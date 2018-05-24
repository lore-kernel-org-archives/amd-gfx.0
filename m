From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: GPU hang trying to run OpenCL kernels on x86_64
Date: Thu, 24 May 2018 10:30:56 +0200
Message-ID: <22178876-688c-b4fe-d40e-1bab28024603@daenzer.net>
References: <CAEzXK1p3SnOnduP0nL1D1pNWH1LTWwApEs7QnQPTFDdBBiHLXA@mail.gmail.com>
 <CY4PR12MB13045EA9BCBFAB20D698BA86FE860@CY4PR12MB1304.namprd12.prod.outlook.com>
 <CAEzXK1rJbXSpLUm=XQTLvySM4HJ45G9fQ0WCTPhnvdPETwUaYA@mail.gmail.com>
 <53cc38f2-e94a-1514-0a03-303101db2f88@daenzer.net>
 <CAEzXK1qHtfOBgismLvNy_x+NcMw78288AuwovBR-JmRwqpDmGQ@mail.gmail.com>
 <CAEzXK1oM6b1bV3R3ezwD4eYrJXWV9+cdUFMC4q5+1bPkpmJFqQ@mail.gmail.com>
 <CAEzXK1qRWkL67rG40jk4Odqm8AjbDvnnaCsDycLPRcPXXPL-KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAEzXK1qRWkL67rG40jk4Odqm8AjbDvnnaCsDycLPRcPXXPL-KQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?Q?Lu=c3=ads_Mendes?= <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Abramov, Slava" <Slava.Abramov-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOC0wNS0yNCAxMjowNiBBTSwgTHXDrXMgTWVuZGVzIHdyb3RlOgo+IEkndmUgdHJpZWQg
TGludXggNC4xNy1yYzYgd2l0aCBVYnVudHUgMTguMDQgb24gVHlhbiBTNzAwMiBhbmQgSSBhbSBu
b3QgZXZlbgo+IGFibGUgc2VlIGxpZ2h0ZG0vZ2RtMyBhcyBzeXN0ZW0gaGFuZ3Mgd2hlbiBzdGFy
dGluZyBYLgo+IEhhdmluZyBTUi1JT1YgZW5hYmxlZCBvciBkaXNhYmxlZCBtYWtlcyBubyBkaWZm
ZXJlbmNlLgo+IFRlc3RlZCB3aXRoIEFNRCBSWCA0NjAuCj4gV2hlbiBYIGlzIHN1cHBvc2VkIHRv
IHN0YXJ0IHRoZSBzeXN0ZW0gaGFuZ3MgYW5kIG9ubHkgYSByZWN0YW5ndWxhciByZWdpb24KPiBv
biB0aGUgdG9wIGxlZnQgY29ybmVyIHNjcmVlbiByZW1haW5zIHdpdGggY29uc29sZSB0ZXh0IG1l
c3NhZ2VzIGZyb20gdGhlCj4gYm9vdCBwcm9jZXNzIHdoaWxlIHRoZSByZW1haW5pbmcgb2YgdGhl
IHNjcmVlbiBpcyBqdXN0IGJsYWNrLiBJIGFtIHVuYWJsZQo+IHRvIGRvIGFueXRoaW5nIHdpdGgg
dGhlIGtleWJvYXJkLCBzd2l0Y2hpbmcgdG8gY29uc29sZSBkb2VzIG5vdCB3b3JrLAo+IGN0cmwt
YWx0LWRlbCBhbHNvIGRvZXNuJ3Qgd29yay4gSSd2ZSB0byBkbyBhIGNvbGQgcmVzZXQuCgpDYW4g
eW91IGlzb2xhdGUgd2hpY2ggY2hhbmdlIGludHJvZHVjZWQgdGhpcyBuZXcgaXNzdWUgd2l0aCBn
aXQgYmlzZWN0PwoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8
ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lh
c3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
