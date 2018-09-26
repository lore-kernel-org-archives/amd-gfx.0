From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 12/12] drm/amdgpu: disable IH ring 2 WPTR overflow on Vega10
Date: Wed, 26 Sep 2018 15:53:30 +0200
Message-ID: <20180926135330.2218-12-christian.koenig@amd.com>
References: <20180926135330.2218-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180926135330.2218-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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

VGhhdCBzaG91bGQgYWRkIGJhY2sgcHJlc3N1cmUgb24gdGhlIGNsaWVudC4KClNpZ25lZC1vZmYt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMTBfaWguYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS92ZWdhMTBfaWguYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2ExMF9paC5jCmlu
ZGV4IGRkMTU1YTIwN2ZkZC4uYzg1MjVjMjlmYzE2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS92ZWdhMTBfaWguYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS92ZWdhMTBfaWguYwpAQCAtMjA3LDYgKzIwNyw4IEBAIHN0YXRpYyBpbnQgdmVnYTEwX2loX2ly
cV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCiAJaWhfcmJfY250bCA9IFJSRUcz
Ml9TT0MxNShPU1NTWVMsIDAsIG1tSUhfUkJfQ05UTF9SSU5HMSk7CiAJaWhfcmJfY250bCA9IHZl
Z2ExMF9paF9yYl9jbnRsKGloLCBpaF9yYl9jbnRsKTsKKwlpaF9yYl9jbnRsID0gUkVHX1NFVF9G
SUVMRChpaF9yYl9jbnRsLCBJSF9SQl9DTlRMX1JJTkcyLAorCQkJCSAgIFdQVFJfT1ZFUkZMT1df
RU5BQkxFLCAwKTsKIAlXUkVHMzJfU09DMTUoT1NTU1lTLCAwLCBtbUlIX1JCX0NOVExfUklORzIs
IGloX3JiX2NudGwpOwogCiAJLyogc2V0IHJwdHIsIHdwdHIgdG8gMCAqLwotLSAKMi4xNC4xCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
