From: "Kazlauskas, Nicholas" <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Get NV14 specific ip params as needed
Date: Wed, 27 Nov 2019 11:31:46 -0500
Message-ID: <b60fc8a3-cd3b-f48f-97af-e1e45d40c310@amd.com>
References: <20191126213222.17728-1-zhan.liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191126213222.17728-1-zhan.liu-5C7GfCeVMHo@public.gmane.org>
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
To: Zhan Liu <zhan.liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, hersenxs.wu-5C7GfCeVMHo@public.gmane.org, rodrigo.siqueira-5C7GfCeVMHo@public.gmane.org

T24gMjAxOS0xMS0yNiA0OjMyIHAubS4sIFpoYW4gTGl1IHdyb3RlOgo+IFtXaHldCj4gTlYxNCBp
cyB1c2luZyBpdHMgb3duIGlwIHBhcmFtcyB0aGF0J3MgZGlmZmVyZW50IGZyb20gb3RoZXIKPiBE
Q04yLjAgQVNJQ3MuCj4gCj4gW0hvd10KPiBBZGQgQVNJQyByZXZpc2lvbiBjaGVjayB0byBtYWtl
IHN1cmUgTlYxNCBnZXRzIGNvcnJlY3QKPiBpcCBwYXJhbXMuCj4gCj4gU2lnbmVkLW9mZi1ieTog
WmhhbiBMaXUgPHpoYW4ubGl1QGFtZC5jb20+CgpSZXZpZXdlZC1ieTogTmljaG9sYXMgS2F6bGF1
c2thcyA8bmljaG9sYXMua2F6bGF1c2thc0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jIHwgMyArKysKPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVzb3VyY2UuYwo+IGluZGV4IGRiYzBh
NGE3YzI4NC4uM2RkMmIyNDI5YWUyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMKPiBAQCAtMzI0NSw2ICszMjQ1
LDkgQEAgc3RhdGljIHN0cnVjdCBfdmNzX2RwaV9zb2NfYm91bmRpbmdfYm94X3N0ICpnZXRfYXNp
Y19yZXZfc29jX2JiKAo+ICAgc3RhdGljIHN0cnVjdCBfdmNzX2RwaV9pcF9wYXJhbXNfc3QgKmdl
dF9hc2ljX3Jldl9pcF9wYXJhbXMoCj4gICAJdWludDMyX3QgaHdfaW50ZXJuYWxfcmV2KQo+ICAg
ewo+ICsJaWYgKEFTSUNSRVZfSVNfTkFWSTE0X00oaHdfaW50ZXJuYWxfcmV2KSkKPiArCQlyZXR1
cm4gJmRjbjJfMF9udjE0X2lwOwo+ICsKPiAgIAkvKiBOVjEyIGFuZCBOVjEwICovCj4gICAJcmV0
dXJuICZkY24yXzBfaXA7Cj4gICB9Cj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZng=
