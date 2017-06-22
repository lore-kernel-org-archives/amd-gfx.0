From: Mario Kleiner <mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] drm/vc4: Allow vblank_disable_immediate on non-fw-kms.
Date: Thu, 22 Jun 2017 03:39:36 +0200
Message-ID: <650fc80b-a90d-157d-15e4-89c69d1b8189@gmail.com>
References: <20170621014457.26587-1-mario.kleiner.de@gmail.com>
 <20170621014457.26587-2-mario.kleiner.de@gmail.com>
 <87r2ydco07.fsf@eliezer.anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <87r2ydco07.fsf-omZaPlIz5HhaEpDpdNBo/KxOck334EZe@public.gmane.org>
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
To: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDYvMjEvMjAxNyAwNjoxOSBQTSwgRXJpYyBBbmhvbHQgd3JvdGU6Cj4gTWFyaW8gS2xlaW5l
ciA8bWFyaW8ua2xlaW5lci5kZUBnbWFpbC5jb20+IHdyaXRlczoKPiAKPj4gV2l0aCBpbnN0YW50
YW5lb3VzIGhpZ2ggcHJlY2lzaW9uIHZibGFuayB0aW1lc3RhbXBpbmcKPj4gdGhhdCB1cGRhdGVz
IGF0IGxlYWRpbmcgZWRnZSBvZiB2YmxhbmssIHRoZSBlbXVsYXRlZAo+PiAiaHcgdmJsYW5rIGNv
dW50ZXIiIGZyb20gdmJsYW5rIHRpbWVzdGFtcGluZyB3aGljaAo+PiBpbmNyZW1lbnRzIGF0IGxl
YWRpbmcgZWRnZSBvZiB2YmxhbmssIGFuZCByZWxpYWJsZQo+PiBwYWdlIGZsaXAgZXhlY3V0aW9u
IGFuZCBjb21wbGV0aW9uIGF0IGxlYWRpbmcgZWRnZQo+PiBvZiB2YmxhbmssIHdlIHNob3VsZCBt
ZWV0IHRoZSByZXF1aXJlbWVudHMgZm9yIGZhc3QKPj4gdmJsYW5rIGlycSBkaXNhYmxlL2VuYWJs
ZS4KPj4KPj4gVGVzdGluZyBhZ2FpbnN0IHJwaS00LjEyLXJjNSBMaW51eCBrZXJuZWwgd2l0aCB0
aW1pbmcKPj4gbWVhc3VyZW1lbnQgZXF1aXBtZW50IGluZGljYXRlcyB0aGlzIHdvcmtzIGZpbmUs
Cj4+IHNvIGFsbG93IGltbWVkaWF0ZSB2YmxhbmsgZGlzYWJsZSBmb3IgcG93ZXIgc2F2aW5nLgo+
Pgo+PiBGb3IgZGVidWdnaW5nIGluIGNhc2Ugb2YgdW5leHBlY3RlZCB0cm91YmxlLCBib290aW5n
Cj4+IHdpdGgga2VybmVsIGNtZGxpbmUgb3B0aW9uIGRybS52YmxhbmtvZmZkZWxheT0wCj4+IHdv
dWxkIGtlZXAgdmJsYW5rIGlycXMgb24gdG8gYXBwcm94aW1hdGUgb2xkIGJlaGF2aW9yLgo+Pgo+
PiBTaWduZWQtb2ZmLWJ5OiBNYXJpbyBLbGVpbmVyIDxtYXJpby5rbGVpbmVyLmRlQGdtYWlsLmNv
bT4KPj4gQ2M6IEVyaWMgQW5ob2x0IDxlcmljQGFuaG9sdC5uZXQ+Cj4gCj4gSWYgeW91IGNhbiBz
cGluIHRoaXMgYWdhaW5zdCBkcm0tbWlzYy1uZXh0IGluc3RlYWQgb2YgdGhlIGRvd25zdHJlYW0K
PiB0cmVlLCBJIGNhbiBnZXQgaXQgYXBwbGllZC4KPiAKCkRvbmUsIHRoYW5rcyEKLW1hcmlvCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
