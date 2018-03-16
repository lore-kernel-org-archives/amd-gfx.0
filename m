From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 6/6] drm/amd/pp: Remove unneeded void * casts for Vega10
Date: Fri, 16 Mar 2018 15:30:55 -0400
Message-ID: <CADnq5_OYr_GAGhv3hLBvFwtwbZcOw23avO5+au75r8-pZ6cBWA@mail.gmail.com>
References: <1521193173-529-1-git-send-email-Rex.Zhu@amd.com>
 <1521193173-529-7-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1521193173-529-7-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gRnJpLCBNYXIgMTYsIDIwMTggYXQgNTozOSBBTSwgUmV4IFpodSA8UmV4LlpodUBhbWQuY29t
PiB3cm90ZToKPiBSZW1vdmVzIHVubmVlZGVkIHZvaWQgKiBjYXN0cyBmb3IgdGhlIGZvbGxvd2lu
ZyBwb2ludGVyczoKPiBod21nci0+YmFja2VuZAo+IGh3bWdyLT5zbXVfYmFja2VuZAo+Cj4gQ2hh
bmdlLUlkOiBJOTg4N2QzOWMyN2RhZGY5NTNhYjMyZTdlY2Q3ZTViOTBjNzNmOWE1Zgo+IFNpZ25l
ZC1vZmYtYnk6IFJleCBaaHUgPFJleC5aaHVAYW1kLmNvbT4KCldpdGggRXZhbidzIGNvbW1lbnQg
b24gcGF0Y2ggNSBhZGRyZXNzZWQsIHRoZSBzZXJpZXMgaXM6ClJldmlld2VkLWJ5OiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
