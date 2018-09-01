From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: When couldn't find bo, need to return
 error.
Date: Sat, 1 Sep 2018 10:17:25 +0200
Message-ID: <aabe391a-d6d5-564f-1e0d-b2fb218bdeae@gmail.com>
References: <1535775863-27689-1-git-send-email-Emily.Deng@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1535775863-27689-1-git-send-email-Emily.Deng-5C7GfCeVMHo@public.gmane.org>
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
To: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMDEuMDkuMjAxOCB1bSAwNjoyNCBzY2hyaWViIEVtaWx5IERlbmc6Cj4gVGhlIHN0YXJ0eCB3
aWxsIGhhdmUgc2VnbWFudCBmYXVsdCBpZiByZXR1cm4gc3VjY2Vzcy4KPgo+IFNXREVWLTE2Mzk2
Mgo+Cj4gQ2hhbmdlLUlkOiBJNTZiMTg5ZmEyNmVmZGNkMWQ5NmU1MTAwYWYzZjNlMGIxMjA4YjBj
Mwo+IFNpZ25lZC1vZmYtYnk6IEVtaWx5IERlbmcgPEVtaWx5LkRlbmdAYW1kLmNvbT4KCkplcnJ5
IGFscmVhZHkgc2VuZCBhIG11Y2ggYmV0dGVyIHBhdGNoIGZvciB0aGlzLgoKPiAtLS0KPiAgIGFt
ZGdwdS9hbWRncHVfYm8uYyB8IDQgKysrLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2FtZGdwdS9hbWRncHVfYm8uYyBi
L2FtZGdwdS9hbWRncHVfYm8uYwo+IGluZGV4IGYyNWNhY2MuLjdlMjk3ZmEgMTAwNjQ0Cj4gLS0t
IGEvYW1kZ3B1L2FtZGdwdV9iby5jCj4gKysrIGIvYW1kZ3B1L2FtZGdwdV9iby5jCj4gQEAgLTc2
MCw2ICs3NjAsNyBAQCBpbnQgYW1kZ3B1X2ZpbmRfYm9fYnlfY3B1X21hcHBpbmcoYW1kZ3B1X2Rl
dmljZV9oYW5kbGUgZGV2LAo+ICAgCQkJCSAgdWludDY0X3QgKm9mZnNldF9pbl9ibykKPiAgIHsK
PiAgIAl1aW50MzJfdCBpOwo+ICsJaW50IHIgPSAwOwo+ICAgCXN0cnVjdCBhbWRncHVfYm8gKmJv
Owo+ICAgCj4gICAJaWYgKGNwdSA9PSBOVUxMIHx8IHNpemUgPT0gMCkKPiBAQCAtNzg3LDEwICs3
ODgsMTEgQEAgaW50IGFtZGdwdV9maW5kX2JvX2J5X2NwdV9tYXBwaW5nKGFtZGdwdV9kZXZpY2Vf
aGFuZGxlIGRldiwKPiAgIAl9IGVsc2Ugewo+ICAgCQkqYnVmX2hhbmRsZSA9IE5VTEw7Cj4gICAJ
CSpvZmZzZXRfaW5fYm8gPSAwOwo+ICsJCXIgPSAtZXJybm87CgplcnJubyBkb2Vzbid0IGNvbnRh
aW4gYW55IGVycm9yIGluIHRoaXMgY2FzZS4KCj4gICAJfQo+ICAgCXB0aHJlYWRfbXV0ZXhfdW5s
b2NrKCZkZXYtPmJvX3RhYmxlX211dGV4KTsKPiAgIAo+IC0JcmV0dXJuIDA7Cj4gKwlyZXR1cm4g
cjsKPiAgIH0KPiAgIAo+ICAgaW50IGFtZGdwdV9jcmVhdGVfYm9fZnJvbV91c2VyX21lbShhbWRn
cHVfZGV2aWNlX2hhbmRsZSBkZXYsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
