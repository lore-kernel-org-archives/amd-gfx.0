From: Shawn Starr <shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>
Subject: [regression][amdgpu][CIK] drm-next-4.9-wip - piglit test -
 max-texture-size - GPU deadlock
Date: Fri, 14 Oct 2016 15:59:13 -0400
Message-ID: <2357723.EHtFVLQf92@segfault>
References: <1684872.K1LPhXps8I@segfault>
 <CAAxE2A6LYPm_ZCSPK6yLMhCNj0eG_acBwK+XObm6bPUKMjHuvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A6LYPm_ZCSPK6yLMhCNj0eG_acBwK+XObm6bPUKMjHuvg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gTW9uZGF5LCBTZXB0ZW1iZXIgMjYsIDIwMTYgNDo1MzowMCBQTSBFRFQgTWFyZWsgT2zFocOh
ayB3cm90ZToKPiBIaSwKPiAKPiBZb3UgY2FuIHRyeSB0aGlzIHBhdGNoOgo+ICAgZHJtL2FtZGdw
dTogZml4IGFkZHIgaGFuZGxpbmcgaW4gYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nCj4gCj4g
TWFyZWsKPgogCkhlbGxvIE1hcmVrLAoKVGhpcyBoYXMgcmVncmVzc2VkLCBjYW4gd2VkZ2UgR1BV
IGFnYWluLgoKS2VybmVsIGxvZzoKClsgMTU4MS40ODg0MzBdIFtkcm06YW1kZ3B1X2NzX2lvY3Rs
IFthbWRncHVdXSAqRVJST1IqIHR0bV9ldV9yZXNlcnZlX2J1ZmZlcnMgCmZhaWxlZC4KWyAxNTgx
LjQ5MzQyNl0gW2RybTphbWRncHVfY3NfaW9jdGwgW2FtZGdwdV1dICpFUlJPUiogdHRtX2V1X3Jl
c2VydmVfYnVmZmVycyAKZmFpbGVkLgpbIDE1ODEuNDk4NDE4XSBbZHJtOmFtZGdwdV9jc19pb2N0
bCBbYW1kZ3B1XV0gKkVSUk9SKiB0dG1fZXVfcmVzZXJ2ZV9idWZmZXJzIApmYWlsZWQuCgoKCj4g
T24gRnJpLCBTZXAgMjMsIDIwMTYgYXQgMTI6MzcgQU0sIFNoYXduIFN0YXJyIDxzaGF3bi5zdGFy
ckByb2dlcnMuY29tPiAKd3JvdGU6Cj4gPiBXaGVuIEkgdHJ5IHRvIHJ1biBwaWdsaXQsIEkgZ2V0
IGEgR1BVIGRlYWRsb2NrIHJ1bm5pbmcgbWF4LXRleHR1cmUtc2l6ZSwKPiA+IAo+ID4gVGVzdDog
c3BlYy8hb3BlbmdsIDEuMS9tYXgtdGV4dHVyZS1zaXplCj4gPiAKPiA+IEkgd2lsbCBiZWdpbiBi
aXNlY3Rpbmcga2VybmVsIGRyaXZlciwgYnV0IGlmIGFueW9uZSBoYXMgc29tZSB0aXBzIG9uCj4g
PiBsaWtlbHkKPiA+IGNvbW1pdHMgSSBjYW4gdGVzdCBmdXJ0aGVyLgo+ID4gCj4gPiBUaGFua3Ms
Cj4gPiBTaGF3bgo+ID4gCj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwo+ID4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiA+IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCj4gPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
