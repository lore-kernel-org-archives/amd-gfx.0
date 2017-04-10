From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: reserve space before adding a shared fence
Date: Mon, 10 Apr 2017 09:02:13 +0200
Message-ID: <9574da1c-a3a1-f4d3-1d41-695e73c732e0@vodafone.de>
References: <1491807259-7139-1-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1491807259-7139-1-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
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

TWhtLCBkaWQgeW91IHJ1biBpbnRvIGFuIGFjdHVhbCBpc3N1ZSBvciB3YXMgdGhhdCBqdXN0IGZy
b20gcmVhZGluZyB0aGUgCmNvZGU/CgpUaGUgY2FsbGVyIHNob3VsZCBoYXZlIHJlc2VydmVkIGEg
c2hhcmVkIHNsb3QgYmVmb3JlIGNhbGxpbmcgCmFtZGdwdV92bV91cGRhdGVfZGlyZWN0b3JpZXMo
KSBhbmQgSSBqdXN0IGRvdWJsZSBjaGVja2VkIHRoYXQgYW5kIHdlIApzZWVtIHRvIGRvIHRoaXMg
ZXZlcnl3aGVyZS4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCkFtIDEwLjA0LjIwMTcgdW0gMDg6NTQg
c2NocmllYiBKdW53ZWkgWmhhbmc6Cj4gU2lnbmVkLW9mZi1ieTogSnVud2VpIFpoYW5nIDxKZXJy
eS5aaGFuZ0BhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZtLmMgfCAzICsrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBpbmRleCAxNTdhZTUwLi41NWFm
OTA5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5j
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBAQCAtOTEz
LDYgKzkxMyw5IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX3VwZGF0ZV9sZXZlbChzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwKPiAgIAkJaWYgKHNoYWRvdykKPiAgIAkJCWFtZGdwdV9zeW5jX3Jl
c3YoYWRldiwgJmpvYi0+c3luYywgc2hhZG93LT50Ym8ucmVzdiwKPiAgIAkJCQkJIEFNREdQVV9G
RU5DRV9PV05FUl9WTSk7Cj4gKwkJciA9IHJlc2VydmF0aW9uX29iamVjdF9yZXNlcnZlX3NoYXJl
ZChwYXJlbnQtPmJvLT50Ym8ucmVzdik7Cj4gKwkJaWYgKHIpCj4gKwkJCWdvdG8gZXJyb3JfZnJl
ZTsKPiAgIAo+ICAgCQlXQVJOX09OKHBhcmFtcy5pYi0+bGVuZ3RoX2R3ID4gbmR3KTsKPiAgIAkJ
ciA9IGFtZGdwdV9qb2Jfc3VibWl0KGpvYiwgcmluZywgJnZtLT5lbnRpdHksCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
