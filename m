Return-Path: <SRS0=ZMUS=IX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38A0C433C1
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 04:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F9746196C
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 04:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9746196C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB8326EC54;
	Thu, 25 Mar 2021 04:21:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DED226EC54
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Mar 2021 04:21:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ls5fDYamfYNqZcPW8RQFMqwPhBUDeFLQ/t0dTe/k2O9Kfz4UyuPR6A9SQYXKvfzWbph9JiZw7AQ7JN9OEjEYpOD89G2apie3Smpu4kaAxZJDD0iV0OLTvg8C/hbLbpmE1UOzsuPzCs7/ak+5gqHyTZP8w5I4/+vnOpgrq5FH8cxVGCgWNp3A1wexXgdDFbt1V/YQ2ApQFaIgcAhcnhpxWvdqRM9hBHa9G60ENN8xZy7mlylJtFOCeL5LPBvRF8747jTxbWrjC1SWjH05j7117Q4x1Du1TXhGkX1FXKTWW/AArq3FmCxLW1xL5zBGYHmI0BJZIO1Xna7LbUJM7NtdJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRujzAWqQTFE1ijYgJVU3JqUy5DzpZ6mBUnDLqvDsiQ=;
 b=fzhaPt1qGi3WpeZKfu6yLurR+AwRKFCoZcw/t0NO8KsxsU+pa47JXKw/oWJFybeMlOJ733O5RT2dpJs6jZO6k2672tE6mTq2xrwf9FVLyBiGUexA36HQ3IXlAaRAYK+FcFstpu3x4/qOTq0OTuICnwGY2rFseWnI2Wc3bMERfF8ax6vjUNoJhXJxK1BMVzt2nQtUo3Nry4sB1pKYHOMBIOnxGWR/vkaf0c/0j12Q0jvXHnVbwZhB3/2JUz9KxR39Aq3+t1LeDCX0JPDF8DF2CjiPdIFjxH6dSatTrarIYXh/a4WOcT1rEYE+uxdBT+cP3RTKc9WwTV14WynISr1K9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRujzAWqQTFE1ijYgJVU3JqUy5DzpZ6mBUnDLqvDsiQ=;
 b=eFXhwoHCuGOjajT3s3ZxAtp7bVzpY4y2/ySgj83eUWz1gnTHz1VrK4vtxtE4icoA19yDj2rPagqzvVF7071bUwBFMIwF3cAB99N4Dpwp2TP+f9eRLRHgWF/81qLCORy/wHMBAT4NebZj6QSEV8fQGbu5N/UWSmdYjJxBhKT8vNg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3771.namprd12.prod.outlook.com (2603:10b6:5:1ca::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Thu, 25 Mar 2021 04:21:36 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 04:21:36 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: unify the interface for loading SMU microcode
Date: Thu, 25 Mar 2021 12:21:14 +0800
Message-Id: <20210325042115.1104668-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0075.apcprd04.prod.outlook.com
 (2603:1096:202:15::19) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR04CA0075.apcprd04.prod.outlook.com (2603:1096:202:15::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.26 via Frontend Transport; Thu, 25 Mar 2021 04:21:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 36e643ee-0d2f-45e5-7175-08d8ef457a8e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3771:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB37714542C2EFFDCC4ECF6F83E4629@DM6PR12MB3771.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lH+TL3n585i9zuUALPFfXaN/ncjsK1zBrDMpZLSRkAQ1AuWCYGcNg9tZfHIQDdwvn1zDybAMF748MyhAXu5ZM1qzhf6uuAaWCcPK1hvVOKiOzpLIQXPHI6F5kajOPrYFT0B0xrrP5CQJXe6I/xL9Joak29ZkPH22Ais4t4jBqAtLus1/51g/eDAnIw0Bhl22eOPne4cDQnmo7xS8nsD5Mun1/NxwqBRTNQHJbK5BK7j7xGc/+T8Q8gg7zKqR2tAU9IhSLOhP52bNmyUTA+7Y2cWDzKn0BplJ8Oqqtzma+FRipuBJte7SjfQef4HL8UXAReUV5Q9WqTRDsw6En1uJDyk5w2ukZ6/ZIsoxjxO4o/TGddPwJns1sYnsLBzqnGPZ+sjL7Vi9DwFhGkbEPWr8Jo184EyBNLdYxWu0OcIJWGzil4wohijDZ5/SGQaQwvAzorerQAyyyUw8i80SQ4+c5BUfUZXlFi+r++kw/3x6fJusrzkTA3ScY6hFCPbj0AEg8OfWu4z4vEJ5NCV9kKQ3LrIzEGzNsZ5FW40YXGbaxZxiGjvd17bCSW1YUNHb+/rayvBLhhvqWEsBkZii9V5d0Yg+luDRgVQ31wejBZZ5xkTK2pypFSa/Wr7dRfCPe6XjCsiI6zsB1NgVsqzkTpVH449WbP+yO5x0dTwuxlvLvgY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(83380400001)(66946007)(4326008)(478600001)(1076003)(2906002)(6486002)(44832011)(186003)(66476007)(2616005)(66556008)(316002)(26005)(5660300002)(956004)(8676002)(16526019)(86362001)(36756003)(52116002)(7696005)(38100700001)(8936002)(6916009)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tY7LCl/KCDIn59A/xc0t5x9857HmlLt+cJudQG3ns2kwIO+wTpem3OsWIhdR?=
 =?us-ascii?Q?xYZ2A1JbppGAMnV5onWaxMyjzgQxaLU05FbIxC7BrQz8+ln2gLOpnhsbn0Jq?=
 =?us-ascii?Q?0gNPIa7eUGDJaRIouMJp1/Y243CNTdY56E3V4cubPiIJ17MaW6TNBShTyvJd?=
 =?us-ascii?Q?wlCdE8eig7F2/0olLbpiWFNfT2/OQCcL9yT4OlBYKunxN3ptdeME0o1+B0I7?=
 =?us-ascii?Q?t4OAXJ03+hogPLGe6x1uNyD/jkmXtL0Nv44MV5l90Ee67AhWv2REm4XKS6ob?=
 =?us-ascii?Q?OyFsmz0vP4vADdj8K0rFv0a+P524q9Qx7zdMP28iRoRMUdiQaKZNNtkd1XXR?=
 =?us-ascii?Q?KKBCpxAYMUexmBO6iQt6BTlin6zm/M8Os9CEnCCC53z2vytPXHHXiFtqtZmi?=
 =?us-ascii?Q?XOBbW/tTxI9t7CzURlKNgwL+2aMFkMD+jRlkXqlON8MWPSPOLvRpalT9d/BG?=
 =?us-ascii?Q?1+9I3CRTBqy3wZ8IB8Al/bjawPSz3BIy9OOatzUFPrSOHfTfJMUTq30iO3zI?=
 =?us-ascii?Q?gCGaIUoZ4oPISyKUSLWWLuAwSDvYRpkcyNqaH6wnyCZ+FzLBWEkrZQv6qV5G?=
 =?us-ascii?Q?muPmemjwO5rG+9+AON7RTZ6eigYx4MAsc1O4CvEUgdsceZXdLoIak6Da8Rb4?=
 =?us-ascii?Q?vRPAnCXHKvUOzeTLem101w34acq8M5XWrDmiXnb5lPSv2El9IdZ4Cru4Qte0?=
 =?us-ascii?Q?I4FvH0h/ebcOgejGdDITxzb9IE94cWdP06aubfHFvzRHfGVkz/pwPDXlEYJW?=
 =?us-ascii?Q?Dv/pYpLIvlbBNmRwHt1pBp5PwsMBdP+5/uGJnL76hEKP0F58ba+4wp9OG9jp?=
 =?us-ascii?Q?7XfqGy+kpSYVB+X6SYSwcuDcd/VET/KSxWZ4HJvyuxrq5FltXMmgI5lxB7th?=
 =?us-ascii?Q?yoDsEokk82svCoIdtBuFszWTUqKRnxN9otfGXMFcD3JlTDhTUwzg/qzC9V2U?=
 =?us-ascii?Q?+spx5VRBqb+Nw0iatPLJxdnVA9x4kyUwqC+ZhQKKoycRMSRHgHzeCCcG0X/9?=
 =?us-ascii?Q?Dmc6gBDL+OrVKYagN70C4pR9Cj7EOfxMLX00HYUEGijNSzjxtxmgF9islyKk?=
 =?us-ascii?Q?iMMZmlCwlR6S4G0uy0L87od4mht1+0EfFYtxlRlMF3byYJtIMhhATUQnaUbS?=
 =?us-ascii?Q?BWptPZ3+lyk9k5/JhNAQhWLZJYs79M+C0KWLtseqM/81VZWaJCrjU7GRhN0e?=
 =?us-ascii?Q?tbQYusI/PbeIF/5mdwS+nuJdDlIU5zDDmCpGz9YuNda49qMgpXyKMfhzXoEb?=
 =?us-ascii?Q?j87mYab5a116XpVmo7dQtfs/TAsqOwyWgPfnzXqiWCLvYSChcvl/04DD/G3/?=
 =?us-ascii?Q?go7kTY46MjCEt5LdN7r8+5aF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e643ee-0d2f-45e5-7175-08d8ef457a8e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 04:21:36.2881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9fMK9cDkvVIZLLRvcvuva0Vxb7jTB8UqjNUgbXg92BNOgtdG0yY3y1HIbuCnGjX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3771
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No need to have special handling for swSMU supported ASICs.

Change-Id: I49395bfc31b43b09bac78527cd8f08e8600749b3
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    | 10 ++----
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c       |  5 ++-
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  4 ---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 41 +++++++++++------------
 4 files changed, 26 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 9a65ff871a58..b4fd0394cd08 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7174,16 +7174,10 @@ static int gfx_v10_0_hw_init(void *handle)
 		 * loaded firstly, so in direct type, it has to load smc ucode
 		 * here before rlc.
 		 */
-		if (adev->smu.ppt_funcs != NULL && !(adev->flags & AMD_IS_APU)) {
-			r = smu_load_microcode(&adev->smu);
+		if (!(adev->flags & AMD_IS_APU)) {
+			r = amdgpu_pm_load_smu_firmware(adev, NULL);
 			if (r)
 				return r;
-
-			r = smu_check_fw_status(&adev->smu);
-			if (r) {
-				pr_err("SMC firmware status is not correct\n");
-				return r;
-			}
 		}
 		gfx_v10_0_disable_gpa_mode(adev);
 	}
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 0a6bb3311f0f..464fc04fb334 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1606,7 +1606,10 @@ int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_versio
 			pr_err("smu firmware loading failed\n");
 			return r;
 		}
-		*smu_version = adev->pm.fw_version;
+
+		if (smu_version)
+			*smu_version = adev->pm.fw_version;
 	}
+
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 9507ae34c4ca..4684eca7b37b 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1287,10 +1287,6 @@ enum smu_cmn2asic_mapping_type {
 	[profile] = {1, (workload)}
 
 #if !defined(SWSMU_CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !defined(SWSMU_CODE_LAYER_L4)
-int smu_load_microcode(struct smu_context *smu);
-
-int smu_check_fw_status(struct smu_context *smu);
-
 int smu_get_power_limit(struct smu_context *smu,
 			uint32_t *limit,
 			enum smu_ppt_limit_level limit_level);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 10a8c4a65619..3bbe0278e50e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2115,36 +2115,34 @@ const struct amdgpu_ip_block_version smu_v13_0_ip_block =
 	.funcs = &smu_ip_funcs,
 };
 
-int smu_load_microcode(struct smu_context *smu)
+static int smu_load_microcode(void *handle)
 {
+	struct smu_context *smu = handle;
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->pm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
+	/* This should be used for non PSP loading */
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
+		return 0;
 
-	if (smu->ppt_funcs->load_microcode)
+	if (smu->ppt_funcs->load_microcode) {
 		ret = smu->ppt_funcs->load_microcode(smu);
+		if (ret) {
+			dev_err(adev->dev, "Load microcode failed\n");
+			return ret;
+		}
+	}
 
-	mutex_unlock(&smu->mutex);
-
-	return ret;
-}
-
-int smu_check_fw_status(struct smu_context *smu)
-{
-	int ret = 0;
-
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
-	mutex_lock(&smu->mutex);
-
-	if (smu->ppt_funcs->check_fw_status)
+	if (smu->ppt_funcs->check_fw_status) {
 		ret = smu->ppt_funcs->check_fw_status(smu);
-
-	mutex_unlock(&smu->mutex);
+		if (ret) {
+			dev_err(adev->dev, "SMC is not ready\n");
+			return ret;
+		}
+	}
 
 	return ret;
 }
@@ -2995,6 +2993,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.set_watermarks_for_clock_ranges     = smu_set_watermarks_for_clock_ranges,
 	.display_disable_memory_clock_switch = smu_display_disable_memory_clock_switch,
 	.get_max_sustainable_clocks_by_dc    = smu_get_max_sustainable_clocks_by_dc,
+	.load_firmware           = smu_load_microcode,
 };
 
 int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
