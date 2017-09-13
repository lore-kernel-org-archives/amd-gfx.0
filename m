From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/gfx9: implement wave VGPR reading
Date: Wed, 13 Sep 2017 14:06:46 -0400
Message-ID: <a96e83aa-0898-a039-2a9b-e9003b9c6d5e@amd.com>
References: <20170909104907.10048-1-nhaehnle@gmail.com>
 <6c2125a5-7bf2-b6e4-a6d0-ec44033bdbde@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <6c2125a5-7bf2-b6e4-a6d0-ec44033bdbde-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMTEvMDkvMTcgMDM6NDYgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMDkuMDku
MjAxNyB1bSAxMjo0OSBzY2hyaWViIE5pY29sYWkgSMOkaG5sZToKPj4gRnJvbTogTmljb2xhaSBI
w6RobmxlIDxuaWNvbGFpLmhhZWhubGVAYW1kLmNvbT4KPj4KPj4gVGhpcyBpcyBhbHJlYWR5IGhv
b2tlZCB1cCB0byB0aGUgImFtZGdwdV9ncHIiIGRlYnVnZnMgZmlsZSB1c2VkIGJ5Cj4+IHRoZSB1
bXIgdXNlcnNwYWNlIGRlYnVnZ2luZyB0b29sLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBOaWNvbGFp
IEjDpGhubGUgPG5pY29sYWkuaGFlaG5sZUBhbWQuY29tPgo+IAo+IEFja2VkLWJ5OiBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CgoKUmV2aWV3ZWQtYnk6IFRvbSBT
dCBEZW5pcyA8dG9tLnN0ZGVuaXNAYW1kLmNvbT4KCkFsc28gSSd2ZSB0ZXN0ZWQgaXQgdG8gdGhl
IGV4dGVudCB0aGF0IEkgY2FuIHJlYWQgb3V0IGRhdGEgdmlhIHVtciBvbiBteSAKUmF2ZW4gd2hp
bGUgcnVubmluZyBwaWdsaXQuCgpJbiBhbiBpZGVhbCB3b3JsZCBpdCdkIGJlIG5pY2UgdG8gaGF2
ZSBhIGtub3duLWFuc3dlci10ZXN0IHdoZXJlIHVtciAKcmVhZHMgb3V0IFNHUFJTL1ZHUFJTIGFu
ZCB3ZSBjaGVjayBhZ2FpbnN0IGtub3duIHZhbHVlcy4KClRvbQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
