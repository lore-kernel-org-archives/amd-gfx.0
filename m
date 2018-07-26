From: Huang Rui <ray.huang@amd.com>
Subject: [PATCH 0/5] drm/ttm: move non-x86 definitions to the common header
Date: Thu, 26 Jul 2018 17:29:14 +0800
Message-ID: <1532597359-18191-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Bas Nieuwenhuizen <basni@chromium.org>, Huang Rui <ray.huang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

SGksCgpBcyBzdWdnZXN0ZWQgYnkgQ2hyaXN0aWFuLCB3ZSBzaG91bGQgbW92ZSBub24teDg2IGRl
ZmluaXRpb25zIGludG8gb25lIGNvbW1vbgpoZWFkZXIsIGFuZCBpdCB3aWxsIG1ha2UgdGhlIGNv
ZGVzIHJlYWRhYmxlLiBUaGV5IGFyZSBiYXNlZCBvbiB0aGUgaW1wcm92ZW1lbnQKZml4IG9mIEJh
cyAoYWxyZWFkeSByZWJhc2UgQmFzJ3MgcGF0Y2ggdG8gZHJtLW5leHQpLgoKVGhhbmtzLApSYXkK
CkJhcyBOaWV1d2VuaHVpemVuICgxKToKICBkcm0vdHRtOiBNZXJnZSBodWdlcGFnZSBhdHRyIGNo
YW5nZXMgaW4gdHRtX2RtYV9wYWdlX3B1dC4KCkh1YW5nIFJ1aSAoNCk6CiAgZHJtL3R0bTogYWRk
IHR0bV9zZXRfbWVtb3J5IGhlYWRlcgogIGRybS90dG06IGNsZWFuIHVwIG5vbi14ODYgZGVmaW5p
dGlvbnMgb24gdHRtX3BhZ2VfYWxsb2NfZG1hCiAgZHJtL3R0bTogY2xlYW4gdXAgbm9uLXg4NiBk
ZWZpbml0aW9ucyBvbiB0dG1fcGFnZV9hbGxvYwogIGRybS90dG06IHVzZSBzZXRfcGFnZXNfd2Ig
aW5zdGVhZCBvZiBzZXRfbWVtb3J5X3diCgogZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcGFnZV9h
bGxvYy5jICAgICB8ICA1NCArLS0tLS0tLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9w
YWdlX2FsbG9jX2RtYS5jIHwgIDUzICsrLS0tLS0tLS0tLS0KIGluY2x1ZGUvZHJtL3R0bS90dG1f
c2V0X21lbW9yeS5oICAgICAgICAgfCAxMjcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KwogMyBmaWxlcyBjaGFuZ2VkLCAxMzMgaW5zZXJ0aW9ucygrKSwgMTAxIGRlbGV0aW9ucygtKQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvZHJtL3R0bS90dG1fc2V0X21lbW9yeS5oCgotLSAK
Mi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRy
aS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
