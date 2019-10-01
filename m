From: Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH AUTOSEL 5.2 18/63] drm/amdgpu: Fix KFD-related kernel oops on
 Hawaii
Date: Tue,  1 Oct 2019 12:40:40 -0400
Message-ID: <20191001164125.15398-18-sashal@kernel.org>
References: <20191001164125.15398-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191001164125.15398-1-sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

RnJvbTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+CgpbIFVwc3RyZWFt
IGNvbW1pdCBkY2FmYmQ1MGYyZTRkNWNjOTY0YWFlNDA5ZmI1NjkxYjc0M2ZiYTIzIF0KCkhhd2Fp
aSBuZWVkcyB0byBmbHVzaCBjYWNoZXMgZXhwbGljaXRseSwgc3VibWl0dGluZyBhbiBJQiBpbiBh
IHVzZXIKVk1JRCBmcm9tIGtlcm5lbCBtb2RlLiBUaGVyZSBpcyBubyBzX2ZlbmNlIGluIHRoaXMg
Y2FzZS4KCkZpeGVzOiBlYjM5NjFhNTc0MjQgKCJkcm0vYW1kZ3B1OiByZW1vdmUgZmVuY2UgY29u
dGV4dCBmcm9tIHRoZSBqb2IiKQpTaWduZWQtb2ZmLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXgu
S3VlaGxpbmdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtlcm5l
bC5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2liLmMgfCAzICsr
LQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2liLmMKaW5kZXggZmUzOTNhNDZmODgxMS4uNWVlZDI0
MjNkYmI1ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2li
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2liLmMKQEAgLTE0MSw3
ICsxNDEsOCBAQCBpbnQgYW1kZ3B1X2liX3NjaGVkdWxlKHN0cnVjdCBhbWRncHVfcmluZyAqcmlu
ZywgdW5zaWduZWQgbnVtX2licywKIAkvKiByaW5nIHRlc3RzIGRvbid0IHVzZSBhIGpvYiAqLwog
CWlmIChqb2IpIHsKIAkJdm0gPSBqb2ItPnZtOwotCQlmZW5jZV9jdHggPSBqb2ItPmJhc2Uuc19m
ZW5jZS0+c2NoZWR1bGVkLmNvbnRleHQ7CisJCWZlbmNlX2N0eCA9IGpvYi0+YmFzZS5zX2ZlbmNl
ID8KKwkJCWpvYi0+YmFzZS5zX2ZlbmNlLT5zY2hlZHVsZWQuY29udGV4dCA6IDA7CiAJfSBlbHNl
IHsKIAkJdm0gPSBOVUxMOwogCQlmZW5jZV9jdHggPSAwOwotLSAKMi4yMC4xCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
