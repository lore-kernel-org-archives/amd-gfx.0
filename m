From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: skip huge page for PRT mapping
Date: Tue, 5 Jun 2018 08:20:14 +0200
Message-ID: <b819e5ef-d08e-f2ba-ff28-a601dcd7eee7@amd.com>
References: <1528077815-32053-1-git-send-email-Jerry.Zhang@amd.com>
 <BY1PR12MB0502AD59C8B89200345C8CDFB4670@BY1PR12MB0502.namprd12.prod.outlook.com>
 <648c1eb2-0729-7091-6df5-4795e720f25c@gmail.com> <5B14E41E.8030004@amd.com>
 <b303b120-e096-6b3f-71f4-6464e1f2a763@amd.com> <5B14F609.7020105@amd.com>
 <5d5211d6-440b-59a7-1eec-7e6f5d556ecf@amd.com> <5B15EC7E.6010203@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5B15EC7E.6010203-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SGkgSmVycnksCgpBbSAwNS4wNi4yMDE4IHVtIDAzOjUwIHNjaHJpZWIgWmhhbmcsIEplcnJ5IChK
dW53ZWkpOgo+IFtTTklQXQo+Pgo+PiBDYW4geW91IGNoZWNrIGlmIHRoZSBwcm9ibGVtIGFsc28g
dmFuaXNoZXMgd2hlbiB5b3UgZGlzYWJsZSB0aGUgCj4+IGZvbGxvd2luZwo+PiBvcHRpbWl6YXRp
b24gaW4gYW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzPwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIC8qIFdlIGRvbid0IG5lZWQgdG8gdXBkYXRlIFBURXMgZm9yIGh1Z2UgcGFnZXMgKi8K
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZW50cnktPmh1Z2UpCj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+
PiBKdXN0IGNvbW1lbnQgdGhpcyBvdXQgZm9yIGEgdGVzdC4KPgo+IFRoYW5rcyB0byBwb2ludCBp
dCBvdXQuCj4gVGhhdCBpbmRlZWQgd29ya3Mgd2VsbCB0b28uCj4KPiBUaGUgaXNzdWUgaGFwcGVu
ZWQgYnkgbWlzc2luZyB0byB1cGRhdGUgUFRFIGZvciByZXNlcnZlZCBQUlQgcmFuZ2UsIGlmIAo+
IGh1Z2UgcGFnZSBpcyBpbnRyb2R1Y2VkLgo+Cj4gTm90IHN1cmUgaWYgYmVsb3cgY2hhbmdlIGlz
IGV4cGVjdGVkIHRvIHNhdmUgdGhlIGh1Z2UgcGFnZSBmb3IgUFJUIAo+IHN1cHBvcnQuCj4gVGhh
dCB1cGRhdGVzIHRoZSBodWdlIHBhZ2UgYW5kIGZpbGxzIHRoZSBjb3JyZWN0IFBURSBmb3IgUFJU
IGFzIHdlbGwsIAo+IGRpZmZlcmVudCBmcm9tIGN1cnJlbnQgZml4IHBhdGNoLgo+IHt7ewo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBXZSBkb24ndCBuZWVkIHRvIHVwZGF0ZSBQ
VEVzIGZvciBodWdlIHBhZ2VzICovCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
KGVudHJ5LT5odWdlKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChlbnRyeS0+
aHVnZSAmJiAhKGZsYWdzICYgQU1ER1BVX1BURV9QUlQpKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7Cj4KPiB9fX0KCnByb2JsZW0gaXMg
dGhhdCBub3Qgb25seSBhZmZlY3RzIFBSVCwgYnV0IGFsbCBtYXBwaW5ncy4KClNlZSB0aGUgcGF0
Y2ggaGVyZSBpZiB5b3UgY3VycmVudGx5IGNhbid0IHJlY2VpdmUgbWFpbHMgZnJvbSBhbWQtZ2Z4
OiAKaHR0cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0b3Aub3JnL3BhdGNoLzIyNzMzNi8KCkVzc2Vu
dGlhbGx5IEkgbWFkZSBhIHdyb25nIGFzc3VtcHRpb24gaW4gdGhlIGNsZWFyIGFsbCBjb2RlIHBh
dGguIFBsZWFzZSAKYWxzbyBub3RlIHRoYXQgSSBoYWRuJ3QgdGltZSB0byBmdWxseSB0ZXN0IHRo
aXMgcGF0Y2ggeWV0LgoKQ2hyaXN0aWFuLgoKPgo+Cj4gSmVycnkKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
