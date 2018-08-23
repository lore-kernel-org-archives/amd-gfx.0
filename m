From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 07/11] drm/amdgpu: add GMC9 support for PDs/PTs in system
 memory
Date: Thu, 23 Aug 2018 10:50:49 +0800
Message-ID: <5B7E2109.3020406@amd.com>
References: <20180822150517.2330-1-christian.koenig@amd.com>
 <20180822150517.2330-7-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180822150517.2330-7-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDgvMjIvMjAxOCAxMTowNSBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBZGQgdGhl
IG5lY2Vzc2FyeSBoYW5kbGluZy4KPgo+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCkxvb2tzIGdvaW5nIHRvIHVzZSBHVFQgZm9yIHBh
Z2UgdGFibGUuCldoYXQga2luZCBvZiBzY2VuYXJpbyB0byB1c2UgdGhhdD8KY291bGQgaXQgYmUg
cmVwbGFjZWQgYnkgQ1BVIHVwZGF0aW5nIHBhZ2UgdGFibGUgaW4gc3lzdGVtIG1lbW9yeT8KClJl
Z2FyZHMsCkplcnJ5Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5
XzAuYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8w
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCj4gaW5kZXggZTQxMmVi
OGUzNDdjLi4zMzkzYTMyOWZjOWMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ21jX3Y5XzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192
OV8wLmMKPiBAQCAtNTcxLDcgKzU3MSw3IEBAIHN0YXRpYyB1aW50NjRfdCBnbWNfdjlfMF9nZXRf
dm1fcHRlX2ZsYWdzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAgc3RhdGljIHZvaWQg
Z21jX3Y5XzBfZ2V0X3ZtX3BkZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgaW50IGxldmVs
LAo+ICAgCQkJCXVpbnQ2NF90ICphZGRyLCB1aW50NjRfdCAqZmxhZ3MpCj4gICB7Cj4gLQlpZiAo
ISgqZmxhZ3MgJiBBTURHUFVfUERFX1BURSkpCj4gKwlpZiAoISgqZmxhZ3MgJiBBTURHUFVfUERF
X1BURSkgJiYgISgqZmxhZ3MgJiBBTURHUFVfUFRFX1NZU1RFTSkpCj4gICAJCSphZGRyID0gYWRl
di0+dm1fbWFuYWdlci52cmFtX2Jhc2Vfb2Zmc2V0ICsgKmFkZHIgLQo+ICAgCQkJYWRldi0+Z21j
LnZyYW1fc3RhcnQ7Cj4gICAJQlVHX09OKCphZGRyICYgMHhGRkZGMDAwMDAwMDAwMDNGVUxMKTsK
PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
