From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 2/2] drm/amdgpu: Potential uninitialized variable in
 amdgpu_vm_update_directories()
Date: Sat, 30 Sep 2017 11:14:13 +0300
Message-ID: <20170930081413.t6ohq5vrj7pmpthz@mwanda>
References: <20170930081328.kher7yumqzi2vsrg@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20170930081328.kher7yumqzi2vsrg@mwanda>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: kernel-janitors@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>, Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, "Zhang,
 Jerry" <Jerry.Zhang@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

QWZ0ZXIgY29tbWl0IGVhMDk3MjljOTMwMiAoImRybS9hbWRncHU6IHJld29yayBwYWdlIGRpcmVj
dG9yeSBmaWxsaW5nCnYyIikgdGhlbiBpdCBiZWNvbWVzIGEgbG90IGhhcmRlciB0byB2ZXJpZnkg
dGhhdCAiciIgaXMgaW5pdGlhbGl6ZWQuICBNeQpzdGF0aWMgY2hlY2tlciBjb21wbGFpbnMgYW5k
IHNvIEkndmUgcmV2aWV3ZWQgdGhlIGNvZGUuICBJdCBkb2VzIGxvb2sKbGlrZSBpdCBtaWdodCBi
ZSBidWdneS4uLiBBbnl3YXksIGl0IGRvZXNuJ3QgaHVydCB0byBzZXQgInIiIHRvIHplcm8KYXQg
dGhlIHN0YXJ0LgoKU2lnbmVkLW9mZi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBv
cmFjbGUuY29tPgoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKaW5kZXggYmJj
YzY3MDM4MjAzLi5mYjNhZmFiNTU5MDcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92bS5jCkBAIC0xMjQzLDcgKzEyNDMsNyBAQCBzdGF0aWMgdm9pZCBhbWRncHVfdm1faW52YWxp
ZGF0ZV9sZXZlbChzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwKIGludCBhbWRncHVfdm1fdXBkYXRlX2Rp
cmVjdG9yaWVzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQkJCSBzdHJ1Y3QgYW1kZ3B1
X3ZtICp2bSkKIHsKLQlpbnQgcjsKKwlpbnQgciA9IDA7CiAKIAlzcGluX2xvY2soJnZtLT5zdGF0
dXNfbG9jayk7CiAJd2hpbGUgKCFsaXN0X2VtcHR5KCZ2bS0+cmVsb2NhdGVkKSkgewpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGlu
ZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
