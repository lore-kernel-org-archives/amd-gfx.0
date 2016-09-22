From: Andy Furniss <adf.lists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: bind GTT on demand
Date: Thu, 22 Sep 2016 22:54:28 +0100
Message-ID: <57E45314.9080903@gmail.com>
References: <1473154866-2448-1-git-send-email-deathsimple@vodafone.de>
 <1473154866-2448-2-git-send-email-deathsimple@vodafone.de>
 <CAAxE2A4p=fnpwRsXDPhNW518uQqFoDzTxxhYg4_+yzJvhWOoBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A4p=fnpwRsXDPhNW518uQqFoDzTxxhYg4_+yzJvhWOoBQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

TWFyZWsgT2zFocOhayB3cm90ZToKPiBUaGlzIGJyZWFrcyBUb25nYSBzdWNoIHRoYXQgaXQgaGFu
Z3MuIFJlcHJvZHVjaWJsZSBxdWlja2x5IHdpdGg6Cj4KPiBSNjAwX0RFQlVHPXRlc3RkbWEgZ2x4
Z2VhcnMKPgo+IEl0J3MgYSByYW5kb21pemVkIHRlc3QgdGhhdCBydW5zIGZvcmV2ZXIuIEl0IHNo
b3VsZCBoYW5nIHdpdGhpbiAyIHNlY29uZHMuCgpTbyB3aGF0IGlzIHRoZSBzdGF0dXMgb2YgdGhp
cyBub3c/CgpSNjAwX0RFQlVHPXRlc3RkbWEgZ2x4Z2VhcnMgaXNuJ3QgYSB0ZXN0IEkndmUgcnVu
IG9uIG15IHI5Mjg1IHRvbmdhCnVudGlsIEksIGJ5IGx1Y2ssIHNhdyB0aGlzLgoKT24gYWdkZGYg
NC45LXdpcCBhdCBwb3N0IHRpbWUgaXQgZGlkIGhhbmcvcmVib290IGFmdGVyIDIgc2Vjb25kcy4K
Ck9uIGV2ZXJ5IHVwZGF0ZSBzaW5jZSBpdCdzIHN0aWxsIGh1bmcgdGhvdWdoIG5vdyBpdCB0YWtl
cyBsb25nZXIuCgpUb2RheXMgdXBkYXRlIHRlc3RlZCBib3RoIG9uIGhlYWQgYW5kIHJlc2V0IG9u
IHRvIHRoZSBkcm0tbmV4dCB0YWcKc3RpbGwgaGFuZy4KCkdvaW5nIGJhY2sgb3ZlciBvbGRlciA0
Ljktd2lwcyBpdCdzIG9uZSBidWlsdCBvbiAyNnRoIEF1Z3VzdCB0aGF0IGlzCnRoZSBmaXJzdCBu
b3QgdG8gaGFuZy4KCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
