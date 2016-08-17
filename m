From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH xf86-video-amdgpu] Remove unused lut_r/g/b arrays from
 drmmode_crtc_private_rec
Date: Wed, 17 Aug 2016 10:23:04 -0400
Message-ID: <CADnq5_Mt9H8G=juB9NWw_iH-3aecT0N94=8VUAOpMjAd=tfNNw@mail.gmail.com>
References: <20160817095821.15018-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160817095821.15018-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gV2VkLCBBdWcgMTcsIDIwMTYgYXQgNTo1OCBBTSwgTWljaGVsIETDpG56ZXIgPG1pY2hlbEBk
YWVuemVyLm5ldD4gd3JvdGU6Cj4gRnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVy
QGFtZC5jb20+Cj4KPiBGaXhlczogMTA5MWYyOGUxZmEyICgiUmVtb3ZlIGRybW1vZGVfbG9hZF9w
YWxldHRlIikKPiBTaWduZWQtb2ZmLWJ5OiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJA
YW1kLmNvbT4KClJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+Cgo+IC0tLQo+ICBzcmMvZHJtbW9kZV9kaXNwbGF5LmggfCAxIC0KPiAgMSBmaWxlIGNo
YW5nZWQsIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9zcmMvZHJtbW9kZV9kaXNwbGF5
LmggYi9zcmMvZHJtbW9kZV9kaXNwbGF5LmgKPiBpbmRleCA2MTdmMmJjLi4yZTYyYThjIDEwMDY0
NAo+IC0tLSBhL3NyYy9kcm1tb2RlX2Rpc3BsYXkuaAo+ICsrKyBiL3NyYy9kcm1tb2RlX2Rpc3Bs
YXkuaAo+IEBAIC05Miw3ICs5Miw2IEBAIHR5cGVkZWYgc3RydWN0IHsKPiAgICAgICAgIHVpbnQz
Ml90IGRwbXNfbGFzdF9zZXE7Cj4gICAgICAgICBpbnQgZHBtc19sYXN0X2ZwczsKPiAgICAgICAg
IHVpbnQzMl90IGludGVycG9sYXRlZF92YmxhbmtzOwo+IC0gICAgICAgdWludDE2X3QgbHV0X3Jb
MjU2XSwgbHV0X2dbMjU2XSwgbHV0X2JbMjU2XTsKPiAgICAgICAgIGludCBwcmltZV9waXhtYXBf
eDsKPgo+ICAgICAgICAgLyogTW9kZXNldCBuZWVkZWQgZm9yIERQTVMgb24gKi8KPiAtLQo+IDIu
OS4zCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
