Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7BBC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 13:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7064864E21
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 13:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7064864E21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD9C06EABB;
	Wed, 24 Feb 2021 13:57:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A43316EABB
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 13:57:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XH5pxwze70Tysayzt43YzXQP3O5RVXu3lOF9jWeEscLKS+yuHkWCQCjYH0Ax3BQ3fXWa5BvsSZbqjd54+ZjN0e+alSHPiMdIgWA7lGgjOomTWY6dglBJCaX8GSrVTqE9Zq1FnU9Zk0pkNWbLaSRrAi9NqSN18Tbd5WTkL8AlKTs2uygyBggAC7PCoBwE8L2GC42mFGHDivcUc1kmsf9uPs1qYP+GVcc+r4Hqc6c+Pxu2UfZPTE2x+FErjohMvII2X7qzkkM0ZcudEd84P3bkYaAOCFXnjsJHUifwqFYF296z2hTF8bTiq5sgiOYkZV6Xc+J8UvFCzWXW4W5MfSf6zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FR0rjLB6IGuuOJIGOB+glfkXkNPHfJOp14DFuSUjHOc=;
 b=ZnIlP2GvW7lrDQEaKS5VT5Ax/1mtylrg6+5KPo1N59SgS5xxa3CDKDqbmngi4RxGzbjqH4od7ECqr5lbzNrT20/V8ooi9DUYf1rXAfd9VexQLMvWYesNaejuBclZMsgeRIoCBqtfYeCDxDfoX8+Uc0Ku1DXykpoeqDqnmTylcsesX0RFRFosYTBHYvDbDKfPqDAW0wDGZV5qoo3ru0gLmxytw+fcmXjSKs1+7L2GafWHiJPvQ5lvfS0xku5ls0VN3tj/CYfJ7HzUTa6kBy8BdCIQuXzvlgq3CJ45a5oPnRyIT0nvLPcl7GNhovR9ttWZhsM04HiNKbGJo3YipFipCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FR0rjLB6IGuuOJIGOB+glfkXkNPHfJOp14DFuSUjHOc=;
 b=TIyiwcOrDBvsbb4uRDAanm5ClWB02Vrr8wpqyaebOHywSlcMqzv3jAD7VOfJI0lJVRw+dOQI0Kz8JJNHDsPKPN/tD4NMsgMQWr1DRokWWmCM60OyoB1pSp7bSP1VbBYDp0B6ntRWxINjXKhFHsmGCqI6MjpxNA3YSzgv5QG0p7c=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by BL0PR12MB2385.namprd12.prod.outlook.com (2603:10b6:207:4d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Wed, 24 Feb
 2021 13:57:48 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a%4]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 13:57:48 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdgpu: Reset the devices in the XGMI hive duirng
 probe
Thread-Topic: [PATCH 4/4] drm/amdgpu: Reset the devices in the XGMI hive
 duirng probe
Thread-Index: AQHXClQJxWa6xgiGjkmpo7AW9xC3u6pnUhpA
Date: Wed, 24 Feb 2021 13:57:47 +0000
Message-ID: <MN2PR12MB4549C9C9BA565812EA6BB03B979F9@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210224022307.23521-1-shaoyun.liu@amd.com>
In-Reply-To: <20210224022307.23521-1-shaoyun.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-02-24T13:57:43Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=6606fa3f-07f3-4f56-9b6c-66fe2e1e0596;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.196.52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 56feb3fd-1c29-4e92-f012-08d8d8cc2b57
x-ms-traffictypediagnostic: BL0PR12MB2385:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2385313C0226491E74410BE5979F9@BL0PR12MB2385.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KoUuLQ6y2tWMwhiGvSMoaDB3yUOfFmxFKAP+Of/c6OqtRe9xQVWn9Z6Kggxt0UeJ938/hoLUOs07oyheamkz4QYpfAo5OGaxCc1PgEJKGjnEv4iM7AR2ZmMxkegA58byRzJb1lEXCQd7ersWKjLZ4qf6/GsWdej/V04g3dAjF8LZwWvoqYsGO4A9w8Zi+/ntDWkRMgJcmJdnupL0ePrl4LZ5zxBgSKZx8HVNOH5ilKNptyufa9Es5P3tmTTwyRuY7tlzmnRWW+tYIbmrYwr6XSx3Zoyu3Y/AEz9x96VRf5I9sGwNSg74PA0WCc6t3R+gD6x09ZL4h1a+4XsmnUA2989s+WYMc/c6FhrFcB9tUNL6dJQJ/Sb3j9UEufOhnYrJmJ980zwotCI6dFSQ+VCqiQaOWBbvJPhy8kcE/dl8DaentYuVwHkPaFV08pPRH1CJfaT/OFTgheB+p8ZoyJWJO8vOQWmcKm4AgMjgTdqG09mzEAkdzx4/FG8UuoxBUh/yK0q1mOQ01M1s76qvqycZab/2BNFluRsJxWNZzfih/BNJcchbNvCmlElxygYZ4AJUi1jEhqFs7JeNswFHd/7hmzlzr8bd2vUA4gfig9pc3Po=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(186003)(26005)(2906002)(316002)(6506007)(8936002)(478600001)(8676002)(55016002)(83380400001)(86362001)(45080400002)(966005)(53546011)(33656002)(66476007)(110136005)(66946007)(76116006)(55236004)(71200400001)(9686003)(66556008)(66446008)(64756008)(5660300002)(52536014)(7696005)(4326008)(30864003)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/tGt8svccNHtw0EgB1ZKnH2drH51AR5o6f2ZFg11uj6+CRXY+wiqhtA0fWkR?=
 =?us-ascii?Q?uBn5Upw05fQZZzWNKSf0WtQD1uiyn3GoAU4uVjY1RQmfBFB+mIiPW8YUpIRz?=
 =?us-ascii?Q?nFFLPuX/nfR8mAKJBi4rsLGPcbIP/Oh+cFu3yuIzczRnNn60GEq5I9bGUGry?=
 =?us-ascii?Q?Q+HMkotcev3l3cGMvU/i1cY9V3gpzgYuM/aKT4miWYrRzRfNHMLSM3M11hRP?=
 =?us-ascii?Q?/kn0a0+4TRNCpgpwNIdRUBJcCgfwQ74ZL/u5ZS3OzeZVXWR6TdXGHFXHvqCm?=
 =?us-ascii?Q?IdteXJuPWkq4rpF7FoMc+PJV9iFVXdCvwM+eQWrjknHC16EkpeEDdmIQRRxJ?=
 =?us-ascii?Q?BuSnjfbiF+nePIPOK4c6FEelzZpIttXf/CX1vBUNjuw8RwvoaI3yaH3zqcMM?=
 =?us-ascii?Q?AR8F+m444qtc3WXUxq8kEVYEaZTs95BaW6YYpgBGKiFDJVd2bpRZGjjbbs87?=
 =?us-ascii?Q?mMQRDbSdhy830BJegIqEzV8kiR4+aa7hf5RGqgCXJC1t4qP/sjxm8eAOPWJJ?=
 =?us-ascii?Q?ppGJ4y2FFnzKH38DEGXnyMA/IX9IMxmjYRXwmebXfB/hVZkGtRIMVYBbSq/L?=
 =?us-ascii?Q?9syt2Uzuv+L+fL4UaJuLeO4Ijvp2tBS0ctSU1XS7VfcrhpIaNU3DKQHvtteK?=
 =?us-ascii?Q?kN0czIKFNSg1c6FeYfUInN/9nHgJ6iAmasyqXjL/sRCUe6iGAft2g+VT0BHj?=
 =?us-ascii?Q?XTEE8HK/CR9/YwMHNzPXPCgj33GXLYX7iebfcd0mjdtZMfEjsvOJca+C/9Ja?=
 =?us-ascii?Q?HHeTfu63A9zMdBszWGXfQgZF172xYUWCuhUYKGoqOMVioc+UeLydmZ6bLQ5k?=
 =?us-ascii?Q?WKlwgB5nMGJwRRk49lUlAdGmiUkpFL+fyrkRFqYrDW5+JWyoSI8HmQ5uFDOy?=
 =?us-ascii?Q?um5Uhdg15Hq8PsVsSFD8FSq+sDy9m4QxuVmh8JdowZnRWn2avcc5V9txu9Nu?=
 =?us-ascii?Q?s1m6cgCorrGZuLAlBtgxC9893GTRQ80p7DFZeXhKvesGtZZHl9bx1kv4t+CM?=
 =?us-ascii?Q?ptqdGC7nyeRPgtvkvhv1+HbeatE2pyJnemDGahm1MUWABo0kHL/oi31nU7/s?=
 =?us-ascii?Q?vc1NpF3Zhz4PvdA++YpNq5adjs3AIXz22VXdxIW0OUzV5isHzbUXsasilXn5?=
 =?us-ascii?Q?oUyUc2oSaB04RPfIRgSCzt80AzQmr2Q7hlB5LAQXfX0YUUm983D0p6IHXDGq?=
 =?us-ascii?Q?YPBSPOJkWDFOORh7VvirSnge+WMTYixsJR5HUAjbljpUALdeR/eEhEZeb/5x?=
 =?us-ascii?Q?1H/FifSUlfXTFF4oHQvKaLh/iSdLRsysjHiGJu2FrYP9ekXCTEfxs63gZRTk?=
 =?us-ascii?Q?vWxl3xMwJI/yMHkE+7d1jbJg?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56feb3fd-1c29-4e92-f012-08d8d8cc2b57
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 13:57:48.0227 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cK+gtbsShj+TWfoRglTBTyvM/yWHJ/jIeGZeU3210mdLnMagm8OcS9Ry4q8RMcCP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2385
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
Cc: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi Shaoyun,

If this is SBR happening during device init, how different is the handling from the normal passthrough case without XGMI. Shouldn't the minimal init be done and reset performed in such a case also? Wondering why this is specific to "xgmi.pending_reset". In case of XGMI, wouldn't this cause issues if other devices in hive are reset without HV knowledge?

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of shaoyunl
Sent: Wednesday, February 24, 2021 7:53 AM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Reset the devices in the XGMI hive duirng probe

In passthrough configuration, hypervisior will trigger the SBR(Secondary bus reset) to the devices without sync to each other. This could cause device hang since for XGMI configuration, all the devices within the hive need to be reset at a limit time slot. This serial of patches try to solve this issue by co-operate with new SMU which will only do minimum house keeping to response the SBR request but don't do the real reset job and leave it to driver. Driver need to do the whole sw init and minimum HW init to bring up the SMU and trigger the reset(possibly BACO) on all the ASICs at the same time with existing gpu_recovery routine.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: I34e838e611b7623c7ad824704c7ce350808014fc
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 96 +++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |  6 +-
 4 files changed, 87 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 420ef08a51b5..ae8be6d813a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1220,6 +1220,10 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 		}
 	}
 
+	/* Don't post if we need to reset whole hive on init */
+	if (adev->gmc.xgmi.pending_reset)
+		return false;
+
 	if (adev->has_hw_reset) {
 		adev->has_hw_reset = false;
 		return true;
@@ -2147,6 +2151,9 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
 			if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_PSP)
 				continue;
 
+			if (!adev->ip_blocks[i].status.sw)
+				continue;
+
 			/* no need to do the fw loading again if already done*/
 			if (adev->ip_blocks[i].status.hw == true)
 				break;
@@ -2287,7 +2294,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 
 	if (adev->gmc.xgmi.num_physical_nodes > 1)
 		amdgpu_xgmi_add_device(adev);
-	amdgpu_amdkfd_device_init(adev);
+
+	/* Don't init kfd if whole hive need to be reset during init */
+	if (!adev->gmc.xgmi.pending_reset)
+		amdgpu_amdkfd_device_init(adev);
 
 	amdgpu_fru_get_product_info(adev);
 
@@ -2731,6 +2741,16 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 			adev->ip_blocks[i].status.hw = false;
 			continue;
 		}
+
+		/* skip unnecessary suspend if we do not initialize them yet */
+		if (adev->gmc.xgmi.pending_reset &&
+		    !(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
+		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC ||
+		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
+		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH)) {
+			adev->ip_blocks[i].status.hw = false;
+			continue;
+		}
 		/* XXX handle errors */
 		r = adev->ip_blocks[i].version->funcs->suspend(adev);
 		/* XXX handle errors */
@@ -3402,10 +3422,29 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	 *  E.g., driver was not cleanly unloaded previously, etc.
 	 */
 	if (!amdgpu_sriov_vf(adev) && amdgpu_asic_need_reset_on_init(adev)) {
-		r = amdgpu_asic_reset(adev);
-		if (r) {
-			dev_err(adev->dev, "asic reset on init failed\n");
-			goto failed;
+		if (adev->gmc.xgmi.num_physical_nodes) {
+			dev_info(adev->dev, "Pending hive reset.\n");
+			adev->gmc.xgmi.pending_reset = true;
+			/* Only need to init necessary block for SMU to handle the reset */
+			for (i = 0; i < adev->num_ip_blocks; i++) {
+				if (!adev->ip_blocks[i].status.valid)
+					continue;
+				if (!(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
+				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP ||
+				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
+				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
+				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC)) {
+					DRM_DEBUG("IP %s disabed for hw_init.\n",
+						adev->ip_blocks[i].version->funcs->name);
+					adev->ip_blocks[i].status.hw = true;
+				}
+			}
+		} else {
+			r = amdgpu_asic_reset(adev);
+			if (r) {
+				dev_err(adev->dev, "asic reset on init failed\n");
+				goto failed;
+			}
 		}
 	}
 
@@ -3536,19 +3575,19 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* enable clockgating, etc. after ib tests, etc. since some blocks require
 	 * explicit gating rather than handling it automatically.
 	 */
-	r = amdgpu_device_ip_late_init(adev);
-	if (r) {
-		dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
-		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
-		goto failed;
+	if (!adev->gmc.xgmi.pending_reset) {
+		r = amdgpu_device_ip_late_init(adev);
+		if (r) {
+			dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
+			amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
+			goto failed;
+		}
+		/* must succeed. */
+		amdgpu_ras_resume(adev);
+		queue_delayed_work(system_wq, &adev->delayed_init_work,
+				   msecs_to_jiffies(AMDGPU_RESUME_MS));
 	}
 
-	/* must succeed. */
-	amdgpu_ras_resume(adev);
-
-	queue_delayed_work(system_wq, &adev->delayed_init_work,
-			   msecs_to_jiffies(AMDGPU_RESUME_MS));
-
 	if (amdgpu_sriov_vf(adev))
 		flush_delayed_work(&adev->delayed_init_work);
 
@@ -3565,6 +3604,18 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (amdgpu_device_cache_pci_state(adev->pdev))
 		pci_restore_state(pdev);
 
+	if (adev->gmc.xgmi.pending_reset) {
+		struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
+
+		if (atomic_read(&hive->number_devices) ==
+		    adev->gmc.xgmi.num_physical_nodes) {
+			/* Trigger hive reset when all gpus within the hive is ready */
+			dev_info(adev->dev, "Trigger XGMI reset during init.\n");
+			amdgpu_device_gpu_recover(adev, NULL);
+		}
+		amdgpu_put_xgmi_hive(hive);
+	}
+
 	return 0;
 
 failed:
@@ -4241,7 +4292,9 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	int i, r = 0;
 	bool need_full_reset  = *need_full_reset_arg;
 
-	amdgpu_debugfs_wait_dump(adev);
+	/* no need to dump if device is not in good state during probe period */
+	if (!adev->gmc.xgmi.pending_reset)
+		amdgpu_debugfs_wait_dump(adev);
 
 	if (amdgpu_sriov_vf(adev)) {
 		/* stop the data exchange thread */
@@ -4304,6 +4357,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 		list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 			/* For XGMI run all resets in parallel to speed up the process */
 			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
+				tmp_adev->gmc.xgmi.pending_reset = false;
 				if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
 					r = -EALREADY;
 			} else
@@ -4343,10 +4397,10 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 		if (need_full_reset) {
 			/* post card */
-			if (amdgpu_device_asic_init(tmp_adev))
+			r = amdgpu_device_asic_init(tmp_adev);
+			if (r) {
 				dev_warn(tmp_adev->dev, "asic atom init failed!");
-
-			if (!r) {
+			} else {
 				dev_info(tmp_adev->dev, "GPU reset succeeded, trying to resume\n");
 				r = amdgpu_device_ip_resume_phase1(tmp_adev);
 				if (r)
@@ -4797,6 +4851,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		if (audio_suspended)
 			amdgpu_device_resume_display_audio(tmp_adev);
 		amdgpu_device_unlock_adev(tmp_adev);
+		/* enable buffer function after reset */
+		amdgpu_ttm_set_buffer_funcs_status(tmp_adev, true);
 	}
 
 skip_recovery:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index aa0c83776ce0..8c71d84a2fbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -149,6 +149,7 @@ struct amdgpu_xgmi {
 	struct list_head head;
 	bool supported;
 	struct ras_common_if *ras_if;
+	bool pending_reset;
 };
 
 struct amdgpu_gmc {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 839917eb7bc3..cb59facba17a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2261,6 +2261,12 @@ static int psp_load_fw(struct amdgpu_device *adev)
 		goto failed;
 	}
 
+	/* Don't do the real PSP HW init if we are pending on XGMI reset.
+	 * The above init probably should move to psp_sw_init
+	 */
+	if (adev->gmc.xgmi.pending_reset)
+		return 0;
+
 skip_memalloc:
 	ret = psp_hw_start(psp);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 659b385b27b5..b1c8fd90c1b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -492,7 +492,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 	if (!adev->gmc.xgmi.supported)
 		return 0;
 
-	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
+	if (!adev->gmc.xgmi.pending_reset &&
+	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
 		ret = psp_xgmi_initialize(&adev->psp);
 		if (ret) {
 			dev_err(adev->dev,
@@ -538,7 +539,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 
 	task_barrier_add_task(&hive->tb);
 
-	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
+	if (!adev->gmc.xgmi.pending_reset &&
+	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
 		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
 			/* update node list for other device in the hive */
 			if (tmp_adev != adev) {
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C4984d6b147c74129b4ca08d8d86b2aca%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637497302087638243%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ITXvs4vUbDxQYsXrUeDHS3Jpd6dwrcmevvGdXT%2BwLTQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
