From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/amd/display: fix compilation error
Date: Thu, 13 Jun 2019 10:23:46 +0200
Message-ID: <20190613082346.GH23020@phenom.ffwll.local>
References: <20190613023208.GA29690@hari-Inspiron-1545>
 <CADnq5_PU_jvOskC-=+oRQdvYXZvu_n26ogoWTxLRxnW+ke4wDw@mail.gmail.com>
 <20190613024854.GA25104@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20190613024854.GA25104@hari-Inspiron-1545>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc: linux-kernel@vger.kernel.org, Yongqiang Sun <yongqiang.sun@amd.com>, Charlene Liu <charlene.liu@amd.com>, Leo Li <sunpeng.li@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, David Airlie <airlied@linux.ie>, Gloria Li <geling.li@amd.com>, amd-gfx@lists.freedesktop.org, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Tony Cheng <tony.cheng@amd.com>, dri-devel@lists.freedesktop.org, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Anthony Koo <Anthony.Koo@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gVGh1LCBKdW4gMTMsIDIwMTkgYXQgMDg6MTg6NTRBTSArMDUzMCwgSGFyaXByYXNhZCBLZWxh
bSB3cm90ZToKPiBPbiBXZWQsIEp1biAxMiwgMjAxOSBhdCAxMDozNToyNlBNIC0wNDAwLCBBbGV4
IERldWNoZXIgd3JvdGU6Cj4gPiBPbiBXZWQsIEp1biAxMiwgMjAxOSBhdCAxMDozNCBQTSBIYXJp
cHJhc2FkIEtlbGFtCj4gPiA8aGFyaXByYXNhZC5rZWxhbUBnbWFpbC5jb20+IHdyb3RlOgo+ID4g
Pgo+ID4gPiB0aGlzIHBhdGNoIGZpeGVzIGJlbG93IGNvbXBpbGF0aW9uIGVycm9yCj4gPiA+Cj4g
PiA+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBf
aHdfc2VxdWVuY2VyLmM6IEluCj4gPiA+IGZ1bmN0aW9uIOKAmGRjbjEwX2FwcGx5X2N0eF9mb3Jf
c3VyZmFjZeKAmToKPiA+ID4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9k
Yy9kY24xMC9kY24xMF9od19zZXF1ZW5jZXIuYzoyMzc4OjM6Cj4gPiA+IGVycm9yOiBpbXBsaWNp
dCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJh1ZGVsYXnigJkKPiA+ID4gWy1XZXJyb3I9aW1w
bGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCj4gPiA+ICAgIHVkZWxheSh1bmRlcmZsb3dfY2hl
Y2tfZGVsYXlfdXMpOwo+ID4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBIYXJpcHJhc2FkIEtlbGFt
IDxoYXJpcHJhc2FkLmtlbGFtQGdtYWlsLmNvbT4KPiA+IAo+ID4gV2hhdCBicmFuY2ggaXMgdGhp
cyBwYXRjaCBiYXNlZCBvbj8KPiA+IAo+ID4gQWxleAo+IAo+IEhpIEFsZXgsCj4gCj4gSXQgaXMg
b24gbGludXgtbmV4dAoKZHJtLW1pc2MtbmV4dCBoYXMgU2FtJ3MgaGVhZGVyIGNsZWFudXAuIEkg
Z3Vlc3Mgd2UgcHVsbCBsaW51eC9kZWxheS5oIGluCmltcGxpY2l0bHkgc29tZXdoZXJlLCBidXQg
bm90IGZvciBhbGwgY29uZmlncy4KLURhbmllbAoKPiAKPiBUaGFua3MsCj4gSGFyaXByYXNhZCBr
Cj4gPiA+IC0tLQo+ID4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2Rj
bjEwX2h3X3NlcXVlbmNlci5jIHwgMSArCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykKPiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kY24xMC9kY24xMF9od19zZXF1ZW5jZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kY24xMC9kY24xMF9od19zZXF1ZW5jZXIuYwo+ID4gPiBpbmRleCBkMjM1Mjk0OS4u
MWFjOWE0ZiAxMDA2NDQKPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RjbjEwL2RjbjEwX2h3X3NlcXVlbmNlci5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9od19zZXF1ZW5jZXIuYwo+ID4gPiBAQCAtMjMsNiAr
MjMsNyBAQAo+ID4gPiAgICoKPiA+ID4gICAqLwo+ID4gPgo+ID4gPiArI2luY2x1ZGUgPGxpbnV4
L2RlbGF5Lmg+Cj4gPiA+ICAjaW5jbHVkZSAiZG1fc2VydmljZXMuaCIKPiA+ID4gICNpbmNsdWRl
ICJjb3JlX3R5cGVzLmgiCj4gPiA+ICAjaW5jbHVkZSAicmVzb3VyY2UuaCIKPiA+ID4gLS0KPiA+
ID4gMi43LjQKPiA+ID4KPiA+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KPiA+ID4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiA+ID4gYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKPiA+ID4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4CgotLSAKRGFuaWVsIFZldHRlcgpTb2Z0d2FyZSBFbmdpbmVl
ciwgSW50ZWwgQ29ycG9yYXRpb24KaHR0cDovL2Jsb2cuZmZ3bGwuY2gKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApk
cmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
