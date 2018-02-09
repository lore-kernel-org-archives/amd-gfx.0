From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH libdrm 2/2] libdrm: clean up non list code path for vamgr
Date: Fri, 9 Feb 2018 09:58:08 +0100
Message-ID: <c7eaf026-f0f5-fab3-4bab-c11b39701e6a@daenzer.net>
References: <20180112054554.19585-1-david1.zhou@amd.com>
 <20180112054554.19585-2-david1.zhou@amd.com>
 <e3722edc-8ca4-4730-d649-2b5a959b92c1@daenzer.net>
 <4a2036e5-820f-d62a-a773-2da1f575e1bc@amd.com>
 <c6b30b81-8b6f-3b5a-5654-e8075939143e@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c6b30b81-8b6f-3b5a-5654-e8075939143e-5C7GfCeVMHo@public.gmane.org>
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
To: Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org>, Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Hui.Deng-5C7GfCeVMHo@public.gmane.org

T24gMjAxOC0wMi0wOSAwNzowMSBBTSwgQ2h1bm1pbmcgWmhvdSB3cm90ZToKPiBPbiAyMDE45bm0
MDLmnIgwOOaXpSAxNzoxMywgQ2h1bm1pbmcgWmhvdSB3cm90ZToKPj4gT24gMjAxOOW5tDAy5pyI
MDjml6UgMTc6MDEsIE1pY2hlbCBEw6RuemVyIHdyb3RlOgo+Pj4KPj4+IHRoaXMgY2hhbmdlIGNv
bXBsZXRlbHkgYnJva2UgcmFkZW9uc2kgZHVlIHRvIG1lbW9yeSBtYW5hZ2VtZW50IGVycm9ycwo+
Pj4gKHNlZSB2YWxncmluZCBvdXRwdXQgZm9yIGdseGdlYXJzIGJlbG93KSwgc28gSSBoYWQgdG8g
cmV2ZXJ0IGl0Lgo+PiBvaywgSSB3aWxsIGxvb2sgaW50byB3aGF0IGhhcHBlbnMuIFNvcnJ5IGZv
ciBicm9rZW4uCj4gVGhlIHBhdGNoIGxvc3QgYSAiZ290byBvdXQiIGluIGZyZWVfdmEgd2hlbiBh
cHBseWluZyBwYXRjaCBmcm9tIGh5YnJpZAo+IHRvIG9wZW5zb3VyY2UuCj4gVGhlIGF0dGFjaGVk
IGZpeGVzIHRoYXQsIEkgdGVzdGVkIHN1Y2Nlc3NmdWxseSBpbiBteSBsb2NhbCBzaWRlLgo+IMKg
cGxlYXNlIHJldmlldyBvciB0ZXN0LCBpZiBubyBwcm9ibGVtLCBJIHdpbGwgc3VibWl0IGl0IGFn
YWluLgoKUGxlYXNlIGFkZDoKCnYyOiBBZGQgbWlzc2luZyAiZ290byBvdXQiClRlc3RlZC1ieTog
TWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+Cgp0byB0aGUgY29tbWl0IGxv
ZyBiZWZvcmUgcHVzaGluZy4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAg
ICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBl
bnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
