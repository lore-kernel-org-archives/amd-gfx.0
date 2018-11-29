From: zhoucm1 <zhoucm1@amd.com>
Subject: Re: restart syncobj timeline changes v2
Date: Thu, 29 Nov 2018 18:38:53 +0800
Message-ID: <7bec5188-30cc-323e-5674-faf6e461425f@amd.com>
References: <20181128145021.4105-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181128145021.4105-1-christian.koenig@amd.com>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Daniel
 Vetter <daniel@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>, "Anholt,
 Eric" <eric@anholt.net>
List-Id: amd-gfx.lists.freedesktop.org

TG9va3MgdmVyeSB2ZXJ5IGdvb2QsIGFuZCBJIGFwcGxpZWQgdGhlbSBpbiBteSBsb2NhbCwgYW5k
IHRlc3RlZCBieSAKLi9hbWRncHVfdGVzdCAtcyA5IGFuZCBzeW5vYmpfYmFzaWMvd2FpdCBvZiBJ
R1QgdG9kYXkuCgorRGFuaWVsLCBDaHJpcywgRXJpYywgQ291bGQgeW91IGFsc28gaGF2ZSBhIGxv
b2sgYXMgd2VsbD8KCgotRGF2aWQKCgoKT24gMjAxOOW5tDEx5pyIMjjml6UgMjI6NTAsIENocmlz
dGlhbiBLw7ZuaWcgd3JvdGU6Cj4gVGVzdGVkIHRoaXMgcGF0Y2ggc2V0IG1vcmUgZXh0ZW5zaXZl
bHkgaW4gdGhlIGxhc3QgdHdvIHdlZWtzIGFuZCBmaXhlZCB0b25zIG9mIGFkZGl0aW9uYWwgYnVn
cy4KPgo+IFN0aWxsIG9ubHkgdGVzdGluZyB3aXRoIGhhbmQgbWFkZSBEUk0gcGF0Y2hlcywgYnV0
IHRob3NlIGFyZSBub3cgcmF0aGVyIHJlbGlhYmxlIGF0IGxlYXN0IG9uIGFtZGdwdS4gU2V0dGlu
ZyB1cCBpZ3QgaXMgdGhlIG5leHQgdGhpbmcgb24gdGhlIFRPRE8gbGlzdC4KPgo+IFVBUEkgc2Vl
bXMgdG8gYmUgcHJldHR5IHNvbGlkIGFscmVhZHkgZXhjZXB0IGZvciB0d28gY2hhbmdlczoKPiAx
LiBEcm9wcGluZyBhbiBleHRyYSBmbGFnIGluIHRoZSB3YWl0IGludGVyZmFjZSB3aGljaCB3YXMg
ZGVmYXVsdCBiZWhhdmlvciBhbnl3YXkuCj4gMi4gRHJvcHBlZCB0aGUgZXh0cmEgaW5kaXJlY3Rp
b24gaW4gdGhlIHF1ZXJ5IGludGVyZmFjZS4KPgo+IEFkZGl0aW9uYWwgdG8gdGhhdCBJJ20gdGhp
bmtpbmcgaWYgd2Ugc2hvdWxkbid0IHJlcGxhY2UgdGhlIGZsYWdzIHBhcmFtZXRlciB0byBmaW5k
X2ZlbmNlKCkgd2l0aCBhIHRpbWVvdXQgdmFsdWUgaW5zdGVhZCB0byBsaW1pdCBob3cgbG9uZyB3
ZSB3YW50IHRvIHdhaXQgZm9yIGEgZmVuY2UgdG8gYXBwZWFyLgo+Cj4gUGxlYXNlIHRlc3QgYW5k
IGNvbW1lbnQsCj4gQ2hyaXN0aWFuLgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmkt
ZGV2ZWwK
