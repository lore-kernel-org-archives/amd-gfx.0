From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 1/5] drm/amdgpu/gfx8: KIQ is also disabled when MEC is
 disabled
Date: Fri, 31 Mar 2017 09:00:33 +0200
Message-ID: <eb79c077-2024-1737-5016-0dc461c6182e@vodafone.de>
References: <1490898851-2797-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490898851-2797-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

QW0gMzAuMDMuMjAxNyB1bSAyMDozNCBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBTZXQgdGhlIHJl
YWR5IGZsYWcgdG8gcmVmbGVjdCB0aGlzLgo+Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKUGF0Y2hlcyAjMSBhbmQgIzMtIzUgYXJlIFJl
dmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIAo8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoK
UGF0Y2ggIzIgaXMgQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5j
IHwgMSArCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYwo+IGluZGV4IDFkMDBiMDQuLjNkNGNlMDMgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYwo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMKPiBAQCAtNDU2MSw2ICs0NTYxLDcgQEAg
c3RhdGljIHZvaWQgZ2Z4X3Y4XzBfY3BfY29tcHV0ZV9lbmFibGUoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsIGJvb2wgZW5hYmxlKQo+ICAgCQlXUkVHMzIobW1DUF9NRUNfQ05UTCwgKENQX01F
Q19DTlRMX19NRUNfTUUxX0hBTFRfTUFTSyB8IENQX01FQ19DTlRMX19NRUNfTUUyX0hBTFRfTUFT
SykpOwo+ICAgCQlmb3IgKGkgPSAwOyBpIDwgYWRldi0+Z2Z4Lm51bV9jb21wdXRlX3JpbmdzOyBp
KyspCj4gICAJCQlhZGV2LT5nZnguY29tcHV0ZV9yaW5nW2ldLnJlYWR5ID0gZmFsc2U7Cj4gKwkJ
YWRldi0+Z2Z4LmtpcS5yaW5nLnJlYWR5ID0gZmFsc2U7Cj4gICAJfQo+ICAgCXVkZWxheSg1MCk7
Cj4gICB9CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
