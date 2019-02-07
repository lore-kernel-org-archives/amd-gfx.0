From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: kernel BUG at drivers/gpu/drm//ttm/ttm_bo.c:196!
Date: Thu, 7 Feb 2019 12:30:46 +0100
Message-ID: <1ebb64af-bdc1-8a39-d63d-f5c127808407@daenzer.net>
References: <b1448d56-5dc4-d3f4-db04-e7993533240b@daenzer.net>
 <95cef707-4d19-cbd4-c913-523f4b22c89a@gmail.com>
 <b5a55494-356d-31a3-fe5a-491d337f6a66@daenzer.net>
 <f4543d33-233d-b242-d3cf-f087a5dcd755@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f4543d33-233d-b242-d3cf-f087a5dcd755-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOS0wMi0wNyAxMDo1OCBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDA1
LjAyLjE5IHVtIDE4OjQwIHNjaHJpZWIgTWljaGVsIETDpG56ZXI6Cj4+IE9uIDIwMTktMDItMDUg
NDo0NSBwLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4gUG9zc2libGUsIGJ1dCB1bmxp
a2VseS4KPj4+Cj4+PiBUaGF0IHNvdW5kcyBtb3JlIGxpa2UgYSByZWZlcmVuY2UgY291bnRpbmcg
cHJvYmxlbSB3aGVyZSBzb21ldGhpbmcgaXMKPj4+IGtpbGxpbmcgdGhlIEJPIHdoaWxlIGl0IGlz
IHN0aWxsIG9uIHRoZSBMUlUuCj4+IEZXSVcsIEkndmUgaGl0IHRoaXMgdHdpY2Ugbm93IHRvZGF5
LCB3aGVyZWFzIEkgZG9uJ3QgcmVtZW1iZXIgZXZlcgo+PiBoaXR0aW5nIGl0IGJlZm9yZSAobm90
IDEwMCUgc3VyZSB0aG91Z2gpLgo+Pgo+PiBJIHJldmVydGVkIHRoZSByZW1haW5pbmcgaHVuayBv
ZiB0aGUgImNsZWFudXAgc2V0dGluZyBidWxrX21vdmFibGUiCj4+IGNoYW5nZSwgYW5kIGl0IHN1
cnZpdmVkIGEgcGlnbGl0IHJ1bi4gQ291bGQganVzdCBiZSBsdWNrLCB0aG91Z2guLi4KPiAKPiBE
aWQgeW91IGhhdmUgS0FTQU4gZW5hYmxlZD8KClllcywgS0FTQU4gaXMgZW5hYmxlZCBpbiBteSBh
bWQtc3RhZ2luZy1kcm0tbmV4dCBidWlsZHMgKGFzIGNhbiBiZSBzZWVuCmluIHRoZSBkbWVzZyBl
eGNlcnB0KS4KCkZXSVcsIH43MCBtcyBiZWZvcmUgdGhpcyBoYXBwZW5lZCwgdGhlIE9PTSBraWxs
ZXIgd2FzIHRyaWdnZXJlZCBmcm9tIGEKcGFnZSBmYXVsdC4gTWF5YmUgdGhhdCdzIHJlbGF0ZWQ/
CgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAg
ICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAg
ICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
