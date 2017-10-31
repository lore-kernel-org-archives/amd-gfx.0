From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Mesa-dev] [PATCH] amdgpu: Add R600_DEBUG flag to reserve VMID
 per ctx.
Date: Tue, 31 Oct 2017 16:57:12 +0100
Message-ID: <CAAxE2A4SM3ZZTrN+UUw5mncdSx8e7zMiSGvEE7BgssyVrnyNyw@mail.gmail.com>
References: <1509464412-30394-1-git-send-email-andrey.grodzovsky@amd.com>
 <b269c18b-5520-2f26-2545-2b742ee34f2f@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b269c18b-5520-2f26-2545-2b742ee34f2f-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "mesa-dev-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <mesa-dev-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SSBhZGRyZXNzZWQgdGhlIGZlZWRiYWNrIGFuZCBwdXNoZWQgdGhlIHBhdGNoLgoKTWFyZWsKCk9u
IFR1ZSwgT2N0IDMxLCAyMDE3IGF0IDQ6NTAgUE0sIE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFl
bnplci5uZXQ+IHdyb3RlOgo+IE9uIDMxLzEwLzE3IDA0OjQwIFBNLCBBbmRyZXkgR3JvZHpvdnNr
eSB3cm90ZToKPj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IEdyb2R6b3Zza3kgPGFuZHJleS5ncm9k
em92c2t5QGFtZC5jb20+Cj4KPiBbLi4uXQo+Cj4+IGRpZmYgLS1naXQgYS9zcmMvZ2FsbGl1bS93
aW5zeXMvYW1kZ3B1L2RybS9hbWRncHVfY3MuYyBiL3NyYy9nYWxsaXVtL3dpbnN5cy9hbWRncHUv
ZHJtL2FtZGdwdV9jcy5jCj4+IGluZGV4IDhmNDNlOTMuLjExNTU0OTIgMTAwNjQ0Cj4+IC0tLSBh
L3NyYy9nYWxsaXVtL3dpbnN5cy9hbWRncHUvZHJtL2FtZGdwdV9jcy5jCj4+ICsrKyBiL3NyYy9n
YWxsaXVtL3dpbnN5cy9hbWRncHUvZHJtL2FtZGdwdV9jcy5jCj4+IEBAIC0yNTYsNiArMjU2LDE0
IEBAIHN0YXRpYyBzdHJ1Y3QgcmFkZW9uX3dpbnN5c19jdHggKmFtZGdwdV9jdHhfY3JlYXRlKHN0
cnVjdCByYWRlb25fd2luc3lzICp3cykKPj4gICAgICAgIGdvdG8gZXJyb3JfY3JlYXRlOwo+PiAg
ICAgfQo+Pgo+PiArICAgaWYgKGN0eC0+d3MtPnJlc2VydmVfdm1pZCkgewo+PiArICAgICAgICBy
ID0gYW1kZ3B1X3ZtX3Jlc2VydmVfdm1pZChjdHgtPmN0eCwgMCk7Cj4+ICsgICAgICAgIGlmIChy
KSB7Cj4+ICsgICAgICAgICAgICAgZnByaW50ZihzdGRlcnIsICJhbWRncHU6IGFtZGdwdV9jc19j
dHhfY3JlYXRlIGZhaWxlZC4gKCVpKVxuIiwgcik7Cj4KPiBUaGlzIHNob3VsZCBzYXkgImFtZGdw
dTogYW1kZ3B1X3ZtX3Jlc2VydmVfdm1pZCBmYWlsZWQuICglaSlcbiIuCj4KPgo+IC0tCj4gRWFy
dGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6
Ly93d3cuYW1kLmNvbQo+IExpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAg
ICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3Blcgo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4gbWVzYS1kZXYgbWFpbGluZyBsaXN0Cj4gbWVzYS1k
ZXZAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9tZXNhLWRldgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
