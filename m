From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH AUTOSEL 4.19 044/167] drm/amdgpu: validate user pitch
 alignment
Date: Mon, 9 Sep 2019 17:25:58 +0200
Message-ID: <4286bd73-cbf5-cd5c-1d80-1d6e68301f6b@daenzer.net>
References: <20190903162519.7136-1-sashal@kernel.org>
 <20190903162519.7136-44-sashal@kernel.org>
 <7957107d-634f-4771-327e-99fdd5e6474e@daenzer.net>
 <20190903170347.GA24357@kroah.com> <20190903200139.GJ5281@sasha-vm>
 <CAKMK7uFpBnkF4xABdkDMZ8TYhL4jg6ZuGyHGyVeBxc9rkyUtXQ@mail.gmail.com>
 <CADnq5_Mfee4xmzMJ-Hmw251QCMfabWPKd8PX+o70D97qdCDJ8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_Mfee4xmzMJ-Hmw251QCMfabWPKd8PX+o70D97qdCDJ8g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Yu Zhao <yuzhao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOS0wOS0wNyA0OjU4IHAubS4sIEFsZXggRGV1Y2hlciB3cm90ZToKPgo+IFRoZSBwYXRj
aCBzaHVmZmxpbmcgZG9lc24ndCBoZWxwLCBidXQgcmVnYXJkbGVzcywgdGhlIHNhbWUgdGhpbmcg
Y291bGQKPiBoYXBwZW4gZXZlbiB3aXRoIGEgZGlyZWN0IGNvbW1pdHRlciB0cmVlIGlmIHNvbWVv
bmUgbWlzc2VkIHRoZSB0YWcgd2hlbgo+IGNvbW1pdHRpbmcuCgpUcnVlLCBidXQgaW4gdGhlIGxh
dHRlciBjYXNlIGl0IHdvdWxkIGF0IGxlYXN0IGJlIHBvc3NpYmxlIHRvIGFkZCB0YWdzCnJlZmVy
ZW5jaW5nIHBlcnNpc3RlbnQgY29tbWl0IGhhc2hlcyByZWdhcmRsZXNzIG9mIHdoZW4gZml4LXVw
cyBoYXBwZW4sCndoZXJlYXMgd2l0aCB0aGUgZm9ybWVyIHRoaXMgaXNuJ3QgcG9zc2libGUgYmVm
b3JlIHRoZSBvcmlnaW5hbCBjaGFuZ2UKbWFrZXMgaXQgdG8gTGludXMgb3IgYXQgbGVhc3QgRGF2
ZS4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAg
ICAgICAgIGh0dHBzOi8vcmVkaGF0LmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAg
ICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
