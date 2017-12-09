From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 35/37] drm/amdkfd: Add dGPU support to kernel_queue_init
Date: Fri,  8 Dec 2017 23:11:16 -0500
Message-ID: <1512792678-26211-6-git-send-email-Felix.Kuehling@amd.com>
References: <1512792678-26211-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1512792678-26211-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>

UmVjb2duaXplIGRHUFUgQVNJQyBmYW1pbGllcy4KClNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhs
aW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9rZXJuZWxfcXVldWUuYyB8IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfa2Vy
bmVsX3F1ZXVlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfa2VybmVsX3F1ZXVl
LmMKaW5kZXggNWRjNjU2Ny4uNjlmNDk2NCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2tlcm5lbF9xdWV1ZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9rZXJuZWxfcXVldWUuYwpAQCAtMjk3LDEwICsyOTcsMTUgQEAgc3RydWN0IGtlcm5l
bF9xdWV1ZSAqa2VybmVsX3F1ZXVlX2luaXQoc3RydWN0IGtmZF9kZXYgKmRldiwKIAogCXN3aXRj
aCAoZGV2LT5kZXZpY2VfaW5mby0+YXNpY19mYW1pbHkpIHsKIAljYXNlIENISVBfQ0FSUklaTzoK
KwljYXNlIENISVBfVE9OR0E6CisJY2FzZSBDSElQX0ZJSkk6CisJY2FzZSBDSElQX1BPTEFSSVMx
MDoKKwljYXNlIENISVBfUE9MQVJJUzExOgogCQlrZXJuZWxfcXVldWVfaW5pdF92aSgma3EtPm9w
c19hc2ljX3NwZWNpZmljKTsKIAkJYnJlYWs7CiAKIAljYXNlIENISVBfS0FWRVJJOgorCWNhc2Ug
Q0hJUF9IQVdBSUk6CiAJCWtlcm5lbF9xdWV1ZV9pbml0X2Npaygma3EtPm9wc19hc2ljX3NwZWNp
ZmljKTsKIAkJYnJlYWs7CiAJZGVmYXVsdDoKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
