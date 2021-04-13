Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F241C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 11:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35261610CA
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 11:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35261610CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9625895B6;
	Tue, 13 Apr 2021 11:51:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B3EF895B6
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 11:51:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBDnKaijMOpp8mVsbaBLRcUPs1Xhao9gzYMt8eKJ4vWiGRFx7+d0++EW3dI+WiHU+QvWd72gZQ4qZr7bphl9rLWX5rzHPWLBOJuNMlWq6GFk7EQOEkpO/mLrRLtUlwQ00zKE9QUZ3/1Uh02flcAGl1p79gntqHV06T+HwbnjfwD0pcD0JmsE8h5X/AMRX+n4XhgpPUNRlUVKje3oItzIJfLIcTCzjYU0Krs0+1ZrEWwfYiwLc40q9p5Wuv4ewwonRdzIs/1ftmC97Arm6kuigPiHIeiSz0E9y0qcO9v6s3quIM+d3xpVcCtySGHyRBpuxbMsQX/0D93YC3aqYPeTIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DINIAKewgcO4S5vS3n/EzNlIFxhWlrlQOJQrfJDrnQ=;
 b=NjEpFx3DcIoKuQK0eiTrtKi5wTYbpd9cA7HZ4hRT5ou/+/CnsJAy/tjskGvDetWTA0N3LU4zURLEa/N1KD0ZvvPleDzIbAtS8Fg3jLQpDy3/gh24nwqJOwNV5JguvVuHbVUyuxpmgcpf43iMzUawcKVeykijmV+OFLRdAjPkJPevDdPvjJNaBgBNsyEJyUnKy03i03PD0atjOhfFItl6r+uF8UmHTJpIevapJpqPEtxG2Ciej0Lcpqmlus7FCcYlQ6++eAmEwjybCkSHwokECH71+hlFqAhx04qZVCaBMUzNKU4TF0Ns/eRTN06XD2ZKPRKlzUgDr2lTG+nAP+8qzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DINIAKewgcO4S5vS3n/EzNlIFxhWlrlQOJQrfJDrnQ=;
 b=D7xjgjGxQFsKmid0dSkPS8PlVR1+HiwFXvJJ+BVUAom8eU2ORv6a7EdS1ubsbbZaKjEk8NMEoMb+CRVzFLaJpCVTxGWw8PaLf6UBB3GCJlng2dRYE/sjK/HbwSRMbruB4+OwSrpVaUBYtmJLagqbi3h1dL1MwYf6Fda3Ddoy5Wo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3023.namprd12.prod.outlook.com (2603:10b6:208:c8::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Tue, 13 Apr
 2021 11:51:45 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::8da7:cf00:1356:1199]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::8da7:cf00:1356:1199%5]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 11:51:45 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: correction of ucode fw_size calculation errors
Date: Tue, 13 Apr 2021 19:51:19 +0800
Message-Id: <20210413115119.15962-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2P15301CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::30) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-ws.amd.com (58.247.170.245) by
 HK2P15301CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.1 via Frontend Transport; Tue, 13 Apr 2021 11:51:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b157c8d-dfb0-4fae-9f7d-08d8fe728299
X-MS-TrafficTypeDiagnostic: MN2PR12MB3023:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3023A0FDA71AE969A460383DA24F9@MN2PR12MB3023.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xvQ1tBhkPFQDnp9mE7QWCTHW3+Y6VZ9HPIMsTxNRHJJG6Weth+hVRjlmwWjYJGnlHClylt1bsIBBT186GCvJEvimF/GkSSTcS+Rh1GV+n03qAW49Yc1kiEJhGSXg6RKEGY6xtQA9rdPaYD/+OHboU7MXHIMrwbg8AUXdDZEblxrOqoGBSiXs4oXAYaSjZfVEUE3zErNJb8W7Mow+iiNsD8EoHXDTgXerPyHUXRoodmShqiklC46pGgT4tbSNZypixFbru8suhEJF8X8lqZQEbFPK/63saIK3gdIVFrXOx2tsDpfzf7XvjJ+YCuDS/FfzMWuECvRUfoDJ2TLOraBybVFIMzd6DoO8A/Z8ILDRO2QlY0JqNTdjDbyh67uvl2E68d2XEfGGefL6Sv/I6RNEshTZ8PcsOnnld5V4T7OB/COeJIuTlQxKRuoypNu9i89WLQe54V64WE68nzaz/14G72Qj8nLh9+Jk2kQ85toCIt1BOjOxf/mWaEyl06xNkri1EeFf3GaaRKXAvsA6yoyztJpGS/9FsLxWv5LvZiRMWm9HLeV74HpRQT+pQeu5q5uGM4POzuiM3pwRalzn3iZtlRyuj5w3VLsAJ6KoX3H9Vt+0GWEJs0K/zqyI6/LRtHT5SbCKWD++qQ7d+4BunoYM+M0fVhsUXQP9HPBzkxFkOMY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(186003)(38100700002)(2616005)(66556008)(956004)(6486002)(8936002)(316002)(1076003)(66946007)(2906002)(52116002)(83380400001)(5660300002)(4326008)(478600001)(7696005)(26005)(6916009)(66476007)(38350700002)(36756003)(86362001)(8676002)(6666004)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4LrGWYXhSmLnm5//a+nFbGLktpR2dvZErV6iclfqPV3xHUjXi4Jsac6PigMj?=
 =?us-ascii?Q?MDMDeTyS+ub+5OjHBWwY1PbTp0/r1Lg1e17E4yzWFxhRNPQlnuALhZaGQs9y?=
 =?us-ascii?Q?oAE0xIo1wPatm/hcaU92dvaHsc7kUtlGzr+KJMFjse4BrVncVtYX3cXsqA9A?=
 =?us-ascii?Q?4PS0Syuyw0/PZJWxtwv5YIEAfIDv3d3VHuGv11m34CxPsFR99CcKAsUgrbJC?=
 =?us-ascii?Q?lDtZAANflRt+ckpRNEHmRDngYoDsny2/1LWX3MM2wLP0aTIUniy5e5uPJPZR?=
 =?us-ascii?Q?SMEIYc2hLpWeH1mIFGjN2StWr7ycQPMG3mbdyOA8HONTySAYgO7Y6rg1cIXO?=
 =?us-ascii?Q?GLfrsmP/gi9pslqhU5XjZ14lCl1gGdtAcpX9yzcJMIy431n0PfUWMMEwKkF4?=
 =?us-ascii?Q?4SfrrWQ+0w1+sF16pT8NABSOlKFTViuSNZBlQN8H/++joRBxsv2qMqaDZ75/?=
 =?us-ascii?Q?Mw85juwtEv4YNEUsgCrDngKjV2O66piHyBFy2fh9zLKFJAkPYrTcZq/vO8Bl?=
 =?us-ascii?Q?W6eNTd+kYWVwAi8kyNZijt2oJJ4rsM7rjdIctJOQRXFFxoUEfUmfbquNJ1wn?=
 =?us-ascii?Q?9anU4575QQMPtAKGDCccGNxQk1aDALtji5VLqQbNw4TKqCVAOamLuNsa1pm4?=
 =?us-ascii?Q?P13T+cg2h78wu6dVW+c3tADt0abQKQM872SndPeudtu3C514eLKKBFXR6cJZ?=
 =?us-ascii?Q?596niw/J8ygCuXBA9usqnhZHqNh02E3bgz8VcsY5jsqjUdOPCNUi8h9SdwuZ?=
 =?us-ascii?Q?oeDcwiTHmTtlAORJItDXY2t5wGnIOx89gOEM+dvigK6nsfcNj+oV/ZBklZto?=
 =?us-ascii?Q?tE9LFmTgvXrZF2cwxcuRe0Mre2TfCDjRLC9M1PDZdX0wog8b/PwGId/MEzUb?=
 =?us-ascii?Q?RJgRIM1xVAuyNetNSv2rpnuJYV3v1XyoZ5tHR/U2yVKGmk4EfsBZJFXcGGbD?=
 =?us-ascii?Q?qRWc+2NDUUzPBfj2URldSKWmqpJwHRuJyJ0fGPuUNE8le9OA1dQ+yFQTci6q?=
 =?us-ascii?Q?lj9hDoi9O9ZTh/bArCsqGuiLzKe0EHnmVB4EyFMdWbVL9rIDbrTtGnvYLbBG?=
 =?us-ascii?Q?0Tx09CdO9Oqt3kWTUqv7/XxovN0UwF6JwcM5R4IbEkmeoGgTo2vQPpaUAre2?=
 =?us-ascii?Q?ktAyluyTPCaeYAufFo9bo5dxuRI1smKgI/4PKpN/hhXxiHq60U2WDuUaDpI2?=
 =?us-ascii?Q?RS8G6yYnBY0YosncFqIfZ5gMGT704jx46WPakd+RswooMb0kyndGIItgHkdE?=
 =?us-ascii?Q?WRUUhnpn3yDtv+ObGnX9KaShQpRgnvXVa1qkGwkfmlQIhOmnYMZpTKm0Qc48?=
 =?us-ascii?Q?E0CYySrDNjBZA43GVidI/svq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b157c8d-dfb0-4fae-9f7d-08d8fe728299
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 11:51:45.0384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yojU9GE2MKvqgeT0aen99TJNww9bzhpPGP8innfrxvE77GYkKWMVvqgzYZSjtX/n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3023
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
Cc: Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

correct big and little endian problems on different platforms.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c         | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c          | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 85a6a10e048f..0a00a7cc8eaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4354,7 +4354,7 @@ static int gfx_v10_0_mec_init(struct amdgpu_device *adev)
 			 le32_to_cpu(mec_hdr->header.ucode_array_offset_bytes));
 		fw_size = le32_to_cpu(mec_hdr->header.ucode_size_bytes);
 
-		r = amdgpu_bo_create_reserved(adev, mec_hdr->header.ucode_size_bytes,
+		r = amdgpu_bo_create_reserved(adev, fw_size,
 					      PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
 					      &adev->gfx.mec.mec_fw_obj,
 					      &adev->gfx.mec.mec_fw_gpu_addr,
@@ -5769,7 +5769,7 @@ static int gfx_v10_0_cp_gfx_load_pfp_microcode(struct amdgpu_device *adev)
 		le32_to_cpu(pfp_hdr->header.ucode_array_offset_bytes));
 	fw_size = le32_to_cpu(pfp_hdr->header.ucode_size_bytes);
 
-	r = amdgpu_bo_create_reserved(adev, pfp_hdr->header.ucode_size_bytes,
+	r = amdgpu_bo_create_reserved(adev, fw_size,
 				      PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
 				      &adev->gfx.pfp.pfp_fw_obj,
 				      &adev->gfx.pfp.pfp_fw_gpu_addr,
@@ -5847,7 +5847,7 @@ static int gfx_v10_0_cp_gfx_load_ce_microcode(struct amdgpu_device *adev)
 		le32_to_cpu(ce_hdr->header.ucode_array_offset_bytes));
 	fw_size = le32_to_cpu(ce_hdr->header.ucode_size_bytes);
 
-	r = amdgpu_bo_create_reserved(adev, ce_hdr->header.ucode_size_bytes,
+	r = amdgpu_bo_create_reserved(adev, fw_size,
 				      PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
 				      &adev->gfx.ce.ce_fw_obj,
 				      &adev->gfx.ce.ce_fw_gpu_addr,
@@ -5924,7 +5924,7 @@ static int gfx_v10_0_cp_gfx_load_me_microcode(struct amdgpu_device *adev)
 		le32_to_cpu(me_hdr->header.ucode_array_offset_bytes));
 	fw_size = le32_to_cpu(me_hdr->header.ucode_size_bytes);
 
-	r = amdgpu_bo_create_reserved(adev, me_hdr->header.ucode_size_bytes,
+	r = amdgpu_bo_create_reserved(adev, fw_size,
 				      PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
 				      &adev->gfx.me.me_fw_obj,
 				      &adev->gfx.me.me_fw_gpu_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 06811a1f4625..831398e15b84 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2013,7 +2013,7 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *adev)
 		 le32_to_cpu(mec_hdr->header.ucode_array_offset_bytes));
 	fw_size = le32_to_cpu(mec_hdr->header.ucode_size_bytes);
 
-	r = amdgpu_bo_create_reserved(adev, mec_hdr->header.ucode_size_bytes,
+	r = amdgpu_bo_create_reserved(adev, fw_size,
 				      PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
 				      &adev->gfx.mec.mec_fw_obj,
 				      &adev->gfx.mec.mec_fw_gpu_addr,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 6274cae4a065..00610def69ea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -174,7 +174,7 @@ int smu_v11_0_load_microcode(struct smu_context *smu)
 	hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
 	src = (const uint32_t *)(adev->pm.fw->data +
 		le32_to_cpu(hdr->header.ucode_array_offset_bytes));
-	smc_fw_size = hdr->header.ucode_size_bytes;
+	smc_fw_size = le32_to_cpu(hdr->header.ucode_size_bytes;)
 
 	for (i = 1; i < smc_fw_size/4 - 1; i++) {
 		WREG32_PCIE(addr_start, src[i]);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 0864083e7435..d7ea8215d7dc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -149,7 +149,7 @@ int smu_v13_0_load_microcode(struct smu_context *smu)
 	hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
 	src = (const uint32_t *)(adev->pm.fw->data +
 				 le32_to_cpu(hdr->header.ucode_array_offset_bytes));
-	smc_fw_size = hdr->header.ucode_size_bytes;
+	smc_fw_size = le32_to_cpu(hdr->header.ucode_size_bytes);
 
 	for (i = 1; i < smc_fw_size/4 - 1; i++) {
 		WREG32_PCIE(addr_start, src[i]);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
