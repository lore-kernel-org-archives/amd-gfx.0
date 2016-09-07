From: Huang Rui <ray.huang@amd.com>
Subject: Re: [Updated PATCH v2] drm: modify drm_global_item_ref to avoid two
 times of writing ref->object
Date: Wed, 7 Sep 2016 16:48:35 +0800
Message-ID: <20160907084835.GA13883@hr-amur2>
References: <1473225871-2847-1-git-send-email-ray.huang@amd.com>
 <88949438-6e9e-502c-a543-9ca374411b1c@amd.com>
 <20160907075435.GA13516@hr-amur2>
 <8e0116fa-6f4c-ea4f-5e59-73cb98a543bf@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <8e0116fa-6f4c-ea4f-5e59-73cb98a543bf@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Wang, Ken" <Ken.Wang@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gV2VkLCBTZXAgMDcsIDIwMTYgYXQgMDQ6MDI6NDdQTSArMDgwMCwgS29lbmlnLCBDaHJpc3Rp
YW4gd3JvdGU6Cj4gQW0gMDcuMDkuMjAxNiB1bSAwOTo1NCBzY2hyaWViIEh1YW5nIFJ1aToKPiA+
IE9uIFdlZCwgU2VwIDA3LCAyMDE2IGF0IDA5OjEyOjI5QU0gKzAyMDAsIENocmlzdGlhbiBLP25p
ZyB3cm90ZToKPiA+PiBBbSAwNy4wOS4yMDE2IHVtIDA3OjI0IHNjaHJpZWIgSHVhbmcgUnVpOgoK
c25pcC4KCj4gPj4+ICAgCSsraXRlbS0+cmVmY291bnQ7Cj4gPj4+IC0JcmVmLT5vYmplY3QgPSBp
dGVtLT5vYmplY3Q7Cj4gPj4+IC0JbXV0ZXhfdW5sb2NrKCZpdGVtLT5tdXRleCk7Cj4gPj4+IC0J
cmV0dXJuIDA7Cj4gPj4+ICsJZ290byBvdXQ7Cj4gPj4gQSBnb3RvIGluIHRoZSBub3QgZXJyb3Ig
cGF0aCBpcyBhIGJpdCB1bnVzdWFsLiBTaW5jZSBvdXRfZXJyIGlzIG9ubHkKPiA+PiB1c2VkIG9u
Y2UgY291bGRuJ3QgeW91IGp1c3QgbW92ZSB0aGUgY29kZSBpbnRvIHRoZSBpZiBhbmQgdGhlbiBn
b3RvCj4gPj4gdG8gb3V0IGFzIHdlbGw/Cj4gPj4KPiA+PiBBbHRlcm5hdGl2ZSB5b3UgY291bGQg
anVzdCBkdXBsaWNhdGUgdGhlIG11dGV4IHJlbGVhc2UgaW4gdGhlCj4gPj4gbm9uLWVycm9yIHBh
dGguCj4gPj4KPiA+IEFjdHVhbGx5LCBJIGFsc28gaGF2ZSBhIGxpdHRsZSBjb25jZXJuIHdpdGgg
ImdvdG8iIGluIG5vbi1lcnJvciBwYXRoLiBCdXQKPiA+IGFzIFNlYW4ncyBzdWdnZXN0aW9uLCB1
c2UgImdvdG8iIGNhbiBhdm9pZCBhIGR1cGxpY2F0ZSBtdXRleCByZWxlYXNlLCB5b3UKPiA+IGtu
b3cuCj4gCj4gSSB3b3VsZCBjZXJ0YWlubHkgcHJlZmVyIHRoZSBkdXBsaWNhdGUgbXV0ZXggcmVs
ZWFzZS4KPiAKPiA+Cj4gPiBAU2VhbiwgaWYgeW91IGRvbid0IGhhdmUgY29uY2VybiB3aXRoIGFk
ZGluZyBhIG11dGV4IHJlbGVhc2UgYmVsb3csIEkgd2lsbAo+ID4gdXBkYXRlIGl0IGluIFYzLgo+
ID4KPiA+IC0tLQo+ID4gICAgICAgICAgKytpdGVtLT5yZWZjb3VudDsKPiA+ICAgICAgICAgIG11
dGV4X3VubG9jaygmaXRlbS0+bXV0ZXgpOwo+ID4gICAgICAgICAgcmV0dXJuIDA7Cj4gPgo+ID4g
b3V0X2VycjoKPiA+ICAgICAgICAgIGtmcmVlKHJlZi0+b2JqZWN0KTsKPiA+ICAgICAgICAgIHJl
Zi0+b2JqZWN0ID0gTlVMTDsKPiA+IG91dDoKPiAKPiBCVFc6IEkgd291bGQgbmFtZSB0aG9zZSBs
YWJlbHMgZXJyb3JfZnJlZSBhbmQgZXJyb3JfdW5sb2NrIHRvIG1ha2UgY2xlYXIgCj4gdGhhdCB0
aGV5IGFyZSBmb3IgZXJyb3IgaGFuZGxpbmcgYW5kIHdoYXQgdGhleSBhcmUgc3VwcG9zZWQgdG8g
ZG8uCj4gCgpPSywgd2lsbCByZW5hbWUgdGhlIGxhYmVsIGluIFYzLgoKVGhhbmtzLApSdWkKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1h
aWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
