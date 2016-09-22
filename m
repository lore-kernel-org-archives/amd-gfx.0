From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/vce: allow the clock table packet
Date: Thu, 22 Sep 2016 09:07:37 +0200
Message-ID: <0282888e-57fb-15f5-75dc-fcb8b901e6b5@vodafone.de>
References: <1474490176-1718-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1474490176-1718-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

QW0gMjEuMDkuMjAxNiB1bSAyMjozNiBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBUaGlzIHBhY2tl
dCBhbGxvd3MgdGhlIHVzZXIgbW9kZSBkcml2ZXIgdG8gc3BlY2lmeQo+IHRoZSByZXF1aXJlZCBw
ZXJmb3JtYW5jZSBmb3Igc3BlY2lmaWMgdXNlIGNhc2VzLgo+Cj4gU2lnbmVkLW9mZi1ieTogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlz
dGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNlLmMgfCAxICsKPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92Y2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y2Uu
Ywo+IGluZGV4IDJjOWVhOWIuLjA2Yjk0YzEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZjZS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZjZS5jCj4gQEAgLTY5MSw2ICs2OTEsNyBAQCBpbnQgYW1kZ3B1X3ZjZV9yaW5n
X3BhcnNlX2NzKHN0cnVjdCBhbWRncHVfY3NfcGFyc2VyICpwLCB1aW50MzJfdCBpYl9pZHgpCj4g
ICAJCWNhc2UgMHgwNDAwMDAwODogLyogcmRvICovCj4gICAJCWNhc2UgMHgwNDAwMDAwOTogLyog
dnVpICovCj4gICAJCWNhc2UgMHgwNTAwMDAwMjogLyogYXV4aWxpYXJ5IGJ1ZmZlciAqLwo+ICsJ
CWNhc2UgMHgwNTAwMDAwOTogLyogY2xvY2sgdGFibGUgKi8KPiAgIAkJCWJyZWFrOwo+ICAgCj4g
ICAJCWNhc2UgMHgwMzAwMDAwMTogLyogZW5jb2RlICovCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
