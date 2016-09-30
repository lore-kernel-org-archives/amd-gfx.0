From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: mutex_destroy in amdgpu_ctx_fini()
Date: Fri, 30 Sep 2016 11:28:23 +0800
Message-ID: <57EDDBD7.7090606@amd.com>
References: <CY4PR12MB1768BBD9F3498EA5EB29C317F7CE0@CY4PR12MB1768.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1768BBD9F3498EA5EB29C317F7CE0-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

R29vZCBjYXRjaCwgQ291bGQgeW91IG1ha2UgYSBwYXRjaD8KClRoYW5rcywKRGF2aWQgWmhvdQoK
T24gMjAxNuW5tDA55pyIMjnml6UgMTk6MTgsIFN0RGVuaXMsIFRvbSB3cm90ZToKPiBJbiB0aGlz
IGJsb2NrIG9mIGNvZGUgSSdtIHdvbmRlcmluZyBpZiB0aGUgbXV0ZXhfZGVzdHJveSBzaG91bGQg
YmUgaG9pc3RlZCBvdXQgb2YgdGhlIGlubmVyIGxvb3A/Cj4KPiBzdGF0aWMgdm9pZCBhbWRncHVf
Y3R4X2Zpbmkoc3RydWN0IGFtZGdwdV9jdHggKmN0eCkKPiB7Cj4gICAgICAgICAgc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYgPSBjdHgtPmFkZXY7Cj4gICAgICAgICAgdW5zaWduZWQgaSwgajsK
Pgo+Cj4gICAgICAgICAgaWYgKCFhZGV2KQo+ICAgICAgICAgICAgICAgICAgcmV0dXJuOwo+Cj4K
PiAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgQU1ER1BVX01BWF9SSU5HUzsgKytpKQo+ICAgICAg
ICAgICAgICAgICAgZm9yIChqID0gMDsgaiA8IGFtZGdwdV9zY2hlZF9qb2JzOyArK2opIHsKPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgZmVuY2VfcHV0KGN0eC0+cmluZ3NbaV0uZmVuY2VzW2pd
KTsKPiAgICAgICAgICAgICAgICAgICAgICAgICAgbXV0ZXhfZGVzdHJveSgmY3R4LT5yaW5nc1tp
XS5zZW1fbG9jayk7Cj4gICAgICAgICAgICAgICAgICB9Cj4KPgo+IENoZWVycywKPiBUb20KPiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZngg
bWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
