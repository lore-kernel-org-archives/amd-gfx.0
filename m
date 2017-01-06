From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PART1 PATCH v2 7/8] drm/amdgpu: add get clockgating_state
 method for uvd v5&v6
Date: Fri, 6 Jan 2017 18:23:22 +0800
Message-ID: <20170106102321.GB32617@hr-amur2>
References: <1483688740-7530-1-git-send-email-ray.huang@amd.com>
 <1483688740-7530-3-git-send-email-ray.huang@amd.com>
 <195a9920-1e4a-d3d5-88c7-daf431c90b6c@vodafone.de>
 <20170106101426.GA32617@hr-amur2>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170106101426.GA32617@hr-amur2>
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
To: Christian =?utf-8?B?S++/vW5pZw==?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: Ping Fu <ping.fu-5C7GfCeVMHo@public.gmane.org>, David Mao <david.mao-5C7GfCeVMHo@public.gmane.org>, Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Rex Zhu <rex.zhu-5C7GfCeVMHo@public.gmane.org>, Hawking Zhang <hawking.zhang-5C7GfCeVMHo@public.gmane.org>

T24gRnJpLCBKYW4gMDYsIDIwMTcgYXQgMDY6MTQ6MjdQTSArMDgwMCwgSHVhbmcgUnVpIHdyb3Rl
Ogo+IE9uIEZyaSwgSmFuIDA2LCAyMDE3IGF0IDEwOjUyOjI1QU0gKzAxMDAsIENocmlzdGlhbiBL
w7ZuaWcgd3JvdGU6Cj4gPiBBbSAwNi4wMS4yMDE3IHVtIDA4OjQ1IHNjaHJpZWIgSHVhbmcgUnVp
Ogo+ID4gPitzdGF0aWMgdm9pZCB1dmRfdjZfMF9nZXRfY2xvY2tnYXRpbmdfc3RhdGUodm9pZCAq
aGFuZGxlLCB1MzIgKmZsYWdzKQo+ID4gPit7Cj4gPiA+KwlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWhhbmRsZTsKPiA+ID4rCWludCBkYXRhOwo+
ID4gPisKPiA+ID4rCWlmIChhZGV2LT51dmQuaXNfcG93ZXJnYXRlZCkgewo+ID4gPisJCURSTV9J
TkZPKCJDYW5ub3QgZ2V0IGNsb2NrZ2F0aW5nIHN0YXRlIHdoZW4gVVZEIGlzIHBvd2VyZ2F0ZWQu
XG4iKTsKPiA+ID4rCQlyZXR1cm47Cj4gPiA+ICAJfQo+ID4gCj4gPiBUaGlzIGlzIG5vdCByZWFs
bHkgc2F2ZS4gVGhlIHBvd2VyIGNhbiBiZSBnYXRlZCBqdXN0IGluIHRoZSBtb21lbnQKPiA+IHlv
dSBjaGVjayB0aGUgdmFyaWFibGUuCj4gPiAKPiA+IEFkZGluZyBhIHNwaW5sb2NrIG9yIG11dGV4
IHRvIHByb3RlY3QgdGhlIHZhcmlhYmxlIHNob3VsZCBiZSBzdWZmaWNpZW50Lgo+ID4gCj4gCj4g
WWVzLCBhIGxvY2sgc2hvdWxkIGJlIGFkZGVkLiBIb3cgYWJvdXQgYmVsb3cgY2hhbmdlczoKPiAK
CkNocmlzdGlhbiwgc29ycnkgcGxlYXNlIGlnbm9yZSB0aGlzIG1haWwsIEkganVzdCB1cGRhdGUg
dXZkIHY1LCBtaXNzZWQgdG8KdXBkYXRlIHV2ZCB2Ni4gSSB3aWxsIHNlbmQgaXQgbGF0ZXIuCgpU
aGFua3MsClJ1aQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
