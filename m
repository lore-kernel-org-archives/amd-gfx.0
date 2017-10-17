From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/9] drm/amdkfd: Avoid submitting an unnecessary packet to
 HWS
Date: Tue, 17 Oct 2017 13:26:35 -0400
Message-ID: <4ffac32e-9955-af7a-ab9c-cd1ee50a8c97@amd.com>
References: <1506485396-6326-1-git-send-email-Felix.Kuehling@amd.com>
 <1506485396-6326-5-git-send-email-Felix.Kuehling@amd.com>
 <CAFCwf113j3LDjeST-me4NOK=o6N+JxCcaR8zxPt+XtuOy091mA@mail.gmail.com>
 <CAFCwf13vQn8NG0dxS1jxT1yj3e7evbOgM9vt1DXrSUf_fzm0JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAFCwf13vQn8NG0dxS1jxT1yj3e7evbOgM9vt1DXrSUf_fzm0JQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-CA
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
To: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Yong Zhao <yong.zhao-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SSdsbCBzZW5kIHlvdSBhIHBhdGNoIGJ5IEZyaWRheS4KClJlZ2FyZHMsCsKgIEZlbGl4CgoKT24g
MjAxNy0xMC0xNyAwMzowNCBBTSwgT2RlZCBHYWJiYXkgd3JvdGU6Cj4gSGkgRmVsaXgsIFlvbmcu
Cj4gSSB3b3VsZCBsaWtlIHRvIHNlbmQgYSBwdWxsIHJlcXVlc3QgdG8gRGF2ZSBmb3Iga2VybmVs
IDQuMTUgd2l0aCBhbGwKPiB0aGUgcGF0Y2hlcyB5b3Ugc2VudCBpbiB0aGUgbGFzdCAzIHdlZWtz
LCBidXQgSSdtIGJsb2NrZWQgYnkgdGhlIGZpeCBJCj4gYXNrZWQgZm9yIHRoaXMgcGF0Y2guCj4g
RG8geW91IHRoaW5rIHlvdSBjb3VsZCBtYWtlIGl0IGhhcHBlbiB1bnRpbCB0aGUgZW5kIG9mIHRo
ZSB3ZWVrID8KPgo+IFRoYW5rcywKPiBPZGVkCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
