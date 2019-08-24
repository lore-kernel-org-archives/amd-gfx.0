From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH 1/2] mm/hmm: hmm_range_fault() NULL pointer bug
Date: Sun, 25 Aug 2019 00:37:54 +0200
Message-ID: <20190824223754.GA21891@lst.de>
References: <20190823221753.2514-1-rcampbell@nvidia.com>
 <20190823221753.2514-2-rcampbell@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190823221753.2514-2-rcampbell-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/nouveau>
List-Post: <mailto:nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Nouveau" <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Ralph Campbell <rcampbell-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gRnJpLCBBdWcgMjMsIDIwMTkgYXQgMDM6MTc6NTJQTSAtMDcwMCwgUmFscGggQ2FtcGJlbGwg
d3JvdGU6Cj4gQWx0aG91Z2ggaG1tX3JhbmdlX2ZhdWx0KCkgY2FsbHMgZmluZF92bWEoKSB0byBt
YWtlIHN1cmUgdGhhdCBhIHZtYSBleGlzdHMKPiBiZWZvcmUgY2FsbGluZyB3YWxrX3BhZ2VfcmFu
Z2UoKSwgaG1tX3ZtYV93YWxrX2hvbGUoKSBjYW4gc3RpbGwgYmUgY2FsbGVkCj4gd2l0aCB3YWxr
LT52bWEgPT0gTlVMTCBpZiB0aGUgc3RhcnQgYW5kIGVuZCBhZGRyZXNzIGFyZSBub3QgY29udGFp
bmVkCj4gd2l0aGluIHRoZSB2bWEgcmFuZ2UuCgpTaG91bGQgd2UgY29udmVydCB0byB3YWxrX3Zt
YV9yYW5nZSBpbnN0ZWFkPyAgT3Iga2VlcCB3YWxrX3BhZ2VfcmFuZ2UKYnV0IGRyb3Agc2VhcmNo
aW5nIHRoZSB2bWEgb3Vyc2VsdmVzPwoKRXhjZXB0IGZvciB0aGF0IHRoZSBwYXRjaCBsb29rcyBn
b29kIHRvIG1lOgoKUmV2aWV3ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpOb3V2ZWF1IG1h
aWxpbmcgbGlzdApOb3V2ZWF1QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL25vdXZlYXU=
