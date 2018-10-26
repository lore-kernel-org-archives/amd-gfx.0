From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/v3d: Fix compilation error on kbuilt test robot.
Date: Fri, 26 Oct 2018 10:53:09 -0400
Message-ID: <CADnq5_Mcv1_uUkzWC-2czKBq3Yq_JOSRAOgi4jPNG8RrJoNqpQ@mail.gmail.com>
References: <1540564994-20109-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1540564994-20109-1-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
To: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gRnJpLCBPY3QgMjYsIDIwMTggYXQgMTA6NDMgQU0gQW5kcmV5IEdyb2R6b3Zza3kKPGFuZHJl
eS5ncm9kem92c2t5QGFtZC5jb20+IHdyb3RlOgo+Cj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IEdy
b2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+ClJldmlld2VkLWJ5OiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9k
cm0vdjNkL3YzZF9zY2hlZC5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdjNkL3Yz
ZF9zY2hlZC5jIGIvZHJpdmVycy9ncHUvZHJtL3YzZC92M2Rfc2NoZWQuYwo+IGluZGV4IDI3M2Qw
ZmIuLjgwYjY0MWYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3YzZC92M2Rfc2NoZWQu
Ywo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS92M2QvdjNkX3NjaGVkLmMKPiBAQCAtMjIyLDcgKzIy
Miw3IEBAIHYzZF9zY2hlZF9pbml0KHN0cnVjdCB2M2RfZGV2ICp2M2QpCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAmdjNkX3NjaGVkX29wcywKPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGh3X2pvYnNfbGltaXQsIGpvYl9oYW5nX2xpbWl0LAo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcyhoYW5nX2xpbWl0X21zKSwKPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICJ2M2RfcmVuZGVyIiwgdHJ1ZSk7Cj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAidjNkX3JlbmRlciIpOwo+ICAgICAgICAgaWYgKHJldCkgewo+ICAgICAg
ICAgICAgICAgICBkZXZfZXJyKHYzZC0+ZGV2LCAiRmFpbGVkIHRvIGNyZWF0ZSByZW5kZXIgc2No
ZWR1bGVyOiAlZC4iLAo+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldCk7Cj4gLS0KPiAyLjcu
NAo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBk
cmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4gZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
