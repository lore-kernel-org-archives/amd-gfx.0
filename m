Return-Path: <SRS0=QenQ=FP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C3FC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 14:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F5F120637
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 14:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5F120637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D92956E0CA;
	Fri, 11 Dec 2020 14:55:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BCCC6E03A
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Dec 2020 14:55:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLnQ4uXocCfOz/RnCLYbnRR7ItS2OZYo5M93xmbMvtEJsC8ebGKqd+t3nYA3UR82Bo76dh8AN85cc6UbvY70RVSRVIv0j+1D259E+njG4LbZtSNznFIU3n7xGnzBAXDNF2lJTwUETFZ2uJM6Ry4helQLg737tLFwj0SLtpZOKRpbVccLnUvYPVIms2/Ugy9e5dDkPBqquVYcyatXkPk1gKUOAC8RIYJilLUrXRCzGqI7eekURkxP5Q17AlkfcdwJFjy8cVo+k3lRiZqtTXaEB30QthsLb0uLMTAYBfzjemObl/jgyR5OxqTz/vRA/Xz/EGNxQ6RN/mHsY+2Q6yrMTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b36/SiVlYuW4V5cisuPOh+a3IMZ3pjOb1KomL1AEb3M=;
 b=afLpdMo3umqklsEu0VzfL/5BpYbXaWZdqGqhwuuRSr4V1ZBaXH66lKq01CTe871wweAPCWVaItE1Ddn56SlljfCVdM5+jhrstf+QLGijFdstdRPyUnhsqLZaaodtkCRes3jua+Bs3zt4rZpwTja9MijfWUw5uPLPm8CP5bQonyPVMA6QwJzsaPKKWCKNYrvcapYiMFhF3+e1ZIsOWVbVp0Fa/m+2TJdhGg5nlfYLFcjSBlxOVlmM9nR4SLsxt1V+YlXTr7UFZBNAON0znDnF+JDgIXxAsZmgoT75hhHl0jTT8MDTOfdCLPJTdzvebRE9qXfDorOiZYypMzThCzDsKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b36/SiVlYuW4V5cisuPOh+a3IMZ3pjOb1KomL1AEb3M=;
 b=s+eRtfFIBFYsT7J+F8H/r6YqmdVCnYWjVZf9O9DMWfSpTITj8uAzZLhyxomup2uiEdLCXhY3B2XSMHkwwPJEz0BNZ2RZ9VAQOoypC/KLPWBMPlThsf5rOugq69ZVTiY1n4+P6t23VBcO8z4wYNZxKo5qrn/N3ZbwCSnBRkPUIcc=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4991.namprd12.prod.outlook.com (2603:10b6:208:a4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Fri, 11 Dec
 2020 14:55:10 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af%5]) with mapi id 15.20.3632.019; Fri, 11 Dec 2020
 14:55:10 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: skip vram operation for BAMACO runtime
Thread-Topic: [PATCH] drm/amdgpu: skip vram operation for BAMACO runtime
Thread-Index: AQHWz5zh2kPlnWBTnUGUMznu3ZuO1anx+1rG
Date: Fri, 11 Dec 2020 14:55:10 +0000
Message-ID: <MN2PR12MB4488786228BE12ADC2765418F7CA0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201211090448.113278-1-likun.gao@amd.com>
In-Reply-To: <20201211090448.113278-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-11T14:55:09.943Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0743e1b6-927a-45ee-e553-08d89de4c20a
x-ms-traffictypediagnostic: MN2PR12MB4991:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB49914F7D029E7FFA0103B18DF7CA0@MN2PR12MB4991.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tpR3EB/8z8nZdvRbod9tg3T8nNp2/s6tFqpiDCyuuuDhUthN0ewhEzYldbwEXjA1MIzBuRde+rFzOz62Gwmf8srOOHsFzrxuqYLhtMpKgXCU1BXWzqZSppJrOQixlj2SUdSEemoV4US1oZT5mhfMff6Th/f+JJpernv0J0JYeotZvXKn25qLES1wOzW8sEM3Fx4l41o/2vH1f7mW0sHyCAYxXzDjFuyngHIPoqP8qh3pjPdR+/8fBEUPG868agP8HMOV9pbLkP3J5Lwt2HU8E1Vmo1kATK9PKPViyGt1dv8QGcNAbI+/VchBr/7PBbnKDg2z4NP8VcPhodIyGCk6EanrLJbzU240xWEXu1Vmzb4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(366004)(83380400001)(6506007)(71200400001)(966005)(66946007)(508600001)(7696005)(66446008)(86362001)(166002)(33656002)(66556008)(53546011)(64756008)(76116006)(52536014)(66476007)(186003)(55016002)(54906003)(4326008)(2906002)(19627405001)(45080400002)(8676002)(110136005)(5660300002)(26005)(8936002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tIy0lyOeP7J/YxuaqiNxPRblpFU0YMthUJDc0ca2wSt8Qrohy0Y2bnCGMuGs?=
 =?us-ascii?Q?bXWTec68bGd7Y+S9fgEabf891RwkqVLt4P6Ts2ac079K+IMNyF5uHFdOoKJm?=
 =?us-ascii?Q?tf6dLNIZoJ/fje/RDAih5tfUjnYDEBuuimGM8Xh56KkLXeE/nY2vI1ucXuSy?=
 =?us-ascii?Q?JCBW0TjGIQ7LhlzRSr/Hh7YFcCSmdvF/+m1vcxjMMdaBhGnAQrg0ZGA4zI9D?=
 =?us-ascii?Q?adpQDIFuIoOmt/gMdHeYGOzcFchQBolg/9UmmUjxUKUIafIR/eohMxUj82S7?=
 =?us-ascii?Q?0exAikz4Z126uqNF02OgrY7nk89RPmFfwWT1o59urqF+QI1g18Q7DX/IJ/Sq?=
 =?us-ascii?Q?VWSZmLlw92X8yFcfMf7W7/qPOxoPuSQ0yDFWEnPbq/8sviW9eV778aj3ren4?=
 =?us-ascii?Q?GKtZVP5CV1pSJJIRgJRxrLrZ5cNkN7JnDjTf+MkUqwZvf1wgmeemCqy/lgxf?=
 =?us-ascii?Q?Khl0VUPfI5wjwWqvZG1kG8r4awaqdE3GbSjIqA80393Dcs+o42h1KSO4V3Fd?=
 =?us-ascii?Q?X8Di/3KGjIM0hrGICuUvVOwYL3jNKJhxG/mCa0t/jTfC+vXvwIASpW6ZT3FS?=
 =?us-ascii?Q?S8aCuPSp6SICuswGSXrep0Hk6mSqqIviG49RO1+iKmIb2+EmBtHqNesIFz7I?=
 =?us-ascii?Q?q94wINXpnpCC5TPNdqfLu3lJieb+hPK3cy5Tkp0CxizuHeo8dYoUlU1G11bd?=
 =?us-ascii?Q?gaftZQGRuVEdpWK8qk/UAsbRXOGkfXtc8lAjoz339cXkJu8X5Pfi1tZ+zSnX?=
 =?us-ascii?Q?KUZaflR8PdjepDoeXx0JFIlewcXMjW26M33Skamp0AJHLS6htFxs8aTerJtY?=
 =?us-ascii?Q?Z/hU/13FaGiyAH12Gv/4TJJVzihzxQPGzExAWB6hOP+xOUyKkO3E4FKgruhk?=
 =?us-ascii?Q?PkDoGBo9TZ80oUiUVgwL4XisWzMn2DPUcBOV/TmwvT0ytLXRnVpyDrtKa8//?=
 =?us-ascii?Q?yLeJtniympAHbZ6UGaHpu7uMYQoTjBEFcuUa9wd3aJ4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0743e1b6-927a-45ee-e553-08d89de4c20a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2020 14:55:10.5129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mxZ+4ib4d+72Gfg31IEG3yYmGpawYrufMtT0JFmJD0kuhyrm613VNW/JBhuoig5yf1SrnFeSYIKomdHy6S/t/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4991
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0901901151=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0901901151==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488786228BE12ADC2765418F7CA0MN2PR12MB4488namp_"

--_000_MN2PR12MB4488786228BE12ADC2765418F7CA0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Instead of checking the global parameters everywhere, let's check the runti=
me pm parameter and then set a local adev variable per device.  That way we=
 can have a mix of devices that support different runtime pm modes in the s=
ame system and everything works.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Likun Ga=
o <likun.gao@amd.com>
Sent: Friday, December 11, 2020 4:04 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Gao, Likun <Likun.Gao@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Z=
hang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: skip vram operation for BAMACO runtime

From: Likun Gao <Likun.Gao@amd.com>

Skip vram related operation for bamaco rumtime suspend and resume as
vram is alive when BAMACO.
It can save about 32ms when suspend and about 15ms when resume.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I6ad39765de5ed1aac2dc51e96ed7a21a727272cd
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  9 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 72 +++++++++++++---------
 2 files changed, 50 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 0ec7c28c4d5a..66b790dfb151 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2464,7 +2464,8 @@ static int amdgpu_device_ip_late_init(struct amdgpu_d=
evice *adev)
         amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
         amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);

-       amdgpu_device_fill_reset_magic(adev);
+       if ((amdgpu_runtime_pm !=3D 2) || !adev->in_runpm)
+               amdgpu_device_fill_reset_magic(adev);

         r =3D amdgpu_device_enable_mgpu_fan_boost();
         if (r)
@@ -3706,7 +3707,8 @@ int amdgpu_device_suspend(struct drm_device *dev, boo=
l fbcon)
         amdgpu_amdkfd_suspend(adev, !fbcon);

         /* evict vram memory */
-       amdgpu_bo_evict_vram(adev);
+       if ((amdgpu_runtime_pm !=3D 2) || !adev->in_runpm)
+               amdgpu_bo_evict_vram(adev);

         amdgpu_fence_driver_suspend(adev);

@@ -3718,7 +3720,8 @@ int amdgpu_device_suspend(struct drm_device *dev, boo=
l fbcon)
          * This second call to evict vram is to evict the gart page table
          * using the CPU.
          */
-       amdgpu_bo_evict_vram(adev);
+       if ((amdgpu_runtime_pm !=3D 2) || !adev->in_runpm)
+               amdgpu_bo_evict_vram(adev);

         return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 523d22db094b..67e74b43a1ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -397,10 +397,12 @@ static int psp_tmr_init(struct psp_context *psp)
                 }
         }

-       pptr =3D amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
-       ret =3D amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_SIZE,
+       if ((amdgpu_runtime_pm !=3D 2) || !psp->adev->in_runpm) {
+               pptr =3D amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
+               ret =3D amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TM=
R_SIZE,
                                       AMDGPU_GEM_DOMAIN_VRAM,
                                       &psp->tmr_bo, &psp->tmr_mc_addr, ppt=
r);
+       }

         return ret;
 }
@@ -504,8 +506,10 @@ static int psp_tmr_terminate(struct psp_context *psp)
                 return ret;

         /* free TMR memory buffer */
-       pptr =3D amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
-       amdgpu_bo_free_kernel(&psp->tmr_bo, &psp->tmr_mc_addr, pptr);
+       if ((amdgpu_runtime_pm !=3D 2) || !psp->adev->in_runpm) {
+               pptr =3D amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
+               amdgpu_bo_free_kernel(&psp->tmr_bo, &psp->tmr_mc_addr, pptr=
);
+       }

         return 0;
 }
@@ -795,9 +799,10 @@ int psp_xgmi_terminate(struct psp_context *psp)
         psp->xgmi_context.initialized =3D 0;

         /* free xgmi shared memory */
-       amdgpu_bo_free_kernel(&psp->xgmi_context.xgmi_shared_bo,
-                       &psp->xgmi_context.xgmi_shared_mc_addr,
-                       &psp->xgmi_context.xgmi_shared_buf);
+       if ((amdgpu_runtime_pm !=3D 2) || !psp->adev->in_runpm)
+               amdgpu_bo_free_kernel(&psp->xgmi_context.xgmi_shared_bo,
+                               &psp->xgmi_context.xgmi_shared_mc_addr,
+                               &psp->xgmi_context.xgmi_shared_buf);

         return 0;
 }
@@ -812,7 +817,8 @@ int psp_xgmi_initialize(struct psp_context *psp)
             !psp->adev->psp.ta_xgmi_start_addr)
                 return -ENOENT;

-       if (!psp->xgmi_context.initialized) {
+       if (!psp->xgmi_context.initialized &&
+           ((amdgpu_runtime_pm !=3D 2) || !psp->adev->in_runpm)) {
                 ret =3D psp_xgmi_init_shared_buf(psp);
                 if (ret)
                         return ret;
@@ -1122,9 +1128,10 @@ static int psp_ras_terminate(struct psp_context *psp=
)
         psp->ras.ras_initialized =3D false;

         /* free ras shared memory */
-       amdgpu_bo_free_kernel(&psp->ras.ras_shared_bo,
-                       &psp->ras.ras_shared_mc_addr,
-                       &psp->ras.ras_shared_buf);
+       if ((amdgpu_runtime_pm !=3D 2) || !psp->adev->in_runpm)
+               amdgpu_bo_free_kernel(&psp->ras.ras_shared_bo,
+                               &psp->ras.ras_shared_mc_addr,
+                               &psp->ras.ras_shared_buf);

         return 0;
 }
@@ -1145,7 +1152,8 @@ static int psp_ras_initialize(struct psp_context *psp=
)
                 return 0;
         }

-       if (!psp->ras.ras_initialized) {
+       if (!psp->ras.ras_initialized &&
+           ((amdgpu_runtime_pm !=3D 2) || !psp->adev->in_runpm)) {
                 ret =3D psp_ras_init_shared_buf(psp);
                 if (ret)
                         return ret;
@@ -1257,7 +1265,8 @@ static int psp_hdcp_initialize(struct psp_context *ps=
p)
                 return 0;
         }

-       if (!psp->hdcp_context.hdcp_initialized) {
+       if (!psp->hdcp_context.hdcp_initialized &&
+           ((amdgpu_runtime_pm !=3D 2) || !psp->adev->in_runpm)) {
                 ret =3D psp_hdcp_init_shared_buf(psp);
                 if (ret)
                         return ret;
@@ -1325,9 +1334,10 @@ static int psp_hdcp_terminate(struct psp_context *ps=
p)
         psp->hdcp_context.hdcp_initialized =3D false;

         /* free hdcp shared memory */
-       amdgpu_bo_free_kernel(&psp->hdcp_context.hdcp_shared_bo,
-                             &psp->hdcp_context.hdcp_shared_mc_addr,
-                             &psp->hdcp_context.hdcp_shared_buf);
+       if ((amdgpu_runtime_pm !=3D 2) || !psp->adev->in_runpm)
+               amdgpu_bo_free_kernel(&psp->hdcp_context.hdcp_shared_bo,
+                                     &psp->hdcp_context.hdcp_shared_mc_add=
r,
+                                     &psp->hdcp_context.hdcp_shared_buf);

         return 0;
 }
@@ -1404,7 +1414,8 @@ static int psp_dtm_initialize(struct psp_context *psp=
)
                 return 0;
         }

-       if (!psp->dtm_context.dtm_initialized) {
+       if (!psp->dtm_context.dtm_initialized &&
+           ((amdgpu_runtime_pm !=3D 2) || !psp->adev->in_runpm)) {
                 ret =3D psp_dtm_init_shared_buf(psp);
                 if (ret)
                         return ret;
@@ -1472,9 +1483,10 @@ static int psp_dtm_terminate(struct psp_context *psp=
)
         psp->dtm_context.dtm_initialized =3D false;

         /* free hdcp shared memory */
-       amdgpu_bo_free_kernel(&psp->dtm_context.dtm_shared_bo,
-                             &psp->dtm_context.dtm_shared_mc_addr,
-                             &psp->dtm_context.dtm_shared_buf);
+       if ((amdgpu_runtime_pm !=3D 2) || !psp->adev->in_runpm)
+               amdgpu_bo_free_kernel(&psp->dtm_context.dtm_shared_bo,
+                                     &psp->dtm_context.dtm_shared_mc_addr,
+                                     &psp->dtm_context.dtm_shared_buf);

         return 0;
 }
@@ -1563,7 +1575,8 @@ static int psp_rap_initialize(struct psp_context *psp=
)
                 return 0;
         }

-       if (!psp->rap_context.rap_initialized) {
+       if (!psp->rap_context.rap_initialized &&
+           ((amdgpu_runtime_pm !=3D 2) || !psp->adev->in_runpm)) {
                 ret =3D psp_rap_init_shared_buf(psp);
                 if (ret)
                         return ret;
@@ -1602,9 +1615,10 @@ static int psp_rap_terminate(struct psp_context *psp=
)
         psp->rap_context.rap_initialized =3D false;

         /* free rap shared memory */
-       amdgpu_bo_free_kernel(&psp->rap_context.rap_shared_bo,
-                             &psp->rap_context.rap_shared_mc_addr,
-                             &psp->rap_context.rap_shared_buf);
+       if ((amdgpu_runtime_pm !=3D2) || !psp->adev->in_runpm)
+               amdgpu_bo_free_kernel(&psp->rap_context.rap_shared_bo,
+                                     &psp->rap_context.rap_shared_mc_addr,
+                                     &psp->rap_context.rap_shared_buf);

         return ret;
 }
@@ -2261,10 +2275,12 @@ static int psp_resume(void *handle)

         DRM_INFO("PSP is resuming...\n");

-       ret =3D psp_mem_training(psp, PSP_MEM_TRAIN_RESUME);
-       if (ret) {
-               DRM_ERROR("Failed to process memory training!\n");
-               return ret;
+       if ((amdgpu_runtime_pm !=3D 2) || !psp->adev->in_runpm) {
+               ret =3D psp_mem_training(psp, PSP_MEM_TRAIN_RESUME);
+               if (ret) {
+                       DRM_ERROR("Failed to process memory training!\n");
+                       return ret;
+               }
         }

         mutex_lock(&adev->firmware.mutex);
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C0bee5882ad6142eb967c08d89db4018b%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637432743751698480%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3D1AU6gN6Yqp8yZT%2BHDWfAwFh9UuWh7XoJg2kD%2F%2BbwZjA%3D&amp;reserved=3D0

--_000_MN2PR12MB4488786228BE12ADC2765418F7CA0MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Instead of checking the global parameters everywhere, let's check the runti=
me pm parameter and then set a local adev variable per device.&nbsp; That w=
ay we can have a mix of devices that support different runtime pm modes in =
the same system and everything works.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Likun Gao &lt;likun.gao@amd.c=
om&gt;<br>
<b>Sent:</b> Friday, December 11, 2020 4:04 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Gao, Likun &lt;Likun.Gao@amd.com&gt;; Feng, Kenneth &lt;Kenneth.=
Feng@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: skip vram operation for BAMACO runtime<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Likun Gao &lt;Likun.Gao@amd.com&gt;<br>
<br>
Skip vram related operation for bamaco rumtime suspend and resume as<br>
vram is alive when BAMACO.<br>
It can save about 32ms when suspend and about 15ms when resume.<br>
<br>
Signed-off-by: Likun Gao &lt;Likun.Gao@amd.com&gt;<br>
Change-Id: I6ad39765de5ed1aac2dc51e96ed7a21a727272cd<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |&nbsp; 9 ++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c&nbsp;&nbsp;&nbsp; | 72 ++++++=
+++++++---------<br>
&nbsp;2 files changed, 50 insertions(+), 31 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 0ec7c28c4d5a..66b790dfb151 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2464,7 +2464,8 @@ static int amdgpu_device_ip_late_init(struct amdgpu_d=
evice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_cg_state=
(adev, AMD_CG_STATE_GATE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_pg_state=
(adev, AMD_PG_STATE_GATE);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_fill_reset_magic(adev);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_runtime_pm !=3D 2) || !ad=
ev-&gt;in_runpm)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_fill_reset_magic(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_enable=
_mgpu_fan_boost();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
@@ -3706,7 +3707,8 @@ int amdgpu_device_suspend(struct drm_device *dev, boo=
l fbcon)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_suspend(adev=
, !fbcon);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* evict vram memory */<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_evict_vram(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_runtime_pm !=3D 2) || !ad=
ev-&gt;in_runpm)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_bo_evict_vram(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fence_driver_suspen=
d(adev);<br>
&nbsp;<br>
@@ -3718,7 +3720,8 @@ int amdgpu_device_suspend(struct drm_device *dev, boo=
l fbcon)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * This second call t=
o evict vram is to evict the gart page table<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * using the CPU.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_evict_vram(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_runtime_pm !=3D 2) || !ad=
ev-&gt;in_runpm)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_bo_evict_vram(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index 523d22db094b..67e74b43a1ab 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -397,10 +397,12 @@ static int psp_tmr_init(struct psp_context *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pptr =3D amdgpu_sriov_vf(psp-&gt;adev=
) ? &amp;tmr_buf : NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_create_kernel(psp-&=
gt;adev, tmr_size, PSP_TMR_SIZE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_runtime_pm !=3D 2) || !ps=
p-&gt;adev-&gt;in_runpm) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pptr =3D amdgpu_sriov_vf(psp-&gt;adev) ? &amp;tmr_buf : NULL;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D amdgpu_bo_create_kernel(psp-&gt;adev, tmr_size, PSP_TMR_=
SIZE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; AMDGPU_GEM_DOMAIN_VRAM,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &amp;psp-&gt;tmr_bo, &amp;psp-&gt;tmr_mc_addr, pptr);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
@@ -504,8 +506,10 @@ static int psp_tmr_terminate(struct psp_context *psp)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* free TMR memory buffer =
*/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pptr =3D amdgpu_sriov_vf(psp-&gt;adev=
) ? &amp;tmr_buf : NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;psp-&gt;tm=
r_bo, &amp;psp-&gt;tmr_mc_addr, pptr);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_runtime_pm !=3D 2) || !ps=
p-&gt;adev-&gt;in_runpm) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pptr =3D amdgpu_sriov_vf(psp-&gt;adev) ? &amp;tmr_buf : NULL;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_bo_free_kernel(&amp;psp-&gt;tmr_bo, &amp;psp-&gt;tmr_mc_a=
ddr, pptr);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -795,9 +799,10 @@ int psp_xgmi_terminate(struct psp_context *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;xgmi_context.initi=
alized =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* free xgmi shared memory=
 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;psp-&gt;xg=
mi_context.xgmi_shared_bo,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;psp-&gt;xgm=
i_context.xgmi_shared_mc_addr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;psp-&gt;xgm=
i_context.xgmi_shared_buf);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_runtime_pm !=3D 2) || !ps=
p-&gt;adev-&gt;in_runpm)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_bo_free_kernel(&amp;psp-&gt;xgmi_context.xgmi_shared_bo,<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;psp-&gt;xgmi_context.xgmi_shared_mc_ad=
dr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;psp-&gt;xgmi_context.xgmi_shared_buf);=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -812,7 +817,8 @@ int psp_xgmi_initialize(struct psp_context *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !p=
sp-&gt;adev-&gt;psp.ta_xgmi_start_addr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOENT;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;xgmi_context.initialized=
) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;xgmi_context.initialized=
 &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((amdgpu_runt=
ime_pm !=3D 2) || !psp-&gt;adev-&gt;in_runpm)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D psp_xgmi_init_shared_buf(psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
@@ -1122,9 +1128,10 @@ static int psp_ras_terminate(struct psp_context *psp=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;ras.ras_initialize=
d =3D false;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* free ras shared memory =
*/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;psp-&gt;ra=
s.ras_shared_bo,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;psp-&gt;ras=
.ras_shared_mc_addr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;psp-&gt;ras=
.ras_shared_buf);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_runtime_pm !=3D 2) || !ps=
p-&gt;adev-&gt;in_runpm)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_bo_free_kernel(&amp;psp-&gt;ras.ras_shared_bo,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;psp-&gt;ras.ras_shared_mc_addr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;psp-&gt;ras.ras_shared_buf);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -1145,7 +1152,8 @@ static int psp_ras_initialize(struct psp_context *psp=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;ras.ras_initialized) {<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;ras.ras_initialized &amp=
;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((amdgpu_runt=
ime_pm !=3D 2) || !psp-&gt;adev-&gt;in_runpm)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D psp_ras_init_shared_buf(psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
@@ -1257,7 +1265,8 @@ static int psp_hdcp_initialize(struct psp_context *ps=
p)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;hdcp_context.hdcp_initia=
lized) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;hdcp_context.hdcp_initia=
lized &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((amdgpu_runt=
ime_pm !=3D 2) || !psp-&gt;adev-&gt;in_runpm)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D psp_hdcp_init_shared_buf(psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
@@ -1325,9 +1334,10 @@ static int psp_hdcp_terminate(struct psp_context *ps=
p)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;hdcp_context.hdcp_=
initialized =3D false;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* free hdcp shared memory=
 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;psp-&gt;hd=
cp_context.hdcp_shared_bo,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &amp;psp-&gt;hdcp_context.hdcp_shared_mc_addr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &amp;psp-&gt;hdcp_context.hdcp_shared_buf);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_runtime_pm !=3D 2) || !ps=
p-&gt;adev-&gt;in_runpm)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_bo_free_kernel(&amp;psp-&gt;hdcp_context.hdcp_shared_bo,<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ps=
p-&gt;hdcp_context.hdcp_shared_mc_addr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ps=
p-&gt;hdcp_context.hdcp_shared_buf);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -1404,7 +1414,8 @@ static int psp_dtm_initialize(struct psp_context *psp=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;dtm_context.dtm_initiali=
zed) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;dtm_context.dtm_initiali=
zed &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((amdgpu_runt=
ime_pm !=3D 2) || !psp-&gt;adev-&gt;in_runpm)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D psp_dtm_init_shared_buf(psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
@@ -1472,9 +1483,10 @@ static int psp_dtm_terminate(struct psp_context *psp=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;dtm_context.dtm_in=
itialized =3D false;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* free hdcp shared memory=
 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;psp-&gt;dt=
m_context.dtm_shared_bo,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &amp;psp-&gt;dtm_context.dtm_shared_mc_addr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &amp;psp-&gt;dtm_context.dtm_shared_buf);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_runtime_pm !=3D 2) || !ps=
p-&gt;adev-&gt;in_runpm)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_bo_free_kernel(&amp;psp-&gt;dtm_context.dtm_shared_bo,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ps=
p-&gt;dtm_context.dtm_shared_mc_addr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ps=
p-&gt;dtm_context.dtm_shared_buf);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -1563,7 +1575,8 @@ static int psp_rap_initialize(struct psp_context *psp=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;rap_context.rap_initiali=
zed) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;rap_context.rap_initiali=
zed &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((amdgpu_runt=
ime_pm !=3D 2) || !psp-&gt;adev-&gt;in_runpm)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D psp_rap_init_shared_buf(psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
@@ -1602,9 +1615,10 @@ static int psp_rap_terminate(struct psp_context *psp=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;rap_context.rap_in=
itialized =3D false;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* free rap shared memory =
*/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;psp-&gt;ra=
p_context.rap_shared_bo,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &amp;psp-&gt;rap_context.rap_shared_mc_addr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &amp;psp-&gt;rap_context.rap_shared_buf);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_runtime_pm !=3D2) || !psp=
-&gt;adev-&gt;in_runpm)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_bo_free_kernel(&amp;psp-&gt;rap_context.rap_shared_bo,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ps=
p-&gt;rap_context.rap_shared_mc_addr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ps=
p-&gt;rap_context.rap_shared_buf);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
@@ -2261,10 +2275,12 @@ static int psp_resume(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;PSP is resu=
ming...\n&quot;);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_mem_training(psp, PSP_MEM=
_TRAIN_RESUME);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;Failed to process memory training!\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_runtime_pm !=3D 2) || !ps=
p-&gt;adev-&gt;in_runpm) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D psp_mem_training(psp, PSP_MEM_TRAIN_RESUME);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;=
Failed to process memory training!\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;f=
irmware.mutex);<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C0bee5882ad6142eb967c08d89db4018b%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637432743751698480%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3D1AU6gN6Yqp8yZT%2BHDWfAwFh9UuWh7XoJg2kD%2F%2BbwZjA%3D=
&amp;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=
=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;a=
mp;data=3D04%7C01%7Calexander.deucher%40amd.com%7C0bee5882ad6142eb967c08d89=
db4018b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637432743751698480%7CU=
nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC=
JXVCI6Mn0%3D%7C1000&amp;amp;sdata=3D1AU6gN6Yqp8yZT%2BHDWfAwFh9UuWh7XoJg2kD%=
2F%2BbwZjA%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488786228BE12ADC2765418F7CA0MN2PR12MB4488namp_--

--===============0901901151==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0901901151==--
