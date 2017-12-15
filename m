From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: always cancel uvd idel handler in uvd
 suspend
Date: Fri, 15 Dec 2017 10:23:09 +0100
Message-ID: <213ebe8a-58b7-7156-abdb-c43405f119cd@gmail.com>
References: <1513323175-9063-1-git-send-email-Jim.Qu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1513323175-9063-1-git-send-email-Jim.Qu-5C7GfCeVMHo@public.gmane.org>
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
To: Jim Qu <Jim.Qu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTUuMTIuMjAxNyB1bSAwODozMiBzY2hyaWViIEppbSBRdToKPiBDaGFuZ2UtSWQ6IEk2Mjcy
MGEyZGY5MjAwNWM4ODM4ZjJlNmE1MDVmN2Q0ODQwOTAzZWJiCj4gU2lnbmVkLW9mZi1ieTogSmlt
IFF1IDxKaW0uUXVAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+IGZvciBib3RoLgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYyB8IDQgKystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdXZkLmMKPiBpbmRleCA5MTZlNTE2Li44OWQ1OWZkIDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYwo+IEBAIC0yOTcsNiArMjk3LDggQEAgaW50IGFt
ZGdwdV91dmRfc3VzcGVuZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIAlpZiAoYWRl
di0+dXZkLnZjcHVfYm8gPT0gTlVMTCkKPiAgIAkJcmV0dXJuIDA7Cj4gICAKPiArCWNhbmNlbF9k
ZWxheWVkX3dvcmtfc3luYygmYWRldi0+dXZkLmlkbGVfd29yayk7Cj4gKwo+ICAgCWZvciAoaSA9
IDA7IGkgPCBhZGV2LT51dmQubWF4X2hhbmRsZXM7ICsraSkKPiAgIAkJaWYgKGF0b21pY19yZWFk
KCZhZGV2LT51dmQuaGFuZGxlc1tpXSkpCj4gICAJCQlicmVhazsKPiBAQCAtMzA0LDggKzMwNiw2
IEBAIGludCBhbWRncHVfdXZkX3N1c3BlbmQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4g
ICAJaWYgKGkgPT0gQU1ER1BVX01BWF9VVkRfSEFORExFUykKPiAgIAkJcmV0dXJuIDA7Cj4gICAK
PiAtCWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmYWRldi0+dXZkLmlkbGVfd29yayk7Cj4gLQo+
ICAgCXNpemUgPSBhbWRncHVfYm9fc2l6ZShhZGV2LT51dmQudmNwdV9ibyk7Cj4gICAJcHRyID0g
YWRldi0+dXZkLmNwdV9hZGRyOwo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
