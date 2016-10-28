From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/i915: Before pageflip, also wait for shared dmabuf
 fences.
Date: Fri, 28 Oct 2016 10:34:55 +0900
Message-ID: <720351a2-7597-aee3-58ce-9d65cad5762f@daenzer.net>
References: <3f4643cb-52a9-d7ae-439b-5f6fc6e718cc@vodafone.de>
 <20160922063625.GD22164@dvetter-linux.ger.corp.intel.com>
 <b95726e7-6bf6-a1b8-2a63-0758b1b185e2@vodafone.de>
 <CAKMK7uF13M7d8qRRwKs_8M-QHjnuB7k3jshTUDnccTTQf6unog@mail.gmail.com>
 <ddf99e2a-5f9a-41b9-9fde-af7bfd522572@vodafone.de>
 <CAKMK7uEidoKbTO-m3KSz8UmQhF+uorg2-cWY8UpOXjZ_9MCxLg@mail.gmail.com>
 <d2430ff8-43bd-bff2-9b02-847cabfd56c0@vodafone.de>
 <ed1a57a4-1409-6d07-998a-2b54f466f710@daenzer.net>
 <20160923120954.GH22164@dvetter-linux.ger.corp.intel.com>
 <8c21f70a-7f96-480e-9784-93f2d48f52bb@daenzer.net>
 <20160926080419.GV20761@phenom.ffwll.local>
 <CAHbf0-HZ6EotqwgvkxRTdRF97xB3qBA=DRKAzaAXguV_PR_P8w@mail.gmail.com>
 <d74d34a7-5221-d282-d9d1-b0e1007fc0c7@daenzer.net>
 <c77a2cb9-1f0e-f1a3-aedd-a111cd6ba8e8@vodafone.de>
 <e92512c7-4fb5-6fa1-e93f-0322d1537c46@daenzer.net>
 <CAHbf0-GGMWZrhB+PKpc-QbD__6fqB4pQVFfN+gzLWNhi+DuG3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAHbf0-GGMWZrhB+PKpc-QbD__6fqB4pQVFfN+gzLWNhi+DuG3Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjcvMTAvMTYgMTA6MzMgUE0sIE1pa2UgTG90aGlhbiB3cm90ZToKPiAKPiBKdXN0IGFub3Ro
ZXIgZ2VudGxlIHBpbmcgdG8gc2VlIHdoZXJlIHlvdSBhcmUgd2l0aCB0aGlzPwoKSSBoYXZlbid0
IGdvdCBhIGNoYW5jZSB0byBsb29rIGludG8gdGhpcyBhbnkgZnVydGhlci4KCgotLSAKRWFydGhs
aW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93
d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAg
ICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
