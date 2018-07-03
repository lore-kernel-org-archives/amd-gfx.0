From: Tom St Denis <tstdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: SOC15 DC support warning
Date: Tue, 3 Jul 2018 12:24:24 -0400
Message-ID: <c0695889-126f-0fc7-e274-6820649b3ba0@amd.com>
References: <0334a673-faa5-916a-f62f-d1737d4dad5b@amd.com>
 <36e5a149-9e3b-f6f6-7450-698c6684b47d@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <36e5a149-9e3b-f6f6-7450-698c6684b47d-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SGkgRmVsaXgsCgpJIGNhbiAodjIpIHRoZSBwYXRjaCBJIHNlbnQgdG8gdGhlIGxpc3QuICBVbHRp
bWF0ZWx5IGEgYnVpbGQgd2FybmluZyAKYWxvbmUgSSB0aGluayBpcyB0aGUgd3JvbmcgYXBwcm9h
Y2guCgpDaGVlcnMsClRvbQoKT24gMDcvMDMvMjAxOCAxMjoxMyBQTSwgRmVsaXggS3VlaGxpbmcg
d3JvdGU6Cj4gCj4gT24gMjAxOC0wNy0wMyAxMDoxOSBBTSwgVG9tIFN0IERlbmlzIHdyb3RlOgo+
PiBIaSBhbGwsCj4+Cj4+IFRoaXMgYmxvY2sKPj4KPj4gI2lmIGRlZmluZWQoQ09ORklHX0RSTV9B
TURfREMpCj4+ICDCoMKgwqDCoMKgwqDCoCBlbHNlIGlmIChhbWRncHVfZGV2aWNlX2hhc19kY19z
dXBwb3J0KGFkZXYpKQo+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfZGV2aWNlX2lw
X2Jsb2NrX2FkZChhZGV2LCAmZG1faXBfYmxvY2spOwo+PiAjZWxzZQo+PiAjwqDCoMKgIHdhcm5p
bmcgIkVuYWJsZSBDT05GSUdfRFJNX0FNRF9EQyBmb3IgZGlzcGxheSBzdXBwb3J0IG9uIFNPQzE1
LiIKPj4gI2VuZGlmCj4+Cj4+Cj4+IGluIHNvYzE1X3NldF9pcF9ibG9ja3MoKSBzaG91bGQgcHJv
YmFibHkgYmUgcG9ydGVkIHRvIGEgcnVudGltZQo+PiBkcm1fd2FybigpIG5vP8KgIFRoaXMgbWVh
bnMgYSBrZXJuZWwgd2l0aCBubyBEQyBzdXBwb3J0IHdpbGwganVzdAo+PiBzaWxlbnRseSBmYWls
IHRvIGxpZ2h0IHVwIG9uIFNPQzE1Lgo+Pgo+PiBJIGNhbiB3cml0ZSBhIHBhdGNoIGZvciB0aGlz
IGlmIG5vYm9keSBvYmplY3RzLgo+IAo+IE1heWJlIGRvIGJvdGguIFNvIHNvbWVvbmUgYnVpbGRp
bmcgYSBrZXJuZWwgd2l0aG91dCBEQyBnZXRzIGEgd2FybmluZyBhcwo+IHdlbGwgYXMgc29tZW9u
ZSBydW5uaW5nIGl0Lgo+IAo+IFJlZ2FyZHMsCj4gIMKgIEZlbGl4Cj4gCj4gCj4+Cj4+IChmb3Vu
ZCB0aGlzIHdoaWxlIHRyeWluZyB0byBzb3J0IG91dCB0aGUgUFAgZ2V0X2Nsb2NrcyBjYWxsIGZv
ciBteQo+PiBSYXZlbjEgLi4uKS4KPj4KPj4gVG9tCj4+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
