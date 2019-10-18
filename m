From: Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
Date: Fri, 18 Oct 2019 20:36:18 +0000
Message-ID: <20191018203608.GA5670@mellanox.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <bc954d29-388b-9e29-f960-115ccc6b9fea@gmail.com>
 <20191016160444.GB3430@mellanox.com>
 <2df298e2-ee91-ef40-5da9-2bc1af3a17be@gmail.com>
 <2046e0b4-ba05-0683-5804-e9bbf903658d@amd.com>
 <d6bcbd2a-2519-8945-eaf5-4f4e738c7fa9@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d6bcbd2a-2519-8945-eaf5-4f4e738c7fa9-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <C97D0CFCD1F5B645A1B272BD732EBC74-wNKe6lTLrGecE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Andrea Arcangeli <aarcange-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Yang,
 Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>, Ralph Campbell <rcampbell-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-rdma-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-rdma-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, John Hubbard <jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

T24gVGh1LCBPY3QgMTcsIDIwMTkgYXQgMDQ6NDc6MjBQTSArMDAwMCwgS29lbmlnLCBDaHJpc3Rp
YW4gd3JvdGU6Cgo+ID4gZ2V0X3VzZXJfcGFnZXMvaG1tX3JhbmdlX2ZhdWx0KCkgYW5kIGludmFs
aWRhdGVfcmFuZ2Vfc3RhcnQoKSBib3RoIGFyZQo+ID4gY2FsbGVkIHdoaWxlIGhvbGRpbmcgbW0t
Pm1hcF9zZW0sIHNvIHRoZXkgYXJlIGFsd2F5cyBzZXJpYWxpemVkLgo+IAo+IE5vdCBldmVuIHJl
bW90ZWx5Lgo+IAo+IEZvciBjYWxsaW5nIGdldF91c2VyX3BhZ2VzKCkvaG1tX3JhbmdlX2ZhdWx0
KCkgeW91IG9ubHkgbmVlZCB0byBob2xkIHRoZSAKPiBtbWFwX3NlbSBpbiByZWFkIG1vZGUuCgpS
aWdodAogCj4gQW5kIElJUkMgaW52YWxpZGF0ZV9yYW5nZV9zdGFydCgpIGlzIHNvbWV0aW1lcyBj
YWxsZWQgd2l0aG91dCBob2xkaW5nIAo+IHRoZSBtbWFwX3NlbSBhdCBhbGwuCgpZZXAKIAo+IFNv
IGFnYWluIGhvdyBhcmUgdGhleSBzZXJpYWxpemVkPwoKVGhlICdkcml2ZXIgbG9jaycgdGhpbmcg
ZG9lcyBpdCwgcmVhZCB0aGUgaG1tIGRvY3VtZW50YXRpb24sIHRoZSBobW0KYXBwcm9hY2ggaXMg
YmFzaWNhbGx5IHRoZSBvbmx5IGFwcHJvYWNoIHRoYXQgd2FzIGNvcnJlY3Qgb2YgYWxsIHRoZQpk
cml2ZXJzLi4KClNvIGxvbmcgYXMgdGhlICdkcml2ZXIgbG9jaycgaXMgaGVsZCB0aGUgcmFuZ2Ug
Y2Fubm90IGJlY29tZQppbnZhbGlkYXRlZCBhcyB0aGUgJ2RyaXZlciBsb2NrJyBwcmV2ZW50cyBw
cm9ncmVzcyBvZiBpbnZhbGlkYXRpb24uCgpIb2xkaW5nIHRoZSBkcml2ZXIgbG9jayBhbmQgdXNp
bmcgdGhlIHNlcSBiYXNlZCBtbXVfcmFuZ2VfcmVhZF9yZXRyeSgpCnRlbGxzIGlmIHRoZSBwcmV2
aW91cyB1bmxvY2tlZCBnZXRfdXNlcl9wYWdlcygpIGlzIHN0aWxsIHZhbGlkIG9yCm5lZWRzIHRv
IGJlIGRpc2NhcmQuCgpTbyBpdCBkb2Vzbid0IG1hdHRlciBpZiBnZXRfdXNlcl9wYWdlcygpIHJh
Y2VzIG9yIG5vdCwgdGhlIHJlc3VsdCBpcyBub3QKdG8gYmUgdXNlZCB1bnRpbCB0aGUgZHJpdmVy
IGxvY2sgaXMgaGVsZCBhbmQgbW11X3JhbmdlX3JlYWRfcmV0cnkoKQpjYWxsZWQsIHdoaWNoIHBy
b3ZpZGVzIHRoZSBjb2hlcmVuY2UuCgpJdCBpcyB0aGUgdXN1YWwgc2VxbG9jayBwYXR0ZXJuLgoK
SmFzb24KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
