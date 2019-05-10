From: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/2] Two bug-fixes for HMM
Date: Fri, 10 May 2019 19:53:21 +0000
Message-ID: <20190510195258.9930-1-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "alex.deucher-5C7GfCeVMHo@public.gmane.org" <alex.deucher-5C7GfCeVMHo@public.gmane.org>, "airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>

VGhlc2UgcHJvYmxlbXMgd2VyZSBmb3VuZCBpbiBBTUQtaW50ZXJuYWwgdGVzdGluZyBhcyB3ZSdy
ZSB3b3JraW5nIG9uDQphZG9wdGluZyBITU0uIFRoZXkgYXJlIHJlYmFzZWQgYWdhaW5zdCBnbGlz
c2UvaG1tLTUuMi12My4gV2UnZCBsaWtlIHRvIGdldA0KdGhlbSBhcHBsaWVkIHRvIGEgbWFpbmxp
bmUgTGludXgga2VybmVsIGFzIHdlbGwgYXMgZHJtLW5leHQgYW5kDQphbWQtc3RhZ2luZy1kcm0t
bmV4dCBzb29uZXIgcmF0aGVyIHRoYW4gbGF0ZXIuDQoNCkN1cnJlbnRseSB0aGUgSE1NIGluIGFt
ZC1zdGFnaW5nLWRybS1uZXh0IGlzIHF1aXRlIGZhciBiZWhpbmQgaG1tLTUuMi12MywNCmJ1dCB0
aGUgZHJpdmVyIGNoYW5nZXMgZm9yIEhNTSBhcmUgZXhwZWN0ZWQgdG8gbGFuZCBpbiA1LjIgYW5k
IHdpbGwgbmVlZCB0bw0KYmUgcmViYXNlZCBvbiB0aG9zZSBITU0gY2hhbmdlcy4NCg0KSSdkIGxp
a2UgdG8gd29yayBvdXQgYSBmbG93IGJldHdlZW4gSmVyb21lLCBEYXZlLCBBbGV4IGFuZCBteXNl
bGYgdGhhdA0KYWxsb3dzIHVzIHRvIHRlc3QgdGhlIGxhdGVzdCB2ZXJzaW9uIG9mIEhNTSBvbiBh
bWQtc3RhZ2luZy1kcm0tbmV4dCBzbw0KdGhhdCBpZGVhbGx5IGV2ZXJ5dGhpbmcgY29tZXMgdG9n
ZXRoZXIgaW4gbWFzdGVyIHdpdGhvdXQgbXVjaCBuZWVkIGZvcg0KcmViYXNpbmcgYW5kIHJldGVz
dGluZy4NCg0KTWF5YmUgaGF2aW5nIEplcm9tZSdzIGxhdGVzdCBITU0gY2hhbmdlcyBpbiBkcm0t
bmV4dC4gSG93ZXZlciwgdGhhdCBtYXkNCmNyZWF0ZSBkZXBlbmRlbmNpZXMgd2hlcmUgSmVyb21l
IGFuZCBEYXZlIG5lZWQgdG8gY29vcmRpbmF0ZSB0aGVpciBwdWxsLQ0KcmVxdWVzdHMgZm9yIG1h
c3Rlci4NCg0KRmVsaXggS3VlaGxpbmcgKDEpOg0KICBtbS9obW06IE9ubHkgc2V0IEZBVUxUX0ZM
QUdfQUxMT1dfUkVUUlkgZm9yIG5vbi1ibG9ja2luZw0KDQpQaGlsaXAgWWFuZyAoMSk6DQogIG1t
L2htbTogc3VwcG9ydCBhdXRvbWF0aWMgTlVNQSBiYWxhbmNpbmcNCg0KIG1tL2htbS5jIHwgNCAr
Ky0tDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0K
LS0gDQoyLjE3LjENCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
