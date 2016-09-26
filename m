From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [amdgpu][CIK] drm-next-4.9-wip - piglit test - max-texture-size -
 GPU deadlock
Date: Mon, 26 Sep 2016 16:53:00 +0200
Message-ID: <CAAxE2A6LYPm_ZCSPK6yLMhCNj0eG_acBwK+XObm6bPUKMjHuvg@mail.gmail.com>
References: <1684872.K1LPhXps8I@segfault>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1684872.K1LPhXps8I@segfault>
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
To: Shawn Starr <shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SGksCgpZb3UgY2FuIHRyeSB0aGlzIHBhdGNoOgogIGRybS9hbWRncHU6IGZpeCBhZGRyIGhhbmRs
aW5nIGluIGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZwoKTWFyZWsKCk9uIEZyaSwgU2VwIDIz
LCAyMDE2IGF0IDEyOjM3IEFNLCBTaGF3biBTdGFyciA8c2hhd24uc3RhcnJAcm9nZXJzLmNvbT4g
d3JvdGU6Cj4gV2hlbiBJIHRyeSB0byBydW4gcGlnbGl0LCBJIGdldCBhIEdQVSBkZWFkbG9jayBy
dW5uaW5nIG1heC10ZXh0dXJlLXNpemUsCj4KPiBUZXN0OiBzcGVjLyFvcGVuZ2wgMS4xL21heC10
ZXh0dXJlLXNpemUKPgo+IEkgd2lsbCBiZWdpbiBiaXNlY3Rpbmcga2VybmVsIGRyaXZlciwgYnV0
IGlmIGFueW9uZSBoYXMgc29tZSB0aXBzIG9uIGxpa2VseQo+IGNvbW1pdHMgSSBjYW4gdGVzdCBm
dXJ0aGVyLgo+Cj4gVGhhbmtzLAo+IFNoYXduCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
