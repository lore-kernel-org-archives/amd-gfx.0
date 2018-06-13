From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] Update function level documentation for GPUVM v2
Date: Wed, 13 Jun 2018 16:01:17 +0200
Message-ID: <03738b7c-9b0d-bcfb-5781-354f4ff3e983@gmail.com>
References: <1528812303-4720-1-git-send-email-andrey.grodzovsky@amd.com>
 <4f64a37b-433a-1c08-10e3-cd2b6c9ed560@daenzer.net>
 <66dc2027-8ea2-4118-e493-7ed2e6f98997@amd.com>
 <1d8844bf-472a-663b-2247-7c22dd31c114@daenzer.net>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1d8844bf-472a-663b-2247-7c22dd31c114-otUistvHUpPR7s880joybQ@public.gmane.org>
Content-Language: en-US
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTMuMDYuMjAxOCB1bSAxNTo1NyBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTgt
MDYtMTMgMDM6NTIgUE0sIEFuZHJleSBHcm9kem92c2t5IHdyb3RlOgo+PiBZZWEsIHdpbGwgdGFr
ZSBjYXJlIG9mIHRoaXMsIHRoaXMgcGFydGljdWxhciB3YXJuaW5nIGlzIGFsbCBvdmVyIHRoZQo+
PiBwbGFjZSB3aGVuIHlvdSBjb21waWxlIHNvIEkgZGlkbid0IG5vdGljZSBteSBvd24gYW1vbmcg
b3RoZXJzLgo+IFRvIGF2b2lkIHRoYXQgcHJvYmxlbSwgSSByZWNvbW1lbmQgZ2VuZXJhdGluZyBk
b2N1bWVudGF0aW9uIGZpcnN0Cj4gd2l0aG91dCBvbmUncyBwYXRjaGVzIGFwcGxpZWQsIHRoZW4g
KHdpdGhvdXQgY2xlYW5pbmcgdGhlIGdlbmVyYXRlZAo+IGRvY3VtZW50YXRpb24gZmlyc3QpIGFn
YWluIHdpdGggdGhlbSBhcHBsaWVkLiBUaGUgc2Vjb25kIHJ1biBzaG91bGQgb25seQo+IHJlLWdl
bmVyYXRlIHRoaW5ncyBhZmZlY3RlZCBieSBvbmUncyBwYXRjaGVzLCBzbyBpdCBzaG91bGQgYmUg
ZWFzeSB0bwo+IHNwb3QgYW55IHdhcm5pbmdzIHJlbGF0ZWQgdG8gdGhlbS4KCllvdSBjYW4gYWxz
byBqdXN0IGlzc3VlIGFuICJ0b3VjaCAkZmlsZSIgY29tbWFuZCB0byBmb3JjZSBvbmx5IApyZWdl
bmVyYXRpb24gdGhlIGZpbGUgeW91J3JlIGludGVyZXN0ZWQgaW4uCgpDaHJpc3RpYW4uCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
