From: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: disable job timeout on GPU reset disabled
Date: Tue, 20 Mar 2018 02:11:24 +0000
Message-ID: <DM5PR1201MB248999A09FAAC36F90204EF9E4AB0@DM5PR1201MB2489.namprd12.prod.outlook.com>
References: <1521439692-14823-1-git-send-email-evan.quan@amd.com>
 <d7a88e66-6533-9c12-c36c-9b3ea569e354@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_DM5PR1201MB248999A09FAAC36F90204EF9E4AB0DM5PR1201MB2489_"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d7a88e66-6533-9c12-c36c-9b3ea569e354-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--_002_DM5PR1201MB248999A09FAAC36F90204EF9E4AB0DM5PR1201MB2489_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgQ2hyaXN0aWFuLA0KDQpUaGUgbWVzc2FnZXMgcHJvbXB0ZWQgb24gdGltZW91dCBhcmUgRXJy
b3JzIG5vdCBqdXN0IFdhcm5pbmdzIGFsdGhvdWdoIHdlIGRpZCBub3Qgc2VlIGFueSByZWFsIHBy
b2JsZW0oZm9yIHRoZSBkZ2VtbSBzcGVjaWFsIGNhc2UpLiBUaGF0J3Mgd2h5IHdlIHNheSBpdCBj
b25mdXNpbmcuDQpBbmQgaSBzdXBwb3NlIHlvdSB3YW50IGEgZml4IGxpa2UgbXkgcHJldmlvdXMg
cGF0Y2goc2VlIGF0dGFjaG1lbnQpLg0KDQpSZWdhcmRzLA0KRXZhbg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIFttYWlsdG86Y2tvZW5pZy5s
ZWljaHR6dW1lcmtlbkBnbWFpbC5jb21dDQo+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMTksIDIwMTgg
NTo0MiBQTQ0KPiBUbzogUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+OyBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIu
RGV1Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBkaXNh
YmxlIGpvYiB0aW1lb3V0IG9uIEdQVSByZXNldA0KPiBkaXNhYmxlZA0KPiANCj4gQW0gMTkuMDMu
MjAxOCB1bSAwNzowOCBzY2hyaWViIEV2YW4gUXVhbjoNCj4gPiBTaW5jZSB1bmRlciBzb21lIGhl
YXZ5IGNvbXB1dGluZyBlbnZpcm9ubWVudChkZ2VtbSB0ZXN0KSwgaXQgdGFrZXMgdGhlDQo+ID4g
YXNpYyBvdmVyIDEwKyBzZWNvbmRzIHRvIGZpbmlzaCB0aGUgZGlzcGF0Y2hlZCBzaW5nbGUgam9i
IHdoaWNoIHdpbGwNCj4gPiB0cmlnZ2VyIHRoZSB0aW1lb3V0LiBJdCdzIHF1aXRlIGNvbmZ1c2lu
ZyBhbHRob3VnaCBpdCBkb2VzIG5vdCBzZWVtIHRvDQo+ID4gYnJpbmcgYW55IHJlYWwgcHJvYmxl
bXMuDQo+ID4gQXMgYSBxdWljayB3b3Jrcm91bmQsIHdlIGNob29zZSB0byBkaXNhYmxlIHRpbWVv
dXQgd2hlbiBHUFUgcmVzZXQgaXMNCj4gPiBkaXNhYmxlZC4NCj4gDQo+IE5BSywgSSBlbmFibGVk
IHRob3NlIHdhcm5pbmcgaW50ZW50aW9uYWxseSBldmVuIHdoZW4gdGhlIEdQVSByZWNvdmVyeSBp
cw0KPiBkaXNhYmxlZCB0byBoYXZlIGEgaGludCBpbiB0aGUgbG9ncyB3aGF0IGdvZXMgd3Jvbmcu
DQo+IA0KPiBQbGVhc2Ugb25seSBpbmNyZWFzZSB0aGUgdGltZW91dCBmb3IgdGhlIGNvbXB1dGUg
cXVldWUgYW5kL29yIGFkZCBhDQo+IHNlcGFyYXRlIHRpbWVvdXQgZm9yIHRoZW0uDQo+IA0KPiBS
ZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo+IA0KPiANCj4gPg0KPiA+IENoYW5nZS1JZDogSTNhOTVk
ODU2YmE0OTkzMDk0ZGM3YjYyNjk2NDllNDcwYzViMDUzZDINCj4gPiBTaWduZWQtb2ZmLWJ5OiBF
dmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgNyArKysrKysrDQo+ID4gICAxIGZpbGUg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPiBpbmRleCA4YmQ5YzNmLi45ZDZhNzc1IDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0K
PiA+IEBAIC04NjEsNiArODYxLDEzIEBAIHN0YXRpYyB2b2lkDQo+IGFtZGdwdV9kZXZpY2VfY2hl
Y2tfYXJndW1lbnRzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiA+ICAgCQlhbWRncHVf
bG9ja3VwX3RpbWVvdXQgPSAxMDAwMDsNCj4gPiAgIAl9DQo+ID4NCj4gPiArCS8qDQo+ID4gKwkg
KiBEaXNhYmxlIHRpbWVvdXQgd2hlbiBHUFUgcmVzZXQgaXMgZGlzYWJsZWQgdG8gYXZvaWQgY29u
ZnVzaW5nDQo+ID4gKwkgKiB0aW1lb3V0IG1lc3NhZ2VzIGluIHRoZSBrZXJuZWwgbG9nLg0KPiA+
ICsJICovDQo+ID4gKwlpZiAoYW1kZ3B1X2dwdV9yZWNvdmVyeSA9PSAwIHx8IGFtZGdwdV9ncHVf
cmVjb3ZlcnkgPT0gLTEpDQo+ID4gKwkJYW1kZ3B1X2xvY2t1cF90aW1lb3V0ID0gSU5UX01BWDsN
Cj4gPiArDQo+ID4gICAJYWRldi0+ZmlybXdhcmUubG9hZF90eXBlID0gYW1kZ3B1X3Vjb2RlX2dl
dF9sb2FkX3R5cGUoYWRldiwNCj4gYW1kZ3B1X2Z3X2xvYWRfdHlwZSk7DQo+ID4gICB9DQo+ID4N
Cg0K

--_002_DM5PR1201MB248999A09FAAC36F90204EF9E4AB0DM5PR1201MB2489_
Content-Type: message/rfc822
Content-Disposition: attachment;
	creation-date="Tue, 20 Mar 2018 02:11:21 GMT";
	modification-date="Tue, 20 Mar 2018 02:11:21 GMT"

Received: from CY4PR1201MB2485.namprd12.prod.outlook.com
 (2a01:111:e400:c60a::18) by DM5PR1201MB2489.namprd12.prod.outlook.com with
 HTTPS via CY1PR07CA0008.NAMPRD07.PROD.OUTLOOK.COM; Fri, 16 Mar 2018 04:52:40
 +0000
Received: from CY1PR1201CA0013.namprd12.prod.outlook.com
 (2a01:111:e400:5b9a::23) by CY4PR1201MB2485.namprd12.prod.outlook.com
 (2603:10b6:903:d0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.588.14; Fri, 16
 Mar 2018 04:52:38 +0000
Received: from DM3NAM03FT062.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::202) by CY1PR1201CA0013.outlook.office365.com
 (2a01:111:e400:5b9a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.588.14 via Frontend
 Transport; Fri, 16 Mar 2018 04:52:38 +0000
Received: from mail.amd.com (165.204.84.17) by
 DM3NAM03FT062.mail.protection.outlook.com (10.152.83.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.567.18 via Frontend Transport; Fri, 16 Mar 2018 04:52:38 +0000
Received: from build-machine.amd.com (10.34.1.3) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server id 14.3.382.0; Thu, 15 Mar 2018
 23:52:38 -0500
From: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
CC: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan"
	<Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: no job timeout setting on compute queues
Thread-Topic: [PATCH] drm/amdgpu: no job timeout setting on compute queues
Thread-Index: AQHTvOKcbuVLKZ6LcUmip8+3pClWDQ==
Date: Fri, 16 Mar 2018 04:52:32 +0000
Message-ID: <1521175952-21758-1-git-send-email-evan.quan-5C7GfCeVMHo@public.gmane.org>
Content-Language: zh-CN
X-MS-Exchange-Organization-AuthSource: SATLEXCHOV01.amd.com
X-MS-Has-Attach: 
X-MS-Exchange-Organization-Network-Message-Id: d6e40a1e-2deb-44b0-eef4-08d58af9be43
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-organization-originalclientipaddress: 10.34.1.3
x-ms-exchange-organization-originalserveripaddress: 10.152.83.142
x-ms-publictraffictype: Email
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB2489;27:Vzjyyddz1h98qxsCoKgC/Gg8vHcXDuIQDVxEJIgYsGfULQovHdTDkTPsApQ9GTjbGZJ7FPu9f1SCMFaNWS5J4rs0UQphIput7Gnoc7g9g+s/4o+Ao52ZSlJkvWvHp3lY
X-Microsoft-Antispam-Message-Info: yKPd7mEC4JWZ68M8ZmCJw589CLsph8OupI1eRInh8qigWB2GBt5XIgIVyimJGGLlxQNaBYqYd+mO03FCZI0UQKNPRbFMi2v/8i/SeTyFPJk9Hruj/O2blasB3WQyQDFZmAPtikPSk4gOx6b0Y3Ed3RtlgIfTTNYdewuHNPphSX+E0vUcwqPlaC7EHaz4qQBK7r484NlF4/uVx5eIgeaDjivshK6KIvFHjBvUWX5EFTNxwud5t8q2TaBLhX6FDfaqBxx/mgpQ0pv0UQRZ0QG71nolgOn+n5vc+cgPwWNK2SzQsdO6wwEG+5DWNVQxymkUCWFeEtqDSe7/ZFvqVGbqScQyMyFmq9WhKYmpd/jSO985pWq53q2ieIfAIwljcw7/C2mx2ZmRAmOFS14yXl8DnN9jixsvqh8OumHSZvSkDkv8u9bAzzv5tfRxW0Hpt/8wGktdsTU2FPWkomK+oIcfuo35VgyWqXVeI8G29TTkW0VbkyFyMounMh1dIkcTW8uq/k137G75mqQK0IVv1Cv1YGUa2+S+U6aNbI6Oef4GWC31ltI9c86OAi8hyl3sk18f
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0

Under some heavy computing test(dgemm) environment, it may takes
the asic over 50+ seconds to finish the dispatched single job
which will trigger the timeout. It's quite annoying although it
does not seem to bring any real problems.
As a quick workround, we choose to not enfoce the timeout
setting on compute queues.

Change-Id: I210011a90898617367e897a90e9f8fb2639281a3
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_fence.c
index 008e198..455a81e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -435,7 +435,9 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *r=
ing,
        if (ring->funcs->type !=3D AMDGPU_RING_TYPE_KIQ) {
                r =3D drm_sched_init(&ring->sched, &amdgpu_sched_ops,
                                   num_hw_submission, amdgpu_job_hang_limit=
,
-                                  msecs_to_jiffies(amdgpu_lockup_timeout),=
 ring->name);
+                                  (ring->funcs->type =3D=3D AMDGPU_RING_TY=
PE_COMPUTE) ?
+                                  MAX_SCHEDULE_TIMEOUT : msecs_to_jiffies(=
amdgpu_lockup_timeout),
+                                  ring->name);
                if (r) {
                        DRM_ERROR("Failed to create scheduler on ring %s.\n=
",
                                  ring->name);
--
2.7.4


--_002_DM5PR1201MB248999A09FAAC36F90204EF9E4AB0DM5PR1201MB2489_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--_002_DM5PR1201MB248999A09FAAC36F90204EF9E4AB0DM5PR1201MB2489_--
