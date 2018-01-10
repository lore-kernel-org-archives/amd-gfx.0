From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix 64bit BAR detection
Date: Wed, 10 Jan 2018 16:04:11 +0100
Message-ID: <f774bb5f-1e25-a5f3-0ec0-cbb4f61d5cf6@gmail.com>
References: <20180108135147.41819-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180108135147.41819-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

UGluZz8gQWxleCwgRGF2aWQsIGFueWJvZHk/CgpBbSAwOC4wMS4yMDE4IHVtIDE0OjUxIHNjaHJp
ZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPiBXaW5kb3dzIGFkZGVkIGJ5IHRoZSBCSU9TIGFyZSBub3Qg
bWFya2VkIGFzIDY0Yml0IGJlY2F1c2UgdGhleSBhcmUKPiB1c3VhbGx5IG5vdCBjaGFuZ2VhYmxl
IGFueXdheS4KPgo+IFRoaXMgZml4ZXMgbGFyZ2UgQkFSIHN1cHBvcnQgb24gbXkgbmV3IFJ5emVu
IGJ1aWxkIHN5c3RlbS4KPgo+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYwo+IGluZGV4IGU5MTU3NTMxMTY0Ni4uNzExNGYyNTI3ZWRjIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+IEBAIC02MjYsNyArNjI2LDcg
QEAgaW50IGFtZGdwdV9kZXZpY2VfcmVzaXplX2ZiX2JhcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKPiAgIAkJcm9vdCA9IHJvb3QtPnBhcmVudDsKPiAgIAo+ICAgCXBjaV9idXNfZm9yX2Vh
Y2hfcmVzb3VyY2Uocm9vdCwgcmVzLCBpKSB7Cj4gLQkJaWYgKHJlcyAmJiByZXMtPmZsYWdzICYg
SU9SRVNPVVJDRV9NRU1fNjQgJiYKPiArCQlpZiAocmVzICYmIHJlcy0+ZmxhZ3MgJiAoSU9SRVNP
VVJDRV9NRU0gfCBJT1JFU09VUkNFX01FTV82NCkgJiYKPiAgIAkJICAgIHJlcy0+c3RhcnQgPiAw
eDEwMDAwMDAwMHVsbCkKPiAgIAkJCWJyZWFrOwo+ICAgCX0KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
