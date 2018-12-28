From: Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] drm/intel_dsi_vbt: Remove duplicate header
Date: Fri, 28 Dec 2018 09:18:07 +0200
Message-ID: <87a7kqw24w.fsf@intel.com>
References: <20181225133055.GA2628@hp-pavilion-15-notebook-pc-brajeswar>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181225133055.GA2628@hp-pavilion-15-notebook-pc-brajeswar>
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
To: Brajeswar Ghosh <brajeswar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, joonas.lahtinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rodrigo.vivi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, sabyasachi.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

T24gVHVlLCAyNSBEZWMgMjAxOCwgQnJhamVzd2FyIEdob3NoIDxicmFqZXN3YXIubGludXhAZ21h
aWwuY29tPiB3cm90ZToKPiBSZW1vdmUgdmlkZW8vbWlwaV9kaXNwbGF5Lmggd2hpY2ggaXMgaW5j
bHVkZWQgbW9yZSB0aGFuIG9uY2UKPgo+IFNpZ25lZC1vZmYtYnk6IEJyYWplc3dhciBHaG9zaCA8
YnJhamVzd2FyLmxpbnV4QGdtYWlsLmNvbT4KClB1c2hlZCB0byBkcm0taW50ZWwtbmV4dC1xdWV1
ZWQsIHRoYW5rcyBmb3IgdGhlIHBhdGNoLgoKQlIsCkphbmkuCgo+IC0tLQo+ICBkcml2ZXJzL2dw
dS9kcm0vaTkxNS9pbnRlbF9kc2lfdmJ0LmMgfCAxIC0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVs
ZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9pbnRlbF9kc2lf
dmJ0LmMgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9pbnRlbF9kc2lfdmJ0LmMKPiBpbmRleCBhYzgz
ZDZiODlhZTAuLjQwYTVlZmEzM2MzZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkx
NS9pbnRlbF9kc2lfdmJ0LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9pbnRlbF9kc2lf
dmJ0LmMKPiBAQCAtMzIsNyArMzIsNiBAQAo+ICAjaW5jbHVkZSA8bGludXgvc2xhYi5oPgo+ICAj
aW5jbHVkZSA8dmlkZW8vbWlwaV9kaXNwbGF5Lmg+Cj4gICNpbmNsdWRlIDxhc20vaW50ZWwtbWlk
Lmg+Cj4gLSNpbmNsdWRlIDx2aWRlby9taXBpX2Rpc3BsYXkuaD4KPiAgI2luY2x1ZGUgImk5MTVf
ZHJ2LmgiCj4gICNpbmNsdWRlICJpbnRlbF9kcnYuaCIKPiAgI2luY2x1ZGUgImludGVsX2RzaS5o
IgoKLS0gCkphbmkgTmlrdWxhLCBJbnRlbCBPcGVuIFNvdXJjZSBHcmFwaGljcyBDZW50ZXIKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
