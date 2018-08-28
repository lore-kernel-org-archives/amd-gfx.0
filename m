From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 05/10] drm/amdgpu: put GART away from VRAM
Date: Tue, 28 Aug 2018 10:01:00 +0800
Message-ID: <5B84ACDC.6070200@amd.com>
References: <20180827165337.1651-1-christian.koenig@amd.com>
 <20180827165337.1651-5-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180827165337.1651-5-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDgvMjgvMjAxOCAxMjo1MyBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbHdheXMg
dHJ5IHRvIHB1dCB0aGUgR0FSVCBhd2F5IGZyb20gd2hlcmUgVlJBTSBpcy4KPgo+IFNpZ25lZC1v
ZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiAtLS0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYyB8IDIgKy0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYwo+IGluZGV4IDI2NWVjNjgwNzEzMC4uNDMzMWEw
ZTI1Y2RjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9n
bWMuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYwo+IEBA
IC0xMzYsNyArMTM2LDcgQEAgdm9pZCBhbWRncHVfZ21jX2dhcnRfbG9jYXRpb24oc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfZ21jICptYykKPiAgIAkgICAgKHNpemVf
YWYgPCBtYy0+Z2FydF9zaXplKSkKPiAgIAkJbWMtPmdhcnRfc3RhcnQgPSAwOwo+ICAgCWVsc2UK
PiAtCQltYy0+Z2FydF9zdGFydCA9IEFMSUdOKG1jLT52cmFtX2VuZCArIDEsIDB4MTAwMDAwMDAw
VUxMKTsKPiArCQltYy0+Z2FydF9zdGFydCA9IG1jLT5tY19tYXNrIC0gbWMtPmdhcnRfc2l6ZSAr
IDE7CgppdCBzZWVtcyB0byBicmVhayB0aGUgVkNFIGxpbWl0YXRpb24gYWJvdXQgNEcgYWxpZ25t
ZW50PwoKSmVycnkKCj4gICAJbWMtPmdhcnRfZW5kID0gbWMtPmdhcnRfc3RhcnQgKyBtYy0+Z2Fy
dF9zaXplIC0gMTsKPiAgIAlkZXZfaW5mbyhhZGV2LT5kZXYsICJHQVJUOiAlbGx1TSAweCUwMTZs
bFggLSAweCUwMTZsbFhcbiIsCj4gICAJCQltYy0+Z2FydF9zaXplID4+IDIwLCBtYy0+Z2FydF9z
dGFydCwgbWMtPmdhcnRfZW5kKTsKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
