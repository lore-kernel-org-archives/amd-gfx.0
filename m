From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Count disabled CRTCs in commit tail earlier
Date: Fri, 22 Jun 2018 09:38:30 +0200
Message-ID: <a07b99f8-e5ea-fa8c-dc43-75c032c4afd0@daenzer.net>
References: <20180621204832.22448-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180621204832.22448-1-lyude-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Lyude Paul <lyude-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Shirish S <shirish.s-5C7GfCeVMHo@public.gmane.org>, "Leo (Sunpeng) Li" <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Tony Cheng <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOC0wNi0yMSAxMDo0OCBQTSwgTHl1ZGUgUGF1bCB3cm90ZToKPiBUaGlzIGZpeGVzIGEg
cmVncmVzc2lvbiBJIGFjY2lkZW50YWxseSByZWR1Y2VkIHRoYXQgd2FzIHBpY2tlZCB1cCBieQo+
IGthc2FuLCB3aGVyZSB3ZSB3ZXJlIGNoZWNraW5nIHRoZSBDUlRDIGF0b21pYyBzdGF0ZXMgYWZ0
ZXIgRFJNJ3MgaGVscGVycwo+IGhhZCBhbHJlYWR5IGZyZWVkIHRoZW0uIEV4YW1wbGU6Cj4gCj4g
Wy4uLl0KPiAKPiBTbywgd2UgZml4IHRoaXMgYnkgY291bnRpbmcgdGhlIG51bWJlciBvZiBDUlRD
cyB0aGlzIGF0b21pYyBjb21taXQgZGlzYWJsZWQKPiBlYXJseSBvbiBpbiB0aGUgZnVuY3Rpb24g
YmVmb3JlIHRoZWlyIGF0b21pYyBzdGF0ZXMgaGF2ZSBiZWVuIGZyZWVkLCB0aGVuIHVzZQo+IHRo
YXQgY291bnQgbGF0ZXIgdG8gZG8gdGhlIGFwcHJvcHJpYXRlIG51bWJlciBvZiBSUE0gcHV0cyBh
dCB0aGUgZW5kIG9mIHRoZQo+IGZ1bmN0aW9uLgo+IAo+IEZpeGVzOiA5NzAyODAzN2EzOGFlICgi
ZHJtL2FtZGdwdTogR3JhYi9wdXQgcnVudGltZSBQTSByZWZlcmVuY2VzIGluIGF0b21pY19jb21t
aXRfdGFpbCgpIikKPiBTaWduZWQtb2ZmLWJ5OiBMeXVkZSBQYXVsIDxseXVkZUByZWRoYXQuY29t
Pgo+IENjOiBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRhZW56ZXIubmV0Pgo+IFJlcG9ydGVkLWJ5
OiBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRhZW56ZXIubmV0PgoKQWN0dWFsbHksIGl0IHdhcyBy
ZXBvcnRlZCBieSBUb20gU3QgRGVuaXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+LiBXaXRoCnRoYXQg
Zml4ZWQsCgpBY2tlZC1ieTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+
CgoobmVlZHMgcmV2aWV3IGJ5IERDIGZvbGtzKQoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56
ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJl
IHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBY
IGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
