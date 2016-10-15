From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: don't give up if DPM is already running
Date: Sat, 15 Oct 2016 21:55:22 +0300
Message-ID: <CANOLnOM3XD6vX6rOH8ngrMGuQ+hZG7nFUV9fA=0L9BVi13bdVw@mail.gmail.com>
References: <1476040988-11676-1-git-send-email-notasas@gmail.com>
 <CADnq5_PBtB=c=ycPRU-gOndt8C7HaZL_7SxKD6uEBFvWsSXz8w@mail.gmail.com>
 <CY4PR12MB16875537013AAC3A7C43B615FBDD0@CY4PR12MB1687.namprd12.prod.outlook.com>
 <CY4PR12MB1687EAFA6B672B00C4C608D4FBDC0@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1687EAFA6B672B00C4C608D4FBDC0-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SGksCgpPbiBUaHUsIE9jdCAxMywgMjAxNiBhdCAxMDo0NSBBTSwgWmh1LCBSZXggPFJleC5aaHVA
YW1kLmNvbT4gd3JvdGU6Cj4KPiBUaGUgYXR0YWNoZWQgcGF0Y2hlcyB3ZXJlIGFsc28gZm9yIHRo
aXMgaXNzdWUuCj4gRGlzYWJsZSBkcG0gd2hlbiBybW1vZCBhbWRncHUuCgpJdCB3b3JrcyBmb3Ig
bW9kcHJvYmUtcm1tb2QtbW9kcHJvYmUgdGVzdCwgdGhhbmtzLgoKSG93ZXZlciB3aXRoIEdQVSBw
YXNzdGhyb3VnaCAoZ2l2aW5nIGNvbnRyb2wgb2YgdGhlIEdQVSB0byBhIFdpbmRvd3MKdmlydHVh
bCBtYWNoaW5lIHVzaW5nIGlvbW11LCB0aGVuIHNodXR0aW5nIGRvd24gdGhlIFZNIGFuZCBsb2Fk
aW5nCmFtZGdwdSkgdGhlIHByb2JsZW0gaXMgc3RpbGwgdGhlcmUsIHNhbWUgYmFja3RyYWNlIGFz
IGluIG15IGNvbW1pdAptZXNzYWdlLiBJdCBzZWVtcyB0aGUgV2luZG93cyBkcml2ZXIgbGVhdmVz
IERQTSBlbmFibGVkIG9uIHNodXRkb3duLgpXaXRoIG15IHBhdGNoIHRoZSBjcmFzaCBnb2VzIGF3
YXkuCgpJdCB3b3VsZCBiZSBuaWNlIHRvIGhhdmUgR1BVIHBhc3N0aHJvdWdoIHdvcmtpbmcsIHRo
aXMgaXMgdGhlIG9ubHkKaXNzdWUgdGhhdCBicmVha3MgaXQuIFdpbmRvd3MgY2FuIGRyaXZlIHRo
ZSBHUFUgYWZ0ZXIgYW1kZ3B1IGZpbmUKYWxyZWFkeSwgb25seSBhbWRncHUgaGFzIHByb2JsZW1z
IHRvIHJ1biBhZnRlciBXaW5kb3dzLgoKR3Jhxb52eWRhcwpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
