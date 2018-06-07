From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 2/3] drm/amdgpu: Add interrupt SQ source struct to
 amdgpu_gfx struct v2.
Date: Thu, 7 Jun 2018 18:19:14 -0400
Message-ID: <1528409955-6956-2-git-send-email-andrey.grodzovsky@amd.com>
References: <1528409955-6956-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1528409955-6956-1-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
Cc: David Panariti <David.Panariti-5C7GfCeVMHo@public.gmane.org>, nicolai.haehnle-5C7GfCeVMHo@public.gmane.org

RnJvbTogRGF2aWQgUGFuYXJpdGkgPERhdmlkLlBhbmFyaXRpQGFtZC5jb20+CgpTUSBjYW4gZ2Vu
ZXJhdGUgaW50ZXJydXB0cyBvbiBFREMvRUNDIGVycm9ycyBhbmQgdGhpcyBzdHJ1Y3QgY29udHJv
bHMKaG93IHRoZSBpbnRlcnJ1cHQgaXMgaGFuZGxlZC4gIFRoZSBndXRzIGFyZSBmaWxsZWQgaW4g
aW4gdGhlCmdmX3Y8bWFqb3I+XzxtaW5vcj4uYyBmaWxlcy4KCnYyOgpSZWJhc2UuCgpTaWduZWQt
b2ZmLWJ5OiBEYXZpZCBQYW5hcml0aSA8RGF2aWQuUGFuYXJpdGlAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaAppbmRleCA3NmFkNjMy
Li5lOGM2Y2MxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUu
aAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaApAQCAtOTY5LDYgKzk2
OSw3IEBAIHN0cnVjdCBhbWRncHVfZ2Z4IHsKIAlzdHJ1Y3QgYW1kZ3B1X2lycV9zcmMJCXByaXZf
cmVnX2lycTsKIAlzdHJ1Y3QgYW1kZ3B1X2lycV9zcmMJCXByaXZfaW5zdF9pcnE7CiAJc3RydWN0
IGFtZGdwdV9pcnFfc3JjCQljcF9lY2NfZXJyb3JfaXJxOworCXN0cnVjdCBhbWRncHVfaXJxX3Ny
YwkJc3FfaXJxOwogCS8qIGdmeCBzdGF0dXMgKi8KIAl1aW50MzJfdAkJCWdmeF9jdXJyZW50X3N0
YXR1czsKIAkvKiBjZSByYW0gc2l6ZSovCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
