From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdkfd: enable KFD support for navi14
Date: Tue, 30 Jul 2019 23:54:02 -0400
Message-ID: <CADnq5_O2zietHydanh4PM2bFtJfQjBnUg9At1iy5WbTpovCkKQ@mail.gmail.com>
References: <20190726191615.20351-1-alexander.deucher@amd.com>
 <20190726191615.20351-2-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190726191615.20351-2-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

UGluZz8KCk9uIEZyaSwgSnVsIDI2LCAyMDE5IGF0IDM6MTYgUE0gQWxleCBEZXVjaGVyIDxhbGV4
ZGV1Y2hlckBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gU2FtZSBhcyBuYXZpMTAuCj4KPiBTaWduZWQt
b2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gLS0tCj4g
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYyB8IDEgKwo+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfYW1ka2ZkLmMKPiBpbmRleCBmMDUyYzcwZTQ2NTkuLjk3ZjdjNTIzNWNjOSAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMKPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMKPiBAQCAtOTEs
NiArOTEsNyBAQCB2b2lkIGFtZGdwdV9hbWRrZmRfZGV2aWNlX3Byb2JlKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KQo+ICAgICAgICAgICAgICAgICBrZmQya2dkID0gYW1kZ3B1X2FtZGtmZF9h
cmN0dXJ1c19nZXRfZnVuY3Rpb25zKCk7Cj4gICAgICAgICAgICAgICAgIGJyZWFrOwo+ICAgICAg
ICAgY2FzZSBDSElQX05BVkkxMDoKPiArICAgICAgIGNhc2UgQ0hJUF9OQVZJMTQ6Cj4gICAgICAg
ICAgICAgICAgIGtmZDJrZ2QgPSBhbWRncHVfYW1ka2ZkX2dmeF8xMF8wX2dldF9mdW5jdGlvbnMo
KTsKPiAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gICAgICAgICBkZWZhdWx0Ogo+IC0tCj4gMi4y
MC4xCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
