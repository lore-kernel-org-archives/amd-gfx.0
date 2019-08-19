From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] amd/amdgpu: add Arcturus vf DID support
Date: Mon, 19 Aug 2019 12:56:44 +0200
Message-ID: <633dcb44-d3ba-15b1-e3f7-31f37569142b@gmail.com>
References: <1565945960-21236-1-git-send-email-Frank.Min@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1565945960-21236-1-git-send-email-Frank.Min-5C7GfCeVMHo@public.gmane.org>
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
To: "Frank.Min" <Frank.Min-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTYuMDguMTkgdW0gMTA6NTkgc2NocmllYiBGcmFuay5NaW46Cj4gQ2hhbmdlLUlkOiBJNzE1
MzE1Mzc4NWZkZDU0YTEwZWJjNDdlNzc4ZTA2OTgyZWRjNzlkNwo+IFNpZ25lZC1vZmYtYnk6IEZy
YW5rLk1pbiA8RnJhbmsuTWluQGFtZC5jb20+CgpDYW4ndCBqdWRnZSBpZiB0aGUgdmFsdWVzIGFy
ZSBjb3JyZWN0LCBidXQgZmVlbCBmcmVlIHRvIGFkZCBhbiBBY2tlZC1ieTogCkNocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4gdG8gdGhlIGZpcnN0IHR3byBwYXRjaGVz
LgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyB8IDEg
Kwo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2Rydi5jCj4gaW5kZXggMGU4YzE2NS4uMzg5MGJhMiAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPiBAQCAtOTk5LDYgKzk5OSw3IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCBwY2lpZGxpc3RbXSA9IHsKPiAgIAl7
MHgxMDAyLCAweDczOEMsIFBDSV9BTllfSUQsIFBDSV9BTllfSUQsIDAsIDAsIENISVBfQVJDVFVS
VVN9LAo+ICAgCXsweDEwMDIsIDB4NzM4OCwgUENJX0FOWV9JRCwgUENJX0FOWV9JRCwgMCwgMCwg
Q0hJUF9BUkNUVVJVU30sCj4gICAJezB4MTAwMiwgMHg3MzhFLCBQQ0lfQU5ZX0lELCBQQ0lfQU5Z
X0lELCAwLCAwLCBDSElQX0FSQ1RVUlVTfSwKPiArCXsweDEwMDIsIDB4NzM5MCwgUENJX0FOWV9J
RCwgUENJX0FOWV9JRCwgMCwgMCwgQ0hJUF9BUkNUVVJVU30sCj4gICAJLyogTmF2aTEwICovCj4g
ICAJezB4MTAwMiwgMHg3MzEwLCBQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAwLCBDSElQX05B
VkkxMH0sCj4gICAJezB4MTAwMiwgMHg3MzEyLCBQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAw
LCBDSElQX05BVkkxMH0sCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
