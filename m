From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] drm: add func to better detect wether swiotlb is needed
Date: Wed, 27 Feb 2019 14:25:50 -0500
Message-ID: <20190227192550.GB24946@char.us.oracle.com>
References: <1550617692-27306-1-git-send-email-michael.d.labriola@gmail.com>
 <ba6812cbb26341bd9b5d3a0981f7d64b@AMSPEX02CL03.citrite.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <ba6812cbb26341bd9b5d3a0981f7d64b@AMSPEX02CL03.citrite.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Paul Durrant <Paul.Durrant@citrix.com>
Cc: Juergen Gross <jgross@suse.com>, Andrew Cooper <Andrew.Cooper3@citrix.com>, 'Michael D Labriola' <michael.d.labriola@gmail.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>, Christoph Hellwig <hch@infradead.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Jan Beulich <JBeulich@suse.com>, Alex Deucher <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, Monk Liu <monk.liu@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

LnNuaXAuLgo+ID4gLXU2NCBkcm1fZ2V0X21heF9pb21lbSh2b2lkKQo+ID4gK2Jvb2wgZHJtX25l
ZWRfc3dpb3RsYihpbnQgZG1hX2JpdHMpCj4gPiAgewo+ID4gIAlzdHJ1Y3QgcmVzb3VyY2UgKnRt
cDsKPiA+ICAJcmVzb3VyY2Vfc2l6ZV90IG1heF9pb21lbSA9IDA7Cj4gPiAKPiA+ICsJLyoKPiA+
ICsJICogWGVuIHBhcmF2aXJ0dWFsIGhvc3RzIHJlcXVpcmUgc3dpb3RsYiByZWdhcmRsZXNzIG9m
IHJlcXVlc3RlZCBkbWEKPiA+ICsJICogdHJhbnNmZXIgc2l6ZS4KPiA+ICsJICoKPiA+ICsJICog
Tk9URTogUmVhbGx5LCB3aGF0IGl0IHJlcXVpcmVzIGlzIHVzZSBvZiB0aGUgZG1hX2FsbG9jX2Nv
aGVyZW50Cj4gPiArCSAqICAgICAgIGFsbG9jYXRvciB1c2VkIGluIHR0bV9kbWFfcG9wdWxhdGUo
KSBpbnN0ZWFkIG9mCj4gPiArCSAqICAgICAgIHR0bV9wb3B1bGF0ZV9hbmRfbWFwX3BhZ2VzKCks
IHdoaWNoIGJvdW5jZSBidWZmZXJzIHNvIG11Y2gKPiA+IGluCj4gPiArCSAqICAgICAgIFhlbiBp
dCBsZWFkcyB0byBzd2lvdGxiIGJ1ZmZlciBleGhhdXN0aW9uLgo+ID4gKwkgKi8KPiA+ICsJaWYg
KHhlbl9wdl9kb21haW4oKSkKPiAKPiBJJ3ZlIG5vdCBiZWVuIGZvbGxvd2luZyBhbGwgb2YgdGhl
IGlucyBhbmQgb3V0cyBvZiB0aGUgZGlzY3Vzc2lvbiBvbiB0aGlzIHNvIGFwb2xvZ2llcyBpZiBJ
J20gbWlzc2luZyBzb21lIGNvbnRleHQsIGJ1dC4uLgo+IAo+IFRoaXMgbG9va3MgbGlrZSB0aGUg
d3JvbmcgdGVzdCB0byBtZS4gSSB0aGluayBpdCBzaG91bGQgYmU6Cj4gCj4gaWYgKCB4ZW5fc3dp
b3RsYiApCgpBaCwgdGhhdCBjb3VsZCBiZSBhcyB3ZWxsLiAKPiAKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
