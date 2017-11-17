From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display/dc/core/dc_resource: use swap macro in
 rect_swap_helper
Date: Fri, 17 Nov 2017 10:45:51 -0500
Message-ID: <179346a7-d49d-60cd-9b6d-b7394a770641@amd.com>
References: <20171110223813.GA32508@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171110223813.GA32508-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>
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
To: "Gustavo A. R. Silva" <garsilva-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

T24gMjAxNy0xMS0xMCAwNTozOCBQTSwgR3VzdGF2byBBLiBSLiBTaWx2YSB3cm90ZToKPiBNYWtl
IHVzZSBvZiB0aGUgc3dhcCBtYWNybyBpbnN0ZWFkIG9mIF9tYW51YWxseV8gc3dhcHBpbmcgdmFs
dWVzCj4gYW5kIHJlbW92ZSB1bm5lY2Vzc2FyeSB2YXJpYWJsZSB0ZW1wLgo+IAo+IFRoaXMgbWFr
ZXMgdGhlIGNvZGUgZWFzaWVyIHRvIHJlYWQgYW5kIG1haW50YWluLgo+IAo+IFRoaXMgY29kZSB3
YXMgZGV0ZWN0ZWQgd2l0aCB0aGUgaGVscCBvZiBDb2NjaW5lbGxlLgo+IAo+IFNpZ25lZC1vZmYt
Ynk6IEd1c3Rhdm8gQS4gUi4gU2lsdmEgPGdhcnNpbHZhQGVtYmVkZGVkb3IuY29tPgoKUmV2aWV3
ZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgoKSGFycnkKCj4g
LS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX3Jlc291cmNlLmMg
fCAxMSArKy0tLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA5IGRl
bGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvY29yZS9kY19yZXNvdXJjZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Nv
cmUvZGNfcmVzb3VyY2UuYwo+IGluZGV4IGQxY2RmOWYuLmVlMjE2ZjIgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfcmVzb3VyY2UuYwo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX3Jlc291cmNlLmMKPiBAQCAt
NDI2LDE1ICs0MjYsOCBAQCBzdGF0aWMgZW51bSBwaXhlbF9mb3JtYXQgY29udmVydF9waXhlbF9m
b3JtYXRfdG9fZGFsc3VyZmFjZSgKPiAgCj4gIHN0YXRpYyB2b2lkIHJlY3Rfc3dhcF9oZWxwZXIo
c3RydWN0IHJlY3QgKnJlY3QpCj4gIHsKPiAtCXVpbnQzMl90IHRlbXAgPSAwOwo+IC0KPiAtCXRl
bXAgPSByZWN0LT5oZWlnaHQ7Cj4gLQlyZWN0LT5oZWlnaHQgPSByZWN0LT53aWR0aDsKPiAtCXJl
Y3QtPndpZHRoID0gdGVtcDsKPiAtCj4gLQl0ZW1wID0gcmVjdC0+eDsKPiAtCXJlY3QtPnggPSBy
ZWN0LT55Owo+IC0JcmVjdC0+eSA9IHRlbXA7Cj4gKwlzd2FwKHJlY3QtPmhlaWdodCwgcmVjdC0+
d2lkdGgpOwo+ICsJc3dhcChyZWN0LT54LCByZWN0LT55KTsKPiAgfQo+ICAKPiAgc3RhdGljIHZv
aWQgY2FsY3VsYXRlX3ZpZXdwb3J0KHN0cnVjdCBwaXBlX2N0eCAqcGlwZV9jdHgpCj4gCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
