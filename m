From: Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [v3 PATCH 3/3] drm/amd/display: Switch to using atomic_helper for
 flip.
Date: Wed, 01 Feb 2017 12:00:45 +0100
Message-ID: <e1d5d0fc-455c-ac05-79a8-52e5397ea5fb@samsung.com>
References: <1485656811-4211-1-git-send-email-Andrey.Grodzovsky@amd.com>
 <CGME20170129022819epcas1p4cea98f25e385a1a98c063770283c4a2e@epcas1p4.samsung.com>
 <1485656811-4211-4-git-send-email-Andrey.Grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-reply-to: <1485656811-4211-4-git-send-email-Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
To: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dc_upstream-5C7GfCeVMHo@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

SGkgQW5kcmV5LAoKCk9uIDI5LjAxLjIwMTcgMDM6MjYsIEFuZHJleSBHcm9kem92c2t5IHdyb3Rl
Ogo+IFN3aWN0aCB0byB1c2UgYXRvbWljIGhlbHBlci4KPiBTdGFydCB1c2luZyBhY3R1YWwgdXNl
cidzIGdpdmVuIHRhcmdldF92YmxhbmsgdmFsdWUgZm9yIGZsaXAgCj4gaW5zdGVhZCBvZiBjdXJy
ZW50IHZhbHVlLgo+Cj4gdjM6Cj4gVXBkYXRlIGZvciBtb3ZpZyBwZmxpcCBmbGFncyB0byBjcnRj
X3N0YXRlCj4KPiBDaGFuZ2UtSWQ6IEkyNWRhZTZkOGMyOWRlNWQwMjJhNDJhYTk5YTE4YTMyNjc0
YjU2Y2RhCj4KR2Vycml0ICByZWxpYyA6KQoKUmVnYXJkcwpBbmRyemVqCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
