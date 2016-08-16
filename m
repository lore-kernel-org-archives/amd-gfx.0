From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: DCE wait for idle
Date: Tue, 16 Aug 2016 09:37:47 -0400
Message-ID: <CADnq5_OWFo6emg2RQa3NPWOGJAJcyNsy_JCNq44=Z7VAcUMQ_g@mail.gmail.com>
References: <DM5PR12MB11324CCFF1289BEC5B42565EF7130@DM5PR12MB1132.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB11324CCFF1289BEC5B42565EF7130-2J9CzHegvk+UzrhdoDeimQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gVHVlLCBBdWcgMTYsIDIwMTYgYXQgNzo1MyBBTSwgU3REZW5pcywgVG9tIDxUb20uU3REZW5p
c0BhbWQuY29tPiB3cm90ZToKPiBJbiB0aGVzZSBmdW5jdGlvbnMKPgo+Cj4gc3RhdGljIGJvb2wg
ZGNlX3YxMV8wX2lzX2lkbGUodm9pZCAqaGFuZGxlKQo+IHsKPiByZXR1cm4gdHJ1ZTsKPiB9Cj4K
PiBzdGF0aWMgaW50IGRjZV92MTFfMF93YWl0X2Zvcl9pZGxlKHZvaWQgKmhhbmRsZSkKPiB7Cj4g
cmV0dXJuIDA7Cj4gfQo+Cj4gU2hvdWxkbid0IHRoZXkgd2FpdCBvbiB0aGUgR1VJIGJpdCBvZiB0
aGUgR1JCTV9TVEFUVVMgcmVnaXN0ZXI/CgpUaGVyZSBpcyBubyBEQ0Ugc3RhdGUgaW4gdGhlIFNS
Qk1fU1RBVFVTIHJlZ2lzdGVycy4gIEdSQk1fU1RBVFVTIGlzCm9ubHkgdGhlIDNkL2NvbXB1dGUg
ZW5naW5lLiAgVGhlIEdVSSBiaXQganVzdCBtZWFucyBzb21ldGhpbmcgaW4gdGhlCjNkL2NvbXB1
dGUgYmxvY2sgaXMgYnVzeS4gIEl0J3Mgbm90IERDRSBzdGF0dXMuICBUaGVyZSBhcmUgYSBsb3Qg
b2YKY29tcG9uZW50cyBpbiB0aGUgRENFIGVuZ2luZSB0aGF0IGNvdWxkIGJlIGJ1c3kgKGdycGgs
IGNydGMsCnRyYW5zbWl0dGVycywgZW5jb2RlcnMsIGxpbmUgYnVmZmVycywgZXRjLikgYW5kIGlm
IGEgZGlzcGxheSBwYXRoIGlzCmFjdGl2ZSwgdGhleSBhcmUgbGlrZWx5IHRvIGJlLiAgVGhhdCBz
YWlkLCB0aGUgc3RhdHVzIG9mIHRoZSBEQ0UgYmxvY2sKaXMgZ2VuZXJhbGx5IG5vdCBpbnRlcmVz
dGluZyBmb3IgbW9zdCB0aGluZ3Mgd2UgdXNlIHRoZSBpZGxlIGNhbGxiYWNrcwpmb3IuCgpBbGV4
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
