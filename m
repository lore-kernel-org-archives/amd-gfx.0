From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix gtt_mgr bo's offset
Date: Tue, 20 Sep 2016 18:19:33 +0800
Message-ID: <57E10D35.5040006@amd.com>
References: <1474362552-9062-1-git-send-email-Flora.Cui@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1474362552-9062-1-git-send-email-Flora.Cui-5C7GfCeVMHo@public.gmane.org>
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
To: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

CgpPbiAyMDE25bm0MDnmnIgyMOaXpSAxNzowOSwgRmxvcmEgQ3VpIHdyb3RlOgo+IENoYW5nZS1J
ZDogSTg5ZTliZTNkNWM5NmQ0NjY1NWYzYTk3N2ZiNTU3YjIwYjRkODc2MDkKPiBTaWduZWQtb2Zm
LWJ5OiBGbG9yYSBDdWkgPEZsb3JhLkN1aUBhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2d0dF9tZ3IuYyB8IDQgKystLQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ3R0X21nci5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2d0dF9tZ3IuYwo+IGluZGV4IDI2MmU4NzIuLmIyNjZjZjcgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2d0dF9tZ3IuYwo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ndHRfbWdyLmMKPiBAQCAt
MTI4LDggKzEyOCw4IEBAIGludCBhbWRncHVfZ3R0X21ncl9hbGxvYyhzdHJ1Y3QgdHRtX21lbV90
eXBlX21hbmFnZXIgKm1hbiwKPiAgIAo+ICAgCWlmICghcikgewo+ICAgCQltZW0tPnN0YXJ0ID0g
bm9kZS0+c3RhcnQ7Cj4gLQkJdGJvLT5vZmZzZXQgPSAodGJvLT5tZW0uc3RhcnQgPDwgUEFHRV9T
SElGVCkgKwo+IC0JCSAgICB0Ym8tPmJkZXYtPm1hblt0Ym8tPm1lbS5tZW1fdHlwZV0uZ3B1X29m
ZnNldDsKPiArCQl0Ym8tPm9mZnNldCA9IChtZW0tPnN0YXJ0IDw8IFBBR0VfU0hJRlQpICsKPiAr
CQkgICAgdGJvLT5iZGV2LT5tYW5bbWVtLT5tZW1fdHlwZV0uZ3B1X29mZnNldDsKbWVtLT5tZW1f
dHlwZSBzZWVtcyBub3Qgc2V0IHlldCBhcyB3ZWxsIGlmIEkgYW0gY29ycmVjdC4KSUlSQywgSSBm
ZWVsIGl0J3MgYmV0dGVyIHRoYXQgdGJvLT5vZmZzZXQgaXMgc2V0IG91dCBvZiB0aGlzIGZ1bmN0
aW9uIAphZnRlciBnZXRfbm9kZSBzdWNjZXNzZnVsbHkuCgpSZWdhcmRzLApEYXZpZCBaaG91Cgo+
ICAgCX0KPiAgIAo+ICAgCXJldHVybiByOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
