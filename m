From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/radeon: Add dpm quirk for Jet PRO (v2)
Date: Fri, 5 Jan 2018 10:20:54 +0100
Message-ID: <90430644-432b-3b09-d81e-f5ec4aa986ba@gmail.com>
References: <20180104220342.30645-1-alexander.deucher@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180104220342.30645-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

QW0gMDQuMDEuMjAxOCB1bSAyMzowMyBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBGaXhlcyBzdGFi
aWxpdHkgaXNzdWVzLgo+Cj4gdjI6IGNsYW1wIHNjbGsgdG8gNjAwIE1oego+Cj4gQnVnOiBodHRw
czovL2J1Z3MuZnJlZWRlc2t0b3Aub3JnL3Nob3dfYnVnLmNnaT9pZD0xMDMzNzAKPiBTaWduZWQt
b2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CgpBY2tlZC1i
eTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiBmb3IgdGhlIHNl
cmllcy4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpX2RwbS5jIHwgNSArKysr
Kwo+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9yYWRlb24vc2lfZHBtLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Np
X2RwbS5jCj4gaW5kZXggZWUzZTc0MjY2YTEzLi45N2EwYTYzOWRhZDkgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaV9kcG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9y
YWRlb24vc2lfZHBtLmMKPiBAQCAtMjk4NCw2ICsyOTg0LDExIEBAIHN0YXRpYyB2b2lkIHNpX2Fw
cGx5X3N0YXRlX2FkanVzdF9ydWxlcyhzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiwKPiAgIAkJ
ICAgIChyZGV2LT5wZGV2LT5kZXZpY2UgPT0gMHg2NjY3KSkgewo+ICAgCQkJbWF4X3NjbGsgPSA3
NTAwMDsKPiAgIAkJfQo+ICsJCWlmICgocmRldi0+cGRldi0+cmV2aXNpb24gPT0gMHhDMykgfHwK
PiArCQkgICAgKHJkZXYtPnBkZXYtPmRldmljZSA9PSAweDY2NjUpKSB7Cj4gKwkJCW1heF9zY2xr
ID0gNjAwMDA7Cj4gKwkJCW1heF9tY2xrID0gODAwMDA7Cj4gKwkJfQo+ICAgCX0gZWxzZSBpZiAo
cmRldi0+ZmFtaWx5ID09IENISVBfT0xBTkQpIHsKPiAgIAkJaWYgKChyZGV2LT5wZGV2LT5yZXZp
c2lvbiA9PSAweEM3KSB8fAo+ICAgCQkgICAgKHJkZXYtPnBkZXYtPnJldmlzaW9uID09IDB4ODAp
IHx8CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
