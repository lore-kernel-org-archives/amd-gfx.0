From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm: add drm device name
Date: Tue, 17 Sep 2019 10:12:26 +0200
Message-ID: <03d31464-3968-6923-5323-f63060d70f1f@gmail.com>
References: <20190903214040.2386-1-sonny.jiang@amd.com>
 <CAAxE2A45N4gMYrcETDpznGKyxLztuwenFasL19a81QQmBkYiww@mail.gmail.com>
 <CAF6AEGvvUUOGujJC9P3t72N93AJuxiiVt0OAk8zf226Q8WmHvg@mail.gmail.com>
 <CAKMK7uHFNhdNY4Y9ZFMNuci7gssPWCT5f5y=e4npg8s5r_jBdQ@mail.gmail.com>
 <CAAxE2A6sESsKAi3K1etAZeCwAPgexn099G6g0aJQnavTkiH+mA@mail.gmail.com>
 <87woe7eanv.fsf@intel.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <87woe7eanv.fsf-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
To: Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, =?UTF-8?B?TWFyZWsgT2zFocOh?= =?UTF-8?Q?k?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: "Jiang, Sonny" <Sonny.Jiang-5C7GfCeVMHo@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMTcuMDkuMTkgdW0gMDc6NDcgc2NocmllYiBKYW5pIE5pa3VsYToKPiBPbiBNb24sIDE2IFNl
cCAyMDE5LCBNYXJlayBPbMWhw6FrIDxtYXJhZW9AZ21haWwuY29tPiB3cm90ZToKPj4gVGhlIHB1
cnBvc2UgaXMgdG8gZ2V0IHJpZCBvZiBhbGwgUENJIElEIHRhYmxlcyBmb3IgYWxsIGRyaXZlcnMg
aW4KPj4gdXNlcnNwYWNlLiAob3IgYXQgbGVhc3Qgc3RvcCB1cGRhdGluZyB0aGVtKQo+Pgo+PiBN
ZXNhIGNvbW1vbiBjb2RlIGFuZCBtb2Rlc2V0dGluZyB3aWxsIHVzZSB0aGlzLgo+IEknZCB0aGlu
ayB0aGlzIHdvdWxkIHdhcnJhbnQgYSBoaWdoIGxldmVsIGRlc2NyaXB0aW9uIG9mIHdoYXQgeW91
IHdhbnQKPiB0byBhY2hpZXZlIGluIHRoZSBjb21taXQgbWVzc2FnZS4KCkFuZCBtYXliZSBleHBs
aWNpdGx5IGNhbGwgaXQgdWFwaV9uYW1lIG9yIGV2ZW4gdWFwaV9kcml2ZXJfbmFtZS4KClJlZ2Fy
ZHMsCkNocmlzdGlhbi4KCj4KPiBCUiwKPiBKYW5pLgo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZng=
