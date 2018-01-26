From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: 'buf' pointer in ttm_bo_vm_access_kmap()
Date: Fri, 26 Jan 2018 15:38:31 +0100
Message-ID: <b7b27f3c-8b8e-1ead-f00c-c118f86b71fc@gmail.com>
References: <d3f92e9e-d0aa-1861-df8b-78320be94483@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d3f92e9e-d0aa-1861-df8b-78320be94483-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMjYuMDEuMjAxOCB1bSAxNTozMSBzY2hyaWViIFRvbSBTdCBEZW5pczoKPiBIaSBhbGwsCj4K
PiBJbiB0aGUgZnVuY3Rpb24gdHRtX2JvX3ZtX2FjY2Vzc19rbWFwKCkgaXQgZG9lc24ndCBzZWVt
IHRvIG1lIGxpa2UgdGhlIAo+ICdidWYnIHBvaW50ZXIgaXMgaW5jcmVtZW50ZWQuwqAgVGhhdCBz
ZWVtcyBsaWtlIGEgYnVnIG5vPwoKWWVhaCwgbG9va3Mgc3VzcGljaW91cyB0byBtZSBhcyB3ZWxs
LiBCdXQgVFRNIHF1ZXN0aW9ucyBzaG91bGQgQ0MgdGhlIApkcmkgbGlzdCBhcyB3ZWxsLgoKQW5k
IGluIHRoaXMgcGFydGljdWxhciBjYXNlIEkgdGhpbmsgRmVsaXggd2FzIHRoZSBhdXRob3IgdGhh
dCBmdW5jdGlvbi4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4KPiBDaGVlcnMsCj4gVG9tCj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1h
aWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
