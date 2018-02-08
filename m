From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 2/2] amdgpu/dc/dml: Support clang option for stack
 alignment
Date: Wed, 7 Feb 2018 17:37:30 -0800
Message-ID: <20180208013730.GC116483@google.com>
References: <20180208012156.165934-1-mka@chromium.org>
 <20180208012156.165934-2-mka@chromium.org>
 <CABXOdTeOvFkRp=Z6P47o3ky0HNWkeQ5b_Ff2DVKb8g5tdo3G_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <CABXOdTeOvFkRp=Z6P47o3ky0HNWkeQ5b_Ff2DVKb8g5tdo3G_Q@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Guenter Roeck <groeck@google.com>
Cc: Craig Bergstrom <craigb@chromium.org>, Justin TerAvest <teravest@chromium.org>, David Airlie <airlied@linux.ie>, Felix Kuehling <Felix.Kuehling@amd.com>, linux-kernel <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Guenter Roeck <groeck@chromium.org>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

RWwgV2VkLCBGZWIgMDcsIDIwMTggYXQgMDU6MzQ6NDRQTSAtMDgwMCBHdWVudGVyIFJvZWNrIGhh
IGRpdDoKCj4gT24gV2VkLCBGZWIgNywgMjAxOCBhdCA1OjIxIFBNLCBNYXR0aGlhcyBLYWVobGNr
ZSA8bWthQGNocm9taXVtLm9yZz4gd3JvdGU6Cj4gPiBETUwgdXNlcyB0aGUgY29tcGlsZXIgb3B0
aW9uIC1tcHJlZmVycmVkLXN0YWNrLWJvdW5kYXJ5PTQgdG8gY29uZmlndXJlCj4gPiBhIHN0YWNr
IGFsaWdubWVudCBvZiAxNiBieXRlcy4gQ2xhbmcgdXNlcyB0aGUgb3B0aW9uIC1tc3RhY2stYWxp
Z25tZW50Cj4gPiBpbnN0ZWFkLCB3aGljaCBleHBlY3RzIGFzIHBhcmFtZXRlciB0aGUgYWxpZ25t
ZW50IGluIGJ5dGVzLCBhbmQgbm90IGEKPiA+IHBvd2VyIG9mIHR3byBsaWtlIC1tcHJlZmVycmVk
LXN0YWNrLWJvdW5kYXJ5Lgo+ID4KPiA+IFByb2JlIGZvciBib3RoIGNvbXBpbGVyIG9wdGlvbnMg
YW5kIHVzZSB0aGUgY29ycmVjdCBvbmUsIHNpbWlsYXIgdG8KPiA+IHdoYXQgaXMgZG9uZSBpbiBh
cmNoL3g4Ni9NYWtlZmlsZS4KPiA+Cj4gPiBSZXBvcnRlZC1ieTogR3VlbnRlciBSb2VjayA8Z3Jv
ZWNrQGNocm9taXVtLm9yZz4KPiA+IFNpZ25lZC1vZmYtYnk6IE1hdHRoaWFzIEthZWhsY2tlIDxt
a2FAY2hyb21pdW0ub3JnPgo+ID4gLS0tCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2RtbC9NYWtlZmlsZSB8IDggKysrKysrKy0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvTWFrZWZpbGUgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZG1sL01ha2VmaWxlCj4gPiBpbmRleCBiOGNhZGY4MzNlNzEuLjc0MDk3NTkzMWQy
MSAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvTWFr
ZWZpbGUKPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvTWFrZWZp
bGUKPiA+IEBAIC0yNCw3ICsyNCwxMyBAQAo+ID4gICMgSXQgcHJvdmlkZXMgdGhlIGdlbmVyYWwg
YmFzaWMgc2VydmljZXMgcmVxdWlyZWQgYnkgb3RoZXIgREFMCj4gPiAgIyBzdWJjb21wb25lbnRz
Lgo+ID4KPiA+IC1zdWJkaXItY2NmbGFncy15ICs9IC1taGFyZC1mbG9hdCAtbXNzZSAtbXByZWZl
cnJlZC1zdGFjay1ib3VuZGFyeT00Cj4gPiAraWZuZXEgKCQoY2FsbCBjYy1vcHRpb24sIC1tcHJl
ZmVycmVkLXN0YWNrLWJvdW5kYXJ5PTQpLCkKPiA+ICsgICAgICAgY2Nfc3RhY2tfYWxpZ249LW1w
cmVmZXJyZWQtc3RhY2stYm91bmRhcnk9NAo+ID4gK2Vsc2UgaWZuZXEgKCQoY2FsbCBjYy1vcHRp
b24sIC1tc3RhY2stYWxpZ25tZW50PTE2KSwpCj4gPiArICAgICAgIGNjX3N0YWNrX2FsaWduIDo9
IC1tc3RhY2stYWxpZ25tZW50PTE2Cj4gPiArZW5kaWYKPiA+ICsKPiBBbnkgcmVhc29uIGZvciB1
c2luZyBib3RoID0gYW5kIDo9ID8KCk5vdCByZWFsbHksIHdpbGwgZml4LgoKVGhhbmtzIQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFp
bGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
