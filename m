From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 10/22] drm/amdgpu: no need to count emitted for SRIOV
Date: Mon, 26 Feb 2018 11:09:03 +0100
Message-ID: <994af188-1283-44ea-f868-73f4002a7cb3@gmail.com>
References: <1519622300-8990-1-git-send-email-Monk.Liu@amd.com>
 <1519622300-8990-11-git-send-email-Monk.Liu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1519622300-8990-11-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
To: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

SSB3b3VsZCByYXRoZXIgYXZvaWQgY2FsbGluZyB0aGUgZnVuY3Rpb24gaW4gdGhlIGZpcnN0IHBs
YWNlLgoKQ2hyaXN0aWFuLgoKQW0gMjYuMDIuMjAxOCB1bSAwNjoxOCBzY2hyaWViIE1vbmsgTGl1
Ogo+IENoYW5nZS1JZDogSTM3MDk2NmFjZDBmMTkyNWE5OWRmZGU4ODg2NzhlNmUwZmQwOTNiMTUK
PiBTaWduZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KPiAtLS0KPiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYyB8IDQgKysrLQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYwo+IGluZGV4IDMzN2RiNTcuLjVmYjQzNTcgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5jCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5jCj4gQEAgLTExMTcsMTEgKzEx
MTcsMTMgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3V2ZF9pZGxlX3dvcmtfaGFuZGxlcihzdHJ1Y3Qg
d29ya19zdHJ1Y3QgKndvcmspCj4gICB7Cj4gICAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYg
PQo+ICAgCQljb250YWluZXJfb2Yod29yaywgc3RydWN0IGFtZGdwdV9kZXZpY2UsIHV2ZC5pZGxl
X3dvcmsud29yayk7Cj4gLQl1bnNpZ25lZCBmZW5jZXMgPSBhbWRncHVfZmVuY2VfY291bnRfZW1p
dHRlZCgmYWRldi0+dXZkLnJpbmcpOwo+ICsJdW5zaWduZWQgZmVuY2VzOwo+ICAgCj4gICAJaWYg
KGFtZGdwdV9zcmlvdl92ZihhZGV2KSkKPiAgIAkJQlVHKCk7Cj4gICAKPiArCWZlbmNlcyA9IGFt
ZGdwdV9mZW5jZV9jb3VudF9lbWl0dGVkKCZhZGV2LT51dmQucmluZyk7Cj4gKwo+ICAgCWlmIChm
ZW5jZXMgPT0gMCkgewo+ICAgCQlpZiAoYWRldi0+cG0uZHBtX2VuYWJsZWQpIHsKPiAgIAkJCWFt
ZGdwdV9kcG1fZW5hYmxlX3V2ZChhZGV2LCBmYWxzZSk7CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
