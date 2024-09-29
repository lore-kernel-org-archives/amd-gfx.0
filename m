Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58282CF6499
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Sep 2024 10:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A25C210E111;
	Sun, 29 Sep 2024 10:49:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BXydFtqD";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0366910E144
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Sep 2024 10:49:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ty4/x15XIz88CurX2jMKItpT+Hqy5oryg7Z3OuMG0IW+zntZZh94FJ0oKr7GUkA1+m9afHanXz6XjHWctwritNdgC9NiiYa1eOxLzw1J7Wuy1z06vLRx8IepQSTIM97QP5NKa6gv/kX5vEpC5b6Rp/Bzf1FI4p4ABZ06gJeKJjcDWcW3r08qxJHtLCJUD72PEFkkUlZVALKQCNxf9lDTEwLStp5Zqos2MdC8jhAYCSbgKU1Tg1hRTlCWWgnMIRTS2sCPFZaigzyw6t8wJAqeCMoz7yVFXh9ls4DC7cws/HASrT6jvK8jDXNEM91rnz2YK5XT1tAJ0WF91GStFKHhtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PGqpzrw7fNnI00Ls1bM33XdDGZjCsp0C8mhK888F58=;
 b=FyHsP30b62sDhnvrT9/rb3GlLz6cGJLk3bh3rxzrlZwbeC55gbhIJgIHctySuRzN/jBlwhRQh3kh02PA4ARc1S41jnTDNIq7/3VwXCn7IqQs2arB0yiK5W/DTSgi8s8XXWorT5dT/sLvK8UX0tVLyM+rPOwTmymALgp/PuL1dbh7vYJnuTBjpu9tXuOI8hmOFIP1iIcpgz+G4/rkikViTvdvgXM5rNKZ7ntraHeCSy6AdRhNmVU0SYUi/foznJk/tw3ARCy/eVAuxtFIV0V+dXt1MPP7ESWxgQ2iBcHikXoflYbAZd2f9KzWkKZ00SfVzpM13s81LfJHOoIjM6F59g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PGqpzrw7fNnI00Ls1bM33XdDGZjCsp0C8mhK888F58=;
 b=BXydFtqDiG1IdaKGk/iTk/K04n7xDjcCcA4rSk8rRr7XF0VA43P6ONo4aS2Y7+Gn/rLHPWHnxSodykZlXqn/7m+yPH78kCCzJIM8kOojVWaHegKRWTcifHqmc5Ks1/SH/AmJM4AHFqzDUNydmhqJsDe86OlT5gebVwXG9pFm+FU=
Received: from SA1P222CA0155.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::25)
 by CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Sun, 29 Sep
 2024 10:49:15 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::88) by SA1P222CA0155.outlook.office365.com
 (2603:10b6:806:3c3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26 via Frontend
 Transport; Sun, 29 Sep 2024 10:49:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Sun, 29 Sep 2024 10:49:14 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 05:49:13 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>
Subject: [PATCH 2/3] drm/amd/pm: implement dpm sdma reset function
Date: Sun, 29 Sep 2024 18:48:55 +0800
Message-ID: <20240929104856.46010-2-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240929104856.46010-1-jiadong.zhu@amd.com>
References: <20240929104856.46010-1-jiadong.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|CH3PR12MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2409bb-06f2-4920-c00b-08dce0745c38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6fz6F0kdd6FLFxOKq9/9h4IcRgmCsyY04Q+ycYQywby/xeRVaVkwbJPXevuI?=
 =?us-ascii?Q?u/tV8lSiE30v6RhNcLA0BKJQojNAGZJcH45/prLFsEij8l4hccWbxyW9v8hO?=
 =?us-ascii?Q?awuvPjiwfMRZMTcK77lPIut+cUmP8HGG7kNemvDkn/D2a8Xv9ED3EOHxKlUh?=
 =?us-ascii?Q?bzsNmyzDwyzSG6XI6oM75NP+w3lUIQEXw/rtMCwnRjCs5/LjLB80vv74gig5?=
 =?us-ascii?Q?azjzKuaqGZKZh9osb5ExmwkFera08comqT1/oHdbpQjNiPcFnqZNTyjTBz1J?=
 =?us-ascii?Q?PJ9ZFWdmgok/NF5TOUBhpaihTukiPvJa7JnBUxHHJ3D6rcgKBTS4wgaC3R6W?=
 =?us-ascii?Q?hBr5d0bGTrYe0qxmFG/Diq+Re5DnJ9Ulgrc43iiNY3gJnwp9wjikZ0nrup8E?=
 =?us-ascii?Q?ofxjAy5WI4POVCB3vC0VOIQ0mi4jScjlECuVjUjo94ONpcuCX4tIziTBA8Eh?=
 =?us-ascii?Q?gX+sz2S75JA61BS6HNUJml1SOvJ5U0YkS2Ua/meHJVcKE7uAsRD2NbS2o+LN?=
 =?us-ascii?Q?axmHcyHJER5ZOJH5bsgN8/vF7IgCXy9zgODWHmdAws4ntMjEwI/8KibNE/sX?=
 =?us-ascii?Q?6qHFUdsuCPmZOXKXPAmv8xXbHt9dhmUhLR3nXvnyiMZvXXtvbm5QNl5ecyBc?=
 =?us-ascii?Q?XEZtYkpAh4dVUu++Qk/g1e84RIMI0MYOh8yop9c7EsdFlfmn6wa/Ci8CX+uW?=
 =?us-ascii?Q?LUdvzVl1brskfWcz+5ZVojdzEjIGERexjDKqbxEAg9MxgwN3DShMXMDz0LCF?=
 =?us-ascii?Q?S4nauSmResvAhvTxnxFHFnts68Do4Ay3BNXqfpqHmKyOTQsxfrNbPC90Yfja?=
 =?us-ascii?Q?StTtqY2of5kQ9DxDQRkHK+uljrC1BZYuFXTnhfJ7JbAx2keZYRAMA63va/cr?=
 =?us-ascii?Q?SkZZQYLaNT74WhfJH4vc6q1yGB/sPfrg1nExXKjJJkxJqsnaleLi4HTk1wnk?=
 =?us-ascii?Q?zitqtIID8GbL7Z/5OfjjR9dA+nxBUNRZhPHvSTAKV6iiGSRfnk+n6Tz4nDKR?=
 =?us-ascii?Q?jOTZFegMPbLcegu3t1knyoN1M5z5rxj2JnqtXJpfJufWe2MRfp/vQPjPxMqS?=
 =?us-ascii?Q?ryR8/NzAh150pmFkkwW+oUwEFMv13e90bATx+k5hJSpf+V8hiwxRsNHI+wOz?=
 =?us-ascii?Q?P5rOFzzRFvWUJykAWW4nvxnt4TZq0deqUr6PljF+YPWeeL45usb/vczKWeUa?=
 =?us-ascii?Q?zXo05cKtUmoWzYweSC08ZDr/6d0Fx8JksxOE5L4rGIZOBHVPSIlLOBqNogvh?=
 =?us-ascii?Q?MUs29aoZ5wEq9iuuGVEwBysdtbJ7K62Mdb/QC073qIB+3qC8zeKPS/sufZdi?=
 =?us-ascii?Q?xw8n2PFxg2Krk+hCtwjzKn544TdO0eiFP2Oxd93Z2KoG6m8YS8r1FsAopsSy?=
 =?us-ascii?Q?APbHF/yhN9YOzN6CKZQUIF7RiH8vtFtFi5PESX4H5nj3muSjvvnTk+levWRN?=
 =?us-ascii?Q?mfYIo8QIpin9tXldAvo5aq8+edW4zRbw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 10:49:14.7037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2409bb-06f2-4920-c00b-08dce0745c38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7500
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Implement sdma soft reset by sending MSG_ResetSDMA on smu 13.0.6.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c              | 15 +++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h          |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 10 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h    |  6 ++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h     |  3 ++-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 16 ++++++++++++++++
 6 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 9dc82f4d7c93..9e7a652d119b 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -700,6 +700,21 @@ int amdgpu_dpm_send_rma_reason(struct amdgpu_device *adev)
 	return ret;
 }
 
+int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret;
+
+	if (!is_support_sw_smu(adev))
+		return -EOPNOTSUPP;
+
+	mutex_lock(&adev->pm.mutex);
+	ret = smu_reset_sdma(smu, inst_mask);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
+}
+
 int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
 				  enum pp_clock_type type,
 				  uint32_t *min,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index f5bf41f21c41..41fb6ef984bf 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -597,5 +597,6 @@ int amdgpu_dpm_set_pm_policy(struct amdgpu_device *adev, int policy_type,
 			     int policy_level);
 ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev,
 				      enum pp_pm_policy p_type, char *buf);
+int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask);
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 4a6b4ad97f06..590d004046ef 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3820,3 +3820,13 @@ int smu_send_rma_reason(struct smu_context *smu)
 
 	return ret;
 }
+
+int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
+{
+	int ret = 0;
+
+	if (smu->ppt_funcs && smu->ppt_funcs->reset_sdma)
+		ret = smu->ppt_funcs->reset_sdma(smu, inst_mask);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index b44a185d07e8..5487d9d84a4d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1371,6 +1371,11 @@ struct pptable_funcs {
 	 */
 	int (*send_rma_reason)(struct smu_context *smu);
 
+	/**
+	 * @reset_sdma: message SMU to soft reset sdma instance.
+	 */
+	int (*reset_sdma)(struct smu_context *smu, uint32_t inst_mask);
+
 	/**
 	 * @get_ecc_table:  message SMU to get ECC INFO table.
 	 */
@@ -1630,6 +1635,7 @@ void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device *adev);
 int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t size);
 int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t size);
 int smu_send_rma_reason(struct smu_context *smu);
+int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask);
 int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
 		      int level);
 ssize_t smu_get_pm_policy_info(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index e71a721c12b9..855eb57c734d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -275,7 +275,8 @@
 	__SMU_DUMMY_MAP(RmaDueToBadPageThreshold), \
 	__SMU_DUMMY_MAP(SelectPstatePolicy), \
 	__SMU_DUMMY_MAP(MALLPowerController), \
-	__SMU_DUMMY_MAP(MALLPowerState),
+	__SMU_DUMMY_MAP(MALLPowerState), \
+	__SMU_DUMMY_MAP(ResetSDMA),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 52f3c537bb3f..6ca9bc6660cb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -182,6 +182,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(SelectPLPDMode,                      PPSMC_MSG_SelectPLPDMode,                  0),
 	MSG_MAP(RmaDueToBadPageThreshold,            PPSMC_MSG_RmaDueToBadPageThreshold,        0),
 	MSG_MAP(SelectPstatePolicy,                  PPSMC_MSG_SelectPstatePolicy,              0),
+	MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,                       0),
 };
 
 // clang-format on
@@ -2697,6 +2698,20 @@ static int smu_v13_0_6_send_rma_reason(struct smu_context *smu)
 	return ret;
 }
 
+static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
+{
+	int ret = 0;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+					      SMU_MSG_ResetSDMA, inst_mask, NULL);
+	if (ret)
+		dev_err(smu->adev->dev,
+			"[%s] failed to send ResetSDMA event to SMU\n",
+			__func__);
+
+	return ret;
+}
+
 static int mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
@@ -3342,6 +3357,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.i2c_fini = smu_v13_0_6_i2c_control_fini,
 	.send_hbm_bad_pages_num = smu_v13_0_6_smu_send_hbm_bad_page_num,
 	.send_rma_reason = smu_v13_0_6_send_rma_reason,
+	.reset_sdma = smu_v13_0_6_reset_sdma,
 };
 
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
-- 
2.25.1

