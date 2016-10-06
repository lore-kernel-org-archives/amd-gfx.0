From: =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: initialize the context reset_counter in
 amdgpu_ctx_init
Date: Thu, 6 Oct 2016 17:02:05 +0200
Message-ID: <7fb5612e-3421-93c4-7f18-6f597be99d15@amd.com>
References: <1475567106-5818-1-git-send-email-nhaehnle@gmail.com>
 <2d749b1b-5d1b-f0bc-502b-358acf09e04a@vodafone.de>
 <CAAxE2A55JNWJ3hP5MtbHA=Jz_5bKQDnfvvTrwvW-g2LiDf8TrA@mail.gmail.com>
 <CADnq5_O8-D7hS5riU-7izo-jxh7fLTMYfpevcbBJqJHbKmKXjQ@mail.gmail.com>
 <CAAxE2A6FHmQhfzxAiq9-pMi+LkyJ6PAqvZi_-MV-xX1sZ_vv-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A6FHmQhfzxAiq9-pMi+LkyJ6PAqvZi_-MV-xX1sZ_vv-A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMDYuMTAuMjAxNiAxNjo0MywgTWFyZWsgT2zFocOhayB3cm90ZToKPiBPbiBUaHUsIE9jdCA2
LCAyMDE2IGF0IDQ6MjQgUE0sIEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPiB3
cm90ZToKPj4gT24gVGh1LCBPY3QgNiwgMjAxNiBhdCA2OjI4IEFNLCBNYXJlayBPbMWhw6FrIDxt
YXJhZW9AZ21haWwuY29tPiB3cm90ZToKPj4+IERvIHdlIG5lZWQgdG8gYnVtcCB0aGUgRFJNIHZl
cnNpb24gZm9yIHRoaXMgYnVnIGZpeD8KPj4+Cj4+Cj4+IEFsdGVybmF0aXZlbHksIHdlIGNvdWxk
IGp1c3QgY2Mgc3RhYmxlLiAgQmVpbmcgdGhhdCB0aGUgd2hvbGUgcmVzZXQKPj4gaGFuZGxpbmcg
aXMgbWVzYSBpcyB0aWxsIGtpbmQgb2YgdXAgaW4gdGhlIGFpciwgSSdtIG5vdCBzdXJlIGhvdwo+
PiBjcml0aWNhbCBpdCBpcy4KPgo+IFRoZSBNZXNhIHBhcnQgaXMgYWN0dWFsbHkgY29tcGxldGUu
IFRoZSBwcm9ibGVtIGlzIHRoYXQgaWYgYW4KPiBhcHBsaWNhdGlvbiByZXF1ZXN0cyB0aGUgR0xf
TE9TRV9DT05URVhUX09OX1JFU0VUIHN0cmF0ZWd5LCBhbgo+IGluY29ycmVjdCByZXNldCBjb3Vu
dGVyIHJldHVybmVkIGJ5IHRoZSBrZXJuZWwgd2lsbCBhdXRvbWF0aWNhbGx5IGtpbGwKPiB0aGUg
T3BlbkdMIGNvbnRleHQgKGJ5IHNldHRpbmcgdGhlIG5vLW9wIGRpc3BhdGNoKSwgc28gaXQncyBh
IHByZXR0eQo+IHNlcmlvdXMgaXNzdWUgYW5kIHRoZSBrZXJuZWwgc2hvdWxkIHJldHVybiBjb3Jy
ZWN0IHZhbHVlcyByZWdhcmRsZXNzCj4gb2YgdGhlIHN0YXRlIG9mIEdQVSByZXNldCB0aGVyZS4g
SWYgdGhlIGtlcm5lbCByZXR1cm5zIGFuIGluY29ycmVjdAo+IHJlc2V0IGNvdW50ZXIsIHdlIG5l
ZWQgYSB2ZXJzaW9uIGJ1bXAgZm9yIHRoZSBmaXguCgpZZWFoLCB0aGF0IHNlZW1zIHRvIGJlIHRo
ZSBzYWZlc3Qgc29sdXRpb24uCgpOaWNvbGFpCgo+Cj4gTWFyZWsKPgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
