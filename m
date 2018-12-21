From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/virtual_dce: Need to pin the fb's bo
Date: Fri, 21 Dec 2018 09:52:01 +0100
Message-ID: <34e8133d-c462-f836-5d95-db3119fd311d@daenzer.net>
References: <1545377209-10718-1-git-send-email-Emily.Deng@amd.com>
 <3d75c11d-1172-1d0e-17a6-b5931660fe61@daenzer.net>
 <BN7PR12MB26449E825462ADBC0AC0A2E68FB80@BN7PR12MB2644.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN7PR12MB26449E825462ADBC0AC0A2E68FB80-Zx/IyJUqfGKoYeSiBV3SvgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOC0xMi0yMSA5OjQ1IGEubS4sIERlbmcsIEVtaWx5IHdyb3RlOgo+PiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQo+PiBGcm9tOiBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRhZW56ZXIu
bmV0Pgo+PiBTZW50OiBGcmlkYXksIERlY2VtYmVyIDIxLCAyMDE4IDQ6MzggUE0KPj4gVG86IERl
bmcsIEVtaWx5IDxFbWlseS5EZW5nQGFtZC5jb20+Cj4+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwo+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1L3ZpcnR1YWxfZGNl
OiBOZWVkIHRvIHBpbiB0aGUgZmIncyBibwo+Pgo+PiBPbiAyMDE4LTEyLTIxIDg6MjYgYS5tLiwg
RW1pbHkgRGVuZyB3cm90ZToKPj4+IFdoZW4gdGhlIGJvIGlzIHVzZWQgdG8gc2V0IG1vZGUsIHRo
ZSBibyBuZWVkIHRvIGJlIHBpbm5lZC4KPj4KPj4gT24gc2Vjb25kIHRob3VnaHQsIHdoeSBkb2Vz
IHRoZSBCTyBuZWVkIHRvIGJlIHBpbm5lZD8gV2hlbiB1c2luZyB0aGUgZGlzcGxheQo+PiBoYXJk
d2FyZSwgdGhlIEJPIG5lZWRzIHRvIGJlIHBpbm5lZCB0byBwcmV2ZW50IGl0IGZyb20gYmVpbmcg
bW92ZWQgd2hpbGUgdGhlCj4+IGhhcmR3YXJlIGlzIHNjYW5uaW5nIG91dCBmcm9tIGl0LCBidXQg
dGhhdCBzaG91bGRuJ3QgYmUgbmVjZXNzYXJ5IGhlcmUuCj4gVGhlIHBpbiBoZXJlIGlzIHVzZWQg
Zm9yIHNjYW4gb3V0IHRoZSBidWZmZXIgYnkgcmVtb3RlIGRpc3BsYXkgYXBwLgoKSSBzdGlsbCBk
b24ndCB1bmRlcnN0YW5kIHdoeSBwaW5uaW5nIGlzIG5lZWRlZC4gV2hhdCBtZWNoYW5pc20gZG9l
cyB0aGUKcmVtb3RlIGRpc3BsYXkgYXBwIHVzZSB0byBhY2Nlc3MgdGhlIEJPIGNvbnRlbnRzPwoK
Ci0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAg
ICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAg
ICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
