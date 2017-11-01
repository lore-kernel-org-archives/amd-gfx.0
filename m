From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Mesa-dev] [PATCH] amdgpu: Add R600_DEBUG flag to reserve VMID
 per ctx.
Date: Wed, 1 Nov 2017 09:49:07 +0100
Message-ID: <06f3fefd-0058-832d-f114-7d41740810dd@gmail.com>
References: <1509464412-30394-1-git-send-email-andrey.grodzovsky@amd.com>
 <b269c18b-5520-2f26-2545-2b742ee34f2f@daenzer.net>
 <CAAxE2A4SM3ZZTrN+UUw5mncdSx8e7zMiSGvEE7BgssyVrnyNyw@mail.gmail.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A4SM3ZZTrN+UUw5mncdSx8e7zMiSGvEE7BgssyVrnyNyw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "mesa-dev-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <mesa-dev-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SSdtIG5vdCAxMDAlIHN1cmUgdGhhdCBwYXRjaCB3YXMgY29ycmVjdC4KCldoZW4gaXMgYW1kZ3B1
X2N0eF9jcmVhdGUoKSBjYWxsZWQ/IFRoZSBWTUlEIGlzIHJlc2VydmVkIGZvciB0aGUgd2hvbGUg
CnByb2Nlc3MsIG5vdCBqdXN0IGEgY29udGV4dC4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCkFtIDMx
LjEwLjIwMTcgdW0gMTY6NTcgc2NocmllYiBNYXJlayBPbMWhw6FrOgo+IEkgYWRkcmVzc2VkIHRo
ZSBmZWVkYmFjayBhbmQgcHVzaGVkIHRoZSBwYXRjaC4KPgo+IE1hcmVrCj4KPiBPbiBUdWUsIE9j
dCAzMSwgMjAxNyBhdCA0OjUwIFBNLCBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRhZW56ZXIubmV0
PiB3cm90ZToKPj4gT24gMzEvMTAvMTcgMDQ6NDAgUE0sIEFuZHJleSBHcm9kem92c2t5IHdyb3Rl
Ogo+Pj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IEdyb2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5
QGFtZC5jb20+Cj4+IFsuLi5dCj4+Cj4+PiBkaWZmIC0tZ2l0IGEvc3JjL2dhbGxpdW0vd2luc3lz
L2FtZGdwdS9kcm0vYW1kZ3B1X2NzLmMgYi9zcmMvZ2FsbGl1bS93aW5zeXMvYW1kZ3B1L2RybS9h
bWRncHVfY3MuYwo+Pj4gaW5kZXggOGY0M2U5My4uMTE1NTQ5MiAxMDA2NDQKPj4+IC0tLSBhL3Ny
Yy9nYWxsaXVtL3dpbnN5cy9hbWRncHUvZHJtL2FtZGdwdV9jcy5jCj4+PiArKysgYi9zcmMvZ2Fs
bGl1bS93aW5zeXMvYW1kZ3B1L2RybS9hbWRncHVfY3MuYwo+Pj4gQEAgLTI1Niw2ICsyNTYsMTQg
QEAgc3RhdGljIHN0cnVjdCByYWRlb25fd2luc3lzX2N0eCAqYW1kZ3B1X2N0eF9jcmVhdGUoc3Ry
dWN0IHJhZGVvbl93aW5zeXMgKndzKQo+Pj4gICAgICAgICBnb3RvIGVycm9yX2NyZWF0ZTsKPj4+
ICAgICAgfQo+Pj4KPj4+ICsgICBpZiAoY3R4LT53cy0+cmVzZXJ2ZV92bWlkKSB7Cj4+PiArICAg
ICAgICByID0gYW1kZ3B1X3ZtX3Jlc2VydmVfdm1pZChjdHgtPmN0eCwgMCk7Cj4+PiArICAgICAg
ICBpZiAocikgewo+Pj4gKyAgICAgICAgICAgICBmcHJpbnRmKHN0ZGVyciwgImFtZGdwdTogYW1k
Z3B1X2NzX2N0eF9jcmVhdGUgZmFpbGVkLiAoJWkpXG4iLCByKTsKPj4gVGhpcyBzaG91bGQgc2F5
ICJhbWRncHU6IGFtZGdwdV92bV9yZXNlcnZlX3ZtaWQgZmFpbGVkLiAoJWkpXG4iLgo+Pgo+Pgo+
PiAtLQo+PiBFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAg
ICAgICAgaHR0cDovL3d3dy5hbWQuY29tCj4+IExpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAg
ICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3Blcgo+PiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBtZXNhLWRldiBtYWlsaW5n
IGxpc3QKPj4gbWVzYS1kZXZAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+IGh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vbWVzYS1kZXYKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
