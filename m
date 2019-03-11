From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/5] Clean up TTM mmap offsets
Date: Mon, 11 Mar 2019 17:51:39 +0100
Message-ID: <0ac91c9b-5b8e-b27c-286b-7b9697a4f1c2@gmail.com>
References: <20190207085931.29569-1-tzimmermann@suse.de>
 <2509b876-8335-4be6-b33b-bbf11a73145f@redhat.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <2509b876-8335-4be6-b33b-bbf11a73145f-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>, alexander.deucher-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, David1.Zhou-5C7GfCeVMHo@public.gmane.org, airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, z.liuxinliang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, thellstrom-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org, linux-graphics-maintainer-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, ray.huang-5C7GfCeVMHo@public.gmane.org, Jerry.Zhang-5C7GfCeVMHo@public.gmane.org
Cc: spice-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org

QW0gMTEuMDMuMTkgdW0gMTc6Mzkgc2NocmllYiBIYW5zIGRlIEdvZWRlOgo+IEhpLAo+Cj4gT24g
MDctMDItMTkgMDk6NTksIFRob21hcyBaaW1tZXJtYW5uIHdyb3RlOgo+PiBBbG1vc3QgYWxsIFRU
TS1iYXNlZCBkcml2ZXJzIHVzZSB0aGUgc2FtZSB2YWx1ZXMgZm9yIHRoZSBtbWFwLWFibGUKPj4g
cmFuZ2Ugb2YgQk8gYWRkcmVzc2VzLiBFYWNoIGRyaXZlciB0aGVyZWZvcmUgZHVwbGljYXRlcyB0
aGUKPj4gRFJNX0ZJTEVfUEFHRV9PRkZTRVQgY29uc3RhbnQuIE9UT0gsIHRoZSBtbWFwIHJhbmdl
J3Mgc2l6ZSBpcyBub3QKPj4gY29uZmlndXJhYmxlIGJ5IGRyaXZlcnMuCj4+Cj4+IFRoaXMgcGF0
Y2ggc2V0IHJlcGxhY2VzIGRyaXZlci1zcGVjaWZpYyBjb25maWd1cmF0aW9uIHdpdGggYSBzaW5n
bGUKPj4gc2V0dXAuIEFsbCBjb2RlIGlzIGxvY2F0ZWQgd2l0aGluIFRUTS4gVFRNIGFuZCBHRU0g
c2hhcmUgdGhlIHNhbWUKPj4gcmFuZ2UgZm9yIG1tYXAtYWJsZSBCT3MuCj4+Cj4+IFRob21hcyBa
aW1tZXJtYW5uICg1KToKPj4gwqDCoCBzdGFnaW5nL3Zib3h2aWRlbzogVXNlIHNhbWUgQk8gbW1h
cCBvZmZzZXQgYXMgb3RoZXIgZHJpdmVycwo+PiDCoMKgIGRybS90dG06IERlZmluZSBhIHNpbmds
ZSBEUk1fRklMRV9QQUdFX09GRlNFVCBjb25zdGFudAo+PiDCoMKgIGRybS90dG06IFJlbW92ZSBm
aWxlX3BhZ2Vfb2Zmc2V0IHBhcmFtZXRlciBmcm9tIHR0bV9ib19kZXZpY2VfaW5pdCgpCj4+IMKg
wqAgZHJtL3R0bTogUXVpY2stdGVzdCBtbWFwIG9mZnNldCBpbiB0dG1fYm9fbW1hcCgpCj4+IMKg
wqAgZHJtOiBVc2UgdGhlIHNhbWUgbW1hcC1yYW5nZSBvZmZzZXQgYW5kIHNpemUgZm9yIEdFTSBh
bmQgVFRNCj4KPiBOb3RlIEknbSBhYm91dCB0byBwdXNoIGEgcGF0Y2gtc2VyaWVzIHRvIGRybS1t
aXNjLW5leHQgd2hpY2ggbW92ZXMKPiB2Ym94dmlkZW8gb3V0IG9mIHN0YWdpbmcgYW5kIEkgc2Vl
IHRoYXQgdGhpcyBzZXJpZXMgaGFzIG5vdCBsYW5kZWQKPiBpbiBkcm0tbWlzYy1uZXh0IHlldCwg
c28gaXQgd2lsbCBuZWVkcyB0byBiZSByZWJhc2VkLgoKTWhtLCBUVE0gaXMgdXN1YWxseSBub3Qg
cHVzaGVkIHVwc3RyZWFtIHRocm91Z2ggZHJtLW1pc2MtbmV4dCwgc28gdGhhdCAKd2lsbCBjZXJ0
YWlubHkgY29sbGlkZSB3aXRoIHRoZSBuZXh0IFRUTSBwdWxsIHJlcXVlc3QuCgpTbyBjYW4geW91
IHdhaXQgd2l0aCB0aGF0IG9yIHNob3VsZCBJIG1ha2UgYW4gZXhjZXB0aW9uIGFuZCBtZXJnZSB0
aGlzIApjaGFuZ2UgdGhvdWdoIGRybS1taXNjLW5leHQ/CgpDaHJpc3RpYW4uCgo+Cj4gUmVnYXJk
cywKPgo+IEhhbnMKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCj4gZHJpLWRldmVsIG1haWxpbmcgbGlzdAo+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2RyaS1kZXZlbAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
