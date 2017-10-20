From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/5] drm/amdgpu:skip job for guilty ctx in parser_init
Date: Fri, 20 Oct 2017 11:09:09 +0200
Message-ID: <f4321cf8-0adb-e78b-0903-3d7134228b3a@gmail.com>
References: <1508470385-16164-1-git-send-email-Monk.Liu@amd.com>
 <1508470385-16164-5-git-send-email-Monk.Liu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1508470385-16164-5-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
To: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjAuMTAuMjAxNyB1bSAwNTozMyBzY2hyaWViIE1vbmsgTGl1Ogo+IENoYW5nZS1JZDogSTQ0
MDE5ZjY0NzViMWVhYWJhNTU2MzNjZjVmOGJiODQyODRmMTlhMmMKPiBTaWduZWQtb2ZmLWJ5OiBN
b25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2NzLmMgfCA2ICsrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9jcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMKPiBpbmRl
eCBmN2ZjZWI2Li4xZDVjYmU3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9jcy5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2NzLmMKPiBAQCAtOTAsNiArOTAsMTIgQEAgc3RhdGljIGludCBhbWRncHVfY3NfcGFyc2VyX2lu
aXQoc3RydWN0IGFtZGdwdV9jc19wYXJzZXIgKnAsIHZvaWQgKmRhdGEpCj4gICAJCWdvdG8gZnJl
ZV9jaHVuazsKPiAgIAl9Cj4gICAKPiArCS8qIHNraXAgZ3VpbHR5IGNvbnRleHQgam9iICovCj4g
KwlpZiAoYXRvbWljX3JlYWQoJnAtPmN0eC0+Z3VpbHR5KSA9PSAxKSB7Cj4gKwkJcmV0ID0gLUVD
QU5DRUxFRDsKPiArCQlnb3RvIGZyZWVfY2h1bms7Cj4gKwl9Cj4gKwo+ICAgCW11dGV4X2xvY2so
JnAtPmN0eC0+bG9jayk7Cj4gICAKPiAgIAkvKiBnZXQgY2h1bmtzICovCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
