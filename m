From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Remove bo.priority compiler warning
Date: Wed, 15 Feb 2017 10:21:26 +0100
Message-ID: <4887b7c2-070e-d125-d049-31c538ee3b61@vodafone.de>
References: <daa4edb1-ace7-1640-6ae3-645126a64acc@amd.com>
 <b933c715-dd96-977f-077a-1d0f56bda614@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b933c715-dd96-977f-077a-1d0f56bda614-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

WWVhaCwgTmljb2xhaSB3YXMgZmFzdGVyIHRoYW4geW91LgoKUGF0Y2ggaXMgYWxyZWFkeSByZXZp
ZXdlZCBhbmQgc2hvdWxkIGJlIGNvbW1pdHRlZC4KCkNocmlzdGlhbi4KCkFtIDE0LjAyLjIwMTcg
dW0gMTk6MzAgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBJIHRoaW5rIE5pY29sYWkgYmVhdCB5
b3UgdG8gdGhpcyB3aXRoIGhpcyBwYXRjaCAiZHJtL3R0bTogbWFrZQo+IFRUTV9NQVhfQk9fUFJJ
T1JJVFkgdW5zaWduZWQiLgo+Cj4KPiBPbiAxNy0wMi0xNCAwMTowMyBQTSwgS2VudCBSdXNzZWxs
IHdyb3RlOgo+PiBBZGRyZXNzZXMgdGhpcyBjb21waWxlIHdhcm5pbmc6Cj4+Cj4+IHdhcm5pbmc6
IGNvbXBhcmlzb24gb2YgZGlzdGluY3QgcG9pbnRlciB0eXBlcyBsYWNrcyBhIGNhc3QgW2VuYWJs
ZWQgYnkKPj4gZGVmYXVsdF0KPj4gICAgYm8tPnRiby5wcmlvcml0eSA9IG1pbihiby0+dGJvLnBy
aW9yaXR5LCBUVE1fTUFYX0JPX1BSSU9SSVRZIC0gMSk7Cj4+Cj4+ICAgS2VudAo+Pgo+Pgo+Pgo+
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBhbWQt
Z2Z4IG1haWxpbmcgbGlzdAo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFp
bGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
