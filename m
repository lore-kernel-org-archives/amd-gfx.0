From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/5] drm/ttm: move non-x86 definitions to the common header
Date: Thu, 26 Jul 2018 17:14:03 +0800
Message-ID: <1532596448-17831-1-git-send-email-ray.huang@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Bas Nieuwenhuizen <basni-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

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
Mi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
