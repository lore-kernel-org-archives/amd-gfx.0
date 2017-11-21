From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: move UVD/VCE and VCN structure out from union
Date: Tue, 21 Nov 2017 18:17:04 +0100
Message-ID: <8e1d3d87-c2f6-9892-4646-810ce9e9acfa@daenzer.net>
References: <20171121142804.4047-1-leo.liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171121142804.4047-1-leo.liu-5C7GfCeVMHo@public.gmane.org>
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
To: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxNy0xMS0yMSAwMzoyOCBQTSwgTGVvIExpdSB3cm90ZToKPiBXaXRoIHRoZSBlbmFibGVt
ZW50IG9mIFZDTiBEZWMgYW5kIEVuYyBmcm9tIHVzZXIgc3BhY2UsIFVzZXIgc3BhY2UgcXVlcmll
cwo+IGtlcm5lbCBmb3IgdGhlIElQIGluZm9ybWF0aW9uLCBpZiBIVyBoYXMgVVZEL1ZDRSwgdGhl
IGluZm8gY29tZXMgZnJvbSB0aGVzZQo+IElQIGJsb2NrcywgYnV0IHRoaXMgY291bGQgZW5kIHVw
IG1pcy1pbnRlcnByZXQgZm9yIFZDTiB3aGVuIHRoZXkgYXJlIGluIHRoZQo+IHVuaW9uLCB0aGVy
IG90aGVyIHdheSBzYW1lIHdoZW4gSFcgd2l0aCBWQ04gYmxvY2suCj4gCj4gU2lnbmVkLW9mZi1i
eTogTGVvIExpdSA8bGVvLmxpdUBhbWQuY29tPgoKUGxlYXNlIGFkZDoKCkZpeGVzOiA5NWQwOTA2
Zjg1MDYgKCJkcm0vYW1kZ3B1OiBhZGQgaW5pdGlhbCB2Y24gc3VwcG9ydCBhbmQgZGVjb2RlCiAg
ICAgICAgICAgICAgICAgICAgICB0ZXN0cyIpCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnClJl
dmlld2VkLWFuZC1UZXN0ZWQtYnk6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnplckBhbWQu
Y29tPgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAg
ICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAg
ICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
