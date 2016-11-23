From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/gfx7: move eop programming per queue
Date: Wed, 23 Nov 2016 18:49:08 -0500
Message-ID: <CADnq5_OVmdTJQpGqOdxvDVhSvGeX5eAgOmJdtA-K2jEDMWaYJg@mail.gmail.com>
References: <1479932826-3362-1-git-send-email-alexander.deucher@amd.com>
 <1479932826-3362-2-git-send-email-alexander.deucher@amd.com>
 <1479942059.4125077.797525393.1034ADD9@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1479942059.4125077.797525393.1034ADD9-2RFepEojUI2N1INw9kWLP6GC3tUn3ZHUQQ4Iyu8u01E@public.gmane.org>
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
To: Jay Cornwall <jay-gJmSnxjMpeIFV7jr3Ov9Ew@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gV2VkLCBOb3YgMjMsIDIwMTYgYXQgNjowMCBQTSwgSmF5IENvcm53YWxsIDxqYXlAamNvcm53
YWxsLm1lPiB3cm90ZToKPiBPbiBXZWQsIE5vdiAyMywgMjAxNiwgYXQgMTQ6MjcsIEFsZXggRGV1
Y2hlciB3cm90ZToKPj4gSXQncyBwZXIgcXVldWUgbm90IHBlciBwaXBlLgo+Cj4gQXJlIHlvdSBz
dXJlPyBJIHdhcyB1bmRlciB0aGUgaW1wcmVzc2lvbiB0aGF0IEVPUCBxdWVldXMgd2VyZSBwZXIt
cGlwZQo+IG9uIEdmeDcgYW5kIHBlci1xdWV1ZSBvbiBHZng4IG9ud2FyZHMgKHRvIHN1cHBvcnQg
Y29udGV4dCBzYXZlL3Jlc3RvcmUpLgo+IEl0J3MgYWxzbyBoaW50ZWQgYXQgYnkgdGhlIHJlZ2lz
dGVyIG5hbWUgKEhQRCA9PSBIYXJkd2FyZSBQaXBlCj4gRGVzY3JpcHRvciwgSFFEID09IEhhcmR3
YXJlIFF1ZXVlIERlc2NyaXB0b3IpLgoKTm8sIEknbSBub3Qgc3VyZS4gIEkgaGF2ZSBhIHBhdGNo
IHNldCBmb3IgYW1kZ3B1IHRvIGxlYXZlIHRoZQpmYl9sb2NhdGlvbiBhcyBwcm9ncmFtbWVkIGJ5
IHRoZSB2YmlvcyByYXRoZXIgdGhhbiByZXByb2dyYW1taW5nIHdoaWNoCnJlc3VsdGVkIGluIHZy
YW0gbm90IGJlaW5nIGF0IDAgaW4gdGhlIEdQVSdzIGFkZHJlc3Mgc3BhY2UuICBJIHRoZW4KZ290
IHJpbmcgZmFpbHVyZXMgb24gdGhlIGNvbXB1dGUgcXVldWVzIHVudGlsIEkgbWFkZSB0aGUgZW9w
cyBwZXIKcXVldWUuICBJdCBjb3VsZCBiZSBzb21ldGhpbmcgZWxzZSwgYnV0IHRoaXMgc2VlbWVk
IHRvIGZpeCBpdC4KCkFsZXgKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
