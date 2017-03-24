From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH umr] Add new AI CG bits to umr_print_config()
Date: Fri, 24 Mar 2017 09:48:55 -0400
Message-ID: <20170324134855.2587-1-tom.stdenis@amd.com>
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
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgotLS0KIHNy
Yy9hcHAvcHJpbnRfY29uZmlnLmMgfCA2ICsrKysrKwogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL3NyYy9hcHAvcHJpbnRfY29uZmlnLmMgYi9zcmMvYXBwL3By
aW50X2NvbmZpZy5jCmluZGV4IDZhNGJmNWRkNTk0YS4uNmRiZTBkNDJiOGRjIDEwMDY0NAotLS0g
YS9zcmMvYXBwL3ByaW50X2NvbmZpZy5jCisrKyBiL3NyYy9hcHAvcHJpbnRfY29uZmlnLmMKQEAg
LTU0LDYgKzU0LDEyIEBAIE0oQU1EX0NHX1NVUFBPUlRfVkNFX01HQ0csIDFVTCA8PCAxNCkKIE0o
QU1EX0NHX1NVUFBPUlRfSERQX0xTLCAxVUwgPDwgMTUpCiBNKEFNRF9DR19TVVBQT1JUX0hEUF9N
R0NHLCAxVUwgPDwgMTYpCiBNKEFNRF9DR19TVVBQT1JUX1JPTV9NR0NHLCAxVUwgPDwgMTcpCitN
KEFNRF9DR19TVVBQT1JUX0RSTV9MUywgMVVMIDw8IDE4KQorTShBTURfQ0dfU1VQUE9SVF9CSUZf
TUdDRywgMVVMIDw8IDE5KQorTShBTURfQ0dfU1VQUE9SVF9HRlhfM0RfQ0dDRywgMVVMIDw8IDIw
KQorTShBTURfQ0dfU1VQUE9SVF9HRlhfM0RfQ0dMUywgMVVMIDw8IDIxKQorTShBTURfQ0dfU1VQ
UE9SVF9EUk1fTUdDRywgMVVMIDw8IDIyKQorTShBTURfQ0dfU1VQUE9SVF9ERl9NR0NHLCAxVUwg
PDwgMjMpCiB7IE5VTEwsIDAsIH0sCiB9OwogCi0tIAoyLjEyLjAKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
