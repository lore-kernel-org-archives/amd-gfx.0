From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 17/26] drm/amd/display: implement PERF_TRACE on Linux
Date: Sat, 13 Oct 2018 19:40:24 +0200
Message-ID: <d1083156-4246-1af2-1bb2-5bdb54455b99@gmail.com>
References: <20181010220922.3864-1-Bhawanpreet.Lakha@amd.com>
 <20181010220922.3864-19-Bhawanpreet.Lakha@amd.com>
 <116c2a95-a249-88c7-ad6a-1b688f03b2c9@daenzer.net>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <116c2a95-a249-88c7-ad6a-1b688f03b2c9-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
Cc: David Francis <David.Francis-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTIuMTAuMjAxOCB1bSAxODo1NiBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTgt
MTAtMTEgMTI6MDkgYS5tLiwgQmhhd2FucHJlZXQgTGFraGEgd3JvdGU6Cj4+IEZyb206IERhdmlk
IEZyYW5jaXMgPERhdmlkLkZyYW5jaXNAYW1kLmNvbT4KPj4KPj4gW1doeV0KPj4gQSBxdWljay1h
bmQtZGlydHkgd2F5IG9mIGdldHRpbmcgcGVyZm9ybWFuY2UgZGF0YSBmb3IgdGhlIGFtZGdwdQo+
PiBkcml2ZXIgd291bGQgbWFrZSBwZXJmb3JtYW5jZSBpbXByb3ZlbWVudHMgZWFzaWVyCj4+Cj4+
IFtIb3ddCj4+IFRoZSBQRVJGX1RSQUNFIGZ1bmN0aW9uYWxpdHkgaXMgYSB0aWMtdG9jIHN0eWxl
IGRlYnVnIG1ldGhvZC4KPj4gUHV0IFBFUkZfVFJBQ0UgY2FsbHMgb24gZWl0aGVyIHNpZGUgb2Yg
dGhlIGNvZGUgeW91IHdhbnQgdG8gdGVzdC4KPj4gUEVSRl9UUkFDRSByZXF1aXJlcyBhY2Nlc3Mg
dG8gc3RydWN0IGRjX2NvbnRleHQuICBQRVJGX1RSQUNFKCkKPj4gd2lsbCBwaWNrIHVwIHRoZSBD
VFggbWFjcm8sIGFuZCBQRVJGX1RSQUNFX0NUWChzdHJ1Y3QgZGNfY29udGV4dCkKPj4gYWxsb3dz
IHlvdSB0byBwYXNzIHRoZSBjb250ZXh0IGV4cGxpY2l0bHkuCj4+Cj4+IFRoZSBsYXN0IDIwIHJl
c3VsdHMgY2FuIGJlIHJlYWQgdGhyb3VnaCB0aGUgZGVidWdmcyBlbnRyeQo+PiBhbWRncHVfcGVy
Zl90cmFjZS4gIEVhY2ggcmVzdWx0IGNvbnRhaW5zIHRoZSB0aW1lIGluIG5zIGFuZAo+PiBudW1i
ZXIgb2YgR1BVIHJlYWQvd3JpdGVzIHNpbmNlIHRoZSByZXN1bHQgYmVmb3JlIGl0Lgo+Pgo+PiBJ
biBteSBleHBlcmltZW50YXRpb24sIGVhY2ggUEVSRl9UUkFDRSgpIGNhbGwgdXNlcyBhdCBtb3N0
IDcwMG5zCj4gU2hvdWxkIHRoaXMgdXNlIHRoZSBMaW51eCB0cmFjaW5nIGluZnJhc3RydWN0dXJl
PwoKWWVhaCwgYWdyZWUgdGhhdCBsb29rcyBsaWtlIHJlaW1wbGVtZW50aW5nIHRoZSB0cmFjaW5n
IGluZnJhc3RydWN0dXJlIHRvIAptZSBhcyB3ZWxsLgoKQ2hyaXN0aWFuLgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
