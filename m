From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm: add drm device name
Date: Wed, 18 Sep 2019 16:03:24 +0200
Message-ID: <8c49e2e3-1fa1-35db-7d25-574b4b64cca0@daenzer.net>
References: <20190903214040.2386-1-sonny.jiang@amd.com>
 <CAAxE2A45N4gMYrcETDpznGKyxLztuwenFasL19a81QQmBkYiww@mail.gmail.com>
 <CAF6AEGvvUUOGujJC9P3t72N93AJuxiiVt0OAk8zf226Q8WmHvg@mail.gmail.com>
 <CAKMK7uHFNhdNY4Y9ZFMNuci7gssPWCT5f5y=e4npg8s5r_jBdQ@mail.gmail.com>
 <CAAxE2A6sESsKAi3K1etAZeCwAPgexn099G6g0aJQnavTkiH+mA@mail.gmail.com>
 <87woe7eanv.fsf@intel.com> <03d31464-3968-6923-5323-f63060d70f1f@gmail.com>
 <CAKMK7uEj4FZ3YQqG-cCTa4EEaJoAk09Zaz398F9Hmo+mdXCKiw@mail.gmail.com>
 <7540df63-e623-19b0-dde5-b89ff2b7fb89@amd.com>
 <7535dcf4-413f-f06f-b3d1-dcffc86b43e0@daenzer.net>
 <5d0a8619-7073-fac2-cdd6-83b55221140b@daenzer.net>
 <b61ec704-894d-092a-253c-961ff2ea01a2@gmail.com>
 <4d255e1c-1d4a-a754-afe0-b18776a11a7e@daenzer.net>
 <CAAxE2A7RcsiEsWBtbsDE2Wp+Vx7n-vwM1qL6HX_qKt=KnHCd4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A7RcsiEsWBtbsDE2Wp+Vx7n-vwM1qL6HX_qKt=KnHCd4g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Jiang, Sonny" <Sonny.Jiang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOS0wOS0xOCAxOjQxIGEubS4sIE1hcmVrIE9sxaHDoWsgd3JvdGU6Cj4gZHJtVmVyc2lv
bjo6bmFtZSA9IGFtZGdwdSwgcmFkZW9uLCBpbnRlbCwgZXRjLgo+IGRybVZlcnNpb246OmRlc2Mg
PSB2ZWdhMTAsIHZlZ2ExMiwgdmVnYTIwLCAuLi4KPiAKPiBUaGUgY29tbW9uIE1lc2EgY29kZSB3
aWxsIHVzZSBuYW1lIGFuZCBkZXNjIHRvIHNlbGVjdCB0aGUgZHJpdmVyLgoKTGlrZSB0aGUgWG9y
ZyBtb2Rlc2V0dGluZyBkcml2ZXIsIHRoYXQgY29kZSBkb2Vzbid0IG5lZWQgdGhpcyBrZXJuZWwK
ZnVuY3Rpb25hbGl0eSBvciBuZXcgUENJIElEcy4gSXQgY2FuIGp1c3Qgc2VsZWN0IHRoZSBjdXJy
ZW50IGRyaXZlciBmb3IKYWxsIGRldmljZXMgd2hpY2ggYXJlbid0IHN1cHBvcnRlZCBieSBvbGRl
ciBkcml2ZXJzICh3aGljaCBpcyBhIGZpeGVkCnNldCBhdCB0aGlzIHBvaW50KS4KCgo+IFRoZSBB
TUQtc3BlY2lmaWMgTWVzYSBjb2RlIHdpbGwgdXNlIGRlc2MgdG8gaWRlbnRpZnkgdGhlIGNoaXAu
CgpEb2Vzbid0IGxpYmRybV9hbWRncHUncyBzdHJ1Y3QgYW1kZ3B1X2dwdV9pbmZvOjpmYW1pbHlf
aWQgcHJvdmlkZSB0aGUKc2FtZSBpbmZvcm1hdGlvbj8KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBE
w6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHBzOi8vcmVkaGF0LmNvbQpM
aWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBh
bmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
