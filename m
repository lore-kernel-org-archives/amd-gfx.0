From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH xf86-video-amdgpu 17/19] Store device_name as
 AMDGPUEntRec::master_node
Date: Tue, 10 Apr 2018 10:29:36 +0200
Message-ID: <995c2313-3603-e05b-fc19-93dec3ba9876@daenzer.net>
References: <20180404142954.31360-1-emil.l.velikov@gmail.com>
 <20180404142954.31360-18-emil.l.velikov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180404142954.31360-18-emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
VmVsaWtvdiA8ZW1pbC52ZWxpa292QGNvbGxhYm9yYS5jb20+Cj4gCj4gUmVuYW1lIHRoZSB2YXJp
YWJsZSB0byByZWZsZWN0IHdoYXQgaXQgaXMuIFBsdXMgbW92ZSBpdCBvdXQgb2YgdGhlIGRyaTIK
PiBzZWN0aW9uIC0gaXQncyB1c2VkIGluIGRyaTIgYW5kIGRyaTMuCj4gCj4gU2lnbmVkLW9mZi1i
eTogRW1pbCBWZWxpa292IDxlbWlsLnZlbGlrb3ZAY29sbGFib3JhLmNvbT4KClsuLi5dCgo+IGRp
ZmYgLS1naXQgYS9zcmMvYW1kZ3B1X3Byb2JlLmMgYi9zcmMvYW1kZ3B1X3Byb2JlLmMKPiBpbmRl
eCA0OTU5YmQ2Li5lOWFmZTQyIDEwMDY0NAo+IC0tLSBhL3NyYy9hbWRncHVfcHJvYmUuYwo+ICsr
KyBiL3NyYy9hbWRncHVfcHJvYmUuYwo+IEBAIC0xNzgsNiArMTc4LDEwIEBAIHN0YXRpYyBCb29s
IGFtZGdwdV9kZXZpY2Vfc2V0dXAoU2NybkluZm9QdHIgcFNjcm4sCj4gIAlpZiAocEFNREdQVUVu
dC0+ZmQgPCAwKQo+ICAJCXJldHVybiBGQUxTRTsKPiAgCj4gKwlwQU1ER1BVRW50LT5tYXN0ZXJf
bm9kZSA9IGRybUdldERldmljZU5hbWVGcm9tRmQyKHBBTURHUFVFbnQtPmZkKTsKPiArCWlmIChw
QU1ER1BVRW50LT5tYXN0ZXJfbm9kZSkKPiArCSAgICAgICBnb3RvIGVycm9yX2FtZGdwdTsKClRo
aXMgc2hvdWxkIGJlCgoJaWYgKCFwQU1ER1BVRW50LT5tYXN0ZXJfbm9kZSkKCnNob3VsZG4ndCBp
dD8KCgouLi4gV2hpY2ggcmFpc2VzIHRoZSBxdWVzdGlvbjogSG93IGRpZCB5b3UgdGVzdCB0aGVz
ZSBwYXRjaGVzPyA6KQoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAg
ICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1
c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
