From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 01/11] drm/amdgpu: try allocating VRAM as power of two
Date: Tue, 11 Sep 2018 09:55:45 +0200
Message-ID: <5fd331d0-24ab-7540-2d0a-b227230743c0@daenzer.net>
References: <20180909180339.1910-1-christian.koenig@amd.com>
 <20180909180339.1910-2-christian.koenig@amd.com>
 <60b9c96a-d31d-cd61-df22-c8414f0166dc@amd.com>
 <9b61bb4c-4721-c8af-0810-4ecc18ed1ea4@gmail.com>
 <46b7da24-4b04-7daf-e6c3-07e10ecb6fd6@daenzer.net>
 <d0af0309-e4f9-9825-fd30-9cf79ed5f823@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d0af0309-e4f9-9825-fd30-9cf79ed5f823-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wOS0xMSA5OjQ2IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTEu
MDkuMjAxOCB1bSAwOTozNyBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+PiBPbiAyMDE4LTA5LTEx
IDg6NDkgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+IEJ1dCBhbm90aGVyIHF1ZXN0
aW9uOiBXaHkgZG8geW91IHdhbnQgdG8gY2xlYXIgVlJBTSBvbiBhbGxvY2F0aW9uPyBXZQo+Pj4g
cGVyZmVjdGx5IHN1cHBvcnQgYWxsb2NhdGluZyBWUkFNIHdpdGhvdXQgY2xlYXJpbmcgaXQuCj4+
IFdoaWNoIGlzIGEgcHJvYmxlbSBvZiBpdHMgb3duLCBhcyBpdCBjYW4gbGVhayBpbmZvcm1hdGlv
biBmcm9tIG9uZQo+PiBwcm9jZXNzIHRvIGFub3RoZXIuCj4gCj4gSG93IGFib3V0IGFkZGluZyBh
IEFNREdQVV9HRU1fQ1JFQVRFX1ZSQU1fU0VDUkVEIGZsYWcgd2hpY2ggdHJpZ2dlcnMKPiBjbGVh
cmluZyBWUkFNIHdoZW4gdGhlIEJPIGlzIGZyZWVkPwoKRG9lc24ndCBzb3VuZCBsaWtlIG11Y2gg
YmV0dGVyIEFQSSB0aGFuIEFNREdQVV9HRU1fQ1JFQVRFX1ZSQU1fQ0xFQVJFRAp0byBtZS4gV2h5
IHdvdWxkIGFueSBwcm9jZXNzIGJlIG9rYXkgd2l0aCBsZWFraW5nIGl0cyBCTyBjb250ZW50cyB0
bwpvdGhlciBwcm9jZXNzZXM/IENvdWxkIHRoYXQgZmxhZyBldmVuIHByZXZlbnQgaXQgaW4gYWxs
IGNhc2VzLCBlLmcuIHdoZW4KQk9zIGFyZSBldmljdGVkIG9yIG90aGVyd2lzZSBtaWdyYXRlZD8K
CgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAg
ICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAg
ICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
