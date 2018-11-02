From: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu/test: Add illegal register and memory
 access test.
Date: Fri, 2 Nov 2018 19:17:18 +0000
Message-ID: <3dd42dd2-75f2-0def-b04e-67c15847a35b@amd.com>
References: <1541010808-1293-1-git-send-email-andrey.grodzovsky@amd.com>
 <08e1a7c5-7e2e-9706-404d-4c1217b95e07@daenzer.net>
 <4a71addd-3bd9-4caf-72d0-fe4de4475fef@amd.com>
 <CADnq5_M_t5Rg3_MRvLiJQkNMrM_ZLXz2jgb2VxR2OmRGB4750g@mail.gmail.com>
 <40e6d884-f03b-58f3-88b0-d22560812f50@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2048249988=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <40e6d884-f03b-58f3-88b0-d22560812f50-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============2048249988==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_3dd42dd275f20defb04e67c15847a35bamdcom_"

--_000_3dd42dd275f20defb04e67c15847a35bamdcom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

VGhlcmUgaXMgYSBwcGxpYiBtZXNzYWdpbmcgcmVsYXRlZCBmYWlsdXJlIGN1cnJlbnRseSBkdXJp
bmcgR1BVIHJlc2V0LiBJIHdpbGwgcHV0IHRoaXMgaXNzdWUgb24gbXkgVE9ETw0KDQpsaXN0IGZv
ciBsYXRlciB0aW1lIGFmdGVyIGhhbmRsaW5nIG1vcmUgcHJpb3JpdGl6ZWQgc3R1ZmYgYW5kIHdp
bGwgZGlzYWJsZSB0aGUgZGVhZGxvY2sgdGVzdCBzdWl0ZSBmb3IgYWxsIG5vbiBkR1BVIGdmeDgv
OSBBU0lDcyB1bnRpbCB0aGVuLg0KDQpBbmRyZXkNCg0KT24gMTEvMDIvMjAxOCAwMjoxNCBQTSwg
R3JvZHpvdnNreSwgQW5kcmV5IHdyb3RlOg0KDQpIYXZlIHlvdSB0cmllZCBlbmFibGluZyByZXNl
dCBvbiBnZng3IGRHUFVzPyAgSXQgdXNlcyBwcmV0dHkgbXVjaCB0aGUNCnNhbWUgc2VxdWVuY2Ug
YXMgZ2Z4OCBzbyBpdCBtaWdodCBqdXN0IHdvcmsuDQoNCkFsZXgNCg0KDQpJIGhhdmVuJ3QgYnV0
IEkgY2FuIGdpdmUgaXQgYSB0cnkuDQoNCkFuZHJleQ0KDQoNCg0K

--_000_3dd42dd275f20defb04e67c15847a35bamdcom_
Content-Type: text/html; charset="utf-8"
Content-ID: <079D461A76E24C48AC5DB734F1A3A7CA-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjwvaGVhZD4NCjxib2R5IHRleHQ9IiMwMDAwMDAi
IGJnY29sb3I9IiNGRkZGRkYiPg0KPHA+VGhlcmUgaXMgYSBwcGxpYiBtZXNzYWdpbmcgcmVsYXRl
ZCBmYWlsdXJlIGN1cnJlbnRseSBkdXJpbmcgR1BVIHJlc2V0LiBJIHdpbGwgcHV0IHRoaXMgaXNz
dWUgb24gbXkgVE9ETzwvcD4NCjxwPmxpc3QgZm9yIGxhdGVyIHRpbWUgYWZ0ZXIgaGFuZGxpbmcg
bW9yZSBwcmlvcml0aXplZCBzdHVmZiBhbmQgd2lsbCBkaXNhYmxlIHRoZSBkZWFkbG9jayB0ZXN0
IHN1aXRlIGZvciBhbGwgbm9uIGRHUFUgZ2Z4OC85IEFTSUNzIHVudGlsIHRoZW4uPC9wPg0KPHA+
QW5kcmV5PGJyPg0KPC9wPg0KPGJyPg0KPGRpdiBjbGFzcz0ibW96LWNpdGUtcHJlZml4Ij5PbiAx
MS8wMi8yMDE4IDAyOjE0IFBNLCBHcm9kem92c2t5LCBBbmRyZXkgd3JvdGU6PGJyPg0KPC9kaXY+
DQo8YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBjaXRlPSJtaWQ6NDBlNmQ4ODQtZjAzYi01OGYzLTg4
YjAtZDIyNTYwODEyZjUwQGFtZC5jb20iPg0KPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgc3R5bGU9
ImNvbG9yOiAjMDAwMDAwOyI+DQo8cHJlIHdyYXA9IiI+SGF2ZSB5b3UgdHJpZWQgZW5hYmxpbmcg
cmVzZXQgb24gZ2Z4NyBkR1BVcz8gIEl0IHVzZXMgcHJldHR5IG11Y2ggdGhlDQpzYW1lIHNlcXVl
bmNlIGFzIGdmeDggc28gaXQgbWlnaHQganVzdCB3b3JrLg0KDQpBbGV4DQo8L3ByZT4NCjwvYmxv
Y2txdW90ZT4NCjxwcmUgd3JhcD0iIj5JIGhhdmVuJ3QgYnV0IEkgY2FuIGdpdmUgaXQgYSB0cnku
DQoNCkFuZHJleQ0KDQo8L3ByZT4NCjwvYmxvY2txdW90ZT4NCjxicj4NCjwvYm9keT4NCjwvaHRt
bD4NCg==

--_000_3dd42dd275f20defb04e67c15847a35bamdcom_--

--===============2048249988==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2048249988==--
