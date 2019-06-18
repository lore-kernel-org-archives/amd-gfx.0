From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add job->preamble_status back to status value
Date: Tue, 18 Jun 2019 13:10:07 +0200
Message-ID: <817ca792-fbb2-580b-89e6-9edb24caef2e@gmail.com>
References: <1560853789-22977-1-git-send-email-Jack.Xiao@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1560853789-22977-1-git-send-email-Jack.Xiao-5C7GfCeVMHo@public.gmane.org>
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
To: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

QW0gMTguMDYuMTkgdW0gMTI6MzEgc2NocmllYiBYaWFvLCBKYWNrOgo+IGpvYi0+cHJlYW1ibGVf
c3RhdHVzIHdhcyBhY2NpZGVudGx5IGRyb3BwZWQgZnJvbSB0aGUgY29tYmluYXRpb24gdmFsdWUK
PiBvZiBzdGF0dXMgdmFyYWlhYmxlIHdoaWNoIGlzIHRoZSBwYXJhbWV0ZXIgb2Ygc29tZSByaW5n
IGxldmVsIGZ1bmN0aW9uLgo+IFRoZSBwYXRjaCBpcyB0byBhZGQgaXQgYmFjay4KPgo+IFNpZ25l
ZC1vZmYtYnk6IEphY2sgWGlhbyA8SmFjay5YaWFvQGFtZC5jb20+CgpGb3Igbm93IEFja2VkLWJ5
OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+LCBjYXVzZSB3ZSAK
bmVlZCB0byBnZXQgdGhpcyBmaXhlZCBBU0FQLgoKQnV0IG5vdyB0aGUgcXVlc3Rpb24gaXMgd2h5
IGRvIHdlIGFjdHVhbGx5IGhhdmUgdHdvIGZpZWxkcyBpbiB0aGUgam9iIApmb3IgdGhlIHNhbWUg
c3RhdHVzPwoKQ2hyaXN0aWFuLgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9pYi5jIHwgMSArCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jCj4gaW5kZXggOTBjYzA4NC4uNjg4
MmVlYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIu
Ywo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jCj4gQEAgLTIw
OCw2ICsyMDgsNyBAQCBpbnQgYW1kZ3B1X2liX3NjaGVkdWxlKHN0cnVjdCBhbWRncHVfcmluZyAq
cmluZywgdW5zaWduZWQgbnVtX2licywKPiAgIAo+ICAgCXNraXBfcHJlYW1ibGUgPSByaW5nLT5j
dXJyZW50X2N0eCA9PSBmZW5jZV9jdHg7Cj4gICAJaWYgKGpvYiAmJiByaW5nLT5mdW5jcy0+ZW1p
dF9jbnR4Y250bCkgewo+ICsJCXN0YXR1cyB8PSBqb2ItPnByZWFtYmxlX3N0YXR1czsKPiAgIAkJ
c3RhdHVzIHw9IGpvYi0+cHJlZW1wdGlvbl9zdGF0dXM7Cj4gICAJCWFtZGdwdV9yaW5nX2VtaXRf
Y250eGNudGwocmluZywgc3RhdHVzKTsKPiAgIAl9CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZng=
