From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] drm/amd/display: fix spelling mistake: "Usupported" ->
 "Unsupported"
Date: Tue, 3 Apr 2018 13:02:08 +0300
Message-ID: <20180403100207.ve3r6aluj6udilie@mwanda>
References: <20180330160047.7368-1-colin.king@canonical.com>
 <87tvssaawl.fsf@intel.com>
 <alpine.DEB.2.20.1804031139110.3630@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1804031139110.3630@hadrien>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Colin King <colin.king@canonical.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlLCBBcHIgMDMsIDIwMTggYXQgMTE6NDE6MDVBTSArMDIwMCwgSnVsaWEgTGF3YWxsIHdy
b3RlOgo+IAo+IAo+IE9uIFR1ZSwgMyBBcHIgMjAxOCwgSmFuaSBOaWt1bGEgd3JvdGU6Cj4gCj4g
PiBPbiBGcmksIDMwIE1hciAyMDE4LCBDb2xpbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5j
b20+IHdyb3RlOgo+ID4gPiBGcm9tOiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmlj
YWwuY29tPgo+ID4gPgo+ID4gPiBUcml2aWFsIGZpeCB0byBzcGVsbGluZyBtaXN0YWtlIGluIERS
TV9FUlJPUiBlcnJvciBtZXNzYWdlIHRleHQKPiA+Cj4gPiBUaGFua3MgZm9yIHRoZSBwYXRjaC4K
PiA+Cj4gPiBQbGVhc2UgZG8gY29uc2lkZXIgbGltaXRpbmcgdGhlIGRpc3RyaWJ1dGlvbiBpbiB0
aGUgZnV0dXJlLAo+ID4gdGhvdWdoLiBUaGVyZSdzIG5vIG5lZWQgdG8gaW5jbHVkZSBsa21sIG9y
IGV2ZW4gZHJpLWRldmVsIGZvciB0cml2aWFsCj4gPiBwYXRjaGVzIGxpa2UgdGhpcy4KPiAKPiBJ
dCdzIGNvbXBsZXggdG8gaGF2ZSB0byByZW1lbWJlciB0aGUgcHJlZmVyZW5jZXMgZm9yIGV2ZXJ5
IHN1YnN5c3RlbS4KPiBQcmVmZXJlbmNlcyBzaG91bGQgYmUgZXhwcmVzc2VkIGluIHRoZSBNQUlO
VEFJTkVSUyBmaWxlIGluIHNvbWUgd2F5Lgo+IEFsc28sIHNpbmNlIG5vIG9uZSByZWFkcyBsa21s
LCBkb2VzIGl0IGh1cnQgdG8gaGF2ZSBldmVuIHRyaXZpYWwgcGF0Y2hlcz8KCkkgYWx3YXlzIHRl
bGwgcGVvcGxlIG5vdCB0byBDQyBsa21sIHdoZW4gdGhlcmUgaXMgYSBzbWFsbGVyIHN1YnN5c3Rl
bQpsaXN0IHdoaWNoIGNhbiBoYW5kbGUgaXQgYnV0IExpbnVzIHNhaWQgbXkgYWR2aWNlIHdhcyBi
YWQuCgpyZWdhcmRzLApkYW4gY2FycGVudGVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9kcmktZGV2ZWwK
