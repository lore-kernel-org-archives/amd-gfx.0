From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm] drm/amdgpu: define amdgpu_syncobj_handle type for
 vulkan usage
Date: Wed, 24 Jan 2018 11:55:50 +0100
Message-ID: <5cd83a2e-d7c6-1ba2-136d-2aa235855186@gmail.com>
References: <1516774761-32653-1-git-send-email-seth.zhu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1516774761-32653-1-git-send-email-seth.zhu-5C7GfCeVMHo@public.gmane.org>
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
To: Seth Zhu <seth.zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjQuMDEuMjAxOCB1bSAwNzoxOSBzY2hyaWViIFNldGggWmh1Ogo+IFZ1bGthbiBGZW5jZSBh
bmQgU2VtYXBob3JlKEFNRFZMSykgd2lsbCBhZGQgaW1wbGVtZW50YXRpb24gYmFzZWQgb24KPiBz
eW5jIG9iamVjdC4gU2VtYW50aWMgc3luY29iaiBoYW5kbGUgdHlwZSBpcyByZXF1aXJlZCBpbnN0
ZWFkIG9mCj4gdXNpbmcgdWludDMyX3QgZGlyZWN0bHkuCgpBcyBJIGFscmVhZHkgd3JvdGUgdG8g
RGF2aWQgSSBkb24ndCB0aGluayB0aGF0IHRoaXMgaXMgYSBnb29kIGlkZWEuCgpUaGUgc3luYyBv
YmplY3QgaXMgYSBnZW5lcmFsIERSTSBvYmplY3QgYW5kIG5vdGhpbmcgYW1kZ3B1IHNwZWNpZmlj
LgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPgo+IENoYW5nZS1JZDogSWRiZDJiMmIxNjE4MThmYTU4
ZmUwYmIzZDFhYzQ2NDUzODQ3YWU2MjYKPiBTaWduZWQtb2ZmLWJ5OiBTZXRoIFpodSA8c2V0aC56
aHVAYW1kLmNvbT4KPiAtLS0KPiAgIGFtZGdwdS9hbWRncHUuaCB8IDQgKysrKwo+ICAgMSBmaWxl
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2FtZGdwdS9hbWRncHUu
aCBiL2FtZGdwdS9hbWRncHUuaAo+IGluZGV4IDllZjU1ZTUuLjMxZmMyMDEgMTAwNjQ0Cj4gLS0t
IGEvYW1kZ3B1L2FtZGdwdS5oCj4gKysrIGIvYW1kZ3B1L2FtZGdwdS5oCj4gQEAgLTE0NSw2ICsx
NDUsMTAgQEAgdHlwZWRlZiBzdHJ1Y3QgYW1kZ3B1X3NlbWFwaG9yZSAqYW1kZ3B1X3NlbWFwaG9y
ZV9oYW5kbGU7Cj4gICAgKiBEZWZpbmUgaGFuZGxlIGZvciBzZW0gZmlsZQo+ICAgICovCj4gICB0
eXBlZGVmIHVpbnQzMl90IGFtZGdwdV9zZW1faGFuZGxlOwo+ICsvKioKPiArICogRGVmaW5lIGhh
bmRsZSBmb3Igc3luY29iago+ICsgKi8KPiArdHlwZWRlZiB1aW50MzJfdCBhbWRncHVfc3luY29i
al9oYW5kbGU7Cj4gICAKPiAgIAo+ICAgLyotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSovCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
