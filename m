From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Plus NULL function pointer check
Date: Tue, 13 Mar 2018 08:59:11 +0100
Message-ID: <45746f1c-377c-b610-083e-97d606038c80@gmail.com>
References: <1520917649-7995-1-git-send-email-Rex.Zhu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1520917649-7995-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

QW0gMTMuMDMuMjAxOCB1bSAwNjowNyBzY2hyaWViIFJleCBaaHU6Cj4gQ2hhbmdlLUlkOiBJZmQ2
NTUzNjQ2ZTc0NjhiYzkzNTUwNDA3NTgxNjA3NDM3M2UxZDU4ZAo+IFNpZ25lZC1vZmYtYnk6IFJl
eCBaaHUgPFJleC5aaHVAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMyArKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2aWNlLmMKPiBpbmRleCA1NmIyMjQ1Li4xODc1NTAwIDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+IEBAIC0xNDEzLDcgKzE0MTMsOCBA
QCBzdGF0aWMgaW50IGFtZGdwdV9kZXZpY2VfaXBfbGF0ZV9zZXRfY2dfc3RhdGUoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAJCQljb250aW51ZTsKPiAgIAkJLyogc2tpcCBDRyBmb3Ig
VkNFL1VWRCwgaXQncyBoYW5kbGVkIHNwZWNpYWxseSAqLwo+ICAgCQlpZiAoYWRldi0+aXBfYmxv
Y2tzW2ldLnZlcnNpb24tPnR5cGUgIT0gQU1EX0lQX0JMT0NLX1RZUEVfVVZEICYmCj4gLQkJICAg
IGFkZXYtPmlwX2Jsb2Nrc1tpXS52ZXJzaW9uLT50eXBlICE9IEFNRF9JUF9CTE9DS19UWVBFX1ZD
RSkgewo+ICsJCSAgICBhZGV2LT5pcF9ibG9ja3NbaV0udmVyc2lvbi0+dHlwZSAhPSBBTURfSVBf
QkxPQ0tfVFlQRV9WQ0UgJiYKPiArCQkgICAgYWRldi0+aXBfYmxvY2tzW2ldLnZlcnNpb24tPmZ1
bmNzLT5zZXRfY2xvY2tnYXRpbmdfc3RhdGUpIHsKPiAgIAkJCS8qIGVuYWJsZSBjbG9ja2dhdGlu
ZyB0byBzYXZlIHBvd2VyICovCj4gICAJCQlyID0gYWRldi0+aXBfYmxvY2tzW2ldLnZlcnNpb24t
PmZ1bmNzLT5zZXRfY2xvY2tnYXRpbmdfc3RhdGUoKHZvaWQgKilhZGV2LAo+ICAgCQkJCQkJCQkJ
CSAgICAgQU1EX0NHX1NUQVRFX0dBVEUpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
