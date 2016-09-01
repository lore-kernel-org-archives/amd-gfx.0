From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3] drm/amd/amdgpu: Simplify mask creation in gfx6
Date: Thu,  1 Sep 2016 13:44:46 -0400
Message-ID: <20160901174447.13037-3-tom.stdenis@amd.com>
References: <20160901174447.13037-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160901174447.13037-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92Nl8wLmMgfCA4ICstLS0tLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y2XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92Nl8wLmMKaW5kZXggMDk5NTM5ZjBmYTUzLi41ZjUwOGM5NjQ5NmYgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92Nl8wLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y2XzAuYwpAQCAtOTExLDEzICs5MTEsNyBAQCBzdGF0
aWMgdm9pZCBnZnhfdjZfMF9zZWxlY3Rfc2Vfc2goc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
IHUzMiBzZV9udW0sCiAKIHN0YXRpYyB1MzIgZ2Z4X3Y2XzBfY3JlYXRlX2JpdG1hc2sodTMyIGJp
dF93aWR0aCkKIHsKLQl1MzIgaSwgbWFzayA9IDA7Ci0KLQlmb3IgKGkgPSAwOyBpIDwgYml0X3dp
ZHRoOyBpKyspIHsKLQkJbWFzayA8PD0gMTsKLQkJbWFzayB8PSAxOwotCX0KLQlyZXR1cm4gbWFz
azsKKwlyZXR1cm4gKHUzMikoKCh1NjQpMSA8PCBiaXRfd2lkdGgpIC0gMSk7CiB9CiAKIHN0YXRp
YyB1MzIgZ2Z4X3Y2XzBfZ2V0X3JiX2Rpc2FibGVkKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LAotLSAKMi45LjMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
