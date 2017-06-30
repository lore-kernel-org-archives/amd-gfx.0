From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Make KIQ read/write register routine be atomic
Date: Fri, 30 Jun 2017 10:21:22 +0900
Message-ID: <14d97048-a0ba-69cd-1eac-e82c4462c51f@daenzer.net>
References: <1498770496-28032-1-git-send-email-Shaoyun.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1498770496-28032-1-git-send-email-Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
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
To: Shaoyun Liu <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMzAvMDYvMTcgMDY6MDggQU0sIFNoYW95dW4gTGl1IHdyb3RlOgo+IDEuIFVzZSBzcGluIGxv
Y2sgaW5zdGVhZCBvZiBtdXRleCBpbiBLSVEKPiAyLiBEaXJlY3RseSB3cml0ZSB0byBLSVEgZmVu
Y2UgYWRkcmVzcyBpbnN0ZWFkIG9mIHVzaW5nIGZlbmNlX2VtaXQoKQo+IDMuIERpc2FibGUgdGhl
IGludGVycnVwdCBmb3IgS0lRIHJlYWQvd3JpdGUgYW5kIHVzZSBDUFUgcG9sbGluZwoKVGhpcyBs
aXN0IGluZGljYXRlcyB0aGF0IHRoaXMgcGF0Y2ggc2hvdWxkIGJlIHNwbGl0IHVwIGluIGF0IGxl
YXN0IHRocmVlCnBhdGNoZXMuIDopCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAg
ICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdh
cmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxv
cGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
