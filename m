From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] amdgpu: Add R600_DEBUG flag to reserve VMID
	per ctx.
Date: Tue, 31 Oct 2017 16:50:58 +0100
Message-ID: <b269c18b-5520-2f26-2545-2b742ee34f2f@daenzer.net>
References: <1509464412-30394-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <mesa-dev-bounces@lists.freedesktop.org>
In-Reply-To: <1509464412-30394-1-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-CA
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/mesa-dev>,
 <mailto:mesa-dev-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/mesa-dev>
List-Post: <mailto:mesa-dev@lists.freedesktop.org>
List-Help: <mailto:mesa-dev-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/mesa-dev>,
 <mailto:mesa-dev-request@lists.freedesktop.org?subject=subscribe>
Errors-To: mesa-dev-bounces@lists.freedesktop.org
Sender: "mesa-dev" <mesa-dev-bounces@lists.freedesktop.org>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: mesa-dev@lists.freedesktop.org, Marek.Olsak@amd.com, amd-gfx@lists.freedesktop.org, ckoenig.leichtzumerken@gmail.com
List-Id: amd-gfx.lists.freedesktop.org

T24gMzEvMTAvMTcgMDQ6NDAgUE0sIEFuZHJleSBHcm9kem92c2t5IHdyb3RlOgo+IFNpZ25lZC1v
ZmYtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPgoKWy4u
Ll0KCj4gZGlmZiAtLWdpdCBhL3NyYy9nYWxsaXVtL3dpbnN5cy9hbWRncHUvZHJtL2FtZGdwdV9j
cy5jIGIvc3JjL2dhbGxpdW0vd2luc3lzL2FtZGdwdS9kcm0vYW1kZ3B1X2NzLmMKPiBpbmRleCA4
ZjQzZTkzLi4xMTU1NDkyIDEwMDY0NAo+IC0tLSBhL3NyYy9nYWxsaXVtL3dpbnN5cy9hbWRncHUv
ZHJtL2FtZGdwdV9jcy5jCj4gKysrIGIvc3JjL2dhbGxpdW0vd2luc3lzL2FtZGdwdS9kcm0vYW1k
Z3B1X2NzLmMKPiBAQCAtMjU2LDYgKzI1NiwxNCBAQCBzdGF0aWMgc3RydWN0IHJhZGVvbl93aW5z
eXNfY3R4ICphbWRncHVfY3R4X2NyZWF0ZShzdHJ1Y3QgcmFkZW9uX3dpbnN5cyAqd3MpCj4gICAg
ICAgIGdvdG8gZXJyb3JfY3JlYXRlOwo+ICAgICB9Cj4gIAo+ICsgICBpZiAoY3R4LT53cy0+cmVz
ZXJ2ZV92bWlkKSB7Cj4gKwkgICByID0gYW1kZ3B1X3ZtX3Jlc2VydmVfdm1pZChjdHgtPmN0eCwg
MCk7Cj4gKwkgICBpZiAocikgewo+ICsJCWZwcmludGYoc3RkZXJyLCAiYW1kZ3B1OiBhbWRncHVf
Y3NfY3R4X2NyZWF0ZSBmYWlsZWQuICglaSlcbiIsIHIpOwoKVGhpcyBzaG91bGQgc2F5ICJhbWRn
cHU6IGFtZGdwdV92bV9yZXNlcnZlX3ZtaWQgZmFpbGVkLiAoJWkpXG4iLgoKCi0tIApFYXJ0aGxp
bmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3
dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAg
ICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwptZXNhLWRldiBtYWlsaW5nIGxpc3QKbWVzYS1kZXZAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vbWVzYS1kZXYK
