From: Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] mm/hmm: hmm_range_fault handle pages swapped out
Date: Fri, 16 Aug 2019 00:54:34 +0000
Message-ID: <20190816005429.GD9929@mellanox.com>
References: <20190815205227.7949-1-Philip.Yang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190815205227.7949-1-Philip.Yang-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <156BFA0EFAA85449B09AE3B7C3825D33-wNKe6lTLrGecE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>, Ralph Campbell <rcampbell-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "alex.deucher-5C7GfCeVMHo@public.gmane.org" <alex.deucher-5C7GfCeVMHo@public.gmane.org>, "Kuehling,
 Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gVGh1LCBBdWcgMTUsIDIwMTkgYXQgMDg6NTI6NTZQTSArMDAwMCwgWWFuZywgUGhpbGlwIHdy
b3RlOgo+IGhtbV9yYW5nZV9mYXVsdCBtYXkgcmV0dXJuIE5VTEwgcGFnZXMgYmVjYXVzZSBzb21l
IG9mIHBmbnMgYXJlIGVxdWFsIHRvCj4gSE1NX1BGTl9OT05FLiBUaGlzIGhhcHBlbnMgcmFuZG9t
bHkgdW5kZXIgbWVtb3J5IHByZXNzdXJlLiBUaGUgcmVhc29uIGlzCj4gZm9yIHN3YXBwZWQgb3V0
IHBhZ2UgcHRlIHBhdGgsIGhtbV92bWFfaGFuZGxlX3B0ZSBkb2Vzbid0IHVwZGF0ZSBmYXVsdAo+
IHZhcmlhYmxlIGZyb20gY3B1X2ZsYWdzLCBzbyBpdCBmYWlsZWQgdG8gY2FsbCBobW1fdmFtX2Rv
X2ZhdWx0IHRvIHN3YXAKPiB0aGUgcGFnZSBpbi4KPgo+IFRoZSBmaXggaXMgdG8gY2FsbCBobW1f
cHRlX25lZWRfZmF1bHQgdG8gdXBkYXRlIGZhdWx0IHZhcmlhYmxlLgoKPiBDaGFuZ2UtSWQ6IEky
ZTg2MTE0ODU1NjNkMTFkOTM4ODgxYzE4Yjc5MzVmYTFlN2M5MWVlCgpJJ2xsIGZpeCBpdCBmb3Ig
eW91IGJ1dCBwbGVhc2UgYmUgY2FyZWZ1bCBub3QgdG8gc2VuZCBDaGFuZ2UtaWQncyB0bwp0aGUg
cHVibGljIGxpc3RzLgoKQWxzbyB3aGF0IGlzIHRoZSBGaXhlcyBsaW5lIGZvciB0aGlzPwoKPiBT
aWduZWQtb2ZmLWJ5OiBQaGlsaXAgWWFuZyA8UGhpbGlwLllhbmdAYW1kLmNvbT4KPiAgbW0vaG1t
LmMgfCAzICsrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpSYWxwaCBoYXMg
YWxzbyBiZWVuIGxvb2tpbmcgYXQgdGhpcyBhcmVhIGFsc28gc28gSSdsbCBnaXZlIGhpbSBhIGJp
dAp0byBjaGltZSBpbiwgb3RoZXJ3aXNlIHdpdGggSmVyb21lJ3MgcmV2aWV3IHRoaXMgbG9va3Mg
T0sgdG8gZ28gdG8KbGludXgtbmV4dAoKVGhhbmtzLApKYXNvbgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZng=
