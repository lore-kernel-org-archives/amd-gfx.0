From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/1] amdgpu: move asic id table to a separate file
Date: Tue, 16 May 2017 10:28:13 +0900
Message-ID: <b6e4c26b-2463-054b-697f-b657eb8386ed@daenzer.net>
References: <1494449815-10162-1-git-send-email-Samuel.Li@amd.com>
 <DM3PR1201MB10392013EC4407011C4F9B84F5EC0@DM3PR1201MB1039.namprd12.prod.outlook.com>
 <fcbc7ab9-f5f7-c529-9526-d78772c0d830@daenzer.net>
 <CY1PR1201MB1033C872BA2CF7916ED3A369F5ED0@CY1PR1201MB1033.namprd12.prod.outlook.com>
 <1bdcfa4a-6840-796e-1623-2949358a0364@daenzer.net>
 <CY1PR1201MB103331794AEFCBCD27AB5FFCF5E20@CY1PR1201MB1033.namprd12.prod.outlook.com>
 <832d50ad-6dbb-fd6b-b052-664f9de08153@daenzer.net>
 <CY1PR1201MB10332061C42EE8988B8250F3F5E10@CY1PR1201MB1033.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY1PR1201MB10332061C42EE8988B8250F3F5E10-JBJ/M6OpXY+2VhmsawAdvGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Yuan,
 Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

T24gMTYvMDUvMTcgMDU6NDMgQU0sIExpLCBTYW11ZWwgd3JvdGU6Cj4+IFBsZWFzZSBwcm92aWRl
IHNwZWNpZmljIHJlYXNvbnMgd2h5IHRoaXMgZmlsZSBjYW5ub3QgYmUgaW4gdGhlIGxpYmRybSBy
ZXBvc2l0b3J5IHVwc3RyZWFtLgo+IEEgc2VwYXJhdGUgcmVwbyBpcyBwcmVmZXJyZWQgaGVyZSwK
PiAxKSAgS2VlcCBhIGNsZWFuIHNlcGFyYXRpb24gYmV0d2VlbiBjb2RlIGFuZCBkYXRhLgoKV2h5
IGRvIHRoZXkgbmVlZCB0byBiZSBzZXBhcmF0ZT8KCgo+IDIpIElkZWFsbHksIHRoZSBjb21taXQg
b2YgdGhpcyBkYXRhIGZpbGUgc2hvdWxkIGNvbnRhaW4gYSBTaWduZWQtT2ZmLUJ5Ogo+IGZyb20g
c29tZW9uZSBhdXRob3JpdGF0aXZlIG9uIHRoZSBsaWNlbnNpbmcgb2YgTWFya2V0aW5nIG5hbWVz
LCBpLmUuCj4gZnJvbSBzb21lb25lIHdpdGhpbiB0aGUgdmVuZG9yIChBTUQpLgoKRG9lcyBpdCBt
YXR0ZXIgZm9yIHRoYXQgd2hpY2ggcmVwb3NpdG9yeSB0aGUgZmlsZSBpcyBsb2NhdGVkIGluPyBI
b3cgc28/Cgo+IEl0IGlzIHZlcnkgc2ltaWxhciB0byBsaW51eC1maXJtd2FyZSByZXBvIGluIHRo
YXQgaXQgY2FuIGJlIHRyZWF0ZWQgYXMKPiBhIGJsYWNrIGJveCBmcm9tIHRoZSB2ZW5kb3IgKEl0
IGNvdWxkIGJlIGEgYmluYXJ5IGlmIHJlcXVlc3RlZCwgYXMgaXQKPiBpcyBvbiBDYXRhbHlzdCBX
aW5kb3dzIGRyaXZlcikuCgpSaWdodCBub3cgaXQncyBqdXN0IGEgc2ltcGxlIHRleHQgZmlsZS4K
Cgo+IEkgYW0gb3BlbiB0byBvdGhlciBzdWdnZXN0aW9ucywgaWYgeW91IHdvdWxkIGxpa2UgdG8g
YnJpbmcgdXAuIAoKTGV0J3MgcHV0IGl0IGluIHRoZSBsaWJkcm0gcmVwb3NpdG9yeSwgdW5sZXNz
IHRoZXJlJ3MgYW4gYWN0dWFsCnRlY2huaWNhbCByZWFzb24gd2h5IGl0IGNhbid0IGJlIHRoZXJl
LiBPdGhlcndpc2Ugd2UncmUganVzdCBjcmVhdGluZwpidXN5d29yayBmb3IgZGlzdHJvIHBhY2th
Z2VycyBhbmQgZWFybHkgY29tbXVuaXR5IHRlc3RlcnMuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwg
RMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20K
TGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2Eg
YW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
