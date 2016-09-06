From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 00/15] drm/amdgpu/si: Make SI DPM workable
Date: Tue, 6 Sep 2016 10:35:54 +0800
Message-ID: <20160906023553.GA5814@hr-amur2>
References: <1472621007-17578-1-git-send-email-ray.huang@amd.com>
 <CAAxE2A6D3hAP1D3i0py3G4erMGNq8-5LjypVA_PnEQQSUjEshQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAAxE2A6D3hAP1D3i0py3G4erMGNq8-5LjypVA_PnEQQSUjEshQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Marek =?utf-8?B?T2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Huan, Alvin" <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Yu,
 Hui" <Hui.Yu-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Wang,
 Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

T24gVHVlLCBTZXAgMDYsIDIwMTYgYXQgMDM6MzE6NDZBTSArMDgwMCwgTWFyZWsgT2zFocOhayB3
cm90ZToKPiBIaSBSdWksCj4gCj4gRG8geW91IGhhdmUgVGFoaXRpIExFIGluIHRoZSBvZmZpY2U/
IEl0IG1pZ2h0IGJlIHdvcnRoIHRlc3RpbmcgaXQgdG8KPiBzZWUgaWYgaXQgd29ya3MuIFRoZXJl
IHdlcmUgc29tZSBpc3N1ZXMgd2l0aCBpdCBpbiB0aGUgcGFzdC4KPiAKCkkgdXNlZCBUYWhpdGkg
WFQgW0RldmljZSBJRCA2Nzk4XSwgZG8geW91IGtub3cgdGhlIGRldmljZSBpZCBvZiBUYWhpdGkg
TEU/CgpUaGFua3MsClJ1aQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
