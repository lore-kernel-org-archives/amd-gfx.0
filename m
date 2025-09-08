Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6F0CAC581
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 11:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE94010E4C1;
	Mon,  8 Sep 2025 11:03:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vWXGav+h";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E34210E4C1
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 11:03:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/oC10qrq4zf+ZrSkD91Jxh8vYaaulYKOKe4o9u+ke96OjZyujGaB79KxP+X/QMFWpPM2el8Ql7ms3a9jMFm7X6PhPa5Ig2t4sEfa4Q8DRmeD4MDHTK8f793e+UChAmMIPgAhhmPypCAyy5/DCvLnVL/LT/+WkIr32w1OeezZlRUAgroCVZGpPQuRQhgE8skdpcq+z9jHwpyAditJdXLowUDEuyPCL+LEe/0Xg8AKMJNWhurD6wfXi63wAPcacrhh56owwzSVj3y8OLKMINNDla6ZpZ5NCK16kEDbKJ99sW6sPw/7XEHqFQZhWd7UNF2sdc69Ip71sLbmBkGRpO4lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKpNThBteXDfNviJkoichfI95hITAEe+SEOi5vcuZTU=;
 b=xKHCNbudpwFHcF/i+bgKAfsA/G+IL3cqThJaO08PLVaQqgEaiEXtt5g9wQD/f+XVhcHe0k9qfvdJCljBErFvcTCnDmlNfO9qLM1IHeLT7VdRdLcaerl6GAlwRvfdqOK49XBzE4GGn+FFCI1IppxAYR5v9MVZaA4uCUjO70pzxVUnMW+VGlnR3uekw6scJoHqh/QrY/+PtlSddfGtDWDBCc1gJD5dpVocC0slQloCuFokeklPP43TJkZTi2RiE4KMVBBm5taw0Js9uOIdDgj7TieuP0B58H3kqEx3sCUQtgKqvHeOg7O5rh/ZLjceglZHuxxleoV7o6MkriW2CKKbKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKpNThBteXDfNviJkoichfI95hITAEe+SEOi5vcuZTU=;
 b=vWXGav+hJNVruirbDhFq08vB1uysVbE4AeHT9gvNhgUtYSOBpUHbZimgBjcgwhdQSDIHhXq+hnFbXgIG7CB316feK9vFVsanHNAWT4vke0iSW4mOJllnP42uLlgq0bLrFlJnh5ezRyVcqJd6LYxz2qcFoC7fIciff2dMqX62KqY=
Received: from MN0P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::35)
 by BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:03:07 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::ae) by MN0P223CA0018.outlook.office365.com
 (2603:10b6:208:52b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 11:03:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 11:03:06 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 04:03:04 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH v2 6/7] drm/amd/pm: Update SMUv13.0.6 partition metrics
Date: Mon, 8 Sep 2025 16:31:17 +0530
Message-ID: <20250908110231.2888628-7-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250908110231.2888628-1-lijo.lazar@amd.com>
References: <20250908110231.2888628-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|BY5PR12MB4322:EE_
X-MS-Office365-Filtering-Correlation-Id: c7ff3c63-7451-4268-100d-08ddeec74a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/TVPuLDLTiUec60Crplg6cccmGQP9Ck9WotkGsBQVyNB+c9GclEGH2nOk4gM?=
 =?us-ascii?Q?8Y0YiFnkFgFb48vNtehDQa8r9LNpkbLhxja5QS2NyQoPq4mzFmtr+0ChMihR?=
 =?us-ascii?Q?1l1zsxTzaoV1Pu+g+EwQrSPkXaRx3tAWFZhkp0MrxI57cFbgvlvwrfhwX7IS?=
 =?us-ascii?Q?dTQ6b+o/v27gLSTtRG28CqBJqZVJ+8xPcPNnGmo7hovcHKcgcO+Xu3NZp9Xe?=
 =?us-ascii?Q?jBLzM8G17Msa+pH7WqBKIk5P0FZQH3RA2enIfo49abCb8rOILQBZN18Oa4qU?=
 =?us-ascii?Q?qvfYJbllfc9mAe0mHUB1s1jQzlw7Lf5aj59u/QVy9yejhQmh5eXllOjmMJw2?=
 =?us-ascii?Q?7G+bTGIsb2xh0BwGLezj9S9eUS0lWPT3gXITgOFltNToA8MMA56VylI+imCM?=
 =?us-ascii?Q?zwoEaRgN9a754Vm8tJFWqIy+qH/Bi+/gPOcNuRtOypyI54O9sfgK9lvVK53K?=
 =?us-ascii?Q?7CaWF/I+rR2NPxU0MwMnAdnFfVOiye/L6ZUf41yF6fBvc3wBCAOUTKG8OeLR?=
 =?us-ascii?Q?2ooTpuLn5MORwz9t/s5Frylf5sitEuHWQOED7016eokof6Qn6LM9/7Bpxm8+?=
 =?us-ascii?Q?MMXx2ZI0gEdpDQL/OjJ5N+VNV07sIF1YEQEWj0wnIJB8jVpowKOR3ytqTKVP?=
 =?us-ascii?Q?ElVL4pu4oyTva4CYCJwdwA6bQFwEW+pa7I0//lE0rB0hwB+wsQO5b9EZI0rr?=
 =?us-ascii?Q?0AsUD3oIhKkmUiJ7VSug0nJA7wDnqcBktTtgFTAlWp6nd49d65opQ1Vud079?=
 =?us-ascii?Q?HZkss7EXeZ7RQM0xcCeq6Xe74UVbOcxD5wQ09ObggYsfDLpl/n8Lxrh6Runu?=
 =?us-ascii?Q?3sXc0SEC4Ag47KF7CH6U80J4Wcogzwt4ATgBd5Fi/XEHK2FUZQusQCLb9zNU?=
 =?us-ascii?Q?2xOaz6patyPVPgIlIZlmD9juHzFsQ9EfEkpMPE2wRa5q/mhFRl8qjp23Z99i?=
 =?us-ascii?Q?4t5hPYseLBCTez+p+Bqqn5iPtU+oGqW4PXEJpLc+wSH5Z3K9PuYTta7AxG6f?=
 =?us-ascii?Q?TSBun/LH+Fxp/HTS6YZknGiCtxuEEpbgJViC+AHHs8OLnQqiiMoKaIfKT3zD?=
 =?us-ascii?Q?CK7QOuq/p+Nre4XOUajpynZOxnLACqTWqZC+6QboSZRG09jpryOM+1L3GgO0?=
 =?us-ascii?Q?0yiTg5RfaGcUzB/SisM9GZcmlfnmUZkQ8Ba9/whYcCpaCyZ0Zy2hLOF332zX?=
 =?us-ascii?Q?6QHpNc8e+TANK0sGa5yEfB64v8ITBH4faVERB8ILR4WPqTHP8CWnnZuE+yxP?=
 =?us-ascii?Q?StXDM9rbpXjlmpltyniTlhjEQM6o1BEhVEyoZ1BLJOoCD3XUR/D83GuzmRQP?=
 =?us-ascii?Q?xDZAGRt+XZXGL57qjziit42B3ui0OLv1okMeHnc81wH7NP3xF200qCz8QUCj?=
 =?us-ascii?Q?M5UoQ2glKkvoMHEaVTQfonjwRlYvJLwVQwapfiPtOuUAEuFOqZyc7wna03fU?=
 =?us-ascii?Q?WVdZa0OwbsLpaJUcyZZuPIHhUElPm1PTLH/VQ15cGVMvVbUQjtVwHEHXK2K8?=
 =?us-ascii?Q?RUjJ8WApOfuO4vLnqNfXYD0/ThPM7sjSRdsX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:03:06.3742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ff3c63-7451-4268-100d-08ddeec74a04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322
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

For SMU v13.0.6 SOCs, move to partition metrics v1.1 schema

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  6 ++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  | 34 +++++++++++++++++++
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 8eaa81dd7f0e..03cecf3da557 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2628,7 +2628,7 @@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct smu_context *smu, int xcp_id,
 {
 	const u8 num_jpeg_rings = AMDGPU_MAX_JPEG_RINGS_4_0_3;
 	int version = smu_v13_0_6_get_metrics_version(smu);
-	struct amdgpu_partition_metrics_v1_0 *xcp_metrics;
+	struct smu_v13_0_6_partition_metrics *xcp_metrics;
 	MetricsTableV0_t *metrics_v0 __free(kfree) = NULL;
 	struct amdgpu_device *adev = smu->adev;
 	int ret, inst, i, j, k, idx;
@@ -2648,8 +2648,8 @@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct smu_context *smu, int xcp_id,
 	if (i == adev->xcp_mgr->num_xcps)
 		return -EINVAL;
 
-	xcp_metrics = (struct amdgpu_partition_metrics_v1_0 *)table;
-	smu_cmn_init_partition_metrics(xcp_metrics, 1, 0);
+	xcp_metrics = (struct smu_v13_0_6_partition_metrics *)table;
+	smu_v13_0_6_partition_metrics_init(xcp_metrics, 1, 1);
 
 	metrics_v0 = kzalloc(METRICS_TABLE_SIZE, GFP_KERNEL);
 	if (!metrics_v0)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 1b449ab2d89f..ee1bc8535a9e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -213,6 +213,40 @@ void smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table,
 				  void *smu_metrics,
 				  struct smu_v13_0_6_gpu_metrics *gpu_metrics);
 
+#define SMU_13_0_6_PARTITION_METRICS_FIELDS(SMU_SCALAR, SMU_ARRAY)             \
+	SMU_ARRAY(SMU_MATTR(CURRENT_GFXCLK), SMU_MUNIT(CLOCK_1),               \
+		  SMU_MTYPE(U16), current_gfxclk, SMU_13_0_6_MAX_XCC)          \
+	SMU_ARRAY(SMU_MATTR(CURRENT_SOCCLK), SMU_MUNIT(CLOCK_1),               \
+		  SMU_MTYPE(U16), current_socclk, SMU_13_0_6_MAX_CLKS)         \
+	SMU_ARRAY(SMU_MATTR(CURRENT_VCLK0), SMU_MUNIT(CLOCK_1),                \
+		  SMU_MTYPE(U16), current_vclk0, SMU_13_0_6_MAX_CLKS)          \
+	SMU_ARRAY(SMU_MATTR(CURRENT_DCLK0), SMU_MUNIT(CLOCK_1),                \
+		  SMU_MTYPE(U16), current_dclk0, SMU_13_0_6_MAX_CLKS)          \
+	SMU_SCALAR(SMU_MATTR(CURRENT_UCLK), SMU_MUNIT(CLOCK_1),                \
+		   SMU_MTYPE(U16), current_uclk)                               \
+	SMU_ARRAY(SMU_MATTR(GFX_BUSY_INST), SMU_MUNIT(PERCENT),                \
+		  SMU_MTYPE(U32), gfx_busy_inst, SMU_13_0_6_MAX_XCC)           \
+	SMU_ARRAY(SMU_MATTR(JPEG_BUSY), SMU_MUNIT(PERCENT), SMU_MTYPE(U16),    \
+		  jpeg_busy, SMU_13_0_6_MAX_JPEG)                              \
+	SMU_ARRAY(SMU_MATTR(VCN_BUSY), SMU_MUNIT(PERCENT), SMU_MTYPE(U16),     \
+		  vcn_busy, SMU_13_0_6_MAX_VCN)                                \
+	SMU_ARRAY(SMU_MATTR(GFX_BUSY_ACC), SMU_MUNIT(PERCENT), SMU_MTYPE(U64), \
+		  gfx_busy_acc, SMU_13_0_6_MAX_XCC)                            \
+	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_PPT_ACC), SMU_MUNIT(NONE),    \
+		  SMU_MTYPE(U64), gfx_below_host_limit_ppt_acc,                \
+		  SMU_13_0_6_MAX_XCC)                                          \
+	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_THM_ACC), SMU_MUNIT(NONE),    \
+		  SMU_MTYPE(U64), gfx_below_host_limit_thm_acc,                \
+		  SMU_13_0_6_MAX_XCC)                                          \
+	SMU_ARRAY(SMU_MATTR(GFX_LOW_UTILIZATION_ACC), SMU_MUNIT(NONE),         \
+		  SMU_MTYPE(U64), gfx_low_utilization_acc, SMU_13_0_6_MAX_XCC) \
+	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_TOTAL_ACC), SMU_MUNIT(NONE),  \
+		  SMU_MTYPE(U64), gfx_below_host_limit_total_acc,              \
+		  SMU_13_0_6_MAX_XCC)
+
+DECLARE_SMU_METRICS_CLASS(smu_v13_0_6_partition_metrics,
+			  SMU_13_0_6_PARTITION_METRICS_FIELDS);
+
 #endif /* SWSMU_CODE_LAYER_L2 */
 
 #endif
-- 
2.49.0

