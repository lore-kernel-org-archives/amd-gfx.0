From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm 0/4] amdgpu: new approach for ras inject test
Date: Thu, 29 Aug 2019 11:03:27 +0200
Message-ID: <16e80e67-e9eb-4091-d2ea-69255e68bb25@gmail.com>
References: <20190829085917.20439-1-guchun.chen@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190829085917.20439-1-guchun.chen-5C7GfCeVMHo@public.gmane.org>
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
To: Guchun Chen <guchun.chen-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Hawking.Zhang-5C7GfCeVMHo@public.gmane.org, Dennis.Li-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, alexander.deucher-5C7GfCeVMHo@public.gmane.org, Tao.Zhou1-5C7GfCeVMHo@public.gmane.org
Cc: Candice.Li-5C7GfCeVMHo@public.gmane.org

T25seSBza2ltbWVkIG92ZXIgdGhlIHBhdGNoZXMsIGJ1dCBpbiBnZW5lcmFsIGxvb2tzIGdvb2Qg
dG8gbWUuCgpGZWVsIGZyZWUgdG8gYWRkIGFuIEFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+IAp0byB0aGUgd2hvbGUgc2VyaWVzLgoKQnV0IHNvbWVi
b2R5IHdpdGggbW9yZSByYXMga25vd2xlZGdlIHRoYW4gSSBoYXZlIHNob3VsZCBwcm9iYWJseSB0
YWtlIGEgCmxvb2sgYXMgd2VsbC4KCkNocmlzdGlhbi4KCkFtIDI5LjA4LjE5IHVtIDEwOjU5IHNj
aHJpZWIgR3VjaHVuIENoZW46Cj4gVGhlc2UgcGF0Y2hlcyBhcmUgdG8gcmVtb3ZlIGFkZGl0aW9u
YWwgZXh0ZXJuYWwgbGliLWpzb25jCj4gZGVwZW5kZW5jZSwgYW5kIHRvIHB1dCBhbGwgdGVzdCBj
b25maWd1cmF0aW9ucyBpbnRvIEMgY29kZS4KPgo+IEd1Y2h1biBDaGVuICg0KToKPiAgICBhbWRn
cHU6IHJlbW92ZSBqc29uIHBhY2thZ2UgZGVwZW5kZW5jZQo+ICAgIGFtZGdwdTogZGVsZXRlIHRl
c3QgY29uZmlndXJhdGlvbiBmaWxlCj4gICAgYW1kZ3B1OiBhZGQgcmFzIGluamVjdCB1bml0IHRl
c3QKPiAgICBhbWRncHU6IGFkZCByYXMgZmVhdHVyZSBjYXBhYmlsaXR5IGNoZWNrIGluIGluamVj
dCB0ZXN0Cj4KPiAgIGNvbmZpZ3VyZS5hYyAgICAgICAgICAgICB8ICAxOCAtLS0KPiAgIGRhdGEv
YW1kZ3B1X3Jhcy5qc29uICAgICB8IDI2NyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCj4gICBtZXNvbi5idWlsZCAgICAgICAgICAgICAgfCAgIDEgLQo+ICAgdGVzdHMvYW1kZ3B1
L01ha2VmaWxlLmFtIHwgICA1ICstCj4gICB0ZXN0cy9hbWRncHUvbWVzb24uYnVpbGQgfCAgMTYg
Ky0KPiAgIHRlc3RzL2FtZGdwdS9yYXNfdGVzdHMuYyB8IDMwNSArKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgIDYgZmlsZXMgY2hhbmdlZCwgMTE2IGluc2VydGlvbnMo
KyksIDQ5NiBkZWxldGlvbnMoLSkKPiAgIGRlbGV0ZSBtb2RlIDEwMDY0NCBkYXRhL2FtZGdwdV9y
YXMuanNvbgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
