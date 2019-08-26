From: Ralph Campbell <rcampbell-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] mm/hmm: hmm_range_fault() NULL pointer bug
Date: Mon, 26 Aug 2019 11:02:12 -0700
Message-ID: <e2ecc1a7-0d2f-5957-e6cb-b3c86c085d80@nvidia.com>
References: <20190823221753.2514-1-rcampbell@nvidia.com>
 <20190823221753.2514-2-rcampbell@nvidia.com> <20190824223754.GA21891@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190824223754.GA21891-jcswGhMUV9g@public.gmane.org>
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
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

Ck9uIDgvMjQvMTkgMzozNyBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gT24gRnJpLCBB
dWcgMjMsIDIwMTkgYXQgMDM6MTc6NTJQTSAtMDcwMCwgUmFscGggQ2FtcGJlbGwgd3JvdGU6Cj4+
IEFsdGhvdWdoIGhtbV9yYW5nZV9mYXVsdCgpIGNhbGxzIGZpbmRfdm1hKCkgdG8gbWFrZSBzdXJl
IHRoYXQgYSB2bWEgZXhpc3RzCj4+IGJlZm9yZSBjYWxsaW5nIHdhbGtfcGFnZV9yYW5nZSgpLCBo
bW1fdm1hX3dhbGtfaG9sZSgpIGNhbiBzdGlsbCBiZSBjYWxsZWQKPj4gd2l0aCB3YWxrLT52bWEg
PT0gTlVMTCBpZiB0aGUgc3RhcnQgYW5kIGVuZCBhZGRyZXNzIGFyZSBub3QgY29udGFpbmVkCj4+
IHdpdGhpbiB0aGUgdm1hIHJhbmdlLgo+IAo+IFNob3VsZCB3ZSBjb252ZXJ0IHRvIHdhbGtfdm1h
X3JhbmdlIGluc3RlYWQ/ICBPciBrZWVwIHdhbGtfcGFnZV9yYW5nZQo+IGJ1dCBkcm9wIHNlYXJj
aGluZyB0aGUgdm1hIG91cnNlbHZlcz8KPiAKPiBFeGNlcHQgZm9yIHRoYXQgdGhlIHBhdGNoIGxv
b2tzIGdvb2QgdG8gbWU6Cj4gCj4gUmV2aWV3ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hA
bHN0LmRlPgo+IAoKSSB0aGluayBrZWVwaW5nIHRoZSBjYWxsIHRvIHdhbGtfcGFnZV9yYW5nZSgp
IG1ha2VzIHNlbnNlLgpKYXNvbiBpcyBob3BpbmcgdG8gYmUgYWJsZSB0byBzbmFwc2hvdCBhIHJh
bmdlIHdpdGggJiB3aXRob3V0IHZtYXMKYW5kIGhhdmUgdGhlIHBmbnNbXSBmaWxsZWQgd2l0aCBl
bXB0eS92YWxpZCBlbnRyaWVzIGFzIGFwcHJvcHJpYXRlLgoKSSBwbGFuIHRvIHJlcG9zdCBteSBw
YXRjaCBjaGFuZ2luZyBobW1fcmFuZ2VfZmF1bHQoKSB0byB1c2UKd2Fsay50ZXN0X3dhbGsgd2hp
Y2ggd2lsbCByZW1vdmUgdGhlIGNhbGwgdG8gZmluZF92bWEoKS4KSmFzb24gaGFkIHNvbWUgY29u
Y2VybnMgYWJvdXQgdGVzdGluZyBpdCBzbyB0aGF0J3Mgd2h5IEkgaGF2ZQpiZWVuIHdvcmtpbmcg
b24gc29tZSBITU0gc2VsZiB0ZXN0cyBiZWZvcmUgcmVzZW5kaW5nIGl0LgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
