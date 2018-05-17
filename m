From: James Zhu <jamesz-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/4] drm/amdgpu: count fences from all uvd instances in
 idle handler
Date: Thu, 17 May 2018 19:53:02 -0400
Message-ID: <518f4cfb-7ba6-f6d3-d537-84a75e083358@amd.com>
References: <20180517223640.23823-1-alexander.deucher@amd.com>
 <20180517223640.23823-2-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180517223640.23823-2-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

UmV2aWV3ZWQtYnk6IEphbWVzIFpodSA8SmFtZXMuWmh1QGFtZC5jb20+CgoKT24gMjAxOC0wNS0x
NyAwNjozNiBQTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+IEN1cnJlbnQgbXVsdGktVVZEIGhhcmR3
YXJlIHVzZXMgYSBzaW5nbGUgY2xvY2sgYW5kIHBvd2VyIHNvdXJjZQo+IHNvIGhhbmRsZSBhbGwg
aW5zdGFuY2VzIGluIHRoZSBpZGxlIGhhbmRsZXIuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmMgfCA2ICsrKysrLQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV91dmQuYwo+IGluZGV4IDA3NzI2ODAzNzFhMS4uYmUyOTE3YzY2OThlIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYwo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYwo+IEBAIC0xMTQ2LDcgKzEx
NDYsMTEgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3V2ZF9pZGxlX3dvcmtfaGFuZGxlcihzdHJ1Y3Qg
d29ya19zdHJ1Y3QgKndvcmspCj4gICB7Cj4gICAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYg
PQo+ICAgCQljb250YWluZXJfb2Yod29yaywgc3RydWN0IGFtZGdwdV9kZXZpY2UsIHV2ZC5pbnN0
LT5pZGxlX3dvcmsud29yayk7Cj4gLQl1bnNpZ25lZCBmZW5jZXMgPSBhbWRncHVfZmVuY2VfY291
bnRfZW1pdHRlZCgmYWRldi0+dXZkLmluc3QtPnJpbmcpOwo+ICsJdW5zaWduZWQgZmVuY2VzID0g
MCwgaTsKPiArCj4gKwlmb3IgKGkgPSAwOyBpIDwgYWRldi0+dXZkLm51bV91dmRfaW5zdDsgKytp
KSB7Cj4gKwkJZmVuY2VzICs9IGFtZGdwdV9mZW5jZV9jb3VudF9lbWl0dGVkKCZhZGV2LT51dmQu
aW5zdFtpXS5yaW5nKTsKPiArCX0KPiAgIAo+ICAgCWlmIChmZW5jZXMgPT0gMCkgewo+ICAgCQlp
ZiAoYWRldi0+cG0uZHBtX2VuYWJsZWQpIHsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
