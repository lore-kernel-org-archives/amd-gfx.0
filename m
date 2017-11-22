From: Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/ttm: add set_pages_wb for handling page order
 more than zero
Date: Wed, 22 Nov 2017 11:50:22 +0000
Message-ID: <151135142294.5636.17032818438593706175@mail.alporthouse.com>
References: <1511351069-4757-1-git-send-email-Hongbo.He@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1511351069-4757-1-git-send-email-Hongbo.He-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Roger He <Hongbo.He-5C7GfCeVMHo@public.gmane.org>

UXVvdGluZyBSb2dlciBIZSAoMjAxNy0xMS0yMiAxMTo0NDoyNykKPiBDaGFuZ2UtSWQ6IElkZjVj
Y2I1NzlkMjY0YjM0MzE5OWQ4YjgzNDRiZGRlZWMyYzAwMTlmCj4gU2lnbmVkLW9mZi1ieTogUm9n
ZXIgSGUgPEhvbmdiby5IZUBhbWQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vdHRtL3R0
bV9wYWdlX2FsbG9jLmMgfCAxMSArKysrKysrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5z
ZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdl
X2FsbG9jLmMgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jLmMKPiBpbmRleCBh
OGIyYmZhLi5jZGJiNzMxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3Bh
Z2VfYWxsb2MuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxsb2MuYwo+
IEBAIC0yMjMsNiArMjIzLDE3IEBAIHN0YXRpYyBzdHJ1Y3Qga29ial90eXBlIHR0bV9wb29sX2tv
YmpfdHlwZSA9IHsKPiAgc3RhdGljIHN0cnVjdCB0dG1fcG9vbF9tYW5hZ2VyICpfbWFuYWdlcjsK
PiAgCj4gICNpZm5kZWYgQ09ORklHX1g4Ngo+ICtzdGF0aWMgaW50IHNldF9wYWdlc193YihzdHJ1
Y3QgcGFnZSAqcGFnZSwgaW50IG51bXBhZ2VzKQo+ICt7Cj4gKyNpZiBJU19FTkFCTEVEKENPTkZJ
R19BR1ApCj4gKyAgICAgICBpbnQgaTsKPiArCj4gKyAgICAgICBmb3IgKGkgPSAwOyBpIDwgbnVt
cGFnZXM7IGkrKykKPiArICAgICAgICAgICAgICAgdW5tYXBfcGFnZV9mcm9tX2FncChwYWdlKysp
Owo+ICsjZW5kaWYKPiArICAgICAgIHJldHVybiAwOwo+ICt9Cj4gKwo+ICBzdGF0aWMgaW50IHNl
dF9wYWdlc19hcnJheV93YihzdHJ1Y3QgcGFnZSAqKnBhZ2VzLCBpbnQgYWRkcmluYXJyYXkpCgpC
b3RoIG9mIHRoZXNlIGFyZSBzaGFkb3dpbmcgZXhwb3J0cyBmcm9tIGFyY2gveDg2LCBwcm9iYWJs
eSBub3QgdGhlCndpc2VzdCBjaG9pY2Ugb2YgbmFtZXMuCi1DaHJpcwpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
