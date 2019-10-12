From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 08/19] drm/amdgpu: rename amdgpu_device_is_px to
 amdgpu_device_supports_boco
Date: Sat, 12 Oct 2019 13:51:55 +0200
Message-ID: <20191012115155.4tngjbwxgbehzjdr@wunner.de>
References: <20191011014536.10869-1-alexander.deucher@amd.com>
 <20191011014536.10869-9-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20191011014536.10869-9-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: tiwai-l3A5Bk7waGM@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gVGh1LCBPY3QgMTAsIDIwMTkgYXQgMDg6NDU6MjVQTSAtMDUwMCwgQWxleCBEZXVjaGVyIHdy
b3RlOgo+IFRvIGJldHRlciBtYXRjaCB3aGF0IHdlIGFyZSBjaGVja2luZyBmb3IgYW5kIHRvIGFs
aWduIHdpdGgKPiBhbWRncHVfZGV2aWNlX3N1cHBvcnRzX2JhY28uCj4gCj4gQkFDTyAtIEJ1cyBB
Y3RpdmUsIENoaXAgT2ZmCj4gQk9DTyAtIEJ1cyBPZmYsIENoaXAgT2ZmCgpJdCB3b3VsZCBiZSB1
c2VmdWwgdG8gc3BlbGwgb3V0IEJBQ08gaW4gdGhlIHByZWNlZGluZyBwYXRjaGVzIGFzIHdlbGwu
CgoKPiAtICogYW1kZ3B1X2RldmljZV9pc19weCAtIElzIHRoZSBkZXZpY2UgaXMgYSBkR1BVIHdp
dGggSEcvUFggcG93ZXIgY29udHJvbAo+ICsgKiBhbWRncHVfZGV2aWNlX3N1cHBvcnRzX2JvY28g
LSBJcyB0aGUgZGV2aWNlIGlzIGEgZEdQVSB3aXRoIEhHL1BYIHBvd2VyIGNvbnRyb2wKCkR1cGxp
Y2F0ZSB2ZXJiLgoKTXkgcGVyc29uYWwgc3R5bGUgdG8gZG9jdW1lbnQgYm9vbGVhbiByZXR1cm4g
dmFsdWVzIGlzICJ3aGV0aGVyIC4uLiIsCmkuZS4gIndoZXRoZXIgZGV2aWNlIGlzIGEgZEdQVSB3
aXRoIEhHL1BYIHBvd2VyIGNvbnRyb2wiLgpCdXQgdGhhdCdzIGp1c3QgbWUuCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
