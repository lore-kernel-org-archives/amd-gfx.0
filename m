From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 20/25] drm/amd/display: Fix missing conditions in hw sequencer.
Date: Mon, 23 Jan 2017 09:36:08 -0500
Message-ID: <20170123143613.15441-21-harry.wentland@amd.com>
References: <20170123143613.15441-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170123143613.15441-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Zeyu Fan <Zeyu.Fan-5C7GfCeVMHo@public.gmane.org>

RnJvbTogWmV5dSBGYW4gPFpleXUuRmFuQGFtZC5jb20+CgpDaGFuZ2UtSWQ6IEk2MjFjMjM1NjMx
OTIyOWM1ZTQ1NWQyZmQ2Y2NiZWRjNGE3NDA3N2FlClNpZ25lZC1vZmYtYnk6IFpleXUgRmFuIDxa
ZXl1LkZhbkBhbWQuY29tPgpBY2tlZC1ieTogSGFycnkgV2VudGxhbmQgPEhhcnJ5LldlbnRsYW5k
QGFtZC5jb20+ClJldmlld2VkLWJ5OiBUb255IENoZW5nIDxUb255LkNoZW5nQGFtZC5jb20+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfaHdzZXEuYyB8IDIgKy0K
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX2h3c2VxLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9od3NlcS5jCmluZGV4IGNkOWEzNzFh
ZTIzNy4uMGVlZTEzNWJmYTU0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvZGNlL2RjZV9od3NlcS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kY2UvZGNlX2h3c2VxLmMKQEAgLTE2MCw3ICsxNjAsNyBAQCB2b2lkIGRjZV9jcnRjX3N3aXRj
aF90b19jbGtfc3JjKHN0cnVjdCBkY2VfaHdzZXEgKmh3cywKIAkJc3RydWN0IGNsb2NrX3NvdXJj
ZSAqY2xrX3NyYywKIAkJdW5zaWduZWQgaW50IHRnX2luc3QpCiB7Ci0JaWYgKGNsa19zcmMtPmlk
ID09IENMT0NLX1NPVVJDRV9JRF9EUF9EVE8pIHsKKwlpZiAoY2xrX3NyYy0+aWQgPT0gQ0xPQ0tf
U09VUkNFX0lEX0RQX0RUTyB8fCBjbGtfc3JjLT5kcF9jbGtfc3JjKSB7CiAJCVJFR19VUERBVEUo
UElYRUxfUkFURV9DTlRMW3RnX2luc3RdLAogCQkJCURQX0RUTzBfRU5BQkxFLCAxKTsKIAotLSAK
Mi45LjMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
