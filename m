From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: use irq-safe lock for kiq->ring_lock
Date: Tue, 7 Nov 2017 14:09:52 +0200
Message-ID: <CANOLnOOJgKA-oLhj3raL17Rpbsq=VKY7cfVx5DFqvr+_K_UjbQ@mail.gmail.com>
References: <1510039608-15811-1-git-send-email-Pixel.Ding@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1510039608-15811-1-git-send-email-Pixel.Ding-5C7GfCeVMHo@public.gmane.org>
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
To: Pixel Ding <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gVHVlLCBOb3YgNywgMjAxNyBhdCA5OjI2IEFNLCBQaXhlbCBEaW5nIDxQaXhlbC5EaW5nQGFt
ZC5jb20+IHdyb3RlOgo+IEZyb206IHBkaW5nIDxQaXhlbC5EaW5nQGFtZC5jb20+Cj4KPiAuLi4K
Pgo+IFNpZ25lZC1vZmYtYnk6IHBkaW5nIDxQaXhlbC5EaW5nQGFtZC5jb20+CgpZb3UgbmVlZCB0
byBmaXggeW91ciBnaXQgY29uZmlnIHVzZXIubmFtZS4KCgpHcmHFvnZ5ZGFzCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
