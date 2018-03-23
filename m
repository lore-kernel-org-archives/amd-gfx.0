From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/5] drm/amdgpu: remove duplicate cg/pg wrapper functions
Date: Fri, 23 Mar 2018 13:00:33 +0100
Message-ID: <f54f650c-bbcb-f06a-9507-433a86d875b2@gmail.com>
References: <1521803425-17089-1-git-send-email-Rex.Zhu@amd.com>
 <1521803425-17089-5-git-send-email-Rex.Zhu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1521803425-17089-5-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

QW0gMjMuMDMuMjAxOCB1bSAxMjoxMCBzY2hyaWViIFJleCBaaHU6Cj4gW1NOSVBdCj4gLWludCBh
bWRncHVfZGV2aWNlX2lwX3NldF9wb3dlcmdhdGluZ19zdGF0ZShzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwKPiAraW50IGFtZGdwdV9kZXZpY2VfaXBfc2V0X3Bvd2VyZ2F0aW5nX3N0YXRlKHZv
aWQgKmRldiwKPiAgIAkJCQkJICAgZW51bSBhbWRfaXBfYmxvY2tfdHlwZSBibG9ja190eXBlLAo+
ICAgCQkJCQkgICBlbnVtIGFtZF9wb3dlcmdhdGluZ19zdGF0ZSBzdGF0ZSkKPiAgIHsKPiAgIAlp
bnQgaSwgciA9IDA7Cj4gKwlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGRldjsKClRoZSB1
c3VhbCBjb2Rpbmcgc3R5bGUgaXMgbG9uZ2VyIGxpbmVzIGZpcnN0IGFuZCBjb21tb25seSB1c2Vk
IHZhcmlhYmxlcyAKbGlrZSAiaSIgYW5kICJyIiBsYXN0LgoKQXBhcnQgZnJvbSB0aGF0IHRoZSBz
ZXJpZXMgaXMgQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgCjxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+LgoKUmVnYXJkcywKQ2hyaXN0aWFuLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
