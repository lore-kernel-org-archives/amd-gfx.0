From: Jani Nikula <jani.nikula-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 0/9] drm/print: add and use
 drm_debug_enabled()
Date: Wed, 02 Oct 2019 17:11:45 +0300
Message-ID: <87v9t79qzi.fsf@intel.com>
References: <cover.1569329774.git.jani.nikula@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <cover.1569329774.git.jani.nikula-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/freedreno>
List-Post: <mailto:freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Freedreno" <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: David Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Francisco Jerez <currojerez-sGOZH3hwPm2sTnJN9+BGXg@public.gmane.org>, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Russell King <linux+etnaviv-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, etnaviv-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Eric Engestrom <eric.engestrom-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Sean Paul <sean-p7yTbzM4H96eqtR555YLDQ@public.gmane.org>, Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlLCAyNCBTZXAgMjAxOSwgSmFuaSBOaWt1bGEgPGphbmkubmlrdWxhQGludGVsLmNvbT4g
d3JvdGU6Cj4gICBkcm0vcHJpbnQ6IG1vdmUgZHJtX2RlYnVnIHZhcmlhYmxlIHRvIGRybV9wcmlu
dC5bY2hdCj4gICBkcm0vcHJpbnQ6IGFkZCBkcm1fZGVidWdfZW5hYmxlZCgpCj4gICBkcm0vZXRu
YXZpdjogdXNlIGRybV9kZWJ1Z19lbmFibGVkKCkgdG8gY2hlY2sgZm9yIGRlYnVnIGNhdGVnb3Jp
ZXMKPiAgIGRybS9pMmMvc2lsMTY0OiB1c2UgZHJtX2RlYnVnX2VuYWJsZWQoKSB0byBjaGVjayBm
b3IgZGVidWcgY2F0ZWdvcmllcwo+ICAgZHJtL21zbTogdXNlIGRybV9kZWJ1Z19lbmFibGVkKCkg
dG8gY2hlY2sgZm9yIGRlYnVnIGNhdGVnb3JpZXMKClB1c2hlZCB0aGUgYWJvdmUgcGF0Y2hlcyB0
byBkcm0tbWlzYy1uZXh0LCB0aGFua3MgZm9yIHRoZSByZXZpZXdzIGFuZAphY2tzIQoKVGhlIGJl
bG93IGk5MTUgYW5kIGFtZGdwdSBwYXRjaGVzIGNvbmZsaWN0IG9uIGRybS1taXNjLW5leHQsIGFu
ZCBJCmhhdmVuJ3QgcmVjZWl2ZWQgYW55IGZlZWRiYWNrIG9uIG5vdXZlYXUuCgo+ICAgZHJtL2k5
MTU6IHVzZSBkcm1fZGVidWdfZW5hYmxlZCgpIHRvIGNoZWNrIGZvciBkZWJ1ZyBjYXRlZ29yaWVz
Cj4gICBkcm0vbm91dmVhdTogdXNlIGRybV9kZWJ1Z19lbmFibGVkKCkgdG8gY2hlY2sgZm9yIGRl
YnVnIGNhdGVnb3JpZXMKPiAgIGRybS9hbWRncHU6IHVzZSBkcm1fZGVidWdfZW5hYmxlZCgpIHRv
IGNoZWNrIGZvciBkZWJ1ZyBjYXRlZ29yaWVzCj4gICBkcm0vcHJpbnQ6IHJlbmFtZSBkcm1fZGVi
dWcgdG8gX19kcm1fZGVidWcgdG8gZGlzY291cmFnZSB1c2UKCkJSLApKYW5pLgoKCi0tIApKYW5p
IE5pa3VsYSwgSW50ZWwgT3BlbiBTb3VyY2UgR3JhcGhpY3MgQ2VudGVyCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkZyZWVkcmVubyBtYWlsaW5nIGxpc3QK
RnJlZWRyZW5vQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ZyZWVkcmVubw==
