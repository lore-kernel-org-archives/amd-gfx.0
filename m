From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: How to gracefully handle pci remove
Date: Wed, 29 Aug 2018 10:43:49 -0400
Message-ID: <02a4e04d-6f6d-ea00-5345-abbcc5b86176@amd.com>
References: <3460a3cb-91b9-3f3c-22af-d61b72a53454@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <3460a3cb-91b9-3f3c-22af-d61b72a53454-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: ML dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, daniel-/w4YWyX8dFk@public.gmane.org
Cc: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SnVzdCBhbm90aGVyIHBpbmcuLi4KCkRhbmllbCwgRGF2ZSAtIG1heWJlIHlvdSBjb3VsZCBnaXZl
IHNvbWUgYWR2aXNlIG9uIHRoYXQgPwoKUC5TIEkgdHJpZWQgd2l0aCBJbnRlbCBjYXJkIChpOTE1
KSBkcml2ZXIgb24gNC4xOC4xIGtlcm5lbCB0byBkbyB0aGUgCnNhbWUgdG8gZ2V0IHNvbWUgcmVm
ZXJlbmNlIHBvaW50LCBidXQgaXQganVzdCBoYW5nZWQuCgpBbmRyZXkKCgoKT24gMDgvMjcvMjAx
OCAxMjowNCBQTSwgQW5kcmV5IEdyb2R6b3Zza3kgd3JvdGU6Cj4gSGkgZXZlcnlib2R5ICwgSSBh
bSB0cnlpbmcgdG8gcmVzb2x2ZSB2YXJpb3VzIHByb2JsZW1zIEkgb2JzZXJ2ZSB3aGVuIAo+IGxv
Z2ljYWxseSByZW1vdmluZyBBTURHUFUgZGV2aWNlIGZyb20gcGNpIC0gZWNobyAxID4gCj4gL3N5
cy9jbGFzcy9kcm0vY2FyZDAvZGV2aWNlL3JlbW92ZQo+Cj4gT25lIG9mIHRoZSBwcm9ibGVtcyBJ
IGVuY291bnRlcmVkIHdhcyBoaXR0aW5nIFdBUk5zwqAgaW4gCj4gYW1kZ3B1X2dlbV9mb3JjZV9y
ZWxlYXNlLiBJdCBjb21wbGFpbnRzwqAgYWJvdXQgc3RpbGwgb3BlbiBjbGllbnQgRkRzIAo+IGFu
ZCBCT3MgYWxsb2NhdGlvbnMgd2hpY2ggaXMgb2J2aW91cyBzaW5jZQo+Cj4gd2UgZGlkbid0IGxl
dCB1c2VyIHNwYWNlIGNsaWVudHMga25vdyBhYm91dCB0aGUgZGV2aWNlIHJlbW92YWwgYW5kIAo+
IGhlbmNlIHRoZXkgd29uJ3QgcmVsZWFzZSBhbGxvY2F0aW9ucyBhbmQgd29uJ3QgY2xvc2UgdGhl
aXIgRkRzLgo+Cj4gUXVlc3Rpb24gLSBob3cgb3RoZXIgZHJpdmVycyBoYW5kbGUgdGhpcyB1c2Ug
Y2FzZSwgZXNwZWNpYWxseSBlR1BVcyAKPiBzaW5jZSB0aGV5IGluZGVlZCBtYXkgYmUgZXh0cmFj
dGVkIGluIGFueSBtb21lbnQsIGlzIHRoZXJlIGFueSB3YXkgdG8gCj4gbm90aWZ5IFhvcmcgYW5k
IG90aGVyIGNsaWVudHMgYWJvdXQgdGhpcyBzbyB0aGV5IG1heQo+Cj4gaGF2ZSBhIGNoYW5jZSB0
byByZWxlYXNlIGFsbCB0aGVpciBhbGxvY2F0aW9ucyBhbmQgcHJvYmFibHkgdGVybWluYXRlIAo+
ID8gTWF5YmUgc29tZSBraW5kIG9mIHVldmVudCA/Cj4KPiBBbmRyZXkKPgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
