From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: regression in suspend/resume on Polaris
Date: Mon, 20 Nov 2017 14:21:26 +0100
Message-ID: <d558b4ac-d533-ca09-3bf1-918a0f41370b@amd.com>
References: <abd84787-4ba4-0a98-d17e-86a1e1467d8c@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <abd84787-4ba4-0a98-d17e-86a1e1467d8c-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Liu, Monk" <monk.liu-5C7GfCeVMHo@public.gmane.org>

WWVhaCwga25vd24gaXNzdWUuIFNlZSB0aGUgcHJvcG9zZWQgcGF0Y2ggZnJvbSBNb25rIGFib3V0
IHBhcnRpYWxseSAKcmV2ZXJ0aW5nIHRoaXMgY29tbWl0LgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoK
QW0gMjAuMTEuMjAxNyB1bSAxNDoxOCBzY2hyaWViIFRvbSBTdCBEZW5pczoKPiBIaSwKPgo+IFRo
aXMgY29tbWl0IGNhdXNlcyBhIGZhaWx1cmUgKGF0dGFjaGVkKSBvbiByZXN1bWUgd2l0aCBhIFBv
bGFyaXMxMCAKPiBkZXZpY2UgaW5zdGFsbGVkIChkdXJpbmcgdXZkIHZpZGVvIHBsYXliYWNrKS4K
Pgo+IGNvbW1pdCAxY2ZkOGUyMzdmMDMxOGUzMzAxOTBhYzIxZDYzYzU4YWU2YTFmNjZjIChIRUFE
LCByZWZzL2Jpc2VjdC9iYWQpCj4gQXV0aG9yOiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4K
PiBEYXRlOsKgwqAgVHVlIE5vdiAxNCAxMTo1MjozNSAyMDE3ICswODAwCj4KPiDCoMKgwqAgZHJt
L2FtZGdwdTpjbGVhbnVwIEdNQyAmIGdhcnQgZ2FyYmFnZSBmdW5jdGlvbgo+Cj4gwqDCoMKgIGZv
ciBnYXJ0X3JhbV9hbGxvYy9mcmVlLCB0aGV5IGFyZSBuZXZlciB1c2VkIGluIGRyaXZlciB0aHVz
Cj4gwqDCoMKgIHJpcGUgdGhlbSBvdXQgdG90YWxseS4KPgo+IMKgwqDCoCBmb3IgZ2FydF92cmFt
X3Bpbi91bnBpbiwgdGhleSBhcmUgbm90IG5lZWRlZCBiZWN1YXNlIHdlIGNhbgo+IMKgwqDCoCB1
c2UgYm9fY3JlYXRfa2VybmVsL2ZyZWUgdG8gcmVwbGFjZSB0aGUgb3JpZ2luYWwgbWFudWFsIHdh
eQo+IMKgwqDCoCBpbiB0aGUgZ2FydF92cmFtX2FsbG9jL2ZyZWUsIHRodXMgZ2FydF92cmFtX3Bp
bi91bnBpbiBjYW4KPiDCoMKgwqAgYWxzbyBiZSByaXBlZCBvdXQuCj4KPiDCoMKgwqAgQ2hhbmdl
LUlkOiBJYzYwOTQ5YjU5ZDhiMzYzZTUxOTlmNmMxMWQ5ZWE0YTE1ZWM1NzUxOQo+IMKgwqDCoCBT
aWduZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KPiDCoMKgwqAgUmV2aWV3
ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPgo+IENo
ZWVycywKPiBUb20KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
