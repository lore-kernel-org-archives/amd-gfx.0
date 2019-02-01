From: sylvain.bertrand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: Re: [PATCH 01/35] drm/amd/display: Use udelay when waiting between
 aux retries
Date: Fri, 1 Feb 2019 22:55:59 +0000
Message-ID: <20190201225559.GA1064@freedom>
References: <20190201152847.11151-1-Bhawanpreet.Lakha@amd.com>
 <20190201152847.11151-2-Bhawanpreet.Lakha@amd.com>
 <20190201173141.GA3838@freedom>
 <fda8f6ec-5a75-6456-3034-f3714b304b77@amd.com>
 <20190201200830.GA7069@freedom> <20190201204706.GA8286@freedom>
 <058665e8-0241-8fc1-8a2a-9f1d7484b29e@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <058665e8-0241-8fc1-8a2a-9f1d7484b29e-5C7GfCeVMHo@public.gmane.org>
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
To: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Cc: "Barberiz, John" <John.Barberiz-5C7GfCeVMHo@public.gmane.org>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gRnJpLCBGZWIgMDEsIDIwMTkgYXQgMDk6MjA6NTZQTSArMDAwMCwgV2VudGxhbmQsIEhhcnJ5
IHdyb3RlOgo+IERSTSdzIEFVWCBjb2RlIHVzZXMgdXNsZWVwX3JhbmdlIGluIGRybV9kcF9kcGNk
X2FjY2Vzcy4KCk15IGJhZCwgZm9yZ290IGFib3V0IHRoZSB1c2xlZXBfcmFuZ2Ugc3dpdGNoLiBU
aGF0IHNhaWQgQVVYX1JFVFJZX0lOVEVSVkFMIGlzCjUwMCB1cywgd2l0aCBhIHVzbGVlcF9yYW5n
ZSB0b3AgYm91bmQgb2YgNjAwIHVzLgoKVGhlbiwgaXQgd291bGQgbWVhbiBEQyBEUCB0aW1lb3V0
IHJldHJpZXMgd291bGQgaGFwcGVuIGFmdGVyIH4xbXMsIGFuZCBkcm0KfjYwMHVzLiBBZGRpdGlv
bmFseSwgaXQgc2VlbXMgdGhhdCB0aGUgbnVtYmVyIG9mIHJldHJpZXMgYXJlIDMgaW4gZHJtIGNv
ZGUgYW5kCjcgaW4gREMgY29kZS4gCgpJIG1heSBiZSB3cm9uZywgYnV0IGl0IHNlZW1zIERDIGNv
ZGUgaXMgbXVjaCBtb3JlICJpbnNpc3RpbmciIG9uIGF1eGNoYW5uZWwKKGVkaWQgcmV0cmlldmFs
KSBhbmQgbXVjaCBtb3JlIGZvcmdpdmluZyBvbiBtb25pdG9yIGFiaWxpdHkgdG8gdGltZW91dCBp
bgp0aW1lICh+MW1zKS4KCklmIEkgZGlkIHJlYWQgdGhlIGNvZGUgdGhlIHJpZ2h0IHdheSwgaXQg
bWF5IGJlIG1vcmUgcmVhc29uYWJsZSB0byBoYXZlIHNpbWlsYXIKYmVoYXZpb3IgaW4gZHJtIGNv
ZGUgdGhhbiBpbiBEQyBjb2RlLCByaWdodD8KCi0tIApTeWx2YWluCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
