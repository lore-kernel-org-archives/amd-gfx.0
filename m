From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 1/3] locking/ww_mutex: cleanup lock->ctx usage in amdgpu
Date: Tue, 20 Feb 2018 14:08:26 +0100
Message-ID: <c22fe062-6c7e-cfa3-5f0b-da135a751921@amd.com>
References: <20180215141944.4332-1-christian.koenig@amd.com>
 <20180220123532.GD25314@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180220123532.GD25314@hirez.programming.kicks-ass.net>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

QW0gMjAuMDIuMjAxOCB1bSAxMzozNSBzY2hyaWViIFBldGVyIFppamxzdHJhOgo+IFRoaXMgcmVh
bGx5IHNob3VsZCd2ZSBiZWVuIENjJ2VkIHRvIG1lLgo+Cj4gT24gVGh1LCBGZWIgMTUsIDIwMTgg
YXQgMDM6MTk6NDJQTSArMDEwMCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvd3dfbXV0ZXguaCBiL2luY2x1ZGUvbGludXgvd3dfbXV0ZXguaAo+
PiBpbmRleCAzOWZkYTE5NWJmNzguLmRkNTgwZGIyODllOCAxMDA2NDQKPj4gLS0tIGEvaW5jbHVk
ZS9saW51eC93d19tdXRleC5oCj4+ICsrKyBiL2luY2x1ZGUvbGludXgvd3dfbXV0ZXguaAo+PiBA
QCAtMzU4LDQgKzM1OCwyMSBAQCBzdGF0aWMgaW5saW5lIGJvb2wgd3dfbXV0ZXhfaXNfbG9ja2Vk
KHN0cnVjdCB3d19tdXRleCAqbG9jaykKPj4gICAJcmV0dXJuIG11dGV4X2lzX2xvY2tlZCgmbG9j
ay0+YmFzZSk7Cj4+ICAgfQo+PiAgIAo+PiArLyoqCj4+ICsgKiB3d19tdXRleF9pc19vd25lZF9i
eSAtIGlzIHRoZSB3L3cgbXV0ZXggbG9ja2VkIGJ5IHRoaXMgdGFzayBpbiB0aGF0IGNvbnRleHQK
Pj4gKyAqIEBsb2NrOiB0aGUgbXV0ZXggdG8gYmUgcXVlcmllZAo+PiArICogQHRhc2s6IHRoZSB0
YXNrIHN0cnVjdHVyZSB0byBjaGVjawo+PiArICogQGN0eDogdGhlIHcvdyBhY3F1aXJlIGNvbnRl
eHQgdG8gdGVzdAo+PiArICoKPj4gKyAqIFJldHVybnMgdHJ1ZSBpZiB0aGUgbXV0ZXggaXMgbG9j
a2VkIGluIHRoZSBjb250ZXh0IGJ5IHRoZSBnaXZlbiB0YXNrLCBmYWxzZQo+PiArICogb3RoZXJ3
aXNlLgo+PiArICovCj4+ICtzdGF0aWMgaW5saW5lIGJvb2wgd3dfbXV0ZXhfaXNfb3duZWRfYnko
c3RydWN0IHd3X211dGV4ICpsb2NrLAo+PiArCQkJCQlzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2ss
Cj4+ICsJCQkJCXN0cnVjdCB3d19hY3F1aXJlX2N0eCAqY3R4KQo+PiArewo+PiArCXJldHVybiBs
aWtlbHkoX19tdXRleF9vd25lcigmbG9jay0+YmFzZSkgPT0gdGFzaykgJiYKPj4gKwkJUkVBRF9P
TkNFKGxvY2stPmN0eCkgPT0gY3R4Owo+PiArfQo+IE5hayBvbiB0aGF0IGludGVyZmFjZSwgdGhh
dCdzIHJhY3kgYW5kIGJyb2tlbiBieSBkZXNpZ24uCgpXaHk/CgpSZWdhcmRzLApDaHJpc3RpYW4u
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZl
bCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
