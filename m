From: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] mm/hmm: support automatic NUMA balancing
Date: Tue, 14 May 2019 21:14:42 +0000
Message-ID: <180dbdaf-3ca4-07be-b549-08757e2ef105@amd.com>
References: <20190510195258.9930-1-Felix.Kuehling@amd.com>
 <20190510195258.9930-2-Felix.Kuehling@amd.com>
 <20190513142720.3334a98cbabaae67b4ffbb5a@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190513142720.3334a98cbabaae67b4ffbb5a-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Content-Language: en-US
Content-ID: <37BFBE354B9EE042991B3828B0383237-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

T24gMjAxOS0wNS0xMyA1OjI3IHAubS4sIEFuZHJldyBNb3J0b24gd3JvdGU6DQo+IFtDQVVUSU9O
OiBFeHRlcm5hbCBFbWFpbF0NCj4NCj4gT24gRnJpLCAxMCBNYXkgMjAxOSAxOTo1MzoyMyArMDAw
MCAiS3VlaGxpbmcsIEZlbGl4IiA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4gd3JvdGU6DQo+DQo+
PiBGcm9tOiBQaGlsaXAgWWFuZyA8UGhpbGlwLllhbmdAYW1kLmNvbT4NCj4+DQo+PiBXaGlsZSB0
aGUgcGFnZSBpcyBtaWdyYXRpbmcgYnkgTlVNQSBiYWxhbmNpbmcsIEhNTSBmYWlsZWQgdG8gZGV0
ZWN0IHRoaXMNCj4+IGNvbmRpdGlvbiBhbmQgc3RpbGwgcmV0dXJuIHRoZSBvbGQgcGFnZS4gQXBw
bGljYXRpb24gd2lsbCB1c2UgdGhlIG5ldw0KPj4gcGFnZSBtaWdyYXRlZCwgYnV0IGRyaXZlciBw
YXNzIHRoZSBvbGQgcGFnZSBwaHlzaWNhbCBhZGRyZXNzIHRvIEdQVSwNCj4+IHRoaXMgY3Jhc2gg
dGhlIGFwcGxpY2F0aW9uIGxhdGVyLg0KPj4NCj4+IFVzZSBwdGVfcHJvdG5vbmUocHRlKSB0byBy
ZXR1cm4gdGhpcyBjb25kaXRpb24gYW5kIHRoZW4gaG1tX3ZtYV9kb19mYXVsdA0KPj4gd2lsbCBh
bGxvY2F0ZSBuZXcgcGFnZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXAgWWFuZyA8UGhp
bGlwLllhbmdAYW1kLmNvbT4NCj4gVGhpcyBzaG91bGQgaGF2ZSBpbmNsdWRlZCB5b3VyIHNpZ25l
ZC1vZmYtYnk6LCBzaW5jZSB5b3Ugd2VyZSBvbiB0aGUNCj4gcGF0Y2ggZGVsaXZlcnkgcGF0aC4g
IEknbGwgbWFrZSB0aGF0IGNoYW5nZSB0byBteSBjb3B5IG9mIHRoZSBwYXRjaCwNCj4gT0s/DQo+
DQpZZXMuIFRoYW5rcyENCg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
Zng=
