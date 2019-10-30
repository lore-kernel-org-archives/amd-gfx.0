From: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/powerplay: print the pptable provider
Date: Wed, 30 Oct 2019 08:19:14 +0000
Message-ID: <20191030081858.2807-1-xiaojie.yuan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>, "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, "Yuan,
 Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogWGlhb2ppZSBZdWFuIDx4aWFvamllLnl1YW5AYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYyB8IDIgKysKIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9zbXVfdjExXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3Nt
dV92MTFfMC5jCmluZGV4IDdlODgyOTk5YWJhZC4uMGY3NTA0YWUyMzk1IDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYwpAQCAtMzY4LDYgKzM2OCw3IEBAIGludCBz
bXVfdjExXzBfc2V0dXBfcHB0YWJsZShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkKIAl2ZXJzaW9u
X21ham9yID0gbGUxNl90b19jcHUoaGRyLT5oZWFkZXIuaGVhZGVyX3ZlcnNpb25fbWFqb3IpOwog
CXZlcnNpb25fbWlub3IgPSBsZTE2X3RvX2NwdShoZHItPmhlYWRlci5oZWFkZXJfdmVyc2lvbl9t
aW5vcik7CiAJaWYgKHZlcnNpb25fbWFqb3IgPT0gMiAmJiBzbXUtPnNtdV90YWJsZS5ib290X3Zh
bHVlcy5wcF90YWJsZV9pZCA+IDApIHsKKwkJcHJfaW5mbygidXNlIGRyaXZlciBwcm92aWRlZCBw
cHRhYmxlICVkXG4iLCBzbXUtPnNtdV90YWJsZS5ib290X3ZhbHVlcy5wcF90YWJsZV9pZCk7CiAJ
CXN3aXRjaCAodmVyc2lvbl9taW5vcikgewogCQljYXNlIDA6CiAJCQlyZXQgPSBzbXVfdjExXzBf
c2V0X3BwdGFibGVfdjJfMChzbXUsICZ0YWJsZSwgJnNpemUpOwpAQCAtMzg0LDYgKzM4NSw3IEBA
IGludCBzbXVfdjExXzBfc2V0dXBfcHB0YWJsZShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkKIAkJ
CXJldHVybiByZXQ7CiAKIAl9IGVsc2UgeworCQlwcl9pbmZvKCJ1c2UgdmJpb3MgcHJvdmlkZWQg
cHB0YWJsZVxuIik7CiAJCWluZGV4ID0gZ2V0X2luZGV4X2ludG9fbWFzdGVyX3RhYmxlKGF0b21f
bWFzdGVyX2xpc3Rfb2ZfZGF0YV90YWJsZXNfdjJfMSwKIAkJCQkJCSAgICBwb3dlcnBsYXlpbmZv
KTsKIAotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
