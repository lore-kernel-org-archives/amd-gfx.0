From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/i915: Before pageflip,
 also wait for shared dmabuf fences.
Date: Wed, 21 Sep 2016 13:04:39 +0200
Message-ID: <CAKMK7uG3j54NzwjxmWuSmP787r+QN-Cu5T8R-naX6S9RvvKemw@mail.gmail.com>
References: <1473293683-6247-1-git-send-email-mario.kleiner.de@gmail.com>
 <20160908063038.GB28919@nuc-i3427.alporthouse.com>
 <9e28ae2e-ed2f-ef0e-8690-1f78f5aed18b@gmail.com>
 <20160908162346.GA5479@nuc-i3427.alporthouse.com>
 <abccc8ac-10c6-ab22-c59d-f43ee48ba78d@daenzer.net>
 <bdd0653d-e4d6-fbbe-89f1-b1104682bf02@vodafone.de>
 <20160913093945.GA25204@nuc-i3427.alporthouse.com>
 <9c0f86d0-eb23-7110-c663-01859132ac83@vodafone.de>
 <7aafce92-8bcf-1c5c-45de-9e8ecda85239@daenzer.net>
 <554f660d-cc8d-295e-42aa-c374e95bdc8a@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <554f660d-cc8d-295e-42aa-c374e95bdc8a@vodafone.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple@vodafone.de>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>, amd-gfx list <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gV2VkLCBTZXAgMjEsIDIwMTYgYXQgMTI6MzAgUE0sIENocmlzdGlhbiBLw7ZuaWcKPGRlYXRo
c2ltcGxlQHZvZGFmb25lLmRlPiB3cm90ZToKPiBBbSAyMS4wOS4yMDE2IHVtIDExOjU2IHNjaHJp
ZWIgTWljaGVsIETDpG56ZXI6Cj4+Cj4+Cj4+IExvb2tzIGxpa2UgdGhlcmUgYXJlIGRpZmZlcmVu
dCBpbnRlcnByZXRhdGlvbnMgb2YgdGhlIHNlbWFudGljcyBvZgo+PiBleGNsdXNpdmUgdnMuIHNo
YXJlZCBmZW5jZXMuIFdoZXJlIGFyZSB0aGVzZSBzZW1hbnRpY3MgZG9jdW1lbnRlZD8KPgo+Cj4g
WWVhaCwgSSB0aGluayBhcyB3ZWxsIHRoYXQgdGhpcyBpcyB0aGUgcHJpbWFyeSBxdWVzdGlvbiBo
ZXJlLgo+Cj4gSUlSQyB0aGUgZmVuY2VzIHdlcmUgZXhwbGljaXRseSBjYWxsZWQgZXhjbHVzaXZl
L3NoYXJlZCBpbnN0ZWFkIG9mCj4gd3JpdGluZy9yZWFkaW5nIG9uIHB1cnBvc2UuCj4KPiBJIGFi
c29sdXRlbHkgZG9uJ3QgbWluZCBzd2l0Y2hpbmcgdG8gdGhlbSB0byB3cml0aW5nL3JlYWRpbmcg
c2VtYW50aWNzLCBidXQKPiBhbWRncHUgcmVhbGx5IG5lZWRzIG11bHRpcGxlIHdyaXRlcnMgYXQg
dGhlIHNhbWUgdGltZS4KPgo+IFNvIGluIHRoaXMgY2FzZSB0aGUgd3JpdGluZyBzaWRlIG9mIGEg
cmVzZXJ2YXRpb24gb2JqZWN0IG5lZWRzIHRvIGJlIGEKPiBjb2xsZWN0aW9uIG9mIGZlbmNlcyBh
cyB3ZWxsLgoKWW91IGNhbid0IGhhdmUgbXVsdGlwbGUgd3JpdGVycyB3aXRoIGltcGxpY2l0IHN5
bmNpbmcuIFRoYXQgY29uZnVzaW9uCmlzIGV4YWN0bHkgd2h5IHdlIGNhbGxlZCB0aGVtIHNoYXJl
ZC9leGNsdXNpdmUuIE11bHRpcGxlIHdyaXRlcnMKZ2VuZXJhbGx5IG1lYW5zIHRoYXQgeW91IGRv
IHNvbWUgZm9ybSBvZiBmZW5jaW5nIGluIHVzZXJzcGFjZQoodW5zeW5jJ2VkIGdsIGJ1ZmZlciBh
Y2Nlc3MgaXMgdGhlIGNvbW1vbiBvbmUpLiBXaGF0IHlvdSBkbyBmb3IKcHJpdmF0ZSBidWZmZXJz
IGRvZXNuJ3QgbWF0dGVyLCBidXQgd2hlbiB5b3UgcmVuZGVyIGludG8gYQpzaGFyZWQvd2luc3lz
IGJ1ZmZlciB5b3UgcmVhbGx5IG5lZWQgdG8gc2V0IHRoZSBleGNsdXNpdmUgZmVuY2UgKGFuZAp0
aGVyZSBjYW4gb25seSBldmVyIGJlIG9uZSkuIFNvIHByb2JhYmx5IG5lZWRzIHNvbWUgdXNlcnNw
YWNlCmFkanVzdG1lbnRzIHRvIG1ha2Ugc3VyZSB5b3UgZG9uJ3QgYWNjaWRlbnRhbGx5IHNldCBh
biBleGNsdXNpdmUgd3JpdGUKaGF6YXJkIHdoZW4geW91IGRvbid0IHJlYWxseSB3YW50IHRoYXQg
aW1wbGljaXQgc3luYy4KLURhbmllbAotLSAKRGFuaWVsIFZldHRlcgpTb2Z0d2FyZSBFbmdpbmVl
ciwgSW50ZWwgQ29ycG9yYXRpb24KKzQxICgwKSA3OSAzNjUgNTcgNDggLSBodHRwOi8vYmxvZy5m
ZndsbC5jaApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpk
cmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
