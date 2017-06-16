From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: don't check the default value for vm size
Date: Fri, 16 Jun 2017 19:38:39 +0200
Message-ID: <a02d2d43-9563-50f4-3d4b-f73563a92cd4@vodafone.de>
References: <1497565284-22459-1-git-send-email-alexander.deucher@amd.com>
 <c930dae8-3704-81df-4911-1842aefa1cc0@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c930dae8-3704-81df-4911-1842aefa1cc0-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTYuMDYuMjAxNyB1bSAwNDozNiBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDE2LzA2
LzE3IDA3OjIxIEFNLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4+IEF2b2lkcyBwcmludGluZyBzcHVy
aW91cyBtZXNzYWdlcyBsaWtlIHRoaXM6Cj4+IFsgICAgMy4xMDIwNTldIGFtZGdwdSAwMDAwOjAx
OjAwLjA6IFZNIHNpemUgKC0xKSBtdXN0IGJlIGEgcG93ZXIgb2YgMgo+Pgo+PiBTaWduZWQtb2Zm
LWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4+IC0tLQo+PiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDQgKysrKwo+PiAg
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+PiBpbmRleCA1MDAwMWJmLi5mZjkwZjc4IDEwMDY0
NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4+IEBAIC0x
MDc0LDYgKzEwNzQsMTAgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2NoZWNrX2Jsb2NrX3NpemUoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+ICAgCj4+ICAgc3RhdGljIHZvaWQgYW1kZ3B1X2No
ZWNrX3ZtX3NpemUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+ICAgewo+PiArCS8qIG5v
IG5lZWQgdG8gY2hlY2sgdGhlIGRlZmF1bHQgdmFsdWUgKi8KPj4gKwlpZiAoYW1kZ3B1X3ZtX3Np
emUgPT0gLTEpCj4+ICsJCXJldHVybjsKPj4gKwo+PiAgIAlpZiAoIWFtZGdwdV9jaGVja19wb3Rf
YXJndW1lbnQoYW1kZ3B1X3ZtX3NpemUpKSB7Cj4+ICAgCQlkZXZfd2FybihhZGV2LT5kZXYsICJW
TSBzaXplICglZCkgbXVzdCBiZSBhIHBvd2VyIG9mIDJcbiIsCj4+ICAgCQkJIGFtZGdwdV92bV9z
aXplKTsKPj4KPiBSZXZpZXdlZC1ieTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFt
ZC5jb20+Cj4KPgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+CgpBbmQgb25lIG1vcmUgaXRlbSByZW1vdmVkIGZyb20gbXkgdG9kbyBsaXN0IDop
CgpUaGFua3MsCgpDaHJpc3RpYW4uCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
