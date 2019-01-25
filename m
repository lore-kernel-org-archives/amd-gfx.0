From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm: enable uncached DMA optimization for ARM and arm64
Date: Fri, 25 Jan 2019 12:30:23 +0100
Message-ID: <961e758d-b0a0-8f6c-a8fa-c3047e058706@gmail.com>
References: <20190124120658.30288-1-ard.biesheuvel@linaro.org>
 <3cca35a9-c71c-a100-b29d-31ba0d1d10b1@amd.com>
 <CAKv+Gu9OG3O4+4F2nioaQ-3U-1kwRBr5KVj-1gD1ZEsUx_Ud5A@mail.gmail.com>
 <CADnq5_PETD6umm9Df7OZ9BdaV5MZutmhN+HTAnVkcRLg5=TNWw@mail.gmail.com>
 <CAKv+Gu-Yk1iEe+cF30ee7R+hcrke9XH9MdTeERA2P-0s2QpaLw@mail.gmail.com>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAKv+Gu-Yk1iEe+cF30ee7R+hcrke9XH9MdTeERA2P-0s2QpaLw@mail.gmail.com>
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Alex Deucher <alexdeucher@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>, Carsten Haitzler <Carsten.Haitzler@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Michael Ellerman <mpe@ellerman.id.au>, "Daenzer,
 Michel" <Michel.Daenzer@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@infradead.org>, David Airlie <airlied@linux.ie>, "Huang,
 Ray" <Ray.Huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Jerry" <Jerry.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, Sean Paul <sean@poorly.run>, "Koenig, Christian" <Christian.Koenig@amd.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>
List-Id: amd-gfx.lists.freedesktop.org

QW0gMjUuMDEuMTkgdW0gMDk6NDMgc2NocmllYiBBcmQgQmllc2hldXZlbDoKPiBPbiBUaHUsIDI0
IEphbiAyMDE5IGF0IDE1OjAxLCBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4g
d3JvdGU6Cj4+IE9uIFRodSwgSmFuIDI0LCAyMDE5IGF0IDk6MDAgQU0gQXJkIEJpZXNoZXV2ZWwK
Pj4gPGFyZC5iaWVzaGV1dmVsQGxpbmFyby5vcmc+IHdyb3RlOgo+Pj4gT24gVGh1LCAyNCBKYW4g
MjAxOSBhdCAxMzozMSwgS29lbmlnLCBDaHJpc3RpYW4KPj4+IDxDaHJpc3RpYW4uS29lbmlnQGFt
ZC5jb20+IHdyb3RlOgo+Pj4+IEFtIDI0LjAxLjE5IHVtIDEzOjA2IHNjaHJpZWIgQXJkIEJpZXNo
ZXV2ZWw6Cj4+Pj4+IFRoZSBEUk0gZHJpdmVyIHN0YWNrIGlzIGRlc2lnbmVkIHRvIHdvcmsgd2l0
aCBjYWNoZSBjb2hlcmVudCBkZXZpY2VzCj4+Pj4+IG9ubHksIGJ1dCBwZXJtaXRzIGFuIG9wdGlt
aXphdGlvbiB0byBiZSBlbmFibGVkIGluIHNvbWUgY2FzZXMsIHdoZXJlCj4+Pj4+IGZvciBzb21l
IGJ1ZmZlcnMsIGJvdGggdGhlIENQVSBhbmQgdGhlIEdQVSB1c2UgdW5jYWNoZWQgbWFwcGluZ3Ms
Cj4+Pj4+IHJlbW92aW5nIHRoZSBuZWVkIGZvciBETUEgc25vb3BpbmcgYW5kIGFsbG9jYXRpb24g
aW4gdGhlIENQVSBjYWNoZXMuCj4+Pj4+Cj4+Pj4+IFRoZSB1c2Ugb2YgdW5jYWNoZWQgR1BVIG1h
cHBpbmdzIHJlbGllcyBvbiB0aGUgY29ycmVjdCBpbXBsZW1lbnRhdGlvbgo+Pj4+PiBvZiB0aGUg
UENJZSBOb1Nub29wIFRMUCBhdHRyaWJ1dGUgYnkgdGhlIHBsYXRmb3JtLCBvdGhlcndpc2UgdGhl
IEdQVQo+Pj4+PiB3aWxsIHVzZSBjYWNoZWQgbWFwcGluZ3Mgbm9uZXRoZWxlc3MuIE9uIHg4NiBw
bGF0Zm9ybXMsIHRoaXMgZG9lcyBub3QKPj4+Pj4gc2VlbSB0byBtYXR0ZXIsIGFzIHVuY2FjaGVk
IENQVSBtYXBwaW5ncyB3aWxsIHNub29wIHRoZSBjYWNoZXMgaW4gYW55Cj4+Pj4+IGNhc2UuIEhv
d2V2ZXIsIG9uIEFSTSBhbmQgYXJtNjQsIGVuYWJsaW5nIHRoaXMgb3B0aW1pemF0aW9uIG9uIGEK
Pj4+Pj4gcGxhdGZvcm0gd2hlcmUgTm9Tbm9vcCBpcyBpZ25vcmVkIHJlc3VsdHMgaW4gbG9zcyBv
ZiBjb2hlcmVuY3ksIHdoaWNoCj4+Pj4+IGJyZWFrcyBjb3JyZWN0IG9wZXJhdGlvbiBvZiB0aGUg
ZGV2aWNlLiBTaW5jZSB3ZSBoYXZlIG5vIHdheSBvZgo+Pj4+PiBkZXRlY3Rpbmcgd2hldGhlciBO
b1Nub29wIHdvcmtzIG9yIG5vdCwganVzdCBkaXNhYmxlIHRoaXMKPj4+Pj4gb3B0aW1pemF0aW9u
IGVudGlyZWx5IGZvciBBUk0gYW5kIGFybTY0Lgo+Pj4+Pgo+Pj4+PiBDYzogQ2hyaXN0aWFuIEtv
ZW5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Pj4+PiBDYzogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+Pj4+PiBDYzogRGF2aWQgWmhvdSA8RGF2aWQxLlpo
b3VAYW1kLmNvbT4KPj4+Pj4gQ2M6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Cj4+Pj4+
IENjOiBKdW53ZWkgWmhhbmcgPEplcnJ5LlpoYW5nQGFtZC5jb20+Cj4+Pj4+IENjOiBNaWNoZWwg
RGFlbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KPj4+Pj4gQ2M6IERhdmlkIEFpcmxpZSA8
YWlybGllZEBsaW51eC5pZT4KPj4+Pj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5j
aD4KPj4+Pj4gQ2M6IE1hYXJ0ZW4gTGFua2hvcnN0IDxtYWFydGVuLmxhbmtob3JzdEBsaW51eC5p
bnRlbC5jb20+Cj4+Pj4+IENjOiBNYXhpbWUgUmlwYXJkIDxtYXhpbWUucmlwYXJkQGJvb3RsaW4u
Y29tPgo+Pj4+PiBDYzogU2VhbiBQYXVsIDxzZWFuQHBvb3JseS5ydW4+Cj4+Pj4+IENjOiBNaWNo
YWVsIEVsbGVybWFuIDxtcGVAZWxsZXJtYW4uaWQuYXU+Cj4+Pj4+IENjOiBCZW5qYW1pbiBIZXJy
ZW5zY2htaWR0IDxiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc+Cj4+Pj4+IENjOiBXaWxsIERlYWNv
biA8d2lsbC5kZWFjb25AYXJtLmNvbT4KPj4+Pj4gQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hA
aW5mcmFkZWFkLm9yZz4KPj4+Pj4gQ2M6IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5j
b20+Cj4+Pj4+IENjOiBhbWQtZ2Z4IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Pgo+Pj4+PiBDYzogZHJpLWRldmVsIDxkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPgo+
Pj4+PiBSZXBvcnRlZC1ieTogQ2Fyc3RlbiBIYWl0emxlciA8Q2Fyc3Rlbi5IYWl0emxlckBhcm0u
Y29tPgo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBBcmQgQmllc2hldXZlbCA8YXJkLmJpZXNoZXV2ZWxA
bGluYXJvLm9yZz4KPj4+PiBUaGUgc3ViamVjdCBsaW5lIHNob3VsZCBwcm9iYWJseSByZWFkICJk
aXNhYmxlIHVuY2FjaGVkLi4uIi4KPj4+Pgo+Pj4gVWdoLCBvZiBjb3Vyc2UgLi4uCj4+Pgo+Pj4+
IFdpdGggdGhhdCBmaXhlZCB0aGUgcGF0Y2ggaXMgUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7Zu
aWcKPj4+PiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPi4KPj4+Pgo+PiBTYW1lOgo+PiBSZXZp
ZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+Pgo+IFRo
YW5rcyBhbGwKPgo+IFNob3VsZCBJIHJlc2VuZCB0aGUgcGF0Y2ggd2l0aCB0aGUgc3ViamVjdCBj
b3JyZWN0ZWQ/CgpJIHdpbGwgdXBkYXRlIHRoZSBzdWJqZWN0IGxpbmUgYW5kIHB1c2ggaXQgdXBz
dHJlYW0gdGhyb3VnaCAKZHJtLW1pc2MtbmV4dCBpZiBub2JvZHkgb2JqZWN0cy4KCkNocmlzdGlh
bi4KCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBk
cmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4gZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2
ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
