From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: Plan: BO move throttling for visible VRAM evictions
Date: Thu, 18 May 2017 10:39:05 +0200
Message-ID: <fae2d145-63ee-3f74-b509-2d43b84ed417@vodafone.de>
References: <CAAxE2A4ap8BoOEg1tOF+Ec1vBfZRSANOebikYBaHUfXokY7EwA@mail.gmail.com>
 <9220eda1-5176-36cd-e6b3-801c3e4f759a@daenzer.net>
 <78989271-9812-f891-3a00-0d5b39a06b7c@daenzer.net>
 <CAAxE2A60hubc8jbZkO101sxqVZKR8iub=GsfRovj17+P2zKDKQ@mail.gmail.com>
 <aee1e2b7-dd00-e24b-bcfc-e2299e31908b@daenzer.net>
 <CAAxE2A5g7tJG+94XxPr-mdGXkeL1GPMNMaYgc7ATEk7pxsiXfA@mail.gmail.com>
 <c343b89c-318f-d3af-d02e-4e6843c422f6@daenzer.net>
 <CAAxE2A5_tiOEvLVegNvkuvYrFcsU52H6EfCff3faKBZwPfbuYQ@mail.gmail.com>
 <a5a8428e-444a-34b9-7fa9-60e77582819a@daenzer.net>
 <CAAxE2A4ex4e-5ShqesZ8oXJj1CnmH6Enhvu4fXs9kDKu9NHeiQ@mail.gmail.com>
 <78fe31b2-2a0a-a1af-6af8-954d892e34ba@daenzer.net>
 <CAAxE2A7mh7pmbbszk1qnChPxZtVMzRBWY2GkB1DEcrEZ0t5m3w@mail.gmail.com>
 <4548bad6-2dc9-29be-b62e-33c181db77af@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <4548bad6-2dc9-29be-b62e-33c181db77af-otUistvHUpPR7s880joybQ@public.gmane.org>
Content-Language: en-US
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMTguMDUuMjAxNyB1bSAxMDoxNyBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IFtTTklQXQo+
IE9uZSB0aGluZyB0aGF0IG1pZ2h0IGhlbHAgd291bGQgYmUgaWYgd2UgY291bGQgc3dhcCBpbmRp
dmlkdWFsIG1lbW9yeQo+IG5vZGVzIGJldHdlZW4gdmlzaWJsZSBhbmQgaW52aXNpYmxlIFZSQU0g
Zm9yIENQVSBwYWdlIGZhdWx0cywgaW5zdGVhZCBvZgo+IG1vdmluZy9ldmljdGluZyB3aG9sZSBC
T3MuIENocmlzdGlhbiwgZG8geW91IHRoaW5rIHNvbWV0aGluZyBsaWtlIHRoYXQKPiB3b3VsZCBi
ZSBwb3NzaWJsZT8KSSd2ZSBsb29rZWQgaW50byB0aGlzIHdoaWxlIHdvcmtpbmcgb24gc3BsaXR0
aW5nIFZSQU0gYWxsb2NhdGlvbnMgaW50byAKc21hbGxlciBub2RlcyBhbmQgdGhlIGFuc3dlciBp
cyBub3BlLCBub3QgYXQgYWxsLgoKV2Ugd291bGQgcHJldHR5IG11Y2ggbmVlZCB0byByZXdyaXRl
IHdob2xlIFRUTSBmcm9tIEJPIGJhc2VkIHRvIHBhZ2UgCmJhc2VkLiBPdGhlcndpc2UgeW91IGp1
c3QgaGF2ZSB3YXkgdG8gbXVjaCBvdmVyaGVhZCB3aXRoIGFsbCB0aG9zZSB0dG0gCm9iamVjdHMg
YXJvdW5kLgoKQW5kIHdoZW4gd2UgcmVhbGx5IHdhbnQgdGhpcyBzdGVwIEkgd291bGQgcmF0aGVy
IHdhaXQgZm9yIEhNTSB0byBsYW5kIAphbmQgdXNlIHRoYXQgaW5zdGVhZC4KCkNocmlzdGlhbi4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
