From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 01/11] drm/amdgpu: try allocating VRAM as power of two
Date: Tue, 11 Sep 2018 10:25:35 +0200
Message-ID: <eb945449-490e-9e97-60c0-d558475e0194@daenzer.net>
References: <20180909180339.1910-1-christian.koenig@amd.com>
 <20180909180339.1910-2-christian.koenig@amd.com>
 <60b9c96a-d31d-cd61-df22-c8414f0166dc@amd.com>
 <9b61bb4c-4721-c8af-0810-4ecc18ed1ea4@gmail.com>
 <46b7da24-4b04-7daf-e6c3-07e10ecb6fd6@daenzer.net>
 <d0af0309-e4f9-9825-fd30-9cf79ed5f823@amd.com>
 <5fd331d0-24ab-7540-2d0a-b227230743c0@daenzer.net>
 <a3c91610-e5e2-c666-cfda-344f1f40485c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a3c91610-e5e2-c666-cfda-344f1f40485c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wOS0xMSAxMDoyMCBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDEx
LjA5LjIwMTggdW0gMDk6NTUgc2NocmllYiBNaWNoZWwgRMOkbnplcjoKPj4gT24gMjAxOC0wOS0x
MSA5OjQ2IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBBbSAxMS4wOS4yMDE4IHVt
IDA5OjM3IHNjaHJpZWIgTWljaGVsIETDpG56ZXI6Cj4+Pj4gT24gMjAxOC0wOS0xMSA4OjQ5IGEu
bS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Pj4+IEJ1dCBhbm90aGVyIHF1ZXN0aW9uOiBX
aHkgZG8geW91IHdhbnQgdG8gY2xlYXIgVlJBTSBvbiBhbGxvY2F0aW9uPyBXZQo+Pj4+PiBwZXJm
ZWN0bHkgc3VwcG9ydCBhbGxvY2F0aW5nIFZSQU0gd2l0aG91dCBjbGVhcmluZyBpdC4KPj4+PiBX
aGljaCBpcyBhIHByb2JsZW0gb2YgaXRzIG93biwgYXMgaXQgY2FuIGxlYWsgaW5mb3JtYXRpb24g
ZnJvbSBvbmUKPj4+PiBwcm9jZXNzIHRvIGFub3RoZXIuCj4+PiBIb3cgYWJvdXQgYWRkaW5nIGEg
QU1ER1BVX0dFTV9DUkVBVEVfVlJBTV9TRUNSRUQgZmxhZyB3aGljaCB0cmlnZ2Vycwo+Pj4gY2xl
YXJpbmcgVlJBTSB3aGVuIHRoZSBCTyBpcyBmcmVlZD8KPj4gRG9lc24ndCBzb3VuZCBsaWtlIG11
Y2ggYmV0dGVyIEFQSSB0aGFuIEFNREdQVV9HRU1fQ1JFQVRFX1ZSQU1fQ0xFQVJFRAo+PiB0byBt
ZS4gV2h5IHdvdWxkIGFueSBwcm9jZXNzIGJlIG9rYXkgd2l0aCBsZWFraW5nIGl0cyBCTyBjb250
ZW50cyB0bwo+PiBvdGhlciBwcm9jZXNzZXM/Cj4gCj4gV2VsbCB0aGUgY29udGVudCBvZiBtb3N0
IEJPcyBpcyB1bmludGVyZXN0aW5nIHRvIG90aGVyIHByb2Nlc3NlcywgZS5nLgo+IHRleHR1cmVz
LgoKVGV4dHVyZXMgY2FuIGhvbGQgYXBwbGljYXRpb24gd2luZG93IGNvbnRlbnRzLCB3aGljaCBj
YW4gYmUgc2Vuc2l0aXZlLgpOb3QgY2xlYXJpbmcgQk9zIGNhbiByZXN1bHQgaW4gc3VjaCBjb250
ZW50cyBzaG93aW5nIHVwIGluIHVuZXhwZWN0ZWQKcGxhY2VzLgoKCi0tIApFYXJ0aGxpbmcgTWlj
aGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQu
Y29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBN
ZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
