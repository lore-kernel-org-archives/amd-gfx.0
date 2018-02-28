From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: fix "add AMDGPU_VA_RANGE_HIGH"
Date: Wed, 28 Feb 2018 16:25:40 +0100
Message-ID: <42d3a34d-2df5-2f9f-95b7-525957297cab@gmail.com>
References: <20180228144111.1651-1-christian.koenig@amd.com>
 <2450a93d-fbf0-0a6c-e0b8-2432a401d531@daenzer.net>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <2450a93d-fbf0-0a6c-e0b8-2432a401d531-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjguMDIuMjAxOCB1bSAxNjoyMSBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTgt
MDItMjggMDM6NDEgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IFRoZSAzMmJpdCBhZGRy
ZXNzIHJhbmdlIGVuZCBpcyBleGNsdXNpdmUsIG5vdCBpbmNsdXNpdmUuCj4gVGhlIG90aGVyIHdh
eSBhcm91bmQuIDopIEluY2x1c2l2ZSBtZWFucyBbYSxiXSwgaS5lLiBhbiBpbnRlcnZhbAo+IGlu
Y2x1ZGluZyB0aGUgZW5kcG9pbnRzLCB3aGVyZWFzIGV4Y2x1c2l2ZSBtZWFucyBdYSxiWywgaS5l
LiBhbiBpbnRlcnZhbAo+IG5vdCBpbmNsdWRpbmcgdGhlIGVuZHBvaW50cy4gVGhlIHBhdGNoIGNo
YW5nZXMgdGhlIDMyLWJpdCBhZGRyZXNzIHJhbmdlCj4gZW5kcG9pbnQgZnJvbSBleGNsdXNpdmUg
dG8gaW5jbHVzaXZlLgoKQWN0dWFsbHkgdGhhdCdzIG5vdCB3aGF0IEkgbWVhbnQuIEhvdyBhYm91
dCB0aGlzOgoKIlRoZSByYW5nZSBpcyBzdG9yZWQgYXMgZXhjbHVzaXZlLCBub3QgaW5jbHVzaXZl
LiBTdWJ0cmFjdHMgb25lIHRvIGdldCAKdGhlIGluY2x1c2l2ZSBpbnRlcnZhbCBmb3IgdGhlIGNh
bGN1bGF0aW9uLiIKCj4+IFRoaXMgZml4ZXMgY3Jhc2hlcyB3aGVuIDMyYml0IGFkZHJlc3NlcyBh
cmUgaW4gdXNlLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+Cj4gV2l0aCB0aGUgYWJvdmUgZml4ZWQsCj4KPiBSZXZpZXdlZC1h
bmQtVGVzdGVkLWJ5OiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KPgo+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
