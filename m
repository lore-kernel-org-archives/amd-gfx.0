From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 02/13] drm/amdgpu:enable mcbp for gfx9
Date: Fri, 24 Mar 2017 18:38:21 +0800
Message-ID: <1490351912-10122-3-git-send-email-Monk.Liu@amd.com>
References: <1490351912-10122-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490351912-10122-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

c2V0IGJpdCAyMSBvZiBJQi5jb250cm9sIGZpbGVkIHRvIGFjdHVhbGx5IGVuYWJsZQpNQ0JQIGZv
ciBTUklPVgoKQ2hhbmdlLUlkOiBJZTUxMjZkNWJlOTVlMDM3MDg3Y2Y3MTY3YzI4YzYxOTc1ZjQw
ZDc4NApTaWduZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwppbmRl
eCBhZDgyYWI3Li4wZDhmYjUxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjlfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMK
QEAgLTMwMTYsNiArMzAxNiw5IEBAIHN0YXRpYyB2b2lkIGdmeF92OV8wX3JpbmdfZW1pdF9pYl9n
Zngoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAogCiAgICAgICAgIGNvbnRyb2wgfD0gaWItPmxl
bmd0aF9kdyB8ICh2bV9pZCA8PCAyNCk7CiAKKwkJaWYgKGFtZGdwdV9zcmlvdl92ZihyaW5nLT5h
ZGV2KSAmJiAoaWItPmZsYWdzICYgQU1ER1BVX0lCX0ZMQUdfUFJFRU1QVCkpCisJCQljb250cm9s
IHw9ICgxIDw8IDIxKTsKKwogICAgICAgICBhbWRncHVfcmluZ193cml0ZShyaW5nLCBoZWFkZXIp
OwogCUJVR19PTihpYi0+Z3B1X2FkZHIgJiAweDMpOyAvKiBEd29yZCBhbGlnbiAqLwogICAgICAg
ICBhbWRncHVfcmluZ193cml0ZShyaW5nLAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
