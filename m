From: Bas Nieuwenhuizen <basni-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 0/4] drm/ttm: move non-x86 definitions to the common
 header
Date: Thu, 26 Jul 2018 13:59:01 +0200
Message-ID: <CAC4kW=2cFrK_3aqMpgv0Y-06mizOqkOX-ZZ0T2QGFPGi_emoLg@mail.gmail.com>
References: <1532605933-26209-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1532605933-26209-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gVGh1LCBKdWwgMjYsIDIwMTggYXQgMTo1MiBQTSwgSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1k
LmNvbT4gd3JvdGU6Cj4gSGksCj4KPiBBcyBzdWdnZXN0ZWQgYnkgQ2hyaXN0aWFuLCB3ZSBzaG91
bGQgbW92ZSBub24teDg2IGRlZmluaXRpb25zIGludG8gb25lIGNvbW1vbgo+IGhlYWRlciwgYW5k
IGl0IHdpbGwgbWFrZSB0aGUgY29kZXMgcmVhZGFibGUuIFRoZXkgYXJlIGJhc2VkIG9uIHRoZSBp
bXByb3ZlbWVudAo+IGZpeCBvZiBCYXMgKGFscmVhZHkgcmViYXNlIEJhcydzIHBhdGNoIHRvIGRy
bS1uZXh0KS4KPgo+IENoYW5nZXMgZnJvbSBWMSAtPiBWMjoKPiAtIGFkZCB0dG1fIHByZWZpeCBh
dCB0aGlzIGhlYWRlci4KPiAtIHVzZSBzZXRfcGFnZXNfd2IgaW5zdGVhZCBvZiBzZXRfbWVtb3J5
X3diLgoKVGhhbmtzISBGb3IgdGhlIHNlcmllcwoKUmV2aWV3ZWQtYnk6IEJhcyBOaWV1d2VuaHVp
emVuIDxiYXNuaUBjaHJvbWl1bS5vcmc+Cj4KPiBUaGFua3MsCj4gUmF5Cj4KPiBCYXMgTmlldXdl
bmh1aXplbiAoMSk6Cj4gICBkcm0vdHRtOiBNZXJnZSBodWdlcGFnZSBhdHRyIGNoYW5nZXMgaW4g
dHRtX2RtYV9wYWdlX3B1dC4gKHYyKQo+Cj4gSHVhbmcgUnVpICgzKToKPiAgIGRybS90dG06IGFk
ZCB0dG1fc2V0X21lbW9yeSBoZWFkZXIgKHYyKQo+ICAgZHJtL3R0bTogY2xlYW4gdXAgbm9uLXg4
NiBkZWZpbml0aW9ucyBvbiB0dG1fcGFnZV9hbGxvY19kbWEKPiAgIGRybS90dG06IGNsZWFuIHVw
IG5vbi14ODYgZGVmaW5pdGlvbnMgb24gdHRtX3BhZ2VfYWxsb2MKPgo+ICBkcml2ZXJzL2dwdS9k
cm0vdHRtL3R0bV9wYWdlX2FsbG9jLmMgICAgIHwgIDYyICsrLS0tLS0tLS0tLS0tLQo+ICBkcml2
ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jX2RtYS5jIHwgIDU3ICsrLS0tLS0tLS0tLS0t
Cj4gIGluY2x1ZGUvZHJtL3R0bS90dG1fc2V0X21lbW9yeS5oICAgICAgICAgfCAxMjggKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAzIGZpbGVzIGNoYW5nZWQsIDE0MCBpbnNlcnRp
b25zKCspLCAxMDcgZGVsZXRpb25zKC0pCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2Ry
bS90dG0vdHRtX3NldF9tZW1vcnkuaAo+Cj4gLS0KPiAyLjcuNAo+Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
