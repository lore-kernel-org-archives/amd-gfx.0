From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 09/13] drm/amd/display: Fix indentation in create_eml_sink()
Date: Tue, 17 Oct 2017 12:19:08 -0400
Message-ID: <20171017161912.11357-10-tom.stdenis@amd.com>
References: <20171017161912.11357-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171017161912.11357-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAzICstLQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCmluZGV4IGMy
M2U2YTI4ODY2Ni4uNWUwM2Q5MThiMTlmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKQEAgLTI4MTYsOCArMjgxNiw3IEBAIHN0YXRp
YyB2b2lkIGNyZWF0ZV9lbWxfc2luayhzdHJ1Y3QgYW1kZ3B1X2RtX2Nvbm5lY3RvciAqYWNvbm5l
Y3RvcikKIAkJKGVkaWQtPmV4dGVuc2lvbnMgKyAxKSAqIEVESURfTEVOR1RILAogCQkmaW5pdF9w
YXJhbXMpOwogCi0JaWYgKGFjb25uZWN0b3ItPmJhc2UuZm9yY2UKLQkJCQkJPT0gRFJNX0ZPUkNF
X09OKQorCWlmIChhY29ubmVjdG9yLT5iYXNlLmZvcmNlID09IERSTV9GT1JDRV9PTikKIAkJYWNv
bm5lY3Rvci0+ZGNfc2luayA9IGFjb25uZWN0b3ItPmRjX2xpbmstPmxvY2FsX3NpbmsgPwogCQlh
Y29ubmVjdG9yLT5kY19saW5rLT5sb2NhbF9zaW5rIDoKIAkJYWNvbm5lY3Rvci0+ZGNfZW1fc2lu
azsKLS0gCjIuMTIuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
