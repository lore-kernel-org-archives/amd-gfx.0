From: "Yu, Qiang" <Qiang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add amdgpu_bo_inc_ref() function.
Date: Mon, 3 Sep 2018 09:52:45 +0000
Message-ID: <BY2PR12MB02432966B8EF9D6CF93E487A8F0C0@BY2PR12MB0243.namprd12.prod.outlook.com>
References: <1535957709-26008-1-git-send-email-Qiang.Yu@amd.com>,
 <ff7f2575-7c8b-3083-d10a-7445bbaa6f14@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ff7f2575-7c8b-3083-d10a-7445bbaa6f14-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deng,
 Hui" <Hui.Deng-5C7GfCeVMHo@public.gmane.org>

Cj4+ICBhbWRncHVfYm9fZnJlZQo+PiArYW1kZ3B1X2JvX2luY19yZWYKPj4gIGFtZGdwdV9ib19p
bXBvcnQKPj4gIGFtZGdwdV9ib19saXN0X2NyZWF0ZQo+PiAgYW1kZ3B1X2JvX2xpc3RfZGVzdHJv
eQo+Cj4gVGhhbmtzIGZvciByZW1lbWJlcmluZyB0byBhZGQgdGhlIHN5bWJvbCBoZXJlLCBidXQg
YW1kZ3B1X2JvX2luY19yZWYKPiBnb2VzIGFmdGVyIGFtZGdwdV9ib19pbXBvcnQgaW4gbGV4aWNh
bCBvcmRlci4gOikKT2gsIGhhdmVuJ3Qgbm90aWNlIHRoaXMgaXMgaW4gYWxwaGFiZXRpYyBvcmRl
ci4KCj4+Cj4+ICtpbnQgYW1kZ3B1X2JvX2luY19yZWYoYW1kZ3B1X2JvX2hhbmRsZSBibykKPj4g
K3sKPj4gKyAgICAgYXRvbWljX2luYygmYm8tPnJlZmNvdW50KTsKPj4gKyAgICAgcmV0dXJuIDA7
Cj4+ICt9Cj4KPiBXaGF0J3MgdGhlIHBvaW50IG9mIGhhdmluZyBhIG5vbi12b2lkIHJldHVybiB2
YWx1ZSB0aGF0J3MgYWx3YXlzIDA/CkluZGVlZCBubyBhY3R1YWwgZnVuY3Rpb25hbGl0eSwgd2ls
bCBwcmVwYXJlIGEgcGF0Y2ggZm9yIHJlbW92aW5nIGl0LgoKVGhhbmtzLApRaWFuZwoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
