From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH hmm 02/15] mm/mmu_notifier: add an interval tree notifier
Date: Sun, 27 Oct 2019 20:15:37 -0300
Message-ID: <20191027231537.GA25385@ziepe.ca>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <20191015181242.8343-3-jgg@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20191015181242.8343-3-jgg@ziepe.ca>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jerome Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc: Andrea Arcangeli <aarcange@redhat.com>, linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlLCBPY3QgMTUsIDIwMTkgYXQgMDM6MTI6MjlQTSAtMDMwMCwgSmFzb24gR3VudGhvcnBl
IHdyb3RlOgoKPiArc3RhdGljIHZvaWQgbW5faXRyZWVfcmVsZWFzZShzdHJ1Y3QgbW11X25vdGlm
aWVyX21tICptbW5fbW0sCj4gKwkJCSAgICAgc3RydWN0IG1tX3N0cnVjdCAqbW0pCj4gK3sKPiAr
CXN0cnVjdCBtbXVfbm90aWZpZXJfcmFuZ2UgcmFuZ2UgPSB7Cj4gKwkJLmZsYWdzID0gTU1VX05P
VElGSUVSX1JBTkdFX0JMT0NLQUJMRSwKPiArCQkuZXZlbnQgPSBNTVVfTk9USUZZX1JFTEVBU0Us
Cj4gKwkJLm1tID0gbW0sCj4gKwkJLnN0YXJ0ID0gMCwKPiArCQkuZW5kID0gVUxPTkdfTUFYLAo+
ICsJfTsKPiArCXN0cnVjdCBtbXVfcmFuZ2Vfbm90aWZpZXIgKm1ybjsKPiArCXVuc2lnbmVkIGxv
bmcgY3VyX3NlcTsKPiArCWJvb2wgcmV0Owo+ICsKPiArCWZvciAobXJuID0gbW5faXRyZWVfaW52
X3N0YXJ0X3JhbmdlKG1tbl9tbSwgJnJhbmdlLCAmY3VyX3NlcSk7IG1ybjsKPiArCSAgICAgbXJu
ID0gbW5faXRyZWVfaW52X25leHQobXJuLCAmcmFuZ2UpKSB7Cj4gKwkJcmV0ID0gbXJuLT5vcHMt
PmludmFsaWRhdGUobXJuLCAmcmFuZ2UpOwo+ICsJCVdBUk5fT04ocmV0KTsKClRoaXMgc2hvdWxk
IGJlIAogIFdBUk5fT04oIXJldCkKCkphc29uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2RyaS1kZXZlbA==
