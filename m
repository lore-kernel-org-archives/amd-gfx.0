From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix iova debugfs for non-iommu case
Date: Tue, 19 Sep 2017 13:14:02 -0400
Message-ID: <5fbdcf5d-3be9-5af9-2321-8c59ebac4bb3@amd.com>
References: <20170919153042.9994-1-tom.stdenis@amd.com>
 <e9302f12-3f26-5176-79d1-5d837e44ebd5@amd.com>
 <1e817718-572a-6d77-f948-ef3ed5eeef0c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1e817718-572a-6d77-f948-ef3ed5eeef0c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMTkvMDkvMTcgMDE6MTAgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQXMgZmFyIGFz
IEkga25vdyB3ZSBkb24ndCBuZWVkICNpZmRlZnMgY2F1c2UgdGhlcmUgYXJlIGR1bW15IGZ1bmN0
aW9ucyAKPiB3aGVuIElPTU1VIGlzIG5vdCBjb21waWxlZCBpbi4KPiAKPiBCdXQgdGhpcyBwYXRj
aCBpcyBhIE5BSyBzaW5jZSBpdCBjaXJjdW12ZW50cyB0aGUgL2Rldi9tZW0gcmVzdHJpY3Rpb24g
Cj4gd2hlbiBJT01NVSBpcyBkaXNhYmxlZCBhbmQgdGhhdCBpcyBub3Qgc29tZXRoaW5nIHdlIGNh
biBlYXNpbHkgYWxsb3cuCgpJIHJhaXNlZCB0aGlzIG9iamVjdGlvbiAyNCBob3VycyBhZ28gYW5k
IHdhcyB0b2xkIHRvIGdvIGFoZWFkIHdpdGggdGhlIApyZWFkL3dyaXRlIG1ldGhvZHMgYW55d2F5
cy4KClNob3J0IG9mIG1ha2luZyBhIGxpc3Qgb2YgbWFwcGluZ3MvYWxsb2NhdGlvbnMgaW4gdGhl
IHR0bSBsYXllciBJIGhhdmUgCm5vIGlkZWEgaG93IHdlIHdvdWxkIHRyYWNrIHRoaXMgaW4gdGhl
IG5vbi1pb21tdSBjYXNlIHdoaWNoIG1lYW5zIHRoZSAKZW50aXJlIGlvdmEgZGVidWdmcyBlbnRy
eSBzaG91bGQgaGF2ZSBiZWVuIE5BSydlZCBpbiB0aGUgZmlyc3QgcGxhY2UuCgpJJ20gb3BlbiB0
byBzdWdnZXN0aW9ucy4KClRvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
