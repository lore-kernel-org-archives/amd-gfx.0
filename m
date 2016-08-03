From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/6] drm/amd/amdgpu:  Move VCE bypass after MGCG test
Date: Wed,  3 Aug 2016 11:51:40 -0400
Message-ID: <20160803155142.27161-5-tom.stdenis@amd.com>
References: <20160803155142.27161-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160803155142.27161-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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

T25seSBpc3N1ZSBieXBhc3MgaWYgTUdDRyBlbmFibGVkCgpTaWduZWQtb2ZmLWJ5OiBUb20gU3Qg
RGVuaXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdmNlX3YzXzAuYyB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3ZjZV92M18wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjNfMC5jCmluZGV4
IDlkMTkyNGU0ZTJiYy4uNjNjOWVmZWZhNTgzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS92Y2VfdjNfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zj
ZV92M18wLmMKQEAgLTc2OSwxMiArNzY5LDEyIEBAIHN0YXRpYyBpbnQgdmNlX3YzXzBfc2V0X2Ns
b2NrZ2F0aW5nX3N0YXRlKHZvaWQgKmhhbmRsZSwKIAlib29sIGVuYWJsZSA9IChzdGF0ZSA9PSBB
TURfQ0dfU1RBVEVfR0FURSkgPyB0cnVlIDogZmFsc2U7CiAJaW50IGk7CiAKLQlpZiAoYWRldi0+
YXNpY190eXBlID09IENISVBfUE9MQVJJUzEwKQotCQl2Y2VfdjNfc2V0X2J5cGFzc19tb2RlKGFk
ZXYsIGVuYWJsZSk7Ci0KIAlpZiAoIShhZGV2LT5jZ19mbGFncyAmIEFNRF9DR19TVVBQT1JUX1ZD
RV9NR0NHKSkKIAkJcmV0dXJuIDA7CiAKKwlpZiAoYWRldi0+YXNpY190eXBlID09IENISVBfUE9M
QVJJUzEwKQorCQl2Y2VfdjNfc2V0X2J5cGFzc19tb2RlKGFkZXYsIGVuYWJsZSk7CisKIAltdXRl
eF9sb2NrKCZhZGV2LT5ncmJtX2lkeF9tdXRleCk7CiAJZm9yIChpID0gMDsgaSA8IDI7IGkrKykg
ewogCQkvKiBQcm9ncmFtIFZDRSBJbnN0YW5jZSAwIG9yIDEgaWYgbm90IGhhcnZlc3RlZCAqLwot
LSAKMi45LjIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
