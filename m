From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdkfd: Remove duplicate header
Date: Mon, 26 Nov 2018 15:33:48 -0500
Message-ID: <CADnq5_PhesnKq+AxhF+9WsqWYMSpjSRBRLtCpCZ_E2O+DjPEow@mail.gmail.com>
References: <20181122140714.GA3219@hp-pavilion-15-notebook-pc-brajeswar>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181122140714.GA3219@hp-pavilion-15-notebook-pc-brajeswar>
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
To: brajeswar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Sabyasachi Gupta <sabyasachi.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Souptick Joarder <jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Deucher,
 Alexander" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gRnJpLCBOb3YgMjMsIDIwMTggYXQgMjo0MSBBTSBCcmFqZXN3YXIgR2hvc2gKPGJyYWplc3dh
ci5saW51eEBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gUmVtb3ZlIGdjYS9nZnhfOF8wX2VudW0uaCB3
aGljaCBpcyBpbmNsdWRlZCBtb3JlIHRoYW4gb25jZQo+Cj4gU2lnbmVkLW9mZi1ieTogQnJhamVz
d2FyIEdob3NoIDxicmFqZXN3YXIubGludXhAZ21haWwuY29tPgoKQXBwbGllZC4gIHRoYW5rcyEK
CkFsZXgKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVl
dWVfbWFuYWdlcl92aS5jIHwgMSAtCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1
ZV9tYW5hZ2VyX3ZpLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1
ZXVlX21hbmFnZXJfdmkuYwo+IGluZGV4IGZkNjBhMTE2YmUzNy4uYzNhNWRjZmU4NzdhIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFu
YWdlcl92aS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9x
dWV1ZV9tYW5hZ2VyX3ZpLmMKPiBAQCAtMjQsNyArMjQsNiBAQAo+ICAjaW5jbHVkZSAia2ZkX2Rl
dmljZV9xdWV1ZV9tYW5hZ2VyLmgiCj4gICNpbmNsdWRlICJnY2EvZ2Z4XzhfMF9lbnVtLmgiCj4g
ICNpbmNsdWRlICJnY2EvZ2Z4XzhfMF9zaF9tYXNrLmgiCj4gLSNpbmNsdWRlICJnY2EvZ2Z4Xzhf
MF9lbnVtLmgiCj4gICNpbmNsdWRlICJvc3Mvb3NzXzNfMF9zaF9tYXNrLmgiCj4KPiAgc3RhdGlj
IGJvb2wgc2V0X2NhY2hlX21lbW9yeV9wb2xpY3lfdmkoc3RydWN0IGRldmljZV9xdWV1ZV9tYW5h
Z2VyICpkcW0sCj4gLS0KPiAyLjE3LjEKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1haWxpbmcgbGlzdAo+IGRyaS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2RyaS1kZXZlbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
