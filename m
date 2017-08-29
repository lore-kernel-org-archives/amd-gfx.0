From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/5] drm/amdgpu: fix comment on amdgpu_bo_va
Date: Tue, 29 Aug 2017 10:19:21 +0800
Message-ID: <11c0c2cf-b785-a23d-5bb9-358693204c56@amd.com>
References: <1503946244-1535-1-git-send-email-deathsimple@vodafone.de>
 <1503946244-1535-3-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1503946244-1535-3-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

UmV2aWV3ZWQtYnk6IENodW5taW5nIFpob3UgPGRhdmlkMS56aG91QGFtZC5jb20+CgoKT24gMjAx
N+W5tDA45pyIMjnml6UgMDI6NTAsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gRnJvbTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Cj4gRXhjZXB0IGZvciB0
aGUgcmVmZXJlbmNlIGNvdW50IGFsbCBvdGhlciBtZW1iZXJzIGFyZSBwcm90ZWN0ZWQKPiBieSB0
aGUgVk0gUEQgYmVpbmcgcmVzZXJ2ZWQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmggfCA0ICsrKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfb2JqZWN0LmgKPiBpbmRleCBlNjEzYmE0Li40MjQ5MmU2IDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaAo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaAo+IEBAIC00OSw5ICs0OSwx
MSBAQCBzdHJ1Y3QgYW1kZ3B1X2JvX3ZhIHsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X3ZtX2JvX2Jhc2UJ
YmFzZTsKPiAgIAo+ICAgCS8qIHByb3RlY3RlZCBieSBibyBiZWluZyByZXNlcnZlZCAqLwo+IC0J
c3RydWN0IGRtYV9mZW5jZQkgICAgICAgICpsYXN0X3B0X3VwZGF0ZTsKPiAgIAl1bnNpZ25lZAkJ
CXJlZl9jb3VudDsKPiAgIAo+ICsJLyogYWxsIG90aGVyIG1lbWJlcnMgcHJvdGVjdGVkIGJ5IHRo
ZSBWTSBQRCBiZWluZyByZXNlcnZlZCAqLwo+ICsJc3RydWN0IGRtYV9mZW5jZQkgICAgICAgICps
YXN0X3B0X3VwZGF0ZTsKPiArCj4gICAJLyogbWFwcGluZ3MgZm9yIHRoaXMgYm9fdmEgKi8KPiAg
IAlzdHJ1Y3QgbGlzdF9oZWFkCQlpbnZhbGlkczsKPiAgIAlzdHJ1Y3QgbGlzdF9oZWFkCQl2YWxp
ZHM7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
