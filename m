From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm 2/2] [RFC] amdgpu: do not free flink bo for flink_fd
Date: Fri, 10 Aug 2018 16:20:23 +0200
Message-ID: <78d960c7-6feb-9ca0-c6c8-b335a06e8f21@gmail.com>
References: <1533877508-27480-1-git-send-email-Jerry.Zhang@amd.com>
 <1533877508-27480-2-git-send-email-Jerry.Zhang@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1533877508-27480-2-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
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
To: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: christian.koenig-5C7GfCeVMHo@public.gmane.org

QW0gMTAuMDguMjAxOCB1bSAwNzowNSBzY2hyaWViIEp1bndlaSBaaGFuZzoKPiB0aGUgZmxpbmsg
Ym8gaXMgdXNlZCB0byBleHBvcnQKCldoeSBzaG91bGQgd2UgZG8gdGhpcz8gVGhhdCBtYWtlcyBu
byBzZW5zZSwgdGhpcyB3YXkgd2Ugd291bGQgY3JlYXRlIGEgCm1lbW9yeSBsZWFrLgoKQ2hyaXN0
aWFuLgoKPgo+IFNpZ25lZC1vZmYtYnk6IEp1bndlaSBaaGFuZyA8SmVycnkuWmhhbmdAYW1kLmNv
bT4KPiAtLS0KPiAgIGFtZGdwdS9hbWRncHVfYm8uYyB8IDYgLS0tLS0tCj4gICAxIGZpbGUgY2hh
bmdlZCwgNiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9hbWRncHUvYW1kZ3B1X2JvLmMg
Yi9hbWRncHUvYW1kZ3B1X2JvLmMKPiBpbmRleCA2ZjBiYWYxLi41YjkxY2ZjIDEwMDY0NAo+IC0t
LSBhL2FtZGdwdS9hbWRncHVfYm8uYwo+ICsrKyBiL2FtZGdwdS9hbWRncHVfYm8uYwo+IEBAIC0y
MTksMTIgKzIxOSw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2JvX2V4cG9ydF9mbGluayhhbWRncHVf
Ym9faGFuZGxlIGJvKQo+ICAgCj4gICAJYm8tPmZsaW5rX25hbWUgPSBmbGluay5uYW1lOwo+ICAg
Cj4gLQlpZiAoYm8tPmRldi0+ZmxpbmtfZmQgIT0gYm8tPmRldi0+ZmQpIHsKPiAtCQlzdHJ1Y3Qg
ZHJtX2dlbV9jbG9zZSBhcmdzID0ge307Cj4gLQkJYXJncy5oYW5kbGUgPSBoYW5kbGU7Cj4gLQkJ
ZHJtSW9jdGwoYm8tPmRldi0+ZmxpbmtfZmQsIERSTV9JT0NUTF9HRU1fQ0xPU0UsICZhcmdzKTsK
PiAtCX0KPiAtCj4gICAJcHRocmVhZF9tdXRleF9sb2NrKCZiby0+ZGV2LT5ib190YWJsZV9tdXRl
eCk7Cj4gICAJciA9IGhhbmRsZV90YWJsZV9pbnNlcnQoJmJvLT5kZXYtPmJvX2ZsaW5rX25hbWVz
LCBiby0+ZmxpbmtfbmFtZSwgYm8pOwo+ICAgCXB0aHJlYWRfbXV0ZXhfdW5sb2NrKCZiby0+ZGV2
LT5ib190YWJsZV9tdXRleCk7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
