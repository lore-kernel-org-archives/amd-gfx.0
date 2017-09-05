From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 5/8] drm/amdkfd: Use PASID manager from KGD
Date: Tue, 5 Sep 2017 11:39:52 -0400
Message-ID: <38861266-8859-bccc-1fd3-609dc7697175@amd.com>
References: <1504045524-23853-1-git-send-email-Felix.Kuehling@amd.com>
 <1504045524-23853-6-git-send-email-Felix.Kuehling@amd.com>
 <CAFCwf13voQSyLFp8smtgMa=ZRRgrf+7H3wzfnF0cP+ak4tMhGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAFCwf13voQSyLFp8smtgMa=ZRRgrf+7H3wzfnF0cP+ak4tMhGw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

Ck9uIDIwMTctMDktMDMgMDc6NTQgQU0sIE9kZWQgR2FiYmF5IHdyb3RlOgo+IERvbid0IHlvdSBu
ZWVkIHRvIGFsbG9jYXRlIFBBU0lEIG9uIGFsbCBwb3NzaWJsZSBkZXZpY2VzID8KPiBJZiBzbywg
ZG9lcyBpdCBuZWVkIHRvIGJlIHRoZSBzYW1lIG9uIGFsbCBkZXZpY2VzID8KVGhlIFBBU0lEIGFs
bG9jYXRvciBpcyBnbG9iYWwgKG5vdCBwZXItZGV2aWNlKSwgc28gdGhlIFBBU0lEIGlzIGludGVu
ZGVkCnRvIGJlIHRoZSBzYW1lIGZvciBhbGwgZGV2aWNlcy4gSSBvbmx5IG5lZWQgdG8gZmluZCBh
IGRldmljZSBmb3IgdGhlCmtmZDJrZ2QgaW50ZXJmYWNlIHBvaW50ZXIuIEluIGEgbXVsdGktR1BV
IHN5c3RlbSBpdCBkb2Vzbid0IG1hdHRlciB3aGljaApvbmUuIFRoZXkgYWxsIHNoYXJlIHRoZSBz
YW1lIFBBU0lEIGFsbG9jYXRvci4KClRlY2huaWNhbGx5LCBJIHRoaW5rIGRpZmZlcmVudCBkZXZp
Y2VzIGNvdWxkIHVzZSBkaWZmZXJlbnQgUEFTSURzIGZvcgp0aGUgc2FtZSBwcm9jZXNzLiBCdXQg
aXQgd291bGQgbWFrZSB0aGUgZHJpdmVyIG1vcmUgY29tcGxpY2F0ZWQgYW5kCnRoZXJlIGlzIG5v
IHJlYXNvbiB0byBkbyB0aGlzLgoKUmVnYXJkcywKICBGZWxpeAoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
