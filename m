From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: fix compilation error
Date: Thu, 13 Jun 2019 20:42:17 +0200
Message-ID: <20190613184217.GA2385@ravnborg.org>
References: <20190613023208.GA29690@hari-Inspiron-1545>
 <CADnq5_PU_jvOskC-=+oRQdvYXZvu_n26ogoWTxLRxnW+ke4wDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CADnq5_PU_jvOskC-=+oRQdvYXZvu_n26ogoWTxLRxnW+ke4wDw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Charlene Liu <charlene.liu-5C7GfCeVMHo@public.gmane.org>, Hariprasad Kelam <hariprasad.kelam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmytro Laktyushkin <Dmytro.Laktyushkin-5C7GfCeVMHo@public.gmane.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, Tony Cheng <tony.cheng-5C7GfCeVMHo@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Gloria Li <geling.li-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Yongqiang Sun <yongqiang.sun-5C7GfCeVMHo@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>, Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>, Anthony Koo <Anthony.Koo-5C7GfCeVMHo@public.gmane.org>

SGkgQWxleC4KCk9uIFdlZCwgSnVuIDEyLCAyMDE5IGF0IDEwOjM1OjI2UE0gLTA0MDAsIEFsZXgg
RGV1Y2hlciB3cm90ZToKPiBPbiBXZWQsIEp1biAxMiwgMjAxOSBhdCAxMDozNCBQTSBIYXJpcHJh
c2FkIEtlbGFtCj4gPGhhcmlwcmFzYWQua2VsYW1AZ21haWwuY29tPiB3cm90ZToKPiA+Cj4gPiB0
aGlzIHBhdGNoIGZpeGVzIGJlbG93IGNvbXBpbGF0aW9uIGVycm9yCj4gPgo+ID4gZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY24xMC9kY24xMF9od19zZXF1ZW5jZXIu
YzogSW4KPiA+IGZ1bmN0aW9uIOKAmGRjbjEwX2FwcGx5X2N0eF9mb3Jfc3VyZmFjZeKAmToKPiA+
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBfaHdf
c2VxdWVuY2VyLmM6MjM3ODozOgo+ID4gZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1
bmN0aW9uIOKAmHVkZWxheeKAmQo+ID4gWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFy
YXRpb25dCj4gPiAgICB1ZGVsYXkodW5kZXJmbG93X2NoZWNrX2RlbGF5X3VzKTsKPiA+Cj4gPiBT
aWduZWQtb2ZmLWJ5OiBIYXJpcHJhc2FkIEtlbGFtIDxoYXJpcHJhc2FkLmtlbGFtQGdtYWlsLmNv
bT4KCkFtIEkgcmlnaHQgaW4gYXNzdW1pbmcgeW91IHRvb2sgdGhpcyBwYXRjaD8KCkkgZXhwZWN0
IHRoYXQgbmV3IGNvZGUgdXNpbmcgdWRlbGF5IHdhcyBhZGRlZCB0byB0aGUgYW1kIHRyZWUsCmFu
ZCB3aGVuIG1lcmdlZCB3aXRoIGRybS1taXNjLW5leHQgaXQgZmFpbGVkLCBiZWNhdXNlIGRybS1t
aXNjLW5leHQgbm8KbG9uZ2VyIGhhZCBkcm1QLmggaW5jbHVkZWQgc28gbm8gaW1wbGljaXQgaW5j
bHVkZSBvZiBkZWxheS5oCgpUaGUgcm9vdCBjYXVzZSB3YXMgdGhhdCBteSBvcmlnaW5hbCBwYXRj
aHNldCBzaG91bGQgaGF2ZSBiZWVuIGJhc2VkCm9uIHRoZSBhbWQgdHJlZSwgYW5kIGFwcGxpZWQg
dGhlcmUgOi0oCgoJU2FtCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
