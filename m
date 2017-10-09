From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 08/12] drm/amdgpu:explicitly call fence_process
Date: Mon, 9 Oct 2017 10:23:48 +0200
Message-ID: <5cb1ae43-ec3a-2b0b-b78b-91cefd575672@gmail.com>
References: <1506751432-21789-1-git-send-email-Monk.Liu@amd.com>
 <1506751432-21789-9-git-send-email-Monk.Liu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1506751432-21789-9-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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

QW0gMzAuMDkuMjAxNyB1bSAwODowMyBzY2hyaWViIE1vbmsgTGl1Ogo+IHRoaXMgd2F5IG5vIG5l
ZWQgdG8gd2FpdCB0aW1lciB0cmlnZ2VyZWQgdG8gc2F2ZSB0aW1lCgpJbiBwcmluY2lwbGUgYSBn
b29kIGlkZWEsIGJ1dCBwbGVhc2UgcmVtb3ZlIAphbWRncHVfZmVuY2VfZHJpdmVyX2ZvcmNlX2Nv
bXBsZXRpb25fcmluZygpIGFuZCB1c2UgCmFtZGdwdV9mZW5jZV9kcml2ZXJfZm9yY2VfY29tcGxl
dGlvbigpIGluc3RlYWQuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+Cj4gQ2hhbmdlLUlkOiBJZTk2
ZmQyZmMxZjYwNTRlYmMxZTU4YzNkNzAzNDcxNjM5MzcxZWUyMgo+IFNpZ25lZC1vZmYtYnk6IE1v
bmsgTGl1IDxNb25rLkxpdUBhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2ZlbmNlLmMgfCA3ICsrKysrKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9mZW5jZS5jCj4gaW5kZXggMzMzYmFkNy4uMTM3ODVkOCAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jCj4gQEAgLTU0Myw4ICs1NDMsMTMgQEAg
dm9pZCBhbWRncHVfZmVuY2VfZHJpdmVyX2ZvcmNlX2NvbXBsZXRpb24oc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpCj4gICAKPiAgIHZvaWQgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9mb3JjZV9jb21w
bGV0aW9uX3Jpbmcoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQo+ICAgewo+IC0JaWYgKHJpbmcp
Cj4gKwlpZiAocmluZykgewo+ICAgCQlhbWRncHVfZmVuY2Vfd3JpdGUocmluZywgcmluZy0+ZmVu
Y2VfZHJ2LnN5bmNfc2VxKTsKPiArCQkvKiBjYWxsIGZlbmNlIHByb2Nlc3MgbWFudWFsbHkgY2Fu
IGdldCBpdCBkb25lIHF1aWNrbHkKPiArCQkgKiBpbnN0ZWFkIG9mIHdhaXRpbmcgZm9yIHRoZSB0
aW1lciB0cmlnZ2VyZWQKPiArCQkgKi8KPiArCQlhbWRncHVfZmVuY2VfcHJvY2VzcyhyaW5nKTsK
PiArCX0KPiAgIH0KPiAgIAo+ICAgLyoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
