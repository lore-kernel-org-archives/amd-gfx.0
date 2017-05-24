From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 0/5] GFX9 KIQ
Date: Wed, 24 May 2017 09:10:27 -0400
Message-ID: <8e2430e1-bca7-a40c-6a2e-dff13b7be18a@amd.com>
References: <1494527730-30128-1-git-send-email-alexander.deucher@amd.com>
 <40533e4c-7f8f-70a4-2e15-3540da60b2b0@amd.com>
 <b4b2b241-d072-a227-9be4-a51ccd85d063@amd.com>
 <CADnq5_O+kbGLTR6H+a+7RRUz2etK5gJQt1YVsXEr3RE+UpoqyQ@mail.gmail.com>
 <CADnq5_NSwLQW6A3pTVLR2CHBeyNDE4jWx5J3FVDwH-7h53F1mQ@mail.gmail.com>
 <ae9e8d7c-ac6f-3fae-0986-0f74e106be09@amd.com>
 <BN6PR12MB1652617D3506D75744B56A55F7FE0@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1652617D3506D75744B56A55F7FE0-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjQvMDUvMTcgMDk6MTAgQU0sIERldWNoZXIsIEFsZXhhbmRlciB3cm90ZToKPj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4gRnJvbTogYW1kLWdmeCBbbWFpbHRvOmFtZC1nZngtYm91
bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmddIE9uIEJlaGFsZgo+PiBPZiBUb20gU3QgRGVuaXMK
Pj4gU2VudDogV2VkbmVzZGF5LCBNYXkgMjQsIDIwMTcgNzo1MCBBTQo+PiBUbzogQWxleCBEZXVj
aGVyCj4+IENjOiBhbWQtZ2Z4IGxpc3QKPj4gU3ViamVjdDogUmU6IFtQQVRDSCAwLzVdIEdGWDkg
S0lRCj4+IAo+PiBPbiAyMy8wNS8xNyAwNTozMiBQTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+PiA+
IE9uIFR1ZSwgTWF5IDIzLCAyMDE3IGF0IDU6MzEgUE0sIEFsZXggRGV1Y2hlciA8YWxleGRldWNo
ZXJAZ21haWwuY29tPgo+PiB3cm90ZToKPj4gPj4gT24gRnJpLCBNYXkgMTIsIDIwMTcgYXQgNzox
MSBBTSwgVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgo+PiB3cm90ZToKPj4gPj4+
IE9uIDExLzA1LzE3IDA3OjMzIFBNLCBUb20gU3QgRGVuaXMgd3JvdGU6Cj4+ID4+Pj4KPj4gPj4+
PiBPbiAxMS8wNS8xNyAwMjozNSBQTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+PiA+Pj4+Pgo+PiA+
Pj4+PiBUaGVzZSBhcmUgdGhlIGxhc3RlIG9mIHRoZSBnZng5IEtJUSBwYXRjaGVzIHRoYXQgaGF2
ZW4ndCBsYW5kZWQgeWV0Lgo+PiBDYW4KPj4gPj4+Pj4gc29tZW9uZSB3aXRoIGdmeDkgY2FwYWJs
ZSBodyB0ZXN0IHRoaXMgKHZlZ2ExMCBvciByYXZlbik/ICBUaGlzIGlzCj4+IG5lZWRlZAo+PiA+
Pj4+PiB0byBlbmFibGUgcG93ZXJnYXRpbmcgb24gZ2Z4OS4KPj4gPj4+Pj4KPj4gPj4+Pj4gVGhh
bmtzLAo+PiA+Pj4+Cj4+ID4+Pj4KPj4gPj4+PiBJZiBub2JvZHkgZ2V0cyB0byBpdCBieSBtb3Ju
aW5nIEknbGwgdHJ5IGl0IG91dCBmaXJzdCB0aGluZyBvbiBteSB2ZWdhMTAKPj4gPj4+PiB0aG91
Z2ggbXkgVkJJT1MgbWlnaHQgbmVlZCB1cGRhdGluZy4uLgo+PiA+Pj4KPj4gPj4+Cj4+ID4+Pgo+
PiA+Pj4gVGhleSBkb24ndCBhcHBseSBvbiB0b3Agb2YgZWl0aGVyIDQuOSBub3IgNC4xMS4uLgo+
PiA+Pgo+PiA+PiBPZGQuICBUaGV5IGFwcGxpZWQgZm9yIG1lIChhdCBsZWFzdCB0byB0aGUgNC4x
MSB0cmVlIEkgaGFkIGNoZWNrZWQgb3V0Cj4+ID4+IHdoZW4gSSBsZWZ0IHRvd24pLiAgQXR0YWNo
ZWQgYWdhaW4ganVzdCBpbiBjYXNlLgo+PiAKPj4gVGhpcyBzZXJpZXMgYXBwbGllcyBmaW5lIGFu
ZCBzZWVtcyB0byB3b3JrIGluIGJhc2ljIHRlc3RzIChnbm9tZSArIEdMCj4+IGFwcHMgKyB1dmQv
dmNlIGFwcHMpIG9uIG15IHZlZ2ExMC4KPj4gCj4+IEhhdmVuJ3QgdHJpZWQgb24gcmF2ZW4geWV0
Lgo+IAo+IEFsbCB0aGUgcmluZyBhbmQgSUIgdGVzdHMgcGFzcz8KCllhIGl0IGJvb3RzIHVwIGFu
ZCBJIGNhbiBydW4gZ25vbWUgKyBnbCBhcHBzIGp1c3QgZmluZS4KClRvbQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
