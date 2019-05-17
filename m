From: Erico Nunes <nunes.erico-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: lima_bo memory leak after drm_sched job destruction rework
Date: Fri, 17 May 2019 23:42:48 +0200
Message-ID: <CAK4VdL26tEkW+6fU4DaXa8pGAfpQ5TfgiwNhyHXq=EJh72ak=Q@mail.gmail.com>
References: <CAK4VdL2wa=UrpRqfML-ymkEX7LkE6FP3ykgNUQonLdjmaydq_Q@mail.gmail.com>
 <3f1a556e-dd4c-3dc7-b966-a63baf1e7c52@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <3f1a556e-dd4c-3dc7-b966-a63baf1e7c52-5C7GfCeVMHo@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Deng,
 Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, "lima-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <lima-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Sharat Masetty <smasetty-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, Qiang Yu <yuq825-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Russell King <linux+etnaviv-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

T24gRnJpLCBNYXkgMTcsIDIwMTkgYXQgMTA6NDMgUE0gR3JvZHpvdnNreSwgQW5kcmV5CjxBbmRy
ZXkuR3JvZHpvdnNreUBhbWQuY29tPiB3cm90ZToKPiBPbiA1LzE3LzE5IDM6MzUgUE0sIEVyaWNv
IE51bmVzIHdyb3RlOgo+ID4gTGltYSBjdXJyZW50bHkgZGVmYXVsdHMgdG8gYW4gImluZmluaXRl
IiB0aW1lb3V0LiBTZXR0aW5nIGEgNTAwbXMKPiA+IGRlZmF1bHQgdGltZW91dCBsaWtlIG1vc3Qg
b3RoZXIgZHJtX3NjaGVkIHVzZXJzIGRvIGZpeGVkIHRoZSBsZWFrIGZvcgo+ID4gbWUuCj4KPiBJ
IGFtIG5vdCB2ZXJ5IGNsZWFyIGFib3V0IHRoZSBwcm9ibGVtIC0gc28geW91IGJhc2ljYWxseSBu
ZXZlciBhbGxvdyBhCj4gdGltZSBvdXQgaGFuZGxlciB0byBydW4gPyBBbmQgdGhlbiB3aGVuIHRo
ZSBqb2IgaGFuZ3MgZm9yIGV2ZXIgeW91IGdldAo+IHRoaXMgbWVtb3J5IGxlYWsgPyBIb3cgaXQg
d29ya2VkIGZvciB5b3UgYmVmb3JlIHRoaXMgcmVmYWN0b3JpbmcgPyBBcwo+IGZhciBhcyBJIHJl
bWVtYmVyICBzY2hlZC0+b3BzLT5mcmVlX2pvYiBiZWZvcmUgdGhpcyBjaGFuZ2Ugd2FzIGNhbGxl
ZAo+IGZyb20gZHJtX3NjaGVkX2pvYl9maW5pc2ggd2hpY2ggaXMgdGhlIHdvcmsgc2NoZWR1bGVk
IGZyb20gSFcgZmVuY2UKPiBzaWduYWxlZCBjYWxsYmFjayAtIGRybV9zY2hlZF9wcm9jZXNzX2pv
YiBzbyBpZiB5b3VyIGpvYiBoYW5ncyBmb3IgZXZlcgo+IGFueXdheSBhbmQgdGhpcyB3b3JrIGlz
IG5ldmVyIHNjaGVkdWxlZCAgd2hlbiB5b3VyIGZyZWVfam9iIGNhbGxiYWNrIHdhcwo+IGNhbGxl
ZCA/CgpJbiB0aGlzIHBhcnRpY3VsYXIgY2FzZSwgdGhlIGpvYnMgcnVuIHN1Y2Nlc3NmdWxseSwg
bm90aGluZyBoYW5ncy4KTGltYSBjdXJyZW50bHkgc3BlY2lmaWVzIGFuICJpbmZpbml0ZSIgdGlt
ZW91dCB0byB0aGUgZHJtIHNjaGVkdWxlciwKc28gaWYgYSBqb2IgZGlkIGRpZCBoYW5nLCBpdCB3
b3VsZCBoYW5nIGZvcmV2ZXIsIEkgc3VwcG9zZS4gQnV0IHRoaXMKaXMgbm90IHRoZSBpc3N1ZS4K
CklmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHkgaXQgd29ya2VkIHdlbGwgYmVmb3JlIHRoZSByZXdv
cmsgYmVjYXVzZSB0aGUKY2xlYW51cCB3YXMgdHJpZ2dlcmVkIGF0IHRoZSBlbmQgb2YgZHJtX3Nj
aGVkX3Byb2Nlc3Nfam9iCmluZGVwZW5kZW50bHkgb24gdGhlIHRpbWVvdXQuCgpXaGF0IEknbSBv
YnNlcnZpbmcgbm93IGlzIHRoYXQgZXZlbiB3aGVuIGpvYnMgcnVuIHN1Y2Nlc3NmdWxseSwgdGhl
eQphcmUgbm90IGNsZWFuZWQgYnkgdGhlIGRybSBzY2hlZHVsZXIgYmVjYXVzZSBkcm1fc2NoZWRf
Y2xlYW51cF9qb2JzCnNlZW1zIHRvIGdpdmUgdXAgYmFzZWQgb24gdGhlIHN0YXR1cyBvZiBhIHRp
bWVvdXQgd29ya2VyLgpJIHdvdWxkIGV4cGVjdCB0aGUgdGltZW91dCB2YWx1ZSB0byBvbmx5IGJl
IHJlbGV2YW50IGluIGVycm9yL2h1bmcgam9iIGNhc2VzLgoKSSB3aWxsIHByb2JhYmx5IHNldCB0
aGUgdGltZW91dCB0byBhIHJlYXNvbmFibGUgdmFsdWUgYW55d2F5LCBJIGp1c3QKcG9zdGVkIGhl
cmUgdG8gcmVwb3J0IHRoYXQgdGhpcyBjYW4gcG9zc2libHkgYmUgYSBidWcgaW4gdGhlIGRybQpz
Y2hlZHVsZXIgYWZ0ZXIgdGhhdCByZXdvcmsuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA==
