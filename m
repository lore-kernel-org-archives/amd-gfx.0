From: Jerry Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix duplicated code
Date: Tue, 21 Mar 2017 10:34:07 +0800
Message-ID: <58D0911F.9070601@amd.com>
References: <1490062243-547-1-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490062243-547-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

Ck9uIDAzLzIxLzIwMTcgMTA6MTAgQU0sIENodW5taW5nIFpob3Ugd3JvdGU6Cj4gaXQgY291bGQg
Y29tZSBmcm9tIGJyYW5jaCBtZXJnZS4KPgo+IENoYW5nZS1JZDogSTE2OTU5YWFkNmNhNmQ2NGNi
ODMzMGYyM2VlNjQ3MmVlYzRjZjJhM2UKPiBTaWduZWQtb2ZmLWJ5OiBDaHVubWluZyBaaG91IDxE
YXZpZDEuWmhvdUBhbWQuY29tPgpSZXZpZXdlZC1ieTogSnVud2VpIFpoYW5nIDxKZXJyeS5aaGFu
Z0BhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmMgfCA0IC0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBpbmRleCA4MWMzYzc1Li5kZDdkZjQ1IDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBAQCAtOTkwLDEwICs5
OTAsNiBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZyhzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwKPgo+ICAgCXJpbmcgPSBjb250YWluZXJfb2Yodm0tPmVudGl0eS5z
Y2hlZCwgc3RydWN0IGFtZGdwdV9yaW5nLCBzY2hlZCk7Cj4KPiAtCW1lbXNldCgmcGFyYW1zLCAw
LCBzaXplb2YocGFyYW1zKSk7Cj4gLQlwYXJhbXMuYWRldiA9IGFkZXY7Cj4gLQlwYXJhbXMuc3Jj
ID0gc3JjOwo+IC0KPiAgIAkvKiBzeW5jIHRvIGV2ZXJ5dGhpbmcgb24gdW5tYXBwaW5nICovCj4g
ICAJaWYgKCEoZmxhZ3MgJiBBTURHUFVfUFRFX1ZBTElEKSkKPiAgIAkJb3duZXIgPSBBTURHUFVf
RkVOQ0VfT1dORVJfVU5ERUZJTkVEOwo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
