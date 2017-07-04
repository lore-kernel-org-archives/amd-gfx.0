From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: set firmware loading type as direct by
 default for raven
Date: Tue, 4 Jul 2017 17:59:03 +0800
Message-ID: <20170704095902.GA25844@hr-amur2>
References: <1499157314-28393-1-git-send-email-ray.huang@amd.com>
 <595B6267.9040600@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <595B6267.9040600-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

T24gVHVlLCBKdWwgMDQsIDIwMTcgYXQgMDU6Mzk6NTFQTSArMDgwMCwgWmhhbmcsIEplcnJ5IHdy
b3RlOgo+IEhpIFJheSwKPiAKPiBUaGFua3MgZm9yIHlvdXIgaW5pdGlhbCBwYXRjaCB0byBlbmFi
bGUgUFNQIG9wdGlvbiBmb3IgUmF2ZW4uCj4gCj4gVG8gc2ltcGxpZnkgaXQsIHdlIG1heSBsZXZl
cmFnZSBWRUdBMTAgY2FzZSBmb3IgUmF2ZW4gZGlyZWN0bHkuCj4gQW5kIHJlbW92ZSBhbGwgUmF2
ZW4gZXhpc3RpbmcgY29kZSB1bmRlciAiY2FzZSBDSElQX1JBVkVOIgo+IEhvdyBkbyB5b3UgdGhp
bmsgYWJvdXQgaXQ/Cj4gCgpQcm9iYWJseSBub3QuIFZlZ2ExMCBlbmFibGVkIHBzcCBmdyBsb2Fk
aW5nIGJ5IGRlZmF1bHQsIGJ1dCBub3QgZm9yIHJhdmVuLgoKTXkgbWFpbmx5IGlkZWEgaGVyZSBp
cyAKCmRlZmF1bHQ6Cm1vZHByb2JlIGFtZGdwdSAtPiB1c2UgZGlyZWN0IGZ3IGxvYWRpbmcuCgpk
ZWJ1Z2dpbmcgcHNwOgptb2Rwcm9iZSBhbWRncHUgZndfbG9hZF90eXBlPTIgLT4gdXNlIHBzcCBm
dyBsb2FkaW5nLgoKSXQgZG9lc24ndCBpbXBhY3Qgb3RoZXIgZ3V5cyB1c2UgYW5kIHdlIGNhbiBk
ZWJ1ZyBpdCBtb3JlIHNtb290aGx5LiA6LSkKClRoYW5rcywKUmF5Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
