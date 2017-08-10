From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] drm/amdgpu: Uninitialized variable in
 amdgpu_ttm_backend_bind()
Date: Thu, 10 Aug 2017 11:16:48 +0900
Message-ID: <406505cd-fd17-b87a-0d3f-9adf5376880a@daenzer.net>
References: <20170809103046.mhj7mhe3qwy5ozvy@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170809103046.mhj7mhe3qwy5ozvy@mwanda>
Content-Language: en-CA
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Dan Carpenter <dan.carpenter@oracle.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Flora Cui <Flora.Cui@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gMDkvMDgvMTcgMDc6MzAgUE0sIERhbiBDYXJwZW50ZXIgd3JvdGU6Cj4gTXkgc3RhdGljIGNo
ZWNrZXIgY29tcGxhaW5zIHRoYXQgaXQncyBwb3NzaWJsZSBmb3IgInIiIHRvIGJlCj4gdW5pbml0
aWFsaXplZC4gIEl0IHVzZWQgdG8gYmUgc2V0IHRvIHplcm8gc28gdGhpcyByZXR1cm5zIGl0IHRv
IHRoZSBvbGQKPiBiZWhhdmlvci4KPiAKPiBGaXhlczogOThhN2Y4OGNlOWE5ICgiZHJtL2FtZGdw
dTogYmluZCBCT3Mgd2l0aCBHVFQgc3BhY2UgYWxsb2NhdGVkIGRpcmVjdGx5IHYyIikKPiBTaWdu
ZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+Cj4gCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+IGluZGV4IGU2ZjlhNTRjOTU5
ZC4uYjVmMmEwODc1N2Q2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV90dG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90
dG0uYwo+IEBAIC03NTMsNyArNzUzLDcgQEAgc3RhdGljIGludCBhbWRncHVfdHRtX2JhY2tlbmRf
YmluZChzdHJ1Y3QgdHRtX3R0ICp0dG0sCj4gIAkJCQkgICBzdHJ1Y3QgdHRtX21lbV9yZWcgKmJv
X21lbSkKPiAgewo+ICAJc3RydWN0IGFtZGdwdV90dG1fdHQgKmd0dCA9ICh2b2lkKil0dG07Cj4g
LQlpbnQgcjsKPiArCWludCByID0gMDsKPiAgCj4gIAlpZiAoZ3R0LT51c2VycHRyKSB7Cj4gIAkJ
ciA9IGFtZGdwdV90dG1fdHRfcGluX3VzZXJwdHIodHRtKTsKClJldmlld2VkLWJ5OiBNaWNoZWwg
RMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBE
w6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpM
aWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBh
bmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRl
dmVsCg==
