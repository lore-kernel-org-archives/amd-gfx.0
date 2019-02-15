From: David Francis <David.Francis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 0/3] Make DRM DSC helpers more generally usable
Date: Fri, 15 Feb 2019 12:01:29 -0500
Message-ID: <20190215170132.11224-1-David.Francis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, nikola.cornij-5C7GfCeVMHo@public.gmane.org, manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, harry.wentland-5C7GfCeVMHo@public.gmane.org, David Francis <David.Francis-5C7GfCeVMHo@public.gmane.org>

ZHJtX2RzYyBjb3VsZCB1c2Ugc29tZSB3b3JrIHNvIHRoYXQgZHJtIGRyaXZlcnMgb3RoZXIgdGhh
bgppOTE1IGNhbiBtYWtlIHVzZSBvZiBpdCB0aGVpciBvd24gRFNDIGltcGxlbWVudGF0aW9ucwoK
TW92ZSByYyBjb21wdXRlLCBhIGZ1bmN0aW9uIHRoYXQgZm9ybXMgcGFydCBvZiB0aGUgRFNDIHNw
ZWMsCmludG8gZHJtLiBVcGRhdGUgaXQgdG8gRFNDIDEuMi4gQWxzbyBzcGxpdCB0aGUgUFBTIHBh
Y2tpbmcgYW5kClNEUCBoZWFkZXIgaW5pdCBmdW5jdGlvbnMsIHRvIGFsbG93IGZvciBkcml2ZXJz
IHdpdGgKdGhlaXIgb3duIFNEUCBzdHJ1Y3QgaGVhZGVycwoKdjI6ClJlYmFzZSBvbnRvIGRybS1u
ZXh0ClJlZmFjdG9yIGRybV9kc2NfZHBfcHBzX2hlYWRlcl9pbml0CkNsZWFuIHVwIGRvY3VtZW50
YXRpb24gb24gbmV3IGRybSBmdW5jdGlvbgoKRGF2aWQgRnJhbmNpcyAoMyk6CiAgZHJtL2k5MTU6
IE1vdmUgZHNjIHJhdGUgcGFyYW1zIGNvbXB1dGUgaW50byBkcm0KICBkcm0vZHNjOiBBZGQgbmF0
aXZlIDQyMCBhbmQgNDIyIHN1cHBvcnQgdG8gY29tcHV0ZV9yY19wYXJhbXMKICBkcm0vZHNjOiBT
cGxpdCBEU0MgUFBTIGFuZCBTRFAgaGVhZGVyIGluaXRpYWxpc2F0aW9ucwoKIGRyaXZlcnMvZ3B1
L2RybS9kcm1fZHNjLmMgICAgICAgICB8IDI2OSArKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0KIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX3Zkc2MuYyB8IDEzMyArLS0tLS0tLS0tLS0t
LS0KIGluY2x1ZGUvZHJtL2RybV9kc2MuaCAgICAgICAgICAgICB8ICAgOSArLQogMyBmaWxlcyBj
aGFuZ2VkLCAyMTkgaW5zZXJ0aW9ucygrKSwgMTkyIGRlbGV0aW9ucygtKQoKLS0gCjIuMTcuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
