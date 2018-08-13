From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: add AVFS control to PP_FEATURE_MASK
Date: Mon, 13 Aug 2018 14:44:18 +0800
Message-ID: <20180813064417.GA32351@hr-amur2>
References: <20180810182454.15236-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180810182454.15236-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gRnJpLCBBdWcgMTAsIDIwMTggYXQgMDE6MjQ6NTJQTSAtMDUwMCwgQWxleCBEZXVjaGVyIHdy
b3RlOgo+IEFkZCBhIHBwZmVhdHVyZW1hc2sgZmxhZyB0byBkaXNhYmxlIEFWRlMgY29udHJvbC4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CgpTZXJpZXMgYXJlIFJldmlld2VkLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29t
PgoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9zaGFyZWQuaCB8IDEg
Kwo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9zaGFyZWQuaCBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvaW5jbHVkZS9hbWRfc2hhcmVkLmgKPiBpbmRleCAyNjU2MjFkODk0NWMuLjg2YjE2N2VjOTg2
MyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYW1kX3NoYXJlZC5o
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9zaGFyZWQuaAo+IEBAIC0x
MjksNiArMTI5LDcgQEAgZW51bSBQUF9GRUFUVVJFX01BU0sgewo+ICAJUFBfR0ZYT0ZGX01BU0sg
PSAweDgwMDAsCj4gIAlQUF9BQ0dfTUFTSyA9IDB4MTAwMDAsCj4gIAlQUF9TVFVUVEVSX01PREUg
PSAweDIwMDAwLAo+ICsJUFBfQVZGU19NQVNLID0gMHg0MDAwMCwKPiAgfTsKPiAgCj4gIC8qKgo+
IC0tIAo+IDIuMTMuNgo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
