From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix the memory corruption on S3
Date: Thu, 29 Jun 2017 17:07:33 +0900
Message-ID: <d86cec19-7927-c29e-d2fb-fdaf589e3369@daenzer.net>
References: <1498719798-8435-1-git-send-email-ray.huang@amd.com>
 <86b9418d-450e-9101-517d-8d1ae7c8b358@daenzer.net>
 <20170629075910.GA10514@hr-amur2>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170629075910.GA10514@hr-amur2>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Cc: "Huan, Alvin" <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, "Qiao,
 Joe(Markham)" <Joe2.Qiao-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Jiang,
 Sonny" <Sonny.Jiang-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

T24gMjkvMDYvMTcgMDQ6NTkgUE0sIEh1YW5nIFJ1aSB3cm90ZToKPiBPbiBUaHUsIEp1biAyOSwg
MjAxNyBhdCAwMzozNDo1N1BNICswODAwLCBNaWNoZWwgRMOkbnplciB3cm90ZToKPj4gT24gMjkv
MDYvMTcgMDQ6MDMgUE0sIEh1YW5nIFJ1aSB3cm90ZToKPj4+IHBzcC0+Y21kIHdpbGwgYmUgdXNl
ZCBvbiByZXN1bWUgcGhhc2UsIHNvIHdlIGNhbiBub3QgZnJlZSBpdCBvbiBod19pbml0Lgo+Pj4g
T3RoZXJ3aXNlLCBhIG1lbW9yeSBjb3JydXB0aW9uIHdpbGwgYmUgdHJpZ2dlcmVkLgo+Pj4KPj4+
IFNpZ25lZC1vZmYtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Cj4+PiAtLS0KPj4+
Cj4+PiBBbGV4LCBDaHJpc3RpYW4sCj4+Pgo+Pj4gVGhpcyBpcyB0aGUgZmluYWwgZml4IGZvciB2
ZWdhMTAgUzMuIFRoZSByYW5kb20gbWVtb3J5IGNvcnJ1cHRpb24gaXNzdWUgaXMKPj4gcm9vdAo+
Pj4gY2F1c2VkLgo+Pj4KPj4+IFRoYW5rcywKPj4+IFJheQo+Pj4KPj4+IC0tLQo+Pj4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyB8IDggKysrKysrLS0KPj4+ICAxIGZp
bGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kLwo+PiBhbWRncHUvYW1kZ3B1X3BzcC5jCj4+PiBpbmRleCA1MDQxMDczLi5m
Y2RkNTQyIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3BzcC5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMK
Pj4+IEBAIC0zNzIsOCArMzcyLDYgQEAgc3RhdGljIGludCBwc3BfbG9hZF9mdyhzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikKPj4+ICAgICAgICBpZiAocmV0KQo+Pj4gICAgICAgICAgICAgICAg
Z290byBmYWlsZWRfbWVtOwo+Pj4KPj4+IC0gICAgIGtmcmVlKGNtZCk7Cj4+PiAtCj4+PiAgICAg
ICAgcmV0dXJuIDA7Cj4+Cj4+IFRoaXMgbG9va3MgbGlrZSBhIGdvb2QgY2F0Y2guCj4+Cj4+Cj4+
PiBAQCAtMzg0LDYgKzM4Miw3IEBAIHN0YXRpYyBpbnQgcHNwX2xvYWRfZncoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZwc3AtPmZ3
X3ByaV9tY19hZGRyLCAmcHNwLT5md19wcmlfYnVmKTsKPj4+ICBmYWlsZWQ6Cj4+PiAgICAgICAg
a2ZyZWUoY21kKTsKPj4+ICsgICAgIGNtZCA9IE5VTEw7Cj4+Cj4+IFRoaXMgc2hvdWxkIHByb2Jh
Ymx5IGJlCj4+Cj4+ICAgICAgICAgcHNwLT5jbWQgPSBOVUxMOwo+Pgo+PiBpbnN0ZWFkPwo+Pgo+
IAo+IEFjdHVhbGx5LCB3ZSBzZXQgcHNwLT5jbWQgPSBjbWQgYmVmb3JlLgo+IAo+IEJ1dCBhbnl3
YXksIHdlIG5lZWRuJ3QgImNtZCIgbWVtYmVyIGFueSBtb3JlLgoKWW91IHNob3VsZCBwcm9iYWJs
eSBzdGlsbCBzZXQgcHNwLT5jbWQgPSBOVUxMIGhlcmUsIG90aGVyd2lzZSBwc3AtPmNtZApzdGls
bCBjb250YWlucyB0aGUgcG9pbnRlciB0byB0aGUgbWVtb3J5IHRoYXQgaXMgZnJlZWQgaGVyZSwg
d2hpY2ggY291bGQKcmVzdWx0IGluIHVzZS1hZnRlci1mcmVlIHNvbWV3aGVyZSBlbHNlLgoKCi0t
IApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAg
aHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAg
fCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
