From: Arkadiusz Hiler <arkadiusz.hiler-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [Intel-gfx] [PATCH i-g-t] tests: Rename I915_MAX_PIPES to
 IGT_MAX_PIPES
Date: Tue, 13 Jun 2017 15:41:14 +0300
Message-ID: <20170613124114.GA16239@ahiler-desk1.ger.corp.intel.com>
References: <1497042784-22210-1-git-send-email-sunpeng.li@amd.com>
 <06254a1a-31ba-1372-a17b-280ae7fc1e21@amd.com>
 <20170612115415.GB2999@ahiler-desk1.ger.corp.intel.com>
 <f8d21da3-d638-3180-10da-f05441c3d34a@amd.com>
 <87vao0ibll.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87vao0ibll.fsf-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
To: Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: sunpeng.li-5C7GfCeVMHo@public.gmane.org, Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>, intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gVHVlLCBKdW4gMTMsIDIwMTcgYXQgMTA6MzU6MzRBTSArMDMwMCwgSmFuaSBOaWt1bGEgd3Jv
dGU6Cj4gT24gTW9uLCAxMiBKdW4gMjAxNywgSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5k
QGFtZC5jb20+IHdyb3RlOgo+ID4gVGhlIGVtYWlsIHdhcyBzZW50IGJ1dCBtaWdodCBiZSBzdHVj
ayBpbiB0aGUgbW9kZXJhdGlvbiBxdWV1ZSBzaW5jZSBMZW8KPiA+IChTdW4gcGVuZykgaXMgZmFp
cmx5IG5ldyBvbiB0aGUgRkRPIG1haWxpbmcgbGlzdHMuCj4gPgo+ID4gSmFuaSwgRGFuaWVsLCBj
YW4geW91IGNoZWNrIGlmIExlbydzIElHVCBlbWFpbHMgYXJlIHN0dWNrIGluIHRoZQo+ID4gbW9k
ZXJhdGlvbiBxdWV1ZT8KPiAKPiBEb25lLiBJJ3ZlIHdoaXRlbGlzdGVkIGhpcyBlbWFpbCBhZGRy
ZXNzIG9uIGludGVsLWdmeCwgYnV0IEkgc3VnZ2VzdAo+IHN1YnNjcmliaW5nIHRvby4KPiAKPiBC
UiwKPiBKYW5pLgoKVGhhbmtzIEphbmkuCgpJJ2xsIHdhaXQgd2l0aCBwdXNoaW5nIHRoaXMgdW50
aWxsIHdlIHJ1biBpdCB0aG91Z2ggQ0kgc3lzdGVtIHRvIG1ha2UKc3VyZSBub3RoaW5nIGJyZWFr
cywgYXMgc3VnZ2VzdGVkIGJ5IFBldHJpLgoKVGhhbmtzIGZvciB0aGUgcGF0Y2ghCgotLSAKQ2hl
ZXJzLApBcmVrCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
