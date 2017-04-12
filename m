From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/8] sync_file: add support for a semaphore object
Date: Thu, 13 Apr 2017 05:05:27 +1000
Message-ID: <CAPM=9tyiKAH-T2rxwcqxc=LWZ8o_5TyxV3GVhy_JKZv3PZQsCw@mail.gmail.com>
References: <20170411032220.21101-1-airlied@gmail.com>
 <20170411032220.21101-6-airlied@gmail.com>
 <20170411075057.GA2724@nuc-i3427.alporthouse.com>
 <CAPM=9tzgNoSXPoZfJbRcoRmGZL9gENo+TTZCbauMjB7mwayZxw@mail.gmail.com>
 <20170412103116.GL4250@nuc-i3427.alporthouse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170412103116.GL4250-aII6DKEyn0pWYbfKqPwjAkR8Iwp7RQ6xAL8bYrjMMd8@public.gmane.org>
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
To: Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

Pj4KPj4gTm90IHN1cmUgd2hhdCB0aGUgYmVzdCBzZW1hbnRpY3MgYXJlIHRoZXJlLCBhbnkgb3Bp
bmlvbnMgb24gYmFycmluZwo+PiB3YWtldXBzL3BvbGxpbmcgb24gc2VtYXBob3JlIHN5bmNfZmls
ZXMsIGFuZCBqdXN0IHB1bnRpbmcgdGhpcwo+PiB1bnRpbCB3ZSBuZWVkIGl0Lgo+Cj4gSSB0aGlu
ayBnZXR0aW5nIGl0IHJpZ2h0IG5vdyB3aWxsIG1ha2Ugd3JpdGluZyBzd19zeW5jLWVzcXVlIChp
LmUuIGNwdSkKPiB0ZXN0cyBlYXNpZXIgYW5kIG1vcmUgY29tcGxldGUuCgpJIGp1c3QgZG9uJ3Qg
aGF2ZSBhbnkgdXNlIGNhc2UgZm9yIGl0LCBzbyB3ZSB3b3VsZCBiZSB3cml0aW5nIGNvZGUgdG8K
d3JpdGUgdGVzdHMgZm9yIGl0LgoKVGhhdCBkb2Vzbid0IHNlZW0gc21hcnQuCgpJZiB0aGVyZSBp
cyBhIGZ1dHVyZSBub24tdGVzdGluZyB1c2UgY2FzZSwgdGhlIEFQSSBpcyBleHByZXNzaXZlCmVu
b3VnaCBmb3Igc29tZW9uZQp0byBhZGQgYSBmbGFnIG9yIG5ldyBzeW5jIG9iaiB0byBhbGxvdyBw
b2xsaW5nIGFuZCB0byBhZGQgc3VwcG9ydCBpbiBhCm5pY2UgZWFzaWx5CmRpZ2VzdGlibGUgcGF0
Y2guCgpEYXZlLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
