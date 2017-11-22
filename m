From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] amdgpu: Use unsigned HW IP/instance/ring indices in
 amdgpu_queue_mgr_map
Date: Wed, 22 Nov 2017 10:22:12 +0100
Message-ID: <38c529df-e25e-1a85-03da-ed2a48728b90@amd.com>
References: <20171121172940.8037-1-michel@daenzer.net>
 <fa7f26cb-7a4b-059c-d570-f2e7e15abeac@gmail.com>
 <e46d1d6b-213f-7095-6f8d-216413017cd7@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e46d1d6b-213f-7095-6f8d-216413017cd7-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjIuMTEuMjAxNyB1bSAwOTo0MiBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTct
MTEtMjEgMDc6MzggUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDIxLjExLjIwMTcg
dW0gMTg6Mjkgc2NocmllYiBNaWNoZWwgRMOkbnplcjoKPj4+IEZyb206IE1pY2hlbCBEw6RuemVy
IDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgo+Pj4KPj4+IFRoaXMgbWF0Y2hlcyB0aGUgY29ycmVz
cG9uZGluZyBVQVBJIGZpZWxkcy4gVHJlYXRpbmcgdGhlIHJpbmcgaW5kZXggYXMKPj4+IHNpZ25l
ZCBjb3VsZCByZXN1bHQgaW4gYWNjZXNzaW5nIHJhbmRvbSB1bnJlbGF0ZWQgbWVtb3J5IGlmIHRo
ZSBNU0Igd2FzCj4+PiBzZXQuCj4+Pgo+Pj4gRml4ZXM6IGVmZmQ5MjRkMmYzYiAoImRybS9hbWRn
cHU6IHVudGllIHVzZXIgcmluZyBpZHMgZnJvbSBrZXJuZWwgcmluZwo+Pj4gIMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlkcyB2NiIpCj4+PiBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZwo+Pj4gU2lnbmVkLW9mZi1ieTogTWljaGVsIETDpG56ZXIgPG1pY2hl
bC5kYWVuemVyQGFtZC5jb20+Cj4+IFN1YmplY3QgbGluZSBpcyBvZmYsIFsuLi5dCj4gSSBhc3N1
bWUgeW91J3JlIHJlZmVycmluZyB0byB0aGUgcHJlZml4LiBXZWxsLCBJJ20gYWN0dWFsbHkgdHJ5
aW5nIHRvCj4gc2V0IGEgdHJlbmQgdGhlcmUuIDopIFNpbmNlIHRoZXJlJ3Mgbm8gb3RoZXIgYW1k
Z3B1IGRyaXZlciwgdGhlIGRybS8gaXMKPiByZWR1bmRhbnQuIEluIHRoZSBzcGVjaWZpYyBjYXNl
IG9mIHRoaXMgcGF0Y2gsIGFkZGluZyBpdCB3b3VsZCBtYWtlIHRoZQo+IHNob3J0bG9nIHRvbyBs
b25nLCBhbmQgSU1FIGl0J3MgcXVpdGUgb2Z0ZW4gdGhlIGNhc2UgdGhhdCB0aG9zZSBmb3VyCj4g
Y2hhcmFjdGVyIGNlbGxzIGNvdWxkIGJlIHB1dCB0byBiZXR0ZXIgdXNlIHRoYW4gZm9yIHRoZSBy
ZWR1bmRhbnQgcHJlZml4LgoKWWVhaCwgbWFraW5nIHRoZSBwcmVmaXggc2hvcnRlciBpcyBvbmUg
dGhpbmcgSSBoYXZlIHRob3VnaHQgYWJvdXQgYXMgd2VsbC4KCkJ1dCBjdXJyZW50bHkgd2UgdXNl
ICJkcm0vYW1kZ3B1OiIgZm9yIHRoZSBrZXJuZWwgYW5kICJhbWRncHU6IiBmb3IgCmxpYmRybSBh
bmQgSSBhY3R1YWxseSB3b3VsZCBsaWtlIHRvIGtlZXAgdGhhdC4KCkNocmlzdGlhbi4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
