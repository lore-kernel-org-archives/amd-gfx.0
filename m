From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 01/12] drm/ttm: Fix 'buf' pointer update in
 ttm_bo_vm_access_kmap() (v2)
Date: Mon, 29 Jan 2018 15:39:00 +0100
Message-ID: <ae578edc-835c-9a12-8eef-e53b10648fad@gmail.com>
References: <20180129135513.22538-1-tom.stdenis@amd.com>
 <20180129135513.22538-2-tom.stdenis@amd.com>
 <8aa2cc49-8935-cb59-9f2a-97d8ad422959@daenzer.net>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <8aa2cc49-8935-cb59-9f2a-97d8ad422959@daenzer.net>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>, Tom St Denis <tom.stdenis@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

QW0gMjkuMDEuMjAxOCB1bSAxNTozMSBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTgt
MDEtMjkgMDI6NTUgUE0sIFRvbSBTdCBEZW5pcyB3cm90ZToKPj4gVGhlIGJ1ZiBwb2ludGVyIHdh
cyBub3QgYmVpbmcgaW5jcmVtZW50ZWQgaW5zaWRlIHRoZSBsb29wCj4+IG1lYW5pbmcgdGhlIHNh
bWUgYmxvY2sgb2YgZGF0YSB3b3VsZCBiZSByZWFkIG9yIHdyaXR0ZW4KPj4gcmVwZWF0ZWRseS4K
Pj4KPj4gU2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgo+
PiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
Pgo+IFBsZWFzZSBhZGQ6Cj4KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwo+IEZpeGVzOiAw
OWFjNGZjYjNmMjUgKCJkcm0vdHRtOiBJbXBsZW1lbnQgdm1fb3BlcmF0aW9uc19zdHJ1Y3QuYWNj
ZXNzIHYyIikKCldoYXQgTWljaGVsIG1lYW50IGhlcmUgaXMgdGhhdCB5b3Ugc2hvdWxkIGFkZCB0
aGUgIkNjOiAiIGFuZCAiRml4ZXM6ICIgCnRhZ3MgdG8gdGhlIGNvbW1pdCBtZXNzYWdlIGFuZCBO
T1Qgc2VuZCBpdCBtYW51YWxseSB0byAKc3RhYmxlQHZnZXIua2VybmVsLm9yZy4KClRoZSAiQ2M6
IiB0YWcgcmVzdWx0cyBpbiBhdXRvbWF0aWNhbGx5IGJhY2twb3J0aW5nIG9mIHRoZSBwYXRjaCB0
byAKc3RhYmxlIGtlcm5lbHMuIE1hbnVhbGx5IHNlbmRpbmcgYSBwYXRjaCB0byBzdGFibGVAdmdl
ci5rZXJuZWwub3JnIGlzIApvbmx5IG5lY2Vzc2FyeSB3aGVuIHRoZSBhdXRvbWF0ZWQgYmFja3Bv
cnQgZG9lc24ndCB3b3JrLgoKQ2hyaXN0aWFuLgoKPgo+IHNvIHRoYXQgaXQnbGwgZ2V0IGJhY2tw
b3J0ZWQgdG8gdGhlIHJlbGV2YW50IHN0YWJsZSBicmFuY2hlcy4KPgo+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0
CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
