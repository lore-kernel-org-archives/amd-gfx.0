From: Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: always reset asic when going into suspend
Date: Mon, 25 Nov 2019 13:17:59 +0800
Message-ID: <CAD8Lp46f9LR_VJ26BGfOGvj8sTjKZowkbjLNv6R4CsVMfRZQ=Q@mail.gmail.com>
References: <20191015065002.18701-1-drake@endlessm.com>
 <CADnq5_M4Leu0raYS6M72MqTm1+PLg9BjHCHLAYuB2-dEVP56_A@mail.gmail.com>
 <CAD8Lp443ZhPEo0PJRxbTSB9DY9x92OvWBeH29m9Ehpyhg+2n5A@mail.gmail.com>
 <CADnq5_OaATVESAY9E2mtd7PoV2VjG=WLS56LCHVpieSHDTas0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_OaATVESAY9E2mtd7PoV2VjG=WLS56LCHVpieSHDTas0A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: "Deucher, Alexander" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

T24gRnJpLCBOb3YgMjIsIDIwMTkgYXQgMTE6MzIgUE0gQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hl
ckBnbWFpbC5jb20+IHdyb3RlOgo+IERvIHRoZXNlIHBhdGNoZXMgaGVscD8KPiBodHRwczovL3Bh
dGNod29yay5mcmVlZGVza3RvcC5vcmcvcGF0Y2gvMzQxNzc1Lwo+IGh0dHBzOi8vcGF0Y2h3b3Jr
LmZyZWVkZXNrdG9wLm9yZy9wYXRjaC8zNDE5NjgvCgpVbmZvcnR1bmF0ZWx5IG5vdC4gVGhlIG9y
aWdpbmFsIGlzc3VlIHN0aWxsIGV4aXN0cyAoZGVhZCBnZnggYWZ0ZXIKcmVzdW1lIGZyb20gczJp
ZGxlKSBhbmQgYWxzbyB3aGVuIEkgdHJpZ2dlciBleGVjdXRpb24gb2YgdGhlIHN1c3BlbmQKb3Ig
cnVudGltZSBzdXNwZW5kIHJvdXRpbmVzIHRoZSBwb3dlciB1c2FnZSBpbmNyZWFzZXMgYXJvdW5k
IDEuNVcgYXMKYmVmb3JlLgoKSGF2ZSB5b3UgY29uZmlybWVkIHRoYXQgYW1kZ3B1IHMyaWRsZSBp
cyB3b3JraW5nIG9uIHBsYXRmb3JtcyB5b3UgaGF2ZSBpbiBoYW5kPwoKVGhhbmtzCkRhbmllbApf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
