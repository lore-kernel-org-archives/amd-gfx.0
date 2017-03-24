From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] Revert "drm/radeon: Try evicting from CPU accessible to
 inaccessible VRAM first"
Date: Fri, 24 Mar 2017 18:59:12 +0900
Message-ID: <219c6e11-09d9-d2aa-a04d-20074b4a409b@daenzer.net>
References: <1490206797-15653-1-git-send-email-zmichaels@oblong.com>
 <c56f4a6a-a17d-b9b0-311e-7100df8c7cee@daenzer.net>
 <CAGCDoEGuMVnv6rA-y5XDbc6hiNWiTg6nt4e4u2dZObeY8roKXA@mail.gmail.com>
 <8020e778-c9c8-e67b-428a-436f2f1c0d7b@daenzer.net>
 <CAHWPjbXbAo8CVSJDK1GzN=M4pMobMw9XVQVfVeGVM4H=n36vuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAHWPjbXbAo8CVSJDK1GzN=M4pMobMw9XVQVfVeGVM4H=n36vuQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Julien Isorce <julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Zachary Michaels <zmichaels-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org>, Julien Isorce <jisorce-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjQvMDMvMTcgMDY6NTAgUE0sIEp1bGllbiBJc29yY2Ugd3JvdGU6Cj4gSGkgTWljaGVsLAo+
IAo+IChKdXN0IGZvciBvdGhlciByZWFkZXJzIG15IHJlcGx5IGhhcyBiZWVuIGRlbGF5ZWQgb24g
dGhlIG1haWxpbmcgbGlzdHMKPiBhbmQgc2hvdWxkIGhhdmUgYmVlbiBvbiBzZWNvbmQgcG9zaXRp
b24pCgpJdCBpcyBvbiBodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvcGF0Y2gvMTQ1
NzMxLyAsIGRpZCB5b3UgbWVhbgpzb21ldGhpbmcgZWxzZT8KClRoZSBkZWxheSB3YXMgYmVjYXVz
ZSB5b3Ugd2VyZW4ndCBzdWJzY3JpYmVkIHRvIHRoZSBhbWQtZ2Z4IG1haWxpbmcgbGlzdAp5ZXQs
IHNvIHlvdXIgcG9zdCB3ZW50IHRocm91Z2ggdGhlIG1vZGVyYXRpb24gcXVldWUuCgoKPiBJIHdp
bGwgaGF2ZSBhIGdvIHdpdGggdGhhdCBjaGFuZ2UgYW5kIGxldCB5b3Uga25vdy4gSSBkbyBub3Qg
cmVtZW1iZXIgaWYKPiBJIHRyaWVkIGl0IGZvciB0aGlzIHNvZnQgbG9ja3VwLiBCdXQgZm9yIHN1
cmUgaXQgZG9lcyBub3Qgc29sdmUgdGhlIGhhcmQKPiBsb2NrdXAgdGhhdCBaYWNoIGFsc28gbWVu
dGlvbmVkIGF0IHRoZSBlbmQgb2YgaGlzIHJlcGx5LgoKSSdsbCBmb2xsb3cgdXAgdG8gaGlzIHBv
c3QgYWJvdXQgdGhhdC4KCgo+IEJ1dCBpbiBnZW5lcmFsLCBpc24ndCAicmFkZW9uX2xvY2t1cF90
aW1lb3V0IiBzdXBwb3NlZCB0byBkZXRlY3QgdGhpcwo+IHNpdHVhdGlvbiA/CgpObywgaXQncyBm
b3IgZGV0ZWN0aW5nIEdQVSBoYW5ncywgd2hlcmVhcyB0aGlzIGlzIGEgQ1BVICJoYW5nIiAoaW5m
aW5pdGUKbG9vcCkuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAg
IHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVz
aWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
