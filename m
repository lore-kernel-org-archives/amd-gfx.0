From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 2/4] drm/amdkfd: Adding new IOCTL for scratch memory
Date: Tue, 15 Aug 2017 10:24:22 +0200
Message-ID: <b114b316-1142-11b8-6393-5f903bb2d663@vodafone.de>
References: <1502513265-14281-1-git-send-email-Felix.Kuehling@amd.com>
 <1502513265-14281-3-git-send-email-Felix.Kuehling@amd.com>
 <CAFCwf11z1Uo9jd82XAGrapXA44KpY+KrV69nbXLkoX6v10_gig@mail.gmail.com>
 <22ab982e-a1b1-5d61-9eaa-f9c149cf3d5e@amd.com>
 <c310b952-116b-376c-0794-232e69f88592@vodafone.de>
 <33308ac3-bdf2-21ac-2122-b43702fdd95f@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <33308ac3-bdf2-21ac-2122-b43702fdd95f-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMTQuMDguMjAxNyB1bSAxNzozMSBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+IFtTTklQXQo+
IFJlcGVhdGluZyB0aGUgc2FtZSBhcmd1bWVudCBJIG1hZGUgb24gYW5vdGhlciBlbWFpbDoKCkNv
bW1lbnRlZCBvbiB0aGF0IGluIHRoZSBvdGhlciBtYWlsLCBsZXQncyBrZWVwIHRoZSBkaXNjdXNz
aW9uIG9uIHRoaXMgCnRvcGljIHRoZXJlLgoKPj4gQlRXOiBXaGF0IGV4YWN0bHkgdGhpcyB0aGlz
IGdvb2QgZm9yPwo+IFNjcmF0Y2ggbWVtb3J5IGlzIHByaXZhdGUgbWVtb3J5IHBlciB3b3JrLWl0
ZW0uIEl0J3MgdXNlZCB3aGVuIGEgc2hhZGVyCj4gcHJvZ3JhbSBoYXMgdG9vIGZldyByZWdpc3Rl
cnMgYXZhaWxhYmxlLiBXaXRoIEhTQSB3ZSB1c2UgZmxhdCBzY3JhdGNoCj4gYWRkcmVzc2luZywg
d2hlcmUgc2hhZGVycyBjYW4gYWNjZXNzIHByaXZhdGUgbWVtb3J5IGluIGEgc3BlY2lhbCBzY3Jh
dGNoCj4gYXBlcnR1cmUgdXNpbmcgbm9ybWFsIG1lbW9yeSBpbnN0cnVjdGlvbnMuIFVzaW5nIHRo
ZSBzYW1lIHZpcnR1YWwKPiBhZGRyZXNzLCBlYWNoIHdvcmsgaXRlbSBnZXRzIGl0cyBvd24gcHJp
dmF0ZSBwaWVjZSBvZiBtZW1vcnkuIFRoZQo+IGhhcmR3YXJlIGRvZXMgdGhlIGFkZHJlc3MgdHJh
bnNsYXRpb24gZnJvbSB0aGUgVkEgaW4gdGhlIHByaXZhdGUKPiBhcGVydHVyZSB0byBhIHNjcmF0
Y2gtYmFja2luZyBWQS4gVGhlIGFwcGxpY2F0aW9uIGlzIHJlc3BvbnNpYmxlIGZvcgo+IGFsbG9j
YXRpbmcgdGhlIG1lbW9yeSB0byBiYWNrIHRoYXQgc2NyYXRjaCBhcmVhLCBhbmQgdG8gbWFwIGl0
IHNvbWV3aGVyZQo+IGluIGl0cyB2aXJ0dWFsIGFkZHJlc3Mgc3BhY2UuCj4KPiBUaGlzIGlvY3Rs
IHRlbGxzIHRoZSBoYXJkd2FyZSAob3IgSFdTIGZpcm13YXJlKSB0aGUgVkEgb2YgdGhlIHNjcmF0
Y2gKPiBiYWNraW5nIG1lbW9yeS4KCk9rLCB5b3UndmUgZ290IG1lIGxvc3QgaGVyZS4gTm90IHRo
YXQgSSdtIGRlZXBseSBpbnRvIHRoYXQgc3R1ZmYsIGJ1dCBteSAKbGFzdCBzdGF0dXMgaXMgdGhh
dCB0aG9zZSBhcGVydHVyZXMgYXJlIGdsb2JhbCBhbmQgbm90IHBlci9wcm9jZXNzIG9yIFZNSUQu
CgpUaGF0IHdvdWxkIG1lYW4gdGhhdCB3aGVuIHR3byBwcm9jZXNzZXMgdHJ5IHRvIHNldCB0d28g
ZGlmZmVyZW50IAphZGRyZXNzZXMgd2UgYXJlIGNvbXBsZXRlbHkgbG9zdCBoZXJlLgoKQ2hyaXN0
aWFuLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
