From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm 3/3] amdgpu: rework and remove amdgpu_get_auth()
Date: Tue, 7 Mar 2017 00:47:45 +0000
Message-ID: <CACvgo51YfAodRHuqk+shKysqqvoOTOoN5WZG5Nxu0fPxc102sQ@mail.gmail.com>
References: <20170122184813.12995-1-emil.l.velikov@gmail.com>
 <20170122184813.12995-3-emil.l.velikov@gmail.com>
 <CACvgo50BMP2qZsFzJK7Jmc-sAJkz7NVGKz0XjxZP3dMGs7_wtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CACvgo50BMP2qZsFzJK7Jmc-sAJkz7NVGKz0XjxZP3dMGs7_wtg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: ML dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gNyBNYXJjaCAyMDE3IGF0IDAwOjQ1LCBFbWlsIFZlbGlrb3YgPGVtaWwubC52ZWxpa292QGdt
YWlsLmNvbT4gd3JvdGU6Cgo+IEkgaGF2ZSBhbm90aGVyIH4yMCBwYXRjaCBzZXJpZXMgdGhhdCBi
dWlsZHMgb24gdG9wIDstKQo+CkNvcnJlY3Rpb24gLSB0aG9zZSBhcmUgeGY4Ni12aWRlby1hbWRn
cHUgb25lcyBpbmRlcGVuZGVudCBvZiB0aGlzIHNlcmllcy4KClBhcmRvbiBmb3IgdGhlIG5vaXNl
LgpFbWlsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
