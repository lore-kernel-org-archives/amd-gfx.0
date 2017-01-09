From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] amdgpu: sync amdgpu_drm.h with the kernel
Date: Mon, 9 Jan 2017 17:20:42 +0000
Message-ID: <CACvgo52HQMMO7Jz_VQ3_p5YF0_zOUnFMu62FrSxfswJOJ8+Bug@mail.gmail.com>
References: <1483960700-20924-1-git-send-email-arindam.nath@amd.com>
 <CACvgo53Ns-Qm1vFeR9_BrV1SV3B4GNbkd_v0FoPvfw0QpAbkXA@mail.gmail.com>
 <0536c131-9db7-1a38-970e-efe45e2dda97@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <0536c131-9db7-1a38-970e-efe45e2dda97-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gOSBKYW51YXJ5IDIwMTcgYXQgMTY6NDQsIENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4gQW0gMDkuMDEuMjAxNyB1bSAxNzozOSBzY2hyaWViIEVt
aWwgVmVsaWtvdjoKPj4KPj4gT24gOSBKYW51YXJ5IDIwMTcgYXQgMTE6MTgsIEFyaW5kYW0gTmF0
aCA8YXJpbmRhbS5uYXRoQGFtZC5jb20+IHdyb3RlOgo+Pgo+Pj4gdjI6Cj4+PiAqIEdlbmVyYXRl
ZCB1c2luZyBtYWtlIGhlYWRlcnNfaW5zdGFsbC4KPj4+ICogR2VuZXJhdGVkIGZyb20gbGludXgt
c3RhYmxlL21hc3RlciBjb21taXQKPj4+ICAgIGExMjExMDNjOTIyODQ3YmE1MDEwODE5YTNmMjUw
ZjFmN2ZjODRhYjgKPj4+Cj4+IFRoZSBhYm92ZSBpcyBlaXRoZXIgd3Jvbmcgb3IgeW91J3ZlIGRv
bmUgbWFudWFsIGNoYW5nZXMuIEJvdGggb2Ygd2hpY2gKPj4gYXJlIF9ub3RfIGNvb2wuCj4KPgo+
IFdlbGwgYWNjb3JkaW5nIHRvIG15IGdpdCBoaXN0b3J5IHRoYXQgaXM6Cj4KPiBjb21taXQgYTEy
MTEwM2M5MjI4NDdiYTUwMTA4MTlhM2YyNTBmMWY3ZmM4NGFiOAo+IEF1dGhvcjogTGludXMgVG9y
dmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPgo+IERhdGU6ICAgU3VuIEphbiA4
IDE0OjE4OjE3IDIwMTcgLTA4MDAKPgo+ICAgICBMaW51eCA0LjEwLXJjMwo+Cj4KWWVzIHRoYXQg
aXMgdGhlIGNvbW1pdCBpbiBxdWVzdGlvbiwgeWV0ICJHZW5lcmF0ZWQgdXNpbmcgbWFrZQpoZWFk
ZXJzX2luc3RhbGwiIGlzIGEgbGllIDstKQouLi4gb3IgdGhlcmUgdGhlcmUgYXJlIG1hbnVhbCBj
aGFuZ2VzLgoKSnVzdCBkbyBjaGVja291dCAmJiBtYWtlIGhlYWRlcnNfaW5zdGFsbCAmJiBjcCAm
JiBnaXQgZGlmZiBmb3IgdGhlIHNwZWNpZmljcy4KCi1FbWlsCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
