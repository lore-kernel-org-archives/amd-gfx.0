From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH xf86-video-amdgpu 11/19] Don't leak a AMDGPUEntRec
 instance if amdgpu_device_setup fails
Date: Tue, 10 Apr 2018 10:28:12 +0200
Message-ID: <24ee9e07-9740-9a8e-3659-02c699db130c@daenzer.net>
References: <20180404142954.31360-1-emil.l.velikov@gmail.com>
 <20180404142954.31360-12-emil.l.velikov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180404142954.31360-12-emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wNC0wNCAwNDoyOSBQTSwgRW1pbCBWZWxpa292IHdyb3RlOgo+IEZyb206IEVtaWwg
VmVsaWtvdiA8ZW1pbC52ZWxpa292QGNvbGxhYm9yYS5jb20+Cj4gCj4gU2VlbXMgbGlrZSB3ZSd2
ZSBiZWVuIGxlYWtpbmcgdGhpcyBmb3IgeWVhcnMuIEl0IGJlY2FtZSBtb3JlIG9idmlvdXMKPiB3
aXRoIHRoZSByZWNlbnQgcmVmYWN0b3JpbmcuCj4gCj4gU2lnbmVkLW9mZi1ieTogRW1pbCBWZWxp
a292IDxlbWlsLnZlbGlrb3ZAY29sbGFib3JhLmNvbT4KPiAtLS0KPiAgc3JjL2FtZGdwdV9wcm9i
ZS5jIHwgMiArKwo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAt
LWdpdCBhL3NyYy9hbWRncHVfcHJvYmUuYyBiL3NyYy9hbWRncHVfcHJvYmUuYwo+IGluZGV4IDUz
N2Q0NGMuLjU4ODg5MWMgMTAwNjQ0Cj4gLS0tIGEvc3JjL2FtZGdwdV9wcm9iZS5jCj4gKysrIGIv
c3JjL2FtZGdwdV9wcm9iZS5jCj4gQEAgLTI0Myw2ICsyNDMsOCBAQCBhbWRncHVfcHJvYmUoU2Ny
bkluZm9QdHIgcFNjcm4sIGludCBlbnRpdHlfbnVtLAo+ICAJcmV0dXJuIFRSVUU7Cj4gIAo+ICBl
cnJvcjoKPiArCWZyZWUocFByaXYtPnB0cik7Cj4gKwlwUHJpdi0+cHRyID0gTlVMTDsKPiAgCXJl
dHVybiBGQUxTRTsKPiAgfQo+ICAKPiAKCnZhbGdyaW5kIGRvZXNuJ3QgcmVwb3J0IGEgbGVhayBp
ZiBJIGZvcmNlIHRoaXMgZXJyb3IgcGF0aDsgcHJlc3VtYWJseQpYb3JnIGZyZWVzIHRoZSBwcml2
YXRlIGFmdGVyIHJldHVybmluZyBGQUxTRSBoZXJlLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETD
pG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxp
YnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFu
ZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
