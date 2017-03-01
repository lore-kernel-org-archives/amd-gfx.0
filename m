From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 14/15] drm/amd/display: Enable warnings as errors
Date: Wed, 1 Mar 2017 10:19:08 +0900
Message-ID: <b5699930-3477-ba63-af03-5909e1d5bff0@daenzer.net>
References: <20170301002620.24595-1-harry.wentland@amd.com>
 <20170301002620.24595-15-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170301002620.24595-15-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDEvMDMvMTcgMDk6MjYgQU0sIEhhcnJ5IFdlbnRsYW5kIHdyb3RlOgo+IENoYW5nZS1JZDog
STQ4ZDM4ZTRkMDIyNGM5ZjBlNTIwNTViM2M0ZGRlZjhlODcyYjNkYWMKPiBTaWduZWQtb2ZmLWJ5
OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KPiBBY2tlZC1ieTogSGFy
cnkgV2VudGxhbmQgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+Cj4gUmV2aWV3ZWQtYnk6IEpvcmRh
biBMYXphcmUgPEpvcmRhbi5MYXphcmVAYW1kLmNvbT4KPiBSZXZpZXdlZC1ieTogVG9ueSBDaGVu
ZyA8VG9ueS5DaGVuZ0BhbWQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvTWFrZWZpbGUgfCAyICsrCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPiAK
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L01ha2VmaWxlIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L01ha2VmaWxlCj4gaW5kZXggOGJhMzdkZDljZjdmLi5j
MjI0NzViNTU1ODYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L01h
a2VmaWxlCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L01ha2VmaWxlCj4gQEAg
LTUsNiArNSw4IEBACj4gIAo+ICBBTUREQUxQQVRIID0gJChSRUxBVElWRV9BTURfRElTUExBWV9Q
QVRIKQo+ICAKPiArc3ViZGlyLWNjZmxhZ3MteSArPSAtV2Vycm9yCgpQbGVhc2UgZG9uJ3QuIFRo
aXMgd2lsbCByZXN1bHQgaW4gY29tcGlsZSBmYWlsdXJlcyBmb3IgcGVvcGxlIHdpdGgKZGlmZmVy
ZW50IGNvbXBpbGVyIHZlcnNpb25zLCBpbmNsdWRpbmcgeW91ciBmdXR1cmUgc2VsdmVzLgoKCi0t
IApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAg
aHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAg
fCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
