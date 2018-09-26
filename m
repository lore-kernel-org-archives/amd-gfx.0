From: James Zhu <jamesz-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/8] drm/amdgpu:Add DPG support flag
Date: Wed, 26 Sep 2018 08:55:22 -0400
Message-ID: <9884e115-22ed-eea3-12f3-daac18ca0971@amd.com>
References: <1537905323-27071-1-git-send-email-James.Zhu@amd.com>
 <1537905323-27071-3-git-send-email-James.Zhu@amd.com>
 <44a25354-4329-c942-8f86-0528a0b2ce84@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <44a25354-4329-c942-8f86-0528a0b2ce84-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, James Zhu <jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: james.zhu-5C7GfCeVMHo@public.gmane.org

CgpPbiAyMDE4LTA5LTI2IDA0OjAyIEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDI1
LjA5LjIwMTggdW0gMjE6NTUgc2NocmllYiBKYW1lcyBaaHU6Cj4+IEFkZCBEUEcgc3VwcG9ydCBm
bGFnIGZvciBWQ04gRFBHIG1vZGUuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEphbWVzIFpodSA8SmFt
ZXMuWmh1QGFtZC5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUv
YW1kX3NoYXJlZC5oIHwgMiArKwo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
Cj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYW1kX3NoYXJl
ZC5oIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hbWRfc2hhcmVkLmgKPj4gaW5k
ZXggODZiMTY3ZS4uMmY2YmRmMSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9p
bmNsdWRlL2FtZF9zaGFyZWQuaAo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUv
YW1kX3NoYXJlZC5oCj4+IEBAIC0xMTAsNiArMTEwLDggQEAgZW51bSBhbWRfcG93ZXJnYXRpbmdf
c3RhdGUgewo+PiDCoCAjZGVmaW5lIEFNRF9QR19TVVBQT1JUX01NSFVCwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAoMSA8PCAxMykKPj4gwqAgI2RlZmluZSBBTURfUEdfU1VQUE9SVF9WQ07CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICgxIDw8IDE0KQo+Cj4gTG9va3MgbGlrZSB5b3UgYWRkZWQgYW4gZXh0
cmEgZW1wdHkgbGluZSBiZXR3ZWVuIEFNRF9QR19TVVBQT1JUX1ZDTiAKPiBhbmQgdGhlIG5ldyBl
bnRyeSwgd2FzIHRoYXQgaW50ZW50aW9uYWw/CkFscmVhZHkgZml4ZWQgd2l0aCBBbGV4J3MgY29t
bWVudHMuCkphbWVzCj4KPiBBcGFydCBmcm9tIHRoYXQgdGhlIHBhdGNoZXMgbG9vayBnb29kIHRv
IG1lLCBidXQgY2FuJ3QganVkZ2UgaWYgdGhhdCAKPiBpcyByZWFsbHkgY29ycmVjdC4KPgo+IEFj
a2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+IGZvciB0
aGUgc2VyaWVzLgo+Cj4gUmVnYXJkcywKPiBDaHJpc3RpYW4uCj4KPj4gKyNkZWZpbmUgQU1EX1BH
X1NVUFBPUlRfRFBHwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoMSA8PCAxNSkKPj4gKwo+PiDCoCBl
bnVtIFBQX0ZFQVRVUkVfTUFTSyB7Cj4+IMKgwqDCoMKgwqAgUFBfU0NMS19EUE1fTUFTSyA9IDB4
MSwKPj4gwqDCoMKgwqDCoCBQUF9NQ0xLX0RQTV9NQVNLID0gMHgyLAo+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
