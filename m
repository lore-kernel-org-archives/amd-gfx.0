From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v2 xf86-video-amdgpu] Don't bail from
 drmmode_set_desired_modes immediately
Date: Fri, 16 Feb 2018 09:29:39 +0100
Message-ID: <117021cd-1a9d-d9e2-a9ad-8e685ca272c8@daenzer.net>
References: <20180215173931.11298-1-michel@daenzer.net>
 <20180215174900.11747-1-michel@daenzer.net>
 <8c0dbe40-dfd0-9801-1077-2a76c3124dfd@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <8c0dbe40-dfd0-9801-1077-2a76c3124dfd-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wMi0xNSAxMDowNSBQTSwgSGFycnkgV2VudGxhbmQgd3JvdGU6Cj4gT24gMjAxOC0w
Mi0xNSAxMjo0OSBQTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4+IEZyb206IE1pY2hlbCBEw6Ru
emVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgo+Pgo+PiBJZiB3ZSBmYWlsIHRvIGZpbmQgb3Ig
c2V0IHRoZSBtb2RlIGZvciBhIENSVEMsIGtlZXAgdHJ5aW5nIGZvciB0aGUKPj4gcmVtYWluaW5n
IENSVENzLCBhbmQgb25seSByZXR1cm4gRkFMU0UgaWYgd2UgZmFpbGVkIGZvciBhbGwgQ1JUQ3Mg
dGhhdAo+PiBzaG91bGQgYmUgb24uCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IE1pY2hlbCBEw6RuemVy
IDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgo+IAo+IFRoYW5rcy4gVGhpcyBzaG91bGQgaGVscCB3
aGVuIGJhbmR3aWR0aCBjaGVja3MgaW4gREMgZmFpbC4KCkl0IG1pZ2h0IGluIHNvbWUgY2FzZXMs
IHRob3VnaCBJJ20gYWZyYWlkIGl0IHdvbid0IG1ha2UgYW55IGRpZmZlcmVuY2UKaW4gdGhlIGNh
c2UgeW91J3JlIHByb2JhYmx5IHRoaW5raW5nIG9mIChub3QgZW5vdWdoIGJhbmR3aWR0aCBmb3Ig
MyA0Swptb25pdG9ycyBjb25uZWN0ZWQgdG8gYW4gQVBVKSwgaW4gdGhhdCBjYXNlIHR3byBtb25p
dG9ycyBzaG91bGQgbGlnaHQgdXAKZWl0aGVyIHdheS4gQnV0IGlmIHRoZXJlIHdhcyBlLmcuIGEg
Zm91cnRoIDEwODAgbW9uaXRvciBjb25uZWN0ZWQsIHRoYXQKbWlnaHQgbGlnaHQgdXAgbm93LCB3
aGVyZWFzIGl0IG1pZ2h0IG5vdCBoYXZlIGJlZm9yZS4KCgo+IEFja2VkLWJ5OiBIYXJyeSBXZW50
bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KClRoYW5rcyEKCgotLSAKRWFydGhsaW5nIE1p
Y2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1k
LmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAg
TWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
