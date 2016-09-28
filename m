From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/9] drm/amdgpu:add one more fiji device id
Date: Wed, 28 Sep 2016 16:36:13 +0800
Message-ID: <1475051780-21634-2-git-send-email-Monk.Liu@amd.com>
References: <1475051780-21634-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1475051780-21634-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Frank Min <Frank.Min-5C7GfCeVMHo@public.gmane.org>

RnJvbTogRnJhbmsgTWluIDxGcmFuay5NaW5AYW1kLmNvbT4KCkNoYW5nZS1JZDogSTFkOWUxOGM3
NGU2MTRmMzJkOTI0ZTg4ZWUzYjZkYjNiOGJmOTMzYzcKU2lnbmVkLW9mZi1ieTogRnJhbmsgTWlu
IDxGcmFuay5NaW5AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZHJ2LmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQogbW9kZSBjaGFu
Z2UgMTAwNjQ0ID0+IDEwMDc1NSBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2
LmMKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKb2xkIG1vZGUgMTAwNjQ0
Cm5ldyBtb2RlIDEwMDc1NQppbmRleCAzYTZlYTI2Li5kNzMxY2RlCi0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZHJ2LmMKQEAgLTM4NSw2ICszODUsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IHBjaV9kZXZpY2VfaWQgcGNpaWRsaXN0W10gPSB7CiAJezB4MTAwMiwgMHg2OTM5LCBQQ0lfQU5Z
X0lELCBQQ0lfQU5ZX0lELCAwLCAwLCBDSElQX1RPTkdBfSwKIAkvKiBmaWppICovCiAJezB4MTAw
MiwgMHg3MzAwLCBQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAwLCBDSElQX0ZJSkl9LAorCXsw
eDEwMDIsIDB4NzMwRiwgUENJX0FOWV9JRCwgUENJX0FOWV9JRCwgMCwgMCwgQ0hJUF9GSUpJfSwK
IAkvKiBjYXJyaXpvICovCiAJezB4MTAwMiwgMHg5ODcwLCBQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lE
LCAwLCAwLCBDSElQX0NBUlJJWk98QU1EX0lTX0FQVX0sCiAJezB4MTAwMiwgMHg5ODc0LCBQQ0lf
QU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAwLCBDSElQX0NBUlJJWk98QU1EX0lTX0FQVX0sCi0tIAox
LjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
