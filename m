From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: add cu info wave_front_size
Date: Fri, 28 Apr 2017 15:16:55 +0000
Message-ID: <BN6PR12MB165256375F2396F5F434DEEFF7130@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1493349046-23232-1-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1493349046-23232-1-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IEp1bndlaSBaaGFuZyBbbWFpbHRv
OkplcnJ5LlpoYW5nQGFtZC5jb21dCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDI3LCAyMDE3IDEx
OjExIFBNCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IERldWNoZXIs
IEFsZXhhbmRlcjsgV2FuZywgS2VuOyBaaGFuZywgSmVycnkKPiBTdWJqZWN0OiBbUEFUQ0hdIGRy
bS9hbWRncHU6IGFkZCBjdSBpbmZvIHdhdmVfZnJvbnRfc2l6ZQo+IAo+IG1pc3NlZCB0aGF0IGZv
ciBnZnggdjkgaW5mbyBleHBvcnQKPiAKPiBTaWduZWQtb2ZmLWJ5OiBKdW53ZWkgWmhhbmcgPEpl
cnJ5LlpoYW5nQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPgoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1LmggfCAxICsKPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4gCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCj4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaAo+IGluZGV4IDUwMzAxMGEuLmUzMzAwMDkgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaAo+IEBAIC05ODYsNiArOTg2LDcgQEAgc3Ry
dWN0IGFtZGdwdV9nZnhfY29uZmlnIHsKPiAgc3RydWN0IGFtZGdwdV9jdV9pbmZvIHsKPiAgCXVp
bnQzMl90IG51bWJlcjsgLyogdG90YWwgYWN0aXZlIENVIG51bWJlciAqLwo+ICAJdWludDMyX3Qg
YW9fY3VfbWFzazsKPiArCXVpbnQzMl90IHdhdmVfZnJvbnRfc2l6ZTsKPiAgCXVpbnQzMl90IGJp
dG1hcFs0XVs0XTsKPiAgfTsKPiAKPiAtLQo+IDEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
