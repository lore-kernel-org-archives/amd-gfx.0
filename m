From: Erico Nunes <nunes.erico-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: lima_bo memory leak after drm_sched job destruction rework
Date: Fri, 17 May 2019 21:35:11 +0200
Message-ID: <CAK4VdL2wa=UrpRqfML-ymkEX7LkE6FP3ykgNUQonLdjmaydq_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Russell King <linux+etnaviv-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Qiang Yu <yuq825-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sharat Masetty <smasetty-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, lima-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

SGVsbG8sCgpJIGhhdmUgcmVjZW50bHkgb2JzZXJ2ZWQgYSBtZW1vcnkgbGVhayBpc3N1ZSB3aXRo
IGxpbWEgdXNpbmcKZHJtLW1pc2MtbmV4dCwgd2hpY2ggSSBpbml0aWFsbHkgcmVwb3J0ZWQgaGVy
ZToKaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2xpbWEvbGludXgvaXNzdWVzLzI0Ckl0
IGlzIGFuIGVhc2lseSByZXByb2R1Y2VhYmxlIG1lbW9yeSBsZWFrIHdoaWNoIEkgd2FzIGFibGUg
dG8gYmlzZWN0IHRvIGNvbW1pdDoKCjU5MTgwNDVjNGVkNCBkcm0vc2NoZWR1bGVyOiByZXdvcmsg
am9iIGRlc3RydWN0aW9uCgpBZnRlciBzb21lIGludmVzdGlnYXRpb24sIGl0IHNlZW1zIHRoYXQg
YWZ0ZXIgdGhlIHJlZmFjdG9yLApzY2hlZC0+b3BzLT5mcmVlX2pvYiAoaW4gbGltYTogbGltYV9z
Y2hlZF9mcmVlX2pvYikgaXMgbm8gbG9uZ2VyCmNhbGxlZC4KV2l0aCBzb21lIG1vcmUgZGVidWdn
aW5nIEkgZm91bmQgdGhhdCBpdCBpcyBub3QgYmVpbmcgY2FsbGVkIGJlY2F1c2UKdGhlIGpvYiBm
cmVlaW5nIGlzIG5vdyBpbiBkcm1fc2NoZWRfY2xlYW51cF9qb2JzLCB3aGljaCBmb3IgbGltYQph
bHdheXMgYWJvcnRzIGluIHRoZSBpbml0aWFsICJEb24ndCBkZXN0cm95IGpvYnMgd2hpbGUgdGhl
IHRpbWVvdXQKd29ya2VyIGlzIHJ1bm5pbmciIGNvbmRpdGlvbi4KCkxpbWEgY3VycmVudGx5IGRl
ZmF1bHRzIHRvIGFuICJpbmZpbml0ZSIgdGltZW91dC4gU2V0dGluZyBhIDUwMG1zCmRlZmF1bHQg
dGltZW91dCBsaWtlIG1vc3Qgb3RoZXIgZHJtX3NjaGVkIHVzZXJzIGRvIGZpeGVkIHRoZSBsZWFr
IGZvcgptZS4KCkkgY2FuIHNlbmQgYSBwYXRjaCB0byBzZXQgYSA1MDBtcyB0aW1lb3V0IGFuZCBo
YXZlIGl0IHByb2JhYmx5IHdvcmtpbmcKYWdhaW4sIGJ1dCBJIGFtIHdvbmRlcmluZyBub3cgaWYg
dGhpcyBpcyBleHBlY3RlZCBiZWhhdmlvdXIgZm9yCmRybV9zY2hlZCBhZnRlciB0aGUgcmVmYWN0
b3IuCkluIHBhcnRpY3VsYXIgSSBhbHNvIG5vdGljZWQgdGhhdCBkcm1fc2NoZWRfc3VzcGVuZF90
aW1lb3V0IGlzIG5vdApjYWxsZWQgYW55d2hlcmUuIElzIGl0IGV4cGVjdGVkIHRoYXQgd2Ugbm93
IHJlbHkgb24gYSB0aW1lb3V0CnBhcmFtZXRlciB0byBjbGVhbnVwIGpvYnMgdGhhdCByYW4gc3Vj
Y2Vzc2Z1bGx5PwoKRXJpY28KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
