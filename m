From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix iova debugfs for non-iommu case
Date: Tue, 19 Sep 2017 19:18:18 +0200
Message-ID: <73bfce43-eeb2-f30a-21be-f59e1a9eb509@amd.com>
References: <20170919153042.9994-1-tom.stdenis@amd.com>
 <e9302f12-3f26-5176-79d1-5d837e44ebd5@amd.com>
 <1e817718-572a-6d77-f948-ef3ed5eeef0c@gmail.com>
 <5fbdcf5d-3be9-5af9-2321-8c59ebac4bb3@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5fbdcf5d-3be9-5af9-2321-8c59ebac4bb3-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMTkuMDkuMjAxNyB1bSAxOToxNCBzY2hyaWViIFRvbSBTdCBEZW5pczoKPiBPbiAxOS8wOS8x
NyAwMToxMCBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQXMgZmFyIGFzIEkga25vdyB3
ZSBkb24ndCBuZWVkICNpZmRlZnMgY2F1c2UgdGhlcmUgYXJlIGR1bW15IAo+PiBmdW5jdGlvbnMg
d2hlbiBJT01NVSBpcyBub3QgY29tcGlsZWQgaW4uCj4+Cj4+IEJ1dCB0aGlzIHBhdGNoIGlzIGEg
TkFLIHNpbmNlIGl0IGNpcmN1bXZlbnRzIHRoZSAvZGV2L21lbSByZXN0cmljdGlvbiAKPj4gd2hl
biBJT01NVSBpcyBkaXNhYmxlZCBhbmQgdGhhdCBpcyBub3Qgc29tZXRoaW5nIHdlIGNhbiBlYXNp
bHkgYWxsb3cuCj4KPiBJIHJhaXNlZCB0aGlzIG9iamVjdGlvbiAyNCBob3VycyBhZ28gYW5kIHdh
cyB0b2xkIHRvIGdvIGFoZWFkIHdpdGggdGhlIAo+IHJlYWQvd3JpdGUgbWV0aG9kcyBhbnl3YXlz
Lgo+Cj4gU2hvcnQgb2YgbWFraW5nIGEgbGlzdCBvZiBtYXBwaW5ncy9hbGxvY2F0aW9ucyBpbiB0
aGUgdHRtIGxheWVyIEkgaGF2ZSAKPiBubyBpZGVhIGhvdyB3ZSB3b3VsZCB0cmFjayB0aGlzIGlu
IHRoZSBub24taW9tbXUgY2FzZSB3aGljaCBtZWFucyB0aGUgCj4gZW50aXJlIGlvdmEgZGVidWdm
cyBlbnRyeSBzaG91bGQgaGF2ZSBiZWVuIE5BSydlZCBpbiB0aGUgZmlyc3QgcGxhY2UuCj4KPiBJ
J20gb3BlbiB0byBzdWdnZXN0aW9ucy4KCkFzIGxvbmcgYXMgSU9NTVUgaXMgZW5hYmxlZCB0aGUg
ZW50cnkgaXMgcGVyZmVjdGx5IGZpbmUsIGNhdXNlIG9ubHkgCm1lbW9yeSBtYXBwZWQgdG8gdGhl
IElPTU1VIGlzIGFjY2Vzc2libGUgdG8gdGhlIEdQVSBhbmQgc28gYWNjZXNzaWJsZSAKdXNpbmcg
dGhlIGRlYnVnZnMgZW50cnkgYXMgd2VsbC4KCk9ubHkgd2hlbiBJT01NVSBpcyBkaXNhYmxlZCB3
ZSBjYW4ndCBnbyB0aGlzIHdheSBjYXVzZSB3ZSBjYW4ndCBrbm93IAp3aGljaCBtZW1vcnkgaXMg
bWFwcGVkIHRvIHRoZSBkcml2ZXIgYW5kIHdoaWNoIGlzbid0IChvciBjb3VsZCB3ZSAKc29tZWhv
dyB0cmFjayB0aGlzPykuCgpJIHN1Z2dlc3QgdG8gbm90IGNyZWF0ZSB0aGUgZmlsZSBpbiB0aGUg
Zmlyc3QgcGxhY2UgaWYgSU9NTVUgaXMgZGlzYWJsZWQuCgpDaHJpc3RpYW4uCgo+Cj4gVG9tCgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
