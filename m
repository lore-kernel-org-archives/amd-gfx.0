From: James Zhu <jamesz-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/4] drm/amdgpu: Take uvd encode rings into account in
 idle work (v2)
Date: Thu, 17 May 2018 19:53:30 -0400
Message-ID: <48d13d7b-8024-02a9-1d5f-00b3e0f12fb1@amd.com>
References: <20180517223640.23823-1-alexander.deucher@amd.com>
 <20180517223640.23823-3-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180517223640.23823-3-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

ClJldmlld2VkLWJ5OiBKYW1lcyBaaHUgPEphbWVzLlpodUBhbWQuY29tPgoKT24gMjAxOC0wNS0x
NyAwNjozNiBQTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+IFRha2UgdGhlIGVuY29kZSByaW5ncyBp
bnRvIGFjY291bnQgaW4gdGhlIGlkbGUgd29yayBoYW5kbGVyLgo+Cj4gdjI6IGZpeCB0eXBvOiBz
L251bV91dmRfaW5zdC9udW1fZW5jX3JpbmdzLwo+Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5jIHwgNSArKysrLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV91dmQuYwo+IGluZGV4IGJlMjkxN2M2Njk4ZS4uYmNmNjhmODBiYmYwIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYwo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYwo+IEBAIC0xMTQ2LDEwICsxMTQ2
LDEzIEBAIHN0YXRpYyB2b2lkIGFtZGdwdV91dmRfaWRsZV93b3JrX2hhbmRsZXIoc3RydWN0IHdv
cmtfc3RydWN0ICp3b3JrKQo+ICAgewo+ICAgCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0K
PiAgIAkJY29udGFpbmVyX29mKHdvcmssIHN0cnVjdCBhbWRncHVfZGV2aWNlLCB1dmQuaW5zdC0+
aWRsZV93b3JrLndvcmspOwo+IC0JdW5zaWduZWQgZmVuY2VzID0gMCwgaTsKPiArCXVuc2lnbmVk
IGZlbmNlcyA9IDAsIGksIGo7Cj4gICAKPiAgIAlmb3IgKGkgPSAwOyBpIDwgYWRldi0+dXZkLm51
bV91dmRfaW5zdDsgKytpKSB7Cj4gICAJCWZlbmNlcyArPSBhbWRncHVfZmVuY2VfY291bnRfZW1p
dHRlZCgmYWRldi0+dXZkLmluc3RbaV0ucmluZyk7Cj4gKwkJZm9yIChqID0gMDsgaiA8IGFkZXYt
PnV2ZC5udW1fZW5jX3JpbmdzOyArK2opIHsKPiArCQkJZmVuY2VzICs9IGFtZGdwdV9mZW5jZV9j
b3VudF9lbWl0dGVkKCZhZGV2LT51dmQuaW5zdFtpXS5yaW5nX2VuY1tqXSk7Cj4gKwkJfQo+ICAg
CX0KPiAgIAo+ICAgCWlmIChmZW5jZXMgPT0gMCkgewoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
