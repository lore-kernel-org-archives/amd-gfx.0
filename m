From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/radeon: Override fpfn for all VRAM placements in
 radeon_evict_flags
Date: Tue, 28 Mar 2017 10:14:01 +0900
Message-ID: <eb78a662-94e0-e8c6-cc5a-410df7d30570@daenzer.net>
References: <20170327005843.2009-1-michel@daenzer.net>
 <9485c238-d562-c363-f108-0c736af440eb@vodafone.de>
 <CAHWPjbXtsgnbdFw1W0JPzVUDdtvUDmp+9_UFMicwCTGOedcZLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAHWPjbXtsgnbdFw1W0JPzVUDdtvUDmp+9_UFMicwCTGOedcZLw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Julien Isorce <julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Deucher Alex <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, Zachary Michaels <zmichaels-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org>, Julien Isorce <jisorce-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjcvMDMvMTcgMDY6MzMgUE0sIEp1bGllbiBJc29yY2Ugd3JvdGU6Cj4gSGkgTWljaGVsLAo+
IAo+IEdyZWF0ICEgV291bGQgeW91IG1pbmQgdG8ganVzdCBhZGQgYSBub3RlIHRvIG1lbnRpb24g
dGhhdCB0aGUgaW5maW5pdGUKPiBsb29wIGFjdHVhbGx5IGhhcHBlbnMgaW4gdHRtX2JvX21lbV9m
b3JjZV9zcGFjZSA/IFRoeCEKCkknbSBhZnJhaWQgaXQgbWlnaHQgYmUgdG9vIGxhdGUsIGFzIEkg
YWxyZWFkeSBwdXNoZWQgdGhlIGZpeCB0byB0aGUKYW1kLXN0YWdpbmctNC45IGJyYW5jaC4gSSBn
dWVzcyBBbGV4IGNvdWxkIHN0aWxsIGFkZCBpdCBiZWZvcmUgaGUKaW5jbHVkZXMgdGhlIGZpeCBp
biBhIHB1bGwgcmVxdWVzdCB0aG91Z2guCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAg
ICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29m
dHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2
ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
