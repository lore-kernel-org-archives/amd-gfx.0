From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix typo in amdgpu_vmid_mgr_init
Date: Fri, 12 Oct 2018 16:44:57 +0200
Message-ID: <4eb8c56e-b535-2d61-7725-9c2d2ae11341@gmail.com>
References: <1539355291-17917-1-git-send-email-Rex.Zhu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1539355291-17917-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTIuMTAuMjAxOCB1bSAxNjo0MSBzY2hyaWViIFJleCBaaHU6Cj4gU2lnbmVkLW9mZi1ieTog
UmV4IFpodSA8UmV4LlpodUBhbWQuY29tPgoKR29vZCBjYXRjaCwgYnV0IHdlIG5lZWQgYSBjb21t
aXQgbWVzc2FnZS4KCldpdGggdGhhdCBhZGRlZCB0aGUgcGF0Y2ggaXMgUmV2aWV3ZWQtYnk6IENo
cmlzdGlhbiBLw7ZuaWcgCjxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+LgoKQ2hyaXN0aWFuLgoK
PiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMuYyB8IDIgKy0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMuYwo+IGluZGV4IDNhMDcyYTcuLmRmOWIx
NzMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lkcy5j
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lkcy5jCj4gQEAgLTU3
NCw3ICs1NzQsNyBAQCB2b2lkIGFtZGdwdV92bWlkX21ncl9pbml0KHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KQo+ICAgCQkvKiBza2lwIG92ZXIgVk1JRCAwLCBzaW5jZSBpdCBpcyB0aGUgc3lz
dGVtIFZNICovCj4gICAJCWZvciAoaiA9IDE7IGogPCBpZF9tZ3ItPm51bV9pZHM7ICsraikgewo+
ICAgCQkJYW1kZ3B1X3ZtaWRfcmVzZXQoYWRldiwgaSwgaik7Cj4gLQkJCWFtZGdwdV9zeW5jX2Ny
ZWF0ZSgmaWRfbWdyLT5pZHNbaV0uYWN0aXZlKTsKPiArCQkJYW1kZ3B1X3N5bmNfY3JlYXRlKCZp
ZF9tZ3ItPmlkc1tqXS5hY3RpdmUpOwo+ICAgCQkJbGlzdF9hZGRfdGFpbCgmaWRfbWdyLT5pZHNb
al0ubGlzdCwgJmlkX21nci0+aWRzX2xydSk7Cj4gICAJCX0KPiAgIAl9CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
