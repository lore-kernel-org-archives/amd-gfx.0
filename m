From: David Binderman <dcb314-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: linux-4.11-rc1/drivers/gpu/drm/amd/amdgpu/vi.c: 3 bugs
Date: Mon, 6 Mar 2017 09:40:24 +0000
Message-ID: <DB5PR08MB096711F1A243B7E14ADFB1349C2C0@DB5PR08MB0967.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-GB
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
To: "alexander.deucher-5C7GfCeVMHo@public.gmane.org" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "airlied-cv59FeDIM0c@public.gmane.org" <airlied-cv59FeDIM0c@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

CkhlbGxvIHRoZXJlLAoxCgpbbGludXgtNC4xMS1yYzEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdmkuYzoxMDQxXSAtPiBbbGludXgtNC4xMS1yYzEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdmkuYzoxMDM3XTogKHN0eWxlKSBTYW1lIGV4cHJlc3Npb24gb24gYm90aCBzaWRlcyBvZiAn
fCcuCgpNYXliZSB0aGUgbWFjcm8gQU1EX0NHX1NVUFBPUlRfR0ZYX01HTFMgaXMgdXNlZCB0d2lj
ZSA/CgoyLgoKW2xpbnV4LTQuMTEtcmMxL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmM6
MTA3MF0gLT4gW2xpbnV4LTQuMTEtcmMxL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmM6
MTA2Nl06IChzdHlsZSkgU2FtZSBleHByZXNzaW9uIG9uIGJvdGggc2lkZXMgb2YgJ3wnLgoKRHVw
bGljYXRlLgoKSW4gdGhlIHNhbWUgZmlsZToKCmxpbnV4LTQuMTEtcmMxL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3ZpLmM6NzkyXTogKHN0eWxlKSBWYXJpYWJsZSAncicgaXMgYXNzaWduZWQg
YSB2YWx1ZSB0aGF0IGlzIG5ldmVyIHVzZWQuCgpTb3VyY2UgY29kZSBpcwoKICAgIHIgPSB2aV9z
ZXRfdXZkX2Nsb2NrKGFkZXYsIGRjbGssIGl4Q0dfRENMS19DTlRMLCBpeENHX0RDTEtfU1RBVFVT
KTsKCiAgICByZXR1cm4gMDsKClJlZ2FyZHMKCkRhdmlkIEJpbmRlcm1hbgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
