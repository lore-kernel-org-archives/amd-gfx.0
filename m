From: "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: MC_VM_FB_OFFSET is pf only register.
Date: Wed, 15 Aug 2018 09:52:12 +0000
Message-ID: <CY4PR12MB1125D4E1E875A1B6B90BA2FA8F3F0@CY4PR12MB1125.namprd12.prod.outlook.com>
References: <1534326508-17477-1-git-send-email-Emily.Deng@amd.com>
 <1534326508-17477-2-git-send-email-Emily.Deng@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1534326508-17477-2-git-send-email-Emily.Deng-5C7GfCeVMHo@public.gmane.org>
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
To: "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

U29ycnksIHNlbnQgdGhlIHdyb25nIHBhdGNoLCBwbGVhc2UgaWdub3JlIHRoaXMgZW1haWwuCgo+
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPkZyb206IEVtaWx5IERlbmcgPEVtaWx5LkRlbmdA
YW1kLmNvbT4KPlNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDE1LCAyMDE4IDU6NDggUE0KPlRvOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+Q2M6IERlbmcsIEVtaWx5IDxFbWlseS5EZW5n
QGFtZC5jb20+Cj5TdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IE1DX1ZNX0ZCX09GRlNFVCBp
cyBwZiBvbmx5IHJlZ2lzdGVyLgo+Cj5TaWduZWQtb2ZmLWJ5OiBFbWlseSBEZW5nIDxFbWlseS5E
ZW5nQGFtZC5jb20+Cj4tLS0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5j
IHwgNSArKysrLQo+IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKPgo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMK
PmIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+aW5kZXggYjYwZWQyOC4u
NTJiMTNlNiAxMDA2NDQKPi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8w
LmMKPisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPkBAIC02OTMs
NyArNjkzLDEwIEBAIHN0YXRpYyB2b2lkIGdtY192OV8wX3ZyYW1fZ3R0X2xvY2F0aW9uKHN0cnVj
dAo+YW1kZ3B1X2RldmljZSAqYWRldiwKPiAJYW1kZ3B1X2RldmljZV92cmFtX2xvY2F0aW9uKGFk
ZXYsICZhZGV2LT5nbWMsIGJhc2UpOwo+IAlhbWRncHVfZGV2aWNlX2dhcnRfbG9jYXRpb24oYWRl
diwgbWMpOwo+IAkvKiBiYXNlIG9mZnNldCBvZiB2cmFtIHBhZ2VzICovCj4tCWFkZXYtPnZtX21h
bmFnZXIudnJhbV9iYXNlX29mZnNldCA9Cj5nZnhodWJfdjFfMF9nZXRfbWNfZmJfb2Zmc2V0KGFk
ZXYpOwo+KwlpZiAoIWFtZGdwdV9zcmlvdl92ZihhZGV2KSkKPisJCWFkZXYtPnZtX21hbmFnZXIu
dnJhbV9iYXNlX29mZnNldCA9Cj5nZnhodWJfdjFfMF9nZXRfbWNfZmJfb2Zmc2V0KGFkZXYpOwo+
KwllbHNlCj4rCQlhZGV2LT52bV9tYW5hZ2VyLnZyYW1fYmFzZV9vZmZzZXQgPSAwOwo+IH0KPgo+
IC8qKgo+LS0KPjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
