From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v3 3/3] drm/amd: enable S/G for RAVEN chip
Date: Wed, 24 Jul 2019 16:50:09 +0200
Message-ID: <3d0c5357-52b9-80fb-61ff-363e13086aa8@daenzer.net>
References: <1563977442-4809-1-git-send-email-andrey.grodzovsky@amd.com>
 <1563977442-4809-4-git-send-email-andrey.grodzovsky@amd.com>
 <492b52b5-36e0-f957-88e1-c2479f8c56c4@amd.com>
 <e8a4de40-e60c-152a-ba4b-9ef7b1b553c1@amd.com>
 <fc3eb460-934a-afed-b654-b33021d32aa0@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <fc3eb460-934a-afed-b654-b33021d32aa0-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Wu,
 Hersen" <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>, "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOS0wNy0yNCA0OjQxIHAubS4sIEtvZW5pZywgQ2hyaXN0aWFuIHdyb3RlOgo+IEFtIDI0
LjA3LjE5IHVtIDE2OjMyIHNjaHJpZWIgR3JvZHpvdnNreSwgQW5kcmV5Ogo+PiBPbiA3LzI0LzE5
IDEwOjI1IEFNLCBLb2VuaWcsIENocmlzdGlhbiB3cm90ZToKPj4+IEFtIDI0LjA3LjE5IHVtIDE2
OjEwIHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+Pj4gRnJvbTogU2hpcmlzaCBTIDxzaGly
aXNoLnNAYW1kLmNvbT4KPj4+Pgo+Pj4+IGVuYWJsZXMgZ3B1X3ZtX3N1cHBvcnQgaW4gZG0gYW5k
IGFkZHMKPj4+PiBBTURHUFVfR0VNX0RPTUFJTl9HVFQgYXMgc3VwcG9ydGVkIGRvbWFpbgo+Pj4+
Cj4+Pj4gdjI6Cj4+Pj4gTW92ZSBCTyBwbGFjZW1lbnQgbG9naWMgaW50byBhbWRncHVfZGlzcGxh
eV9zdXBwb3J0ZWRfZG9tYWlucwo+Pj4+Cj4+Pj4gdjM6Cj4+Pj4gVXNlIGFtZGdwdV9ib192YWxp
ZGF0ZV91c3djIGluIGFtZGdwdV9kaXNwbGF5X3N1cHBvcnRlZF9kb21haW5zLgo+Pj4+Cj4+Pj4g
Q2hhbmdlLUlkOiBJZjM0MzAwYmVhYTYwYmUyZDM2MTcwYjdiNWIwOTZlYzY0NDUwMmIyMAo+Pj4+
IFNpZ25lZC1vZmYtYnk6IFNoaXJpc2ggUyA8c2hpcmlzaC5zQGFtZC5jb20+Cj4+Pj4gU2lnbmVk
LW9mZi1ieTogQW5kcmV5IEdyb2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+Cj4+
PiBBY3R1YWxseSB0aGF0IGRvZXNuJ3QgbG9vayBsaWtlIGEgZ29vZCBpZGVhIHRvIG1lLgo+Pj4K
Pj4+IEl0IGlzIHN0aWxsIHBlcmZlY3RseSBwb3NzaWJsZSAoYW5kIHdhbnRlZCEpIHRoYXQgdGhl
IFVTV0MgZmxhZyB3YXMgbm90Cj4+PiBzZXQgaW4gdGhlIGZpcnN0IHBsYWNlIGJ5IHVzZXJzcGFj
ZS4KPj4+Cj4+PiBJcyB0aGF0IHN0aWxsIGNoZWNrZWQgc29tZXdoZXJlPwo+Pj4KPj4+IFJlZ2Fy
ZHMsCj4+PiBDaHJpc3RpYW4uCj4+Cj4+IE5vdCBzdXJlIEkgdW5kZXJzdGFuZCBoZXJlLCBjYW4g
eW91IGVsYWJvcmF0ZSA/Cj4gCj4gSXQncyBzdGlsbCBwb3NzaWJsZSB0aGF0IHVzZXJzcGFjZSBk
b2Vzbid0IHNldCB0aGUgVVNXQyBmbGFnIGFuZCB0aGVyZSAKPiBhY3R1YWxseSBtaWdodCBiZSBn
b29kIHJlYXNvbnMgZm9yIHRoYXQuCj4gCj4gRG8gd2Ugc3RpbGwgaGF2ZSBhIGNoZWNrIGZvciB0
aGlzIGNhc2Ugc29tZXdoZXJlPwoKSXQgc291bmRzIGxpa2UgeW91J3JlIG1pc3VuZGVyc3RhbmRp
bmcgd2hhdCB0aGlzIHBhdGNoIGRvZXMsIHByb2JhYmx5CmR1ZSB0byB0aGUgd2VpcmQgYW1kZ3B1
X2JvX3ZhbGlkYXRlX3Vzd2MgQVBJLgphbWRncHVfZGlzcGxheV9zdXBwb3J0ZWRfZG9tYWlucyBk
b2Vzbid0IHNldCB0aGUgZmxhZyBmb3IgdGhlIEJPIGl0c2VsZi4KQ2hhbmdpbmcgdGhlIGhlbHBl
ciBBUEkgdG8gd2hhdCB3ZSBzdWdnZXN0ZWQgc2hvdWxkIGNsZWFyIHRoaXMgdXAuCgooTWF5YmUg
dGhlIG5ldyBoZWxwZXIgZnVuY3Rpb24gc2hvdWxkIGJlIHVzZWQgaW4KYW1kZ3B1X2Rpc3BsYXlf
c3VwcG9ydGVkX2RvbWFpbnMgaW4gcGF0Y2ggMiBhbHJlYWR5LCBvciBpbiB5ZXQgYW5vdGhlcgpz
ZXBhcmF0ZSBwYXRjaD8pCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAg
ICAgIHwgICAgICAgICAgICAgIGh0dHBzOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50
aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
