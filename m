From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/powerplay: fix
 pp_dpm_get_current_power_state()
Date: Mon, 3 Apr 2017 16:28:54 -0400
Message-ID: <CADnq5_NT+KEAX1w8a4vZdTYfH3eQ_OsmPF2KhfoCVBXA5aeQ_Q@mail.gmail.com>
References: <20170403184147.GA22462@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170403184147.GA22462@mwanda>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Tom St Denis <tom.stdenis@amd.com>, Edward O'Callaghan <funfunctor@folklore1984.net>, kernel-janitors@vger.kernel.org, amd-gfx list <amd-gfx@lists.freedesktop.org>, Eric Huang <JinHuiEric.Huang@amd.com>, Huang Rui <ray.huang@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, Rex Zhu <Rex.Zhu@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gTW9uLCBBcHIgMywgMjAxNyBhdCAyOjQxIFBNLCBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVu
dGVyQG9yYWNsZS5jb20+IHdyb3RlOgo+IFRoaXMgc3dpdGNoIHN0YXRlbWVudCBpcyBtaXNzaW5n
IGJyZWFrcy4KPgo+IEZpeGVzOiAyYTUwNzEwNTZlNmEgKCJkcm0vYW1kL3Bvd2VycGxheTogYWRk
IGdsb2JhbCBQb3dlclBsYXkgbXV0ZXguIikKPiBTaWduZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVy
IDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+CgpBcHBsaWVkLiAgdGhhbmtzIQoKPgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRfcG93ZXJwbGF5LmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRfcG93ZXJwbGF5LmMKPiBpbmRleCBkZmQ0
ZmU2ZjA1NzguLjI2MGI3MzJiZTdjMyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9hbWRfcG93ZXJwbGF5LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9hbWRfcG93ZXJwbGF5LmMKPiBAQCAtNTM5LDEwICs1MzksMTMgQEAgc3RhdGljIGVu
dW0gYW1kX3BtX3N0YXRlX3R5cGUgcHBfZHBtX2dldF9jdXJyZW50X3Bvd2VyX3N0YXRlKHZvaWQg
KmhhbmRsZSkKPiAgICAgICAgIHN3aXRjaCAoc3RhdGUtPmNsYXNzaWZpY2F0aW9uLnVpX2xhYmVs
KSB7Cj4gICAgICAgICBjYXNlIFBQX1N0YXRlVUlMYWJlbF9CYXR0ZXJ5Ogo+ICAgICAgICAgICAg
ICAgICBwbV90eXBlID0gUE9XRVJfU1RBVEVfVFlQRV9CQVRURVJZOwo+ICsgICAgICAgICAgICAg
ICBicmVhazsKPiAgICAgICAgIGNhc2UgUFBfU3RhdGVVSUxhYmVsX0JhbGFuY2VkOgo+ICAgICAg
ICAgICAgICAgICBwbV90eXBlID0gUE9XRVJfU1RBVEVfVFlQRV9CQUxBTkNFRDsKPiArICAgICAg
ICAgICAgICAgYnJlYWs7Cj4gICAgICAgICBjYXNlIFBQX1N0YXRlVUlMYWJlbF9QZXJmb3JtYW5j
ZToKPiAgICAgICAgICAgICAgICAgcG1fdHlwZSA9IFBPV0VSX1NUQVRFX1RZUEVfUEVSRk9STUFO
Q0U7Cj4gKyAgICAgICAgICAgICAgIGJyZWFrOwo+ICAgICAgICAgZGVmYXVsdDoKPiAgICAgICAg
ICAgICAgICAgaWYgKHN0YXRlLT5jbGFzc2lmaWNhdGlvbi5mbGFncyAmIFBQX1N0YXRlQ2xhc3Np
ZmljYXRpb25GbGFnX0Jvb3QpCj4gICAgICAgICAgICAgICAgICAgICAgICAgcG1fdHlwZSA9IFBP
V0VSX1NUQVRFX1RZUEVfSU5URVJOQUxfQk9PVDsKPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vZHJpLWRldmVsCg==
