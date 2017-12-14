From: Thomas Hellstrom <thomas-4+hqylr40dJg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/6] drm/ttm: add on_alloc_stage and reservation into
 ttm_operation_ctx
Date: Thu, 14 Dec 2017 09:55:28 +0100
Message-ID: <834f3be6-ba20-06aa-24e4-d0a8d4777545@shipmail.org>
References: <1513071228-29551-1-git-send-email-Hongbo.He@amd.com>
 <8750cd4e-c86a-a011-7bf4-ea74df3cc7ff@shipmail.org>
 <393e18d9-cca1-3ca5-c0d0-0ce794246252@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <393e18d9-cca1-3ca5-c0d0-0ce794246252-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, Roger He <Hongbo.He-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

SGksIENocmlzdGlhbiwKCk9uIDEyLzE0LzIwMTcgMDk6NDAgQU0sIENocmlzdGlhbiBLw7ZuaWcg
d3JvdGU6Cj4gSGkgVGhvbWFzLAo+Cj4gc29ycnkgZm9yIHRoYXQuIE5vdGVkIG9uIHRoZSByZXN0
IG9mIHRoYXQgc2VyaWVzIGFzIHdlbGwgdGhhdCB3ZSBuZWVkIAo+IHRvIGltcHJvdmUgdGhlIGNv
bW1pdCBtZXNzYWdlcy4gQnV0IHRoaXMgb25lIHNvbWVob3cgc2xpcHBlZCB0aHJvdWdoIAo+IGJl
Y2F1c2UgSSBkaXNjdXNzZWQgdGhpcyBjaGFuZ2UgcHJldmlvdXNseSBpbnRlcm5hbGx5IHdpdGgg
Um9nZXIuCj4KPiBUaGF0IG1hZGUgdGhlIGNoYW5nZSBjb21wbGV0ZWx5IGxvZ2ljYWwgZm9yIG1l
LCBidXQgd2l0aG91dCB0aGlzIAo+IGNvbnRleHQgZXZlcnlib2R5IGVsc2UganVzdCB0aGlua3Mg
Ikh1aSB3aGF0PyIuIEdvaW5nIHRvIGtlZXAgdGhhdCBpbiAKPiBtaW5kIHRoZSBuZXh0IHRpbWUu
Cj4KPiBCdXQgYmFjayB0byB0b3BpYzogVGhpcyBzZXJpZXMgYWxsb3dzIEJPcyB3aGljaCBzaGFy
ZSB0aGUgc2FtZSAKPiByZXNlcnZhdGlvbiBvYmplY3QgYXMgdGhlIEJPIGN1cnJlbnRseSBhbGxv
Y2F0ZWQvdmFsaWRhdGVkIHRvIGJlIAo+IGV2aWN0ZWQgZXZlbiB3aGVuIHRoZXkgYXJlIHJlc2Vy
dmVkLgo+Cj4gVGhpcyBpcyB1c2VmdWwgYmVjYXVzZSBhbWRncHUgd2FudHMgdG8gdXNlIGEgc2lu
Z2xlIHJlc2VydmF0aW9uIG9iamVjdCAKPiBmb3IgYWxtb3N0IGFsbCBCT3Mgb2YgYSBwcm9jZXNz
LgoKWWVzLCB0aGF0IGluZGVlZCBtYWtlcyB0aGUgd2hvbGUgdGhpbmcgbW9yZSBjbGVhciwgYW5k
IG1ha2VzIHNlbnNlLgoKT3V0IG9mIGludGVyZXN0LCBpcyB0aGUgc2hhcmVkIHJlc2VydmF0aW9u
IG9iamVjdCB1c2FnZSBhIHNwZWVkIApvcHRpbWl6YXRpb24gKGF2b2lkaW5nIHRoZSB3d19tdXRl
eF9sb2NrcyBhdCByZXNlcnZhdGlvbiB0aW1lPykKb3Igc29tZXRoaW5nIGVsc2U/CgpJIGd1ZXNz
IHRoYXQgZXZlbiBpZiBMUlUgbGlzdHMgbWlnaHQgZ2V0IGNyb3dkZWQgd2l0aCB1bmV2aWN0YWJs
ZSBCT3MsIAppdGVyYXRpbmcgdGhyb3VnaCB0aG9zZSBsaXN0cyBpc24ndCByZWFsbHkgcGFydCBv
ZiB0aGUgZmFzdCBwYXRoLgovVGhvbWFzCgo+Cj4gUmVnYXJkcywKPiBDaHJpc3RpYW4uIAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
