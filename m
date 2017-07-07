From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Add invalidate tlb for all hub bit field
 define
Date: Fri, 7 Jul 2017 15:37:31 -0400
Message-ID: <921e0ecf-8d8a-a029-ddf5-e21b2bf29704@amd.com>
References: <1499448103-12407-1-git-send-email-Shaoyun.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1499448103-12407-1-git-send-email-Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

VGhlIHNlcmllcyBpcyBSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5n
QGFtZC5jb20+CgoKT24gMTctMDctMDcgMDE6MjEgUE0sIFNoYW95dW4gTGl1IHdyb3RlOgo+IENo
YW5nZS1JZDogSTU2NDc1YjcyYWM5ZjlhOGUyNzAxYzU4YzViMTBlMWYyOTMwYWY3Y2QKPiBTaWdu
ZWQtb2ZmLWJ5OiBTaGFveXVuIExpdSA8U2hhb3l1bi5MaXVAYW1kLmNvbT4KPiAtLS0KPiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTVkLmggfCAxICsKPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc29jMTVkLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNWQuaAo+IGluZGV4
IDI5OGVmNGUuLjMxMzBhZjggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc29jMTVkLmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNWQuaAo+
IEBAIC0yNjksNiArMjY5LDcgQEAKPiAgCj4gICNkZWZpbmUJUEFDS0VUM19JTlZBTElEQVRFX1RM
QlMJCQkJMHg5OAo+ICAjICAgICAgICAgICAgICBkZWZpbmUgUEFDS0VUM19JTlZBTElEQVRFX1RM
QlNfRFNUX1NFTCh4KSAgICAgKCh4KSA8PCAwKQo+ICsjICAgICAgICAgICAgICBkZWZpbmUgUEFD
S0VUM19JTlZBTElEQVRFX1RMQlNfQUxMX0hVQih4KSAgICAgKCh4KSA8PCA0KQo+ICAjICAgICAg
ICAgICAgICBkZWZpbmUgUEFDS0VUM19JTlZBTElEQVRFX1RMQlNfUEFTSUQoeCkgICAgICAgKCh4
KSA8PCA1KQo+ICAjZGVmaW5lIFBBQ0tFVDNfU0VUX1JFU09VUkNFUwkJCQkweEEwCj4gIC8qIDEu
IGhlYWRlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
