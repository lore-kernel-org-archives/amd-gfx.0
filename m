From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/radeon: Make CIK support in Radeon conditional
 (v2)
Date: Mon, 10 Apr 2017 16:09:09 -0400
Message-ID: <23d05e6c-ba51-6188-cbb1-9c0c7d87d0a1@amd.com>
References: <1491596149-3709-1-git-send-email-Felix.Kuehling@amd.com>
 <56a29a84-7b92-a666-5d0b-b6c2f3395b21@daenzer.net>
 <64d15f06-1560-825c-c186-2209f87908fc@daenzer.net>
 <74d677b8-6b81-e137-af67-ec4834c72bcc@amd.com>
 <CADnq5_Pz-NymmWd6ExLNxRJ=UVygHsQcaua26ULZstZ409LZzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_Pz-NymmWd6ExLNxRJ=UVygHsQcaua26ULZstZ409LZzw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMTctMDQtMTAgMDI6NTAgUE0sIEFsZXggRGV1Y2hlciB3cm90ZToKPiBPbiBNb24sIEFwciAx
MCwgMjAxNyBhdCAyOjEzIFBNLCBGZWxpeCBLdWVobGluZyA8ZmVsaXgua3VlaGxpbmdAYW1kLmNv
bT4gd3JvdGU6Cj4+Cj4+IEFyZSB0aGVyZSBhbnkgb3RoZXIgaWRlYXMgb3IgcmVxdWVzdHMsIGJl
Zm9yZSBJIGdvIHNwZW5kIG1vcmUgdGltZSBvbiB0aGlzPwo+Cj4gSW4gdGhlIHNob3J0IHRlcm0s
IGl0IHdvdWxkIHByb2JhYmx5IGJlIGdvb2QgdG8ganVzdCBoYXZlIGEgdHJpLXN0YXRlIG9wdGlv
bjoKPiAxLiBvbmx5IHJhZGVvbgo+IDIuIG9ubHkgYW1kZ3B1Cj4gMy4gYm90aAo+Cj4gSSBkb24n
dCB0aGluayB0aGVyZSBpcyBhIGdvb2QgYXV0b21hZ2ljIG9wdGlvbi4KCkFzIEkgdW5kZXJzdGFu
ZCBpdCwgdHJpc3RhdGUgb3B0aW9ucyBhcmUgZm9yIFllcy9Oby9Nb2R1bGUgY2hvaWNlcy4KCldl
cmUgeW91IHRoaW5raW5nIG9mIHNvbWV0aGluZyBsaWtlIHRoaXM/CgogICAgY2hvaWNlIERSTV9D
SUtfU1VQUE9SVAogICAgICAgIHByb21wdCAiU3VwcG9ydCBmb3IgQU1EIENJSyBBU0lDcyIKICAg
ICAgICBkZXBlbmRzIG9uIERSTV9BTURHUFUgfHwgRFJNX1JBREVPTgoKICAgIGNvbmZpZyBEUk1f
Q0lLX1JBREVPTgogICAgICAgIGJvb2wgIlJhZGVvbiIKICAgICAgICBkZXBlbmRzIG9uIERSTV9S
QURFT04KCiAgICBjb25maWcgRFJNX0NJS19BTURHUFUKICAgICAgICBib29sICJBTURHUFUiCiAg
ICAgICAgZGVwZW5kcyBvbiBEUk1fQU1ER1BVCgogICAgY29uZmlnIERSTV9DSUtfQk9USF9ERUZB
VUxUX1JBREVPTgogICAgICAgIGJvb2wgIkJvdGgsIHVzZSBSYWRlb24gYnkgZGVmYXVsdCIKICAg
ICAgICBkZXBlbmRzIG9uIERSTV9BTURHUFUgJiYgRFJNX1JBREVPTgoKICAgIGNvbmZpZyBEUk1f
Q0lLX0JPVEhfREVGQVVMVF9BTURHUFUKICAgICAgICBib29sICJCb3RoLCB1c2UgQU1ER1BVIGJ5
IGRlZmF1bHQiCiAgICAgICAgZGVwZW5kcyBvbiBEUk1fQU1ER1BVICYmIERSTV9SQURFT04KCiAg
ICBlbmRjaG9pY2UKClJlZ2FyZHMsCiAgRmVsaXgKCj4KPiBBbGV4CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
