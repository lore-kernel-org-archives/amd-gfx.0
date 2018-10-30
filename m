From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: disable page queue on SDMA for Vega12
Date: Tue, 30 Oct 2018 10:45:23 +0100
Message-ID: <83cbb602-2aaa-1a9c-f580-1893dbc126fd@gmail.com>
References: <1540885041-14731-1-git-send-email-Curry@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1540885041-14731-1-git-send-email-Curry-5C7GfCeVMHo@public.gmane.org>
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
To: Chen Gong <Curry-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, Curry.Gong-5C7GfCeVMHo@public.gmane.org

QW0gMzAuMTAuMTggdW0gMDg6Mzcgc2NocmllYiBDaGVuIEdvbmc6Cj4gRnJvbTogSnVud2VpIFpo
YW5nIDxKZXJyeS5aaGFuZ0BhbWQuY29tPgo+Cj4gSXQgYmxvY2tzIG1vc3Qgb2Ygc2FuaXR5IHRl
c3RzLCBzbyBkaXNhYmxlIGl0IGZvciBub3cuCj4KPiBUZXN0ZWQtYnk6IENoZW4gR29uZyA8Q3Vy
cnkuR29uZ0BhbWQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEp1bndlaSBaaGFuZyA8SmVycnkuWmhh
bmdAYW1kLmNvbT4KCkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8w
LmMgfCAzICsrLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRf
MC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMKPiBpbmRleCA4OGQ5
MzQzLi4zMTQzYWU4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Nk
bWFfdjRfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMK
PiBAQCAtMTQ3NCw3ICsxNDc0LDggQEAgc3RhdGljIGludCBzZG1hX3Y0XzBfZWFybHlfaW5pdCh2
b2lkICpoYW5kbGUpCj4gICAJCWFkZXYtPnNkbWEuaGFzX3BhZ2VfcXVldWUgPSBmYWxzZTsKPiAg
IAl9IGVsc2Ugewo+ICAgCQlhZGV2LT5zZG1hLm51bV9pbnN0YW5jZXMgPSAyOwo+IC0JCWlmIChh
ZGV2LT5hc2ljX3R5cGUgIT0gQ0hJUF9WRUdBMjApCj4gKwkJaWYgKGFkZXYtPmFzaWNfdHlwZSAh
PSBDSElQX1ZFR0EyMCAmJgo+ICsJCQkJYWRldi0+YXNpY190eXBlICE9IENISVBfVkVHQTEyKQo+
ICAgCQkJYWRldi0+c2RtYS5oYXNfcGFnZV9xdWV1ZSA9IHRydWU7Cj4gICAJfQo+ICAgCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
