From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 6/8] drm/amdkfd: New IOCTL to allocate queue GWS
Date: Fri, 31 May 2019 13:13:40 +1000
Message-ID: <CAPM=9tzs9adV7_ef4hpgswB-S==iQizAF_=FTarVm3EYwPCg0w@mail.gmail.com>
References: <1558651263-3478-1-git-send-email-Oak.Zeng@amd.com>
 <1558651263-3478-6-git-send-email-Oak.Zeng@amd.com>
 <4f49af4d-0953-030c-bb1b-47b7a5fa7c7c@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <4f49af4d-0953-030c-bb1b-47b7a5fa7c7c-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>, "Keely, Sean" <Sean.Keely-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

T24gU2F0LCAyNSBNYXkgMjAxOSBhdCAwNTo0OCwgS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVo
bGluZ0BhbWQuY29tPiB3cm90ZToKPgo+IE9uIDIwMTktMDUtMjMgNjo0MSBwLm0uLCBaZW5nLCBP
YWsgd3JvdGU6Cj4gPiBBZGQgYSBuZXcga2ZkIGlvY3RsIHRvIGFsbG9jYXRlIHF1ZXVlIEdXUy4g
UXVldWUKPiA+IEdXUyBpcyByZWxlYXNlZCBvbiBxdWV1ZSBkZXN0cm95Lgo+ID4KPiA+IENoYW5n
ZS1JZDogSTYwMTUzYzI2YTU3Nzk5MmFkODczZTQyOTJlNzU5ZTVjM2Q1YmJkMTUKPiA+IFNpZ25l
ZC1vZmYtYnk6IE9hayBaZW5nIDxPYWsuWmVuZ0BhbWQuY29tPgo+Cj4gUmV2aWV3ZWQtYnk6IEZl
bGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgo+CgpidHcganVzdCBub3RpY2Vk
IGluIHBhc3Npbmcgd2UgYXJlIGFkZGluZyBuZXcgZmVhdHVyZXMgdG8ga2ZkLCBpcwp0aGVyZSBh
biBvcGVuIHNvdXJjZSBkZXZlbG9wZWQgdXNlcnNwYWNlIHRvIGdvIGFsb25nIHdpdGggdGhpcywg
dGhlcmUKbmVlZHMgdG8gYSBkZXYgYnJhbmNoIGluIHB1YmxpYyBiZWZvcmUgbmV3IGlvY3Rscy91
YXBpIHN1cmZhY2VzIHNob3VsZApiZSBhZGRlZCB0byB0aGUga2VybmVsLgoKVGhlIGNvbW1pdHMg
c2hvdWxkIHByb2JhYmx5IGhhdmUgcG9pbnRlcnMgdG8gdGhhdCBicmFuY2guCgpEYXZlLgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
