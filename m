From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 01/11] drm/amdgpu: try allocating VRAM as power of two
Date: Tue, 11 Sep 2018 10:20:29 +0200
Message-ID: <a3c91610-e5e2-c666-cfda-344f1f40485c@gmail.com>
References: <20180909180339.1910-1-christian.koenig@amd.com>
 <20180909180339.1910-2-christian.koenig@amd.com>
 <60b9c96a-d31d-cd61-df22-c8414f0166dc@amd.com>
 <9b61bb4c-4721-c8af-0810-4ecc18ed1ea4@gmail.com>
 <46b7da24-4b04-7daf-e6c3-07e10ecb6fd6@daenzer.net>
 <d0af0309-e4f9-9825-fd30-9cf79ed5f823@amd.com>
 <5fd331d0-24ab-7540-2d0a-b227230743c0@daenzer.net>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5fd331d0-24ab-7540-2d0a-b227230743c0-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTEuMDkuMjAxOCB1bSAwOTo1NSBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTgt
MDktMTEgOTo0NiBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAxMS4wOS4yMDE4
IHVtIDA5OjM3IHNjaHJpZWIgTWljaGVsIETDpG56ZXI6Cj4+PiBPbiAyMDE4LTA5LTExIDg6NDkg
YS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+PiBCdXQgYW5vdGhlciBxdWVzdGlvbjog
V2h5IGRvIHlvdSB3YW50IHRvIGNsZWFyIFZSQU0gb24gYWxsb2NhdGlvbj8gV2UKPj4+PiBwZXJm
ZWN0bHkgc3VwcG9ydCBhbGxvY2F0aW5nIFZSQU0gd2l0aG91dCBjbGVhcmluZyBpdC4KPj4+IFdo
aWNoIGlzIGEgcHJvYmxlbSBvZiBpdHMgb3duLCBhcyBpdCBjYW4gbGVhayBpbmZvcm1hdGlvbiBm
cm9tIG9uZQo+Pj4gcHJvY2VzcyB0byBhbm90aGVyLgo+PiBIb3cgYWJvdXQgYWRkaW5nIGEgQU1E
R1BVX0dFTV9DUkVBVEVfVlJBTV9TRUNSRUQgZmxhZyB3aGljaCB0cmlnZ2Vycwo+PiBjbGVhcmlu
ZyBWUkFNIHdoZW4gdGhlIEJPIGlzIGZyZWVkPwo+IERvZXNuJ3Qgc291bmQgbGlrZSBtdWNoIGJl
dHRlciBBUEkgdGhhbiBBTURHUFVfR0VNX0NSRUFURV9WUkFNX0NMRUFSRUQKPiB0byBtZS4gV2h5
IHdvdWxkIGFueSBwcm9jZXNzIGJlIG9rYXkgd2l0aCBsZWFraW5nIGl0cyBCTyBjb250ZW50cyB0
bwo+IG90aGVyIHByb2Nlc3Nlcz8KCldlbGwgdGhlIGNvbnRlbnQgb2YgbW9zdCBCT3MgaXMgdW5p
bnRlcmVzdGluZyB0byBvdGhlciBwcm9jZXNzZXMsIGUuZy4gCnRleHR1cmVzLgoKT25seSB0aGlu
Z3MgbGlrZSBwYWdlIHRhYmxlcyBhbmQgbWF5YmUgc29tZSBzZWN1cml0eSByZWxhdGVkIApjYWxj
dWxhdGlvbnMgbmVlZCBleHRyYSBwcm90ZWN0aW9uIGFzIGZhciBhcyBJIGNhbiBzZWUuCgo+IENv
dWxkIHRoYXQgZmxhZyBldmVuIHByZXZlbnQgaXQgaW4gYWxsIGNhc2VzLCBlLmcuIHdoZW4KPiBC
T3MgYXJlIGV2aWN0ZWQgb3Igb3RoZXJ3aXNlIG1pZ3JhdGVkPwoKWWVhaCwgc3VyZSB0aGF0IHNo
b3VsZG4ndCBiZSBhIHByb2JsZW0uIENsZWFyaW5nIGEgQk8gYWZ0ZXIgaXQgaXMgbW92ZWQgCnNo
b3VsZCBiZSB0cml2aWFsLgoKQ2hyaXN0aWFuLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
