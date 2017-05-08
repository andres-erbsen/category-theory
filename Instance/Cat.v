Set Warnings "-notation-overridden".

Require Import Category.Lib.
Require Export Category.Theory.Functor.
Require Export Category.Functor.Id.
Require Export Category.Functor.Compose.
Require Export Category.Instance.Nat.

Generalizable All Variables.
Set Primitive Projections.
Set Universe Polymorphism.
Unset Transparent Obligations.
Set Implicit Arguments.

Ltac constructive :=
  isomorphism; simpl; intros;
  [ natural; simpl; intros
  | natural; simpl; intros
  | .. ]; simpl; intros.

(* Cat is the category of all small categories:

    objects               Categories
    arrows                Functors
    arrow equivalence     Natural Isomorphisms
    identity              Identity Functor
    composition           Horizontal composition of Functors *)

Program Instance Cat : Category := {
  ob      := Category;
  hom     := @Functor;
  homset  := fun _ _ => {| equiv := fun F G => F ≅[Nat] G |};
  id      := @Id;
  compose := @Compose
}.
Next Obligation. equivalence; transitivity y; auto. Qed.
Next Obligation.
  proper.
  constructive.
  all:swap 2 3.
  - apply (transform[to X0] (y0 X2) ∘ fmap (transform[to X1] X2)).
  - apply (transform[from X0] (x0 X2) ∘ fmap (transform[from X1] X2)).
  - rewrite <- !comp_assoc.
    rewrite <- fmap_comp.
    rewrite <- !natural_transformation.
    rewrite !fmap_comp.
    rewrite comp_assoc.
    reflexivity.
  - rewrite <- !comp_assoc.
    rewrite <- fmap_comp.
    rewrite <- !natural_transformation.
    rewrite !fmap_comp.
    rewrite comp_assoc.
    reflexivity.
  - destruct X0 as [to0 from0 iso_to_from0 ?];
    destruct X1 as [to1 from1 iso_to_from1 ?]; simpl in *.
    rewrite <- natural_transformation.
    rewrite <- !comp_assoc.
    rewrite (comp_assoc (transform[to0] _)).
    rewrite iso_to_from0; cat.
    rewrite <- fmap_comp.
    rewrite iso_to_from1; cat.
  - destruct X0 as [to0 from0 ? iso_from_to0 ?];
    destruct X1 as [to1 from1 ? iso_from_to1 ?]; simpl in *.
    rewrite <- natural_transformation.
    rewrite <- !comp_assoc.
    rewrite (comp_assoc (transform[from0] _)).
    rewrite iso_from_to0; cat.
    rewrite <- fmap_comp.
    rewrite iso_from_to1; cat.
Qed.
Next Obligation. constructive; cat. Qed.
Next Obligation. constructive; cat. Qed.
Next Obligation. constructive; cat. Qed.
Next Obligation. constructive; cat. Qed.
