From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 12/15] drm/amdgpu: limit block size to one page
Date: Tue, 28 Mar 2017 11:07:12 +0800
Message-ID: <58D9D360.4080902@amd.com>
References: <1490594005-14553-1-git-send-email-David1.Zhou@amd.com>
 <1490594005-14553-13-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490594005-14553-13-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
To: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org, Alexander.Deucher-5C7GfCeVMHo@public.gmane.org

T24gMDMvMjcvMjAxNyAwMTo1MyBQTSwgQ2h1bm1pbmcgWmhvdSB3cm90ZToKPiBDaGFuZ2UtSWQ6
IEkwMGZmNWQyYzdmZjI5NTYzMzk0Y2I4YWY0YzU3NzgwYjkxODc2NzQzCj4gU2lnbmVkLW9mZi1i
eTogQ2h1bm1pbmcgWmhvdSA8RGF2aWQxLlpob3VAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDggKysrKysrKysKPiAgIDEgZmls
ZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGV2aWNlLmMKPiBpbmRleCA3YmFkNmI2Li40MDQxZDcyIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+IEBAIC0xMDc5LDYgKzEwNzks
MTQgQEAgc3RhdGljIGJvb2wgYW1kZ3B1X2NoZWNrX3BvdF9hcmd1bWVudChpbnQgYXJnKQo+Cj4g
ICBzdGF0aWMgdm9pZCBhbWRncHVfZ2V0X2Jsb2NrX3NpemUoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpCj4gICB7Cj4gKwkvKiBmcm9tIEFJLCBhc2ljIHN0YXJ0cyB0byBzdXBwb3J0IG11bHRp
cGxlIGxldmVsIFZNUFQgKi8KPiArCWlmIChhZGV2LT5mYW1pbHkgPj0gQU1ER1BVX0ZBTUlMWV9B
SSkgewo+ICsJCWlmIChhbWRncHVfdm1fYmxvY2tfc2l6ZSAhPSA5KQo+ICsJCQlkZXZfd2Fybihh
ZGV2LT5kZXYsICJNdWx0aS1WTVBUIGxpbWl0cyBibG9jayBzaXplIHRvIgo+ICsJCQkJICJvbmUg
cGFnZSFcbiIpOwo+ICsJCWFtZGdwdV92bV9ibG9ja19zaXplID0gOTsKCkRvIHlvdSBtZWFuIGZv
ciBtdWx0aS1WTVBULCB0aGUgYmxvY2sgc2l6ZSBtdXN0IGJlIDk/CklzIHRoYXQgcmVsYXRlZCB0
byBwYWdlIGxldmVsPwoKSmVycnkKCj4gKwkJcmV0dXJuOwo+ICsJfQo+ICAgCS8qIGRlZmluZXMg
bnVtYmVyIG9mIGJpdHMgaW4gcGFnZSB0YWJsZSB2ZXJzdXMgcGFnZSBkaXJlY3RvcnksCj4gICAJ
ICogYSBwYWdlIGlzIDRLQiBzbyB3ZSBoYXZlIDEyIGJpdHMgb2Zmc2V0LCBtaW5pbXVtIDkgYml0
cyBpbiB0aGUKPiAgIAkgKiBwYWdlIHRhYmxlIGFuZCB0aGUgcmVtYWluaW5nIGJpdHMgYXJlIGlu
IHRoZSBwYWdlIGRpcmVjdG9yeSAqLwo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
