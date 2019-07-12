From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] drm/amd/display: Support clang option for stack alignment
Date: Fri, 12 Jul 2019 22:30:14 +0200
Message-ID: <CAK8P3a0vTwtDtxDhfmhzOViUp+DPzuJ_qsQsnVFw4B7oBaudTQ@mail.gmail.com>
References: <20190712093720.1461418-1-arnd@arndb.de>
 <CAKwvOd=Xdp_=G3UU9ubayeTvkKCJ9hak0a-7yK90-RPUBQKrpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAKwvOd=Xdp_=G3UU9ubayeTvkKCJ9hak0a-7yK90-RPUBQKrpw@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Duke Du <Duke.Du@amd.com>, clang-built-linux <clang-built-linux@googlegroups.com>, Charlene Liu <charlene.liu@amd.com>, Leo Li <sunpeng.li@amd.com>, Matthias Kaehlcke <mka@google.com>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, David Airlie <airlied@linux.ie>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Masahiro Yamada <yamada.masahiro@socionext.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gRnJpLCBKdWwgMTIsIDIwMTkgYXQgODo0OSBQTSAnTmljayBEZXNhdWxuaWVycycgdmlhIENs
YW5nIEJ1aWx0CkxpbnV4IDxjbGFuZy1idWlsdC1saW51eEBnb29nbGVncm91cHMuY29tPiB3cm90
ZToKPgo+IE9uIEZyaSwgSnVsIDEyLCAyMDE5IGF0IDI6MzcgQU0gQXJuZCBCZXJnbWFubiA8YXJu
ZEBhcm5kYi5kZT4gd3JvdGU6Cj4gPgo+ID4gQXMgcHJldmlvdXNseSBmaXhlZCBmb3IgZG1sIGlu
IGNvbW1pdCA0NzY5Mjc4ZTVjN2YgKCJhbWRncHUvZGMvZG1sOgo+ID4gU3VwcG9ydCBjbGFuZyBv
cHRpb24gZm9yIHN0YWNrIGFsaWdubWVudCIpIGFuZCBjYWxjcyBpbiBjb21taXQKPiA+IGNjMzJh
ZDhmNTU5YyAoImFtZGdwdS9kYy9jYWxjczogU3VwcG9ydCBjbGFuZyBvcHRpb24gZm9yIHN0YWNr
Cj4gPiBhbGlnbm1lbnQiKSwgZGNuMjAgdXNlcyBhbiBvcHRpb24gdGhhdCBpcyBub3QgYXZhaWxh
YmxlIHdpdGggY2xhbmc6Cj4gPgo+ID4gY2xhbmc6IGVycm9yOiB1bmtub3duIGFyZ3VtZW50OiAn
LW1wcmVmZXJyZWQtc3RhY2stYm91bmRhcnk9NCcKPiA+IHNjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6
MjgxOiByZWNpcGUgZm9yIHRhcmdldCAnZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlz
cGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5vJyBmYWlsZWQKPiA+Cj4gPiBVc2UgdGhlIHNh
bWUgdHJpY2sgdGhhdCB3ZSBoYXZlIGluIHRoZSBvdGhlciB0d28gZmlsZXMuCj4KPiBNYXliZSB0
aW1lIGZvciBhIG1hY3JvIGluIEtidWlsZC5pbmNsdWRlIG9yIHNvbWUgc3VjaCwgaWYgd2Ugc2Vl
IHRoaXMKPiBwYXR0ZXJuIGJlaW5nIHJlcGVhdGVkPwoKSSdtIG5vdCBhY3R1YWxseSBjb252aW5j
ZWQgdGhhdCB0aGUgYXJndW1lbnQgZG9lcyBhbnl0aGluZyB1c2VmdWwKYXQgYWxsLCBpZiB0aGUg
a2VybmVsIHN0YWNrIGlzIG5vcm1hbGx5IG5vdCAxNi1ieXRlIGFsaWduZWQKd2hlbiB3ZSBlbnRl
ciB0aGUgZHJpdmVyLCBhbmQgaXQgY2xlYXJseSBpcyBub3QgbmVlZGVkIGlmIHRoZSBzdGFjawpp
cyBhbHJlYWR5IGFsaWduZWQuCgpVbmxlc3MgYW55IGNvZGUgY2FsbGluZyBpbnRvIHRoZSBwb3J0
aW9ucyB0aGF0IHdhbnQgdGhlIGFsaWdubWVudAptYW51YWxseSBhbGlnbnMgdGhlIGtlcm5lbCBz
dGFjayBwb2ludGVyLCB3ZSBjb3VsZCBqdXN0IGFzIHdlbGwKbGVhdmUgaXQgb3V0LiBUaGUgZ2l0
IGhpc3RvcnkgZG9lcyBub3QgZXhwbGFpbiB3aHkgaXQgd2FzIGFkZGVkIGluIHRoZQpmaXJzdCBw
bGFjZSB0aG91Z2gsIHNvIEkgcmVhbGx5IGhhdmUgbm8gaWRlYS4KCkkgc2VlIGluIHRoZSBhcmNo
aXRlY3R1cmUgbWFrZWZpbGVzIHRoYXQgaTM4NiBrZXJuZWxzIGFyZSBidWlsdCB3aXRoCnRoZSBz
YW1lIGZsYWcgZ2xvYmFsbHksIGJ1dCBvdGhlciBhcmNoaXRlY3R1cmVzIChpbmNsdWRpbmcgeDg2
XzY0KQp1c2UgdGhlIGRlZmF1bHQgc3RhY2sgYWxpZ25tZW50LCB3aGljaCBtYXkgYmUgZGlmZmVy
ZW50LgoKICAgICAgQXJuZApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmkt
ZGV2ZWw=
