From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Wrong shift in dce_v8_0_afmt_update_ACR() under dce_v8_0.c?
Date: Tue, 9 Aug 2016 00:30:16 -0400
Message-ID: <CADnq5_OSn=PwvPXQdxPM0DP69ct-WupLXO7=N=-vVe_r7qQNyw@mail.gmail.com>
References: <cd6f0c44-3307-ced9-aac6-fe6cbb8842ea@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <cd6f0c44-3307-ced9-aac6-fe6cbb8842ea-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gTW9uLCBBdWcgOCwgMjAxNiBhdCA1OjQzIFBNLCBBbGV4YW5kcmUgRGVtZXJzCjxhbGV4YW5k
cmUuZi5kZW1lcnNAZ21haWwuY29tPiB3cm90ZToKPiBIaSwKPgo+IFdoaWxlIGxvb2tpbmcgaW50
byBkY2VfdjhfMC5jLCBJIHN0dW1ibGVkIHVwb24gc29tZXRoaW5nIHRoYXQgbWlnaHQgYmUgd3Jv
bmcKPiBkY2VfdjhfMF9hZm10X3VwZGF0ZV9BQ1IoKS4gV2UgY2FuIHJlYWQ6Cj4KPiBXUkVHMzIo
bW1IRE1JX0FDUl8zMl8wICsgb2Zmc2V0LCAoYWNyLmN0c18zMmtoeiA8PAo+IEhETUlfQUNSXzQ0
XzBfX0hETUlfQUNSX0NUU180NF9fU0hJRlQpKTsKPgo+IEhvd2V2ZXIsIEknbSBtb3N0bHkgc3Vy
ZSBpdCBzaG91bGQgYmUgKGx1Y2tpbHksIHRoZSBzaGlmdCBpcyBvZiB0aGUgc2FtZQo+IHZhbHVl
KToKPgo+IFdSRUczMihtbUhETUlfQUNSXzMyXzAgKyBvZmZzZXQsIChhY3IuY3RzXzMya2h6IDw8
Cj4gSERNSV9BQ1JfMzJfMF9fSERNSV9BQ1JfQ1RTXzMyX19TSElGVCkpOwoKWWVhaCwgY29weS9w
YXN0ZSBlcnJvci4KCkFsZXgKCj4KPiBDaGVlcnMKPgo+IC0tCj4gQWxleGFuZHJlIERlbWVycwo+
Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQt
Z2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
