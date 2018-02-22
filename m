From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove duplicate setting of ->need_swiotlb
Date: Thu, 22 Feb 2018 12:01:02 -0500
Message-ID: <CADnq5_NwQe9F4-H3=16YBwY-_k5VEN31awH5VK7EsJ_99-XsqQ@mail.gmail.com>
References: <20180220104450.28652-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180220104450.28652-1-thierry.reding@gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlLCBGZWIgMjAsIDIwMTggYXQgNTo0NCBBTSwgVGhpZXJyeSBSZWRpbmcKPHRoaWVycnku
cmVkaW5nQGdtYWlsLmNvbT4gd3JvdGU6Cj4gRnJvbTogVGhpZXJyeSBSZWRpbmcgPHRyZWRpbmdA
bnZpZGlhLmNvbT4KPgo+IFRoZXJlJ3Mgbm8gbmVlZCB0byBzZXQgdGhpcyBiZWZvcmUgdGhlIG51
bWJlciBvZiBETUEgYml0cyBoYXMgYmVlbgo+IHByb3Blcmx5IGRldGVybWluZWQuCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBUaGllcnJ5IFJlZGluZyA8dHJlZGluZ0BudmlkaWEuY29tPgoKQXBwbGllZC4g
IHRoYW5rcyEKCkFsZXgKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192
OF8wLmMgfCAxIC0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjhfMC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ21jX3Y4XzAuYwo+IGluZGV4IDlhMTcwZTM3ZmJlNy4uOWNjODQ5Zjgy
OWQwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OF8wLmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjhfMC5jCj4gQEAgLTEwODYs
NyArMTA4Niw2IEBAIHN0YXRpYyBpbnQgZ21jX3Y4XzBfc3dfaW5pdCh2b2lkICpoYW5kbGUpCj4g
ICAgICAgICAgKi8KPiAgICAgICAgIGFkZXYtPm5lZWRfZG1hMzIgPSBmYWxzZTsKPiAgICAgICAg
IGRtYV9iaXRzID0gYWRldi0+bmVlZF9kbWEzMiA/IDMyIDogNDA7Cj4gLSAgICAgICBhZGV2LT5u
ZWVkX3N3aW90bGIgPSBkcm1fZ2V0X21heF9pb21lbSgpID4gKCh1NjQpMSA8PCBkbWFfYml0cyk7
Cj4gICAgICAgICByID0gcGNpX3NldF9kbWFfbWFzayhhZGV2LT5wZGV2LCBETUFfQklUX01BU0so
ZG1hX2JpdHMpKTsKPiAgICAgICAgIGlmIChyKSB7Cj4gICAgICAgICAgICAgICAgIGFkZXYtPm5l
ZWRfZG1hMzIgPSB0cnVlOwo+IC0tCj4gMi4xNS4xCj4KPiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vZHJpLWRldmVsCg==
