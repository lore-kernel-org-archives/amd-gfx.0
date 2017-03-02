From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/amdgpu: fix console deadlock if late init
 failed
Date: Thu, 2 Mar 2017 10:10:59 +0900
Message-ID: <a0533bb7-777b-6b46-b534-063b068f7606@daenzer.net>
References: <1488360939-5030-1-git-send-email-Jim.Qu@amd.com>
 <1488360939-5030-2-git-send-email-Jim.Qu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1488360939-5030-2-git-send-email-Jim.Qu-5C7GfCeVMHo@public.gmane.org>
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
To: Jim Qu <Jim.Qu-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDEvMDMvMTcgMDY6MzUgUE0sIEppbSBRdSB3cm90ZToKPiBDaGFuZ2UtSWQ6IElhOTE0ZmFj
MDgzZWJhYjM5NjE3ZGFkMDQ2ZDRiYjk4YWIxZGRmMGE4Cj4gU2lnbmVkLW9mZi1ieTogSmltIFF1
IDxKaW0uUXVAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jIHwgNSArKysrLQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYwo+IGluZGV4IGMwNjc5ZDMuLjZlZWRhMjQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gQEAgLTIxODYsOCArMjE4NiwxMSBAQCBpbnQg
YW1kZ3B1X2RldmljZV9yZXN1bWUoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgYm9vbCByZXN1bWUs
IGJvb2wgZmJjb24pCj4gIAl9Cj4gIAo+ICAJciA9IGFtZGdwdV9sYXRlX2luaXQoYWRldik7Cj4g
LQlpZiAocikKPiArCWlmIChyKSB7Cj4gKwkJaWYgKGZiY29uKQo+ICsJCQljb25zb2xlX3VubG9j
aygpOwo+ICAJCXJldHVybiByOwo+ICsJfQo+ICAKPiAgCS8qIHBpbiBjdXJzb3JzICovCj4gIAls
aXN0X2Zvcl9lYWNoX2VudHJ5KGNydGMsICZkZXYtPm1vZGVfY29uZmlnLmNydGNfbGlzdCwgaGVh
ZCkgewo+IAoKUmV2aWV3ZWQtYnk6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnplckBhbWQu
Y29tPgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAg
ICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAg
ICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
