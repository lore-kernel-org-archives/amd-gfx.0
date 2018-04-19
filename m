From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 4/8] dma-buf: add peer2peer flag
Date: Thu, 19 Apr 2018 01:16:57 -0700
Message-ID: <20180419081657.GA16735@infradead.org>
References: <20180325110000.2238-1-christian.koenig@amd.com>
 <20180325110000.2238-4-christian.koenig@amd.com>
 <20180329065753.GD3881@phenom.ffwll.local>
 <8b823458-8bdc-3217-572b-509a28aae742@gmail.com>
 <20180403090909.GN3881@phenom.ffwll.local>
 <20180403170645.GB5935@redhat.com>
 <20180403180832.GZ3881@phenom.ffwll.local>
 <20180416123937.GA9073@infradead.org>
 <CAKMK7uEFVOh-R2_4vs1M22_wDau0oNTgmCcTWDE+ScxL=92+2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <CAKMK7uEFVOh-R2_4vs1M22_wDau0oNTgmCcTWDE+ScxL=92+2g@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@infradead.org>, Jerome Glisse <jglisse@redhat.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Dan Williams <dan.j.williams@intel.com>, Logan Gunthorpe <logang@deltatee.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gTW9uLCBBcHIgMTYsIDIwMTggYXQgMDM6Mzg6NTZQTSArMDIwMCwgRGFuaWVsIFZldHRlciB3
cm90ZToKPiBXZSd2ZSBicm9rZW4gdGhhdCBhc3N1bXB0aW9uIGluIGk5MTUgeWVhcnMgYWdvLiBO
b3Qgc3RydWN0IHBhZ2UgYmFja2VkCj4gZ3B1IG1lbW9yeSBpcyB2ZXJ5IHJlYWwuCj4gCj4gT2Yg
Y291cnNlIHdlJ2xsIG5ldmVyIGZlZWQgc3VjaCBhIHN0cmFuZ2Ugc2cgdGFibGUgdG8gYSBkcml2
ZXIgd2hpY2gKPiBkb2Vzbid0IHVuZGVyc3RhbmQgaXQsIGJ1dCBhbGxvd2luZyBzZ19wYWdlID09
IE5VTEwgd29ya3MgcGVyZmVjdGx5Cj4gZmluZS4gQXQgbGVhc3QgZm9yIGdwdSBkcml2ZXJzLgoK
Rm9yIEdQVSBkcml2ZXJzIG9uIHg4NiB3aXRoIG5vIGRtYSBjb2hlcmVuY3kgcHJvYmxlbXMsIHN1
cmUuICBCdXQgbm90CmFsbCB0aGUgd29ybGQgaXMgeDg2LiAgV2UgYWxyZWFkeSBoYXZlIHByb2Js
ZW1zIGR1ZSB0byBkbWFidWdzIHVzZQpvZiB0aGUgYXdrd2FyZCBnZXRfc2d0YWJsZSBpbnRlcmZh
Y2UgKHNlZSB0aGUgY29tbW9uIG9uCmFybV9kbWFfZ2V0X3NndGFibGUgdGhhdCBJIGZ1bGx5IGFn
cmVlIHdpdGgpLCBhbmQgZG9pbmcgdGhpcyBmb3IgbWVtb3J5CnRoYXQgZG9lc24ndCBoYXZlIGEg
c3RydWN0IHBhZ2UgYXQgYWxsIHdpbGwgbWFrZSB0aGluZ3MgZXZlbiB3b3JzZS4KCj4gSWYgdGhh
dCdzIG5vdCBhY2NlcHRhYmxlIHRoZW4gSSBndWVzcyB3ZSBjb3VsZCBnbyBvdmVyIHRoZSBlbnRp
cmUgdHJlZQo+IGFuZCBmcm9iIGFsbCB0aGUgZ3B1IHJlbGF0ZWQgY29kZSB0byBzd2l0Y2ggb3Zl
ciB0byBhIG5ldyBzdHJ1Y3QKPiBzZ190YWJsZV9taWdodF9ub3RfYmVfc3RydWN0X3BhZ2VfYmFj
a2VkLCBpbmNsdWRpbmcgYWxsIHRoZSBvdGhlcgo+IGZ1bmN0aW9ucyB3ZSBhZGRlZCBvdmVyIHRo
ZSBwYXN0IGZldyB5ZWFycyB0byBpdGVyYXRlIG92ZXIgc2cgdGFibGVzLgo+IEJ1dCBzZWVtcyBz
bGlnaHRseSBzaWxseSwgZ2l2ZW4gdGhhdCBzZyB0YWJsZXMgc2VlbSB0byBkbyBleGFjdGx5IHdo
YXQKPiB3ZSBuZWVkLgoKSXQgaXNuJ3Qgc2lsbHkuICBXZSB3aWxsIGhhdmUgdG8gZG8gc29tZSBz
dXJnZXJ5IGxpa2UgdGhhdCBhbnl3YXkKYmVjYXVzZSB0aGUgY3VycmVudCBBUElzIGRvbid0IHdv
cmsuICBTbyByZWxheCwgc2l0IGJhY2sgYW5kIGNvbWUgdXAKd2l0aCBhbiBBUEkgdGhhdCBzb2x2
ZXMgdGhlIGV4aXN0aW5nIGlzc3VlcyBhbmQgc2VydmVzIHVzIHdlbGwgaW4KdGhlIGZ1dHVyZS4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
