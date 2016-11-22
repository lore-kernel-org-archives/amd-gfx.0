From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: gnome-shell is frozen upon wakeup from DPMS (bisected)
Date: Tue, 22 Nov 2016 18:39:02 +0900
Message-ID: <f4e2005d-9343-37cd-d532-e8e7e0d43b01@daenzer.net>
References: <e0aa85a5-c26e-f5ea-556b-ee8e5f3bc37e@suse.de>
 <0c0ae77d-fb23-0cdb-161b-c57f41327ad1@daenzer.net>
 <1b69099b-ffb0-0f48-2ab1-34dd6632f000@suse.de>
 <9a09c38c-870f-dc5b-327b-3cc99da49600@daenzer.net>
 <fb2e6acd-0f08-d758-6709-b97e8f200468@suse.de>
 <6e0c3103-03da-559e-adcd-70d063bb55b0@daenzer.net>
 <aedba6ab-7ccc-4061-cf69-eed79d9e5589@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <aedba6ab-7ccc-4061-cf69-eed79d9e5589-l3A5Bk7waGM@public.gmane.org>
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
To: Max Staudt <mstaudt-l3A5Bk7waGM@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjIvMTEvMTYgMDY6MzYgUE0sIE1heCBTdGF1ZHQgd3JvdGU6Cj4gT24gMTEvMjIvMjAxNiAw
OTozNSBBTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4+IE9uIDIxLzExLzE2IDA3OjE1IFBNLCBN
YXggU3RhdWR0IHdyb3RlOgo+Pj4gT24gMTEvMTcvMjAxNiAwOToyNyBBTSwgTWljaGVsIETDpG56
ZXIgd3JvdGU6Cj4+Pj4+IFNvLi4uIHdoYXQgYWJvdXQgRFJJMj8KPj4+Pgo+Pj4+IERvZXMgdGhl
IGF0dGFjaGVkIGtlcm5lbCBwYXRjaCBoZWxwIHdpdGggcHJlLTQuNiBrZXJuZWxzPwo+Pj4KPj4+
IFRoaXMgcGF0Y2ggd29ya3MuIFRoYW5rcyEKPj4KPj4gR3JlYXQsIHRoYW5rcyBmb3IgdGVzdGlu
ZyEKPj4KPj4KPj4+IEFueSBjaGFuY2UgZm9yIHRoaXMgdG8gZ28gaW50byBsaW51eC1zdGFibGU/
Cj4+Cj4+IEknbGwgdHJ5LCBidXQgSSBkb24ndCBrbm93IGlmIGl0J2xsIGJlIGFjY2VwdGVkLgo+
IAo+IAo+IFRoYW5rcyBmb3IgdHJ5aW5nIHN0aWxsIQo+IAo+IAo+IEkgd291bGQgbGlrZSB0byBp
bmNsdWRlIHRoaXMgcGF0Y2ggaW4gdGhlIFNVU0Uga2VybmVsLCBpZiB5b3UgZG9uJ3QgbWluZC4K
Ck5vdCBhdCBhbGwsIHRoYW5rcy4KCj4gRG8geW91IGhhdmUgYSBjb3B5IG9mIHRoZSBkaWZmIHdp
dGggYSBHaXQgY29tbWl0IGhlYWRlciBhbmQgbWVzc2FnZSwgc28gSSBjYW4gYXR0cmlidXRlIGl0
IHRvIHlvdT8KClNlZSBodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvcGF0Y2gvMTIy
OTcwLyAuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAg
ICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAg
ICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
