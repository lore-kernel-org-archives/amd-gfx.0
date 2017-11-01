From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Subject: Re: [PATCH] amdgpu: Add R600_DEBUG flag to reserve VMID
 per ctx.
Date: Wed, 1 Nov 2017 14:39:11 +0100
Message-ID: <CAAxE2A4nQJCCeUVhr3g=UnUnyzFLHdkBzANj9yc-v-qiTGvfkw@mail.gmail.com>
References: <1509464412-30394-1-git-send-email-andrey.grodzovsky@amd.com>
 <b269c18b-5520-2f26-2545-2b742ee34f2f@daenzer.net>
 <CAAxE2A4SM3ZZTrN+UUw5mncdSx8e7zMiSGvEE7BgssyVrnyNyw@mail.gmail.com>
 <06f3fefd-0058-832d-f114-7d41740810dd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <mesa-dev-bounces@lists.freedesktop.org>
In-Reply-To: <06f3fefd-0058-832d-f114-7d41740810dd@gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/mesa-dev>,
 <mailto:mesa-dev-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/mesa-dev>
List-Post: <mailto:mesa-dev@lists.freedesktop.org>
List-Help: <mailto:mesa-dev-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/mesa-dev>,
 <mailto:mesa-dev-request@lists.freedesktop.org?subject=subscribe>
Errors-To: mesa-dev-bounces@lists.freedesktop.org
Sender: "mesa-dev" <mesa-dev-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "mesa-dev@lists.freedesktop.org" <mesa-dev@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

WWVhaCwgaXQgc2hvdWxkIGJlIGNhbGxlZCB3aGVuIHRoZSB3aW5zeXMgaXMgY3JlYXRlZC4KCk1h
cmVrCgpPbiBXZWQsIE5vdiAxLCAyMDE3IGF0IDk6NDkgQU0sIENocmlzdGlhbiBLw7ZuaWcKPGNr
b2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiB3cm90ZToKPiBJJ20gbm90IDEwMCUgc3Vy
ZSB0aGF0IHBhdGNoIHdhcyBjb3JyZWN0Lgo+Cj4gV2hlbiBpcyBhbWRncHVfY3R4X2NyZWF0ZSgp
IGNhbGxlZD8gVGhlIFZNSUQgaXMgcmVzZXJ2ZWQgZm9yIHRoZSB3aG9sZQo+IHByb2Nlc3MsIG5v
dCBqdXN0IGEgY29udGV4dC4KPgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+Cj4KPiBBbSAzMS4x
MC4yMDE3IHVtIDE2OjU3IHNjaHJpZWIgTWFyZWsgT2zFocOhazoKPj4KPj4gSSBhZGRyZXNzZWQg
dGhlIGZlZWRiYWNrIGFuZCBwdXNoZWQgdGhlIHBhdGNoLgo+Pgo+PiBNYXJlawo+Pgo+PiBPbiBU
dWUsIE9jdCAzMSwgMjAxNyBhdCA0OjUwIFBNLCBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRhZW56
ZXIubmV0PiB3cm90ZToKPj4+Cj4+PiBPbiAzMS8xMC8xNyAwNDo0MCBQTSwgQW5kcmV5IEdyb2R6
b3Zza3kgd3JvdGU6Cj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgR3JvZHpvdnNreSA8
YW5kcmV5Lmdyb2R6b3Zza3lAYW1kLmNvbT4KPj4+Cj4+PiBbLi4uXQo+Pj4KPj4+PiBkaWZmIC0t
Z2l0IGEvc3JjL2dhbGxpdW0vd2luc3lzL2FtZGdwdS9kcm0vYW1kZ3B1X2NzLmMKPj4+PiBiL3Ny
Yy9nYWxsaXVtL3dpbnN5cy9hbWRncHUvZHJtL2FtZGdwdV9jcy5jCj4+Pj4gaW5kZXggOGY0M2U5
My4uMTE1NTQ5MiAxMDA2NDQKPj4+PiAtLS0gYS9zcmMvZ2FsbGl1bS93aW5zeXMvYW1kZ3B1L2Ry
bS9hbWRncHVfY3MuYwo+Pj4+ICsrKyBiL3NyYy9nYWxsaXVtL3dpbnN5cy9hbWRncHUvZHJtL2Ft
ZGdwdV9jcy5jCj4+Pj4gQEAgLTI1Niw2ICsyNTYsMTQgQEAgc3RhdGljIHN0cnVjdCByYWRlb25f
d2luc3lzX2N0eAo+Pj4+ICphbWRncHVfY3R4X2NyZWF0ZShzdHJ1Y3QgcmFkZW9uX3dpbnN5cyAq
d3MpCj4+Pj4gICAgICAgICBnb3RvIGVycm9yX2NyZWF0ZTsKPj4+PiAgICAgIH0KPj4+Pgo+Pj4+
ICsgICBpZiAoY3R4LT53cy0+cmVzZXJ2ZV92bWlkKSB7Cj4+Pj4gKyAgICAgICAgciA9IGFtZGdw
dV92bV9yZXNlcnZlX3ZtaWQoY3R4LT5jdHgsIDApOwo+Pj4+ICsgICAgICAgIGlmIChyKSB7Cj4+
Pj4gKyAgICAgICAgICAgICBmcHJpbnRmKHN0ZGVyciwgImFtZGdwdTogYW1kZ3B1X2NzX2N0eF9j
cmVhdGUgZmFpbGVkLgo+Pj4+ICglaSlcbiIsIHIpOwo+Pj4KPj4+IFRoaXMgc2hvdWxkIHNheSAi
YW1kZ3B1OiBhbWRncHVfdm1fcmVzZXJ2ZV92bWlkIGZhaWxlZC4gKCVpKVxuIi4KPj4+Cj4+Pgo+
Pj4gLS0KPj4+IEVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAg
ICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KPj4+IExpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3Qg
ICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3Blcgo+Pj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4+IG1lc2EtZGV2IG1h
aWxpbmcgbGlzdAo+Pj4gbWVzYS1kZXZAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+PiBodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL21lc2EtZGV2Cj4KPgo+Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCm1lc2EtZGV2IG1h
aWxpbmcgbGlzdAptZXNhLWRldkBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9tZXNhLWRldgo=
