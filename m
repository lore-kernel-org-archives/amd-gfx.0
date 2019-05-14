From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/sriov: Need to initialize the
 HDP_NONSURFACE_BAStE
Date: Tue, 14 May 2019 12:33:36 +0200
Message-ID: <8cca3031-e258-785c-331c-6c6d32421ed0@gmail.com>
References: <1557829492-5991-1-git-send-email-Tiecheng.Zhou@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1557829492-5991-1-git-send-email-Tiecheng.Zhou-5C7GfCeVMHo@public.gmane.org>
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
To: Tiecheng Zhou <Tiecheng.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>

QW0gMTQuMDUuMTkgdW0gMTI6MjQgc2NocmllYiBUaWVjaGVuZyBaaG91Ogo+IGl0IHJlcXVpcmVz
IHRvIGluaXRpYWxpemUgSERQX05PTlNVUkZBQ0VfQkFTRSwgc28gYXMgdG8gYXZvaWQKPiB1c2lu
ZyB0aGUgdmFsdWUgbGVmdCBieSBhIHByZXZpb3VzIFZNIHVuZGVyIHNyaW92IHNjZW5hcmlvLgo+
Cj4gU2lnbmVkLW9mZi1ieTogRW1pbHkgRGVuZyA8RW1pbHkuRGVuZ0BhbWQuY29tPgo+IFNpZ25l
ZC1vZmYtYnk6IFRpZWNoZW5nIFpob3UgPFRpZWNoZW5nLlpob3VAYW1kLmNvbT4KCldvdWxkIGl0
IGh1cnQgdXMgdG8gYWxzbyBkbyB0aGlzIG9uIGJhcmUgbWV0YWw/CgpBcGFydCBmcm9tIHRoYXQg
bG9va3MgZ29vZCB0byBtZSwKQ2hyaXN0aWFuLgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dtY192OV8wLmMgfCA1ICsrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21j
X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPiBpbmRleCBi
ZTcyOWU3Li5lOTY2ODRlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dtY192OV8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5j
Cj4gQEAgLTExODEsNiArMTE4MSwxMSBAQCBzdGF0aWMgaW50IGdtY192OV8wX2dhcnRfZW5hYmxl
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgCXRtcCA9IFJSRUczMl9TT0MxNShIRFAs
IDAsIG1tSERQX0hPU1RfUEFUSF9DTlRMKTsKPiAgIAlXUkVHMzJfU09DMTUoSERQLCAwLCBtbUhE
UF9IT1NUX1BBVEhfQ05UTCwgdG1wKTsKPiAgIAo+ICsJaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2
KSkgewo+ICsJCVdSRUczMl9TT0MxNShIRFAsIDAsIG1tSERQX05PTlNVUkZBQ0VfQkFTRSwgKGFk
ZXYtPmdtYy52cmFtX3N0YXJ0ID4+IDgpKTsKPiArCQlXUkVHMzJfU09DMTUoSERQLCAwLCBtbUhE
UF9OT05TVVJGQUNFX0JBU0VfSEksIChhZGV2LT5nbWMudnJhbV9zdGFydCA+PiA0MCkpOwo+ICsJ
fQo+ICsKPiAgIAkvKiBBZnRlciBIRFAgaXMgaW5pdGlhbGl6ZWQsIGZsdXNoIEhEUC4qLwo+ICAg
CWFkZXYtPm5iaW9fZnVuY3MtPmhkcF9mbHVzaChhZGV2LCBOVUxMKTsKPiAgIAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
