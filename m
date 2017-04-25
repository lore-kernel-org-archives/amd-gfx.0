From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 3/6] drm: fourcc byteorder: add bigendian support to
 drm_mode_legacy_fb_format
Date: Tue, 25 Apr 2017 12:18:52 +0900
Message-ID: <3b872a56-80b5-0c44-712f-a9517489eb24@daenzer.net>
References: <20170424062532.26722-1-kraxel@redhat.com>
 <20170424062532.26722-4-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170424062532.26722-4-kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjQvMDQvMTcgMDM6MjUgUE0sIEdlcmQgSG9mZm1hbm4gd3JvdGU6Cj4gUmV0dXJuIGNvcnJl
Y3QgZm91cmNjIGNvZGVzIG9uIGJpZ2VuZGlhbi4gIERyaXZlcnMgbXVzdCBiZSBhZGFwdGVkIHRv
Cj4gdGhpcyBjaGFuZ2UuCj4gCj4gU2lnbmVkLW9mZi1ieTogR2VyZCBIb2ZmbWFubiA8a3JheGVs
QHJlZGhhdC5jb20+CgpKdXN0IHRvIHJlaXRlcmF0ZSwgdGhpcyB3b24ndCB3b3JrIGZvciB0aGUg
cmFkZW9uIGRyaXZlciwgd2hpY2ggcHJvZ3JhbXMKdGhlIEdQVSB0byB1c2UgKGVmZmVjdGl2ZWx5
LCBwZXIgdGhlIGN1cnJlbnQgZGVmaW5pdGlvbiB0aGF0IHRoZXNlIGFyZQpsaXR0bGUgZW5kaWFu
IEdQVSBmb3JtYXRzKSBEUk1fRk9STUFUX1hSR0I4ODg4IHdpdGggcHJlLVI2MDAgYW5kCkRSTV9G
T1JNQVRfQkdSWDg4ODggd2l0aCA+PSBSNjAwLgoKCj4gKyNpZmRlZiBfX0JJR19FTkRJQU4KPiAr
CXN3aXRjaCAoYnBwKSB7Cj4gKwljYXNlIDg6Cj4gKwkJZm10ID0gRFJNX0ZPUk1BVF9DODsKPiAr
CQlicmVhazsKPiArCWNhc2UgMjQ6Cj4gKwkJZm10ID0gRFJNX0ZPUk1BVF9CR1I4ODg7Cj4gKwkJ
YnJlYWs7CgpCVFcsIGVuZGlhbm5lc3MgYXMgYSBjb25jZXB0IGNhbm5vdCBhcHBseSB0byA4IG9y
IDI0IGJwcCBmb3JtYXRzLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAg
ICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVu
dGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3Blcgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
