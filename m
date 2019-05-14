From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/sriov: Need to initialize the
 HDP_NONSURFACE_BAStE
Date: Tue, 14 May 2019 13:04:52 +0200
Message-ID: <82fa6b02-473c-5d83-6cec-7d72fd19f48f@gmail.com>
References: <1557831559-6925-1-git-send-email-Tiecheng.Zhou@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1557831559-6925-1-git-send-email-Tiecheng.Zhou-5C7GfCeVMHo@public.gmane.org>
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
To: Tiecheng Zhou <Tiecheng.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>

QW0gMTQuMDUuMTkgdW0gMTI6NTkgc2NocmllYiBUaWVjaGVuZyBaaG91Ogo+IGl0IHJlcXVpcmVz
IHRvIGluaXRpYWxpemUgSERQX05PTlNVUkZBQ0VfQkFTRSwgc28gYXMgdG8gYXZvaWQKPiB1c2lu
ZyB0aGUgdmFsdWUgbGVmdCBieSBhIHByZXZpb3VzIFZNIHVuZGVyIHNyaW92IHNjZW5hcmlvLgo+
Cj4gdjI6IGl0IHNob3VsZCBub3QgaHVydCBiYXJlbWV0YWwsIGdlbmVyYWxpemUgaXQgZm9yIGJv
dGggc3Jpb3YKPiBhbmQgYmFyZW1ldGFsCj4KPiBTaWduZWQtb2ZmLWJ5OiBFbWlseSBEZW5nIDxF
bWlseS5EZW5nQGFtZC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogVGllY2hlbmcgWmhvdSA8VGllY2hl
bmcuWmhvdUBhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
bWNfdjlfMC5jIHwgMyArKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+IGluZGV4IGJlNzI5ZTcuLmMyMjE1
NzAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPiBAQCAtMTE4MSw2
ICsxMTgxLDkgQEAgc3RhdGljIGludCBnbWNfdjlfMF9nYXJ0X2VuYWJsZShzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldikKPiAgIAl0bXAgPSBSUkVHMzJfU09DMTUoSERQLCAwLCBtbUhEUF9IT1NU
X1BBVEhfQ05UTCk7Cj4gICAJV1JFRzMyX1NPQzE1KEhEUCwgMCwgbW1IRFBfSE9TVF9QQVRIX0NO
VEwsIHRtcCk7Cj4gICAKPiArCVdSRUczMl9TT0MxNShIRFAsIDAsIG1tSERQX05PTlNVUkZBQ0Vf
QkFTRSwgKGFkZXYtPmdtYy52cmFtX3N0YXJ0ID4+IDgpKTsKPiArCVdSRUczMl9TT0MxNShIRFAs
IDAsIG1tSERQX05PTlNVUkZBQ0VfQkFTRV9ISSwgKGFkZXYtPmdtYy52cmFtX3N0YXJ0ID4+IDQw
KSk7Cj4gKwo+ICAgCS8qIEFmdGVyIEhEUCBpcyBpbml0aWFsaXplZCwgZmx1c2ggSERQLiovCj4g
ICAJYWRldi0+bmJpb19mdW5jcy0+aGRwX2ZsdXNoKGFkZXYsIE5VTEwpOwo+ICAgCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
