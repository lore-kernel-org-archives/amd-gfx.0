From: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/6] drm: fourcc byteorder: add bigendian support to
 drm_mode_legacy_fb_format
Date: Wed, 26 Apr 2017 14:11:11 +0200
Message-ID: <1493208671.23739.19.camel@redhat.com>
References: <20170424062532.26722-1-kraxel@redhat.com>
 <20170424062532.26722-4-kraxel@redhat.com>
 <3b872a56-80b5-0c44-712f-a9517489eb24@daenzer.net>
 <1493185990.23739.7.camel@redhat.com>
 <8f91cc58-16dc-5899-66b6-06d430a18801@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <8f91cc58-16dc-5899-66b6-06d430a18801-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

ICBIaSwKCj4gPj4gSnVzdCB0byByZWl0ZXJhdGUsIHRoaXMgd29uJ3Qgd29yayBmb3IgdGhlIHJh
ZGVvbiBkcml2ZXIsIHdoaWNoIHByb2dyYW1zCj4gPj4gdGhlIEdQVSB0byB1c2UgKGVmZmVjdGl2
ZWx5LCBwZXIgdGhlIGN1cnJlbnQgZGVmaW5pdGlvbiB0aGF0IHRoZXNlIGFyZQo+ID4+IGxpdHRs
ZSBlbmRpYW4gR1BVIGZvcm1hdHMpIERSTV9GT1JNQVRfWFJHQjg4ODggd2l0aCBwcmUtUjYwMCBh
bmQKPiA+PiBEUk1fRk9STUFUX0JHUlg4ODg4IHdpdGggPj0gUjYwMC4KPiA+IAo+ID4gSG1tLCBv
aywgaG93IGRvZXMgYmlnZW5kaWFuIGZiZGV2IGVtdWxhdGlvbiB3b3JrIG9uIHByZS1SNjAwIHRo
ZW4/Cj4gCj4gVXNpbmcgYSBHUFUgYnl0ZSBzd2FwcGluZyBtZWNoYW5pc20gd2hpY2ggb25seSBh
ZmZlY3RzIENQVSBhY2Nlc3MgdG8KPiB2aWRlbyBSQU0uCgpUaGF0IGlzIGRvbmUgdXNpbmcgdGhl
IFJBREVPTl9USUxJTkdfU1dBUF97MTYsMzJ9QklUIGZsYWcgbWVudGlvbmVkIGluCmFub3RoZXIg
dGhyZWFkPwoKT2ssIHNvIHRoZSBjcHUgdmlldyB0byBmYmRldiBpcyBEUk1fRk9STUFUX0JHUlg4
ODg4IGluIGFsbCBjYXNlcy4KCldoYXQgYWJvdXQgZHVtYiBib3M/ICBZb3UndmUgbWVudGlvbmVk
IHRoZSBzd2FwIGZsYWcgaXNuJ3QgdXNlZCBmb3IKdGhvc2UuICBXaGljaCBpbXBsaWVzIHRoZXkg
YXJlIGluIGxpdHRsZSBlbmRpYW4gYnl0ZSBvcmRlciAoYm90aCBncHUgYW5kCmNwdSB2aWV3KS4g
IERvZXMgdGhlIG1vZGVzZXR0aW5nIGRyaXZlciB3b3JrIGNvcnJlY3RseSBvbiB0aGF0IGhhcmR3
YXJlPwoKY2hlZXJzLAogIEdlcmQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
