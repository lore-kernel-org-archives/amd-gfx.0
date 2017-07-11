From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] drm/amdgpu/gfx: keep all compute queues on the same pipe
Date: Tue, 11 Jul 2017 11:13:12 -0400
Message-ID: <1499785992-14693-1-git-send-email-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Jim Qu <jim.qu-5C7GfCeVMHo@public.gmane.org>

U3ByZWFkaW5nIHRoZW0gY2F1c2VzIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb25zIHVzaW5nIGNvbXB1
dGUKcXVldWVzLgoKQ2M6IEppbSBRdSA8amltLnF1QGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9nZnguYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9nZnguYwppbmRleCBlMjYxMDhhLi40ZjZjNjhmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2dmeC5jCkBAIC0xMjUsNyArMTI1LDggQEAgdm9pZCBhbWRncHVfZ2Z4X2NvbXB1
dGVfcXVldWVfYWNxdWlyZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAkJaWYgKG1lYyA+
PSBhZGV2LT5nZngubWVjLm51bV9tZWMpCiAJCQlicmVhazsKIAotCQlpZiAoYWRldi0+Z2Z4Lm1l
Yy5udW1fbWVjID4gMSkgeworCQkvKiBGSVhNRTogc3ByZWFkaW5nIHRoZSBxdWV1ZXMgYWNyb3Nz
IHBpcGVzIGNhdXNlcyBwZXJmIHJlZ3Jlc3Npb25zICovCisJCWlmICgwKSB7CiAJCQkvKiBwb2xp
Y3k6IGFtZGdwdSBvd25zIHRoZSBmaXJzdCB0d28gcXVldWVzIG9mIHRoZSBmaXJzdCBNRUMgKi8K
IAkJCWlmIChtZWMgPT0gMCAmJiBxdWV1ZSA8IDIpCiAJCQkJc2V0X2JpdChpLCBhZGV2LT5nZngu
bWVjLnF1ZXVlX2JpdG1hcCk7Ci0tIAoyLjUuNQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
