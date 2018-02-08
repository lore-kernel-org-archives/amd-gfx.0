From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] drm: add func to get max iomem address
Date: Thu, 8 Feb 2018 10:18:00 +0100
Message-ID: <e1768e1b-bc7f-d645-b20b-abb8cf056d67@gmail.com>
References: <20180208083238.8291-1-david1.zhou@amd.com>
 <ba2e0c80-ca21-7969-8fd3-45c00e1c3254@daenzer.net>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ba2e0c80-ca21-7969-8fd3-45c00e1c3254-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org

QW0gMDguMDIuMjAxOCB1bSAxMDowOSBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTgt
MDItMDggMDk6MzIgQU0sIENodW5taW5nIFpob3Ugd3JvdGU6Cj4+IGl0IHdpbGwgYmUgdXNlZCB0
byBjaGVjayBpZiB0aGUgZHJpdmVyIG5lZWRzIHN3aW90bGIKPj4KPj4gQ2hhbmdlLUlkOiBJZGJl
NDdhZjhmMTIwMzJkNDgwM2JiM2Q0NzI3M2U4MDdmMTkxNjljMwo+PiBTaWduZWQtb2ZmLWJ5OiBD
aHVubWluZyBaaG91IDxkYXZpZDEuemhvdUBhbWQuY29tPgo+PiBSZXZpZXdlZC1ieTogTW9uayBM
aXUgPG1vbmsubGl1QGFtZC5jb20+Cj4+IC0tLQo+PiAgIGluY2x1ZGUvZHJtL2RybV9jYWNoZS5o
IHwgMTMgKysrKysrKysrKysrKwo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCsp
Cj4+Cj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9kcm1fY2FjaGUuaCBiL2luY2x1ZGUvZHJt
L2RybV9jYWNoZS5oCj4+IGluZGV4IGJlYWIwZjBkMGNmYi4uNDQyYzliYTYzZDAzIDEwMDY0NAo+
PiAtLS0gYS9pbmNsdWRlL2RybS9kcm1fY2FjaGUuaAo+PiArKysgYi9pbmNsdWRlL2RybS9kcm1f
Y2FjaGUuaAo+PiBAQCAtMzksNiArMzksMTkgQEAgdm9pZCBkcm1fY2xmbHVzaF9wYWdlcyhzdHJ1
Y3QgcGFnZSAqcGFnZXNbXSwgdW5zaWduZWQgbG9uZyBudW1fcGFnZXMpOwo+PiAgIHZvaWQgZHJt
X2NsZmx1c2hfc2coc3RydWN0IHNnX3RhYmxlICpzdCk7Cj4+ICAgdm9pZCBkcm1fY2xmbHVzaF92
aXJ0X3JhbmdlKHZvaWQgKmFkZHIsIHVuc2lnbmVkIGxvbmcgbGVuZ3RoKTsKPj4gICAKPj4gK3N0
YXRpYyBpbmxpbmUgdTY0IGRybV9nZXRfbWF4X2lvbWVtKHZvaWQpCj4+ICt7Cj4+ICsJc3RydWN0
IHJlc291cmNlICp0bXA7Cj4+ICsJdTY0IG1heF9pb21lbSA9IDA7Cj4+ICsKPj4gKwlmb3IgKHRt
cCA9IGlvbWVtX3Jlc291cmNlLmNoaWxkOyB0bXA7IHRtcCA9IHRtcC0+c2libGluZykgewo+PiAr
CQltYXhfaW9tZW0gPSBtYXgobWF4X2lvbWVtLCAgdG1wLT5lbmQpOwo+PiArCX0KPj4gKwo+PiAr
CXJldHVybiBtYXhfaW9tZW07Cj4+ICt9Cj4gSSBkb24ndCB0aGluayB0aGlzIG5lZWRzIHRvIGJl
IGFuIGlubGluZSBmdW5jdGlvbiwgZG9lcyBpdD8KCldlbGwgaXQgaXMgZGVmaW5lZCBpbiBhIGhl
YWRlciwgc28gaXQgbXVzdCBiZSBpbmxpbmUgYmVjYXVzZSBvZiB0aGlzLgoKQnV0IGlmIHlvdSBr
bm93IGEgZ29vZCBwbGFjZSwgd2UgY291bGQgYWxzbyBtb3ZlIGl0IGludG8gc29tZSBDIGZpbGUu
CgpDaHJpc3RpYW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
