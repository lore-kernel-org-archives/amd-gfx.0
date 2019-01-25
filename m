From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 01/26] drm/irq: Don't check for DRIVER_HAVE_IRQ in
 drm_irq_(un)install
Date: Fri, 25 Jan 2019 11:40:32 +0100
Message-ID: <20190125104032.GA27214@ravnborg.org>
References: <20190124165831.16427-1-daniel.vetter@ffwll.ch>
 <20190124165831.16427-2-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190124165831.16427-2-daniel.vetter-/w4YWyX8dFk@public.gmane.org>
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
To: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Intel Graphics Development <intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, DRI Development <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, spice-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

SGkgRGFuaWVsLgoKT24gVGh1LCBKYW4gMjQsIDIwMTkgYXQgMDU6NTg6MDZQTSArMDEwMCwgRGFu
aWVsIFZldHRlciB3cm90ZToKPiBJZiBhIG5vbi1sZWdhY3kgZHJpdmVyIGNhbGxzIHRoZXNlIGl0
J3MgdmFsaWQgdG8gYXNzdW1lIHRoZXJlIGlzCj4gaW50ZXJydXB0IHN1cHBvcnQuIFRoZSBmbGFn
IGlzIHJlYWxseSBvbmx5IG5lZWRlZCBmb3IgbGVnYWN5IGRyaXZlcnMuCj4gCj4gQWxzbyByZW1v
dmUgYWxsIHRoZSBmbGFnIHVzYWdlIGZyb20gbm9uLWxlZ2FjeSBkcml2ZXJzLgo+IAo+IFNpZ25l
ZC1vZmYtYnk6IERhbmllbCBWZXR0ZXIgPGRhbmllbC52ZXR0ZXJAaW50ZWwuY29tPgo+IENjOiBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBDYzogaW50ZWwtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwo+IENjOiBsaW51eC1hbWxvZ2ljQGxpc3RzLmluZnJhZGVhZC5vcmcK
PiBDYzogbGludXgtYXJtLW1zbUB2Z2VyLmtlcm5lbC5vcmcKPiBDYzogZnJlZWRyZW5vQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwo+IENjOiB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwo+IENjOiBzcGljZS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogbGludXgtcmVuZXNhcy1zb2NAdmdlci5r
ZXJuZWwub3JnCgpUaGUgYWN0dWFsIGNvZGUgY2hhbmdlcyBsb29rcyBnb29kLgpCdXQgaWYgdGhp
cyBpcyB0aGUgcmlnaHQgdGhpbmcgdG8gZG8gSSBjYW5ub3QgdGVsbC4KCk9uIHRoaXMgKGxpbWl0
ZWQpIGJhc2lzIEkgcHJvdmlkZSBhbjoKUmV2aWV3ZWQtYnk6IFNhbSBSYXZuYm9yZyA8c2FtQHJh
dm5ib3JnLm9yZz4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
