From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix compile warning
Date: Fri, 7 Apr 2017 09:43:19 +0800
Message-ID: <58E6EEB7.2050607@amd.com>
References: <1491508578-32147-1-git-send-email-AlexBin.Xie@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1491508578-32147-1-git-send-email-AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

Ck9uIDA0LzA3LzIwMTcgMDM6NTYgQU0sIEFsZXggWGllIHdyb3RlOgo+IHdhcm5pbmc6IGNvbXBh
cmlzb24gb2YgZGlzdGluY3QgcG9pbnRlciB0eXBlcyBsYWNrcyBhIGNhc3QKClRoYW5rcyBmb3Ig
eW91ciBwYXRjaC4KSSBoYXZlIGZpeGVkIGl0LgoKUGxlYXNlIGNoZWNrIGluIG91ciBicmFuY2gu
CgpKZXJyeQo+Cj4gQ2hhbmdlLUlkOiBJMzE3ZWRkZDFiZDQzMGM5OGEzYzUwZWMxNzBmNTkyZjk0
NDA4MWE2ZQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggWGllIDxBbGV4QmluLlhpZUBhbWQuY29tPgo+
IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCAyICstCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gaW5kZXggODc4NTQyMC4uY2Y4NzdkZiAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gQEAgLTEyMDQsNyAr
MTIwNCw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LAo+ICAgCSAqIHJlc2VydmUgc3BhY2UgZm9yIG9uZSBjb21tYW5k
IGV2ZXJ5ICgxIDw8IEJMT0NLX1NJWkUpCj4gICAJICogIGVudHJpZXMgb3IgMmsgZHdvcmRzICh3
aGF0ZXZlciBpcyBzbWFsbGVyKQo+ICAgCSAqLwo+IC0JbmNtZHMgPSAobnB0ZXMgPj4gbWluKGFk
ZXYtPnZtX21hbmFnZXIuYmxvY2tfc2l6ZSwgMTEpKSArIDE7Cj4gKwluY21kcyA9IChucHRlcyA+
PiBtaW4oYWRldi0+dm1fbWFuYWdlci5ibG9ja19zaXplLCAxMXUpKSArIDE7Cj4KPiAgIAkvKiBw
YWRkaW5nLCBldGMuICovCj4gICAJbmR3ID0gNjQ7Cj4KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
