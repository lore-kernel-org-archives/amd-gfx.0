From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: clarify why we evict vram twice on suspend
Date: Tue, 11 Oct 2016 14:11:40 +0200
Message-ID: <d8dc2b86-90e4-c29f-660e-779f90918a35@vodafone.de>
References: <1476118180-24496-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1476118180-24496-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

QW0gMTAuMTAuMjAxNiB1bSAxODo0OSBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBVcGRhdGUgdGhl
IGNvbW1lbnQgdG8gZXhwbGFpbiB3aHkgd2UgZG8gdGhpcy4KPgo+IFNpZ25lZC1vZmYtYnk6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+IGZvciBib3RoLgoKPiAtLS0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDUgKysrKy0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBpbmRleCBiZmNhNjc2
Li5iODhhM2I3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYwo+IEBAIC0xOTU4LDcgKzE5NTgsMTAgQEAgaW50IGFtZGdwdV9kZXZpY2Vfc3VzcGVuZChz
dHJ1Y3QgZHJtX2RldmljZSAqZGV2LCBib29sIHN1c3BlbmQsIGJvb2wgZmJjb24pCj4gICAKPiAg
IAlyID0gYW1kZ3B1X3N1c3BlbmQoYWRldik7Cj4gICAKPiAtCS8qIGV2aWN0IHJlbWFpbmluZyB2
cmFtIG1lbW9yeSAqLwo+ICsJLyogZXZpY3QgcmVtYWluaW5nIHZyYW0gbWVtb3J5Cj4gKwkgKiBU
aGlzIHNlY29uZCBjYWxsIHRvIGV2aWN0IHZyYW0gaXMgdG8gZXZpY3QgdGhlIGdhcnQgcGFnZSB0
YWJsZQo+ICsJICogdXNpbmcgdGhlIENQVS4KPiArCSAqLwo+ICAgCWFtZGdwdV9ib19ldmljdF92
cmFtKGFkZXYpOwo+ICAgCj4gICAJcGNpX3NhdmVfc3RhdGUoZGV2LT5wZGV2KTsKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
