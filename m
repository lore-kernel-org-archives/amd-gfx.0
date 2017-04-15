From: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 09/17] drm/amdgpu: take ownership of per-pipe
 configuration v2
Date: Sat, 15 Apr 2017 15:37:18 +0300
Message-ID: <CAFCwf12haVgYLxxcqMqTd-GX7KjxtZXD1Stuqj87HAP32TdvXQ@mail.gmail.com>
References: <20170413213542.18802-1-andresx7@gmail.com>
 <20170413213542.18802-10-andresx7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170413213542.18802-10-andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gRnJpLCBBcHIgMTQsIDIwMTcgYXQgMTI6MzUgQU0sIEFuZHJlcyBSb2RyaWd1ZXogPGFuZHJl
c3g3QGdtYWlsLmNvbT4gd3JvdGU6Cj4gTWFrZSBhbWRncHUgdGhlIG93bmVyIG9mIGFsbCBwZXIt
cGlwZSBzdGF0ZSBvZiB0aGUgSFFEcy4KPgo+IFRoaXMgY2hhbmdlIHdpbGwgYWxsb3cgdXMgdG8g
c3BsaXQgdGhlIHF1ZXVlcyBiZXR3ZWVuIGtmZCBhbmQgYW1kZ3B1Cj4gd2l0aCBhIHF1ZXVlIGdy
YW51bGFyaXR5IGluc3RlYWQgb2YgcGlwZSBncmFudWxhcml0eS4KPgo+IFRoaXMgcGF0Y2ggZml4
ZXMga2ZkIGFsbG9jYXRpbmcgYW4gSERQX0VPUCByZWdpb24gZm9yIGl0cyAzIHBpcGVzIHdoaWNo
Cj4gZ29lcyB1bnVzZWQuCj4KPiB2Mjogc3VwcG9ydCBmb3IgZ2Z4OQo+Cj4gUmV2aWV3ZWQtYnk6
IEVkd2FyZCBPJ0NhbGxhZ2hhbiA8ZnVuZnVuY3RvckBmb2xrbG9yZTE5ODQubmV0Pgo+IFJldmll
d2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KPiBBY2tlZC1i
eTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IFNpZ25lZC1v
ZmYtYnk6IEFuZHJlcyBSb2RyaWd1ZXogPGFuZHJlc3g3QGdtYWlsLmNvbT4KCkhpIEFuZHJlcywK
RllJLCB3aXRoIHlvdXIgcGF0Y2hzZXQgcmViYXNlZCBvbiBhbGV4J3MgZHJtLW5leHQtNC4xMi13
aXAsIG15IEthdmVyaQptYWNoaW5lIHdvbid0IGJvb3QgdGhlIE9TIChVYnVudHUgMTYuMDQpLgpJ
IGJpc2VjdGVkIHlvdXIgcGF0Y2gtc2V0IGFuZCB0aGUgZmlyc3QgYmFkIHBhdGNoIGlzIHRoaXMg
b25lLgoKVW5mb3J0dW5hdGVseSwgSSBkb24ndCBoYXZlIHRoZSBtZWFucyB0byBkdW1wIGtlcm5l
bCBjcmFzaGVzIGJlZm9yZQp0aGUgc3lzdGVtIGJvb3RzLgoKVGh4LApPZGVkCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
