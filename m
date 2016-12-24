From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/8] dal: remove some unused wrappers
Date: Sat, 24 Dec 2016 13:29:06 +0000
Message-ID: <CACvgo50Sx6KdPcoyOjq-tdBLNA=fqf2Rqtsj33AkeT6Bxut00w@mail.gmail.com>
References: <20161213064112.20004-1-airlied@gmail.com>
 <20161213064112.20004-3-airlied@gmail.com>
 <f30d9730-8d3d-4b9d-ced2-4a1bb93138d2@amd.com>
 <CACvgo53HxQq4HhizR-+VY4W7cGb5O3XXmLUNhEGbipeo8ODjWA@mail.gmail.com>
 <CY4PR12MB1768D6FCEC097FCDE97E314EF7910@CY4PR12MB1768.namprd12.prod.outlook.com>
 <CACvgo5220YNkWfW0xWr9Sn6a-tN8Ja02CZu65H2UWTQh+d_EZQ@mail.gmail.com>
 <SN1PR12MB07034F6B1DB5696FC2DA9729FE930@SN1PR12MB0703.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <SN1PR12MB07034F6B1DB5696FC2DA9729FE930-z7L1TMIYDg6P/i5UxMCIqAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Sagalovitch, Serguei" <Serguei.Sagalovitch-5C7GfCeVMHo@public.gmane.org>
Cc: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjEgRGVjZW1iZXIgMjAxNiBhdCAxNTowNCwgU2FnYWxvdml0Y2gsIFNlcmd1ZWkKPFNlcmd1
ZWkuU2FnYWxvdml0Y2hAYW1kLmNvbT4gd3JvdGU6Cj4+ICBJbnRlbCBoYXMgbWFuYWdlZCB0byBn
ZXQgdGhlcmUKPiBJIGFtIG5vdCAxMDAlIHN1cmUuCj4gRS5nLiAgaHR0cDovL3d3dy5waG9yb25p
eC5jb20vc2Nhbi5waHA/cGFnZT1hcnRpY2xlJml0ZW09aW50ZWwtd2luMTAtbWVzYTEyMSZudW09
MQo+Cj4gSW4gZ2VuZXJhbCBJbnRlbCBkcml2ZXIgdW5kZXIgTGludXggaXMgc3RpbGwgIGJlaGlu
ZCBNUyBXaW5kb3dzCj4gdmVyc2lvbi4KPgpUaGUgYXJ0aWNsZSBpcyBwcmV0dHkgb2xkICg2IG1v
bnRocyBhcyBvZiB0b2RheSkgYW5kIG5vIGxvbmdlcgphcHBsaWNhYmxlLiBBRkFJQ1Qgb24gdmly
dHVhbGx5IGV2ZXJ5IGNoaXBzZXQsIGJ1dCBHZW43LCB0aGUgTGludXgKZHJpdmVyIHJlYWNoZWQg
YW5kIGV2ZW4gaGFzIHN1cnBhc3NlZCB0aGUgcmVzcGVjdGl2ZSBXaW5kb3dzIGFuZC9vcgpBbmRy
b2lkIG9uZXMuIENoZWNrIHRoZSBXaWtpcGVkaWEgcGFnZSBbMV0gZm9yIGV4YWN0IGRldGFpbHMg
Oy0pCgpTaWRlIG5vZGU6CkFsdGhvdWdoIGFtZC1nZnggaXMgb2ssIG90aGVyIG1haWxpbmcgbGlz
dHMgd2lsbCBfZXhwbGljaXRseV8gZGlzY2FyZApIVE1MIGVtYWlscy4gSWYgeW91L290aGVycyBh
cmUgaW50ZXJlc3RlZCBpbiBwYXJ0aWNpcGF0aW5nIGluCm9wZW4tc291cmNlIGNvbW11bml0aWVz
LCBJJ2xsIHJlcGVhdCBteSBzdWdnZXN0aW9uIC0gYXZvaWQKaHRtbC90b3AtcG9zdGluZy4KUGxl
YXNlID8KClRoYW5rcwpFbWlsClsxXSBodHRwczovL2VuLndpa2lwZWRpYS5vcmcvd2lraS9MaXN0
X29mX0ludGVsX2dyYXBoaWNzX3Byb2Nlc3NpbmdfdW5pdHMKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
