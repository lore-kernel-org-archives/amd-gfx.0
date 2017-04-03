From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm 3/3] amdgpu: add REPLACE and CLEAR checking for VA
 op (v2)
Date: Mon, 3 Apr 2017 12:54:25 +0200
Message-ID: <CAAxE2A5SZ93EoQ=hhu6oZj8ZfSNEZ5+NvZzRZzJYCONj7AW+8Q@mail.gmail.com>
References: <20170403082720.13166-1-nhaehnle@gmail.com>
 <20170403082720.13166-3-nhaehnle@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170403082720.13166-3-nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Nicolai_H=C3=A4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, =?UTF-8?Q?Nicolai_H=C3=A4hnle?= <nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gTW9uLCBBcHIgMywgMjAxNyBhdCAxMDoyNyBBTSwgTmljb2xhaSBIw6RobmxlIDxuaGFlaG5s
ZUBnbWFpbC5jb20+IHdyb3RlOgo+IEZyb206IEp1bndlaSBaaGFuZyA8SmVycnkuWmhhbmdAYW1k
LmNvbT4KPgo+IHYyOiBmaXggaW5kZW50Cj4KPiBTaWduZWQtb2ZmLWJ5OiBKdW53ZWkgWmhhbmcg
PEplcnJ5LlpoYW5nQGFtZC5jb20+Cj4gUmV2aWV3ZWQtYnk6IE5pY29sYWkgSMOkaG5sZSA8bmlj
b2xhaS5oYWVobmxlQGFtZC5jb20+Cj4gUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiAtLS0KPiAgYW1kZ3B1L2FtZGdwdV9iby5jIHwgNCAr
KystCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+
IGRpZmYgLS1naXQgYS9hbWRncHUvYW1kZ3B1X2JvLmMgYi9hbWRncHUvYW1kZ3B1X2JvLmMKPiBp
bmRleCBmNzI1YmZkLi44YmMxZWJkIDEwMDY0NAo+IC0tLSBhL2FtZGdwdS9hbWRncHVfYm8uYwo+
ICsrKyBiL2FtZGdwdS9hbWRncHVfYm8uYwo+IEBAIC02OTYsMjEgKzY5NiwyMyBAQCBpbnQgYW1k
Z3B1X2JvX3ZhX29wX3JhdyhhbWRncHVfZGV2aWNlX2hhbmRsZSBkZXYsCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgYW1kZ3B1X2JvX2hhbmRsZSBibywKPiAgICAgICAgICAgICAgICAgICAgICAg
ICB1aW50NjRfdCBvZmZzZXQsCj4gICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3Qgc2l6
ZSwKPiAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCBhZGRyLAo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIHVpbnQ2NF90IGZsYWdzLAo+ICAgICAgICAgICAgICAgICAgICAgICAgIHVp
bnQzMl90IG9wcykKPiAgewo+ICAgICAgICAgc3RydWN0IGRybV9hbWRncHVfZ2VtX3ZhIHZhOwo+
ICAgICAgICAgaW50IHI7Cj4KPiAtICAgICAgIGlmIChvcHMgIT0gQU1ER1BVX1ZBX09QX01BUCAm
JiBvcHMgIT0gQU1ER1BVX1ZBX09QX1VOTUFQKQo+ICsgICAgICAgaWYgKG9wcyAhPSBBTURHUFVf
VkFfT1BfTUFQICYmIG9wcyAhPSBBTURHUFVfVkFfT1BfVU5NQVAgJiYKPiArICAgICAgICAgICBv
cHMgIT0gQU1ER1BVX1ZBX09QX1JFUExBQ0UgJiYgb3BzICE9IEFNREdQVV9WQV9PUF9DTEVBUikK
PiArCgpTcHVyaW91cyBlbXB0eSBsaW5lPwoKT3RoZXIgdGhhbiB0aGF0LCB0aGUgc2VyaWVzIGlz
OgpSZXZpZXdlZC1ieTogTWFyZWsgT2zFocOhayA8bWFyZWsub2xzYWtAYW1kLmNvbT4KCkkgZG9u
J3Qga25vdyBob3cgRGF2ZSBmZWVscyBhYm91dCBwdXNoaW5nIHRoaXMgaW50byBsaWJkcm0gd2hl
biBpdCdzCm5vdCBpbiBMaW51cydzIHRyZWUuCgpNYXJlawpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
