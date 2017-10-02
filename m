From: Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 06/18] drm: use ARRAY_SIZE
Date: Mon, 02 Oct 2017 10:43:18 +0300
Message-ID: <871smm6lm1.fsf@intel.com>
References: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
 <20171001193101.8898-7-jeremy.lefaure@lse.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171001193101.8898-7-jeremy.lefaure-tU7rkvAWjlwhT4uAktR2oQ@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/nouveau>
List-Post: <mailto:nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Nouveau" <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Patrik Jakobsson <patrik.r.jakobsson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zhenyu Wang <zhenyuw-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Zhi Wang <zhi.a.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Joonas Lahtinen <joonas.lahtinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Rodrigo Vivi <rodrigo.vivi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, =?utf-8?B?SsOpcsOpbXk=?= Lefaure <jeremy.lefaure-tU7rkvAWjlwhT4uAktR2oQ@public.gmane.org>, intel-gvt-dev-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
List-Id: amd-gfx.lists.freedesktop.org

T24gU3VuLCAwMSBPY3QgMjAxNywgSsOpcsOpbXkgTGVmYXVyZSA8amVyZW15LmxlZmF1cmVAbHNl
LmVwaXRhLmZyPiB3cm90ZToKPiBVc2luZyB0aGUgQVJSQVlfU0laRSBtYWNybyBpbXByb3ZlcyB0
aGUgcmVhZGFiaWxpdHkgb2YgdGhlIGNvZGUuIEFsc28sCj4gaXQgaXMgbm90IGFsd2F5cyB1c2Vm
dWwgdG8gdXNlIGEgdmFyaWFibGUgdG8gc3RvcmUgdGhpcyBjb25zdGFudAo+IGNhbGN1bGF0ZWQg
YXQgY29tcGlsZSB0aW1lIG5vciB0byByZS1pbnZlbnQgdGhlIEFSUkFZX1NJWkUgbWFjcm8uCj4K
PiBGb3VuZCB3aXRoIENvY2NpbmVsbGUgd2l0aCB0aGUgZm9sbG93aW5nIHNlbWFudGljIHBhdGNo
Ogo+IEByIGRlcGVuZHMgb24gKG9yZyB8fCByZXBvcnQpQAo+IHR5cGUgVDsKPiBUW10gRTsKPiBw
b3NpdGlvbiBwOwo+IEBACj4gKAo+ICAoc2l6ZW9mKEUpQHAgL3NpemVvZigqRSkpCj4gfAo+ICAo
c2l6ZW9mKEUpQHAgL3NpemVvZihFWy4uLl0pKQo+IHwKPiAgKHNpemVvZihFKUBwIC9zaXplb2Yo
VCkpCj4gKQo+Cj4gU2lnbmVkLW9mZi1ieTogSsOpcsOpbXkgTGVmYXVyZSA8amVyZW15LmxlZmF1
cmVAbHNlLmVwaXRhLmZyPgoKUGxlYXNlIHNwbGl0IHRoaXMgdXAuCgpQYXRjaCAxOgo+ICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jICAgICAgICAgICB8ICA5ICsrKysrLS0t
LQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jICAgICAgICAgICB8ICA5
ICsrKysrLS0tLQoKUGF0Y2ggMjoKPiAgZHJpdmVycy9ncHUvZHJtL2dtYTUwMC9wc2JfaW50ZWxf
c2R2by5jICAgICAgICAgfCAgOSArKysrLS0tLS0KClBhdGNoIDM6Cj4gIGRyaXZlcnMvZ3B1L2Ry
bS9pOTE1L2d2dC92Z3B1LmMgICAgICAgICAgICAgICAgIHwgIDMgKystCgpQYXRjaCA0Ogo+ICBk
cml2ZXJzL2dwdS9kcm0vbm91dmVhdS9udmttL3N1YmRldi9iaW9zL2luaXQuYyB8ICA3ICsrKyst
LS0KClBhdGNoIDU6Cj4gIGRyaXZlcnMvZ3B1L2RybS92aWEvdmlhX3ZlcmlmaWVyLmMgICAgICAg
ICAgICAgIHwgMTAgKysrKy0tLS0tLQoKQlIsCkphbmkuCgotLSAKSmFuaSBOaWt1bGEsIEludGVs
IE9wZW4gU291cmNlIFRlY2hub2xvZ3kgQ2VudGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCk5vdXZlYXUgbWFpbGluZyBsaXN0Ck5vdXZlYXVAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vbm91dmVhdQo=
