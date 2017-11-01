From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] amdgpu: Add R600_DEBUG flag to reserve VMID per ctx.
Date: Wed, 1 Nov 2017 09:43:53 +0100
Message-ID: <40a3f3be-a093-7fb2-1144-9ecb6decd149@gmail.com>
References: <1509464412-30394-1-git-send-email-andrey.grodzovsky@amd.com>
 <b269c18b-5520-2f26-2545-2b742ee34f2f@daenzer.net>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b269c18b-5520-2f26-2545-2b742ee34f2f-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Cc: mesa-dev-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Marek.Olsak-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMzEuMTAuMjAxNyB1bSAxNjo1MCBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDMxLzEw
LzE3IDA0OjQwIFBNLCBBbmRyZXkgR3JvZHpvdnNreSB3cm90ZToKPj4gU2lnbmVkLW9mZi1ieTog
QW5kcmV5IEdyb2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+Cj4gWy4uLl0KPgo+
PiBkaWZmIC0tZ2l0IGEvc3JjL2dhbGxpdW0vd2luc3lzL2FtZGdwdS9kcm0vYW1kZ3B1X2NzLmMg
Yi9zcmMvZ2FsbGl1bS93aW5zeXMvYW1kZ3B1L2RybS9hbWRncHVfY3MuYwo+PiBpbmRleCA4ZjQz
ZTkzLi4xMTU1NDkyIDEwMDY0NAo+PiAtLS0gYS9zcmMvZ2FsbGl1bS93aW5zeXMvYW1kZ3B1L2Ry
bS9hbWRncHVfY3MuYwo+PiArKysgYi9zcmMvZ2FsbGl1bS93aW5zeXMvYW1kZ3B1L2RybS9hbWRn
cHVfY3MuYwo+PiBAQCAtMjU2LDYgKzI1NiwxNCBAQCBzdGF0aWMgc3RydWN0IHJhZGVvbl93aW5z
eXNfY3R4ICphbWRncHVfY3R4X2NyZWF0ZShzdHJ1Y3QgcmFkZW9uX3dpbnN5cyAqd3MpCj4+ICAg
ICAgICAgZ290byBlcnJvcl9jcmVhdGU7Cj4+ICAgICAgfQo+PiAgIAo+PiArICAgaWYgKGN0eC0+
d3MtPnJlc2VydmVfdm1pZCkgewo+PiArCSAgIHIgPSBhbWRncHVfdm1fcmVzZXJ2ZV92bWlkKGN0
eC0+Y3R4LCAwKTsKPj4gKwkgICBpZiAocikgewo+PiArCQlmcHJpbnRmKHN0ZGVyciwgImFtZGdw
dTogYW1kZ3B1X2NzX2N0eF9jcmVhdGUgZmFpbGVkLiAoJWkpXG4iLCByKTsKPiBUaGlzIHNob3Vs
ZCBzYXkgImFtZGdwdTogYW1kZ3B1X3ZtX3Jlc2VydmVfdm1pZCBmYWlsZWQuICglaSlcbiIuCgoK
Tm90IHN1cmUgd2hlbiBhbWRncHVfY3R4X2NyZWF0ZSgpIGlzIGNhbGxlZCwgYnV0IHRoZSBWTUlE
IGlzIHJlc2VydmVkIApwZXIgcHJvY2VzcyBub3QgcGVyIGNvbnRleHQuCgpDaHJpc3RpYW4uCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
