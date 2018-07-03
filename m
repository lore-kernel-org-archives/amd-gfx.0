From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2] drm/amdgpu: Reserve shared fence slot in
 amdgpu_vm_update_directories
Date: Tue, 3 Jul 2018 16:37:21 +0800
Message-ID: <5B3B35C1.2010408@amd.com>
References: <20180622164235.30770-1-michel@daenzer.net>
 <20180625090717.28522-1-michel@daenzer.net>
 <15c3905c-8e69-9d03-e506-929e4d9176e3@gmail.com> <5B3AD88D.2010604@amd.com>
 <a95367bc-1181-649d-eca0-64ec0380c6c2@amd.com> <5B3B2FE9.1000402@amd.com>
 <78dcd991-2406-59f3-199a-721797a32c2c@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <78dcd991-2406-59f3-199a-721797a32c2c-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, =?UTF-8?B?Q2hy?= =?UTF-8?B?aXN0aWFuIEvDtm5pZw==?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDcvMDMvMjAxOCAwNDoyOCBQTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gT24gMjAxOC0w
Ny0wMyAxMDoxMiBBTSwgWmhhbmcsIEplcnJ5IChKdW53ZWkpIHdyb3RlOgo+Pgo+PiBCVFcsIHJl
c2VydmF0aW9uX29iamVjdF9yZXNlcnZlX3NoYXJlZCgpIHdpbGwgZXh0ZW5kIHRoZSBtYXggbnVt
IGFzIDIKPj4gdGltZXMgaWYgaXQncyBub3QgZW5vdWdoLgo+PiAoZGVmYXVsdCB2YWx1ZSBpcyA0
KQo+Cj4gVGhhdCdzIGFuIGltcGxlbWVudGF0aW9uIGRldGFpbCBhbmQgZGVwZW5kcyBvbiB0aGUg
Y2lyY3Vtc3RhbmNlcy4gVGhlCj4gb25seSBndWFyYW50ZWUgaXMgdGhhdCB0aGVyZSdzIHNwYWNl
IGZvciBhdCBsZWFzdCBvbmUgZmVuY2UgYWZ0ZXIKPiBjYWxsaW5nIHJlc2VydmF0aW9uX29iamVj
dF9yZXNlcnZlX3NoYXJlZCwgdW50aWwKPiByZXNlcnZhdGlvbl9vYmplY3RfYWRkX3NoYXJlZF9m
ZW5jZSBpcyBjYWxsZWQuCgp5ZXMsIGl0J3MgYSBiaXQgbW9yZSBkZXRhaWwgZGlzY3Vzc2lvbiBh
Ym91dCB0aGF0LgpBbnl3YXksIGl0IHNob3VsZCByZXNlcnZlIGF0IGxlYXN0IG9uZSBmb3Igc2hh
cmVkIHJlc2VydmF0aW9uLgpMZXQncyBiYWNrIHRvIHRoZSB1cHBlciBsZXZlbCBkaXNjdXNzaW9u
LgoKSmVycnkKCj4KPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
