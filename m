From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] [RFC] drm/radeon: clear WC flag when moving bo from vram
 to gtt
Date: Mon, 24 Apr 2017 19:08:47 +0900
Message-ID: <51cf0681-5a4f-d245-27a8-e937cad18943@daenzer.net>
References: <1493026928-30134-1-git-send-email-jisorce@oblong.com>
 <e602b898-ee7d-e744-5a08-0ab7d0f63d83@vodafone.de>
 <CAHWPjbVvs70ucs69zC+6j-NyET1AWNFQ=JndKOqZRZA8v6m9+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAHWPjbVvs70ucs69zC+6j-NyET1AWNFQ=JndKOqZRZA8v6m9+Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Julien Isorce <julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjQvMDQvMTcgMDc6MDEgUE0sIEp1bGllbiBJc29yY2Ugd3JvdGU6Cj4gCj4gT24gMjQgQXBy
aWwgMjAxNyBhdCAxMDo1MSwgQ2hyaXN0aWFuIEvDtm5pZyA8ZGVhdGhzaW1wbGVAdm9kYWZvbmUu
ZGUKPiA8bWFpbHRvOmRlYXRoc2ltcGxlQHZvZGFmb25lLmRlPj4gd3JvdGU6Cj4gCj4gICAgIEFt
IDI0LjA0LjIwMTcgdW0gMTE6NDIgc2NocmllYiBKdWxpZW4gSXNvcmNlOgo+IAo+ICAgICAgICAg
QnV0IHJlLWFkZCB0aGUgZmxhZyBpcyB0aGUgYm8gaXMgbW92ZWQgYmFjayB0byB2cmFtLgo+IAo+
ICAgICAgICAgVGhpcyBmaXhlcyAicmluZyAwLzMgc3RhbGxlZCIgaXNzdWUgd2hpY2ggaGFwcGVu
cyB3aGVuIHRoZSBkcml2ZXIKPiAgICAgICAgIGV2aWN0cyBibyBmcm9tIHZyYW0gdG8gZ3R0LCBh
dCBsZWFzdCBvbiBUQUhJVEkgYW5kIENBUFZFUkRFLgo+IAo+IAo+ICAgICBJbnRlcmVzdGluZyBm
aW5kLCBidXQgTkFLIG9uIHRoZSBhcHByb2FjaCBmb3IgZml4aW5nIGl0Lgo+IAo+IAo+IFRoeCBm
b3IgdGhlIGNvbW1lbnRzLgo+ICAKPiAKPiAKPiAgICAgSWYgV0MgbWFwcGluZ3MgZG9uJ3Qgd29y
ayBmb3IgVEFISVRJIGFuZCBDQVBWRVJERSB3ZSBuZWVkIHRvIGZpZ3VyZQo+ICAgICBvdXQgd2h5
IG9yIGF0IGxlYXN0IGRpc2FibGUgdGhlbSBmb3IgdGhvc2UgaGFyZHdhcmUgZ2VuZXJhdGlvbnMg
aW4KPiAgICAgZ2VuZXJhbC4KPiAKPiAKPiBTaG91bGQgSSBleHRlbmQKPiBodHRwczovL2NnaXQu
ZnJlZWRlc2t0b3Aub3JnL35hZ2Q1Zi9saW51eC90cmVlL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24v
cmFkZW9uX29iamVjdC5jP2g9YW1kLXN0YWdpbmctNC45I24yMjgKPiB0byBCT05BSVJFICh3aGlj
aCB3aWxsIGluY2x1ZGUgVkVSREUgYW5kIFRBSElUSSkgPyAodG8gbWF0Y2gKPiBodHRwczovL2Nn
aXQuZnJlZWRlc2t0b3Aub3JnL35hZ2Q1Zi9saW51eC90cmVlL2RyaXZlcnMvZ3B1L2RybS9yYWRl
b24vcmFkZW9uX2liLmM/aD1hbWQtc3RhZ2luZy00LjkjbjE5OSApCgpOb3Qgc3VyZSB0aGUgaXNz
dWUgaXMgd2lkZXNwcmVhZCAvIHN5c3RlbWljIGVub3VnaCB0byBqdXN0aWZ5IHRoYXQKdXBzdHJl
YW0uIFlvdSBjYW4gZG8gd2hhdGV2ZXIgeW91IGRlZW0gYXBwcm9wcmlhdGUgaW4geW91ciBwcm9q
ZWN0LCBvZgpjb3Vyc2UuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAg
ICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50
aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
