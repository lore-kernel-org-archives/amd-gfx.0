From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] Revert "drm/amdgpu/display: Replace
 CONFIG_DRM_AMD_DC_DCN1_0 with CONFIG_X86"
Date: Thu, 16 Aug 2018 17:29:01 -0400
Message-ID: <CADnq5_P1RkU+-soWsCB1NE=15TZn4pLZTLpjdWeu16ZVjF9wxg@mail.gmail.com>
References: <1534448679-13823-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1534448679-13823-1-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
To: "Leo (Sunpeng) Li" <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Jordan Lazare <Jordan.Lazare-5C7GfCeVMHo@public.gmane.org>, "Daenzer,
 Michel" <michel.daenzer-5C7GfCeVMHo@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <harry.wentland-5C7GfCeVMHo@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gVGh1LCBBdWcgMTYsIDIwMTggYXQgMzo0NSBQTSA8c3VucGVuZy5saUBhbWQuY29tPiB3cm90
ZToKPgo+IEZyb206ICJMZW8gKFN1bnBlbmcpIExpIiA8c3VucGVuZy5saUBhbWQuY29tPgo+Cj4g
VGhpcyByZXZlcnRzIGNvbW1pdCA4NjI0YzNjNGRiZmUyNGZjNjc0MDY4NzIzNmEyZTE5NmY1ZjRi
ZmIwLgo+Cj4gV2UgbmVlZCBDT05GSUdfRFJNX0FNRF9EQ19EQ04xXzAgdG8gZ3VhcmQgY29kZSB0
aGF0IGlzIHVzaW5nIGZwIG1hdGguCgpNSXNzaW5nIHlvdXIgU09CLiAgV0l0aCB0aGF0IGZpeGVk
LCBzZXJpZXMgaXM6CkFja2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
