From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/display: Don't spam debug messages
Date: Mon, 9 Apr 2018 14:06:15 -0400
Message-ID: <20180409180615.15900-1-harry.wentland@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, tstdenis-5C7GfCeVMHo@public.gmane.org, Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org, sunpeng.li-5C7GfCeVMHo@public.gmane.org
Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2luY2x1ZGUvbG9nZ2VyX3R5cGVzLmggfCAy
ICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvaW5jbHVkZS9sb2dnZXJfdHlwZXMu
aCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9pbmNsdWRlL2xvZ2dlcl90eXBlcy5oCmlu
ZGV4IDRmMzMyZTgwY2VjYy4uYjYwOGEwODMwODAxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvaW5jbHVkZS9sb2dnZXJfdHlwZXMuaAorKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvaW5jbHVkZS9sb2dnZXJfdHlwZXMuaApAQCAtMzIsNyArMzIsNyBAQAog
CiAjZGVmaW5lIERDX0xPR19FUlJPUiguLi4pIERSTV9FUlJPUihfX1ZBX0FSR1NfXykKICNkZWZp
bmUgRENfTE9HX1dBUk5JTkcoLi4uKSBEUk1fV0FSTihfX1ZBX0FSR1NfXykKLSNkZWZpbmUgRENf
TE9HX0RFQlVHKC4uLikgRFJNX0lORk8oX19WQV9BUkdTX18pCisjZGVmaW5lIERDX0xPR19ERUJV
RyguLi4pIERSTV9ERUJVR19LTVMoX19WQV9BUkdTX18pCiAjZGVmaW5lIERDX0xPR19EQyguLi4p
IERSTV9ERUJVR19LTVMoX19WQV9BUkdTX18pCiAjZGVmaW5lIERDX0xPR19EVE4oLi4uKSBEUk1f
REVCVUdfS01TKF9fVkFfQVJHU19fKQogI2RlZmluZSBEQ19MT0dfU1VSRkFDRSguLi4pIHByX2Rl
YnVnKCJbU1VSRkFDRV06Il9fVkFfQVJHU19fKQotLSAKMi4xNS4xCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
