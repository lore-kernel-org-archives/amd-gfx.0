From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: remove not needed memset
Date: Mon, 18 Nov 2019 12:26:10 -0500
Message-ID: <CADnq5_P981Pt7643HvJQSV_nLqtbEQjO4=cXQDYkUF8ikNeNcQ@mail.gmail.com>
References: <1574067631-26219-1-git-send-email-zhengbin13@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1574067631-26219-1-git-send-email-zhengbin13-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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
To: zhengbin <zhengbin13-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "Deucher,
 Alexander" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>

QXBwbGllZC4gIHRoYW5rcyEKCkFsZXgKCk9uIE1vbiwgTm92IDE4LCAyMDE5IGF0IDEwOjA3IEFN
IHpoZW5nYmluIDx6aGVuZ2JpbjEzQGh1YXdlaS5jb20+IHdyb3RlOgo+Cj4gRml4ZXMgY29jY2lj
aGVjayB3YXJuaW5nOgo+Cj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2loLmM6
NjQ6MTMtMzE6IFdBUk5JTkc6IGRtYV9hbGxvY19jb2hlcmVudCB1c2UgaW4gaWggLT4gcmluZyBh
bHJlYWR5IHplcm9lcyBvdXQgbWVtb3J5LCAgc28gbWVtc2V0IGlzIG5vdCBuZWVkZWQKPgo+IFJl
cG9ydGVkLWJ5OiBIdWxrIFJvYm90IDxodWxrY2lAaHVhd2VpLmNvbT4KPiBTaWduZWQtb2ZmLWJ5
OiB6aGVuZ2JpbiA8emhlbmdiaW4xM0BodWF3ZWkuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfaWguYyB8IDEgLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxl
dGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9paC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2loLmMKPiBpbmRleCA2
ZDhmMDU1Li4xMTFhMzAxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9paC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lo
LmMKPiBAQCAtNjYsNyArNjYsNiBAQCBpbnQgYW1kZ3B1X2loX3JpbmdfaW5pdChzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV9paF9yaW5nICppaCwKPiAgICAgICAgICAg
ICAgICAgaWYgKGloLT5yaW5nID09IE5VTEwpCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIC1FTk9NRU07Cj4KPiAtICAgICAgICAgICAgICAgbWVtc2V0KCh2b2lkICopaWgtPnJpbmcs
IDAsIGloLT5yaW5nX3NpemUgKyA4KTsKPiAgICAgICAgICAgICAgICAgaWgtPmdwdV9hZGRyID0g
ZG1hX2FkZHI7Cj4gICAgICAgICAgICAgICAgIGloLT53cHRyX2FkZHIgPSBkbWFfYWRkciArIGlo
LT5yaW5nX3NpemU7Cj4gICAgICAgICAgICAgICAgIGloLT53cHRyX2NwdSA9ICZpaC0+cmluZ1tp
aC0+cmluZ19zaXplIC8gNF07Cj4gLS0KPiAyLjcuNAo+Cj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeA==
