From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] Add/update function level documentation and add reference
 to amdgpu_vm.c in amdgpu.rst
Date: Tue, 12 Jun 2018 12:12:11 +0200
Message-ID: <b746f410-3504-4d2a-924f-6505feb23d49@daenzer.net>
References: <1528730087-12300-1-git-send-email-andrey.grodzovsky@amd.com>
 <df7ac851-4223-0bff-7482-f041b039b0cd@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <df7ac851-4223-0bff-7482-f041b039b0cd-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Cc: christian.koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wNi0xMSAwNTozMyBQTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gT24gMjAxOC0w
Ni0xMSAwNToxNCBQTSwgQW5kcmV5IEdyb2R6b3Zza3kgd3JvdGU6Cj4+IEBAIC05NCw2ICs5Niwx
NSBAQCBzdHJ1Y3QgYW1kZ3B1X3BydF9jYiB7Cj4+ICAJc3RydWN0IGRtYV9mZW5jZV9jYiBjYjsK
Pj4gIH07Cj4+ICAKPj4gKy8qKgo+PiArICogYW1kZ3B1X3ZtX2JvX2Jhc2VfaW5pdCAtIEFkZHMg
Ym8gdG8gdGhlIGxpc3Qgb2YgYm9zIGFzc29jaWF0ZWQgd2l0aCB0aGUgdm0KPj4gKyAqIEBiYXNl
OiBiYXNlIHN0cnVjdHVyZSBmb3IgdHJhY2tpbmcgQk8gdXNhZ2UgaW4gYSBWTQo+PiArICogQHZt
OiB2bSB0byB3aGljaCBibyBpcyB0byBiZSBhZGRlZAo+PiArICogQGJvOiBhbWRncHUgYnVmZmVy
IG9iamVjdAo+IAo+IE1vc3QgZnVuY3Rpb24gY29tbWVudHMgc2VlbSB0byBoYXZlIGFuIGVtcHR5
IGxpbmUgYmV0d2VlbiB0aGUgZnVuY3Rpb24KPiBuYW1lIGFuZCB0aGUgZmlyc3QgcGFyYW1ldGVy
LiBFaXRoZXIgd29ya3MsIGFuZCBJIGRvbid0IHBhcnRpY3VsYXJseSBjcmUKPiB3aGljaCBvbmUg
d2UgZ28gZm9yLCBidXQgd2Ugc2hvdWxkIHByb2JhYmx5IHRyeSB0byBiZSBjb25zaXN0ZW50IGVp
dGhlciB3YXkuCgpPbiBmdXJ0aGVyIHRob3VnaHQsIEkgc3VnZ2VzdCBhbHdheXMgaGF2aW5nIGFu
IGVtcHR5IGxpbmUsIGJlY2F1c2UgdGhlCmZ1bmN0aW9uIG5hbWUgLyBzdW1tYXJ5IGNhbiBzcGFu
IG11bHRpcGxlIGxpbmVzLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAg
ICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVu
dGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3Blcgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
