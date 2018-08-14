From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Cancel the delay work when suspend
Date: Tue, 14 Aug 2018 11:58:36 +0200
Message-ID: <1c9263f1-94e9-0175-2d96-20003efd4416@gmail.com>
References: <1534239382-4129-1-git-send-email-Rex.Zhu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1534239382-4129-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

QW0gMTQuMDguMjAxOCB1bSAxMTozNiBzY2hyaWViIFJleCBaaHU6Cj4gQ2FuY2VsIHRoZSBkZWxh
eSB3b3JrIHRvIGF2b2lkIHRoZSBjb3JuZXIgY2FzZSB0aGF0Cj4gaWIgdGVzdCB3YXMgbm90IHJ1
bm5pbmcgd2hlbiBzdXNwZW5kCj4KPiBTaWduZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFt
ZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0Bh
bWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYyB8IDIgKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBpbmRleCA0MTNlZjlhLi43
ZWNmMDQwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
Ywo+IEBAIC0yNjc1LDYgKzI2NzUsOCBAQCBpbnQgYW1kZ3B1X2RldmljZV9zdXNwZW5kKHN0cnVj
dCBkcm1fZGV2aWNlICpkZXYsIGJvb2wgc3VzcGVuZCwgYm9vbCBmYmNvbikKPiAgIAlpZiAoZmJj
b24pCj4gICAJCWFtZGdwdV9mYmRldl9zZXRfc3VzcGVuZChhZGV2LCAxKTsKPiAgIAo+ICsJY2Fu
Y2VsX2RlbGF5ZWRfd29ya19zeW5jKCZhZGV2LT5sYXRlX2luaXRfd29yayk7Cj4gKwo+ICAgCWlm
ICghYW1kZ3B1X2RldmljZV9oYXNfZGNfc3VwcG9ydChhZGV2KSkgewo+ICAgCQkvKiB0dXJuIG9m
ZiBkaXNwbGF5IGh3ICovCj4gICAJCWRybV9tb2Rlc2V0X2xvY2tfYWxsKGRldik7CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
