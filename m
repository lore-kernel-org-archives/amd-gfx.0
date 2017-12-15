From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: remove redundant null check of array
 'data'
Date: Fri, 15 Dec 2017 10:05:39 -0500
Message-ID: <299963e5-5847-a2ca-0282-40ab3cd0f590@amd.com>
References: <20171215105343.11372-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171215105343.11372-1-colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Content-Language: en-US
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
To: Colin King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

T24gMjAxNy0xMi0xNSAwNTo1MyBBTSwgQ29saW4gS2luZyB3cm90ZToKPiBGcm9tOiBDb2xpbiBJ
YW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPgo+IAo+IFRoZSBudWxsIGNoZWNrIG9u
IGFjb25uZWN0b3ItPmJhc2UuZWRpZF9ibG9iX3B0ci0+ZGF0YSBpcyByZWR1bmRhbnQKPiBzaW5j
ZSBkYXRhIGlzIGFuIGFycmF5IGFuZCBjYW4gbmV2ZXIgYmUgbnVsbC4gIFJlbW92ZSBpdC4KPiAK
PiBEZXRlY3RlZCBieSBDb3Zlcml0eVNjYW4sIENJRCMxNDYwMzY5ICgiQXJyYXkgY29tcGFyZWQg
YWdhaW5zdCAwIikKPiAKPiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2lu
Z0BjYW5vbmljYWwuY29tPgoKUmV2aWV3ZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50
bGFuZEBhbWQuY29tPgoKSGFycnkKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAzICstLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4gaW5kZXggY2NiZjEwZTNiYmI2Li5jMzg4
Nzc4ZGJiYTMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdw
dV9kbS9hbWRncHVfZG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtLmMKPiBAQCAtMjcyNSw4ICsyNzI1LDcgQEAgc3RhdGljIHZvaWQgY3Jl
YXRlX2VtbF9zaW5rKHN0cnVjdCBhbWRncHVfZG1fY29ubmVjdG9yICphY29ubmVjdG9yKQo+ICAJ
fTsKPiAgCXN0cnVjdCBlZGlkICplZGlkOwo+ICAKPiAtCWlmICghYWNvbm5lY3Rvci0+YmFzZS5l
ZGlkX2Jsb2JfcHRyIHx8Cj4gLQkJIWFjb25uZWN0b3ItPmJhc2UuZWRpZF9ibG9iX3B0ci0+ZGF0
YSkgewo+ICsJaWYgKCFhY29ubmVjdG9yLT5iYXNlLmVkaWRfYmxvYl9wdHIpIHsKPiAgCQlEUk1f
RVJST1IoIk5vIEVESUQgZmlybXdhcmUgZm91bmQgb24gY29ubmVjdG9yOiAlcyAsZm9yY2luZyB0
byBPRkYhXG4iLAo+ICAJCQkJYWNvbm5lY3Rvci0+YmFzZS5uYW1lKTsKPiAgCj4gCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
