From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Shared semaphores for amdgpu
Date: Fri, 10 Mar 2017 13:25:42 +1000
Message-ID: <CAPM=9tz+3DB8zZTH1kRUt8KE-wU7RNeoOE6zQWn_dWDvVRSBMA@mail.gmail.com>
References: <544E607D03B20249AA404517E498FC469A558B@exchange01.valvesoftware.com>
 <BN4PR12MB0787AE3A185BE4D6916CE42AEE600@BN4PR12MB0787.namprd12.prod.outlook.com>
 <a25fdfeb-be5d-2d23-d7b1-ef14891ba6d5@gmail.com>
 <CAPM=9txG2KEw7AH553uFtuvoGYFK1=kmkPRJEHuA=8fq_JcY=w@mail.gmail.com>
 <58B4D68E.5080606@amd.com>
 <CAPM=9tw3nbGe+gaOpoBZeXfmS5+C3R4eK=uT8AL3krL0PMR0LA@mail.gmail.com>
 <CAPM=9twMvVoKCCmQUVsB6uD18j1e9cNq9eNqviVFy6F8v7OdOg@mail.gmail.com>
 <58C0FD86.8040808@amd.com> <d5a5f1ba-4bcb-f374-f18e-b060cc40aa9e@amd.com>
 <CAPM=9twfZhb7vt_gEBE6LaUfthseX_PC_BZctCyu520MK32QCQ@mail.gmail.com>
 <37118a87-28f2-c96d-18dc-a71292ea35d4@amd.com> <58C123A6.70209@amd.com>
 <a6a3ea27-aae2-dc69-1ec2-f463d8417712@vodafone.de>
 <CAPM=9tyn1gvTW5W3JbbxmzkN3PTwJjmOKCHiiU52ZOqGDJf_6A@mail.gmail.com>
 <85322d42-e585-659d-6f98-fc5baf0d6b14@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <85322d42-e585-659d-6f98-fc5baf0d6b14-5C7GfCeVMHo@public.gmane.org>
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
Cc: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, "Mao, David" <David.Mao-5C7GfCeVMHo@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Andres Rodriguez <andresr-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Cui, Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>, Pierre-Loup Griffais <pgriffais-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org>, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Pgo+IEFzIGZhciBhcyBJIGNhbiBzZWUgdGhlIG9ubHkgZnVuY3Rpb25hbGl0eSB3ZSBhcmUgbWlz
c2luZyBoZXJlIGlzOgo+Cj4gdm9pZCBzeW5jX2ZpbGVfc2lnbmFsKHN0cnVjdCBzeW5jX2ZpbGUg
KnN5bmNfZmlsZSwgc3RydWN0IGRtYV9mZW5jZSAqZmVuY2UpCj4gewo+ICAgICBkbWFfZmVuY2Vf
cHV0KHN5bmNfZmlsZS0+ZmVuY2UpOwo+ICAgICBzeW5jX2ZpbGUtPmZlbmNlID0gZmVuY2U7Cj4g
fQo+Cj4gV2UgcHJvYmFibHkgc2hvdWxkIGRvIHRoaXMgYXRvbWljYWxseSwgYnV0IHRoYXQgaXMg
b25seSBhIG1hdHRlciBvZiB0YWtpbmcKPiBsb2Nrcy9hdG9taWMgcG9pbnRlciBvcGVyYXRpb24u
Cj4KPiBUaGUgd2FpdGluZyBpcyBkb25lIHVzaW5nIHRoZSBub3JtYWwgc3luY19maWxlX2dldF9m
ZW5jZSgpIGZ1bmN0aW9uLgo+Cj4gVGhlIHJlc3QgaXMgRGF2aWQncyBwYXRjaCB0byBpbXBvcnQv
ZXhwb3J0IHRoZSBmZCBoYW5kbGUgaW50byBhIGxvY2FsIGlkcgo+IGJhc2VkIGhhbmRsZS4KCkFy
ZSB5b3Ugc3VnZ2VzdGluZyB3ZSBzdGFydCBrZWVwaW5nIHRyYWNrIG9mIHN5bmNfZmlsZSBvYmpl
Y3RzIGluIGEgbG9jYWwgaWRyPwoKQXMgY3VycmVudGx5IHRoZXkgYXJlIG9ubHkgdHJhY2tlZCBh
cyBmaWxlcywgd2hpY2ggaXMgcHJvYmFibHkgbm90IHdoYXQgd2Ugd2FudApmb3IgZXZlcnkgdW5z
aGFyZWQgc2VtYXBob3JlLCBvciBhcmUgeW91IHRoaW5raW5nIG1vcmUgdGhhdCB0aGUgYW1kZ3B1
IGxvY2FsCnNlbSBzaG91bGQgYmUganVzdCBzdG9yaW5nIGEgc3luY19maWxlIHBvaW50ZXIsIHJh
dGhlciB0aGFuIHdoYXQgaXQgZG9lcyBub3cuCgpEYXZlLgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
