From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/powerplay: fix spelling mistake "unsuported"
 -> "unsupported"
Date: Tue, 13 Aug 2019 09:58:31 -0400
Message-ID: <CADnq5_MihuON5NRn7gbjbD9br37=vL+ZtjNqqFE2XQGrA_P7Zw@mail.gmail.com>
References: <20190813103340.11051-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190813103340.11051-1-colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
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
To: Colin King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: David Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>, Rex Zhu <rex.zhu-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIFR1ZSwgQXVnIDEzLCAyMDE5IGF0IDY6MzMgQU0g
Q29saW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPiB3cm90ZToKPgo+IEZyb206IENv
bGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+Cj4KPiBUaGVyZSBpcyBhIHNw
ZWxsaW5nIG1pc3Rha2UgaW4gYSBwcl9lcnIgZXJyb3IgbWVzc2FnZS4gRml4IGl0LiBBbHNvCj4g
YWRkIGEgc3BhY2UgYWZ0ZXIgYSBjb21tYSB0byBjbGVhbiB1cCBhIGNoZWNrcGF0Y2ggd2Fybmlu
Zy4KPgo+IFNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNh
bC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5j
IHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jCj4gaW5kZXggOGJi
Y2YwMzQ3OTljLi5kMzI0YmQyODkzNGQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvc211X3YxMV8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9zbXVfdjExXzAuYwo+IEBAIC0yODgsNyArMjg4LDcgQEAgc3RhdGljIGludCBzbXVfdjEx
XzBfY2hlY2tfZndfdmVyc2lvbihzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkKPiAgICAgICAgICAg
ICAgICAgc211LT5zbWNfaWZfdmVyc2lvbiA9IFNNVTExX0RSSVZFUl9JRl9WRVJTSU9OX05WMTQ7
Cj4gICAgICAgICAgICAgICAgIGJyZWFrOwo+ICAgICAgICAgZGVmYXVsdDoKPiAtICAgICAgICAg
ICAgICAgcHJfZXJyKCJzbXUgdW5zdXBvcnRlZCBhc2ljIHR5cGU6JWQuXG4iLHNtdS0+YWRldi0+
YXNpY190eXBlKTsKPiArICAgICAgICAgICAgICAgcHJfZXJyKCJzbXUgdW5zdXBwb3J0ZWQgYXNp
YyB0eXBlOiVkLlxuIiwgc211LT5hZGV2LT5hc2ljX3R5cGUpOwo+ICAgICAgICAgICAgICAgICBz
bXUtPnNtY19pZl92ZXJzaW9uID0gU01VMTFfRFJJVkVSX0lGX1ZFUlNJT05fSU5WOwo+ICAgICAg
ICAgICAgICAgICBicmVhazsKPiAgICAgICAgIH0KPiAtLQo+IDIuMjAuMQo+Cj4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBkcmktZGV2ZWwgbWFpbGlu
ZyBsaXN0Cj4gZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
