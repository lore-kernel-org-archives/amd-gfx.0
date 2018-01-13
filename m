From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] drm/amdgpu: only set dma_buf ops when it is valid
Date: Sat, 13 Jan 2018 19:59:42 +0100
Message-ID: <113f291c-3e4c-682e-29af-011890c3d7c5@gmail.com>
References: <1515798111-28959-1-git-send-email-Samuel.Li@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1515798111-28959-1-git-send-email-Samuel.Li-5C7GfCeVMHo@public.gmane.org>
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
To: Samuel Li <Samuel.Li-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

Q29tbWl0IG1lc3NhZ2UgYW5kIHNpZ25lZC1vZi1ieSBsaW5lIGlzIG1pc3NpbmcuCgpBcGFydCBm
cm9tIHRoYXQgdGhlIHBhdGNoIGlzIFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIAo8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPi4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCkFtIDEzLjAxLjIw
MTggdW0gMDA6MDEgc2NocmllYiBTYW11ZWwgTGk6Cj4gQ2hhbmdlLUlkOiBJMzdkYWVjYmY2OTVk
YTEzZWFlZWExZDM2MmMyNzBiOTJhODk0MzkzYQo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ByaW1lLmMgfCA1ICsrKy0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wcmltZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ByaW1lLmMKPiBpbmRleCBhMTQyMzRiLi44YWZlYzIxIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wcmltZS5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ByaW1lLmMKPiBAQCAtMjIxLDkgKzIyMSwxMCBA
QCBzdHJ1Y3QgZG1hX2J1ZiAqYW1kZ3B1X2dlbV9wcmltZV9leHBvcnQoc3RydWN0IGRybV9kZXZp
Y2UgKmRldiwKPiAgIAkJcmV0dXJuIEVSUl9QVFIoLUVQRVJNKTsKPiAgIAo+ICAgCWJ1ZiA9IGRy
bV9nZW1fcHJpbWVfZXhwb3J0KGRldiwgZ29iaiwgZmxhZ3MpOwo+IC0JaWYgKCFJU19FUlIoYnVm
KSkKPiArCWlmICghSVNfRVJSKGJ1ZikpIHsKPiAgIAkJYnVmLT5maWxlLT5mX21hcHBpbmcgPSBk
ZXYtPmFub25faW5vZGUtPmlfbWFwcGluZzsKPiAtCWJ1Zi0+b3BzID0gJmFtZGdwdV9kbWFidWZf
b3BzOwo+ICsJCWJ1Zi0+b3BzID0gJmFtZGdwdV9kbWFidWZfb3BzOwo+ICsJfQo+ICAgCj4gICAJ
cmV0dXJuIGJ1ZjsKPiAgIH0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
