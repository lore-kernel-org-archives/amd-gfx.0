From: Lukas Wunner <lukas@wunner.de>
Subject: Re: ATPX changes in drm-next-4.8 and D3cold handling
Date: Thu, 28 Jul 2016 17:40:31 +0200
Message-ID: <20160728154031.GB1929@wunner.de>
References: <20160721104250.GA9930@al>
 <CY4PR12MB13013C6E86224381122F4006F7000@CY4PR12MB1301.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <CY4PR12MB13013C6E86224381122F4006F7000@CY4PR12MB1301.namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Christoph Haag <haagch.christoph@googlemail.com>, 'Peter Wu' <peter@lekensteyn.nl>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gVGh1LCBKdWwgMjgsIDIwMTYgYXQgMDM6MzM6MjVQTSArMDAwMCwgRGV1Y2hlciwgQWxleGFu
ZGVyIHdyb3RlOgo+ID4gRnJvbTogUGV0ZXIgV3UgW21haWx0bzpwZXRlckBsZWtlbnN0ZXluLm5s
XQo+ID4gU2VudDogVGh1cnNkYXksIEp1bHkgMjEsIDIwMTYgNjo0MyBBTQo+ID4gSW4gY2FzZSB5
b3UgbWlzc2VkIGl0LCBEYXZlJ3MgRDNjb2xkIHBhdGNoZXMgd2VyZSBzdWNjZWVkZWQgYnkgY2hh
bmdlcwo+ID4gaW4gUENJIGNvcmUuIFJlbGV2YW50IGNvbW1pdHMgaW4gdGhlIHBjaS9wbSBicmFu
Y2g6Cj4gPiAKPiA+ICAgICAwMDZkNDRlIFBDSTogQWRkIHJ1bnRpbWUgUE0gc3VwcG9ydCBmb3Ig
UENJZSBwb3J0cwo+ID4gICAgIDE2NDY4YzcgQUNQSSAvIGhvdHBsdWcgLyBQQ0k6IFJ1bnRpbWUg
cmVzdW1lIGJyaWRnZSBiZWZvcmUgcmVzY2FuCj4gPiAgICAgZDk2M2Y2NSBQQ0k6IFBvd2VyIG9u
IGJyaWRnZXMgYmVmb3JlIHNjYW5uaW5nIG5ldyBkZXZpY2VzCj4gPiAgICAgOWQyNmQzYSBQQ0k6
IFB1dCBQQ0llIHBvcnRzIGludG8gRDMgZHVyaW5nIHN1c3BlbmQKPiA+ICAgICA0M2Y3Zjg4IFBD
STogRG9uJ3QgY2xlYXIgZDNjb2xkX2FsbG93ZWQgZm9yIFBDSWUgcG9ydHMKPiAKPiBEaWQgdGhv
c2UgZ2V0IG1lcmdlZCB5ZXQ/CgpUaGV5IHdpbGwgZ28gaW50byA0LjguIFNob3VsZCBoYXZlIGdv
bmUgaW50byA0LjcgYWxyZWFkeSBidXQgd2VyZQpkcm9wcGVkIGF0IHRoZSBsYXN0IG1pbnV0ZS4K
Cgo+IEkganVzdCBuZWVkIHRvIHJldmVydCB0aGlzIGNvbW1pdCBvbmNlIHRoZSBkM2NvbGQgcGF0
Y2hlcyBsYW5kOgo+IGh0dHBzOi8vY2dpdC5mcmVlZGVza3RvcC5vcmcvfmFnZDVmL2xpbnV4L2Nv
bW1pdC8/aD1kcm0tbmV4dC00LjgmaWQ9YmRmYjc2MDQwMDY4ZDk2MGNiOWUyMjY4NzZiZThhNTA4
ZDc0MWM0YQoKU28geW91IHByb2JhYmx5IG5lZWQgdG8gcmV2ZXJ0IHRoaXMgbm93LgoKQmVzdCBy
ZWdhcmRzLAoKTHVrYXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRl
dmVsCg==
