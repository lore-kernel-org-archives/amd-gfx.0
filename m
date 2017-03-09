From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Shared semaphores for amdgpu
Date: Thu, 9 Mar 2017 18:15:25 +1000
Message-ID: <CAPM=9twfZhb7vt_gEBE6LaUfthseX_PC_BZctCyu520MK32QCQ@mail.gmail.com>
References: <544E607D03B20249AA404517E498FC469A558B@exchange01.valvesoftware.com>
 <BN4PR12MB0787AE3A185BE4D6916CE42AEE600@BN4PR12MB0787.namprd12.prod.outlook.com>
 <a25fdfeb-be5d-2d23-d7b1-ef14891ba6d5@gmail.com>
 <CAPM=9txG2KEw7AH553uFtuvoGYFK1=kmkPRJEHuA=8fq_JcY=w@mail.gmail.com>
 <58B4D68E.5080606@amd.com>
 <CAPM=9tw3nbGe+gaOpoBZeXfmS5+C3R4eK=uT8AL3krL0PMR0LA@mail.gmail.com>
 <CAPM=9twMvVoKCCmQUVsB6uD18j1e9cNq9eNqviVFy6F8v7OdOg@mail.gmail.com>
 <58C0FD86.8040808@amd.com> <d5a5f1ba-4bcb-f374-f18e-b060cc40aa9e@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d5a5f1ba-4bcb-f374-f18e-b060cc40aa9e-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Mao,
 David" <David.Mao-5C7GfCeVMHo@public.gmane.org>, Andres Rodriguez <andresr-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org>, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Cui,
 Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>, Pierre-Loup Griffais <pgriffais-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org>

T24gOSBNYXJjaCAyMDE3IGF0IDE3OjM4LCBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+IHdyb3RlOgo+PiBJIGRvIHdvbmRlciBpZiB3ZSBuZWVkIHRoZSBzZXBhcmF0
ZSBzZW0gc2lnbmFsL3dhaXQgaW50ZXJmYWNlLCBJIHRoaW5rCj4+IHdlIHNob3VsZCBqdXN0IGFk
ZAo+PiBzZW1hcGhvcmUgY2h1bmtzIHRvIHRoZSBDUyBpbnRlcmZhY2UuCj4KPiBZZWFoLCB0aGF0
J3Mgd2hhdCBJJ3ZlIHNhaWQgYXMgd2VsbCBmcm9tIHRoZSB2ZXJ5IGZpcnN0IGJlZ2lubmluZy4K
Pgo+IEFub3RoZXIgcXVlc3Rpb24gaXMgaWYgd2Ugc2hvdWxkIHJlYWxseSBjcmVhdGUgYW5vdGhl
ciBpbXBsZW1lbnRhdGlvbiB0bwo+IHNoYXJlIHNlbWFwaG9yZXMgYmV0d2VlbiBwcm9jZXNzZXMu
Cj4KPiBJbiBvdGhlciB3b3JkcyBwdXR0aW5nIHRoZSBjdXJyZW50IGZlbmNlcyBpbnNpZGUgdGhl
IHNlbWFwaG9yZSBpbnRvIGEKPiBzeW5jX2ZpbGUgd2l0aCB0aGUgc2lnbmFsX29uX2FueSBiaXQg
c2V0IHdvdWxkIGhhdmUgcHJldHR5IG11Y2ggdGhlIHNhbWUKPiBlZmZlY3QsIGV4Y2VwdCB0aGF0
IHRoZSByZXN1bHRpbmcgb2JqZWN0IHRoZW4gaGFkIHRoZSBzeW5jX2ZpbGUgc2VtYW50aWNzCj4g
Zm9yIGFkZGluZyBuZXcgZmVuY2VzIGFuZCBjYW4gYmUgdXNlZCBpbiB0aGUgYXRvbWljIElPQ1RM
cyBhcyB3ZWxsLgoKU28gdGhlIHZ1bGthbiBleHRlcm5hbCBzZW1hcGhvcmUgc3BlYyBoYXMgdHdv
IGRpZmZlcmVudCB0eXBlIG9mIHNlbWFwaG9yZQpzZW1hbnRpY3MsIEknbSBub3Qgc3VyZSB0aGUg
c3luY19maWxlIHNlbWFudGljcyBtYXRjaCB0aGUgZmlyc3QgdHlwZSwKb25seSB0aGUgc2Vjb25k
LgoKCkkgdGhpbmsgd2Ugd291bGQgc3RpbGwgbmVlZCBzZXBhcmF0ZSBvYmplY3RzIHRvIGRvIHRo
ZSBmaXJzdCB0eXBlLAp3aGljaCBJIHdhbnQgZm9yIFZSIHN0dWZmLi4KCkknbGwgdHJ5IGFuZCB0
aGluayBhYm91dCBpdCBhIGJpdCBoYXJkZXIgdG9tb3Jyb3cuCgpEYXZlLgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
