From: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
Date: Wed, 23 Oct 2019 19:16:25 -0700
Message-ID: <20191024021625.GA5893@infradead.org>
References: <f7e34d8f-f3b0-b86d-7388-1f791674a4a9@amd.com>
 <20191021135744.GA25164@mellanox.com>
 <e07092c3-8ccd-9814-835c-6c462017aff8@amd.com>
 <20191021151221.GC25164@mellanox.com>
 <20191022075735.GV11828@phenom.ffwll.local>
 <20191022150109.GF22766@mellanox.com>
 <20191023090858.GV11828@phenom.ffwll.local>
 <13edf841-421e-3522-fcec-ef919c2013ef@gmail.com>
 <20191023165223.GA4163@redhat.com>
 <20191023172442.GX22766@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20191023172442.GX22766-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
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
To: Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Cc: Andrea Arcangeli <aarcange-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Yang,
 Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>, Ralph Campbell <rcampbell-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-rdma-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-rdma-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, John Hubbard <jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

T24gV2VkLCBPY3QgMjMsIDIwMTkgYXQgMDU6MjQ6NDVQTSArMDAwMCwgSmFzb24gR3VudGhvcnBl
IHdyb3RlOgo+IG1seDUgaXMgc2ltaWxhciwgYnV0IG5vdCBjdXJyZW50bHkgY29kZWQgcXVpdGUg
cmlnaHQsIHRoZXJlIGlzIG9uZQo+IGxvY2sgdGhhdCBwcm90ZWN0cyB0aGUgY29tbWFuZCBxdWV1
ZSBmb3Igc3VibWl0dGluZyBpbnZhbGlkYXRpb25zIHRvCj4gdGhlIEhXIGFuZCBpdCBkb2Vzbid0
IG1ha2UgYSBsb3Qgb2Ygc2Vuc2UgdG8gaGF2ZSBhZGRpdGlvbmFsIGZpbmUKPiBncmFpbmVkIGxv
Y2tpbmcgYmV5b25kIHRoYXQuCgpJRkYgYWxsIGRyaXZlcnMgY291bGQgYWdyZWUgb24gYSBsb2Nr
IHR5cGUgKHJ3X3NlbWFwaG9yZT8pIGZvciB0aGlzCnByb3RlY3Rpb24geW91IGNvdWxkIGFkZCBh
IHBvaW50ZXIgdG8gdGhlIHJhbmdlIHdoaWNoIHdvdWxkIGNsZWFyCnRoaW5ncyB1cCBhIGxvdC4g
IEknbSBqdXN0IG5vdCBzdXJlIHlvdSBjb3VsZCBnZXQgZXZlcnlvbmUgdG8KYWdyZWUuCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
