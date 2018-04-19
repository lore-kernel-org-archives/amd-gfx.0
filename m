From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: enlarge the maximum number of cards
 supported
Date: Thu, 19 Apr 2018 16:24:36 +0200
Message-ID: <c04ac7a4-cd1e-f666-8d24-324f0cfdb9c3@gmail.com>
References: <20180419135049.31988-1-Xiaojie.Yuan@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180419135049.31988-1-Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
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
To: Xiaojie Yuan <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTkuMDQuMjAxOCB1bSAxNTo1MCBzY2hyaWViIFhpYW9qaWUgWXVhbjoKPiAxMjggaXMgdGhl
IG1heGltdW0gbnVtYmVyIG9mIGNhcmRzIHRoYXQgdGhlIGtlcm5lbCBjYW4gc3VwcG9ydAo+IGF0
IHRoZSBtb21lbnQuCj4KPiBDaGFuZ2UtSWQ6IEkxNTViN2IyMTYzNTMwNmQ4ZWNjNDQwYjg1ZmI4
OTU0NTAxYWI1NTk5Cj4gU2lnbmVkLW9mZi1ieTogWGlhb2ppZSBZdWFuIDxYaWFvamllLll1YW5A
YW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+CgpJIGFzc3VtZSB5b3UgZG9uJ3QgaGF2ZSBjb21taXQgcmlnaHRzLCBzbyBJJ20g
Z29pbmcgdG8gcHVzaCB0aGF0IGFueSBtb21lbnQuCgpUaGFua3MsCkNocmlzdGlhbi4KCj4gLS0t
Cj4gICB0ZXN0cy9hbWRncHUvYW1kZ3B1X3Rlc3QuaCB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2Ft
ZGdwdS9hbWRncHVfdGVzdC5oIGIvdGVzdHMvYW1kZ3B1L2FtZGdwdV90ZXN0LmgKPiBpbmRleCA2
Mjg3NTczNi4uZjJlY2UzYzMgMTAwNjQ0Cj4gLS0tIGEvdGVzdHMvYW1kZ3B1L2FtZGdwdV90ZXN0
LmgKPiArKysgYi90ZXN0cy9hbWRncHUvYW1kZ3B1X3Rlc3QuaAo+IEBAIC0zMCw3ICszMCw3IEBA
Cj4gICAvKioKPiAgICAqIERlZmluZSBtYXguIG51bWJlciBvZiBjYXJkIGluIHN5c3RlbSB3aGlj
aCB3ZSBhcmUgYWJsZSB0byBoYW5kbGUKPiAgICAqLwo+IC0jZGVmaW5lIE1BWF9DQVJEU19TVVBQ
T1JURUQgICAgIDQKPiArI2RlZmluZSBNQVhfQ0FSRFNfU1VQUE9SVEVEICAgICAxMjgKPiAgIAo+
ICAgLyogRm9yd2FyZCByZWZlcmVuY2UgZm9yIGFycmF5IHRvIGtlZXAgImRybSIgaGFuZGxlcyAq
Lwo+ICAgZXh0ZXJuIGludCBkcm1fYW1kZ3B1W01BWF9DQVJEU19TVVBQT1JURURdOwoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
