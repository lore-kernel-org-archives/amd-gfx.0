From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH v2] drm/amdgpu: fix solid screen and hard hang when 2k +
 4k display connected with DP
Date: Mon, 26 Jun 2017 14:20:11 +0200
Message-ID: <9150a21d-24c3-8069-73b2-e3f4aec89892@vodafone.de>
References: <1498479491-31585-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1498479491-31585-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Sonny Jiang <sonny.jiang-5C7GfCeVMHo@public.gmane.org>, Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, Joe Qiao <Joe2.Qiao-5C7GfCeVMHo@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>

QW0gMjYuMDYuMjAxNyB1bSAxNDoxOCBzY2hyaWViIEh1YW5nIFJ1aToKPiBTaWduZWQtb2ZmLWJ5
OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgoKQWNrZWQtYnk6IENocmlzdGlhbiBLw7Zu
aWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4uCgo+IC0tLQo+Cj4gVjEgLT4gVjI6Cj4gLSBB
ZGQgUkVBRF9PTkNFIHRvIGF2b2lkIGNvbXBsaWVyIG1pZ2h0IGNhdXNlIHRvIHJlYWQgYXMgcHJl
dmlvdXMgZmVuY2UgdmFsdWUuCj4KPiBJIHdpbGwgcmVmaW5lIGZlbmNlIGNoZWNraW5nIHdpdGgg
ZmVuY2UgaW50ZXJmYWNlIGF0IGFtZGdwdV9mZW5jZS5jIGFmdGVyIFMzCj4gc3RyZXNzIGlzc3Vl
IGNvbXBsZXRlZCBhcyBDaHJpc3RpYW4ncyBzdWdnZXN0aW9uLgo+Cj4gVGhhbmtzLAo+IFJheQo+
Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgfCAyICst
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKPiBpbmRleCA1YmVkNDgzLi5hZjNj
ODdiIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3Au
Ywo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwo+IEBAIC0x
MzAsNyArMTMwLDcgQEAgcHNwX2NtZF9zdWJtaXRfYnVmKHN0cnVjdCBwc3BfY29udGV4dCAqcHNw
LAo+ICAgCXJldCA9IHBzcF9jbWRfc3VibWl0KHBzcCwgdWNvZGUsIGNtZF9idWZfbWNfYWRkciwK
PiAgIAkJCSAgICAgZmVuY2VfbWNfYWRkciwgaW5kZXgpOwo+ICAgCj4gLQl3aGlsZSAoKigodW5z
aWduZWQgaW50ICopcHNwLT5mZW5jZV9idWYpICE9IGluZGV4KSB7Cj4gKwl3aGlsZSAoUkVBRF9P
TkNFKCooKHVuc2lnbmVkIGludCAqKXBzcC0+ZmVuY2VfYnVmKSkgPCBpbmRleCkgewo+ICAgCQlt
c2xlZXAoMSk7Cj4gICAJfQo+ICAgCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
