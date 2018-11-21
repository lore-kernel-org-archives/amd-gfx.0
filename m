From: "Zhang, Jerry(Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu/vce_v3_0.c: Remove duplicate header
Date: Wed, 21 Nov 2018 16:15:51 +0800
Message-ID: <13613dd2-dfef-7a8e-4c27-5b5bed336a89@amd.com>
References: <20181121071103.GA2622@hp-pavilion-15-notebook-pc-brajeswar>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181121071103.GA2622@hp-pavilion-15-notebook-pc-brajeswar>
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
To: Brajeswar Ghosh <brajeswar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, alexander.deucher-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, David1.Zhou-5C7GfCeVMHo@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, leo.liu-5C7GfCeVMHo@public.gmane.org, andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org, Emily.Deng-5C7GfCeVMHo@public.gmane.org, Rex.Zhu-5C7GfCeVMHo@public.gmane.org
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, sabyasachi.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

T24gMTEvMjEvMTggMzoxMSBQTSwgQnJhamVzd2FyIEdob3NoIHdyb3RlOgo+IFJlbW92ZSBnY2Ev
Z2Z4XzhfMF9kLmggd2hpY2ggaXMgaW5jbHVkZWQgbW9yZSB0aGFuIG9uY2UKPgo+IFNpZ25lZC1v
ZmYtYnk6IEJyYWplc3dhciBHaG9zaCA8YnJhamVzd2FyLmxpbnV4QGdtYWlsLmNvbT4KUmV2aWV3
ZWQtYnk6IEp1bndlaSBaaGFuZyA8SmVycnkuWmhhbmdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjNfMC5jIHwgMSAtCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3ZjZV92M18wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjNfMC5jCj4g
aW5kZXggNmRiZDM5NzMwMDcwLi40ZTQyODlhMDZhNTMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvdmNlX3YzXzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3ZjZV92M18wLmMKPiBAQCAtMzcsNyArMzcsNiBAQAo+ICAgI2luY2x1ZGUgImdjYS9n
ZnhfOF8wX2QuaCIKPiAgICNpbmNsdWRlICJzbXUvc211XzdfMV8yX2QuaCIKPiAgICNpbmNsdWRl
ICJzbXUvc211XzdfMV8yX3NoX21hc2suaCIKPiAtI2luY2x1ZGUgImdjYS9nZnhfOF8wX2QuaCIK
PiAgICNpbmNsdWRlICJnY2EvZ2Z4XzhfMF9zaF9tYXNrLmgiCj4gICAjaW5jbHVkZSAiaXZzcmNp
ZC9pdnNyY2lkX3Zpc2xhbmRzMzAuaCIKPiAgIAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
