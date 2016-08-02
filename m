From: "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] Add freesync ioctl interface
Date: Tue, 2 Aug 2016 04:14:01 +0000
Message-ID: <BN6PR12MB1204C7FDE82DB11764D57AC3FC050@BN6PR12MB1204.namprd12.prod.outlook.com>
References: <1470104760-30612-1-git-send-email-Hawking.Zhang@amd.com>
 <11f584d2-7d40-4318-7725-672816b9cd9c@daenzer.net>
 <BN6PR12MB120484B42FE46271D494A73EFC050@BN6PR12MB1204.namprd12.prod.outlook.com>
 <09948c72-7214-5863-5af8-a60dc481371c@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <09948c72-7214-5863-5af8-a60dc481371c-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

VGhlIGtlcm5lbCBicmFuY2ggaGFzIGFscmVhZHkgbWVyZ2VkIHRoZSBpb2N0bCBpbXBsZW1lbnRh
dGlvbi4gSSdtIG9rYXkgdG8ga2VlcCBpdCBpbnRlcm5hbCBhbHRob3VnaC4NCg0KDQpSZWdhcmRz
LA0KSGF3a2luZw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTWljaGVsIETD
pG56ZXIgW21haWx0bzptaWNoZWxAZGFlbnplci5uZXRdIA0KU2VudDogVHVlc2RheSwgQXVndXN0
IDAyLCAyMDE2IDExOjMyDQpUbzogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNv
bT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUmU6IFtQQVRD
SF0gQWRkIGZyZWVzeW5jIGlvY3RsIGludGVyZmFjZQ0KDQpPbiAwMi4wOC4yMDE2IDEyOjEyLCBa
aGFuZywgSGF3a2luZyB3cm90ZToNCj4gVGhlIGltcGxlbWVudGF0aW9uIGlzIGFzIFtQQVRDSF0g
RW5hYmxlL2Rpc2FibGUgZnJlZXN5bmMgd2hlbiANCj4gZW50ZXIvZXhpdCBmdWxsc2NyZWVuIGdh
bWUuDQoNCkkgbWVhbiBhbiBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgaW9jdGwgaW4gdGhlIGtlcm5l
bCBkcml2ZXIuDQoNCg0KUC5TLiBQbGVhc2UgcnVuIHRoZSBmb2xsb3dpbmcgY29tbWFuZCBpbiBl
YWNoIEdpdCByZXBvc2l0b3J5LCBzbyB0aGF0IHRoZSBbUEFUQ0hdIHByZWZpeCBpbmNsdWRlcyB3
aGljaCByZXBvc2l0b3J5IGEgcGF0Y2ggaXMgZm9yOg0KDQogZ2l0IGNvbmZpZyBmb3JtYXQuc3Vi
amVjdHByZWZpeCAiUEFUQ0ggJChiYXNlbmFtZSAkUFdEKSINCg0KLS0gDQpFYXJ0aGxpbmcgTWlj
aGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQu
Y29tDQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAg
TWVzYSBhbmQgWCBkZXZlbG9wZXINCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
