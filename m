From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [V2 1/1] drm/amdgpu/gfx8: add support kernel interface queue(KIQ)
Date: Wed, 4 Jan 2017 11:27:29 +0100
Message-ID: <d3a848b9-1789-0788-a9b1-e80d814a8e01@vodafone.de>
References: <1482476904-21674-1-git-send-email-Xiangliang.Yu@amd.com>
 <CY4PR12MB1701D664FEB2EF8FCFD4EBDBEB680@CY4PR12MB1701.namprd12.prod.outlook.com>
 <58632418.5040408@amd.com>
 <CY4PR12MB1701E0582B28FDC9AF4A1CF7EB680@CY4PR12MB1701.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1701E0582B28FDC9AF4A1CF7EB680-rpdhrqHFk05QaJCA3gGb3wdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Yu, Xiangliang" <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

QW0gMjguMTIuMjAxNiB1bSAwMzo1OSBzY2hyaWViIFl1LCBYaWFuZ2xpYW5nOgo+PiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQo+PiBGcm9tOiBhbWQtZ2Z4IFttYWlsdG86YW1kLWdmeC1ib3Vu
Y2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZ10gT24gQmVoYWxmCj4+IE9mIHpob3VjbTEKPj4gU2Vu
dDogV2VkbmVzZGF5LCBEZWNlbWJlciAyOCwgMjAxNiAxMDozMiBBTQo+PiBUbzogWXUsIFhpYW5n
bGlhbmcgPFhpYW5nbGlhbmcuWXVAYW1kLmNvbT47IGFtZC0KPj4gZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwo+PiBDYzogTGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29tPgo+PiBTdWJqZWN0OiBS
ZTogW1YyIDEvMV0gZHJtL2FtZGdwdS9nZng4OiBhZGQgc3VwcG9ydCBrZXJuZWwgaW50ZXJmYWNl
Cj4+IHF1ZXVlKEtJUSkKPj4KPj4KPj4KPj4gT24gMjAxNuW5tDEy5pyIMjjml6UgMTA6MjcsIFl1
LCBYaWFuZ2xpYW5nIHdyb3RlOgo+Pj4gKwo+Pj4+ICsJYW1kZ3B1X2JvX2t1bm1hcChraXEtPmVv
cF9vYmopOwo+Pj4+ICsKPj4gSSBzZWUgaXQgaXMgaW4gbWFueSBwbGFjZXMsIHdoaWNoIGlzIGRv
bid0IG5lZWQgSSB0aGluaywKPj4gYW1kZ3B1X2JvX2ZyZWVfa2VybmVsIHdpbGwgaGFuZGxlIGl0
IGlmIEknbSBjb3JyZWN0Lgo+IE1lbW9yeSBrbWFwIHNob3VsZCBiZSBmcmVlIEFTQVAgZnJvbSBt
ZW1vcnkgbWFuYWdlbWVudCBwb2ludC4KCk5vLCB0aGF0IGlzIGNvbXBsZXRlbHkgdW5uZWNlc3Nh
cnkgYXMgbG9uZyBhcyB5b3UgZG9uJ3QgcnVuIGEgMzJiaXQgCnN5c3RlbSB3aXRoIHRpZ2h0IGFk
ZHJlc3Mgc3BhY2UuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+Cj4+IFJlZ2FyZHMsCj4+IERhdmlk
IHpob3UKPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
Pj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
Pj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQt
Z2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
