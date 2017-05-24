From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Limit DCN to x86 arch
Date: Wed, 24 May 2017 10:09:00 +0900
Message-ID: <4905eb15-ec8c-61f7-f295-1e014009041c@daenzer.net>
References: <20170519140121.14296-1-harry.wentland@amd.com>
 <f84c51b6-06f1-b4d2-c472-89265ebb26cb@vodafone.de>
 <7a8b84af-38f7-33d2-5bbb-473f2ea35bb2@amd.com>
 <CAPM=9tzcA8t-ji6qNQhycB0cezz2vH6HMixCgvKQ78cY1Y8fsA@mail.gmail.com>
 <4e0c342b-d18e-5f7a-bd30-9becd0e97e3c@amd.com>
 <013f44e3-1734-43f8-4cd7-e950ffb014f0@vodafone.de>
 <ff8918ec-ee0e-692e-4ada-cd6bd939d902@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ff8918ec-ee0e-692e-4ada-cd6bd939d902-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Dmytro Laktyushkin <Dmytro.Laktyushkin-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Tony Cheng <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gMjMvMDUvMTcgMTA6MzcgUE0sIEhhcnJ5IFdlbnRsYW5kIHdyb3RlOgo+IE9uIDIwMTctMDUt
MjAgMDQ6MTMgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDE5LjA1LjIwMTcgdW0g
MjI6Mjggc2NocmllYiBIYXJyeSBXZW50bGFuZDoKPj4+IAo+Pj4gSSByZWFsaXplIHRoaXMgaXMg
cmFpc2luZyBhIGxvdCBvZiBjb25jZXJuLiBJIHdhcyBjb25jZXJuZWQgbXlzZWxmCj4+PiB3aGVu
IEkgZmlyc3Qgc2F3IHRoaXMuIEJlc2lkZSBjYWxsaW5nIGtlcm5lbF9mcHVfYmVnaW4oKSBhbmQK
Pj4+IGtlcm5lbF9mcHVfZW5kKCkgYXJlIHRoZXJlIG90aGVyIHRoaW5ncyB0byB3YXRjaCBvdXQg
Zm9yPwo+Pgo+PiBZZWFoLCBlc3BlY2lhbGx5IHNldHRpbmcgIi1tc3NlIiBpcyByYXRoZXIgcXVl
c3Rpb25hYmxlLiBBcyBmYXIgYXMgSQo+PiBrbm93IG9uIDY0Yml0IHN5c3RlbXMgaXQgaXMgdGhl
IGRlZmF1bHQsIGJ1dCBvbiAzMmJpdCBzeXN0ZW1zIHRoYXQKPj4gY291bGQgc2lsZW50bHkgYnJl
YWsgc29tZSBhc3N1bXB0aW9ucy4KPj4KPj4gQWRkaXRpb25hbCB0byB0aGF0IGFzIGZhciBhcyBJ
IGtub3cgIi1tc3NlIiBpcyBqdXN0IGZvciBvcHRpbWl6YXRpb24KPj4gYW5kIHRoYXQgaXNuJ3Qg
cGVyZm9ybWFuY2UgY3JpdGljYWwgY29kZSwgc28gd2h5IGV4YWN0bHkgZG8gd2UgbmVlZCBpdD8K
PiAKPiBPbmNlIHdlIGVuYWJsZSBtdWx0aS1wbGFuZSBjb2RlIHRoaXMgY29kZSBiZWNvbWVzIHBl
cmZvcm1hbmNlIGNyaXRpY2FsCj4gYXMgSSBiZWxpZXZlIGl0IGdldHMgZXhlY3V0ZWQgd2hlbiBy
ZXNpemluZyBhbiB1bmRlcmxheSBzdXJmYWNlLCBzdWNoIGFzCj4gYSB2aWRlbyBwbGF5ZXIuCgpU
aGF0IHNob3VsZCBzdGlsbCBvbmx5IGhhcHBlbiBvbmNlIHBlciBmcmFtZSB0aG91Z2gsIGkuZS4g
b24gdGhlIG9yZGVyCm9mIDEwcyB0byAxMDBzIG9mIHRpbWVzIHBlciBzZWNvbmQuCgoKLS0gCkVh
cnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRw
Oi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAg
ICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
