From: "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: disable coarse grain clockgating for ST
Date: Thu, 25 Jan 2018 04:32:56 +0000
Message-ID: <BN6PR12MB182641C9629DD1AEADBD3188F2E10@BN6PR12MB1826.namprd12.prod.outlook.com>
References: <1516854622-9227-1-git-send-email-shirish.s12@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1516854622-9227-1-git-send-email-shirish.s12-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

CkZyb206IFNoaXJpc2ggUyA8c2hpcmlzaC5zQGFtZC5jb20+CgpUaGUgQ0dDRyBmZWF0dXJlIG9u
IFN0b25leSBpcyBjYXVzaW5nIEdGWCByZWxhdGVkIGlzc3VlcyBzdWNoIGFzIGZyZWV6ZXMKYW5k
IGJsYW5rIG91dHMuCgpTaWduZWQtb2ZmLWJ5OiBTaGlyaXNoIFMgPHNoaXJpc2guc0BhbWQuY29t
PgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmMgfCAxIC0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdmkuYwpiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmMgaW5kZXggM2I2NmUxYS4u
ZWJmYWM2NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmkuYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92aS5jCkBAIC0xMDQ1LDcgKzEwNDUsNiBAQCBz
dGF0aWMgaW50IHZpX2NvbW1vbl9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkKIAkJCUFNRF9DR19T
VVBQT1JUX0dGWF9DUF9MUyB8CiAJCQlBTURfQ0dfU1VQUE9SVF9HRlhfQ0dUUyB8CiAJCQlBTURf
Q0dfU1VQUE9SVF9HRlhfQ0dUU19MUyB8Ci0JCQlBTURfQ0dfU1VQUE9SVF9HRlhfQ0dDRyB8CiAJ
CQlBTURfQ0dfU1VQUE9SVF9HRlhfQ0dMUyB8CiAJCQlBTURfQ0dfU1VQUE9SVF9CSUZfTFMgfAog
CQkJQU1EX0NHX1NVUFBPUlRfSERQX01HQ0cgfAotLQoyLjcuNAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
