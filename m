Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1C8CD98CC
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 18:53:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A02FD10EB91;
	Wed, 10 Jun 2026 18:53:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lypby0Nn";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66D2010EB91
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 18:53:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvEKAY7vrvMcsS4IlP+1X96CygDjPRE36kZTI+vOQSP3eCvUOtwf6pzSNVT5zhqaRz+nFtqWwNQzDbw11bWrMq5wPPF+TisFM/c8+wRNLzx3/iAESziIrqKvhAGMfBHiYvIO/ahdtm8UqPwg63Jox8MCsAGpOJxRo2jeWz5sbKvWbVfhFrJevclMm3JBC6b7O7giBGcHllz+J3JcOTs+e/UUJML6LsyuyNACwOlgGynKg365jx5awHwdeZmVastDhbZhUiGvBXeXCChGEVUBRrW7k564K5qPUYL3mbNN88E6MMQl4f4OQzlM466Mu3GEVu6KiD8FtsbAYY4TmNJqGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJs9i1Luwzmenm1AnWTDEAHtVuf2jl6RrfxifNPOBJY=;
 b=CXtV0hYLrd1UHf8GL21/K1SYgd0Luui4KC+xyYl88S3VR5JAMEY1AjhXjkJi3d/30/bUxRnFXkjzjdwGxWPpK9ThxihfNMDvyICp8rgJBfB6zD44XRS0fAwqp3DNHLghDmD3F/WyGwuz+Pw+wU/s4/mgzyGmx2q7q/3DYcOOZmSsXKI5xphumppfn7MHbHJXX2+O6+8c2QwTM1gVecRvOoQdX30ABQorexVHCPwvCyZXgbhlZ0TT+5QJGQ3K9cZfI6Npv+0nwPMkT+WgH5ORCMbS0CDPXpHpl/Pdf+qS2K/YpQKDYbQgkhC4ovAEOFRwb9nJ+37/HhQhHo4N718Oww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJs9i1Luwzmenm1AnWTDEAHtVuf2jl6RrfxifNPOBJY=;
 b=Lypby0Nnm6MAiYZ9Igv9RvwEf3SFzEx0T8mThdSbfnISj7q+gDR/kraoCDZeKC1XcWThUIk0Hg6bSnLVUM+ay2CvrYtVhsQvyNd8JXNWzB83Fr1Z9d3ZIVkYGuL/N9DJqya4fpAUEEZhBOgQ74W3j6mYA+cb4pLcw6Bexaq0Y+U=
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13)
 by MW6PR12MB7069.namprd12.prod.outlook.com (2603:10b6:303:238::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 18:53:14 +0000
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957]) by SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957%7]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 18:53:14 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v3] drm/amdkfd: add sdma queue counter for gfxv9.4.3
Thread-Topic: [PATCH v3] drm/amdkfd: add sdma queue counter for gfxv9.4.3
Thread-Index: AQHc+Og68+BhW/EH0UG01PU0Y+SKFLY4ItaF
Date: Wed, 10 Jun 2026 18:53:14 +0000
Message-ID: <SJ2PR12MB86505596D675BC411FAFDD5A8C1A2@SJ2PR12MB8650.namprd12.prod.outlook.com>
References: <20260610144822.65905-1-jinhuieric.huang@amd.com>
In-Reply-To: <20260610144822.65905-1-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-06-10T18:53:14.553Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=1;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8650:EE_|MW6PR12MB7069:EE_
x-ms-office365-filtering-correlation-id: 384897b0-c9a0-49fd-ca58-08dec7218706
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|6133799003|18002099003|22082099003|3023799007|56012099006|8096899003|11063799006;
x-microsoft-antispam-message-info: gpD9A4dNs6wuU1rSnjxoBVet3MrI4A+eRg1eVz0AyDosGf2U0IQzIl+Ebe9H2ZRbrlMTlS2KrNCJHCmM3c63CQb25r8iBra77OqnqAzFBEURIcsIWBpIxpyYAp4b24NbbMWmdl9z+eLBNxQ3nyIle2evHqTWrSPjc1pm2BC1fWa/G1tuYiBmqaAdu+NJOOqS9j8ZZ2rFnoG1sgeGwKte/q/6EzBZ+DZNj4Ktl8ZeTbjMvwOSleTvVr+kDiCZvLPk+ZJMkQK+HZmK4O9/41mF7M27Ke2nU0Pa0lxoxgHp6u1Om54mr6sf8kjwSNmRJ70bjH1B7oioh7hzx7vs8rTlak6/l3ph87OG58AE4Wc8XkbfCnnfGg3ZcSxHmX/iptX86U6LUGsJipIwf08pPDzNBaw+Q82sM3XMu7qyKoZnzhdN5jfgwb5KSIYybqVGomsOSKXyiVXMMHk8Ym+obPyJkdy4czvkCjwnfTEMK3FMcM3MUfL2Jm2ItLb2xQ+ybafWmr18FQ1R0UYcJSP067umFLOfG5hB7sNIlSxcFBKObq2n+xO6p7qfV2HqpMsHJV82rEnigBnBf/t+69S58GUiW3P0gbuAi+a27fGqa9IJI71+6AtlEyhS3EpIQgV3juV2ITF5zwfUVEMG0Zlge1YE6xG6ydp2hPWT9dXeZH+9pNNH3IlywBZwUTjImAdOjay7/aBURoj4wR8/ID8IGbADuSUbj3cO4N+4zWDmSVAZKk61tAs3mui/qGzAavV5rPSS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(8096899003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Zw8wyTreME7yE+DSvx3Jvy7Q2nPW5zZPnIUNARe6yglCfg/IlBUPg8NG5u?=
 =?iso-8859-1?Q?BKi/wYfqHqC5IvkWH4jq78VnUcCydJxWyX1iwAgKAKq7kxM3IUamN8HGW0?=
 =?iso-8859-1?Q?l1tyxBOifFrZagw8Wx9HymwUrNQ3CcZAE5R3wt3bEFW6Faqncbmi+68T36?=
 =?iso-8859-1?Q?nJ37p2k59ZueDAlTq4qcVQIkGfldk0vqSVZjwVtJha/518NAReEem16gpm?=
 =?iso-8859-1?Q?+bklMEcgYQ73KTOmhSvYENI6cu1sj20eXPfT+oc4cN8iSweaT/bl5srgci?=
 =?iso-8859-1?Q?nC+MAeIDIhda/sEYr7wPYQq9vtfJLzbrMD8iUF5xyAkFEL6/MNang7ZFsS?=
 =?iso-8859-1?Q?6rGkDeMMgqVnhZ4wKVpa8yvaMoH3xJi9Mf95oECjQ0KMHSUhN5lzhIJMqS?=
 =?iso-8859-1?Q?KgkfZZAnumzLBTLSeDsGjg0yHoRG4Td6nO33VJyRXM1BjKcQih4MHsWF8u?=
 =?iso-8859-1?Q?E/5VrPLcl6AHaUusJqd5yvJIIfLaMVChyKBoF35E7XYSGh4q7t/WwfZ/zg?=
 =?iso-8859-1?Q?vPSTG5KuzjeH5rsTOmAJvnA75w88WLO6szZMJ+26bdV1EDWKAC2tE45ns4?=
 =?iso-8859-1?Q?FxMYBSi8x/bujGzoMiParU7ageAQB27MYdqxX9/iv1f0CP0AIABEYkzpCy?=
 =?iso-8859-1?Q?bLoBualMtG4zB+4CQD1Zlkcdj2zAOLZ3wukyNtH6BSyjKahXFX5/R6paD2?=
 =?iso-8859-1?Q?QS8cif20kuVL/17DjM5ITnY6eHbJoTDRSvoAAV0yGiDyG4OgwjnLwS77eN?=
 =?iso-8859-1?Q?c1c1RUPtZWbaxojhgujxPl3TaaJcIKCP44vXdMpUpRY+wX4KUb/ZGcDNz+?=
 =?iso-8859-1?Q?Heq25y/hSEPbfuBVUbgEbN65rY8qijAxQuivFb46j1uV+2nKXhj+jwHQM/?=
 =?iso-8859-1?Q?//ZX12ljAMlY9NZtGr9BKUekbIuLksuian0TxtsKmaR81bmu+le9P0mM4B?=
 =?iso-8859-1?Q?oFzz5xZ5HVXiKC9l0Mj7LhBsX1mD1SRBoGd9hsDZLQ0ZQK9S3ERghG03Ve?=
 =?iso-8859-1?Q?RGEJ8Nwyoos/1grPB/84X4Tga1bGE6Jef1QexH299DwXkFRFkvnOMTngpl?=
 =?iso-8859-1?Q?deQkbeo1cfLmygNb/EIVsjNjjGt3NBZH1P34ICrEIYypMHNPEgvdohCG4G?=
 =?iso-8859-1?Q?XAH22yDq/KT99EYEbyeTlYNFAt611EkOqh2TYBRnIToKJVxdaqmg+jWlUD?=
 =?iso-8859-1?Q?zUzc0z2UXpmgG/ZgAyzYgdoYRt5+ceX/FUTGeyrA+UxX85XPWnY+eC58CC?=
 =?iso-8859-1?Q?4YsbmwZ2Igm6LP710XtMzJibPxmsZmoqAtir2R/QKn6ihTkQQnfO4TzxqC?=
 =?iso-8859-1?Q?gNHrGJryPy7Dqe7ZuksFm1LTZKcQP7MTM88eJ5z+2Aky1YDk/Sd5Lk0iH7?=
 =?iso-8859-1?Q?901G/kSSgNfdgx25+GD2pyYgb2Ft+7I+7QzY4o8wdneRnsFYhsG/9YalVk?=
 =?iso-8859-1?Q?BNqYoYzcsrc9boUyJblWGw8zvn8Jqg3ULdbNUFIXhSdjT75m9U/IQNYxCU?=
 =?iso-8859-1?Q?nL4GJB7E/u1cfu/7RgHlsywaiVqZnHz7l9IjAS9vP8oqm7J+sEafln9PRF?=
 =?iso-8859-1?Q?Nr9J5cO0CtF3d4VyoIsrkdgh8zbumr+DL5wb5yyXcJhrhY/aAGAr9/bciC?=
 =?iso-8859-1?Q?23fRyzG7v/MugN9W5KkGSaGs+He6CPosl+kdRZniHDkH4loSuWGHvwB518?=
 =?iso-8859-1?Q?+5KJ3+PprHaKI5t0Xbbm0Eb95r7zX0XEVJhpSj3sNLR3m7DieM1MNo4BCn?=
 =?iso-8859-1?Q?MAwrL5nhMAGpyueu4bxBBS4FTVFttt6c9gXGwMj6Z/OrsX?=
Content-Type: multipart/alternative;
 boundary="_000_SJ2PR12MB86505596D675BC411FAFDD5A8C1A2SJ2PR12MB8650namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384897b0-c9a0-49fd-ca58-08dec7218706
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 18:53:14.6246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B3VoT1XofWM8mS3ezm2LxFlrblbblVZUfv1We14d0o7hp/qm6u+1PWCUupH/IjziAyqDCwZxMUqpGFnYLXp4JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7069
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_SJ2PR12MB86505596D675BC411FAFDD5A8C1A2SJ2PR12MB8650namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Public

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>



________________________________
From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
Sent: Wednesday, June 10, 2026 10:48 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Huang, JinHui=
Eric <JinHuiEric.Huang@amd.com>
Subject: [PATCH v3] drm/amdkfd: add sdma queue counter for gfxv9.4.3

since gfx 9.4.3 HW is calculating accumulated activity counter
per-queue in register sdmax_rlcx_utilization_hi/lo, CPFW adds it in
sdma MQD for save/restore, KFD will read it from there. gfx 9.4.2
will still keep the way to read from memory at rptr+8.

v2: read dynamic counter directly from utilization register
v3: add CPFW supported version check (Harish)

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 67 ++++++++++++++++++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 27 ++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 14 +++-
 .../include/asic_reg/sdma/sdma_4_4_2_offset.h |  4 ++
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  3 +
 drivers/gpu/drm/amd/include/v9_structs.h      |  4 +-
 6 files changed, 111 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index f46c59118304..a97398e7fc30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -584,6 +584,70 @@ static uint32_t kgd_v9_4_3_ptl_ctrl(struct amdgpu_devi=
ce *adev,
                         ptl_state, fmt1, fmt2);
 }

+static int kgd_gfx_v9_4_3_hqd_sdma_get_counter(struct amdgpu_device *adev,
+                                       void *mqd, uint32_t num_sdma_queues=
_per_eng,
+                                       uint64_t *val)
+{
+       struct v9_sdma_mqd *m =3D get_sdma_mqd(mqd);
+       uint32_t sdma_rlc_reg_offset;
+       uint32_t sdma_rlc_rb_cntl;
+       uint32_t engine_id, queue_id;
+       uint32_t engines =3D adev->sdma.num_instances;
+       uint32_t sdma_rlcx_rb_base, sdma_rlcx_rb_base_hi;
+       bool found =3D false;
+
+       if (!m)
+               return -EINVAL;
+
+       if ((amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3)=
 ||
+            amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4)=
) &&
+           adev->gfx.mec_fw_version < 194) {
+               pr_warn_once("MEC FW doesn't support SDMA counter!\n");
+               return -ENOTSUPP;
+       }
+
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 5, 0) =
&&
+           adev->gfx.mec_fw_version < 44) {
+               pr_warn_once("MEC FW doesn't support SDMA counter!\n");
+               return -ENOTSUPP;
+       }
+
+       /* SDMA doesn't support over-subscription, there must be
+        * a HQD associated with a MQD, so found must be true in
+        * the finding loop.
+        */
+       for (engine_id =3D 0; engine_id < engines && !found; engine_id++) {
+               for (queue_id =3D 0; queue_id < num_sdma_queues_per_eng; qu=
eue_id++) {
+                       sdma_rlc_reg_offset =3D get_sdma_rlc_reg_offset(ade=
v,
+                                               engine_id, queue_id);
+                       sdma_rlcx_rb_base =3D RREG32(sdma_rlc_reg_offset +
+                                               regSDMA_RLC0_RB_BASE);
+                       sdma_rlcx_rb_base_hi =3D RREG32(sdma_rlc_reg_offset=
 +
+                                               regSDMA_RLC0_RB_BASE_HI);
+
+                       if (m->sdmax_rlcx_rb_base =3D=3D sdma_rlcx_rb_base =
&&
+                           m->sdmax_rlcx_rb_base_hi =3D=3D sdma_rlcx_rb_ba=
se_hi) {
+                               found =3D true;
+                               break;
+                       }
+               }
+       }
+
+       sdma_rlc_rb_cntl =3D RREG32(sdma_rlc_reg_offset + regSDMA_RLC0_RB_C=
NTL);
+
+       /* Read sdma activity counter from utilization register
+        * if hw queue is enabled, otherwise read from MQD.
+        */
+       if (sdma_rlc_rb_cntl & SDMA_RLC0_RB_CNTL__RB_ENABLE_MASK)
+               *val =3D (uint64_t)RREG32(sdma_rlc_reg_offset + regSDMA_RLC=
0_UTILIZATION_HI) << 32 |
+                       RREG32(sdma_rlc_reg_offset + regSDMA_RLC0_UTILIZATI=
ON_LO);
+       else
+               *val =3D (uint64_t)m->sdmax_rlcx_utilization_hi << 32 |
+                       m->sdmax_rlcx_utilization_lo;
+
+       return 0;
+}
+
 const struct kfd2kgd_calls gc_9_4_3_kfd2kgd =3D {
         .program_sh_mem_settings =3D kgd_gfx_v9_program_sh_mem_settings,
         .set_pasid_vmid_mapping =3D kgd_gfx_v9_4_3_set_pasid_vmid_mapping,
@@ -623,5 +687,6 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd =3D {
         .trigger_pc_sample_trap =3D kgd_v9_4_3_trigger_pc_sample_trap,
         .override_core_cg =3D kgd_gfx_v9_4_3_override_core_cg,
         .setup_stoch_sampling =3D kgd_v9_4_3_setup_stoch_sampling,
-       .ptl_ctrl =3D kgd_v9_4_3_ptl_ctrl
+       .ptl_ctrl =3D kgd_v9_4_3_ptl_ctrl,
+       .hqd_sdma_get_counter =3D kgd_gfx_v9_4_3_hqd_sdma_get_counter
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index b934863312d0..2b9177427058 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1067,8 +1067,17 @@ static int destroy_queue_nocpsch(struct device_queue=
_manager *dqm,
         /* Get the SDMA queue stats */
         if ((q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA) ||
             (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI)) {
-               retval =3D read_sdma_queue_counter((uint64_t __user *)q->pr=
operties.read_ptr,
-                                                       &sdma_val);
+               if ((KFD_GC_VERSION(dqm->dev) <=3D IP_VERSION(9, 4, 2)))
+                       retval =3D read_sdma_queue_counter(
+                                       (uint64_t __user *)q->properties.re=
ad_ptr,
+                                       &sdma_val);
+               else
+                       retval =3D dqm->dev->kfd2kgd->hqd_sdma_get_counter =
?
+                                dqm->dev->kfd2kgd->hqd_sdma_get_counter(
+                                       dqm->dev->adev, q->mqd,
+                                       dqm->dev->kfd->device_info.num_sdma=
_queues_per_engine,
+                                       &sdma_val) :
+                                -ENOTSUPP;
                 if (retval)
                         dev_err(dev, "Failed to read SDMA queue counter fo=
r queue: %d\n",
                                 q->properties.queue_id);
@@ -2728,8 +2737,18 @@ static int destroy_queue_cpsch(struct device_queue_m=
anager *dqm,
         /* Get the SDMA queue stats */
         if ((q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA) ||
             (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI)) {
-               retval =3D read_sdma_queue_counter((uint64_t __user *)q->pr=
operties.read_ptr,
-                                                       &sdma_val);
+               if (KFD_GC_VERSION(dqm->dev) <=3D IP_VERSION(9, 4, 2))
+                       retval =3D read_sdma_queue_counter(
+                                       (uint64_t __user *)q->properties.re=
ad_ptr,
+                                       &sdma_val);
+               else
+                       retval =3D dqm->dev->kfd2kgd->hqd_sdma_get_counter =
?
+                                dqm->dev->kfd2kgd->hqd_sdma_get_counter(
+                                       dqm->dev->adev, q->mqd,
+                                       dqm->dev->kfd->device_info.num_sdma=
_queues_per_engine,
+                                       &sdma_val) :
+                                -ENOTSUPP;
+
                 if (retval)
                         dev_err(dev, "Failed to read SDMA queue counter fo=
r queue: %d\n",
                                 q->properties.queue_id);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index 0be2fd04e6d0..d17f064ea7b9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -95,6 +95,7 @@ struct kfd_sdma_activity_handler_workarea {

 struct temp_sdma_queue_list {
         uint64_t __user *rptr;
+       void *mqd;
         uint64_t sdma_val;
         unsigned int queue_id;
         struct list_head list;
@@ -165,6 +166,7 @@ static void kfd_sdma_activity_worker(struct work_struct=
 *work)

                 INIT_LIST_HEAD(&sdma_q->list);
                 sdma_q->rptr =3D (uint64_t __user *)q->properties.read_ptr=
;
+               sdma_q->mqd =3D q->mqd;
                 sdma_q->queue_id =3D q->properties.queue_id;
                 list_add_tail(&sdma_q->list, &sdma_q_list.list);
         }
@@ -193,7 +195,17 @@ static void kfd_sdma_activity_worker(struct work_struc=
t *work)

         list_for_each_entry(sdma_q, &sdma_q_list.list, list) {
                 val =3D 0;
-               ret =3D read_sdma_queue_counter(sdma_q->rptr, &val);
+
+               if ((KFD_GC_VERSION(dqm->dev) <=3D IP_VERSION(9, 4, 2)))
+                       ret =3D read_sdma_queue_counter(sdma_q->rptr, &val)=
;
+               else
+                       ret =3D dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
+                             dqm->dev->kfd2kgd->hqd_sdma_get_counter(
+                                       dqm->dev->adev, sdma_q->mqd,
+                                       dqm->dev->kfd->device_info.num_sdma=
_queues_per_engine,
+                                       &val) :
+                             -ENOTSUPP;
+
                 if (ret) {
                         pr_debug("Failed to read SDMA queue active counter=
 for queue id: %d",
                                  sdma_q->queue_id);
diff --git a/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h =
b/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h
index ead81aeffd67..11c32e4274fa 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h
@@ -493,6 +493,10 @@
 #define regSDMA_RLC0_MIDCMD_DATA10_BASE_IDX                               =
                              0
 #define regSDMA_RLC0_MIDCMD_CNTL                                          =
                              0x017b
 #define regSDMA_RLC0_MIDCMD_CNTL_BASE_IDX                                 =
                              0
+#define regSDMA_RLC0_UTILIZATION_LO                                       =
                              0x017c
+#define regSDMA_RLC0_UTILIZATION_LO_BASE_IDX                              =
                              0
+#define regSDMA_RLC0_UTILIZATION_HI                                       =
                              0x017d
+#define regSDMA_RLC0_UTILIZATION_HI_BASE_IDX                              =
                              0
 #define regSDMA_RLC1_RB_CNTL                                              =
                              0x0188
 #define regSDMA_RLC1_RB_CNTL_BASE_IDX                                     =
                              0
 #define regSDMA_RLC1_RB_BASE                                              =
                              0x0189
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/=
drm/amd/include/kgd_kfd_interface.h
index d34c869b182f..2c91242caadc 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -361,6 +361,9 @@ struct kfd2kgd_calls {
                              uint32_t *ptl_state,
                              enum amdgpu_ptl_fmt *fmt1,
                              enum amdgpu_ptl_fmt *fmt2);
+       int (*hqd_sdma_get_counter)(struct amdgpu_device *adev,
+                                   void *mqd, uint32_t num_sdma_queues_per=
_eng,
+                                   uint64_t *val);
 };

 #endif  /* KGD_KFD_INTERFACE_H_INCLUDED */
diff --git a/drivers/gpu/drm/amd/include/v9_structs.h b/drivers/gpu/drm/amd=
/include/v9_structs.h
index a2f81b9c38af..e0d387f08576 100644
--- a/drivers/gpu/drm/amd/include/v9_structs.h
+++ b/drivers/gpu/drm/amd/include/v9_structs.h
@@ -69,8 +69,8 @@ struct v9_sdma_mqd {
         uint32_t sdmax_rlcx_midcmd_cntl;
         uint32_t reserved_42;
         uint32_t reserved_43;
-       uint32_t reserved_44;
-       uint32_t reserved_45;
+       uint32_t sdmax_rlcx_utilization_lo;
+       uint32_t sdmax_rlcx_utilization_hi;
         uint32_t reserved_46;
         uint32_t reserved_47;
         uint32_t reserved_48;
--
2.34.1


--_000_SJ2PR12MB86505596D675BC411FAFDD5A8C1A2SJ2PR12MB8650namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
Public</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Harish Kasiviswanathan &lt;Harish.Kasiviswanathan@amd.com&gt;<=
/div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Huang, JinHuiEric &lt;JinHuiEric.Huang@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Wednesday, June 10, 2026 10:48 AM<br>
<b>To:</b>&nbsp;amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;<br>
<b>Cc:</b>&nbsp;Kasiviswanathan, Harish &lt;Harish.Kasiviswanathan@amd.com&=
gt;; Huang, JinHuiEric &lt;JinHuiEric.Huang@amd.com&gt;<br>
<b>Subject:</b>&nbsp;[PATCH v3] drm/amdkfd: add sdma queue counter for gfxv=
9.4.3 </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">since gfx 9.4.3 HW is calculating accumulat=
ed activity counter<br>
per-queue in register sdmax_rlcx_utilization_hi/lo, CPFW adds it in<br>
sdma MQD for save/restore, KFD will read it from there. gfx 9.4.2<br>
will still keep the way to read from memory at rptr+8.<br>
<br>
v2: read dynamic counter directly from utilization register<br>
v3: add CPFW supported version check (Harish)<br>
<br>
Signed-off-by: Eric Huang &lt;jinhuieric.huang@amd.com&gt;<br>
---<br>
&nbsp;.../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c&nbsp;&nbsp; | 67 ++++++++=
++++++++++-<br>
&nbsp;.../drm/amd/amdkfd/kfd_device_queue_manager.c | 27 ++++++--<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; | 14 +++-<br>
&nbsp;.../include/asic_reg/sdma/sdma_4_4_2_offset.h |&nbsp; 4 ++<br>
&nbsp;.../gpu/drm/amd/include/kgd_kfd_interface.h&nbsp;&nbsp; |&nbsp; 3 +<b=
r>
&nbsp;drivers/gpu/drm/amd/include/v9_structs.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 4 +-<br>
&nbsp;6 files changed, 111 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c<br>
index f46c59118304..a97398e7fc30 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c<br>
@@ -584,6 +584,70 @@ static uint32_t kgd_v9_4_3_ptl_ctrl(struct amdgpu_devi=
ce *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptl_s=
tate, fmt1, fmt2);<br>
&nbsp;}<br>
&nbsp;<br>
+static int kgd_gfx_v9_4_3_hqd_sdma_get_counter(struct amdgpu_device *adev,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; void *mqd, uint32_t num_sdma_queues_per_eng,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint64_t *val)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v9_sdma_mqd *m =3D get_sdma_mq=
d(mqd);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_rlc_reg_offset;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_rlc_rb_cntl;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t engine_id, queue_id;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t engines =3D adev-&gt;sdma.nu=
m_instances;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_rlcx_rb_base, sdma_rlcx=
_rb_base_hi;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool found =3D false;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!m)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_ip_version(adev, GC_HWIP,=
 0) =3D=3D IP_VERSION(9, 4, 3) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.=
mec_fw_version &lt; 194) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_warn_once(&quot;MEC FW doesn't support SDMA counter!\n&quot;)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOTSUPP;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) =3D=3D IP_VERSION(9, 5, 0) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.=
mec_fw_version &lt; 44) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_warn_once(&quot;MEC FW doesn't support SDMA counter!\n&quot;)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOTSUPP;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* SDMA doesn't support over-subscrip=
tion, there must be<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * a HQD associated with a MQD, =
so found must be true in<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the finding loop.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (engine_id =3D 0; engine_id &lt; =
engines &amp;&amp; !found; engine_id++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (queue_id =3D 0; queue_id &lt; num_sdma_queues_per_eng; queu=
e_id++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_rlc_reg_off=
set =3D get_sdma_rlc_reg_offset(adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine_id, queue_id);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_rlcx_rb_bas=
e =3D RREG32(sdma_rlc_reg_offset +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regSDMA_RLC0_RB_BASE);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_rlcx_rb_bas=
e_hi =3D RREG32(sdma_rlc_reg_offset +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regSDMA_RLC0_RB_BASE_H=
I);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (m-&gt;sdmax_=
rlcx_rb_base =3D=3D sdma_rlcx_rb_base &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; m-&gt;sdmax_rlcx_rb_base_hi =3D=3D sdma_rlcx_rb_base_hi) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; found =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_rlc_rb_cntl =3D RREG32(sdma_rlc_=
reg_offset + regSDMA_RLC0_RB_CNTL);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Read sdma activity counter from ut=
ilization register<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * if hw queue is enabled, other=
wise read from MQD.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (sdma_rlc_rb_cntl &amp; SDMA_RLC0_=
RB_CNTL__RB_ENABLE_MASK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *val =3D (uint64_t)RREG32(sdma_rlc_reg_offset + regSDMA_RLC0_UTI=
LIZATION_HI) &lt;&lt; 32 |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RREG32(sdma_rlc_=
reg_offset + regSDMA_RLC0_UTILIZATION_LO);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *val =3D (uint64_t)m-&gt;sdmax_rlcx_utilization_hi &lt;&lt; 32 |=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;sdmax_rlcx=
_utilization_lo;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;const struct kfd2kgd_calls gc_9_4_3_kfd2kgd =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .program_sh_mem_settings =
=3D kgd_gfx_v9_program_sh_mem_settings,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_pasid_vmid_mapping =
=3D kgd_gfx_v9_4_3_set_pasid_vmid_mapping,<br>
@@ -623,5 +687,6 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .trigger_pc_sample_trap =
=3D kgd_v9_4_3_trigger_pc_sample_trap,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .override_core_cg =3D kgd_=
gfx_v9_4_3_override_core_cg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .setup_stoch_sampling =3D =
kgd_v9_4_3_setup_stoch_sampling,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ptl_ctrl =3D kgd_v9_4_3_ptl_ctrl<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ptl_ctrl =3D kgd_v9_4_3_ptl_ctrl,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hqd_sdma_get_counter =3D kgd_gfx_v9_=
4_3_hqd_sdma_get_counter<br>
&nbsp;};<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
index b934863312d0..2b9177427058 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
@@ -1067,8 +1067,17 @@ static int destroy_queue_nocpsch(struct device_queue=
_manager *dqm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Get the SDMA queue stat=
s */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((q-&gt;properties.type=
 =3D=3D KFD_QUEUE_TYPE_SDMA) ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (q=
-&gt;properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; retval =3D read_sdma_queue_counter((uint64_t __user *)q-&gt;prop=
erties.read_ptr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sdma_val);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((KFD_GC_VERSION(dqm-&gt;dev) &lt;=3D IP_VERSION(9, 4, 2)))<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D read_=
sdma_queue_counter(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (uint64_t __user *)q-&gt;properties.read_ptr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;sdma_val);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D dqm-&=
gt;dev-&gt;kfd2kgd-&gt;hqd_sdma_get_counter ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;dev-&gt;kfd2kgd-&gt;hqd_sdma_=
get_counter(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dqm-&gt;dev-&gt;adev, q-&gt;mqd,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dqm-&gt;dev-&gt;kfd-&gt;device_info.num_sdma_queues_per_engine,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;sdma_val) :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -ENOTSUPP;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (retval)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_e=
rr(dev, &quot;Failed to read SDMA queue counter for queue: %d\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.queue_id);<br>
@@ -2728,8 +2737,18 @@ static int destroy_queue_cpsch(struct device_queue_m=
anager *dqm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Get the SDMA queue stat=
s */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((q-&gt;properties.type=
 =3D=3D KFD_QUEUE_TYPE_SDMA) ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (q=
-&gt;properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; retval =3D read_sdma_queue_counter((uint64_t __user *)q-&gt;prop=
erties.read_ptr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sdma_val);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (KFD_GC_VERSION(dqm-&gt;dev) &lt;=3D IP_VERSION(9, 4, 2))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D read_=
sdma_queue_counter(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (uint64_t __user *)q-&gt;properties.read_ptr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;sdma_val);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D dqm-&=
gt;dev-&gt;kfd2kgd-&gt;hqd_sdma_get_counter ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;dev-&gt;kfd2kgd-&gt;hqd_sdma_=
get_counter(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dqm-&gt;dev-&gt;adev, q-&gt;mqd,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dqm-&gt;dev-&gt;kfd-&gt;device_info.num_sdma_queues_per_engine,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;sdma_val) :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -ENOTSUPP;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (retval)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_e=
rr(dev, &quot;Failed to read SDMA queue counter for queue: %d\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.queue_id);<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c<br>
index 0be2fd04e6d0..d17f064ea7b9 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
@@ -95,6 +95,7 @@ struct kfd_sdma_activity_handler_workarea {<br>
&nbsp;<br>
&nbsp;struct temp_sdma_queue_list {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t __user *rptr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *mqd;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t sdma_val;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int queue_id;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head list;<br>
@@ -165,6 +166,7 @@ static void kfd_sdma_activity_worker(struct work_struct=
 *work)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;sdma_q-&gt;list);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sdma_q-&gt;rptr =3D (uint64_t __user *)q-&gt;properti=
es.read_ptr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sdma_q-&gt;mqd =3D q-&gt;mqd;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sdma_q-&gt;queue_id =3D q-&gt;properties.queue_id;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; list_add_tail(&amp;sdma_q-&gt;list, &amp;sdma_q_list.=
list);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -193,7 +195,17 @@ static void kfd_sdma_activity_worker(struct work_struc=
t *work)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(sdma_q=
, &amp;sdma_q_list.list, list) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; val =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D read_sdma_queue_counter(sdma_q-&gt;rptr, &amp;val);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((KFD_GC_VERSION(dqm-&gt;dev) &lt;=3D IP_VERSION(9, 4, 2)))<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D read_sdm=
a_queue_counter(sdma_q-&gt;rptr, &amp;val);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D dqm-&gt;=
dev-&gt;kfd2kgd-&gt;hqd_sdma_get_counter ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dqm-&gt;dev-&gt;kfd2kgd-&gt;hqd_sdma_get_counter(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dqm-&gt;dev-&gt;adev, sdma_q-&gt;mqd,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dqm-&gt;dev-&gt;kfd-&gt;device_info.num_sdma_queues_per_engine,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;val) :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; -ENOTSUPP;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_de=
bug(&quot;Failed to read SDMA queue active counter for queue id: %d&quot;,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_q-&gt;queue_id);<br>
diff --git a/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h =
b/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h<br>
index ead81aeffd67..11c32e4274fa 100644<br>
--- a/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h<br>
+++ b/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h<br>
@@ -493,6 +493,10 @@<br>
&nbsp;#define regSDMA_RLC0_MIDCMD_DATA10_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
&nbsp;#define regSDMA_RLC0_MIDCMD_CNTL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0x017b<br>
&nbsp;#define regSDMA_RLC0_MIDCMD_CNTL_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
+#define regSDMA_RLC0_UTILIZATION_LO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x017=
c<br>
+#define regSDMA_RLC0_UTILIZATION_LO_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
+#define regSDMA_RLC0_UTILIZATION_HI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x017=
d<br>
+#define regSDMA_RLC0_UTILIZATION_HI_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
&nbsp;#define regSDMA_RLC1_RB_CNTL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0188<br>
&nbsp;#define regSDMA_RLC1_RB_CNTL_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
&nbsp;#define regSDMA_RLC1_RB_BASE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0189<br>
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/=
drm/amd/include/kgd_kfd_interface.h<br>
index d34c869b182f..2c91242caadc 100644<br>
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h<br>
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h<br>
@@ -361,6 +361,9 @@ struct kfd2kgd_calls {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *ptl_state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_ptl_fmt *fmt1,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_ptl_fmt *fmt2);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*hqd_sdma_get_counter)(struct am=
dgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *mqd, uint32_t=
 num_sdma_queues_per_eng,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *val);<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;#endif&nbsp; /* KGD_KFD_INTERFACE_H_INCLUDED */<br>
diff --git a/drivers/gpu/drm/amd/include/v9_structs.h b/drivers/gpu/drm/amd=
/include/v9_structs.h<br>
index a2f81b9c38af..e0d387f08576 100644<br>
--- a/drivers/gpu/drm/amd/include/v9_structs.h<br>
+++ b/drivers/gpu/drm/amd/include/v9_structs.h<br>
@@ -69,8 +69,8 @@ struct v9_sdma_mqd {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdmax_rlcx_midcmd=
_cntl;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserved_42;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserved_43;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserved_44;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserved_45;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdmax_rlcx_utilization_lo;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdmax_rlcx_utilization_hi;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserved_46;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserved_47;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserved_48;<br>
--<br>
2.34.1<br>
<br>
</div>
</body>
</html>

--_000_SJ2PR12MB86505596D675BC411FAFDD5A8C1A2SJ2PR12MB8650namp_--
