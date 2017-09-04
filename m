From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm] libdrm_amdgpu: add kernel semaphore support
Date: Tue, 5 Sep 2017 07:15:14 +1000
Message-ID: <CAPM=9tx0mJXQ2mSLcAA2GvL-j_XX6QB05Vk9aw+Ta5nbyhCxoQ@mail.gmail.com>
References: <20170706011749.4217-1-airlied@gmail.com>
 <CAAxE2A6Fco40WfJy9kt5usntnv2GP92PjRiw9mcUfPrs+jr+Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A6Fco40WfJy9kt5usntnv2GP92PjRiw9mcUfPrs+jr+Xw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMiBTZXB0ZW1iZXIgMjAxNyBhdCAwMTozNiwgTWFyZWsgT2zFocOhayA8bWFyYWVvQGdtYWls
LmNvbT4gd3JvdGU6Cj4gT24gVGh1LCBKdWwgNiwgMjAxNyBhdCAzOjE3IEFNLCBEYXZlIEFpcmxp
ZSA8YWlybGllZEBnbWFpbC5jb20+IHdyb3RlOgo+PiBGcm9tOiBEYXZlIEFpcmxpZSA8YWlybGll
ZEByZWRoYXQuY29tPgo+Pgo+PiBUaGlzIGFkZHMga2VybmVsIHNlbWFwaG9yZSBzdXBwb3J0IHRv
IHRoZSBjb21tYW5kIHN1Ym1pc3Npb24KPj4gaW50ZXJmYWNlIGluIHdoYXQgc2hvdWxkIGJlIGEg
YmFja3dhcmRzIGNvbXBhdGlibGUgbWFubmVyLAo+PiBpdCBhZGRzIGEgbmV3IGNvbW1hbmQgc3Vi
bWlzc2lvbiBBUEkuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IERhdmUgQWlybGllIDxhaXJsaWVkQHJl
ZGhhdC5jb20+Cj4+IC0tLQo+PiAgYW1kZ3B1L2FtZGdwdS5oICAgIHwgIDI5ICsrKysrKysrKysr
Ky0KPj4gIGFtZGdwdS9hbWRncHVfY3MuYyB8IDExOCArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLQo+PiAgMiBmaWxlcyBjaGFuZ2VkLCAxMzggaW5z
ZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2FtZGdwdS9hbWRn
cHUuaCBiL2FtZGdwdS9hbWRncHUuaAo+PiBpbmRleCAxOTAxZmE4Li42NDliNjZlIDEwMDY0NAo+
PiAtLS0gYS9hbWRncHUvYW1kZ3B1LmgKPj4gKysrIGIvYW1kZ3B1L2FtZGdwdS5oCj4+IEBAIC0z
NjksNiArMzY5LDE2IEBAIHN0cnVjdCBhbWRncHVfY3NfcmVxdWVzdCB7Cj4+ICAgICAgICAgc3Ry
dWN0IGFtZGdwdV9jc19mZW5jZV9pbmZvIGZlbmNlX2luZm87Cj4+ICB9Owo+Pgo+PiArc3RydWN0
IGFtZGdwdV9jc19yZXF1ZXN0X3N5bmNvYmogewo+PiArICAgICAgIC8qCj4+ICsgICAgICAgICoK
Pj4gKyAgICAgICAgKi8KPgo+IERpZCB5b3UgbWVhbiB0byBmaWxsIGluIHRoZSBjb21tZW50IGhl
cmU/Cj4KPiBBbHNvLCBpcyB0aGlzIGludGVyZmFjZSByZWxldmFudCB3aXRoIHRoZSByYXcgQ1Mg
QVBJPwoKVGhpcyBwYXRjaCBpc24ndCByZXF1aXJlZCBhbnltb3JlLiBUaGUgcmF3IENTIGludGVy
ZmFjZSByZXBsYWNlZCBpdC4KCkRhdmUuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
