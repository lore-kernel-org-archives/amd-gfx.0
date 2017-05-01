From: Shaoyun Liu <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Reserve 0-2 invalidation reg sets for none-amdgpu
 usages
Date: Mon, 1 May 2017 11:27:53 -0400
Message-ID: <1493652473-6799-1-git-send-email-Shaoyun.Liu@amd.com>
References: <n>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <n>
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
Cc: Shaoyun Liu <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>

RmlybXdhcmUgdXNlZCByZWcgc2V0IDIgZm9yIHRsYiBpbnZhbGlkYXRpb24uIEFNREdQVSBjYW4g
c3RhcnQgZnJvbSByZWcKc2V0IDMgdG8gYXZvaWQgdGhlIGNvbmZsaWN0LiBBTURLRkQgd2lsbCB1
c2UgdGhlIHJlZyBzZXQgMCBvciAxIHdoZW4KbmVjZXNhcnkuCgpDaGFuZ2UtSWQ6IEk3MWM1OTU3
MDFmNDcxMTBkZjAyNDJkNjkyNjYwN2M5NGJkNTY0NGViClNpZ25lZC1vZmYtYnk6IFNoYW95dW4g
TGl1IDxTaGFveXVuLkxpdUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dtY192OV8wLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlf
MC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwppbmRleCBlNWQ0ZGZl
Li5kYzFlMWMxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlf
MC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKQEAgLTM4Niw3
ICszODYsNyBAQCBzdGF0aWMgaW50IGdtY192OV8wX2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQog
c3RhdGljIGludCBnbWNfdjlfMF9sYXRlX2luaXQodm9pZCAqaGFuZGxlKQogewogCXN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOwotCXVu
c2lnbmVkIHZtX2ludl9lbmdbQU1ER1BVX01BWF9WTUhVQlNdID0geyAwIH07CisJdW5zaWduZWQg
dm1faW52X2VuZ1tBTURHUFVfTUFYX1ZNSFVCU10gPSB7IDMsIDMgfTsKIAl1bnNpZ25lZCBpOwog
CiAJZm9yKGkgPSAwOyBpIDwgYWRldi0+bnVtX3JpbmdzOyArK2kpIHsKLS0gCjEuOS4xCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
