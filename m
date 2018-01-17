From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH libdrm 2/3] amdgpu: Disable deadlock test suite by default for
 SI ASICs
Date: Wed, 17 Jan 2018 12:24:44 +0100
Message-ID: <20180117112445.2582-2-michel@daenzer.net>
References: <20180117112445.2582-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180117112445.2582-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpIYW5ncyBteSBD
YXBlIFZlcmRlLgoKU2lnbmVkLW9mZi1ieTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVy
QGFtZC5jb20+Ci0tLQogdGVzdHMvYW1kZ3B1L2RlYWRsb2NrX3Rlc3RzLmMgfCAzICsrLQogMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L3Rlc3RzL2FtZGdwdS9kZWFkbG9ja190ZXN0cy5jIGIvdGVzdHMvYW1kZ3B1L2RlYWRsb2NrX3Rl
c3RzLmMKaW5kZXggY2QzNGNkZjYuLmE1NzZmYjg0IDEwMDY0NAotLS0gYS90ZXN0cy9hbWRncHUv
ZGVhZGxvY2tfdGVzdHMuYworKysgYi90ZXN0cy9hbWRncHUvZGVhZGxvY2tfdGVzdHMuYwpAQCAt
OTYsNyArOTYsOCBAQCBDVV9CT09MIHN1aXRlX2RlYWRsb2NrX3Rlc3RzX2VuYWJsZSh2b2lkKQog
CQkJCQkgICAgICZtaW5vcl92ZXJzaW9uLCAmZGV2aWNlX2hhbmRsZSkpCiAJCXJldHVybiBDVV9G
QUxTRTsKIAotCWlmIChkZXZpY2VfaGFuZGxlLT5pbmZvLmZhbWlseV9pZCA9PSBBTURHUFVfRkFN
SUxZX0FJKSB7CisJaWYgKGRldmljZV9oYW5kbGUtPmluZm8uZmFtaWx5X2lkID09IEFNREdQVV9G
QU1JTFlfQUkgfHwKKwkgICAgZGV2aWNlX2hhbmRsZS0+aW5mby5mYW1pbHlfaWQgPT0gQU1ER1BV
X0ZBTUlMWV9TSSkgewogCQlwcmludGYoIlxuXG5DdXJyZW50bHkgaGFuZ3MgdGhlIENQIG9uIHRo
aXMgQVNJQywgZGVhZGxvY2sgc3VpdGUgZGlzYWJsZWRcbiIpOwogCQllbmFibGUgPSBDVV9GQUxT
RTsKIAl9Ci0tIAoyLjE1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
