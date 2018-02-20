From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/3] locking/ww_mutex: cleanup lock->ctx usage in amdgpu
Date: Tue, 20 Feb 2018 14:22:54 +0100
Message-ID: <20180220132254.GB25201@hirez.programming.kicks-ass.net>
References: <20180215141944.4332-1-christian.koenig@amd.com>
 <20180220123532.GD25314@hirez.programming.kicks-ass.net>
 <c22fe062-6c7e-cfa3-5f0b-da135a751921@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <c22fe062-6c7e-cfa3-5f0b-da135a751921@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlLCBGZWIgMjAsIDIwMTggYXQgMDI6MDg6MjZQTSArMDEwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiBBbSAyMC4wMi4yMDE4IHVtIDEzOjM1IHNjaHJpZWIgUGV0ZXIgWmlqbHN0cmE6
Cj4gPiA+ICtzdGF0aWMgaW5saW5lIGJvb2wgd3dfbXV0ZXhfaXNfb3duZWRfYnkoc3RydWN0IHd3
X211dGV4ICpsb2NrLAo+ID4gPiArCQkJCQlzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2ssCj4gPiA+
ICsJCQkJCXN0cnVjdCB3d19hY3F1aXJlX2N0eCAqY3R4KQo+ID4gPiArewo+ID4gPiArCXJldHVy
biBsaWtlbHkoX19tdXRleF9vd25lcigmbG9jay0+YmFzZSkgPT0gdGFzaykgJiYKPiA+ID4gKwkJ
UkVBRF9PTkNFKGxvY2stPmN0eCkgPT0gY3R4Owo+ID4gPiArfQo+ID4gTmFrIG9uIHRoYXQgaW50
ZXJmYWNlLCB0aGF0J3MgcmFjeSBhbmQgYnJva2VuIGJ5IGRlc2lnbi4KPiAKPiBXaHk/CgpJZiB0
YXNrICE9IGN1cnJlbnQgeW91IGNhbiByYWNlIHdpdGggYSBjb25jdXJyZW50IG11dGV4X3VubG9j
aygpLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmkt
ZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
