From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PART1 PATCH v4 7/8] drm/amdgpu: add get clockgating_state method
 for uvd v5&v6
Date: Mon, 9 Jan 2017 15:45:33 +0100
Message-ID: <523a8df8-2573-0c56-e6c7-5ac74f77f1f3@amd.com>
References: <1483930814-23529-1-git-send-email-ray.huang@amd.com>
 <1483930814-23529-2-git-send-email-ray.huang@amd.com>
 <364cc068-e347-5f77-b4ff-414f8e8b4fdb@amd.com>
 <CY4PR12MB176846FDA72EF232B6825609F7640@CY4PR12MB1768.namprd12.prod.outlook.com>
 <20170109144614.GA3743@hr-amur2>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170109144614.GA3743@hr-amur2>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Cc: "Fu, Ping" <Ping.Fu-5C7GfCeVMHo@public.gmane.org>, "Mao, David" <David.Mao-5C7GfCeVMHo@public.gmane.org>, "Kuehling,
 Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

QW0gMDkuMDEuMjAxNyB1bSAxNTo0NiBzY2hyaWViIEh1YW5nIFJ1aToKPiBPbiBNb24sIEphbiAw
OSwgMjAxNyBhdCAwNzoyOTowMFBNICswODAwLCBTdERlbmlzLCBUb20gd3JvdGU6Cj4+IFl1cCBp
dCdzIGhlbGQgYnkgYm90aCBhbWRncHVfZHBtX2VuYWJsZV91dmQoKSBhbmQgYW1kZ3B1X2RwbV9l
bmFibGVfdmNlKCkKPj4KPj4gVG9tCj4+Cj4gPHNuaXA+Cj4KPj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjVfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC8K
Pj4gYW1kZ3B1L3V2ZF92NV8wLmMKPj4+IGluZGV4IDAzYTM1ZDkuLmU2NDdkM2UgMTAwNjQ0Cj4+
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjVfMC5jCj4+PiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjVfMC5jCj4+PiBAQCAtNzgxLDE2ICs3ODEs
NDggQEAgc3RhdGljIGludCB1dmRfdjVfMF9zZXRfcG93ZXJnYXRpbmdfc3RhdGUodm9pZCAqaGFu
ZGxlLAo+Pj4gICAgICAgICAgKiB0aGUgc21jIGFuZCB0aGUgaHcgYmxvY2tzCj4+PiAgICAgICAg
ICAqLwo+Pj4gICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqKWhhbmRsZTsKPj4+ICsgICAgIGludCByZXQgPSAwOwo+Pj4gICAKPj4+ICAg
ICAgICAgaWYgKCEoYWRldi0+cGdfZmxhZ3MgJiBBTURfUEdfU1VQUE9SVF9VVkQpKQo+Pj4gICAg
ICAgICAgICAgICAgIHJldHVybiAwOwo+Pj4gICAKPj4+ICsgICAgIG11dGV4X2xvY2soJmFkZXYt
PnBtLm11dGV4KTsKPj4gTWlnaHQgYmUgdGhhdCBJJ20gd3JvbmcsIGJ1dCBkaWRuJ3QgVG9tIHNh
aWQgdGhlIG11dGV4IGlzIHRha2VuIGFueXdheQo+PiB3aGVuIHRoaXMgZnVuY3Rpb24gaXMgY2Fs
bGVkPwo+Pgo+PiBJZiB0aGF0J3MgdHJ1ZSB3ZSB3b3VsZCBjZXJ0YWlubHkgcnVuIGludG8gcHJv
YmxlbSB3aGVuIHdlIHRyeSB0bwo+PiBhY3F1aXJlIGl0IGFnYWluLgo+Pgo+IE9LLCBJIHNlZS4g
QWN0dWFsbHksIHBtLm11dGV4IGlzIGFscmVhZHkgaGVsZCBvbiB1cHBlciBsYXllciBjYWxsCj4g
KGFtZGdwdV9kcG1fZW5hYmxlX3V2ZCkuIFNvIHdlIHNob3VsZCBub3QgaG9sZCBpdCBhZ2FpbiBo
ZXJlLgo+Cj4+PiArCj4+PiArc3RhdGljIHZvaWQgdXZkX3Y1XzBfZ2V0X2Nsb2NrZ2F0aW5nX3N0
YXRlKHZvaWQgKmhhbmRsZSwgdTMyICpmbGFncykKPj4+ICt7Cj4+PiArICAgICBzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWhhbmRsZTsKPj4+ICsg
ICAgIGludCBkYXRhOwo+Pj4gKwo+Pj4gKyAgICAgbXV0ZXhfbG9jaygmYWRldi0+cG0ubXV0ZXgp
Owo+Pj4gKwo+IFdlIGp1c3QgbmVlZCBrZWVwIHBtLm11dGV4IGhlcmUgaW4gc2V0X2Nsb2NrZ2F0
aW5nX3N0YXRlLCB0aGF0J3MgZW5vdWdoLgo+Cj4gQ2hyaXN0aWFuLCBUb20sIGFtIEkgcmlnaHQ/
CgpZZXMsIEkgdGhpbmsgc28uCgpDaHJpc3RpYW4uCgo+Cj4gVGhhbmtzLAo+IFJ1aQoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
