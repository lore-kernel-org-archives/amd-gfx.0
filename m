From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/9] PCI: Add pci_enable_atomic_ops_to_root
Date: Thu, 4 Jan 2018 19:23:56 -0500
Message-ID: <2a1cb1fb-9b7c-5357-f1a3-4dbaf19f442c@amd.com>
References: <1515104268-25087-1-git-send-email-Felix.Kuehling@amd.com>
 <1515104268-25087-2-git-send-email-Felix.Kuehling@amd.com>
 <20180105001725.GL189897@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180105001725.GL189897-1RhO1Y9PlrlHTL0Zs8A6p5iNqAH0jzoTYJqu5kTmcBRl57MIdRCFDg@public.gmane.org>
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
To: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Jay Cornwall <Jay.Cornwall-5C7GfCeVMHo@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ram Amrani <Ram.Amrani-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Doug Ledford <dledford-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

T24gMjAxOC0wMS0wNCAwNzoxNyBQTSwgQmpvcm4gSGVsZ2FhcyB3cm90ZToKPiBAQCAtMzA2Niw2
ICszMDY2LDg2IEBAIGludCBwY2lfcmViYXJfc2V0X3NpemUoc3RydWN0IHBjaV9kZXYgKnBkZXYs
Cj4gaW50IGJhciwgaW50IHNpemUpCj4+ICB9Cj4+ICAKPj4gIC8qKgo+PiArICogcGNpX2VuYWJs
ZV9hdG9taWNfb3BzX3RvX3Jvb3QgLSBlbmFibGUgQXRvbWljT3AgcmVxdWVzdHMgdG8gcm9vdCBw
b3J0Cj4+ICsgKiBAZGV2OiB0aGUgUENJIGRldmljZQo+PiArICogQGNvbXBfY2FwczogQ2FwcyBy
ZXF1aXJlZCBmb3IgYXRvbWljIHJlcXVlc3QgY29tcGxldGlvbgo+PiArICoKPj4gKyAqIFJldHVy
biAwIGlmIGFsbCB1cHN0cmVhbSBicmlkZ2VzIHN1cHBvcnQgQXRvbWljT3Agcm91dGluZywgZWdy
ZXNzCj4+ICsgKiBibG9ja2luZyBpcyBkaXNhYmxlZCBvbiBhbGwgdXBzdHJlYW0gcG9ydHMsIGFu
ZCB0aGUgcm9vdCBwb3J0Cj4+ICsgKiBzdXBwb3J0cyB0aGUgcmVxdWVzdGVkIGNvbXBsZXRpb24g
Y2FwYWJpbGl0aWVzICgzMi1iaXQsIDY0LWJpdAo+PiArICogYW5kL29yIDEyOC1iaXQgQXRvbWlj
T3AgY29tcGxldGlvbiksIG9yIG5lZ2F0aXZlIG90aGVyd2lzZS4KPj4gKyAqLwo+PiAraW50IHBj
aV9lbmFibGVfYXRvbWljX29wc190b19yb290KHN0cnVjdCBwY2lfZGV2ICpkZXYsIHUzMiBjb21w
X2NhcHMpCj4gSSBzdGlsbCB3YW50IHRvIHNlZSB0aGlzIHVzZWQgdG8gcmVwbGFjZSBxZWRyX3Bj
aV9zZXRfYXRvbWljKCkgaWYKPiB0aGF0J3MgcG9zc2libGUuICBJJ20gbm90IGNvbnZpbmNlZCB5
ZXQgdGhhdCB0aGV5IG5lZWQgdG8gYmUKPiBkaWZmZXJlbnQuCgpJIGFncmVlLiBUaGlzIHNob3Vs
ZCBiZSBwb3NzaWJsZSBub3cuIEkndmUgY29udmluY2VkIG15c2VsZiB0aGF0IHRoZQpmdW5jdGlv
bnMgZG8gdGhlIHNhbWUgdGhpbmcuIEJ1dCBJIGhhdmUgbm8gd2F5IG9mIHRlc3RpbmcgaXQuIEkn
ZCBhbHNvCmRvIHRoaXMgaW4gYSBzZXBhcmF0ZSBwYXRjaC4gTWF5YmUgUmFtIG9yIERvdWcgY291
bGQgdGVzdCBpdC4KClJlZ2FyZHMsCsKgIEZlbGl4Cgo+Cj4gQmpvcm4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
