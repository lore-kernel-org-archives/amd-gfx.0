From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix re-program vm invalidate eng address
 range for gfxhub on resume
Date: Wed, 17 May 2017 10:16:31 +0200
Message-ID: <73fa42d9-1994-83ed-db9f-7c601f8a4598@amd.com>
References: <1495006729-17310-1-git-send-email-ray.huang@amd.com>
 <591BFF33.2010303@amd.com> <20170517075557.GA31947@hr-amur2>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170517075557.GA31947@hr-amur2>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Huan, Alvin" <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMTcuMDUuMjAxNyB1bSAwOTo1NSBzY2hyaWViIEh1YW5nIFJ1aToKPiBPbiBXZWQsIE1heSAx
NywgMjAxNyBhdCAwMzo0Mzo0N1BNICswODAwLCBaaG91LCBEYXZpZChDaHVuTWluZykgd3JvdGU6
Cj4+IEJ5IHRoaXMgY2hhbmdlLCBJIHN1Z2dlc3QgdG8gcmVtb3ZlIG1taHViL2dmeGh1Yl92MV8w
X2lwX2Z1bmNzIGFuZCB0aGVpcgo+PiBJUCBibG9jaywgdW5pZnkgdGhlbSB0byBnbWMgaXAgYmxv
Y2ssIHRoaXMgd2F5IHdlIGNhbm5vdCBsb3N0IHNldHRpbmcKPj4gd2hlbiByZXN1bWUgYmFjay4K
Pj4KPiAgRnJvbSBodyBzaWRlLCB3byB3b24ndCBoYXZlIHJlYWwgZ21jIHNpbmNlIHRoaXMgY2hp
cCwgbW1odWIgYW5kIGdmeGh1YihnYykKPiBpbnN0ZWFkIG9mIGl0LiBNYXliZSB3ZSB3b3VsZCBi
ZXR0ZXIgdG8gYWxpZ24gd2l0aCBodyBkZXNnaW4uCgpZZWFoLCBJIGhhZCBwYXRjaGVzIGZvciBk
b2luZyBleGFjdGx5IHRoaXMgYnV0IHRoZW4gZGVjaWRlZCBkcm9wcGluZyBpdC4KCldoYXQgd2Ug
c2hvdWxkIGRvIGlzIHRvIGhhdmUgYW55IG9uZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgY29kZSBo
YW5kbGluZyAKYm90aCBodWJzIGFuZCB0aGVuIGhhdmUgYm90aCBhcyBzZXBhcmF0ZSBJUCBibG9j
ayBpbiB0aGUgbGlzdC4KCkFueXdheSBmb3Igbm93IGJvdGggcGF0Y2hlcyBhcmUgUmV2aWV3ZWQt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgCjxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+LgoKSSBhc3N1
bWUgdGhhdCBmaW5hbGx5IGZpeGVzIFMzIG9uIFZlZ2ExMD8KClJlZ2FyZHMsCkNocmlzdGlhbi4K
Cj4KPiBUaGFua3MsCj4gUnVpCj4KPj4gUmVnYXJkcywKPj4gRGF2aWQgWmhvdQo+Pgo+PiBPbiAy
MDE35bm0MDXmnIgxN+aXpSAxNTozOCwgSHVhbmcgUnVpIHdyb3RlOgo+Pj4gU2lnbmVkLW9mZi1i
eTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KPj4+IC0tLQo+Pj4gICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4aHViX3YxXzAuYyB8IDIgKy0KPj4+ICAgIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhodWJfdjFfMC5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC8KPj4gYW1kZ3B1L2dmeGh1Yl92MV8wLmMKPj4+IGluZGV4IDAwNTA3NWYuLjQxMzEzNTE0
IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4aHViX3YxXzAu
Ywo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4aHViX3YxXzAuYwo+Pj4g
QEAgLTM2OCw3ICszNjgsNyBAQCBzdGF0aWMgaW50IGdmeGh1Yl92MV8wX3N1c3BlbmQodm9pZCAq
aGFuZGxlKQo+Pj4gICAKPj4+ICAgIHN0YXRpYyBpbnQgZ2Z4aHViX3YxXzBfcmVzdW1lKHZvaWQg
KmhhbmRsZSkKPj4+ICAgIHsKPj4+IC0gICAgIHJldHVybiAwOwo+Pj4gKyAgICAgcmV0dXJuIGdm
eGh1Yl92MV8wX2h3X2luaXQoaGFuZGxlKTsKPj4+ICAgIH0KPj4+ICAgCj4+PiAgICBzdGF0aWMg
Ym9vbCBnZnhodWJfdjFfMF9pc19pZGxlKHZvaWQgKmhhbmRsZSkKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
