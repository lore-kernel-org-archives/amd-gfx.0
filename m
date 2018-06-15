From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix type of variable
Date: Fri, 15 Jun 2018 12:39:08 -0400
Message-ID: <CADnq5_PeZBRLVYosQ+rmhDa2QdJv3_FEJJ8Xf6sjoJH5rw8zKA@mail.gmail.com>
References: <20180615133228.GA28677@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180615133228.GA28677@embeddedor.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: =?UTF-8?Q?Signed=2Doff=2Dby=40freedesktop=2Eorg=3ARoman_Li_=3CRoman=2ELi=40amd=2Ecom=3E?= =?UTF-8?Q?=2C_Alex_Deucher_=3Calexander=2Edeucher=40amd=2Ecom=3E=2C_Christian_K=C3=B6nig?= =?UTF-8?Q?_=3Cchristian=2Ekoenig=40amd=2Ecom=3E=2C_David_=28ChunMing=29_Zhou_=3CDavid1=2EZ?= =?UTF-8?Q?hou=40amd=2Ecom=3E=2C_David_Airlie?= <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gRnJpLCBKdW4gMTUsIDIwMTggYXQgOTozMiBBTSwgR3VzdGF2byBBLiBSLiBTaWx2YQo8Z3Vz
dGF2b0BlbWJlZGRlZG9yLmNvbT4gd3JvdGU6Cj4gQ3VycmVudGx5LCB0aGUgbWF4aW11bSB2YWx1
ZSB0aGF0ICpjb3VudGVyKiBjYW4gcmVhY2ggaXMgMjU1LCBhbmQKPiBjb2RlIGF0IGxpbmUgMTUw
OiB3aGlsZSAoY291bnRlciA8IDEwMDApIHsgaW1wbGllcyBhIGJpZ2dlciB2YWx1ZQo+IGNvdWxk
IGJlIGV4cGVjdGVkLgo+Cj4gRml4IHRoaXMgYnkgY2hhbmdpbmcgdGhlIHR5cGUgb2YgdmFyaWFi
bGUgKmNvdW50ZXIqIGZyb20gdWludDhfdAo+IHRvIHVpbnQxNl90Lgo+Cj4gQWRkcmVzc2VzLUNv
dmVyaXR5LUlEOiAxNDcwMDMwICgiT3BlcmFuZHMgZG9uJ3QgYWZmZWN0IHJlc3VsdCIpCj4gRml4
ZXM6IDJiNjE5OWExZDFiNyAoImRybS9hbWQvZGlzcGxheTogcmVwbGFjZSBtc2xlZXAgd2l0aCB1
ZGVsYXkgaW4gZmJjIHBhdGgiKQo+IFNpZ25lZC1vZmYtYnk6IEd1c3Rhdm8gQS4gUi4gU2lsdmEg
PGd1c3Rhdm9AZW1iZWRkZWRvci5jb20+CgpBcHBsaWVkLiAgdGhhbmtzIQoKQWxleAoKPiAtLS0K
PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTExMC9kY2UxMTBfY29tcHJlc3Nv
ci5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEw
L2RjZTExMF9jb21wcmVzc29yLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNl
MTEwL2RjZTExMF9jb21wcmVzc29yLmMKPiBpbmRleCBlMjk5NGQzLi4xMTFjNDkyIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX2NvbXBy
ZXNzb3IuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNl
MTEwX2NvbXByZXNzb3IuYwo+IEBAIC0xNDMsNyArMTQzLDcgQEAgc3RhdGljIHZvaWQgd2FpdF9m
b3JfZmJjX3N0YXRlX2NoYW5nZWQoCj4gICAgICAgICBzdHJ1Y3QgZGNlMTEwX2NvbXByZXNzb3Ig
KmNwMTEwLAo+ICAgICAgICAgYm9vbCBlbmFibGVkKQo+ICB7Cj4gLSAgICAgICB1aW50OF90IGNv
dW50ZXIgPSAwOwo+ICsgICAgICAgdWludDE2X3QgY291bnRlciA9IDA7Cj4gICAgICAgICB1aW50
MzJfdCBhZGRyID0gbW1GQkNfU1RBVFVTOwo+ICAgICAgICAgdWludDMyX3QgdmFsdWU7Cj4KPiAt
LQo+IDIuNy40Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRl
dmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
