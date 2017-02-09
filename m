From: Samuel Pitoiset <samuel.pitoiset-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: report the number of bytes moved at
 buffer creation
Date: Thu, 9 Feb 2017 11:26:54 +0100
Message-ID: <6b2d6ac3-0603-47ad-51f8-6cc638484247@gmail.com>
References: <20170208233518.1334-1-samuel.pitoiset@gmail.com>
 <20170208233518.1334-2-samuel.pitoiset@gmail.com>
 <46a014c2-9fff-ba34-3508-b0444aa49354@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <46a014c2-9fff-ba34-3508-b0444aa49354-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

CgpPbiAwMi8wOS8yMDE3IDAxOjU4IEFNLCBNaWNoZWwgRMOkbnplciB3cm90ZToKPiBPbiAwOS8w
Mi8xNyAwODozNSBBTSwgU2FtdWVsIFBpdG9pc2V0IHdyb3RlOgo+PiBMaWtlIHR0bV9ib192YWxp
ZGF0ZSgpLCB0dG1fYm9faW5pdCgpIG1pZ2h0IG5lZWQgdG8gbW92ZSBCTyBhbmQKPj4gdGhlIG51
bWJlciBvZiBieXRlcyBtb3ZlZCBieSBUVE0gc2hvdWxkIGJlIHJlcG9ydGVkLiBUaGlzIGNhbiBo
ZWxwCj4+IHRoZSB0aHJvdHRsZSBidWZmZXIgbWlncmF0aW9uIG1lY2hhbmlzbSB0byBtYWtlIGEg
YmV0dGVyIGRlY2lzaW9uLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBTYW11ZWwgUGl0b2lzZXQgPHNh
bXVlbC5waXRvaXNldEBnbWFpbC5jb20+Cj4KPiBbLi4uXQo+Cj4+IEBAIC0zOTksMTAgKzQwMCwx
NSBAQCBpbnQgYW1kZ3B1X2JvX2NyZWF0ZV9yZXN0cmljdGVkKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LAo+PiAgCQlsb2NrZWQgPSB3d19tdXRleF90cnlsb2NrKCZiby0+dGJvLnR0bV9yZXN2
LmxvY2spOwo+PiAgCQlXQVJOX09OKCFsb2NrZWQpOwo+PiAgCX0KPj4gKwo+PiArCWluaXRpYWxf
Ynl0ZXNfbW92ZWQgPSBhdG9taWM2NF9yZWFkKCZhZGV2LT5udW1fYnl0ZXNfbW92ZWQpOwo+PiAg
CXIgPSB0dG1fYm9faW5pdCgmYWRldi0+bW1hbi5iZGV2LCAmYm8tPnRibywgc2l6ZSwgdHlwZSwK
Pj4gIAkJCSZiby0+cGxhY2VtZW50LCBwYWdlX2FsaWduLCAha2VybmVsLCBOVUxMLAo+PiAgCQkJ
YWNjX3NpemUsIHNnLCByZXN2ID8gcmVzdiA6ICZiby0+dGJvLnR0bV9yZXN2LAo+PiAgCQkJJmFt
ZGdwdV90dG1fYm9fZGVzdHJveSk7Cj4+ICsJYW1kZ3B1X2NzX3JlcG9ydF9tb3ZlZF9ieXRlcyhh
ZGV2LAo+PiArCQlpbml0aWFsX2J5dGVzX21vdmVkIC0gYXRvbWljNjRfcmVhZCgmYWRldi0+bnVt
X2J5dGVzX21vdmVkKSk7Cj4KPiBUaGlzIGxvb2tzIGJhY2t3YXJkcywgc2hvdWxkIGJlCj4KPiAJ
CWF0b21pYzY0X3JlYWQoJmFkZXYtPm51bV9ieXRlc19tb3ZlZCkgLSBpbml0aWFsX2J5dGVzX21v
dmVkKTsKPgo+ID8KCk15IG1pc3Rha2UsIHRoYW5rcyBmb3Igbm90aWNpbmcuCgo+Cj4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
