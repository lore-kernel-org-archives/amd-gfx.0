From: zhoucm1 <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm 1/4] amdgpu: add bo from user memory to handle table
Date: Tue, 7 Aug 2018 15:51:43 +0800
Message-ID: <a3b83620-72e5-76ea-5005-04f71c46f7c3@amd.com>
References: <1533626820-7701-1-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1533626820-7701-1-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
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
To: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: christian.koenig-5C7GfCeVMHo@public.gmane.org

CgpPbiAyMDE45bm0MDjmnIgwN+aXpSAxNToyNiwgSnVud2VpIFpoYW5nIHdyb3RlOgo+IFdoZW4g
Y3JlYXRlIGJvIGZyb20gdXNlciBtZW1vcnksIGFkZCBpdCB0byBoYW5kbGUgdGFibGUKPiBmb3Ig
ZnV0dXJlIHF1ZXJ5Lgo+Cj4gU2lnbmVkLW9mZi1ieTogSnVud2VpIFpoYW5nIDxKZXJyeS5aaGFu
Z0BhbWQuY29tPgo+IC0tLQo+ICAgYW1kZ3B1L2FtZGdwdV9iby5jIHwgMTEgKysrKysrKysrKy0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBk
aWZmIC0tZ2l0IGEvYW1kZ3B1L2FtZGdwdV9iby5jIGIvYW1kZ3B1L2FtZGdwdV9iby5jCj4gaW5k
ZXggNDIyYzdjOS4uYjI0ZTY5OCAxMDA2NDQKPiAtLS0gYS9hbWRncHUvYW1kZ3B1X2JvLmMKPiAr
KysgYi9hbWRncHUvYW1kZ3B1X2JvLmMKPiBAQCAtNTU2LDcgKzU1NiwxNiBAQCBpbnQgYW1kZ3B1
X2NyZWF0ZV9ib19mcm9tX3VzZXJfbWVtKGFtZGdwdV9kZXZpY2VfaGFuZGxlIGRldiwKPiAgIAli
by0+YWxsb2Nfc2l6ZSA9IHNpemU7Cj4gICAJYm8tPmhhbmRsZSA9IGFyZ3MuaGFuZGxlOwo+ICAg
Cj4gLQkqYnVmX2hhbmRsZSA9IGJvOwo+ICsJcHRocmVhZF9tdXRleF9sb2NrKCZiby0+ZGV2LT5i
b190YWJsZV9tdXRleCk7Cj4gKwlyID0gaGFuZGxlX3RhYmxlX2luc2VydCgmYm8tPmRldi0+Ym9f
aGFuZGxlcywgYm8tPmhhbmRsZSwgYm8pOwo+ICsJcHRocmVhZF9tdXRleF91bmxvY2soJmJvLT5k
ZXYtPmJvX3RhYmxlX211dGV4KTsKPiArCj4gKwlwdGhyZWFkX211dGV4X2luaXQoJmJvLT5jcHVf
YWNjZXNzX211dGV4LCBOVUxMKTsKVGhpcyBsaW5lIGlzIG5vdGhpbmcgd2l0aCBwYXRjaCBpdHNl
bGYsIHBsZWFzZSBzZXBhcmF0ZSBmcm9tIGl0LgoKUmVnYXJkcywKRGF2aWQgWmhvdQo+ICsKPiAr
CWlmIChyKQo+ICsJCWFtZGdwdV9ib19mcmVlKGJvKTsKPiArCWVsc2UKPiArCQkqYnVmX2hhbmRs
ZSA9IGJvOwo+ICAgCj4gICAJcmV0dXJuIHI7Cj4gICB9CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
