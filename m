From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 0/4] drm/ttm: move non-x86 definitions to the common header
Date: Thu, 26 Jul 2018 19:52:09 +0800
Message-ID: <1532605933-26209-1-git-send-email-ray.huang@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Bas Nieuwenhuizen <basni-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

SGksCgpBcyBzdWdnZXN0ZWQgYnkgQ2hyaXN0aWFuLCB3ZSBzaG91bGQgbW92ZSBub24teDg2IGRl
ZmluaXRpb25zIGludG8gb25lIGNvbW1vbgpoZWFkZXIsIGFuZCBpdCB3aWxsIG1ha2UgdGhlIGNv
ZGVzIHJlYWRhYmxlLiBUaGV5IGFyZSBiYXNlZCBvbiB0aGUgaW1wcm92ZW1lbnQKZml4IG9mIEJh
cyAoYWxyZWFkeSByZWJhc2UgQmFzJ3MgcGF0Y2ggdG8gZHJtLW5leHQpLgoKQ2hhbmdlcyBmcm9t
IFYxIC0+IFYyOgotIGFkZCB0dG1fIHByZWZpeCBhdCB0aGlzIGhlYWRlci4KLSB1c2Ugc2V0X3Bh
Z2VzX3diIGluc3RlYWQgb2Ygc2V0X21lbW9yeV93Yi4KClRoYW5rcywKUmF5CgpCYXMgTmlldXdl
bmh1aXplbiAoMSk6CiAgZHJtL3R0bTogTWVyZ2UgaHVnZXBhZ2UgYXR0ciBjaGFuZ2VzIGluIHR0
bV9kbWFfcGFnZV9wdXQuICh2MikKCkh1YW5nIFJ1aSAoMyk6CiAgZHJtL3R0bTogYWRkIHR0bV9z
ZXRfbWVtb3J5IGhlYWRlciAodjIpCiAgZHJtL3R0bTogY2xlYW4gdXAgbm9uLXg4NiBkZWZpbml0
aW9ucyBvbiB0dG1fcGFnZV9hbGxvY19kbWEKICBkcm0vdHRtOiBjbGVhbiB1cCBub24teDg2IGRl
ZmluaXRpb25zIG9uIHR0bV9wYWdlX2FsbG9jCgogZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcGFn
ZV9hbGxvYy5jICAgICB8ICA2MiArKy0tLS0tLS0tLS0tLS0KIGRyaXZlcnMvZ3B1L2RybS90dG0v
dHRtX3BhZ2VfYWxsb2NfZG1hLmMgfCAgNTcgKystLS0tLS0tLS0tLS0KIGluY2x1ZGUvZHJtL3R0
bS90dG1fc2V0X21lbW9yeS5oICAgICAgICAgfCAxMjggKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAxNDAgaW5zZXJ0aW9ucygrKSwgMTA3IGRlbGV0aW9u
cygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvZHJtL3R0bS90dG1fc2V0X21lbW9yeS5o
CgotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
