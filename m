From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add error return value for finding bo by
 cpu mapping
Date: Thu, 30 Aug 2018 10:54:33 +0200
Message-ID: <1773db3d-3e3a-de52-9f51-46b74027ac86@amd.com>
References: <1535619003-18067-1-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1535619003-18067-1-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
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
To: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMzAuMDguMjAxOCB1bSAxMDo1MCBzY2hyaWViIEp1bndlaSBaaGFuZzoKPiBJZiBub3RoaW5n
IGlzIGZvdW5kLCBlcnJvciBzaG91bGQgYmUgcmV0dXJuZWQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBK
dW53ZWkgWmhhbmcgPEplcnJ5LlpoYW5nQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGFtZGdwdS9hbWRn
cHVfYm8uYyB8IDQgKysrLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2FtZGdwdS9hbWRncHVfYm8uYyBiL2FtZGdwdS9h
bWRncHVfYm8uYwo+IGluZGV4IDJmNGY5MGYuLjM4MTJjNWUgMTAwNjQ0Cj4gLS0tIGEvYW1kZ3B1
L2FtZGdwdV9iby5jCj4gKysrIGIvYW1kZ3B1L2FtZGdwdV9iby5jCj4gQEAgLTU1MCw2ICs1NTAs
NyBAQCBpbnQgYW1kZ3B1X2ZpbmRfYm9fYnlfY3B1X21hcHBpbmcoYW1kZ3B1X2RldmljZV9oYW5k
bGUgZGV2LAo+ICAgCQkJCSAgdWludDY0X3QgKm9mZnNldF9pbl9ibykKPiAgIHsKPiAgIAl1aW50
MzJfdCBpOwo+ICsJaW50IHIgPSAwOwo+ICAgCXN0cnVjdCBhbWRncHVfYm8gKmJvOwoKQlRXOiBL
ZXJuZWwgY29kaW5nIHN0eWxlIHVzdWFsbHkgdXNlcyByZXZlcnNlIHhtYXMgdHJlZSBmb3IgdmFy
aWFibGVzLgoKRS5nLiBsb25nZXN0IGxpbmUgZmlyc3QgYW5kIHZhcmlhYmxlIGxpa2UgImkiIG9y
ICJyIiBsYXN0LgoKQnV0IG5vdCBhIGJpZyBpc3N1ZSwKQ2hyaXN0aWFuLgoKPiAgIAo+ICAgCWlm
IChjcHUgPT0gTlVMTCB8fCBzaXplID09IDApCj4gQEAgLTU3NywxMCArNTc4LDExIEBAIGludCBh
bWRncHVfZmluZF9ib19ieV9jcHVfbWFwcGluZyhhbWRncHVfZGV2aWNlX2hhbmRsZSBkZXYsCj4g
ICAJfSBlbHNlIHsKPiAgIAkJKmJ1Zl9oYW5kbGUgPSBOVUxMOwo+ICAgCQkqb2Zmc2V0X2luX2Jv
ID0gMDsKPiArCQlyID0gLUVJTlZBTDsKPiAgIAl9Cj4gICAJcHRocmVhZF9tdXRleF91bmxvY2so
JmRldi0+Ym9fdGFibGVfbXV0ZXgpOwo+ICAgCj4gLQlyZXR1cm4gMDsKPiArCXJldHVybiByOwo+
ICAgfQo+ICAgCj4gICBpbnQgYW1kZ3B1X2NyZWF0ZV9ib19mcm9tX3VzZXJfbWVtKGFtZGdwdV9k
ZXZpY2VfaGFuZGxlIGRldiwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
