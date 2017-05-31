From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amdgpu: Remove two ! operations in an if condition
Date: Wed, 31 May 2017 12:09:22 +0900
Message-ID: <0d416da7-ebbf-f313-f505-250fe7d809c9@daenzer.net>
References: <1496180868-2617-1-git-send-email-AlexBin.Xie@amd.com>
 <1496180868-2617-2-git-send-email-AlexBin.Xie@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1496180868-2617-2-git-send-email-AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMzEvMDUvMTcgMDY6NDcgQU0sIEFsZXggWGllIHdyb3RlOgo+ICBNYWtlIHRoZSBjb2RlIGVh
c2llciB0byB1bmRlcnN0YW5kLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFsZXggWGllIDxBbGV4Qmlu
LlhpZUBhbWQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYyB8IDYgKysrKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBpbmRl
eCA3YTMyM2Y5Li45ZmRlYjgyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtLmMKPiBAQCAtNjgwLDkgKzY4MCwxMSBAQCBib29sIGFtZGdwdV92bV9uZWVkX3BpcGVsaW5l
X3N5bmMoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAo+ICAKPiAgCWlmIChhbWRncHVfdm1faGFk
X2dwdV9yZXNldChhZGV2LCBpZCkpCj4gIAkJcmV0dXJuIHRydWU7Cj4gLQlpZiAoIXZtX2ZsdXNo
X25lZWRlZCAmJiAhZ2RzX3N3aXRjaF9uZWVkZWQpCj4gKwo+ICsJaWYgKHZtX2ZsdXNoX25lZWRl
ZCB8fCBnZHNfc3dpdGNoX25lZWRlZCkKPiArCQlyZXR1cm4gdHJ1ZTsKPiArCWVsc2UKPiAgCQly
ZXR1cm4gZmFsc2U7CgpUaGlzIGNhbiBiZSBmdXJ0aGVyIHNpbXBsaWZpZWQgdG8KCglyZXR1cm4g
dm1fZmx1c2hfbmVlZGVkIHx8IGdkc19zd2l0Y2hfbmVlZGVkOwoKV2l0aCB0aGF0LAoKUmV2aWV3
ZWQtYnk6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgoKCi0tIApFYXJ0
aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDov
L3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAg
ICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
