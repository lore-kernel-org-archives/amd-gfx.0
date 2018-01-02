From: Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/gfx9: only init the apertures used by KGD
Date: Tue, 2 Jan 2018 10:47:48 +0800
Message-ID: <297ee629-c2a5-236b-00ab-dfe393850cb6@amd.com>
References: <20180101211725.9404-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180101211725.9404-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

UmV2aWV3ZWQtYnk6IENodW5taW5nIFpob3UgPGRhdmlkMS56aG91QGFtZC5jb20+CgoKT24gMjAx
OOW5tDAx5pyIMDLml6UgMDU6MTcsIEFsZXggRGV1Y2hlciB3cm90ZToKPiBVc2UgYWRldi0+dm1f
bWFuYWdlci5pZF9tZ3JbMF0ubnVtX2lkcyByYXRoZXIgdGhhbiBoYXJkY29kZWQgMTYuCj4KPiBO
b3RpY2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8ZmVsaXgua3VlaGxpbmdAYW1kLmNvbT4KPiBTaWdu
ZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gLS0t
Cj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIHwgMiArLQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKPiBpbmRleCA1NTY3MGRiYWNhY2UuLjRhYmFmODAyYTI2
MCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwo+IEBAIC0xNTI2LDcg
KzE1MjYsNyBAQCBzdGF0aWMgdm9pZCBnZnhfdjlfMF9ncHVfaW5pdChzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikKPiAgIAkvKiBYWFggU0hfTUVNIHJlZ3MgKi8KPiAgIAkvKiB3aGVyZSB0byBw
dXQgTERTLCBzY3JhdGNoLCBHUFVWTSBpbiBGU0E2NCBzcGFjZSAqLwo+ICAgCW11dGV4X2xvY2so
JmFkZXYtPnNyYm1fbXV0ZXgpOwo+IC0JZm9yIChpID0gMDsgaSA8IDE2OyBpKyspIHsKPiArCWZv
ciAoaSA9IDA7IGkgPCBhZGV2LT52bV9tYW5hZ2VyLmlkX21nclswXS5udW1faWRzOyBpKyspIHsK
PiAgIAkJc29jMTVfZ3JibV9zZWxlY3QoYWRldiwgMCwgMCwgMCwgaSk7Cj4gICAJCS8qIENQIGFu
ZCBzaGFkZXJzICovCj4gICAJCWlmIChpID09IDApIHsKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
