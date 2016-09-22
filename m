From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/i915: Before pageflip, also wait for shared dmabuf
 fences.
Date: Thu, 22 Sep 2016 08:36:25 +0200
Message-ID: <20160922063625.GD22164@dvetter-linux.ger.corp.intel.com>
References: <9c0f86d0-eb23-7110-c663-01859132ac83@vodafone.de>
 <7aafce92-8bcf-1c5c-45de-9e8ecda85239@daenzer.net>
 <554f660d-cc8d-295e-42aa-c374e95bdc8a@vodafone.de>
 <CAKMK7uG3j54NzwjxmWuSmP787r+QN-Cu5T8R-naX6S9RvvKemw@mail.gmail.com>
 <30238c60-f797-afa6-8fd0-7e6dec27e8e9@vodafone.de>
 <CAKMK7uH6N2Kgwkf-11iwdqDAUrFmreYKLLeTGXmEh+N0DQ4tJg@mail.gmail.com>
 <9d1f4872-cabd-bd1b-7f10-6e4230a1f58c@daenzer.net>
 <5c2048ff-0e20-ddf3-2d73-9a3acb38e7ff@vodafone.de>
 <5f57e486-ecda-9fc9-7d08-3855e3080186@daenzer.net>
 <3f4643cb-52a9-d7ae-439b-5f6fc6e718cc@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <3f4643cb-52a9-d7ae-439b-5f6fc6e718cc@vodafone.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <deathsimple@vodafone.de>
Cc: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, dri-devel <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gV2VkLCBTZXAgMjEsIDIwMTYgYXQgMDY6MjM6MzVQTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiBGb3IgYSBxdWljayB3b3JrYXJvdW5kIEkgc3VnZ2VzdCB0byBqdXN0IHNlcmlh
bGl6ZSBhbGwgYWNjZXNzZXMgdG8gQk8gc2hhcmVkCj4gd2l0aCBkaWZmZXJlbnQgZHJpdmVycywg
YnV0IGVzc2VudGlhbGx5IEkgdGhpbmsgaXQgaXMgYSBwZXJmZWN0bHkgdmFsaWQKPiByZXF1aXJl
bWVudCB0byBoYXZlIG11bHRpcGxlIHdyaXRlcnMgdG8gb25lIEJPLgoKSXQgaXMsIGJ1dCBpdCdz
IG5vdCBwb3NzaWJsZSB3aXRoIGltcGxpY2l0IHN5bmMuIElmIHlvdSB3YW50IHBhcmFsbGVsCndy
aXRlIGFjY2VzcyB0byB0aGUgc2FtZSBzaGFyZWQgYnVmZmVyLCB5b3UgX211c3RfIGNhcnJ5IGFy
b3VuZCBzb21lCmV4cGxpY2l0IGZlbmNlcy4gV2l0aGluIGFtZGdwdSB5b3UgY2FuIHVzZSBkcml2
ZXItc3BlY2lmaWMgY29va2llcywgZm9yCnNoYXJlZCBidWZmZXIgd2Ugbm93IGhhdmUgc3luY19m
aWxlLiBCdXQgbXVsdGlwbGUgd3JpdGVycyB3aXRoIGltcGxpY2l0CnN5bmMgc2ltcGx5IGZ1bmRh
bWVudGFsbHkgZG9lc24ndCB3b3JrLiBCZWNhdXNlIHlvdSBoYXZlIG5vIGlkZWEgd2l0aCB3aGlj
aAp3cml0ZXIsIHRvdWNoaW5nIHRoZSBzYW1lIHN1YnJhbmdlIHlvdSB3YW50IHRvIHRvdWNoLgot
RGFuaWVsCi0tIApEYW5pZWwgVmV0dGVyClNvZnR3YXJlIEVuZ2luZWVyLCBJbnRlbCBDb3Jwb3Jh
dGlvbgpodHRwOi8vYmxvZy5mZndsbC5jaApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9kcmktZGV2ZWwK
