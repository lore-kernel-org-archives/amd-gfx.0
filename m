From: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/3] drm/amdgpu: add field indicating if has PCIE atomics
 support
Date: Wed, 29 May 2019 06:32:14 +0000
Message-ID: <1559111516-21940-2-git-send-email-Jack.Xiao@amd.com>
References: <1559111516-21940-1-git-send-email-Jack.Xiao@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1559111516-21940-1-git-send-email-Jack.Xiao-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>

VGhlIG5ldyBmaWVsZCBpbiBhbWRncHUgZGV2aWNlIGlzIHVzZWQgdG8gcmVjb3JkIHdoZXRoZXIg
dGhlDQpzeXN0ZW0gaGFzIFBDSUUgYXRvbWljcyBzdXBwb3J0LiBUaGUgZmllbGQgY2FuIGJlIGV4
cG9zZWQgdG8NClVNRCBvciBrZmQgd2hldGhlciBQQ0lFIGF0b21pY3MgaGF2ZSBzdXBwb3J0ZWQu
DQoNClNpZ25lZC1vZmYtYnk6IEphY2sgWGlhbyA8SmFjay5YaWFvQGFtZC5jb20+DQotLS0NCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCB8IDEgKw0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KaW5kZXgg
ZDM1NWU5YS4uYjBhMDFlNCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdS5oDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KQEAg
LTc2Nyw2ICs3NjcsNyBAQCBzdHJ1Y3QgYW1kZ3B1X2RldmljZSB7DQogCXN0cnVjdCBtdXRleCAg
ICAgICAgICAgICAgICAgICAgZ3JibV9pZHhfbXV0ZXg7DQogCXN0cnVjdCBkZXZfcG1fZG9tYWlu
CQl2Z2FfcG1fZG9tYWluOw0KIAlib29sCQkJCWhhdmVfZGlzcF9wb3dlcl9yZWY7DQorCWJvb2wg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaGF2ZV9hdG9taWNzX3N1cHBvcnQ7DQogDQogCS8q
IEJJT1MgKi8NCiAJYm9vbAkJCQlpc19hdG9tX2Z3Ow0KLS0gDQoxLjkuMQ0KDQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
