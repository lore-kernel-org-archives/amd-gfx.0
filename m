From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/3] drm/amdgpu: Tweaks for high pressure on CPU visible
 VRAM
Date: Fri, 19 May 2017 17:49:38 +0200
Message-ID: <CAAxE2A55HQzmEQ5jd9kRyFWN=F7gxssizeZEtSWv9=H5y4+H6Q@mail.gmail.com>
References: <20170518090809.15916-1-michel@daenzer.net>
 <1495163086-4747-1-git-send-email-john@fastquake.com>
 <CAAxE2A6pcm8EiXDRO2kO64TWJRR4BVrzbpiVrLdzhh3uERzTUg@mail.gmail.com>
 <20170519152732.GA11484@kitsune.fastquake.com>
 <CAAxE2A77Yu9c02Mu-wK3HD_gAKvPbN8q7aEtHcxrcOUhGG4Pfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A77Yu9c02Mu-wK3HD_gAKvPbN8q7aEtHcxrcOUhGG4Pfw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: John Brooks <john-xq/Ko7C6e2Bl57MIdRCFDg@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gRnJpLCBNYXkgMTksIDIwMTcgYXQgNTo0NyBQTSwgTWFyZWsgT2zFocOhayA8bWFyYWVvQGdt
YWlsLmNvbT4gd3JvdGU6Cj4gT24gRnJpLCBNYXkgMTksIDIwMTcgYXQgNToyNyBQTSwgSm9obiBC
cm9va3MgPGpvaG5AZmFzdHF1YWtlLmNvbT4gd3JvdGU6Cj4+IE9uIEZyaSwgTWF5IDE5LCAyMDE3
IGF0IDA1OjI0OjM2UE0gKzAyMDAsIE1hcmVrIE9sxaHDoWsgd3JvdGU6Cj4+PiBXaGVyZSBpcyB5
b3VyICJhdHRhY2hlZCIgcGF0Y2g/Cj4+Pgo+Pj4gTWFyZWsKPj4KPj4gSXQncyBhY3R1YWxseSBh
IHJlcGx5IHRvIG15IG1lc3NhZ2UuIFNvcnJ5IGlmIHRoYXQgd2FzIHVuY2xlYXIuCj4KPiBUaGF0
J3MgT0ssIGJ1dCBJIGRvbid0IHNlZSBhbnkgcGF0Y2ggZnJvbSB5b3UgaGVyZS4KCk5ldmVybWlu
ZC4gSSBndWVzcyBpdCdzICJkcm0vYW1kZ3B1OiBQbGFjZSBuZXcgQ1BVLWFjY2Vzc2JpbGUgQk9z
IGluCkdUVCBpZiB2aXNpYmxlIFZSQU0gaXMgZnVsbCIsIHdoaWNoIGlzIGEgZGlmZmVyZW50IHRo
cmVhZCBpbiBHbWFpbC4KCk1hcmVrCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
