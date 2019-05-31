From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 6/8] drm/amdkfd: New IOCTL to allocate queue GWS
Date: Sat, 1 Jun 2019 06:53:41 +1000
Message-ID: <CAPM=9tzQB_SbCHcAcs3PRq-maed9XdMroROWNQuf9DdgOH5zcQ@mail.gmail.com>
References: <1558651263-3478-1-git-send-email-Oak.Zeng@amd.com>
 <1558651263-3478-6-git-send-email-Oak.Zeng@amd.com>
 <4f49af4d-0953-030c-bb1b-47b7a5fa7c7c@amd.com>
 <CAPM=9tzs9adV7_ef4hpgswB-S==iQizAF_=FTarVm3EYwPCg0w@mail.gmail.com>
 <e857f0f4-341d-1e64-0ffe-5b6812ca5b7f@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e857f0f4-341d-1e64-0ffe-5b6812ca5b7f-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>, "Keely, Sean" <Sean.Keely-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

T24gU2F0LCAxIEp1biAyMDE5IGF0IDA2OjA0LCBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhs
aW5nQGFtZC5jb20+IHdyb3RlOgo+Cj4gT24gMjAxOS0wNS0zMCAxMToxMyBwLm0uLCBEYXZlIEFp
cmxpZSB3cm90ZToKPiA+IE9uIFNhdCwgMjUgTWF5IDIwMTkgYXQgMDU6NDgsIEt1ZWhsaW5nLCBG
ZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4gd3JvdGU6Cj4gPj4gT24gMjAxOS0wNS0yMyA2
OjQxIHAubS4sIFplbmcsIE9hayB3cm90ZToKPiA+Pj4gQWRkIGEgbmV3IGtmZCBpb2N0bCB0byBh
bGxvY2F0ZSBxdWV1ZSBHV1MuIFF1ZXVlCj4gPj4+IEdXUyBpcyByZWxlYXNlZCBvbiBxdWV1ZSBk
ZXN0cm95Lgo+ID4+Pgo+ID4+PiBDaGFuZ2UtSWQ6IEk2MDE1M2MyNmE1Nzc5OTJhZDg3M2U0Mjky
ZTc1OWU1YzNkNWJiZDE1Cj4gPj4+IFNpZ25lZC1vZmYtYnk6IE9hayBaZW5nIDxPYWsuWmVuZ0Bh
bWQuY29tPgo+ID4+IFJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdA
YW1kLmNvbT4KPiA+Pgo+ID4gYnR3IGp1c3Qgbm90aWNlZCBpbiBwYXNzaW5nIHdlIGFyZSBhZGRp
bmcgbmV3IGZlYXR1cmVzIHRvIGtmZCwgaXMKPiA+IHRoZXJlIGFuIG9wZW4gc291cmNlIGRldmVs
b3BlZCB1c2Vyc3BhY2UgdG8gZ28gYWxvbmcgd2l0aCB0aGlzLCB0aGVyZQo+ID4gbmVlZHMgdG8g
YSBkZXYgYnJhbmNoIGluIHB1YmxpYyBiZWZvcmUgbmV3IGlvY3Rscy91YXBpIHN1cmZhY2VzIHNo
b3VsZAo+ID4gYmUgYWRkZWQgdG8gdGhlIGtlcm5lbC4KPiA+Cj4gPiBUaGUgY29tbWl0cyBzaG91
bGQgcHJvYmFibHkgaGF2ZSBwb2ludGVycyB0byB0aGF0IGJyYW5jaC4KPgo+IEFoLCBhIGNoaWNr
ZW4gYW5kIGVnZyBwcm9ibGVtLiBJIHRoaW5rIHRoaXMgaXMgdGhlIGZpcnN0IHRpbWUgd2UncmUK
PiBhZGRpbmcgYSBuZXcgaW9jdGwgdG8gdXBzdHJlYW0gS0ZEIHJhdGhlciB0aGFuIHVwc3RyZWFt
aW5nIG9uZSB0aGF0J3MKPiBiZWVuIGRldmVsb3BlZCBpbnRlcm5hbGx5IGZpcnN0LiBNYXliZSBu
b3QgdGhlIHJpZ2h0IHdheSB0byBkbyBpdC4KClRoZXJlIGlzIG5vIGNoaWNrZW4vZWdnIHByb2Js
ZW0gaGVyZS4gWW91IGRldmVsb3Aga2VybmVsIGFuZCB1c2Vyc3BhY2UKaW4gcGFyYWxsZWwgaW4g
dGhlIG9wZW4sIG9uY2UgeW91IGFyZSBoYXBweSBhbmQgYm90aCBzaWRlcyBhcmUKcmV2aWV3ZWQg
eW91IG1lcmdlIGtlcm5lbCB0aGVuIHVzZXJzcGFjZS4KCkRhdmUuCgo+Cj4gSSBzaG91bGQgYmUg
YWJsZSB0byBwdWJsaXNoIHRoZSB1c2VyIG1vZGUgY29kZSBpbiBsaWJoc2FrbXQgbmV4dCB3ZWVr
Lgo+IFRoZW4gd2UnbGwgd29yayBvbiBhIGtmZHRlc3QgdG8gdmFsaWRhdGUgdGhlIGZpcm13YXJl
IGZ1bmN0aW9uYWxpdHkuCj4gRmluYWxseSB3ZSdsbCB1c2UgR1dTIGZ1cnRoZXIgdXAgdGhlIHNv
ZnR3YXJlIHN0YWNrIGZvciBzeW5jaHJvbml6YXRpb24KPiBvZiBjb25jdXJyZW50IGNvbXB1dGUg
d29ya2dyb3Vwcy4KPgo+IFJlZ2FyZHMsCj4gICAgRmVsaXgKPgo+Cj4gPgo+ID4gRGF2ZS4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
