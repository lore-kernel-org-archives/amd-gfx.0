From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 13/13] mm: allow HMM_MIRROR on all architectures
 with MMU
Date: Tue, 30 Jul 2019 08:52:03 +0300
Message-ID: <20190730055203.28467-14-hch@lst.de>
References: <20190730055203.28467-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190730055203.28467-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/nouveau>
List-Post: <mailto:nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Nouveau" <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: Ralph Campbell <rcampbell-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
List-Id: amd-gfx.lists.freedesktop.org

VGhlcmUgaXNuJ3QgcmVhbGx5IGFueSBhcmNoaXRlY3R1cmUgc3BlY2lmaWMgY29kZSBpbiB0aGlz
IHBhZ2UgdGFibGUKd2FsayBpbXBsZW1lbnRhdGlvbiwgc28gZHJvcCB0aGUgZGVwZW5kZW5jaWVz
LgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+Ci0tLQogbW0v
S2NvbmZpZyB8IDMgKy0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvbW0vS2NvbmZpZyBiL21tL0tjb25maWcKaW5kZXggNTZjZWM2
MzZhMWZjLi5iMTg3ODJiZTk2OWMgMTAwNjQ0Ci0tLSBhL21tL0tjb25maWcKKysrIGIvbW0vS2Nv
bmZpZwpAQCAtNjc3LDggKzY3Nyw3IEBAIGNvbmZpZyBERVZfUEFHRU1BUF9PUFMKIAogY29uZmln
IEhNTV9NSVJST1IKIAlib29sICJITU0gbWlycm9yIENQVSBwYWdlIHRhYmxlIGludG8gYSBkZXZp
Y2UgcGFnZSB0YWJsZSIKLQlkZXBlbmRzIG9uIChYODZfNjQgfHwgUFBDNjQpCi0JZGVwZW5kcyBv
biBNTVUgJiYgNjRCSVQKKwlkZXBlbmRzIG9uIE1NVQogCXNlbGVjdCBNTVVfTk9USUZJRVIKIAlo
ZWxwCiAJICBTZWxlY3QgSE1NX01JUlJPUiBpZiB5b3Ugd2FudCB0byBtaXJyb3IgcmFuZ2Ugb2Yg
dGhlIENQVSBwYWdlIHRhYmxlIG9mIGEKLS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTm91dmVhdSBtYWlsaW5nIGxpc3QKTm91dmVhdUBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9ub3V2ZWF1
