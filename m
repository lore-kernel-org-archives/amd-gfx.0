From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: increase timeout of IB test
Date: Tue, 26 Jul 2016 09:24:54 +0200
Message-ID: <7ab14e56-0a68-3435-f686-d5b20f9b7eae@vodafone.de>
References: <1469512669-13954-1-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1469512669-13954-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
To: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjYuMDcuMjAxNiB1bSAwNzo1NyBzY2hyaWViIENodW5taW5nIFpob3U6Cj4gd2Ugc2hvdWxk
IGdpdmUgZW5vdWdoIHRpbWUgdG8gSUIgdGVzdC4KPgo+IENoYW5nZS1JZDogSTkyYmZiZTliM2Fh
MzUwODNmNDFiYWVkODY2MzkwN2FiZmExNWM4ZTYKPiBTaWduZWQtb2ZmLWJ5OiBDaHVubWluZyBa
aG91IDxEYXZpZDEuWmhvdUBhbWQuY29tPgoKRG8gd2UgcmVhbGx5IG5lZWQgbW9yZSB0aGFuIDEw
bXMgZm9yIGFuIElCIHRlc3Q/IEEgd2hvbGUgc2Vjb25kIHNvdW5kcyAKYXdmdWwgbG9uZyB3aGVu
IHdlIG5lZWQgdG8gZG8gMTArIHRlc3RzIGN1cnJlbnRseS4KCkNocmlzdGlhbi4KCj4gLS0tCj4g
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYyB8IDIgKy0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2liLmMKPiBpbmRleCAwNTAwNjJlLi5hMzFkN2VmIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2liLmMKPiBAQCAtMzMsNyArMzMsNyBAQAo+
ICAgI2luY2x1ZGUgImFtZGdwdS5oIgo+ICAgI2luY2x1ZGUgImF0b20uaCIKPiAgIAo+IC0jZGVm
aW5lIEFNREdQVV9JQl9URVNUX1RJTUVPVVQJbXNlY3NfdG9famlmZmllcygxMCkKPiArI2RlZmlu
ZSBBTURHUFVfSUJfVEVTVF9USU1FT1VUCW1zZWNzX3RvX2ppZmZpZXMoMTAwMCkKPiAgIAo+ICAg
LyoKPiAgICAqIElCCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
