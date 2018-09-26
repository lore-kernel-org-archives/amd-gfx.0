From: <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 02/16] drm/amd/display: fix 4K stereo screen flash issue
Date: Wed, 26 Sep 2018 13:42:03 -0400
Message-ID: <1537983737-17773-3-git-send-email-sunpeng.li@amd.com>
References: <1537983737-17773-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1537983737-17773-1-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
Cc: Charlene Liu <charlene.liu-5C7GfCeVMHo@public.gmane.org>

RnJvbTogQ2hhcmxlbmUgTGl1IDxjaGFybGVuZS5saXVAYW1kLmNvbT4KCltXaHldCkhETUlfc2Ny
YW1iZXIgaXMgbm90IGVuYWJsZWQgZm9yIHBpeGVsIHJhdGUgPjM0ME1oei4KW0hvd10KQ2FsY3Vs
YXRlIHRoZSBwaHkgY2xvY2sgdG8gaW5jbHVkZSB0aGUgSHcgZnJhbWUgcGFja2luZyBmYWN0b3Iu
CgpTaWduZWQtb2ZmLWJ5OiBDaGFybGVuZSBMaXUgPGNoYXJsZW5lLmxpdUBhbWQuY29tPgpSZXZp
ZXdlZC1ieTogQ2hyaXMgUGFyayA8Q2hyaXMuUGFya0BhbWQuY29tPgpBY2tlZC1ieTogTGVvIExp
IDxzdW5wZW5nLmxpQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2NvcmUvZGNfcmVzb3VyY2UuYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNf
cmVzb3VyY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX3Jlc291
cmNlLmMKaW5kZXggMmQ2YTQzMC4uYTNmZWUzNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfcmVzb3VyY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvY29yZS9kY19yZXNvdXJjZS5jCkBAIC0xOTc1LDYgKzE5NzUsOSBAQCBz
dGF0aWMgdm9pZCBjYWxjdWxhdGVfcGh5X3BpeF9jbGtzKHN0cnVjdCBkY19zdHJlYW1fc3RhdGUg
KnN0cmVhbSkKIAllbHNlCiAJCXN0cmVhbS0+cGh5X3BpeF9jbGsgPQogCQkJc3RyZWFtLT50aW1p
bmcucGl4X2Nsa19raHo7CisKKwlpZiAoc3RyZWFtLT50aW1pbmcudGltaW5nXzNkX2Zvcm1hdCA9
PSBUSU1JTkdfM0RfRk9STUFUX0hXX0ZSQU1FX1BBQ0tJTkcpCisJCXN0cmVhbS0+cGh5X3BpeF9j
bGsgKj0gMjsKIH0KIAogZW51bSBkY19zdGF0dXMgcmVzb3VyY2VfbWFwX3Bvb2xfcmVzb3VyY2Vz
KAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
