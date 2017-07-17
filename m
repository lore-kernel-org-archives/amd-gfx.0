From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: read reg in each iterate of psp_wait_for loop
Date: Mon, 17 Jul 2017 19:45:12 +0800
Message-ID: <20170717114511.GA18478@hr-amur2>
References: <1500027617-18557-1-git-send-email-Jerry.Zhang@amd.com>
 <20170717075209.GA16630@hr-amur2> <20170717075755.GB16630@hr-amur2>
 <596C7BBA.2010300@amd.com> <20170717105741.GC32372@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170717105741.GC32372-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
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
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>, "stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gTW9uLCBKdWwgMTcsIDIwMTcgYXQgMDY6NTc6NDFQTSArMDgwMCwgR3JlZyBLSCB3cm90ZToK
PiBPbiBNb24sIEp1bCAxNywgMjAxNyBhdCAwNDo1NjoyNlBNICswODAwLCBaaGFuZywgSmVycnkg
KEp1bndlaSkgd3JvdGU6Cj4gPiArIHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPiAKPiA8Zm9ybWxl
dHRlcj4KPiAKPiBUaGlzIGlzIG5vdCB0aGUgY29ycmVjdCB3YXkgdG8gc3VibWl0IHBhdGNoZXMg
Zm9yIGluY2x1c2lvbiBpbiB0aGUKPiBzdGFibGUga2VybmVsIHRyZWUuICBQbGVhc2UgcmVhZDoK
PiAgICAgaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvcHJvY2Vzcy9zdGFi
bGUta2VybmVsLXJ1bGVzLmh0bWwKPiBmb3IgaG93IHRvIGRvIHRoaXMgcHJvcGVybHkuCj4gCj4g
PC9mb3JtbGV0dGVyPgoKVGhhbmtzLCBHcmVnLiA6LSkKCj4+IEJUVzogcGxlYXNlIGFkZCBDYzog
PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+IGluIHlvdXIgcGF0Y2gsIGl0IG5lZWQgYmUKPj4gYmFj
a3BvcnRlZCB0byBzdGFibGUgdHJlZS4KCkplcnJ5LCBJIG1pZ2h0IG5vdCBkZXNjcmliZSBpdCBj
bGVhcmx5LiBXZSBuZWVkIGZvbGxvdyB0aGUgcnVsZSB0aGF0IEdyZWcKcHJvdmlkZWQuIEFjdHVh
bGx5LCBJIG1lYW50IHRvIGFkZCBDYyBpbiB5b3VyIGNvbW1pdCBtZXNzYWdlIGxpa2UgYmVsb3cs
CnRoZW4gc2VudCBpdCBvdXQ6Cgo4PC0tLS0tLS0tLS0KClN1YmplY3Q6IFtQQVRDSF0gZHJtL2Ft
ZGdwdTogcmVhZCByZWcgaW4gZWFjaCBpdGVyYXRlIG9mIHBzcF93YWl0X2ZvciBsb29wCgpUaGlz
IGZpeGVzIHRoZSBTT1MgbG9hZGluZyBmYWlsdXJlIG9mIHBzcCB2My4xLgoKU2lnbmVkLW9mZi1i
eTogSnVud2VpIFpoYW5nIDxKZXJyeS5aaGFuZ0BhbWQuY29tPgpDYzogc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZwoKODwtLS0tLS0tLS0tCgpBbmQgeW91J2QgYmV0dGVyIHNxdWVlemUgdGhlIHR3byBw
YXRjaGVzIGFzIG9uZSAoYWN0dWFsbHkgaXQncyBvbmx5IG9uZQpmaXgpIHRvIG1ha2UgYmFja3Bv
cnRpbmcgbW9yZSBzbW9vdGguCgpUaGFua3MsClJ1aQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
