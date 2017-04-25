From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 07/24] drm/amd/display: set NULL value during removal for
 remoteSink
Date: Tue, 25 Apr 2017 14:38:56 -0400
Message-ID: <20170425183913.16759-8-harry.wentland@amd.com>
References: <20170425183913.16759-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170425183913.16759-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Leon Elazar <leon.elazar-5C7GfCeVMHo@public.gmane.org>

RnJvbTogTGVvbiBFbGF6YXIgPGxlb24uZWxhemFyQGFtZC5jb20+CgpJbiBNU1QgY2FzZSBkdXJp
bmcgcmVtb3ZhbCBvZiByZW1vdGUgc2luayBpdHMgZGVzY3JpcHRvciBwb2ludGVyIHdhc24ndCBm
cmVlZCBjb3JlY3RseS4KCkNoYW5nZS1JZDogSTFmYjIwMWI0NGNmNzlkOTVhMDIyNTNlZmU5MGNm
MDMyMjAwYzI3YzMKU2lnbmVkLW9mZi1ieTogTGVvbiBFbGF6YXIgPGxlb24uZWxhemFyQGFtZC5j
b20+CkFja2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT4KUmV2
aWV3ZWQtYnk6IFRvbnkgQ2hlbmcgPFRvbnkuQ2hlbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9jb3JlL2RjLmMKaW5kZXggMjAzY2I5ZDBjODlkLi43MGRjMDJjZjRkYmIgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYwpAQCAtMTc4Nyw3ICsxNzg3LDcgQEAgdm9p
ZCBkY19saW5rX3JlbW92ZV9yZW1vdGVfc2luayhjb25zdCBzdHJ1Y3QgZGNfbGluayAqbGluaywg
Y29uc3Qgc3RydWN0IGRjX3NpbmsKIAkJCQlkY19saW5rLT5yZW1vdGVfc2lua3NbaV0gPSBkY19s
aW5rLT5yZW1vdGVfc2lua3NbaSsxXTsKIAkJCQlpKys7CiAJCQl9Ci0KKwkJCWRjX2xpbmstPnJl
bW90ZV9zaW5rc1tpXSA9IE5VTEw7CiAJCQlkY19saW5rLT5zaW5rX2NvdW50LS07CiAJCQlyZXR1
cm47CiAJCX0KLS0gCjIuMTEuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
