From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm: Implement vm_operations_struct.access
Date: Fri, 14 Jul 2017 15:46:46 -0400
Message-ID: <146e6d38-d162-ca3d-62a9-0a8cd9f4c568@amd.com>
References: <1499980105-7721-1-git-send-email-Felix.Kuehling@amd.com>
 <8b708b8e-cf4f-d553-811f-a7849fbf6eff@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <8b708b8e-cf4f-d553-811f-a7849fbf6eff-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Content-Language: en-CA
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMTctMDctMTQgMDY6MDYgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTMuMDcu
MjAxNyB1bSAyMzowOCBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+PiBBbGxvd3MgZ2RiIHRvIGFj
Y2VzcyBjb250ZW50cyBvZiB1c2VyIG1vZGUgbWFwcGVkIEJPcy4gVlJBTSBhY2Nlc3MKPj4gcmVx
dWlyZXMgdGhlIGRyaXZlciB0byBpbXBsZW1lbnQgYSBuZXcgY2FsbGJhY2sgaW4gdHRtX2JvX2Ry
aXZlci4KPgo+IE9uZSBtb3JlIGNvbW1lbnQgYWRkaXRpb25hbGx5IHRvIHdoYXQgTWljaGVsIGFs
cmVhZHkgd3JvdGUgYmVsb3csCj4gYXBhcnQgZnJvbSB0aGF0IGl0IGxvb2tzIGdvb2QgdG8gbWUu
Cj4KPj4KPj4gKyAgICBzd2l0Y2goYm8tPm1lbS5tZW1fdHlwZSkgewo+PiArICAgIGNhc2UgVFRN
X1BMX1NZU1RFTToKPgo+IFdoZW4gdGhlIEJPIGlzIGluIHRoZSBzeXN0ZW0gZG9tYWluIHlvdSBu
ZWVkIHRvIGFkZCB0aGlzIGFzIHdlbGwgSSB0aGluazoKPgo+ICAgICAgICAgaWYgKHVubGlrZWx5
KGJvLT50dG0tPnBhZ2VfZmxhZ3MgJiBUVE1fUEFHRV9GTEFHX1NXQVBQRUQpKSB7Cj4gICAgICAg
ICAgICAgICAgIHJldCA9IHR0bV90dF9zd2FwaW4oYm8tPnR0bSk7Cj4gICAgICAgICAgICAgICAg
IGlmICh1bmxpa2VseShyZXQgIT0gMCkpCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJu
IHJldDsKPiAgICAgICAgIH0KCk9LLCB0aGFua3MgZm9yIHBvaW50aW5nIHRoYXQgb3V0LgoKUmVn
YXJkcywKICBGZWxpeAoKPgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
