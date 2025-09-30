Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CE7CAC5B9
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Sep 2025 08:26:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E75D410E291;
	Tue, 30 Sep 2025 08:26:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LWyZjM5m";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012049.outbound.protection.outlook.com
 [40.93.195.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0612E10E291
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Sep 2025 08:26:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ulm8vpQO8KjTt7eqA+29hrZ5HD4KW9GG+rfIPK7Xy5tqQ+NB2H8W8KCgf/P0J35fTGEP0hf/5nzFtqbWSIG9oCvh5wLhDd8VI9aPd+GwvjisXT4PIOEqOT7X8Q1URdDPWPQcxXk/agOFzhFzcTsyL53Rww0vNXjXD5QONOZYprdHFVA8vOSmq+qB/4hV2zmwC6xUGiVaks3PiuRDJlYX5i3Bp0UU7qgdlSvR3kp7rMLn5znzQuEDA+SL4ONBfhfOiaFhCDp4KTnUvVTRKGHUJ1pp13kfknr8RPmUtzJsufSipUtJbeLvHBzQOx3HH2ONrQEB0LkfXYfdUYr6UeNo4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/H3P3GYa9Ef2s0nSM5/l8U93LP+2IlGjI0/0Hlg2kA=;
 b=tYTfvfocu8JU2BXe0l/rOMouRYplaEwKzMg/XbssptZ6kgFRXYoXVTWu3tCA4L86dWR29JoBOTvh8a0yvcQkUO0qdD4Bsqr/m69BNjH5J7t5R73hJdRUdJ6QHqtqFQmcgO6yOAFDFWuHbP/Yl1ah71J/vG2HWI8dm5K6+hSKyV8husIQCX9GVfmowoBu4occ0/VGGF9t5KBXb+K1JDymHE7dLda52GZODSFiq73JsK75pTbeYuzUHGrYxlEextN9nrG8bJoi2GSC7L8IHy7goWQavRpObKnI7tACziqR85XZBvj+8gdcdQxrawKhx1WAmTuDn94u1jMKJu3d3kcISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/H3P3GYa9Ef2s0nSM5/l8U93LP+2IlGjI0/0Hlg2kA=;
 b=LWyZjM5muri0UejYU52nyj4rix3k/kKrnge4evNX0IC/rFV+74WL11oUOO9UW9M2potrgUU0jE65886mUYhHG72LDCA/1gLlEhDHSBKvZqFrbJHLFT/UOxbcSeLywvE7y/y89S6bLhMfNyLWSn9PlT0PUiXA0WVwsbdK1CsQNzU=
Received: from BLAPR05CA0007.namprd05.prod.outlook.com (2603:10b6:208:36e::7)
 by CH3PR12MB7739.namprd12.prod.outlook.com (2603:10b6:610:151::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Tue, 30 Sep
 2025 08:26:49 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::a6) by BLAPR05CA0007.outlook.office365.com
 (2603:10b6:208:36e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Tue,
 30 Sep 2025 08:26:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 08:26:48 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Sep
 2025 01:26:46 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>, Yang Wang <kevinyang.wang@amd.com>, "Tao
 Zhou" <tao.zhou1@amd.com>
Subject: [PATCH 1/3] drm/amd/pm: export a function amdgpu_smu_ras_send_msg to
 allow send msg directly
Date: Tue, 30 Sep 2025 16:25:23 +0800
Message-ID: <20250930082525.118197-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|CH3PR12MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: 915b0b57-c48f-4605-7e39-08ddfffb19ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q+JQOToCiV0SV6bCQvClSnouAM8yWHPk3uH9AJSvHFM5C55GBr7vcVHMqYV5?=
 =?us-ascii?Q?YAtSiI5zuuYnJI+YPM/bCh6qC8N1P8KT53YhHO4jFllcqtL3rNiig2wMl890?=
 =?us-ascii?Q?SMmA/g16Q1idbxfY6SJzNCG03Ee0TdfVBk5p1wVHdYWV6kkErlbVfuSHuNWk?=
 =?us-ascii?Q?/D/sJyk+i3Gq0z8aVFlgP5IBT5zwTKqPYeeRPL5sh8+g/roLli9p0ExpLpQo?=
 =?us-ascii?Q?017MYJ8Xt4BEkd69s80FYEVKHCSOJMPp2gSkSKiQPVv1zV9UXkzOMWc9U4vP?=
 =?us-ascii?Q?iJlbQjRQTAKTRDjA5c69dxKWec5OdCy816VW2tULPTKKAf5QVcSIdpLQUDNM?=
 =?us-ascii?Q?4GJkX9qK0Rf77F16yIZVDj0LZ4WQbPKyMt7rxcRlYlzS+CMVKiGPBOy65MU1?=
 =?us-ascii?Q?5GKioKcybrJa3xvUi/CZpxf+YEpmE1Ee00vMfTjYAOp9Ok/UPRuRSRRAgq5F?=
 =?us-ascii?Q?tHnVef+GoFyCiA5fA2LWk89y0fzAQjeHF8nu9LlKXxHD2eZ0oqiI1GWB0amW?=
 =?us-ascii?Q?IvE7mEmx6pHJICP+L8zNMkcTR6p5iB9JSSbHSsKtWjl8fojo8Bw6PQTz6xAM?=
 =?us-ascii?Q?bKtyTt5Ma7xr3jbbmhdEC967KncG9tsUa/Rhfenlk76LeQalA2xqfCVFVQXE?=
 =?us-ascii?Q?wI7WUaPcv3OGtijUHW9gZ4BFwit+V3rPRYWkgKh6tKjkKwU7Kfn5ily2F2ki?=
 =?us-ascii?Q?j4GCQAEU/VF4+MCI/gJll4pLHkjqnePDzGqxx9oHluWaczguILcbB82r6IQ5?=
 =?us-ascii?Q?NRfSTwhMBPQLSqR2XBu/u9/y6PBPoAmSpDSyP+J/fwxJ0WZZG6nBaxhRrpSs?=
 =?us-ascii?Q?hjHsD6m8mx8LSHEyYKOAKZmlSbCI12Gi6B1C8H9ltXkgldhDEe/2SLRXvuY4?=
 =?us-ascii?Q?4tdLJw9Cne5+h9Klt0mgdKLnB3mP5OMu4kPzlFXKm02X9vcmDB+ozlt/KjQ9?=
 =?us-ascii?Q?EAF9rpeW19J62GhJH58jOnFjXUXNJ+zZWiXTdZna5hy1VOZDfWD9loilSAH1?=
 =?us-ascii?Q?ext2b//w966hg6uHjxsgMo/rwWEJ9qCpbrfVU+Ex4OY/T7HzROcJIYTh0pO6?=
 =?us-ascii?Q?nJlhv0yCTJsanlS+WmbtV/hqvg/nNnQ3IHGpaW8w8trtrK7gbQ2nz2zW2WzJ?=
 =?us-ascii?Q?Xhx1RJJM2B41tHtCpwaZ/RXgXtimkvdpxTHi/a5yKRKwsyvOLnZ7kOcmwc48?=
 =?us-ascii?Q?4D/GrK7dWdpr2PF93ZiOV5ReAoHN/6Ri4rKlwqA2nMM0oa0lKJZnmtxA+fX8?=
 =?us-ascii?Q?tLoePF6QzsuQ2flWL6jUKtXogtxU7Gj2pPCOPyFfJIrA0asbBURBSih9bmsm?=
 =?us-ascii?Q?iEZRRu+JwDo/YW83b1+hMqot3mW+bCu+0VvXFFi+JAXSwboXXVzkaKoYN5Vh?=
 =?us-ascii?Q?xMZRutWHld6jKMwWps7GVOmnCr/U7UdyYFHqd0MW/htFFQ7rXM2g/idmrx1+?=
 =?us-ascii?Q?dvLxProUEvDe+YYPuIh9l5LyhZb1lbCwjNUCPwT4eBnuXNXyhzKuEZg3Z1uK?=
 =?us-ascii?Q?Rw3UmjrV7yT4wrdtVOyentCg8lKqOYyP//APKGPbI4gc2yqOGGua7JC39soP?=
 =?us-ascii?Q?uLP5BLsb2fE3m4pcq+o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 08:26:48.9581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 915b0b57-c48f-4605-7e39-08ddfffb19ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739
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

provide a interface that allows ras client send msg to smu/pmfw directly.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 11 +++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 11 +++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 19 +++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index fb8086859857..6cda01ce6a64 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -609,6 +609,17 @@ bool is_support_cclk_dpm(struct amdgpu_device *adev)
 	return true;
 }
 
+int amdgpu_smu_ras_send_msg(struct amdgpu_device *adev, enum smu_message_type msg,
+			    uint32_t param, uint32_t *read_arg)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret = -EOPNOTSUPP;
+
+	if (smu->ppt_funcs && smu->ppt_funcs->ras_send_msg)
+		ret = smu->ppt_funcs->ras_send_msg(smu, msg, param, read_arg);
+
+	return ret;
+}
 
 static int smu_sys_get_pp_table(void *handle,
 				char **table)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 582c186d8b62..87d855b76e61 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1521,6 +1521,15 @@ struct pptable_funcs {
 	 */
 	ssize_t (*get_xcp_metrics)(struct smu_context *smu, int xcp_id,
 				   void *table);
+	/**
+	 * @ras_send_msg: Send a message with a parameter from Ras
+	 * &msg: Type of message.
+	 * &param: Message parameter.
+	 * &read_arg: SMU response (optional).
+	 */
+	int (*ras_send_msg)(struct smu_context *smu,
+			    enum smu_message_type msg, uint32_t param, uint32_t *read_arg);
+
 };
 
 typedef enum {
@@ -1786,6 +1795,8 @@ int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
 ssize_t smu_get_pm_policy_info(struct smu_context *smu,
 			       enum pp_pm_policy p_type, char *sysbuf);
 
+int amdgpu_smu_ras_send_msg(struct amdgpu_device *adev, enum smu_message_type msg,
+			    uint32_t param, uint32_t *readarg);
 #endif
 
 void smu_feature_cap_set(struct smu_context *smu, enum smu_feature_cap_id fea_id);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index cbe5b06438c1..126efdbc0f02 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3227,6 +3227,24 @@ static int smu_v13_0_6_reset_vcn(struct smu_context *smu, uint32_t inst_mask)
 	return ret;
 }
 
+static int smu_v13_0_6_ras_send_msg(struct smu_context *smu, enum smu_message_type msg, uint32_t param, uint32_t *read_arg)
+{
+	int ret;
+
+	switch (msg) {
+	case SMU_MSG_QueryValidMcaCount:
+	case SMU_MSG_QueryValidMcaCeCount:
+	case SMU_MSG_McaBankDumpDW:
+	case SMU_MSG_McaBankCeDumpDW:
+	case SMU_MSG_ClearMcaOnRead:
+		ret = smu_cmn_send_smc_msg_with_param(smu, msg, param, read_arg);
+		break;
+	default:
+		ret = -EPERM;
+	}
+
+	return ret;
+}
 
 static int smu_v13_0_6_post_init(struct smu_context *smu)
 {
@@ -3922,6 +3940,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.reset_sdma = smu_v13_0_6_reset_sdma,
 	.dpm_reset_vcn = smu_v13_0_6_reset_vcn,
 	.post_init = smu_v13_0_6_post_init,
+	.ras_send_msg = smu_v13_0_6_ras_send_msg,
 };
 
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
-- 
2.34.1

