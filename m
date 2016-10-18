From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [rfc] fix for regression in pat memory tracking in 4.9-rc1
Date: Tue, 18 Oct 2016 09:51:30 +0200
Message-ID: <20161018075130.GA20761@phenom.ffwll.local>
References: <1476771193-2759-1-git-send-email-airlied@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <1476771193-2759-1-git-send-email-airlied@gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Dave Airlie <airlied@gmail.com>
Cc: dan.j.williams@intel.com, shawn.starr@rogers.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlLCBPY3QgMTgsIDIwMTYgYXQgMDQ6MTM6MTBQTSArMTAwMCwgRGF2ZSBBaXJsaWUgd3Jv
dGU6Cj4gT2theSBJIHNwZW50IHNvbWUgdGltZSBsb29raW5nIGludG8gaXQsIGFuZCB0aGlzIGlz
IHRoZSByZXN1bHQuCj4gCj4gV2UgaGF2ZSB0byBtYW51YWxseSBpbnNlcnQgdGhlIFZSQU0gQkFS
IGludG8gdGhlIHBhdCBtZW1vcnkgdHJhY2tpbmcKPiB0YWJsZSBhcyBXQy4gVGhlIG9ubHkgb3Ro
ZXIgd2F5IHRoaW5ncyBnZXQgaW5zZXJ0ZWQgYXJlIHZpYSBpb3JlbWFwLAo+IHdoaWNoIHdlIG5l
dmVyIGRvIGZvciB0aGUgd2hvbGUgVlJBTSBCQVIuIFdlIGNvdWxkIGluIHRoZW9yeSBtYXAKPiB0
aGUgVlJBTSBCQVIgdXNpbmcgdGhlIGlvbWFwIHN0dWZmIHRoYXQgaTkxNSB1c2VzLCBidXQgd2Ug
ZG9uJ3QKPiBhbmQgdGhpcyBzZWVtcyBlYXNpZXIgZm9yIG5vdy4KPiAKPiBXZSBoYXZlIHRvIGZp
eCB1cCBhdCBsZWFzdCBub3V2ZWF1IGFuZCByYWRlb24gSSB0aGluayBhcyB3ZWxsLgoKV2UgaGF2
ZSBzb21ldGhpbmcgcHJldHR5IGNsb3NlIHRvIHRoaXMgaW4gaTkxNSBhbHJlYWR5LCBpbiBpOTE1
L2k5MTVfbW0uYy4KT3VyIGlkZWEgd2FzIHRvIHJldXNlIHN0cnVjdCBpb19tYXBwaW5nLCBzaW5j
ZSB0aGF0IG9uZSBhbHJlYWR5IHRyYWNrcyB0aGUKY2FjaGUgdHlwZSBmb3IgdXMgKHNvIHRoYXQg
aXQgY291bGQgZG8gdGhlIG9uLWRlbWFuZCBrbWFwIHN0dWZmIHByb3Blcmx5KS4KRXh0ZW5kaW5n
IHRoYXQgdG8gd3JpdGluZyB1c2Vyc3BhY2UgcHRlcyB3YXMgcHJldHR5IHN0cmFpZ2h0Zm9yd2Fy
ZC4gQW5kCml0IGhhcyB0aGUgdXBzaG90IHRoYXQgaXQga2VlcHMgdGhlIG1lbXR5cGUgdHJhY2tp
bmcgZW5jYXBzdWxhdGVkIChhdApsZWFzdCBpZiB3ZSdkIG1vdmUgdGhlIGhlbHBlciBmcm9tIGk5
MTVfbW0uYyBpbnRvIGNvcmUpLgotRGFuaWVsCi0tIApEYW5pZWwgVmV0dGVyClNvZnR3YXJlIEVu
Z2luZWVyLCBJbnRlbCBDb3Jwb3JhdGlvbgpodHRwOi8vYmxvZy5mZndsbC5jaApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBs
aXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
