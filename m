From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: skip ring soft reset on SR-IOV VF
Date: Wed, 14 Nov 2018 11:24:05 +0100
Message-ID: <af3c6113-4f06-2323-dace-2cee260bd9de@gmail.com>
References: <1542183804-3021-1-git-send-email-Trigger.Huang@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1542183804-3021-1-git-send-email-Trigger.Huang-5C7GfCeVMHo@public.gmane.org>
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
To: Trigger Huang <Trigger.Huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTQuMTEuMTggdW0gMDk6MjMgc2NocmllYiBUcmlnZ2VyIEh1YW5nOgo+IFdoZW4gVERSIGhh
cHBlbmVkIG9uIFNSLUlPViBWRiwgdGhlIGhvc3QgSHlwZXJ2aXNvciBtYXkgaGFzIGFscmVhZHkK
PiBkb25lIHRoZSBWRiBGTFIsIHRoZW4sIHRoZSByZS1pbml0aWFsaXphdGlvbiBmbG93IGluIEtN
RCBpcyBhIG11c3QuCj4gVGhlIHNhbWUgbG9naWMgaXMgaW4gYW1kZ3B1X2RldmljZV9pcF9jaGVj
a19zb2Z0X3Jlc2V0LCB0b28KCk5BSywgdGhpcyBpcyBvbmx5IGNhbGxlZCBpbiB0aGUgdGltZW91
dCBjb2RlIHBhdGggYW5kIG5vdCB3aGVuIHRoZSAKSHlwZXJ2aXNvciBzaWduYWxzIGEgRkxSLgoK
Q2hyaXN0aWFuLgoKPgo+IFNpZ25lZC1vZmYtYnk6IFRyaWdnZXIgSHVhbmcgPFRyaWdnZXIuSHVh
bmdAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
aW5nLmMgfCAzICsrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jCj4gaW5kZXggNWI3NWJkYy4uMTRi
ZDY3YSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmlu
Zy5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYwo+IEBA
IC0zOTcsNiArMzk3LDkgQEAgYm9vbCBhbWRncHVfcmluZ19zb2Z0X3JlY292ZXJ5KHN0cnVjdCBh
bWRncHVfcmluZyAqcmluZywgdW5zaWduZWQgaW50IHZtaWQsCj4gICB7Cj4gICAJa3RpbWVfdCBk
ZWFkbGluZSA9IGt0aW1lX2FkZF91cyhrdGltZV9nZXQoKSwgMTAwMDApOwo+ICAgCj4gKwlpZiAo
YW1kZ3B1X3NyaW92X3ZmKHJpbmctPmFkZXYpKQo+ICsJCXJldHVybiBmYWxzZTsKPiArCj4gICAJ
aWYgKCFyaW5nLT5mdW5jcy0+c29mdF9yZWNvdmVyeSkKPiAgIAkJcmV0dXJuIGZhbHNlOwo+ICAg
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
