From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 17/26] drm/amd/display: implement PERF_TRACE on Linux
Date: Fri, 12 Oct 2018 18:56:10 +0200
Message-ID: <116c2a95-a249-88c7-ad6a-1b688f03b2c9@daenzer.net>
References: <20181010220922.3864-1-Bhawanpreet.Lakha@amd.com>
 <20181010220922.3864-19-Bhawanpreet.Lakha@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181010220922.3864-19-Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
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
To: Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
Cc: David Francis <David.Francis-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0xMC0xMSAxMjowOSBhLm0uLCBCaGF3YW5wcmVldCBMYWtoYSB3cm90ZToKPiBGcm9t
OiBEYXZpZCBGcmFuY2lzIDxEYXZpZC5GcmFuY2lzQGFtZC5jb20+Cj4gCj4gW1doeV0KPiBBIHF1
aWNrLWFuZC1kaXJ0eSB3YXkgb2YgZ2V0dGluZyBwZXJmb3JtYW5jZSBkYXRhIGZvciB0aGUgYW1k
Z3B1Cj4gZHJpdmVyIHdvdWxkIG1ha2UgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnRzIGVhc2llcgo+
IAo+IFtIb3ddCj4gVGhlIFBFUkZfVFJBQ0UgZnVuY3Rpb25hbGl0eSBpcyBhIHRpYy10b2Mgc3R5
bGUgZGVidWcgbWV0aG9kLgo+IFB1dCBQRVJGX1RSQUNFIGNhbGxzIG9uIGVpdGhlciBzaWRlIG9m
IHRoZSBjb2RlIHlvdSB3YW50IHRvIHRlc3QuCj4gUEVSRl9UUkFDRSByZXF1aXJlcyBhY2Nlc3Mg
dG8gc3RydWN0IGRjX2NvbnRleHQuICBQRVJGX1RSQUNFKCkKPiB3aWxsIHBpY2sgdXAgdGhlIENU
WCBtYWNybywgYW5kIFBFUkZfVFJBQ0VfQ1RYKHN0cnVjdCBkY19jb250ZXh0KQo+IGFsbG93cyB5
b3UgdG8gcGFzcyB0aGUgY29udGV4dCBleHBsaWNpdGx5Lgo+IAo+IFRoZSBsYXN0IDIwIHJlc3Vs
dHMgY2FuIGJlIHJlYWQgdGhyb3VnaCB0aGUgZGVidWdmcyBlbnRyeQo+IGFtZGdwdV9wZXJmX3Ry
YWNlLiAgRWFjaCByZXN1bHQgY29udGFpbnMgdGhlIHRpbWUgaW4gbnMgYW5kCj4gbnVtYmVyIG9m
IEdQVSByZWFkL3dyaXRlcyBzaW5jZSB0aGUgcmVzdWx0IGJlZm9yZSBpdC4KPiAKPiBJbiBteSBl
eHBlcmltZW50YXRpb24sIGVhY2ggUEVSRl9UUkFDRSgpIGNhbGwgdXNlcyBhdCBtb3N0IDcwMG5z
CgpTaG91bGQgdGhpcyB1c2UgdGhlIExpbnV4IHRyYWNpbmcgaW5mcmFzdHJ1Y3R1cmU/CgoKLS0g
CkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBo
dHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8
ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
