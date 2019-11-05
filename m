From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: fix sysfs interface pcie_replay_count error on
 navi asic
Date: Tue, 5 Nov 2019 11:02:13 +0000
Message-ID: <20191105110200.29855-1-kevin1.wang@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Yuan,
 Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>, "Li,
 Candice" <Candice.Li-5C7GfCeVMHo@public.gmane.org>, "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

dGhlIGFzaWMgY2FsbGJhY2sgZnVuY3Rpb24gb2YgZ2V0X3BjaWVfcmVwbGF5X2NvdW50IGlzIG5v
dCBpbXBsZW1lbnQgb24gbmF2aSBhc2ljLAppdCB3aWxsIGNhdXNlIG51bGwgcGludGVyIGVycm9y
IHdoZW4gcmVhZCB0aGlzIGludGVyZmFjZS4KClNpZ25lZC1vZmYtYnk6IEtldmluIFdhbmcgPGtl
dmluMS53YW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYyB8
IDExICsrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9udi5jCmluZGV4IGE1NWEyZTgzZmIxOS4uYWY2OGY5ODE1ZjI4IDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L252LmMKQEAgLTUzOSw2ICs1MzksMTYgQEAgc3RhdGljIGJvb2wgbnZfbmVl
ZF9yZXNldF9vbl9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCXJldHVybiBmYWxz
ZTsKIH0KIAorc3RhdGljIHVpbnQ2NF90IG52X2dldF9wY2llX3JlcGxheV9jb3VudChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikKK3sKKworCS8qIFRPRE8KKwkgKiBkdW1teSBpbXBsZW1lbnQg
Zm9yIHBjaWVfcmVwbGF5X2NvdW50IHN5c2ZzIGludGVyZmFjZQorCSAqICovCisKKwlyZXR1cm4g
MDsKK30KKwogc3RhdGljIHZvaWQgbnZfaW5pdF9kb29yYmVsbF9pbmRleChzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldikKIHsKIAlhZGV2LT5kb29yYmVsbF9pbmRleC5raXEgPSBBTURHUFVfTkFW
STEwX0RPT1JCRUxMX0tJUTsKQEAgLTU4Niw2ICs1OTYsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IGFtZGdwdV9hc2ljX2Z1bmNzIG52X2FzaWNfZnVuY3MgPQogCS5uZWVkX2Z1bGxfcmVzZXQgPSAm
bnZfbmVlZF9mdWxsX3Jlc2V0LAogCS5nZXRfcGNpZV91c2FnZSA9ICZudl9nZXRfcGNpZV91c2Fn
ZSwKIAkubmVlZF9yZXNldF9vbl9pbml0ID0gJm52X25lZWRfcmVzZXRfb25faW5pdCwKKwkuZ2V0
X3BjaWVfcmVwbGF5X2NvdW50ID0gJm52X2dldF9wY2llX3JlcGxheV9jb3VudCwKIH07CiAKIHN0
YXRpYyBpbnQgbnZfY29tbW9uX2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQotLSAKMi4xNy4xCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
