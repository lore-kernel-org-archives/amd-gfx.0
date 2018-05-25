From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 04/34] drm/amd/display: Do not program interrupt status on
 disabled crtc
Date: Fri, 25 May 2018 12:02:03 -0400
Message-ID: <20180525160233.21168-5-harry.wentland@amd.com>
References: <20180525160233.21168-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180525160233.21168-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Mikita Lipski <mikita.lipski-5C7GfCeVMHo@public.gmane.org>

RnJvbTogTWlraXRhIExpcHNraSA8bWlraXRhLmxpcHNraUBhbWQuY29tPgoKUHJldmVudCBpbnRl
cnJ1cHQgcHJvZ3JhbW1pbmcgb2YgYSBjcnRjIG9uIHdoaWNoIHRoZSBzdHJlYW0gaXMgZGlzYWJs
ZWQgYW5kCml0IGRvZXNuJ3QgaGF2ZSBhbiBPVEcgdG8gcmVmZXJlbmNlLgoKU2lnbmVkLW9mZi1i
eTogTWlraXRhIExpcHNraSA8bWlraXRhLmxpcHNraUBhbWQuY29tPgpSZXZpZXdlZC1ieTogSGFy
cnkgV2VudGxhbmQgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1faXJxLmMgfCAzICsrKwogMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2lycS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1faXJxLmMKaW5kZXggNGJlMjFiZjU0NzQ5Li5hOTEw
ZjAxODM4YWIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVf
ZG0vYW1kZ3B1X2RtX2lycS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtX2lycS5jCkBAIC01NTUsNiArNTU1LDkgQEAgc3RhdGljIGlubGluZSBp
bnQgZG1faXJxX3N0YXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQlyZXR1cm4gMDsK
IAl9CiAKKwlpZiAoYWNydGMtPm90Z19pbnN0ID09IC0xKQorCQlyZXR1cm4gMDsKKwogCWlycV9z
b3VyY2UgPSBkYWxfaXJxX3R5cGUgKyBhY3J0Yy0+b3RnX2luc3Q7CiAKIAlzdCA9IChzdGF0ZSA9
PSBBTURHUFVfSVJRX1NUQVRFX0VOQUJMRSk7Ci0tIAoyLjE3LjAKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
