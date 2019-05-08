From: "Liu, Leo" <Leo.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/6] drm/amdgpu: add no_user_fence flag to ring funcs
Date: Wed, 8 May 2019 15:51:26 +0000
Message-ID: <20190508155100.7810-1-leo.liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Liu, Leo" <Leo.Liu-5C7GfCeVMHo@public.gmane.org>

U28gd2UgY2FuIGdlbmVyYWxpemUgdGhlIG5vIHVzZXIgZmVuY2Ugc3VwcG9ydGVkIGVuZ2luZQ0K
DQpTaWduZWQtb2ZmLWJ5OiBMZW8gTGl1IDxsZW8ubGl1QGFtZC5jb20+DQotLS0NCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5oIHwgMSArDQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcmluZy5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jpbmcu
aA0KaW5kZXggZDdmYWUyNjc2MjY5Li5jZGRkY2U5MzhiZjUgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5oDQorKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcmluZy5oDQpAQCAtMTE0LDYgKzExNCw3IEBAIHN0cnVjdCBhbWRn
cHVfcmluZ19mdW5jcyB7DQogCXVpbnQzMl90CQlhbGlnbl9tYXNrOw0KIAl1MzIJCQlub3A7DQog
CWJvb2wJCQlzdXBwb3J0XzY0Yml0X3B0cnM7DQorCWJvb2wJCQlub191c2VyX2ZlbmNlOw0KIAl1
bnNpZ25lZAkJdm1odWI7DQogCXVuc2lnbmVkCQlleHRyYV9kdzsNCiANCi0tIA0KMi4xNy4xDQoN
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
