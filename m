From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/radeon: Fix GPU lockups for the R7 M270
Date: Tue, 14 Mar 2017 10:34:17 -0400
Message-ID: <CADnq5_MPyb6v_6wPHWHr2pkwX19thyaWurCNr+xi8QJOnFQ5kA@mail.gmail.com>
References: <20170311162113.7497-1-u@umangis.me>
 <CADnq5_MUP3KSEWed47Ot617UwaGxvjuwdWjCDFmrb7_hDEXiLw@mail.gmail.com>
 <dcf05c1d-b672-7f49-8f22-68e30a6aae12@umangis.me>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <dcf05c1d-b672-7f49-8f22-68e30a6aae12-fg9RStOClv1BDLzU/O5InQ@public.gmane.org>
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
To: Umang Raghuvanshi <u@umangis.me>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gTW9uLCBNYXIgMTMsIDIwMTcgYXQgMTA6NDIgUE0sIFVtYW5nIFJhZ2h1dmFuc2hpIDx1QHVt
YW5naXMubWU+IHdyb3RlOgo+Cj4KPiBPbiAwMy8xNC8yMDE3IDAxOjAwIEFNLCBBbGV4IERldWNo
ZXIgd3JvdGU6Cj4KPj4gRG9lcyB5b3VyIGtlcm5lbCBoYXZlIHRoaXMgcGF0Y2g6Cj4+IGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4
LmdpdC9jb21taXQvP2lkPWVmNzM2ZDM5NGU4NWIxYmYxZmQ2NWJhNWU1MjU3Yjg1ZjZjODIzMjUK
Pgo+IFllcywgbXkga2VybmVsIGhhcyB0aGlzIHBhdGNoICh0aGlzIGlzc3VlIGZpcnN0IG9jY3Vy
cmVkIGluIHY0LjEwKS4KCgpDYW4geW91IHNlbmQgbWUgdGhlIGRtZXNnIG91dHB1dCBmcm9tIHlv
dXIgc3lzdGVtPwoKVGhhbmtzLAoKQWxleAoKPgo+IC0tCj4gQ2hlZXJzLAo+IFVtYW5nIFJhZ2h1
dmFuc2hpLgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
