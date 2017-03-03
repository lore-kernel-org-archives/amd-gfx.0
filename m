From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-amdgpu 4/9] present: Also flush before using a flip
 to unflip
Date: Fri,  3 Mar 2017 18:07:40 +0900
Message-ID: <20170303090745.2254-4-michel@daenzer.net>
References: <20170303090745.2254-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170303090745.2254-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpOb3QgZG9pbmcg
c28gbWlnaHQgcmVzdWx0IGluIGludGVybWl0dGVudGx5IHNjYW5uaW5nIG91dCBzdGFsZSBjb250
ZW50cwpvZiB0aGUgc2NyZWVuIHBpeG1hcC4KCihQb3J0ZWQgZnJvbSByYWRlb24gY29tbWl0IDlh
OTUxYTNlNTUxZGI1OGJhNTBlN2E1OTQ1MjFjZWFjNTRkOTA2MTUpCgpTaWduZWQtb2ZmLWJ5OiBN
aWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KLS0tCiBzcmMvYW1kZ3B1X3By
ZXNlbnQuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0
IGEvc3JjL2FtZGdwdV9wcmVzZW50LmMgYi9zcmMvYW1kZ3B1X3ByZXNlbnQuYwppbmRleCBjZjZl
MzZiMmYuLjQwNDhmOTg0NCAxMDA2NDQKLS0tIGEvc3JjL2FtZGdwdV9wcmVzZW50LmMKKysrIGIv
c3JjL2FtZGdwdV9wcmVzZW50LmMKQEAgLTM2Niw2ICszNjYsNyBAQCBhbWRncHVfcHJlc2VudF91
bmZsaXAoU2NyZWVuUHRyIHNjcmVlbiwgdWludDY0X3QgZXZlbnRfaWQpCiAJZXZlbnQtPmV2ZW50
X2lkID0gZXZlbnRfaWQ7CiAJZXZlbnQtPnVuZmxpcCA9IFRSVUU7CiAKKwlhbWRncHVfZ2xhbW9y
X2ZsdXNoKHNjcm4pOwogCWlmIChhbWRncHVfZG9fcGFnZWZsaXAoc2NybiwgQU1ER1BVX0RSTV9R
VUVVRV9DTElFTlRfREVGQVVMVCwgcGl4bWFwLAogCQkJICAgICAgIGV2ZW50X2lkLCBldmVudCwg
LTEsIGFtZGdwdV9wcmVzZW50X2ZsaXBfZXZlbnQsCiAJCQkgICAgICAgYW1kZ3B1X3ByZXNlbnRf
ZmxpcF9hYm9ydCwgRkxJUF9WU1lOQywgMCkpCi0tIAoyLjExLjAKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
