Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BB2C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 05:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53E4164F06
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 05:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E4164F06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E22296E086;
	Thu, 18 Mar 2021 05:19:13 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750073.outbound.protection.outlook.com [40.107.75.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB5B56E086
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 05:19:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVyqgJBsj4xURPB9nPaph18iFbYbz5T2mmNPDmpab4VOJgfDiuxWNpp9NSFyYNN4Gcdb3jJ4vzny4JyBAgooShajF66NHW/lsBsz6RUoZj3jjLNmBjDxaZsxlOao7H6cnJBhHIU3nI97XSqClPJZJ+Q+N3eR6+arPZMHaSteNThYrIYBiS/y2xvLfXUxNbX6KdTOtIZOWkKWzSCmPGmgrjmYHuTxTVdze34qMClvZt8uASmzC60rVNXes1ZrHQURBEbR4bS8FTx1D60rhWxmOAw7oO+g+65m7EtZJVxmWw9G9F1vFahQ5ztsCBtRSqLpeodjtkjFkr1B0699DDcXxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrsEdwCdbo3PJ0y2qKKbJLii2SqaHFT9jr3Vk08ezQ0=;
 b=T6n8bkWbLgDAVFDFzMYfAULZhMFDVF5iPCiiPv/2nN01qfvHE8mCTKR1QukZsRyvIqfcl7lfLuWtOS13aD2SXaqpzt4O6QxXH+uvmjQtfXGcpeb+j+Tgux/Y3Iaf5/sA1aN/e2//HE7SS/HNjwfsTrqbr0CGu6lZWknLfbB9LrE1Sp8Tfk60mYDSpOXANtuwyGxFnSphhtUOG8PSd+CqIQTo6KFPfegOp8ghVM3VY5OVTyZK6kk6DNaqHnrbvk8Vo6sG0dCnKpbG4Rv5VfibebIlalfJztgmhDx4QPRhrgrkyNqCtp8ci+sZwFodyf9WCFdGC0TcuqSooo5yRMepfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrsEdwCdbo3PJ0y2qKKbJLii2SqaHFT9jr3Vk08ezQ0=;
 b=NHIS2Xx71PE/bsTxpbpEStam5NWlUfTE5q8ij6I0nMc2RKm0suddPsxgaZ3tNb8VxnkCf+CLI4aY4fBJgYx70WTg+4ABsY+YtYZy3lVRtJEdBXVArZbVcg0MngNiTjIujz0DcncGyOtwe/akZGftw/dLnQ+49kazF4WfC3M8vNw=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB3901.namprd12.prod.outlook.com (2603:10b6:208:16c::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Thu, 18 Mar
 2021 05:19:09 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408%5]) with mapi id 15.20.3933.033; Thu, 18 Mar 2021
 05:19:09 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: bug fix for baco reset
Thread-Topic: [PATCH] drm/amd/pm: bug fix for baco reset
Thread-Index: AQHXG6wd6G/JGFC6802fb/ctfHKJHqqJKu7A
Date: Thu, 18 Mar 2021 05:19:09 +0000
Message-ID: <MN2PR12MB4549BCB67A967DA61730B28A97699@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210318040634.2848-1-kenneth.feng@amd.com>
In-Reply-To: <20210318040634.2848-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-18T05:19:07Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=99a0c527-550b-4871-ad81-f42e56a89349;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.214.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b076190-b5fb-4be6-8f09-08d8e9cd5bde
x-ms-traffictypediagnostic: MN2PR12MB3901:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB390162D16756FC112D6DCD0097699@MN2PR12MB3901.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TGBAerM+bcnrAGZBPyczE8zcwxHNRCFf57QCwHM1kgiGIrv7Cx9VHtlxUJr/7ancNGEMYzrCdXQygogqlL3ZKPCQEXdynLSFoDYw6lepqVoGx8XvhzzphJGXeoyly4sI0oMeoyvePRsXYM6Q7inyC6FvA6W4Wv8W56bGAY1PJVkoJ7LxkLBzJPJUpaTIqda00enqjUONHQi+kKcox8Z7dP7VhRkz+4uyA8nQSsxj02/X7C/CtYZdipTVwQxyluquS9+8hRkOfzhpb7dnhs5uqBxP2A8j6fonRjLYvc3IishnBynPfThHUD+qhuSDmFgIQXPh44lofAb/c/e66vqmHyXfoygRpqfQwzBxh+fPrP/GKaVCXaWPXyBBxW0YAHIEEwSIf/LhJRQRF1paoRKt/gefcYDppfrpwAIUOB+SbHSs9IJN4Xawt15P9sVP1FYRSzRoMgMudgz7zwKuyOF/ce+AUMFpTrwH0c71bnSJJNm1MPiFspZM0JQ1Mc5uqcVD+WFwJd0zcHRUlfAGep4I5yrZCN1loaa+FIIeIo+FYpbsuMhomS9zGIG/lzWkTUJVAI+nyazHer7CFSKyfx0dZTTyxy++LAFhx9r5/dGBrXJe95t0ztrsYs0GkovsYDLoBl3ELpJ4eHwsXwtp9bjuhaWD6CDgu9egKmjNwK42Gcw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(45080400002)(2906002)(83380400001)(26005)(52536014)(9686003)(186003)(86362001)(478600001)(8676002)(55236004)(5660300002)(71200400001)(55016002)(33656002)(53546011)(4326008)(316002)(8936002)(66446008)(966005)(66556008)(76116006)(64756008)(66476007)(66946007)(110136005)(6506007)(38100700001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3H7zQh7IBac+tbsJy7b5HmI4mKrfN2i3u4IyyLjeEORBrwYieHGHW/uDwebL?=
 =?us-ascii?Q?fMsnfFXuCsZixJASzmO/5EGCzUQZWYOg/+rCiq9Vs0+anU+PmRlvFiALAQPd?=
 =?us-ascii?Q?x+qqbX23Om+sSuLzJzd9wIc2QNxz/oLQzVPv9oRULiQiA8hgi6B19ZApSrcs?=
 =?us-ascii?Q?FS9dEIOALplLeEs2RAmv4hZh60o+qAh/9hYdU3Mfn4vvH2/NgwntS5lVc1WV?=
 =?us-ascii?Q?b8IuLukdQtQ/AcWyIWWAp27Jld3sS4ECT5Bb0vGnLbN4MeeRTLbnLmE+7mgZ?=
 =?us-ascii?Q?BXgezsTcb3cM9prvKjVdpmcaoTuHEDrgKf7EiAOmnkLgPagJCFFs7AlpOvKe?=
 =?us-ascii?Q?yO/Zzhff2kPvz3E6ylnfSyRm8MhMdlmTV/f4JZ0iLOQsqB468tw/xSgCmmHx?=
 =?us-ascii?Q?r//bOhD8XSQetwfHKtSkuUipKZs+3/njibpMn9VKVKLaUnYJ6bEas6T2t6i+?=
 =?us-ascii?Q?qxsZHwjqdb+jDzYQ6O4AjLUKKhVDa65sgT6JCwRPErBUiRwRqmlS2hdlxVbB?=
 =?us-ascii?Q?+q8CwX3RXgS1xYRq8rV3TbvZ9I2A4qVukyggF1GEyO1Kzfb0KJZMijh+jKA3?=
 =?us-ascii?Q?Dv3MFT2LMGPvZ+Fvw9RF2ISSWtcw0/AmuGqVggBHuxaUpzHNufkqYFvJMRrk?=
 =?us-ascii?Q?dsqZMt34sDtz4XdmIS1ogDWC2CYYs7t2g3rfrfzY7FiffU7bLWV0oBht8rXK?=
 =?us-ascii?Q?GpqB5l6sacnb5lzKwof9FPYyM7Bv0ecCSrn63lX8BKrLSpI3jHFr0tfzCTiZ?=
 =?us-ascii?Q?hgg/NDDQm3UnkAnseL4aAgI6hRejb/3nFegAqz13rxbyKaJA4XwO9Ex8Tsq3?=
 =?us-ascii?Q?kQYqiQdTB58O0UYEaEO1gYIwG+4CinHufAWzB8d83A8tCIqZHnQwHB9LUxvK?=
 =?us-ascii?Q?Q/dByEAA0+6n/tl/++XeG/ZhCL+EPEHm1Bu5HuTxAPXP0dhSFl/c8nVWUPUO?=
 =?us-ascii?Q?IgdT14S3i7v5r+WA22lHoz5bUg+vviebC/3X5RVGpuRxTh3O7AQhBhnboIZu?=
 =?us-ascii?Q?CI1W2dl4zo5IBZVE4OCqCkGiGcG4Mk2Nfb5ogxaXvVg39DLeSICTnZ6hUL3P?=
 =?us-ascii?Q?hGiNtkegkodXy8FRA63kIj5vRY8jY7ZZXG7TeaMR11jbkbeh3c3Jl/OqGr7e?=
 =?us-ascii?Q?0KmYBS7Ch4TuS7RZddkfHOkMyUgjIzMt6jkgQURl2MbMcuz3umYbVuBHLdOF?=
 =?us-ascii?Q?7M/0hGwimIZlhHSQYprYVwLZQ7lHPC0h3QvveUMzBAtNW528vz+RtfuU2GaW?=
 =?us-ascii?Q?btuLd0AN84y6rdz9fgNhu/uJ0Wlja8Vn75NeRRouKt5LlPEnIQVFltKt3LNC?=
 =?us-ascii?Q?HqHMSRobffqKu6w6J0xtc47b?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b076190-b5fb-4be6-8f09-08d8e9cd5bde
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 05:19:09.0331 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j3MlLd4brUjP0CkrvjmBi9G19OSxW9/BjKai1VwFBe1umn0AlpmxOrTT+TJau5bk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3901
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth Feng
Sent: Thursday, March 18, 2021 9:37 AM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: bug fix for baco reset

On vega20, rocm-smi gets the wrong gfx voltage after baco reset.
This can be reproduced as below.
:~$ rocm-smi --showvoltage
GPU[0] : Voltage (mV): 737
:~$ rocm-smi -d0 --gpureset
GPU[0] : GPU reset was successful
:~$ rocm-smi --showvoltage
GPU[0] : Voltage (mV): 1550

Root cause: telemetry is disabled in the asic_init after baco exit.
This fix targets to re-enable telemetry then all the power and voltage info can be fetched correctly, mp1 firmware also depends on this setting for dpm arbitration.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/vega20_baco.c    | 17 +++++++++++++++++
 .../drm/amd/pm/powerplay/hwmgr/vega20_baco.h    |  2 +-
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c   |  1 +
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
index 2a28c9df15a0..bb58097a925c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
@@ -28,9 +28,16 @@
 #include "vega20_ppsmc.h"
 #include "vega20_baco.h"
 #include "vega20_smumgr.h"
+#include "smuio/smuio_9_0_offset.h"
+#include "smuio/smuio_9_0_sh_mask.h"
 
 #include "amdgpu_ras.h"
 
+#define mmSMUSVI0_TFN 0x2
+#define SMUSVI0_TFN___PLANE0_MASK 0x1
+#define SMUSVI0_TFN___PLANE1_MASK 0x2
+#define mmSMUSVI0_TFN_BASE_IDX 0
+
 static const struct soc15_baco_cmd_entry clean_baco_tbl[] =  {
 	{CMD_WRITE, SOC15_REG_ENTRY(NBIF, 0, mmBIOS_SCRATCH_6), 0, 0, 0, 0}, @@ -120,3 +127,13 @@ int vega20_baco_apply_vdci_flush_workaround(struct pp_hwmgr *hwmgr)
 
 	return smum_send_msg_to_smc(hwmgr, PPSMC_MSG_BacoWorkAroundFlushVDCI, NULL);  }
+
+void vega20_baco_override_telemetry_parameters(struct pp_hwmgr *hwmgr) 
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
+	uint32_t data = RREG32_SOC15(SMUIO, 0, mmSMUSVI0_TFN);
+

< > This most likely needs a !VF check. Register may not be accessible for VF cases.

Thanks,
Lijo

+	data &= (~SMUSVI0_TFN___PLANE0_MASK);
+	data |= SMUSVI0_TFN___PLANE1_MASK;
+	WREG32_SOC15(SMUIO, 0, mmSMUSVI0_TFN, data); }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
index f06471e712dc..9ca39569ba0e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
@@ -29,5 +29,5 @@ extern int vega20_baco_get_capability(struct pp_hwmgr *hwmgr, bool *cap);  extern int vega20_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);  extern int vega20_baco_set_state(struct pp_hwmgr *hwmgr, enum BACO_STATE state);  extern int vega20_baco_apply_vdci_flush_workaround(struct pp_hwmgr *hwmgr);
-
+extern void vega20_baco_override_telemetry_parameters(struct pp_hwmgr 
+*hwmgr);
 #endif
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 213c9c6b4462..12830a8dd923 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -503,6 +503,7 @@ static int vega20_setup_asic_task(struct pp_hwmgr *hwmgr)
 		ret = vega20_baco_apply_vdci_flush_workaround(hwmgr);
 		if (ret)
 			pr_err("Failed to apply vega20 baco workaround!\n");
+		vega20_baco_override_telemetry_parameters(hwmgr);
 	}
 
 	return ret;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C7fee5a2166be4f31286408d8e9c33f55%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637516372082911361%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=yzMgTiFkTVDmMQ%2FxNH4Zztx3NQRXPSCKw7pflm3VUZY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
