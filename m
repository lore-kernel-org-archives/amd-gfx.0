From: =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>
Subject: Re: TDR and VRAM lost handling in KMD:
Date: Wed, 11 Oct 2017 11:16:57 +0200
Message-ID: <57c55d0e-664b-1f8f-cd75-976cc37a8034@amd.com>
References: <BLUPR12MB0449785160E34EA9369C5E23844A0@BLUPR12MB0449.namprd12.prod.outlook.com>
 <b5c5f6c9-07e2-4688-8ffc-3929bfc59366@amd.com>
 <BLUPR12MB044911DFCB510022605DD38A844A0@BLUPR12MB0449.namprd12.prod.outlook.com>
 <DM5PR12MB1292D21FC5438AEA8FCF9F64FF4A0@DM5PR12MB1292.namprd12.prod.outlook.com>
 <BLUPR12MB0449287A92DF8D3EB30BE6A6844A0@BLUPR12MB0449.namprd12.prod.outlook.com>
 <7a7a1830-5457-ea68-44dc-f88eb1e0a8fe@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <7a7a1830-5457-ea68-44dc-f88eb1e0a8fe-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "Olsak, Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Ramirez, Alejandro" <Alejandro.Ramirez-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Filipas,
 Mario" <Mario.Filipas-5C7GfCeVMHo@public.gmane.org>, "Ding, Pixel" <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>, "Li,
 Bingley" <Bingley.Li-5C7GfCeVMHo@public.gmane.org>, "Jiang, Jerry (SW)" <Jerry.Jiang-5C7GfCeVMHo@public.gmane.org>

T24gMTEuMTAuMjAxNyAxMTowMiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gMS5LaWNrIG91
dCBhbGwgam9icyBpbiB0aGlzIOKAnGd1aWx0eeKAnSBjdHjigJlzIEtGSUZPIHF1ZXVlLCBhbmQg
c2V0IGFsbCAKPj4gdGhlaXIgZmVuY2Ugc3RhdHVzIHRvIOKAnCpFQ0FOQ0VMRUQq4oCdCj4+Cj4+
IFNldHRpbmcgRUNBTkNFTEVEIHNob3VsZCBiZSBvay4gQnV0IEkgdGhpbmsgd2Ugc2hvdWxkIGRv
IHRoaXMgd2hlbiB3ZSAKPj4gdHJ5IHRvIHJ1biB0aGUgam9icyBhbmQgbm90IGR1cmluZyBHUFUg
cmVzZXQuCj4+Cj4+IFtNTF0gd2l0aG91dCBkZWVwIHRob3VnaHQgYW5kIGV4cHJpdG1lbnQsIEni
gJltIG5vdCBzdXJlIHRoZSBkaWZmZXJlbmNlIAo+PiBiZXR3ZWVuIHRoZW0sIGJ1dCBraWNrIGl0
IG91dCBpbiBncHVfcmVzZXQgcm91dGluZSBpcyBtb3JlIGVmZmljaWVudCwKPj4KPiBJIHJlYWxs
eSBkb24ndCB0aGluayBzby4gS2lja2luZyB0aGVtIG91dCBkdXJpbmcgZ3B1X3Jlc2V0IHNvdW5k
cyByYWN5IAo+IHRvIG1lIG9uY2UgbW9yZS4KPiAKPiBBbmQgbWFya2luZyB0aGVtIGNhbmNlbGVk
IHdoZW4gd2UgdHJ5IHRvIHJ1biB0aGVtIGhhcyB0aGUgY2xlYXIgCj4gYWR2YW50YWdlIHRoYXQg
YWxsIGRlcGVuZGVuY2llcyBhcmUgbWVldCBmaXJzdC4KClRoaXMgbWFrZXMgc2Vuc2UgdG8gbWUg
YXMgd2VsbC4KCkl0IHJhaXNlcyBhIHZhZ3VlbHkgcmVsYXRlZCBxdWVzdGlvbjogV2hhdCBoYXBw
ZW5zIHRvIGpvYnMgd2hvc2UgCmRlcGVuZGVuY2llcyB3ZXJlIGNhbmNlbGVkPyBJIGJlbGlldmUg
d2UgY3VycmVudGx5IGRvbid0IGNoZWNrIHRob3NlIAplcnJvcnMsIHNvIHdlIG1pZ2h0IGV4ZWN1
dGUgdGhlbSBhbnl3YXkgaWYgdGhlaXIgY29udGV4dHMgd2VyZSAKdW5hZmZlY3RlZCBieSB0aGUg
cmVzZXQuIFRoZXJlJ3MgYSByaXNrIHRoYXQgdGhlIGpvYiB3aWxsIGhhbmcgZHVlIHRvIApzdGFs
ZSBkYXRhLgoKSSBkb24ndCB0aGluayBpdCdzIGEgaHVnZSByaXNrIGluIHByYWN0aWNlIHRvZGF5
IGJlY2F1c2Ugd2UgZG9uJ3QgaGF2ZSBhIApsb3Qgb2YgYnVmZmVyIHNoYXJpbmcgYmV0d2VlbiBh
cHBsaWNhdGlvbnMsIGJ1dCBpdCdzIHNvbWV0aGluZyB0byB0aGluayAKdGhyb3VnaCBhdCBzb21l
IHBvaW50LiBJbiBhIHdheSwgY2FuY2VsaW5nIG91dCBvZiBhbiBhYnVuZGFuY2Ugb2YgCmNhdXRp
b24gbWF5IGJlIGEgYmFkIGlkZWEgYmVjYXVzZSBpdCBjb3VsZCBraWxsIGEgY29tcG9zaXRvcidz
IHRhc2sgYnkgCmJlaW5nIG92ZXJseSBjb25zZXJ2YXRpdmUuCgpDaGVlcnMsCk5pY29sYWkKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
