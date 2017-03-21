From: =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] amdgpu: add new VA operations CLEAR and REPLACE
Date: Tue, 21 Mar 2017 14:30:10 +0100
Message-ID: <ace47633-adf1-9055-5e08-1803f2f026c4@gmail.com>
References: <1489730362-31095-1-git-send-email-Jerry.Zhang@amd.com>
 <1489730362-31095-2-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1489730362-31095-2-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
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
Cc: christian.koenig-5C7GfCeVMHo@public.gmane.org, nicolai.haehnle-5C7GfCeVMHo@public.gmane.org

VGhpcyBzaG91bGQgdXNlIHRoZSBwcm9wZXIgcHJvY2VkdXJlIGZvciB1cGRhdGluZyBhbWRncHVf
ZHJtLmgsIGFzIApleHBsYWluZWQgaW4gaW5jbHVkZS9kcm0vUkVBRE1FLiBJIGNhbiB0YWtlIGNh
cmUgb2YgdGhpcyBhcyBzb29uIGFzIGFsbCAKdGhlIGtlcm5lbCBwYXRjaGVzIGZvciBQUlQgYXJl
IGluIGEgdHJlZSB0aGF0IGRvZXNuJ3QgcmViYXNlIChpLmUuIAphZ2Q1Zi9kcm0tbmV4dC00LjEy
IG9yIGFpcmxpZWQvZHJtLW5leHQpLgoKTmljb2xhaQoKT24gMTcuMDMuMjAxNyAwNjo1OSwgSnVu
d2VpIFpoYW5nIHdyb3RlOgo+IFNpZ25lZC1vZmYtYnk6IEp1bndlaSBaaGFuZyA8SmVycnkuWmhh
bmdAYW1kLmNvbT4KPiAtLS0KPiAgaW5jbHVkZS9kcm0vYW1kZ3B1X2RybS5oIHwgMiArKwo+ICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9k
cm0vYW1kZ3B1X2RybS5oIGIvaW5jbHVkZS9kcm0vYW1kZ3B1X2RybS5oCj4gaW5kZXggNzAwMmRj
NC4uYTczYjQwYSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2RybS9hbWRncHVfZHJtLmgKPiArKysg
Yi9pbmNsdWRlL2RybS9hbWRncHVfZHJtLmgKPiBAQCAtNDEwLDYgKzQxMCw4IEBAIHN0cnVjdCBk
cm1fYW1kZ3B1X2dlbV9vcCB7Cj4KPiAgI2RlZmluZSBBTURHUFVfVkFfT1BfTUFQCQkJMQo+ICAj
ZGVmaW5lIEFNREdQVV9WQV9PUF9VTk1BUAkJCTIKPiArI2RlZmluZSBBTURHUFVfVkFfT1BfQ0xF
QVIJCQkzCj4gKyNkZWZpbmUgQU1ER1BVX1ZBX09QX1JFUExBQ0UJCQk0Cj4KPiAgLyogRGVsYXkg
dGhlIHBhZ2UgdGFibGUgdXBkYXRlIHRpbGwgdGhlIG5leHQgQ1MgKi8KPiAgI2RlZmluZSBBTURH
UFVfVk1fREVMQVlfVVBEQVRFCQkoMSA8PCAwKQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
