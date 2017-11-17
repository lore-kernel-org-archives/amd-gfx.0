From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] Revert "drm/radeon: dont switch vt on suspend"
Date: Fri, 17 Nov 2017 10:03:44 +0100
Message-ID: <0b5ff2af-fb8b-f1f5-d557-82f248e8ca76@daenzer.net>
References: <20171114223300.28026-1-alexander.deucher@amd.com>
 <CADnq5_OxTjUh5a_EVNAMn9+GjCak+tKxgxYhXBAVD=nhOWcnsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_OxTjUh5a_EVNAMn9+GjCak+tKxgxYhXBAVD=nhOWcnsQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-CA
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "for 3.8" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMTYvMTEvMTcgMDc6MDkgUE0sIEFsZXggRGV1Y2hlciB3cm90ZToKPiBQaW5nPwo+IAo+IAo+
IE9uIFR1ZSwgTm92IDE0LCAyMDE3IGF0IDU6MzMgUE0sIEFsZXggRGV1Y2hlciA8YWxleGRldWNo
ZXJAZ21haWwuY29tPiB3cm90ZToKPj4gRml4ZXMgZGlzdG9ydGVkIGNvbG9ycyBvbiBzb21lIGNh
cmRzIG9uIHJlc3VtZSBmcm9tIHN1c3BlbmQuCj4+Cj4+IFRoaXMgcmV2ZXJ0cyBjb21taXQgYjk3
MjliMTdhNDE0Zjk5YzYxZjRkYjlhYzlmOWVkOTg3ZmEwY2JmZS4KPj4KPj4gQnVnOiBodHRwczov
L2J1Z3MuZnJlZWRlc2t0b3Aub3JnL3Nob3dfYnVnLmNnaT9pZD05ODgzMgo+PiBTaWduZWQtb2Zm
LWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4+IENjOiBzdGFi
bGVAdmdlci5rZXJuZWwub3JnCj4+IC0tLQo+PiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRl
b25fZmIuYyB8IDEgLQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2ZiLmMgYi9kcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl9mYi5jCj4+IGluZGV4IDJmY2Y4MDVkM2ExNi4uMzNiODIxZDZk
MDE4IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9mYi5jCj4+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2ZiLmMKPj4gQEAgLTI0NSw3ICsy
NDUsNiBAQCBzdGF0aWMgaW50IHJhZGVvbmZiX2NyZWF0ZShzdHJ1Y3QgZHJtX2ZiX2hlbHBlciAq
aGVscGVyLAo+PiAgICAgICAgIH0KPj4KPj4gICAgICAgICBpbmZvLT5wYXIgPSByZmJkZXY7Cj4+
IC0gICAgICAgaW5mby0+c2tpcF92dF9zd2l0Y2ggPSB0cnVlOwo+Pgo+PiAgICAgICAgIHJldCA9
IHJhZGVvbl9mcmFtZWJ1ZmZlcl9pbml0KHJkZXYtPmRkZXYsICZyZmJkZXYtPnJmYiwgJm1vZGVf
Y21kLCBnb2JqKTsKPj4gICAgICAgICBpZiAocmV0KSB7CgpSZXZpZXdlZC1ieTogTWljaGVsIETD
pG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOk
bnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGli
cmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5k
IFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
