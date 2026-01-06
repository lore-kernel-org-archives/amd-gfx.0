Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D9DC47BE0
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 10:14:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C52BE10E4D0;
	Tue,  6 Jan 2026 10:14:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3h1vaoza";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010040.outbound.protection.outlook.com [52.101.61.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9A6110E4D0
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 10:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wnh8hW2d5DCh1yr6n2beklodD1ruynh+beDnRI4kJ37OMG63kJBRXQ4rd0BOCATk1+JM2kN71tFPicBhnXyxJ5e9CEBdYFzvQkxqZkrilFfrTDO2bWrGCcga7mXooaN5UXR/5dJov91627hsN7l/vsij8P9kmYvMsiAAiw+iRwWfEYV/JHqV9IlKM2Ff4inLsYTrnEBytKzvAd6gt7EROaNObJl6qpvCKU9P+qLBUuq6wlb7r7YPny0LbzPZQbdCt81b+ZC+JxVKRP+EMaF/z78dCMqCco9AjjEP+ToI7Z0U0H7at7IEVjJjKLiNYp/4R8S71UCA3XfxSz2lIF5vvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41ZlEhoZhdtQTiM7+2NhNP27NyhEdXL53I7TAlnTcoY=;
 b=NTnM+qh+ng/gH9wdLiSLIiu5zDFmf9w6pkGSLV54UgJXKFbrQxYVY8QN0qSQBtTR/7peAevDlLftsg1F/3QfAfhEL1apFXW9aXGs2OqQQ7cq0F8rAQFfFbGEJpmzqpID21WP3xiuE2ciDvSp5IAkqHSwwg74nf2q5qzkkmmpZseeRkvfyCfGTR43TUKy+lrlbQzoqGjEcYIypaXvbQ0MrmP85CBhyZ6dm4PjCaVd50svIlsfjGgigDeXXEOzV8IZCn2G0w7Vh3OpnpqUphp7IBSeTuD3Kxm4KBVJ6vmZCjh9ZdkbDjY3rQ0DFAiKZKz43Yf2FKiV1uk21Y0zM9suvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41ZlEhoZhdtQTiM7+2NhNP27NyhEdXL53I7TAlnTcoY=;
 b=3h1vaozasPvmA2Cd07h2LF/lDfwurQkg6l+CB2Yc26N6BkZ9V2DsuQpCXlUogP09/4yTRdoDYswTucViBcIdUCapZTryhsbYrCG/SFzP5Kr7n/n+zFSZmJuLiUZNlFxUrPSiRfwLXWEKtmYU1d860F8kFoGeKOTBzPTNTDZixkU=
Received: from SA0PR11CA0164.namprd11.prod.outlook.com (2603:10b6:806:1bb::19)
 by MN0PR12MB6367.namprd12.prod.outlook.com (2603:10b6:208:3d3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 10:14:19 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:1bb:cafe::19) by SA0PR11CA0164.outlook.office365.com
 (2603:10b6:806:1bb::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Tue, 6
 Jan 2026 10:14:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 10:14:18 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 04:14:16 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 21/21] drm/amd/pm: Use message control for debug mailbox
Date: Tue, 6 Jan 2026 15:42:41 +0530
Message-ID: <20260106101317.3856153-22-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260106101317.3856153-1-lijo.lazar@amd.com>
References: <20260106101317.3856153-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|MN0PR12MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: e31db474-5d3e-49b4-f4dd-08de4d0c5aa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aDNVOnwdioY+XNRkcCQvduoaPaH183wpTq/JuXTbvh4EBfa2gx+H3ANBhfzw?=
 =?us-ascii?Q?I7FbX+9WW7FWZp40Yqwpw7cSWN83ZOMVfes0mK+ZsWKmhkukiqU/ZIXPgg4d?=
 =?us-ascii?Q?ZKIy0ZFlwOd5XR0SJg8fMqSwCG3MDV7y7keSz0n+Xr0lDev4AlNGaaveXBHc?=
 =?us-ascii?Q?0aNo88hbE8CHXZ+ZjcQ3nnAF/vF9icy54Uuxao+eB4itCq2MHBuWePY/6uMV?=
 =?us-ascii?Q?SoMd225W8Jx6d+CEw4L+qDNdgEbEygJ1nVYTY/PpHwR1LzBMXQJP+w14xFZl?=
 =?us-ascii?Q?Rh/gz/K4/1zEiGOibZFFcyddgmEfhV6FyXJbIPGkH+EkerysOIOt46QmkqHr?=
 =?us-ascii?Q?nNkYCeqTbXUDeQA0uHCAT6Q5Jdx+N+WdD6DTx+OM/Cs51flo/2bhFSXlqymr?=
 =?us-ascii?Q?FARLF/yX9xrGJLKamoq7q1eRKsaxiXGI7VjgVwIL3cUEFPT6xpRH8lqRph4Y?=
 =?us-ascii?Q?oOd0GQPSrfFZ3Cbi/Zye2rynrflT6YNB7STYTp7QSkkwBjgnhVM1LRT0ZU4k?=
 =?us-ascii?Q?Zmhxbps+OlPZzyu6e33VWqYbWS0l5mQMUxEkwBJ3+UsVAv2XphBwr2Jj9Ui0?=
 =?us-ascii?Q?DPKZsO66PbymxvlNehgt6955hjcPfGAj88vGReomZaD6IGSDrcjJsJR5+9Qf?=
 =?us-ascii?Q?so7OiJbqVTAr+iQiKNnbP04J5DRGFxkGEW/LWZFji7klaPHbgMsJI0QVfq8n?=
 =?us-ascii?Q?xQVShhnSRTxXavc63Gkw9KzTVBRIZW6NVv3sRmfQB95X6whOujgNTVgSdnTu?=
 =?us-ascii?Q?TS2QphE1KP2uc9zdBpZmQm52pjQ3bMaYTD8dCohmKbj/9gEddaKGTp1bfHFK?=
 =?us-ascii?Q?IDAykjLtYddemaKQjh9zFOHJeTIRRui09FBoQ4M2gSw92OuBWQFhrBHPBmi+?=
 =?us-ascii?Q?ip2WFETp3rZ4l+lmybNRmlB39KHnouox7ccdLZkwNtCDo82MEpwJk6fjbvZW?=
 =?us-ascii?Q?JjQPCv+q+frP0K/WFFLls8Ypw85vfyo6gtmSDHmfTh4zV3wS/t+7hNUz8u/p?=
 =?us-ascii?Q?Zm7bX5FZdqSZCCzOT/iyl8fG1VsGfR7utx6bt5b6EOuhakNoGy39QGgaBli2?=
 =?us-ascii?Q?tlCTVvkbrYPHV/GOlRPzW97YPQuhfDG2nkqdwbBtOAzD8H1LfulznKlKeeZt?=
 =?us-ascii?Q?g9JHiiQKmRVitQ6Dn5ZNWFJ+ADDkarZZSJod/X818Gic9K4XeH55Mpcpp7xj?=
 =?us-ascii?Q?WXvMRv6csiYwEjS+RvTn71cG3CNarxk0VkoFM3lGCUgpwd+fukWPL6bABdAi?=
 =?us-ascii?Q?7c8ieR+8by9ZM3ZuH8wuUVZwMlBWGk6yx4LRz5uZ6leyzqD/7WBLDM03VGW0?=
 =?us-ascii?Q?M4Up322OfBAPvrGVWDz4LGBHGGjwYjK5cdNXzLP1/ob0xaEO8ubUVpC4BVN/?=
 =?us-ascii?Q?ZpzMPQbANiMBcJEggF/j2FrEqwjaKRrfp7EkMYLOsyXkPZMcAzoE+HBmIONH?=
 =?us-ascii?Q?W2OyyP7+3BPcsdkaIm9GeaFBgKF2r6VKSQ9ud+C8mFR1gEZrH1PL4dRCCKV9?=
 =?us-ascii?Q?6RuFQvgbTXisWK8apu/XM2Ctk7+E8DJMGMPMys1Oy7hfZFbiw5nE5rmiDznp?=
 =?us-ascii?Q?cBi9gOEs/TVSqz4mUx0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 10:14:18.8226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e31db474-5d3e-49b4-f4dd-08de4d0c5aa5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6367
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

Migrate existing debug message mechanism so that it uses debug message
callbacks in message control block.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  4 ----
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 16 ++++++++++------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 17 +++++++----------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 19 ++++++++-----------
 5 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 9b151425feb6..47176810fccd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -755,10 +755,6 @@ struct smu_context {
 
 	struct firmware pptable_firmware;
 
-	u32 debug_param_reg;
-	u32 debug_msg_reg;
-	u32 debug_resp_reg;
-
 	struct delayed_work		swctf_delayed_work;
 
 	/* data structures for wbrf feature support */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 34ff4c35baff..51f96fdcec24 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2366,6 +2366,7 @@ void smu_v13_0_init_msg_ctl(struct smu_context *smu,
 	ctl->ops = &smu_msg_v1_ops;
 	ctl->default_timeout = adev->usec_timeout * 20;
 	ctl->message_map = message_map;
+	ctl->flags = 0;
 }
 
 int smu_v13_0_mode1_reset(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 37941b6c2831..ce52b616b935 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2882,13 +2882,18 @@ static int smu_v13_0_0_enable_gfx_features(struct smu_context *smu)
 		return -EOPNOTSUPP;
 }
 
-static void smu_v13_0_0_set_smu_mailbox_registers(struct smu_context *smu)
+static void smu_v13_0_0_init_msg_ctl(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
 
-	smu->debug_param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_53);
-	smu->debug_msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_75);
-	smu->debug_resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_54);
+	smu_v13_0_init_msg_ctl(smu, smu_v13_0_0_message_map);
+
+	/* Set up debug mailbox registers */
+	ctl->config.debug_param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_53);
+	ctl->config.debug_msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_75);
+	ctl->config.debug_resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_54);
+	ctl->flags |= SMU_MSG_CTL_DEBUG_MAILBOX;
 }
 
 static int smu_v13_0_0_smu_send_bad_mem_page_num(struct smu_context *smu,
@@ -3216,8 +3221,7 @@ void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
 	smu->pwr_src_map = smu_v13_0_0_pwr_src_map;
 	smu->workload_map = smu_v13_0_0_workload_map;
 	smu->smc_driver_if_version = SMU13_0_0_DRIVER_IF_VERSION;
-	smu_v13_0_0_set_smu_mailbox_registers(smu);
-	smu_v13_0_init_msg_ctl(smu, smu_v13_0_0_message_map);
+	smu_v13_0_0_init_msg_ctl(smu);
 
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) ==
 		IP_VERSION(13, 0, 10) &&
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index e414dfd6f644..03c26d8248a3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2107,15 +2107,6 @@ static int smu_v14_0_2_enable_gfx_features(struct smu_context *smu)
 		return -EOPNOTSUPP;
 }
 
-static void smu_v14_0_2_set_smu_mailbox_registers(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-
-	smu->debug_param_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_53);
-	smu->debug_msg_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_75);
-	smu->debug_resp_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_54);
-}
-
 static void smu_v14_0_2_init_msg_ctl(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -2130,6 +2121,13 @@ static void smu_v14_0_2_init_msg_ctl(struct smu_context *smu)
 	ctl->ops = &smu_msg_v1_ops;
 	ctl->default_timeout = adev->usec_timeout * 20;
 	ctl->message_map = smu_v14_0_2_message_map;
+	ctl->flags = 0;
+
+	/* Set up debug mailbox registers */
+	ctl->config.debug_param_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_53);
+	ctl->config.debug_msg_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_75);
+	ctl->config.debug_resp_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_54);
+	ctl->flags |= SMU_MSG_CTL_DEBUG_MAILBOX;
 }
 
 static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu_context *smu,
@@ -2876,6 +2874,5 @@ void smu_v14_0_2_set_ppt_funcs(struct smu_context *smu)
 	smu->table_map = smu_v14_0_2_table_map;
 	smu->pwr_src_map = smu_v14_0_2_pwr_src_map;
 	smu->workload_map = smu_v14_0_2_workload_map;
-	smu_v14_0_2_set_smu_mailbox_registers(smu);
 	smu_v14_0_2_init_msg_ctl(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index f639d3636d30..5b1f059105d6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -102,17 +102,14 @@ static int smu_msg_v1_send_debug_msg(struct smu_msg_ctl *ctl, u32 msg, u32 param
 	return 0;
 }
 
-static int __smu_cmn_send_debug_msg(struct smu_context *smu,
-			       u32 msg,
-			       u32 param)
+static int __smu_cmn_send_debug_msg(struct smu_msg_ctl *ctl,
+				    u32 msg,
+				    u32 param)
 {
-	struct amdgpu_device *adev = smu->adev;
-
-	WREG32(smu->debug_param_reg, param);
-	WREG32(smu->debug_msg_reg, msg);
-	WREG32(smu->debug_resp_reg, 0);
+	if (!ctl->ops || !ctl->ops->send_debug_msg)
+		return -EOPNOTSUPP;
 
-	return 0;
+	return ctl->ops->send_debug_msg(ctl, msg, param);
 }
 
 /**
@@ -199,13 +196,13 @@ int smu_cmn_send_smc_msg(struct smu_context *smu,
 int smu_cmn_send_debug_smc_msg(struct smu_context *smu,
 			 uint32_t msg)
 {
-	return __smu_cmn_send_debug_msg(smu, msg, 0);
+	return __smu_cmn_send_debug_msg(&smu->msg_ctl, msg, 0);
 }
 
 int smu_cmn_send_debug_smc_msg_with_param(struct smu_context *smu,
 			 uint32_t msg, uint32_t param)
 {
-	return __smu_cmn_send_debug_msg(smu, msg, param);
+	return __smu_cmn_send_debug_msg(&smu->msg_ctl, msg, param);
 }
 
 static int smu_msg_v1_decode_response(u32 resp)
-- 
2.49.0

