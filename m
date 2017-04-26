From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm: Harmonize CIK ASIC support in radeon and amdgpu (v2)
Date: Wed, 26 Apr 2017 18:17:12 +0900
Message-ID: <f58fe121-d70c-9e30-7d9e-9188dab99e6c@daenzer.net>
References: <1491866474-1016-1-git-send-email-Felix.Kuehling@amd.com>
 <ac35e641-6fd9-a5d1-c4d9-35e71fa9eb08@daenzer.net>
 <cbcc54ec-c86f-f0eb-715e-f66790b5f964@amd.com>
 <340a5310-e6d1-5e09-81aa-d7106bcdca02@daenzer.net>
 <dedfed15-00b3-83ff-aca7-f4dffff8cc09@amd.com>
 <4bd2c7cf-a555-6cee-a863-b56ee824f9ad@daenzer.net>
 <f2f87cd4-c6c5-7c62-3035-d2f1584d7f00@amd.com>
 <cebca833-9e3f-86c5-8100-feca6ea590e5@daenzer.net>
 <5b7d9374-8277-4c35-efc7-9e93069426a2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5b7d9374-8277-4c35-efc7-9e93069426a2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjYvMDQvMTcgMDM6MDYgQU0sIE5pY29sYWkgSMOkaG5sZSB3cm90ZToKPiBPbiAyNS4wNC4y
MDE3IDA4OjI4LCBNaWNoZWwgRMOkbnplciB3cm90ZToKPj4gT24gMjIvMDQvMTcgMDI6MDUgQU0s
IEZlbGl4IEt1ZWhsaW5nIHdyb3RlOgo+Pgo+PiBTbywgSSdtIHN0YXJ0aW5nIHRvIHRoaW5rIHdl
IG5lZWQgYSBzaGFyZWQgbW9kdWxlIGZvciB0aGlzLCB3aGljaAo+PiBwcm92aWRlcyBvbmUgb3Ig
bXVsdGlwbGUgbW9kdWxlIHBhcmFtZXRlcnMgdG8gY2hvb3NlIHdoaWNoIGRyaXZlciB0byB1c2UK
Pj4gZm9yIENJSy9TSVswXSwgYW5kIHByb3ZpZGVzIHRoZSByZXN1bHQgdG8gdGhlIGFtZGdwdS9y
YWRlb24gZHJpdmVycy4KPj4gVGhhdCBtaWdodCBtYWtlIHRoaW5ncyBlYXNpZXIgZm9yIGFtZGdw
dS1wcm8gLyBvdGhlciBzdGFuZGFsb25lIGFtZGdwdQo+PiB2ZXJzaW9ucyBpbiB0aGUgbG9uZyBy
dW4gYXMgd2VsbCwgYXMgdGhleSBjb3VsZCBhZGQgZmlsZXMgdG8KPj4gL2V0Yy9tb2Rwcm9iZS5k
LyBjaG9vc2luZyB0aGVtc2VsdmVzIGJ5IGRlZmF1bHQsIHdpdGhvdXQgaGF2aW5nIHRvCj4+IGJs
YWNrbGlzdCByYWRlb24uCj4+Cj4+IFdoYXQgZG8geW91IGd1eXMgdGhpbms/Cj4gCj4gSSBzdXNw
ZWN0IHRoYXQgYWRkaW5nIGFuIGVudGlyZSBtb2R1bGUKClRoYXQgc291bmRzIHF1aXRlIGRyYW1h
dGljLiA6KSBXaGljaCBwYXJ0aWN1bGFyIGFzcGVjdChzKSBvZiB0aGF0IGFyZQp5b3UgY29uY2Vy
bmVkIGFib3V0PwoKCj4ganVzdCB0byBzZWxlY3QgYmV0d2VlbiB0d28gb3RoZXIgbW9kdWxlcwoK
RldJVywgSSBzdXNwZWN0IHRoYXQgY291bGQgYWN0dWFsbHkgZW5kIHVwIHNtYWxsZXIgb3ZlcmFs
bCB0aGFuIHRoZQphbHRlcm5hdGl2ZXMgd2UndmUgZGlzY3Vzc2VkIGF0IGxlYXN0IGJ5IHNvbWUg
bWV0cmljcy4KCkFuZCBtYXliZSB0aGlzIG1vZHVsZSBjb3VsZCBiZSB1c2VkIGZvciBzaGFyaW5n
IC8gY29vcmRpbmF0aW5nIG1vcmUKc3R1ZmYgYmV0d2VlbiB0aGUgZHJpdmVycyBpbiB0aGUgZnV0
dXJlLgoKCj4gaXMgdGhlIGtpbmQgb2YgdGhpbmcgdGhhdCBzaG91bGQgYmUgZGlzY3Vzc2VkIGlu
IGEgd2lkZXIgYXVkaWVuY2UgZmlyc3QuCgpJJ2QgbGlrZSB0byBoYXZlIGF0IGxlYXN0IGEgcHJv
b2Ygb2YgY29uY2VwdCBiZWZvcmUgdGhhdC4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVy
ICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBz
b2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBk
ZXZlbG9wZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
