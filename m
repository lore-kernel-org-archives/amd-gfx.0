From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH xf86-video-amdgpu 2/2] Use AC_CONFIG_MACRO_DIR instead of
 AC_CONFIG_MACRO_DIRS
Date: Fri, 24 Aug 2018 11:25:20 -0400
Message-ID: <CADnq5_NduE2y-XZptZB0QMGPngBCN9zX4fQy_yGTtcMy0Y=Xaw@mail.gmail.com>
References: <20180824152012.5825-1-michel@daenzer.net>
 <20180824152012.5825-2-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180824152012.5825-2-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gRnJpLCBBdWcgMjQsIDIwMTggYXQgMTE6MjEgQU0gTWljaGVsIETDpG56ZXIgPG1pY2hlbEBk
YWVuemVyLm5ldD4gd3JvdGU6Cj4KPiBGcm9tOiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56
ZXJAYW1kLmNvbT4KPgo+IE9sZGVyIHZlcnNpb25zIG9mIGF1dG9jb25mIG9ubHkgc3VwcG9ydGVk
IHRoZSBmb3JtZXIuCj4KPiAoQ2hlcnJ5IHBpY2tlZCBmcm9tIHJhZGVvbiBjb21taXQgY2JhOGZl
NGQ2NDgxOWFhYThiYTUxNmFhNjhkYmU2ZDJhYTE1MzA0NikKPgo+IFNpZ25lZC1vZmYtYnk6IE1p
Y2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgoKU2VyaWVzIGlzOgpBY2tlZC1i
eTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKPiAtLS0KPiAgY29u
ZmlndXJlLmFjIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9jb25maWd1cmUuYWMgYi9jb25maWd1cmUuYWMKPiBp
bmRleCAxYWI1YTdhZTIuLjg2NzFjZGY5YyAxMDA2NDQKPiAtLS0gYS9jb25maWd1cmUuYWMKPiAr
KysgYi9jb25maWd1cmUuYWMKPiBAQCAtMjksNyArMjksNyBAQCBBQ19JTklUKFt4Zjg2LXZpZGVv
LWFtZGdwdV0sCj4KPiAgQUNfQ09ORklHX1NSQ0RJUihbTWFrZWZpbGUuYW1dKQo+ICBBQ19DT05G
SUdfSEVBREVSUyhbY29uZmlnLmhdKQo+IC1BQ19DT05GSUdfTUFDUk9fRElSUyhbbTRdKQo+ICtB
Q19DT05GSUdfTUFDUk9fRElSKFttNF0pCj4KPiAgQUNfQ09ORklHX0FVWF9ESVIoLikKPgo+IC0t
Cj4gMi4xOC4wCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
