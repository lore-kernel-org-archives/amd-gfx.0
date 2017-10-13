From: =?UTF-8?Q?Dieter_N=C3=BCtzel?= <Dieter-0hun7QTegEsDD4udEopG9Q@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Fix non-DCN build
Date: Fri, 13 Oct 2017 23:21:33 +0200
Message-ID: <a61aeeb8fdada8ca1fb799eb333ba50a@nuetzel-hh.de>
References: <20171013164400.19199-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171013164400.19199-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Cc: alexander.deucher-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTMuMTAuMjAxNyAxODo0NCwgc2NocmllYiBIYXJyeSBXZW50bGFuZDoKPiBBY3F1aXJlX2Zp
cnN0X3NwbGl0X3BpcGUgb25seSBtYWtlcyBzZW5zZSBmb3IgRENOLgo+IAo+IFNpZ25lZC1vZmYt
Ynk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgoKVGVzdGVkLWJ5OiBE
aWV0ZXIgTsO8dHplbCA8RGlldGVyQG51ZXR6ZWwtaGguZGU+Cgo+IC0tLQo+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19yZXNvdXJjZS5jIHwgMiArKwo+ICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX3Jlc291cmNlLmMKPiBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9jb3JlL2RjX3Jlc291cmNlLmMKPiBpbmRleCAyYTVjOTE3NzI0NzMuLjU1
ZmViMTZiMWZkNyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
Y29yZS9kY19yZXNvdXJjZS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2NvcmUvZGNfcmVzb3VyY2UuYwo+IEBAIC0xNjg0LDggKzE2ODQsMTAgQEAgZW51bSBkY19zdGF0
dXMgcmVzb3VyY2VfbWFwX3Bvb2xfcmVzb3VyY2VzKAo+ICAJLyogYWNxdWlyZSBuZXcgcmVzb3Vy
Y2VzICovCj4gIAlwaXBlX2lkeCA9IGFjcXVpcmVfZmlyc3RfZnJlZV9waXBlKCZjb250ZXh0LT5y
ZXNfY3R4LCBwb29sLCBzdHJlYW0pOwo+IAo+ICsjaWZkZWYgQ09ORklHX0RSTV9BTURfRENfRENO
MV8wCj4gIAlpZiAocGlwZV9pZHggPCAwKQo+ICAJCXBpcGVfaWR4ID0gYWNxdWlyZV9maXJzdF9z
cGxpdF9waXBlKCZjb250ZXh0LT5yZXNfY3R4LCBwb29sLCAKPiBzdHJlYW0pOwo+ICsjZW5kaWYK
PiAKPiAgCWlmIChwaXBlX2lkeCA8IDApCj4gIAkJcmV0dXJuIERDX05PX0NPTlRST0xMRVJfUkVT
T1VSQ0U7Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
