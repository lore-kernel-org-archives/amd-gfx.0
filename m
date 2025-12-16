Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5400D637B8
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6F7510E8A1;
	Tue, 16 Dec 2025 21:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h3FdjsB0";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010005.outbound.protection.outlook.com
 [40.93.198.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB2D610E710
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:04:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpuR4LXSdKSmMqU964grqSA4B68MCPFbz1vp74c3x2+SYUfdonXGrlc6cuTtaMntXuY0s8wNSWcvFnG9MHqVqBXuE2dFQ871WvdSIk/HuBmGk/Xwjly6yKNyrIoY2/tOGKopmbrQmqCWq1zcw5Gj2gr+XWVMt6rdETcF5UmY7Hs2gYx8Jc75gHp5Htq+rpZE5KkzWKBsdRFqlDFZhtilNuSJVS3J81xSsxYiUhem6uHHh+MQ6CYDSLJbLYZKd8i7njVr4okvJcJC8PCAIQs8J3H0lPcvjkJBspsRe2VKMlRBuJDaGT9Vrb0++A80EJcYKoC2n/N4ijh3aqzYj5lHQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0LwPNYMaNIFYA3jxBtjQvSoKYwTtfrwb7keMafpddM=;
 b=fH+9UeaWYyCvgBsdeZ4OkaTsyWBzw+c4Jt+tfOiRkkmvIxJIy4PVASAoWpDYrMPUvDNNdIZqfYDHtx7Ddu4ujo6REaIyFhw5WQSFQweFm3LpjmfpZulWowAaDm1bQnltBdOzO8lJCAgwKtTeVfS33PEP3/RUnT4qlGeoI+bnd3Lvk+UJ3OKUVqKjnfQ+AaM9Brhklb/A6EZO1+rm0PikechENNkfv0LJSViQTEEeqIVAIz+R834mrSWBTKO3qo2u/lQk5cy1pyEC+ks+5gyw09+jeOfShkMEL+8D+UisoTCPbnbWUv+bg2m75YU7cUdE7MpuK378Hcy46Kmx4Hpeow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0LwPNYMaNIFYA3jxBtjQvSoKYwTtfrwb7keMafpddM=;
 b=h3FdjsB0rofmyyM7rhEtPvXNbuNZ4nKBbAA0IUcjC3UCc7U3+CNLuu1Ij22Tqdl8BBYGm1gbv5YwL2Jo15Rn2yet6CicAsbAmLA1Nq5CfhgvC9HfWTpIayYYXieXrpssWQi8DGFc/mpvewbpv7d9nRT8IpAAa7RT+gTioTivluI=
Received: from MN0P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::34)
 by SA1PR12MB8118.namprd12.prod.outlook.com (2603:10b6:806:333::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 21:04:15 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::3c) by MN0P223CA0019.outlook.office365.com
 (2603:10b6:208:52b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 21:04:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 21:04:15 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 15:04:14 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add helpers to access cross-die registers smn
 addr for soc v1_0
Date: Tue, 16 Dec 2025 16:03:49 -0500
Message-ID: <20251216210349.1963466-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216210349.1963466-1-alexander.deucher@amd.com>
References: <20251216210349.1963466-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|SA1PR12MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 19c3c46a-60e7-4c1c-c7f9-08de3ce6abd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?II+dBVt+tWA+D0wl+4Z+iHZsQB5+tULpwYklj5M6aTk4Ds+ZQz63V/yAH6JR?=
 =?us-ascii?Q?dgcmJgBmuwqxhIXjuKZSrICg2OlmmOa5rYJWIQsYmSnQiSf5bei81gvW5d9k?=
 =?us-ascii?Q?4hOmKSswBKtI4iBDk9RYzVkgQnFQRDik6tWfcz6DwRPHxcueybsykMG7j7CU?=
 =?us-ascii?Q?W/ot00x5XNNPZUuP8IBS0b9GbCs+5GlSMKA2OKKWHsUCiVsU0FP/NNU6ebGT?=
 =?us-ascii?Q?VfIkCNWAh3A/ZjdZp6NUHj4U1RQOPhUdhGPvg9FytSEU609TmLXMfKWNLh8y?=
 =?us-ascii?Q?469R6VfHAFgkUKlfgaGfJc1JrX2uN4b07UiWvFXtpeOydtDePd600zn5dfof?=
 =?us-ascii?Q?8CkLYe4n9zuBgQmJpQxX10HCn8VwUGjGe9aHxRzCsvJXdxmfroxAkse/SsxC?=
 =?us-ascii?Q?i4SYY9Va+YF6o3r+UINbMG+v9hjUGULuORYn/lB51qF15j0uTU+XKLTImtGh?=
 =?us-ascii?Q?aPuJnB/RcR341aeRRgo3yPYXUvpKW6D+uoPx/Zku/qI1oRYdkBJsAoUuf0s2?=
 =?us-ascii?Q?+K95Gs+UL24sHTAlOgmIuAtq+tznXO5G2Fqtjw7NclJxwJP/Eqrwvc0/Qe9n?=
 =?us-ascii?Q?oLUb1wDR0MQVuAt4CodFnxRxy5IoBzo9g+v1F73XUwZL7JQgxGoKzd+eL1UY?=
 =?us-ascii?Q?OQsrLY+tNLOXR1VmfRAmGxAs0RfuGsvPjQcs6wRqhB2ZiI6IjrwvUCc6QZjs?=
 =?us-ascii?Q?u853EfCW6Lc8NBsqdEV4Vipz5OYDDGUl2d646NviazRMIgcUvrvePvktoBCD?=
 =?us-ascii?Q?hQG1raUtpbUJIqk+Gh0N1fwHv+oC3W9pNTrY//M+sSsW2GinyMSGsCpKqm56?=
 =?us-ascii?Q?ij/yHUvdOccSggkaIAjXHBnGJfFjShk80g4A++VyyeXBhPnQlFZLsqsVO28D?=
 =?us-ascii?Q?m/DvydqljXslBYdBNDZZIG/JTCYjHJUbAMQCjoMhnXPi5cfbYtoSbJtL4Egu?=
 =?us-ascii?Q?aWhyivvOQSpBt9PeUcykdtzSN+BwSZQnKZ4f6r9DrAT/Fpl59bjKlxZsyfsZ?=
 =?us-ascii?Q?Xg0guTVmpRhEY5XAK4jMvD29tQpKkFRikK3XDt+nYbZ4i3WJ7483B7J5KEOF?=
 =?us-ascii?Q?QI5zkYppx6mdKeqfZrArIvjvEtcjrXGBtGMdVgfTQ1khBganxNy6/+wRBWvo?=
 =?us-ascii?Q?kaXCVY1s+FeXvMsHpkXWJ3453p6KmU3X5AiKS/azh/yGhZb9681J6iGmY60k?=
 =?us-ascii?Q?TpbytMgc/TxVcLQugMU5hyV9FmCIM5M6JPwmHaEtYuOwYxMFsJYoE4pTgR6U?=
 =?us-ascii?Q?CjvW9oPSbSjuEeRah/tgfBc6qj0l4Hw1j0E0fgLmjIIBQQ9d56sH2O5Et6ZO?=
 =?us-ascii?Q?7bMTEQAZAIr+99Id6ddGXc8OJRbqu5r9FtyLsKSt2/p37byO/bGuVZLmXDes?=
 =?us-ascii?Q?2b9O4icbv89G3DA5rSeRpJh8OpEYn6+9JUsrq3isMAc/qKFbBuFU7LeMOOi+?=
 =?us-ascii?Q?hwWN7sNieOxkCVXmqM6WNqhYUYO34Jw6DCzaqgerxZ/fEN2HuhOV3WDf38AT?=
 =?us-ascii?Q?PmHMxhH0ik7D9lZr/4ksEdLw6X/lycB9LMjf7J8iImW7jxsv71b+x7/cSTdV?=
 =?us-ascii?Q?r5a9A81zT4QfxUIL0Y4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:04:15.5543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c3c46a-60e7-4c1c-c7f9-08de3ce6abd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8118
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

From: Le Ma <le.ma@amd.com>

Encode die_id/socket_id for upper 32bits of soc v1_0 registers SMN address.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 32 +++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index e9c7be1ed602e..0b380264ef904 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -72,6 +72,37 @@ static void soc_v1_0_doorbell_index_init(struct amdgpu_device *adev)
 	adev->doorbell_index.max_assignment = AMDGPU_SOC_V1_0_DOORBELL_MAX_ASSIGNMENT << 1;
 }
 
+/* Fixed pattern for upper 32bits smn addressing.
+ *   bit[47:40]: Socket ID
+ *   bit[39:34]: Die ID
+ *   bit[32]: local or remote die in same socket
+ * The ext_id is comprised of socket_id and die_id.
+ *   ext_id = (socket_id << 6) | (die_id)
+*/
+u64 soc_v1_0_encode_ext_smn_addressing(int ext_id)
+{
+	u64 ext_offset;
+	int socket_id, die_id;
+
+	/* local die routing for MID0 on local socket */
+	if (ext_id == 0)
+		return 0;
+
+	die_id = ext_id & 0x3;
+	socket_id = (ext_id >> 6) && 0xff;
+
+	/* Initiated from host, accessing to non-MID0 is cross-die traffic */
+	if (socket_id == 0)
+		ext_offset = ((u64)die_id << 34) | (1ULL << 32);
+	else if (socket_id != 0 && die_id != 0)
+		ext_offset = ((u64)socket_id << 40) | ((u64)die_id << 34) |
+				(3ULL << 32);
+	else
+		ext_offset = ((u64)socket_id << 40) | (1ULL << 33);
+
+	return ext_offset;
+}
+
 static u32 soc_v1_0_get_config_memsize(struct amdgpu_device *adev)
 {
 	return adev->nbio.funcs->get_memsize(adev);
@@ -211,6 +242,7 @@ static const struct amdgpu_asic_funcs soc_v1_0_asic_funcs = {
 	.need_full_reset = &soc_v1_0_need_full_reset,
 	.init_doorbell_index = &soc_v1_0_doorbell_index_init,
 	.need_reset_on_init = &soc_v1_0_need_reset_on_init,
+	.encode_ext_smn_addressing = &soc_v1_0_encode_ext_smn_addressing,
 	.reset = soc_v1_0_asic_reset,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h
index 296b653db987d..146996101aa07 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h
@@ -32,5 +32,6 @@ void soc_v1_0_grbm_select(struct amdgpu_device *adev,
 int soc_v1_0_init_soc_config(struct amdgpu_device *adev);
 bool soc_v1_0_normalize_xcc_reg_range(uint32_t reg);
 uint32_t soc_v1_0_normalize_xcc_reg_offset(uint32_t reg);
+u64 soc_v1_0_encode_ext_smn_addressing(int ext_id);
 
 #endif
-- 
2.52.0

