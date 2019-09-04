From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH AUTOSEL 4.19 044/167] drm/amdgpu: validate user pitch
 alignment
Date: Wed, 4 Sep 2019 17:05:33 +0200
Message-ID: <e8152226-63e1-3ff8-0079-b6dde93bfada@daenzer.net>
References: <20190903162519.7136-1-sashal@kernel.org>
 <20190903162519.7136-44-sashal@kernel.org>
 <7957107d-634f-4771-327e-99fdd5e6474e@daenzer.net>
 <20190903170347.GA24357@kroah.com> <20190903200139.GJ5281@sasha-vm>
 <CAKMK7uFpBnkF4xABdkDMZ8TYhL4jg6ZuGyHGyVeBxc9rkyUtXQ@mail.gmail.com>
 <829c5912-cf80-81d0-7400-d01d286861fc@daenzer.net>
 <20190904120823.GW5281@sasha-vm>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190904120823.GW5281@sasha-vm>
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
To: Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Yu Zhao <yuzhao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

T24gMjAxOS0wOS0wNCAyOjA4IHAubS4sIFNhc2hhIExldmluIHdyb3RlOgo+IAo+IEZXSVcsIEkn
dmUgYWRkZWQgYW5vdGhlciB0ZXN0IHRvIG15IHNjcmlwdHMgdG8gdHJ5IGFuZCBjYXRjaCB0aGVz
ZSBjYXNlcwo+IChSZXZlcnQgIiVzIikuIEl0J2xsIHNsb3cgZG93biB0aGUgc2NyaXB0cyBhIGJp
dCBidXQgaXQncyBiZXR0ZXIgdG8gZ2V0Cj4gaXQgcmlnaHQgcmF0aGVyIHRoYW4gdG8gYmUgZG9u
ZSBxdWlja2x5IDopCgpJbmRlZWQsIHRoYW5rcyEgQW5kIGFnYWluIHNvcnJ5IGZvciB0aGUgYnJv
dWhhaGEsIEkganVzdCBob25lc3RseSBkaWRuJ3QKcmVhbGl6ZSBiZWZvcmUgaG93IHRyaWNreSB0
aGlzIGNhc2Ugd2FzIGZvciB0aGUgc2NyaXB0cy4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6Ru
emVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHBzOi8vcmVkaGF0LmNvbQpMaWJy
ZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQg
WCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
