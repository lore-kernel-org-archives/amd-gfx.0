From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: read reg in each iterate of psp_wait_for loop
Date: Tue, 18 Jul 2017 10:50:27 +0800
Message-ID: <596D7773.3010602@amd.com>
References: <1500027617-18557-1-git-send-email-Jerry.Zhang@amd.com>
 <20170717075209.GA16630@hr-amur2> <20170717075755.GB16630@hr-amur2>
 <596C7BBA.2010300@amd.com> <20170717105741.GC32372@kroah.com>
 <20170717114511.GA18478@hr-amur2>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170717114511.GA18478@hr-amur2>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Wang,
 Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>, "stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMDcvMTcvMjAxNyAwNzo0NSBQTSwgSHVhbmcgUnVpIHdyb3RlOgo+IE9uIE1vbiwgSnVsIDE3
LCAyMDE3IGF0IDA2OjU3OjQxUE0gKzA4MDAsIEdyZWcgS0ggd3JvdGU6Cj4+IE9uIE1vbiwgSnVs
IDE3LCAyMDE3IGF0IDA0OjU2OjI2UE0gKzA4MDAsIFpoYW5nLCBKZXJyeSAoSnVud2VpKSB3cm90
ZToKPj4gPiArIHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPj4KPj4gPGZvcm1sZXR0ZXI+Cj4+Cj4+
IFRoaXMgaXMgbm90IHRoZSBjb3JyZWN0IHdheSB0byBzdWJtaXQgcGF0Y2hlcyBmb3IgaW5jbHVz
aW9uIGluIHRoZQo+PiBzdGFibGUga2VybmVsIHRyZWUuICBQbGVhc2UgcmVhZDoKPj5odHRwczov
L3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9wcm9jZXNzL3N0YWJsZS1rZXJuZWwtcnVs
ZXMuaHRtbAo+PiBmb3IgaG93IHRvIGRvIHRoaXMgcHJvcGVybHkuCj4+Cj4+IDwvZm9ybWxldHRl
cj4KPgo+IFRoYW5rcywgR3JlZy4gOi0pCgpUaGFua3MgR3JlZyB0byByZW1pbmRlciB0aGF0Cgo+
Cj4+PiBCVFc6IHBsZWFzZSBhZGQgQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiBpbiB5b3Vy
IHBhdGNoLCBpdCBuZWVkIGJlCj4+PiBiYWNrcG9ydGVkIHRvIHN0YWJsZSB0cmVlLgo+Cj4gSmVy
cnksIEkgbWlnaHQgbm90IGRlc2NyaWJlIGl0IGNsZWFybHkuIFdlIG5lZWQgZm9sbG93IHRoZSBy
dWxlIHRoYXQgR3JlZwo+IHByb3ZpZGVkLiBBY3R1YWxseSwgSSBtZWFudCB0byBhZGQgQ2MgaW4g
eW91ciBjb21taXQgbWVzc2FnZSBsaWtlIGJlbG93LAo+IHRoZW4gc2VudCBpdCBvdXQ6CgpUaGFu
a3MgdG8gZXhwbGFpbiBpbiBkZXRhaWwuCkkgd2lsbCBwcmVwYXJlIGl0IHRoZW0gYXMgb25lIHBh
dGNoIGFnYWluLgoKSmVycnkKCj4KPiA4PC0tLS0tLS0tLS0KPgo+IFN1YmplY3Q6IFtQQVRDSF0g
ZHJtL2FtZGdwdTogcmVhZCByZWcgaW4gZWFjaCBpdGVyYXRlIG9mIHBzcF93YWl0X2ZvciBsb29w
Cj4KPiBUaGlzIGZpeGVzIHRoZSBTT1MgbG9hZGluZyBmYWlsdXJlIG9mIHBzcCB2My4xLgo+Cj4g
U2lnbmVkLW9mZi1ieTogSnVud2VpIFpoYW5nIDxKZXJyeS5aaGFuZ0BhbWQuY29tPgo+IENjOiBz
dGFibGVAdmdlci5rZXJuZWwub3JnCj4KPiA4PC0tLS0tLS0tLS0KPgo+IEFuZCB5b3UnZCBiZXR0
ZXIgc3F1ZWV6ZSB0aGUgdHdvIHBhdGNoZXMgYXMgb25lIChhY3R1YWxseSBpdCdzIG9ubHkgb25l
Cj4gZml4KSB0byBtYWtlIGJhY2twb3J0aW5nIG1vcmUgc21vb3RoLgo+Cj4gVGhhbmtzLAo+IFJ1
aQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
