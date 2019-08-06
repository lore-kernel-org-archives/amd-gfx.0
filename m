From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: hmm cleanups, v2
Date: Tue,  6 Aug 2019 19:05:38 +0300
Message-ID: <20190806160554.14046-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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

CkhpIErDqXLDtG1lLCBCZW4sIEZlbGl4IGFuZCBKYXNvbiwKCmJlbG93IGlzIGEgc2VyaWVzIGFn
YWluc3QgdGhlIGhtbSB0cmVlIHdoaWNoIGNsZWFucyB1cCB2YXJpb3VzIG1pbm9yCmJpdHMgYW5k
IGFsbG93cyBITU1fTUlSUk9SIHRvIGJlIGJ1aWx0IG9uIGFsbCBhcmNoaXRlY3R1cmVzLgoKRGlm
ZnN0YXQ6CgogICAgMTEgZmlsZXMgY2hhbmdlZCwgOTQgaW5zZXJ0aW9ucygrKSwgMjEwIGRlbGV0
aW9ucygtKQoKQSBnaXQgdHJlZSBpcyBhbHNvIGF2YWlsYWJsZSBhdDoKCiAgICBnaXQ6Ly9naXQu
aW5mcmFkZWFkLm9yZy91c2Vycy9oY2gvbWlzYy5naXQgaG1tLWNsZWFudXBzLjIKCkdpdHdlYjoK
CiAgICBodHRwOi8vZ2l0LmluZnJhZGVhZC5vcmcvdXNlcnMvaGNoL21pc2MuZ2l0L3Nob3J0bG9n
L3JlZnMvaGVhZHMvaG1tLWNsZWFudXBzLjIKCkNoYW5nZXMgc2luY2UgdjE6CiAtIGZpeCB0aGUg
Y292ZXIgbGV0dGVyIHN1YmplY3QKIC0gaW1wcm92ZSB2YXJpb3VzIHBhdGNoIGRlc2NyaXB0aW9u
cwogLSB1c2Ugc3ZtbS0+bW0gaW4gbm91dmVhdV9yYW5nZV9mYXVsdAogLSBpbnZlcnNlIHRoZSBo
bWFzayBmaWVsZCB3aGVuIHVzaW5nIGl0CiAtIHNlbGVjdCBITU1fTUlSUk9SIGluc3RlYWQgb2Yg
bWFraW5nIGl0IGEgdXNlciB2aXNpYmxlIG9wdGlvbgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpOb3V2ZWF1IG1haWxpbmcgbGlzdApOb3V2ZWF1QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL25vdXZlYXU=
