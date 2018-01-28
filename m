From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/radeon: adjust tested variable
Date: Sun, 28 Jan 2018 14:03:31 +0100
Message-ID: <f6ee63cc-0d2e-d314-1621-dd9045970ada@amd.com>
References: <1517063295-16648-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1517063295-16648-1-git-send-email-Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Content-Language: en-US
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
To: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjcuMDEuMjAxOCB1bSAxNToyOCBzY2hyaWViIEp1bGlhIExhd2FsbDoKPiBDaGVjayB0aGUg
dmFyaWFibGUgdGhhdCB3YXMgbW9zdCByZWNlbnRseSBpbml0aWFsaXplZC4KPgo+IFRoZSBzZW1h
bnRpYyBtYXRjaCB0aGF0IGZpbmRzIHRoaXMgcHJvYmxlbSBpcyBhcyBmb2xsb3dzOgo+IChodHRw
Oi8vY29jY2luZWxsZS5saXA2LmZyLykKPgo+IC8vIDxzbXBsPgo+IEBACj4gZXhwcmVzc2lvbiB4
LCB5LCBmLCBnLCBlLCBtOwo+IHN0YXRlbWVudCBTMSxTMixTMyxTNDsKPiBAQAo+Cj4geCA9IGYo
Li4uKTsKPiBpZiAoXCg8Ky4uLnguLi4rPlwmZVwpKSBTMSBlbHNlIFMyCj4gKAo+IHggPSBnKC4u
Lik7Cj4gfAo+IG0gPSBnKC4uLiwmeCwuLi4pOwo+IHwKPiB5ID0gZyguLi4pOwo+ICppZiAoZSkK
PiAgIFMzIGVsc2UgUzQKPiApCj4gLy8gPC9zbXBsPgo+Cj4gU2lnbmVkLW9mZi1ieTogSnVsaWEg
TGF3YWxsIDxKdWxpYS5MYXdhbGxAbGlwNi5mcj4KCkdvb2QgY2F0Y2gsIGFkZGVkIG15IHJiIGFu
ZCBwdXNoZWQgaXQgaW50byBvdXIgdG8tYmUtdXBzdHJlYW1lZCBicmFuY2guCgpUaGFua3MsCkNo
cmlzdGlhbi4KCj4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3V2ZC5j
IHwgICAgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdXZkLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl91dmQuYwo+IGluZGV4IGQzNGQxY2YuLjk1
ZjRkYjcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdXZkLmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl91dmQuYwo+IEBAIC05OTUsNyAr
OTk1LDcgQEAgaW50IHJhZGVvbl91dmRfY2FsY191cGxsX2RpdmlkZXJzKHN0cnVjdCByYWRlb25f
ZGV2aWNlICpyZGV2LAo+ICAgCQkvKiBjYWxjIGRjbGsgZGl2aWRlciB3aXRoIGN1cnJlbnQgdmNv
IGZyZXEgKi8KPiAgIAkJZGNsa19kaXYgPSByYWRlb25fdXZkX2NhbGNfdXBsbF9wb3N0X2Rpdih2
Y29fZnJlcSwgZGNsaywKPiAgIAkJCQkJCQkgcGRfbWluLCBwZF9ldmVuKTsKPiAtCQlpZiAodmNs
a19kaXYgPiBwZF9tYXgpCj4gKwkJaWYgKGRjbGtfZGl2ID4gcGRfbWF4KQo+ICAgCQkJYnJlYWs7
IC8qIHZjbyBpcyB0b28gYmlnLCBpdCBoYXMgdG8gc3RvcCAqLwo+ICAgCj4gICAJCS8qIGNhbGMg
c2NvcmUgd2l0aCBjdXJyZW50IHZjbyBmcmVxICovCj4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
