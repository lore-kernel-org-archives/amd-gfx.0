From: Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>
Subject: Re: [PATCH 01/10] dma-buf: make fence sequence numbers 64 bit v2
Date: Tue, 04 Dec 2018 12:52:15 +0000
Message-ID: <154392793531.11526.17927449302716457070@skylake-alporthouse-com>
References: <20181204115948.15202-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181204115948.15202-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

UXVvdGluZyBDaHJpc3RpYW4gS8O2bmlnICgyMDE4LTEyLTA0IDExOjU5OjM5KQo+IC1zdGF0aWMg
aW5saW5lIGJvb2wgX19kbWFfZmVuY2VfaXNfbGF0ZXIodTMyIGYxLCB1MzIgZjIpCj4gK3N0YXRp
YyBpbmxpbmUgYm9vbCBfX2RtYV9mZW5jZV9pc19sYXRlcih1NjQgZjEsIHU2NCBmMikKPiAgewo+
IC0gICAgICAgcmV0dXJuIChpbnQpKGYxIC0gZjIpID4gMDsKPiArICAgICAgIC8qIFRoaXMgaXMg
Zm9yIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgd2l0aCBkcml2ZXJzIHdoaWNoIGNhbiBvbmx5IGhh
bmRsZQo+ICsgICAgICAgICogMzJiaXQgc2VxdWVuY2UgbnVtYmVycy4gVXNlIGEgNjRiaXQgY29t
cGFyZSB3aGVuIGFueSBvZiB0aGUgaGlnaGVyCj4gKyAgICAgICAgKiBiaXRzIGFyZSBub25lIHpl
cm8sIG90aGVyd2lzZSB1c2UgYSAzMmJpdCBjb21wYXJlIHdpdGggd3JhcCBhcm91bmQKPiArICAg
ICAgICAqIGhhbmRsaW5nLgo+ICsgICAgICAgICovCj4gKyAgICAgICBpZiAodXBwZXJfMzJfYml0
cyhmMSkgfHwgdXBwZXJfMzJfYml0cyhmMikpCj4gKyAgICAgICAgICAgICAgIHJldHVybiBmMSA+
IGYyOwo+ICsKPiArICAgICAgIHJldHVybiAoaW50KShsb3dlcl8zMl9iaXRzKGYxKSAtIGxvd2Vy
XzMyX2JpdHMoZjIpKSA+IDA7CgpPciBqdXN0ICIoaW50NjRfdCkoZjEgLSBmMikgPiAwIiwgd29y
a3MgaWYgZHJpdmVycyBhcmUgb25seSB1c2luZyB0aGUgbG93CjMyYiBhbmQgaWYgdGhleSB1c2Ug
dGhlIGZ1bGwgNjRiLgotQ2hyaXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
