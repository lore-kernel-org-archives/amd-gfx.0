From: Guchun Chen <guchun.chen-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH libdrm 4/4] amdgpu: add ras feature capability check in inject
 test
Date: Thu, 29 Aug 2019 16:59:17 +0800
Message-ID: <20190829085917.20439-5-guchun.chen@amd.com>
References: <20190829085917.20439-1-guchun.chen@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190829085917.20439-1-guchun.chen-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Hawking.Zhang-5C7GfCeVMHo@public.gmane.org, Dennis.Li-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, alexander.deucher-5C7GfCeVMHo@public.gmane.org, Tao.Zhou1-5C7GfCeVMHo@public.gmane.org
Cc: Candice.Li-5C7GfCeVMHo@public.gmane.org, Guchun Chen <guchun.chen-5C7GfCeVMHo@public.gmane.org>

V2hlbiBydW5uaW5nIHJhcyBpbmplY3QgdGVzdCwgaXQncyBuZWVkZWQgdG8gYmUgYWxpZ25lZAp3
aXRoIGtlcm5lbCdzIHJhcyBlbmFibGVtZW50LgoKQ2hhbmdlLUlkOiBJN2U2OWExYTNmNmFiN2Ew
MDUzZjY3ZjdmMWRkM2ZiOWFmNjRmNDc4ZgpTaWduZWQtb2ZmLWJ5OiBHdWNodW4gQ2hlbiA8Z3Vj
aHVuLmNoZW5AYW1kLmNvbT4KLS0tCiB0ZXN0cy9hbWRncHUvcmFzX3Rlc3RzLmMgfCA0ICsrKysK
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90ZXN0cy9hbWRn
cHUvcmFzX3Rlc3RzLmMgYi90ZXN0cy9hbWRncHUvcmFzX3Rlc3RzLmMKaW5kZXggZDUxMGI2NDQu
LmMxYzU0M2MxIDEwMDY0NAotLS0gYS90ZXN0cy9hbWRncHUvcmFzX3Rlc3RzLmMKKysrIGIvdGVz
dHMvYW1kZ3B1L3Jhc190ZXN0cy5jCkBAIC04NjEsNiArODYxLDEwIEBAIHN0YXRpYyB2b2lkIF9f
YW1kZ3B1X3Jhc19pcF9pbmplY3RfdGVzdChjb25zdCBzdHJ1Y3QgcmFzX2luamVjdF90ZXN0X2Nv
bmZpZyAqaXBfCiAJCWlmIChibG9jayA9PSBBUlJBWV9TSVpFKHJhc19ibG9ja19zdHJpbmcpKQog
CQkJYnJlYWs7CiAKKwkJLyogRW5zdXJlIFJBUyBmZWF0dXJlIGZvciB0aGUgSVAgYmxvY2sgaXMg
ZW5hYmxlZCBieSBrZXJuZWwgKi8KKwkJaWYgKGFtZGdwdV9yYXNfaXNfZmVhdHVyZV9zdXBwb3J0
ZWQoYmxvY2spIDw9IDApCisJCQlicmVhazsKKwogCQlyZXQgPSBhbWRncHVfcmFzX3F1ZXJ5X2Vy
cl9jb3VudChibG9jaywgJm9sZF91ZSwgJm9sZF9jZSk7CiAJCUNVX0FTU0VSVF9FUVVBTChyZXQs
IDApOwogCQlpZiAocmV0KQotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZng=
