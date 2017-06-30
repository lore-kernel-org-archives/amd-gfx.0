From: "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: Make KIQ read/write register routine be atomic
Date: Fri, 30 Jun 2017 14:55:39 +0000
Message-ID: <DM5PR12MB11795DAAD88232D2874CEF17F4D30@DM5PR12MB1179.namprd12.prod.outlook.com>
References: <1498770496-28032-1-git-send-email-Shaoyun.Liu@amd.com>
 <14d97048-a0ba-69cd-1eac-e82c4462c51f@daenzer.net>
 <d9834700-f977-e5d5-2c79-7c2332ba44e9@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d9834700-f977-e5d5-2c79-7c2332ba44e9-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SGkgLCBDaHJpc3RpYW4NClRoZSBuZXcgY29kZSBhY3R1YWxseSB3aWxsIG5vdCB1c2UgdGhlIGZl
bmNlIGZ1bmN0aW9uICwgaXQganVzdCBuZWVkIGEgbWVtb3J5IHRoYXQgZXhwb3NlIGJvdGggQ1BV
IGFuZCAgR1BVIGFkZHJlc3MgLiAgRG8geW91ICByZWFsbHkgd2FudCB0byBhZGQgdGhlIHdyYXAg
ZnVuY3Rpb25zIHRoYXQganVzdCBleHBvc2UgdGhlIENQVSBhbmQgIEdQVSBhZGRyZXNzIGluIHRo
aXMgY2FzZSAgPw0KDQpSZWdhcmRzDQpTaGFveXVuLmxpdQ0KDQogDQotLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyBbbWFpbHRvOmRlYXRoc2ltcGxlQHZv
ZGFmb25lLmRlXSANClNlbnQ6IEZyaWRheSwgSnVuZSAzMCwgMjAxNyAzOjU3IEFNDQpUbzogTWlj
aGVsIETDpG56ZXI7IExpdSwgU2hhb3l1bg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBNYWtlIEtJUSByZWFkL3dyaXRl
IHJlZ2lzdGVyIHJvdXRpbmUgYmUgYXRvbWljDQoNCkFtIDMwLjA2LjIwMTcgdW0gMDM6MjEgc2No
cmllYiBNaWNoZWwgRMOkbnplcjoNCj4gT24gMzAvMDYvMTcgMDY6MDggQU0sIFNoYW95dW4gTGl1
IHdyb3RlOg0KPj4gMS4gVXNlIHNwaW4gbG9jayBpbnN0ZWFkIG9mIG11dGV4IGluIEtJUSAyLiBE
aXJlY3RseSB3cml0ZSB0byBLSVEgDQo+PiBmZW5jZSBhZGRyZXNzIGluc3RlYWQgb2YgdXNpbmcg
ZmVuY2VfZW1pdCgpIDMuIERpc2FibGUgdGhlIGludGVycnVwdCANCj4+IGZvciBLSVEgcmVhZC93
cml0ZSBhbmQgdXNlIENQVSBwb2xsaW5nDQo+IFRoaXMgbGlzdCBpbmRpY2F0ZXMgdGhhdCB0aGlz
IHBhdGNoIHNob3VsZCBiZSBzcGxpdCB1cCBpbiBhdCBsZWFzdCANCj4gdGhyZWUgcGF0Y2hlcy4g
OikNClllYWgsIGFwYXJ0IGZyb20gdGhhdCBpcyBpcyBub3QgYSBnb29kIGlkZWEgdG8gbWVzcyB3
aXRoIHRoZSBmZW5jZSBpbnRlcm5hbHMgZGlyZWN0bHkgaW4gdGhlIEtJUSBjb2RlLCBwbGVhc2Ug
YWRkIGEgaGVscGVyIGluIHRoZSBmZW5jZSBjb2RlIGZvciB0aGlzLg0KDQpSZWdhcmRzLA0KQ2hy
aXN0aWFuLg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
