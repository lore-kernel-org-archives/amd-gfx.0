From: Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Subject: Re: amdgpu hangs on boot or shutdown on AMD Raven Ridge CPU (Engineer
 Sample)
Date: Thu, 22 Mar 2018 17:09:09 +0800
Message-ID: <CAD8Lp44vfd59L0UVMUuWRn7JNuib__E=NwWULc-3QPBk8W-GEA@mail.gmail.com>
References: <CAB4CAweUBN=8pd8x4AfMHor3D-C+1HRgAiG=1Vc1ne8M-cV-og@mail.gmail.com>
 <d2de9e60-239c-86a5-16af-bf74fe20a53a@amd.com>
 <CAB4CAwfv6RYRRCbf886+j-omPcwqjbCLC-hxVy=y=Sc1q18-kQ@mail.gmail.com>
 <CAB4CAweBvmuCYat8fjczbUFO-qg8=rEpSi+SbYPwQ=Rqb9fncw@mail.gmail.com>
 <CAD8Lp44hREd-ttStnttbN_gJ1vbYbV8HtEEfAn0f6V7=dHdWwA@mail.gmail.com>
 <CADnq5_MLCJjdiJsa9xCYEf9wB9WN7Y=kPDs-eN9hDdFb+FNS8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_MLCJjdiJsa9xCYEf9wB9WN7Y=kPDs-eN9hDdFb+FNS8w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, Chris Chiu <chiu-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Linux Upstreaming Team <linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>

SGkgQWxleCwKCk9uIFR1ZSwgRmViIDIwLCAyMDE4IGF0IDEwOjE4IFBNLCBBbGV4IERldWNoZXIg
PGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4gd3JvdGU6Cj4+IEl0IHNlZW1zIHRoYXQgd2UgYXJlIG5v
dCBhbG9uZSBzZWVpbmcgYW1kZ3B1LWluZHVjZWQgc3RhYmlsaXR5Cj4+IHByb2JsZW1zIG9uIG11
bHRpcGxlIFJhdmVuIFJpZGdlIHBsYXRmb3Jtcy4KPj4gaHR0cHM6Ly93d3cucGhvcm9uaXguY29t
L3NjYW4ucGhwP3BhZ2U9bmV3c19pdGVtJnB4PUFNRC1SYXZlbi1SaWRnZS1Nb2JvLUxpbnV4Cj4+
Cj4+IEFNRCwgd2hhdCBjYW4gd2UgZG8gdG8gaGVscD8KPgo+IFBsZWFzZSBmaWxlIGJ1Z3M6Cj4g
aHR0cHM6Ly9idWdzLmZyZWVkZXNrdG9wLm9yZwoKU29ycnkgZm9yIHRoZSBkZWxheWVkIHJlc3Bv
bnNlLiBXZSdyZSBzdGlsbCBzZWVpbmcgc2VyaW91cyBpbnN0YWJpbGl0eQpoZXJlIGV2ZW4gb24g
dGhlIGxhdGVzdCBrZXJuZWwuIEZpbGVkCmh0dHBzOi8vYnVncy5mcmVlZGVza3RvcC5vcmcvc2hv
d19idWcuY2dpP2lkPTEwNTY4NAoKVGhhbmtzLApEYW5pZWwKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
