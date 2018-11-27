From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v7 3/5] drm: Document variable refresh properties
Date: Tue, 27 Nov 2018 09:52:06 +0100
Message-ID: <52b214f4-253f-3b24-0d70-7a4c91768795@daenzer.net>
References: <20181108144353.31363-1-nicholas.kazlauskas@amd.com>
 <20181108144353.31363-4-nicholas.kazlauskas@amd.com>
 <77ad01c4-4306-e150-c143-f52593b4656f@amd.com>
 <58956653-ab01-55c8-abad-a6b8e270acd1@amd.com>
 <a3cc6477-37bc-40c5-8042-997a64d166e5@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a3cc6477-37bc-40c5-8042-997a64d166e5-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>
Cc: Manasi Navare <manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Pekka Paalanen <ppaalanen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOC0xMS0yNiAxMDo0OSBwLm0uLCBXZW50bGFuZCwgSGFycnkgd3JvdGU6Cj4gT24gMjAx
OC0xMS0xMiAxMjowNSBwLm0uLCBLYXpsYXVza2FzLCBOaWNob2xhcyB3cm90ZToKPj4gT24gMTEv
MTIvMTggMTE6MTIgQU0sIFdlbnRsYW5kLCBIYXJyeSB3cm90ZToKPj4+IE9uIDIwMTgtMTEtMDgg
OTo0MyBhLm0uLCBOaWNob2xhcyBLYXpsYXVza2FzIHdyb3RlOgo+Pj4+IFRoZXNlIGluY2x1ZGUg
dGhlIGRybV9jb25uZWN0b3IgJ3Zycl9jYXBhYmxlJyBhbmQgdGhlIGRybV9jcnRjCj4+Pj4gJ3Zy
cl9lbmFibGVkJyBwcm9wZXJ0aWVzLgo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogTmljaG9sYXMg
S2F6bGF1c2thcyA8bmljaG9sYXMua2F6bGF1c2thc0BhbWQuY29tPgo+Pj4+IENjOiBIYXJyeSBX
ZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KPj4+PiBDYzogTWFuYXNpIE5hdmFyZSA8
bWFuYXNpLmQubmF2YXJlQGludGVsLmNvbT4KPj4+PiBDYzogUGVra2EgUGFhbGFuZW4gPHBwYWFs
YW5lbkBnbWFpbC5jb20+Cj4+Pj4gQ2M6IFZpbGxlIFN5cmrDpGzDpCA8dmlsbGUuc3lyamFsYUBs
aW51eC5pbnRlbC5jb20+Cj4+Pj4gQ2M6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnplci5u
ZXQ+Cj4+Pgo+Pj4gTG9va3MgZ29vZC4gV2hvbGUgc2VyaWVzIGlzCj4+PiBSZXZpZXdlZC1ieTog
SGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Cj4+Pgo+Pj4gSG93IGFyZSB3
ZSB3aXRoIHRoZSB1c2Vyc3BhY2UgcGF0Y2hlcz8gV2Ugc2hvdWxkIHByb2JhYmx5IGhvbGQgb2Zm
IHB1c2hpbmcgdGhlIGtlcm5lbCBwYXRjaGVzIHVudGlsIHRoZSB1c2Vyc3BhY2Ugd29yayBpcyBh
bGwgcmV2aWV3ZWQuCj4+Pgo+Pj4gSGFycnkKPj4KPj4gVGhhbmtzIGZvciB0aGUgcmV2aWV3Lgo+
Pgo+PiBUaGUgeGY4Ni12aWRlby1hbWRncHUgcGF0Y2hlcyBoYXZlIGJlZW4gcmV2aWV3ZWQgYW5k
IHRoZSBtZXNhIHBhdGNoZXMgCj4+IGhhdmUgYmVlbiBwYXJ0aWFsbHkgcmV2aWV3ZWQuCj4gCj4g
QWxleCwgTWljaGVsLAo+IAo+IGhvdyBkbyB3ZSBtZXJnZSBjaGFuZ2VzIGxpa2UgdGhpcyB0aGF0
IHByb3ZpZGUgYSBrZXJuZWwgQVBJIHRoYXQgZ29lcwo+IHRvZ2V0aGVyIHdpdGggdXNlcnNwYWNl
IGNoYW5nZXM/Cj4gCj4gSSBpbWFnaW5lIHdlJ2Qgd2FudCB0byBnZXQgdGhlIGtlcm5lbCBjaGFu
Z2VzIGluIGZpcnN0LCBhbmQgdGhlbiBtZXJnZQo+IHRoZSB4Zjg2LXZpZGVvLWFtZGdwdSBhbmQg
bWVzYSBjaGFuZ2VzLgoKWWVhaCwgdGhhdCdzIGhvdyBpdCdzIHVzdWFsbHkgZG9uZS4KCgo+IEFu
eSBvYmplY3Rpb25zIHRvIGdldHRpbmcgdGhpcyBtZXJnZWQgdmlhIHRoZSB1c3VhbCBhbWQtc3Rn
PwoKTm9uZSBmcm9tIG1lLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAg
ICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVu
dGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3Blcgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
