From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PART1 PATCH 0/8] Introduce a method to get clock gating status
 dynamically
Date: Fri, 6 Jan 2017 14:12:43 +0800
Message-ID: <20170106061232.GA31453@hr-amur2>
References: <1483624193-20897-1-git-send-email-ray.huang@amd.com>
 <BN6PR12MB1652B0E3AD8F9252CE089FA0F7600@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BN6PR12MB1652B0E3AD8F9252CE089FA0F7600-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Zhu,
 Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "Fu, Ping" <Ping.Fu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Mao,
 David" <David.Mao-5C7GfCeVMHo@public.gmane.org>

T24gVGh1LCBKYW4gMDUsIDIwMTcgYXQgMTE6NDA6MzNQTSArMDgwMCwgRGV1Y2hlciwgQWxleGFu
ZGVyIHdyb3RlOgo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiA+IEZyb206IEh1YW5n
IFJ1aSBbbWFpbHRvOnJheS5odWFuZ0BhbWQuY29tXQo+ID4gU2VudDogVGh1cnNkYXksIEphbnVh
cnkgMDUsIDIwMTcgODo1MCBBTQo+ID4gVG86IERldWNoZXIsIEFsZXhhbmRlcjsgYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKPiA+IENjOiBaaHUsIFJleDsgTWFvLCBEYXZpZDsgRnUsIFBp
bmc7IFpoYW5nLCBIYXdraW5nOyBIdWFuZywgUmF5Cj4gPiBTdWJqZWN0OiBbUEFSVDEgUEFUQ0gg
MC84XSBJbnRyb2R1Y2UgYSBtZXRob2QgdG8gZ2V0IGNsb2NrIGdhdGluZyBzdGF0dXMKPiA+IGR5
bmFtaWNhbGx5Cj4gPiAKPiA+IFRoaXMgc2VyaWVzIHBhdGNoZXMgaW1wbGVtZW50IHRvIGdldCB0
aGUgY2xvY2sgZ2F0aW5nIHN0YXR1cwo+ID4gZHluYW1pY2FsbHkgaW50byBkZWJ1Z2ZzLiBVc2Vy
IHdpbGwgZW50ZXIgcHJvZmlsaW5nIG1vZGUgdG8gcnVudGltZQo+ID4gZGlzYWJsZSBjbG9ja2dh
dGluZywgc28gaXQgbmVlZHMgYW4gaW50ZXJmYWNlIHRvIGV4cG9zZSBjbG9jayBnYXRpbmcKPiA+
IHN0YXRlcy4gUGFydCAxIHdvcmtzIGZvciBWSSwgSSB3aWxsIGltcGxlbWVudCBpdCBvbiBDSS9T
SSBpbiBmb2xsb3dpbmcKPiA+IGRheXMuCj4gCj4gUGF0Y2hlcyAxLTY6Cj4gUmV2aWV3ZWQtYnk6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiAKPiBQYXRjaGVzIDcs
IDg6Cj4gSSdtIG5vdCBzdXJlIGlmIHRoZSBVVkQgYW5kIFZDRSBzdGF0dXMgcmVnaXN0ZXJzIGFy
ZSBhdmFpbGFibGUgaWYgdGhlIGJsb2NrcyBhcmUgcG93ZXJnYXRlZC4gIFJlYWRpbmcgdGhlbSBi
YWNrIHdoaWxlIHBvd2VyZ2F0ZWQgY2FuIGNhdXNlIGEgaGFuZy4gIE1pZ2h0IHdhbnQgdG8gY2hl
Y2sgdGhlIFBHIHN3IHN0YXRlIGJlZm9yZSByZWFkaW5nIGJhY2sgdGhlIHJlZ2lzdGVycy4KPiAK
Ck9LLCBzbyBJIHNob3VsZCBjaGVjayB3aGV0aGVyIFVWRC9WQ0UgaXMgaW4gQU1EX1BHX1NUQVRF
X1VOR0FURSBiZWZvcmUKcmVhZGluZyB0aGUgcmVnaXN0ZXJzLgoKVGhhbmtzLApSdWkKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
