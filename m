From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 0/5] ***[WIP] introduce syncfile as fence reuturn ***
Date: Tue, 12 Sep 2017 13:00:47 +0200
Message-ID: <ab6649bd-4a00-f4a7-cdb7-258eb049fbf4@vodafone.de>
References: <1505211827-12355-1-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1505211827-12355-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
To: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

TkFLIGZvciB0aGUgQ1MgcGFydCAoYnV0IEkgdGhpbmsgdGhhdCB3YXMganVzdCBhcyBwcm92ZSBv
ZiBjb25jZXB0IGFueXdheSkuCgpEYXZlJ3Mgc3luYyBvYmplY3QgaW1wbGVtZW50YXRpb24gaXMg
YWxyZWFkeSBkb25lIGZvciB0aGlzLCB0aGUgcHJvYmxlbSAKaXMgdGhhdCBpc24ndCBtZXJnZWQg
eWV0IGludG8gYW1kLXN0YWdpbmctNC4xMiAoYnV0IHNob3VsZCBiZSBpbiA0LTEzKS4KClRoZSBW
TSBwYXJ0IGxvb2tzIHNpbWlsYXIgdG8gd2hhdCBJIGhhZCBpbiBtaW5kLCBidXQgd2Ugc2hvdWxk
IGJhc2UgdGhpcyAKb24gRGF2ZSdzIHN5bmNfb2JqIHN0dWZmIGFzIHdlbGwuCgpSZWdhcmRzLApD
aHJpc3RpYW4uCgpBbSAxMi4wOS4yMDE3IHVtIDEyOjIzIHNjaHJpZWIgQ2h1bm1pbmcgWmhvdToK
PiAqKiogQkxVUkIgSEVSRSAqKioKPgo+IENodW5taW5nIFpob3UgKDUpOgo+ICAgIGRybS9hbWRn
cHU6IGludHJvZHVjZSBzeW5jIGZpbGUgZm9yIENTIHJldHVybmluZyBmZW5jZQo+ICAgIGRybS9h
bWRncHU6IGFkZCBzeW5jZmlsZSBjaHVuayBzdXBwb3J0Cj4gICAgZHJtL2FtZGdwdTogYWRkIHN5
bmNmaWxlIHN1cHBvcnQgdG8gd2FpdCBpb2N0bAo+ICAgIGRybS9hbWRncHU6IGFkZCBzeW5jZmls
ZSBmZW5jZSBzdXBwb3J0IHRvIHdhaXRfYW55L2FsbCBpb2N0bAo+ICAgIGRybS9hbWRncHU6IGV4
cGFuZCBtYXBwaW5nIGlvY3RsIHRvIHJldHVybiBmZW5jZSB0byBVTUQgYnkgdXNpbmcKPiAgICAg
IHN5bmNmaWxlCj4KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jICB8
IDkwICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQo+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jIHwgMjQgKysrKysrKy0tCj4gICBpbmNsdWRlL3VhcGkv
ZHJtL2FtZGdwdV9kcm0uaCAgICAgICAgICAgfCAxMyArKysrLQo+ICAgMyBmaWxlcyBjaGFuZ2Vk
LCA5NiBpbnNlcnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkKPgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
