From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/6] drm/radeon: remove some set but not used variables
Date: Mon, 18 Nov 2019 12:14:15 -0500
Message-ID: <CADnq5_MiVUNkP4e9bFWMZ0TVq3Nrr-HNpg7uONs6pLRGoFwiog@mail.gmail.com>
References: <1573819980-54523-1-git-send-email-zhengbin13@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1573819980-54523-1-git-send-email-zhengbin13-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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
To: zhengbin <zhengbin13-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "Deucher,
 Alexander" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>

QXBwbGllZCB0aGUgc2VyaWVzLiAgVGhhbmtzIQoKQWxleAoKT24gRnJpLCBOb3YgMTUsIDIwMTkg
YXQgOTo1NiBBTSB6aGVuZ2JpbiA8emhlbmdiaW4xM0BodWF3ZWkuY29tPiB3cm90ZToKPgo+IHpo
ZW5nYmluICg2KToKPiAgIGRybS9yYWRlb246IHJlbW92ZSBzZXQgYnV0IG5vdCB1c2VkIHZhcmlh
YmxlICdzaXplJywncmVsb2NzX2NodW5rJwo+ICAgZHJtL3JhZGVvbjogcmVtb3ZlIHNldCBidXQg
bm90IHVzZWQgdmFyaWFibGUgJ2JhY2tiaWFzX3Jlc3BvbnNlX3RpbWUnCj4gICBkcm0vcmFkZW9u
OiByZW1vdmUgc2V0IGJ1dCBub3QgdXNlZCB2YXJpYWJsZSAnZGlnX2Nvbm5lY3RvcicKPiAgIGRy
bS9yYWRlb246IHJlbW92ZSBzZXQgYnV0IG5vdCB1c2VkIHZhcmlhYmxlICdyYWRlb25fY29ubmVj
dG9yJwo+ICAgZHJtL3JhZGVvbjogcmVtb3ZlIHNldCBidXQgbm90IHVzZWQgdmFyaWFibGUgJ2Js
b2NrcycKPiAgIGRybS9yYWRlb246IHJlbW92ZSBzZXQgYnV0IG5vdCB1c2VkIHZhcmlhYmxlICd0
dl9wbGxfY250bDEnCj4KPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9hdG9tYmlvc19kcC5jICAg
ICAgfCAzIC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3I2MDBfY3MuYyAgICAgICAgICB8
IDggKystLS0tLS0KPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fY29tYmlvcy5jICAg
fCAzICstLQo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMgICB8IDIg
LS0KPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fbGVnYWN5X3R2LmMgfCA4ICstLS0t
LS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2lfZHBtLmMgICAgICAgICAgIHwgMyArLS0K
PiAgNiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQo+Cj4g
LS0KPiAyLjcuNAo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
