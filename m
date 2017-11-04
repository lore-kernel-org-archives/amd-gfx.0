From: walter harms <wharms@bfs.de>
Subject: Re: [PATCH] drm/amd/display: indent an if statement
Date: Sat, 04 Nov 2017 10:16:23 +0100
Message-ID: <59FD8567.4030500@bfs.de>
References: <20171104061232.5bq5hwr2p2ca2cl7@mwanda>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20171104061232.5bq5hwr2p2ca2cl7@mwanda>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Hersen Wu <hersenxs.wu@amd.com>, dri-devel@lists.freedesktop.org, Yue Hin Lau <Yuehin.Lau@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Tony Cheng <tony.cheng@amd.com>, =?ISO-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

CgpBbSAwNC4xMS4yMDE3IDA3OjEyLCBzY2hyaWViIERhbiBDYXJwZW50ZXI6Cj4gVGhlIGlmIHN0
YXRlbWVudCB3YXNuJ3QgaW5kZW50ZWQgc28gaXQgbWFrZXMgc3RhdGljIGFuYWx5c2lzIHRvb2xz
IGFuZAo+IHByb2JhYmx5IHZlcnkgcmVjZW50IEdDQyB2ZXJzaW9ucyBjb21wbGFpbi4KPiAKPiBT
aWduZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+Cj4g
LS0tCj4gSSB3ZW50IG92ZXIgODAgY2hhcmFjdGVycyBiZWNhdXNlIG90aGVyIGxpbmVzIGRvIGFs
cmVhZHkgYW5kIGl0IHNlZW1lZAo+IGxpa2UgdGhlIGNsZWFuZXN0IHRoaW5nIGhlcmUuCj4gCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9y
ZXNvdXJjZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX3Jl
c291cmNlLmMKPiBpbmRleCBkOTExNTkwZDA4YmMuLmM4M2FjNGQ5Y2EzYSAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBfcmVzb3VyY2UuYwo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9yZXNvdXJj
ZS5jCj4gQEAgLTcyNyw3ICs3MjcsNyBAQCBzdGF0aWMgdm9pZCBkZXN0cnVjdChzdHJ1Y3QgZGNu
MTBfcmVzb3VyY2VfcG9vbCAqcG9vbCkKPiAgCj4gIAlmb3IgKGkgPSAwOyBpIDwgcG9vbC0+YmFz
ZS5zdHJlYW1fZW5jX2NvdW50OyBpKyspIHsKPiAgCQlpZiAocG9vbC0+YmFzZS5zdHJlYW1fZW5j
W2ldICE9IE5VTEwpCj4gLQkJa2ZyZWUoRENFMTEwU1RSRU5DX0ZST01fU1RSRU5DKHBvb2wtPmJh
c2Uuc3RyZWFtX2VuY1tpXSkpOwo+ICsJCQlrZnJlZShEQ0UxMTBTVFJFTkNfRlJPTV9TVFJFTkMo
cG9vbC0+YmFzZS5zdHJlYW1fZW5jW2ldKSk7Cj4gIAl9Cj4gIAoKSXMgdGhhdCAiaWYgKHBvb2wt
PmJhc2Uuc3RyZWFtX2VuY1tpXSAhPSBOVUxMKSIgbmVlZGVkIGF0IGFsbCA/CmtmcmVlKCkgc2hv
dWxkIGhhcHBpbHkgaGFuZGxlIE5VTEwuCgpyZSwKIHdoCgoKCj4gIAlmb3IgKGkgPSAwOyBpIDwg
cG9vbC0+YmFzZS5hdWRpb19jb3VudDsgaSsrKSB7Cj4gLS0KPiBUbyB1bnN1YnNjcmliZSBmcm9t
IHRoaXMgbGlzdDogc2VuZCB0aGUgbGluZSAidW5zdWJzY3JpYmUga2VybmVsLWphbml0b3JzIiBp
bgo+IHRoZSBib2R5IG9mIGEgbWVzc2FnZSB0byBtYWpvcmRvbW9Admdlci5rZXJuZWwub3JnCj4g
TW9yZSBtYWpvcmRvbW8gaW5mbyBhdCAgaHR0cDovL3ZnZXIua2VybmVsLm9yZy9tYWpvcmRvbW8t
aW5mby5odG1sCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZl
bAo=
