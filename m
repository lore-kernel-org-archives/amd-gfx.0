From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add another ATPX quirk for TOPAZ
Date: Wed, 18 Jul 2018 09:11:04 +0800
Message-ID: <5B4E93A8.4080401@amd.com>
References: <20180717193854.20054-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180717193854.20054-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

T24gMDcvMTgvMjAxOCAwMzozOCBBTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+IE5lZWRzIEFUUFgg
cmF0aGVyIHRoYW4gX1BSMy4KPgo+IEJ1ZzogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3No
b3dfYnVnLmNnaT9pZD0yMDA1MTcKPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKUmV2aWV3
ZWQtYnk6IEp1bndlaSBaaGFuZyA8SmVycnkuWmhhbmdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYXRweF9oYW5kbGVyLmMgfCAxICsKPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hdHB4X2hhbmRsZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9hdHB4X2hhbmRsZXIuYwo+IGluZGV4IGIzM2YxNjgwYzlhMy4uYTAy
ODY2MWQ5ZTIwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hdHB4X2hhbmRsZXIuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hdHB4X2hhbmRsZXIuYwo+IEBAIC01NzUsNiArNTc1LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBhbWRncHVfcHhfcXVpcmsgYW1kZ3B1X3B4X3F1aXJrX2xpc3RbXSA9IHsKPiAgIAl7IDB4MTAw
MiwgMHg2OTAwLCAweDEwMDIsIDB4MDEyNCwgQU1ER1BVX1BYX1FVSVJLX0ZPUkNFX0FUUFggfSwK
PiAgIAl7IDB4MTAwMiwgMHg2OTAwLCAweDEwMjgsIDB4MDgxMiwgQU1ER1BVX1BYX1FVSVJLX0ZP
UkNFX0FUUFggfSwKPiAgIAl7IDB4MTAwMiwgMHg2OTAwLCAweDEwMjgsIDB4MDgxMywgQU1ER1BV
X1BYX1FVSVJLX0ZPUkNFX0FUUFggfSwKPiArCXsgMHgxMDAyLCAweDY5MDAsIDB4MTAyNSwgMHgx
MjVBLCBBTURHUFVfUFhfUVVJUktfRk9SQ0VfQVRQWCB9LAo+ICAgCXsgMCwgMCwgMCwgMCwgMCB9
LAo+ICAgfTsKPgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
