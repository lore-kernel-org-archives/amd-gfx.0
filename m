From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH xf86-video-amdgpu] glamor: Don't flush in BlockHandler
 with Xorg >= 1.19
Date: Mon, 6 Mar 2017 10:17:31 -0500
Message-ID: <CADnq5_N0goysXkwMxdFqUA-oke2LmMauhTWL37=wc=dTqCj-CQ@mail.gmail.com>
References: <20170306094950.992-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170306094950.992-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gTW9uLCBNYXIgNiwgMjAxNyBhdCA0OjQ5IEFNLCBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRh
ZW56ZXIubmV0PiB3cm90ZToKPiBGcm9tOiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJA
YW1kLmNvbT4KPgo+IFRoaXMgd2FzIG9ubHkgbmVjZXNzYXJ5IHdpdGggb2xkZXIgdmVyc2lvbnMg
Zm9yIGRyaXZpbmcgdGhlIEZCTyBjYWNoZQo+IGV4cGlyeSBtZWNoYW5pc20uCj4KPiBTaWduZWQt
b2ZmLWJ5OiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KClJldmlld2Vk
LWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cgo+IC0tLQo+ICBz
cmMvYW1kZ3B1X2ttcy5jIHwgMiArKwo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
Cj4KPiBkaWZmIC0tZ2l0IGEvc3JjL2FtZGdwdV9rbXMuYyBiL3NyYy9hbWRncHVfa21zLmMKPiBp
bmRleCBkNDhhZDQ4MGEuLjMxYzJlODZmMiAxMDA2NDQKPiAtLS0gYS9zcmMvYW1kZ3B1X2ttcy5j
Cj4gKysrIGIvc3JjL2FtZGdwdV9rbXMuYwo+IEBAIC0xMDM1LDggKzEwMzUsMTAgQEAgc3RhdGlj
IHZvaWQgQU1ER1BVQmxvY2tIYW5kbGVyX0tNUyhCTE9DS0hBTkRMRVJfQVJHU19ERUNMKQo+ICAg
ICAgICAgICAgICAgICB9Cj4gICAgICAgICB9Cj4KPiArI2lmIFhPUkdfVkVSU0lPTl9DVVJSRU5U
IDwgWE9SR19WRVJTSU9OX05VTUVSSUMoMSwxOSwwLDAsMCkKPiAgICAgICAgIGlmIChpbmZvLT51
c2VfZ2xhbW9yKQo+ICAgICAgICAgICAgICAgICBhbWRncHVfZ2xhbW9yX2ZsdXNoKHBTY3JuKTsK
PiArI2VuZGlmCj4KPiAgI2lmZGVmIEFNREdQVV9QSVhNQVBfU0hBUklORwo+ICAgICAgICAgYW1k
Z3B1X2RpcnR5X3VwZGF0ZShwU2Nybik7Cj4gLS0KPiAyLjExLjAKPgo+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QK
PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
