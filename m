From: <Ken.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: correct reference clock value on vega10
Date: Wed, 11 Oct 2017 16:44:24 +0800
Message-ID: <1507711464-9310-1-git-send-email-Ken.Wang@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Ken Wang <Ken.Wang-5C7GfCeVMHo@public.gmane.org>

RnJvbTogS2VuIFdhbmcgPEtlbi5XYW5nQGFtZC5jb20+CgpDaGFuZ2UtSWQ6IEkzNzcwMjkwNzVh
ZjFlMmUwMDJmN2NmZDc5M2RkZDU4ZDg2MTBlNDc0ClNpZ25lZC1vZmYtYnk6IEtlbiBXYW5nIDxL
ZW4uV2FuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMg
fCA2ICsrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYwppbmRleCA3ODM5Njc3Li5hNTEwYzhjIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMKQEAgLTI3OSwxMCArMjc5LDggQEAgc3RhdGlj
IHZvaWQgc29jMTVfaW5pdF9nb2xkZW5fcmVnaXN0ZXJzKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQogfQogc3RhdGljIHUzMiBzb2MxNV9nZXRfeGNsayhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKIHsKLQlpZiAoYWRldi0+YXNpY190eXBlID09IENISVBfVkVHQTEwKQotCQlyZXR1cm4g
YWRldi0+Y2xvY2suc3BsbC5yZWZlcmVuY2VfZnJlcS80OwotCWVsc2UKLQkJcmV0dXJuIGFkZXYt
PmNsb2NrLnNwbGwucmVmZXJlbmNlX2ZyZXE7CisJLyogcmV0dXJuIHRoZSB2YWx1ZSBpbiBLaHog
aW5zdGVhZCBvZiAxMEtoeiovCisJcmV0dXJuIGFkZXYtPmNsb2NrLnNwbGwucmVmZXJlbmNlX2Zy
ZXEgKiAxMDsKIH0KIAogCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
