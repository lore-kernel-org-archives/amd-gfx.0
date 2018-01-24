From: Seth Zhu <seth.zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH libdrm] drm/amdgpu: define amdgpu_syncobj_handle type for
 vulkan usage
Date: Wed, 24 Jan 2018 14:19:21 +0800
Message-ID: <1516774761-32653-1-git-send-email-seth.zhu@amd.com>
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
Cc: Seth Zhu <seth.zhu-5C7GfCeVMHo@public.gmane.org>

VnVsa2FuIEZlbmNlIGFuZCBTZW1hcGhvcmUoQU1EVkxLKSB3aWxsIGFkZCBpbXBsZW1lbnRhdGlv
biBiYXNlZCBvbgpzeW5jIG9iamVjdC4gU2VtYW50aWMgc3luY29iaiBoYW5kbGUgdHlwZSBpcyBy
ZXF1aXJlZCBpbnN0ZWFkIG9mCnVzaW5nIHVpbnQzMl90IGRpcmVjdGx5LgoKQ2hhbmdlLUlkOiBJ
ZGJkMmIyYjE2MTgxOGZhNThmZTBiYjNkMWFjNDY0NTM4NDdhZTYyNgpTaWduZWQtb2ZmLWJ5OiBT
ZXRoIFpodSA8c2V0aC56aHVAYW1kLmNvbT4KLS0tCiBhbWRncHUvYW1kZ3B1LmggfCA0ICsrKysK
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hbWRncHUvYW1k
Z3B1LmggYi9hbWRncHUvYW1kZ3B1LmgKaW5kZXggOWVmNTVlNS4uMzFmYzIwMSAxMDA2NDQKLS0t
IGEvYW1kZ3B1L2FtZGdwdS5oCisrKyBiL2FtZGdwdS9hbWRncHUuaApAQCAtMTQ1LDYgKzE0NSwx
MCBAQCB0eXBlZGVmIHN0cnVjdCBhbWRncHVfc2VtYXBob3JlICphbWRncHVfc2VtYXBob3JlX2hh
bmRsZTsKICAqIERlZmluZSBoYW5kbGUgZm9yIHNlbSBmaWxlCiAgKi8KIHR5cGVkZWYgdWludDMy
X3QgYW1kZ3B1X3NlbV9oYW5kbGU7CisvKioKKyAqIERlZmluZSBoYW5kbGUgZm9yIHN5bmNvYmoK
KyAqLwordHlwZWRlZiB1aW50MzJfdCBhbWRncHVfc3luY29ial9oYW5kbGU7CiAKIAogLyotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLSovCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
