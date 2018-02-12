From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 09/25] drm/amdgpu: Add GPUVM memory management functions
 for KFD
Date: Mon, 12 Feb 2018 14:20:52 -0500
Message-ID: <747ab93f-0498-d733-5eba-d7f0fbc3ff55@amd.com>
References: <1517967174-21709-1-git-send-email-Felix.Kuehling@amd.com>
 <1517967174-21709-10-git-send-email-Felix.Kuehling@amd.com>
 <CAFCwf10ThSfo8zphxPRH549LoyJ1H+XM89rpwpSNeJeuWYayAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAFCwf10ThSfo8zphxPRH549LoyJ1H+XM89rpwpSNeJeuWYayAA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

T24gMjAxOC0wMi0xMiAwMzo0MiBBTSwgT2RlZCBHYWJiYXkgd3JvdGU6Cj4gSGkgRmVsaXgsCj4g
SSB3cm90ZSBzb21lIG1pbm9yIGNvbW1lbnRzLiBJZiB5b3UgZG9uJ3Qgb2JqZWN0IHRvIHRoZW0s
IEknbGwganVzdAo+IGFkZCB0aGVtIHRvIHRoZSBwYXRjaCB0byBzYXZlIHlvdSB0aGUgdHJvdWJs
ZSBvZiByZS1zZW5kaW5nLgoKVGhhbmtzIGZvciBnb2luZyB0aHJvdWdoIHRoaXMuIEkgYWdyZWUg
d2l0aCB5b3VyIGNvbW1lbnRzLgoKUmVnYXJkcywKwqAgRmVsaXgKCj4KPgo+IFRoaXMgcGF0Y2gg
aXM6Cj4gQWNrZWQtYnk6IE9kZWQgR2FiYmF5IDxvZGVkLmdhYmJheUBnbWFpbC5jb20+CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
