From: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] Revert "drm/amdgpu/display: Replace
 CONFIG_DRM_AMD_DC_DCN1_0 with CONFIG_X86"
Date: Fri, 17 Aug 2018 09:56:57 -0400
Message-ID: <773509cb-9760-325c-42ee-abe76684ea32@amd.com>
References: <1534448679-13823-1-git-send-email-sunpeng.li@amd.com>
 <8d7c294c-6585-01f1-cd78-5c30cd30142d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <8d7c294c-6585-01f1-cd78-5c30cd30142d-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, alexander.deucher-5C7GfCeVMHo@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, michel.daenzer-5C7GfCeVMHo@public.gmane.org
Cc: airlied-cv59FeDIM0c@public.gmane.org, Jordan.Lazare-5C7GfCeVMHo@public.gmane.org, harry.wentland-5C7GfCeVMHo@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

CgpPbiAyMDE4LTA4LTE3IDAzOjE2IEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDE2
LjA4LjIwMTggdW0gMjE6NDQgc2NocmllYiBzdW5wZW5nLmxpQGFtZC5jb206Cj4+IFtTTklQXQo+
PiArY29uZmlnIERSTV9BTURfRENfRENOMV8wCj4+ICvCoMKgwqAgYm9vbCAiRENOIDEuMCBSYXZl
biBmYW1pbHkiCj4+ICvCoMKgwqAgZGVwZW5kcyBvbiBEUk1fQU1EX0RDICYmIFg4Ngo+PiArwqDC
oMKgIGRlZmF1bHQgeQo+PiArwqDCoMKgIGhlbHAKPj4gK8KgwqDCoMKgwqAgQ2hvb3NlIHRoaXMg
b3B0aW9uIGlmIHlvdSB3YW50IHRvIGhhdmUKPj4gK8KgwqDCoMKgwqAgUlYgZmFtaWx5IGZvciBk
aXNwbGF5IGVuZ2luZQo+PiArCj4gCj4gUHJvYmFibHkgYmV0dGVyIHRvIGZvbGxvdyBNaWNoZWwn
cyBzdWdnZXN0aW9uIGFuZCBub3QgbWFrZSB0aGF0IGFuIHVzZSAKPiBjb25maWd1cmFibGUgb3B0
aW9uLgo+IAo+IEluc3RlYWQganVzdCBzZWxlY3QgaXQgYmFzZWQgb24gdGhlIGRlcGVuZGVuY2ll
cy4KClRoZSAybmQgcGF0Y2ggc2hvdWxkIGhhdmUgdGFrZW4gY2FyZSBvZiB0aGF0IDopCkxlbwoK
PiAKPiBDaHJpc3RpYW4uCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
