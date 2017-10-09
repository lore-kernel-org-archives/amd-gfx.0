From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 11/12] drm/amdgpu/sriov:show error if ib test failed
Date: Mon, 9 Oct 2017 10:29:50 +0200
Message-ID: <7ce92d79-5f8c-3d15-0fc6-717c8b5e623b@gmail.com>
References: <1506751432-21789-1-git-send-email-Monk.Liu@amd.com>
 <1506751432-21789-12-git-send-email-Monk.Liu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1506751432-21789-12-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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

QW0gMzAuMDkuMjAxNyB1bSAwODowMyBzY2hyaWViIE1vbmsgTGl1Ogo+IGZpeCBsb29zZSBtb2Rl
IGdwdSByZXNldCBpYiB0ZXN0IHJlc3VsdCBpbmNvcnJlY3QgbWVzc2FnZQo+Cj4gQ2hhbmdlLUlk
OiBJYzRlM2I1MWU0ZmY3N2M1ZTA4ZDI2OGE0YTVjYTMyZTdjODgyMzY3Ywo+IFNpZ25lZC1vZmYt
Ynk6IE1vbmsgTGl1IDxNb25rLkxpdUBhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAzICsrLQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+IGluZGV4IDEyMmUyZTEuLmMzZjEwYjUgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gQEAgLTI5MDIsNyAr
MjkwMiw4IEBAIGludCBhbWRncHVfc3Jpb3ZfZ3B1X3Jlc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X2pvYiAqam9iKQo+ICAgCj4gICAJYW1kZ3B1X2lycV9ncHVf
cmVzZXRfcmVzdW1lX2hlbHBlcihhZGV2KTsKPiAgIAo+IC0JaWYgKGFtZGdwdV9pYl9yaW5nX3Rl
c3RzKGFkZXYpKQo+ICsJciA9IGFtZGdwdV9pYl9yaW5nX3Rlc3RzKGFkZXYpOwo+ICsJaWYgKHIp
Cj4gICAJCWRldl9lcnIoYWRldi0+ZGV2LCAiW0dQVV9SRVNFVF0gaWIgcmluZyB0ZXN0IGZhaWxl
ZCAoJWQpLlxuIiwgcik7Cj4gICAKPiAgIAkvKiByZWxlYXNlIGZ1bGwgY29udHJvbCBvZiBHUFUg
YWZ0ZXIgaWIgdGVzdCAqLwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
