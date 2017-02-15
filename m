From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Fix 64-bit division, yet again
Date: Wed, 15 Feb 2017 11:44:19 +0000
Message-ID: <CACvgo50e-sETxPcsHsn6HZu2_oaD2aSE9pFXcJK9wEH5eKS1MA@mail.gmail.com>
References: <20170214203648.24212-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170214203648.24212-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMTQgRmVicnVhcnkgMjAxNyBhdCAyMDozNiwgSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRs
YW5kQGFtZC5jb20+IHdyb3RlOgo+IEFsc28gbWFrZSB0aGUgY29kZSBzb21ld2hhdCBtb3JlIHJl
YWRhYmxlLgo+CkknZCBzdWdnZXN0IHJlYWNoaW5nIHRvIHRoZSB0ZWFtIHRvIGludGVncmF0ZSBz
Y3JpcHRzL2NoZWNrcGF0Y2gucGwgaW4KdGhlIHByZS1jb21taXQgaG9vay4KCkl0IHdpbGwgaGVs
cCB5b3UgaW1wcm92ZSB0aGUgY29kaW5nIHN0YW5kYXJkIGFuZCwgYXMgeW91IG1lbnRpb25lZCwg
aXQKIm1ha2Vbc10gdGhlIGNvZGUgc29tZXdoYXQgbW9yZSByZWFkYWJsZSIuCgotRW1pbApfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
