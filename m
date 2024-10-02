Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4ADCF3195
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 04:38:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EAB710E683;
	Wed,  2 Oct 2024 04:38:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n+CVoewk";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13E8C10E683
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 04:38:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2V8isae0HF1r82+1CjrnQMGMZVEE3PQfU/bMQhlG83WnQu1L+wiojI+jAIYcM65s+XL1mQVc6qsKdFEtO1yTZS//Be/lvQE0wIRrJOfskSsoQmel8OdoNHgFAIj+/ZVhs7Wh3hbkFqrTVYm7elvXnwHGsChr7yMTppJZQCJmDfOQpMdgvDqmmSrVfjdF5ZIiFYcp4aaXY7mLikEk8bVj0GlsJHHTvOgG7UTLDlysqGx8mBrgKNhOLPxr8jo4m5rLNYK/yqO0V+U8qPYJHij/Y+0Sfz1SeGVt+C0fTv6RKClbASwDmRqJWFGZqb2gARzwA3i4ShHbkysTntRQffdxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0igN8eTYnXMLFYYkesWYLzwRPp4rY4/JSsWfdcDuDY=;
 b=gB88OSujQ4+Dhn46UpffxaR1B6z6F+ksfL7RSWaTNh1fVhLuyntdfGac1hUaRSOYGCle5D6IPCOxnx8EqtcqG59sKI/Se9uS0cMzxhDrgph8u+SkmeGxaGi2R9xuZOCKu/iT4hXv/Pb2Nd0lHa2pPG8zTkdMrxc+6FY5gplpn9Uc0LuIeS4Jkt+w8yNgEUWPcO7KsxSW5CcksQ5wc9gSzq9vX0s6xGwpcaspyBiErKfNk7NOBWFfaSugw0j9Qz8CxYvr+heQvQA/4b6AqcTMj7VHyN8yc17CpmEPwFjuakVPXL5bQQMX/dc3DAms5VD3MdOKue2pi7QSlSN2kghbhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0igN8eTYnXMLFYYkesWYLzwRPp4rY4/JSsWfdcDuDY=;
 b=n+CVoewkf1njxri5U8B/nEgenFaIgqryVOs4W0tiymJfHcNaRJuIhTy0WgX4xoYEm5k+NFpMTAxu2V/CrzgNE9zmKm3YYqZR4c72CjyKpewTAdgBxCioBehWO6sIinEPQNkFcpGqeQNqz743hszLJQEhnZGTVyU6UUvCshxLO6Y=
Received: from MW4P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::27)
 by PH0PR12MB8821.namprd12.prod.outlook.com (2603:10b6:510:28d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Wed, 2 Oct
 2024 04:38:48 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::b) by MW4P222CA0022.outlook.office365.com
 (2603:10b6:303:114::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16 via Frontend
 Transport; Wed, 2 Oct 2024 04:38:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 04:38:47 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 23:38:44 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 02/18] drm/amd/pm: enable vcn by instance for smu v13
Date: Wed, 2 Oct 2024 00:36:11 -0400
Message-ID: <20241002043627.102414-3-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002043627.102414-1-boyuan.zhang@amd.com>
References: <20241002043627.102414-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|PH0PR12MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a25165e-b92d-421a-491e-08dce29c1b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7qNQgPgZGZsHYkFhJXT8bd48lNWfL/4ScTJqEbtMPphhsP55vM5yQfFoeRHR?=
 =?us-ascii?Q?O6WPAIAqtX05ycprJRYIgGY2zOp3YRz0Jre5WV9I6ixCPGjMWIiIDZtmBHfw?=
 =?us-ascii?Q?1A1cy3yjbkl3eU7N7mFg8rICalrdgvhX3k2ENx4UPfr7vFhUuxD++e6W9e1/?=
 =?us-ascii?Q?DM88TgfmAjpPlHU22X1aR3rI9CkhkUF5G/F8vHNeeNb0KJVEvP41TamN7vZ+?=
 =?us-ascii?Q?cLbBjdxVomRjzb/DoDHYzGdH7L/JrDErk3lO5H+qHNFnA3vpf/FIG1IwuMGG?=
 =?us-ascii?Q?7q/wOk6chnzIn7A1jCnssluBs8DaF7+aFAxNnQF30AhNEI/zZ2Lu+tMeU/3W?=
 =?us-ascii?Q?mhXHCnQuCQ+8nvMkhN+Ls7/zUs6i2m2YODk91w7aFJWFqc1/ypqqdcWngn4V?=
 =?us-ascii?Q?vdBQMsk6kdhisbHPoeXOmasU+vEoGtQSr4Qepx6YQWfLXj1JTT4ASejlszi7?=
 =?us-ascii?Q?ivNyCd1W9OvJONCP6yvV2Z1sA4zIoF4RHxGx6l6OaHDodXVOMmVwZOgBYRnp?=
 =?us-ascii?Q?jHgpY28miCsLgMyBMjRLkq1lqAeAg+s4+YGJfkWU30xwVsQAmXl6/u0tCg6z?=
 =?us-ascii?Q?gL+IXww+IXp7gZ8LLb1oR+xbeUh7QXkKM9M8DqDUGwrTQMDaywjOGR67coxI?=
 =?us-ascii?Q?XPe8DLMccpoDUEesj4fTIOsCq9cCPPMEXzwlmvFpc7fDhahJzqiH/4J6M5TL?=
 =?us-ascii?Q?0sBTbe3msd46P6s+UsfYt9yVVdQu8fyo3JOYcopuaD6jd8HVb27WAvIhfvf3?=
 =?us-ascii?Q?zw+5/KkMHnPjYGi36fQ8cplbuS6O722A/svl/Iadw8KYEnnT0we0SGYeOMqD?=
 =?us-ascii?Q?rxlnJjiZUVXHFqxXy/FJWLK8rm/N69GM2CVDWFBsD+NTu6Hdv7sYYU9En4xX?=
 =?us-ascii?Q?Eix3YPm9uUiGMqS2ox5ec6acY5Gurq1LCssmq5Q5JgaFrrx1oBt9K4uwcylF?=
 =?us-ascii?Q?MuVkTOcSVZEW/jwmlriTuDQ5cWLrUURt+LNK9gBoYV8adjIY2YhMeqWk3xPJ?=
 =?us-ascii?Q?2J5FJZ97jmquxhdP4X5QWKZ28XYJoV5SsmOedzQ+D8fpFCo8KARC4Q7A/RfC?=
 =?us-ascii?Q?UrtQsbptFDQasgL/tq79KEjNGQczVHp7kjgR0NYEeqwpXKtkfT7Rox6/vsG/?=
 =?us-ascii?Q?/OuUcHlIM1OnMwTlDotc4+qnZRpilpz9YudqN2FRYGod18/qHnxpQOYi8u8q?=
 =?us-ascii?Q?7jrEb2b3pOxkRZq7cJc5p05qJbVTy4mZPy3kMHXE9AgHrIdEXew+xi2so8vV?=
 =?us-ascii?Q?FkJEBLK855egCaonaXgf4IDvXwPlsbj147Um44Qdviwq31FmdFbg+mNnG5Uz?=
 =?us-ascii?Q?/62VOMk6ZmGTbED2++rC/GgHuokzsplCBSJKQVwR/q/T230XgzoQVcl4dj5H?=
 =?us-ascii?Q?QpidBSN0d48DO824chQrSwFZUcc/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 04:38:47.7155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a25165e-b92d-421a-491e-08dce29c1b2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8821
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

For smu v13, set vcn enable or disable by the given instance instead of
setting it for all vcn instances.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  5 +++--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 21 ++++++++-----------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  2 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  |  2 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  2 +-
 5 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index e58220a7ee2f..7b4761ad1902 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -254,8 +254,9 @@ int smu_v13_0_gfx_ulv_control(struct smu_context *smu,
 int smu_v13_0_wait_for_event(struct smu_context *smu, enum smu_event_type event,
 			     uint64_t event_arg);
 
-int smu_v13_0_set_vcn_enable(struct smu_context *smu,
-			     bool enable);
+int smu_v13_0_set_vcn_enable_instance(struct smu_context *smu,
+			     bool enable,
+			     int inst);
 
 int smu_v13_0_set_jpeg_enable(struct smu_context *smu,
 			      bool enable);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index e17466cc1952..d87a1e288b0a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2087,22 +2087,19 @@ int smu_v13_0_get_current_pcie_link_speed(struct smu_context *smu)
 	return link_speed[speed_level];
 }
 
-int smu_v13_0_set_vcn_enable(struct smu_context *smu,
-			     bool enable)
+int smu_v13_0_set_vcn_enable_instance(struct smu_context *smu,
+			     bool enable,
+			     int inst)
 {
 	struct amdgpu_device *adev = smu->adev;
-	int i, ret = 0;
+	int ret = 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return ret;
 
-		ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-						      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
-						      i << 16U, NULL);
-		if (ret)
-			return ret;
-	}
+	ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
+					      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
+					      inst << 16U, NULL);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 866dc77d1005..94a23b330d5e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -3028,7 +3028,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.system_features_control = smu_v13_0_0_system_features_control,
 	.set_allowed_mask = smu_v13_0_set_allowed_mask,
 	.get_enabled_mask = smu_cmn_get_enabled_mask,
-	.dpm_set_vcn_enable = smu_v13_0_set_vcn_enable,
+	.dpm_set_vcn_enable_instance = smu_v13_0_set_vcn_enable_instance,
 	.dpm_set_jpeg_enable = smu_v13_0_set_jpeg_enable,
 	.get_dpm_ultimate_freq = smu_v13_0_0_get_dpm_ultimate_freq,
 	.get_vbios_bootup_values = smu_v13_0_get_vbios_bootup_values,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index b081ae3e8f43..18d14f96b506 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -1099,7 +1099,7 @@ static const struct pptable_funcs smu_v13_0_4_ppt_funcs = {
 	.system_features_control = smu_v13_0_4_system_features_control,
 	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
 	.send_smc_msg = smu_cmn_send_smc_msg,
-	.dpm_set_vcn_enable = smu_v13_0_set_vcn_enable,
+	.dpm_set_vcn_enable_instance = smu_v13_0_set_vcn_enable_instance,
 	.dpm_set_jpeg_enable = smu_v13_0_set_jpeg_enable,
 	.set_default_dpm_table = smu_v13_0_set_default_dpm_tables,
 	.read_sensor = smu_v13_0_4_read_sensor,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index f7d7cae16d9b..416ba5efbf1d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2607,7 +2607,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.system_features_control = smu_v13_0_system_features_control,
 	.set_allowed_mask = smu_v13_0_set_allowed_mask,
 	.get_enabled_mask = smu_cmn_get_enabled_mask,
-	.dpm_set_vcn_enable = smu_v13_0_set_vcn_enable,
+	.dpm_set_vcn_enable_instance = smu_v13_0_set_vcn_enable_instance,
 	.dpm_set_jpeg_enable = smu_v13_0_set_jpeg_enable,
 	.init_pptable_microcode = smu_v13_0_init_pptable_microcode,
 	.populate_umd_state_clk = smu_v13_0_7_populate_umd_state_clk,
-- 
2.34.1

