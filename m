From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Use drm_dev_unplug in PCI .remove
Date: Fri, 31 Aug 2018 19:36:13 +0200
Message-ID: <307a2a9f-9aa9-5b3f-0728-57259af10141@gmail.com>
References: <1535731995-3343-1-git-send-email-andrey.grodzovsky@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1535731995-3343-1-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
To: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

QW0gMzEuMDguMjAxOCB1bSAxODoxMyBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+IFRoaXMg
YXQgbGVhc3QgYWxsb3dzIHRvIGZhaWwgYW55IHN1YnNlcXVlbnQgSU9DVExzIHdpdGggLUVOT0RF
Vgo+IGFmdGVyIHRoZSBkZXZpY2UgaXMgZ29uZS4KPiBTdGlsbCB0aGlzIG9wZXJhdGlvbiBpcyBu
b3Qgc3VwcG9ydGVkIHlldCBpbiBncmFwaGljIG1vZGUKPiBhbmQgd2lsbCBsZWFkIGF0IGxlYXN0
IHRvIHBhZ2UgZmF1bHRzIGFuZCBvdGhlciBpc3N1ZXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmRy
ZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lAYW1kLmNvbT4KCldlbGwgaXQgaXMgYSBz
dGFydCwgUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4uCgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5j
IHwgNCArKy0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
cnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwo+IGluZGV4IGQ3
ZDlhOWQuLjY2ZDE0ZDMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2Rydi5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ry
di5jCj4gQEAgLTk3OCw4ICs5NzgsOCBAQCBhbWRncHVfcGNpX3JlbW92ZShzdHJ1Y3QgcGNpX2Rl
diAqcGRldikKPiAgIHsKPiAgIAlzdHJ1Y3QgZHJtX2RldmljZSAqZGV2ID0gcGNpX2dldF9kcnZk
YXRhKHBkZXYpOwo+ICAgCj4gLQlkcm1fZGV2X3VucmVnaXN0ZXIoZGV2KTsKPiAtCWRybV9kZXZf
cHV0KGRldik7Cj4gKwlEUk1fSU5GTygiRGV2aWNlIHJlbW92YWwgaXMgY3VycmVudGx5IG5vdCBz
dXBwb3J0ZWQgb3V0c2lkZSBvZiBmYmNvblxuIik7Cj4gKwlkcm1fZGV2X3VucGx1ZyhkZXYpOwo+
ICAgCXBjaV9kaXNhYmxlX2RldmljZShwZGV2KTsKPiAgIAlwY2lfc2V0X2RydmRhdGEocGRldiwg
TlVMTCk7Cj4gICB9CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
