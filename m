From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH xf86-video-ati 2/2] Use AC_CONFIG_MACRO_DIR instead of
 AC_CONFIG_MACRO_DIRS
Date: Fri, 24 Aug 2018 10:39:30 -0400
Message-ID: <CADnq5_NiRchGp2gvu3YehiuE35=dofMhstsRh2EsW-wZBdqt+A@mail.gmail.com>
References: <20180823170105.13651-1-michel@daenzer.net>
 <20180823170105.13651-2-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180823170105.13651-2-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

T24gVGh1LCBBdWcgMjMsIDIwMTggYXQgMTowMSBQTSBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRh
ZW56ZXIubmV0PiB3cm90ZToKPgo+IEZyb206IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnpl
ckBhbWQuY29tPgo+Cj4gT2xkZXIgdmVyc2lvbnMgb2YgYXV0b2NvbmYgb25seSBzdXBwb3J0ZWQg
dGhlIGZvcm1lci4KPgo+IFNpZ25lZC1vZmYtYnk6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFl
bnplckBhbWQuY29tPgoKU2VyaWVzIGlzOgpBY2tlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPgoKPiAtLS0KPiAgY29uZmlndXJlLmFjIHwgMiArLQo+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQg
YS9jb25maWd1cmUuYWMgYi9jb25maWd1cmUuYWMKPiBpbmRleCA0NDQ4NjJmM2IuLmI2ZGE2NzNl
YSAxMDA2NDQKPiAtLS0gYS9jb25maWd1cmUuYWMKPiArKysgYi9jb25maWd1cmUuYWMKPiBAQCAt
MjksNyArMjksNyBAQCBBQ19JTklUKFt4Zjg2LXZpZGVvLWF0aV0sCj4KPiAgQUNfQ09ORklHX1NS
Q0RJUihbTWFrZWZpbGUuYW1dKQo+ICBBQ19DT05GSUdfSEVBREVSUyhbY29uZmlnLmhdKQo+IC1B
Q19DT05GSUdfTUFDUk9fRElSUyhbbTRdKQo+ICtBQ19DT05GSUdfTUFDUk9fRElSKFttNF0pCj4K
PiAgQUNfQ09ORklHX0FVWF9ESVIoLikKPgo+IC0tCj4gMi4xOC4wCj4KPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0
Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
