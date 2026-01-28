Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CFEAD25926
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 10:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12DBE10E650;
	Wed, 28 Jan 2026 10:59:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GJIE+OTK";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2F2F10E650
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 10:59:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vR1AcDFq+91E8ODsvX4Fd50qnFQQpVZTzalQcMhFKBhL7AgOUsYyVeHd2oCNbchMEIsSVye0FjaQBmB2GS2/Xdl+STeCTR06yKKELDEhGmOmyIpUmb2Pc6R0lz2F1CrjiwvlCUa6HtYRhCeNJjB4HAj/xtqftDaAYCl4Oyun34YYZBssN5+B0YAgkz/hqbt7D5rgXgflEcT3Ust1GgJOa5gyTXz2whMdPS56oEm9SlAH27x5FnV9jE5puAeKeauDp761nYqnTUi2CV5zXTMlT4x3811u04eToSoUDWUgf32kduVNBDnviPeNNUqY4hZsEFxI7y+9UYrQgjbWipw84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOhd+aTUec296cG+ZJ3XXpdxb+0fLwFasVnw7e6GbCw=;
 b=oEXBiz0ROmKC6Ek/9NyZbZCoRydvreySroMEDhRcpGvjkg7lsap25DvnEUOtpE1456WjaF7pNApd/b4Y3VSCobXdMof2bkTuBICsKPSbFsQau/dxhwvboIyhbDYQXmWogKN/i+1LABd7nVwv7UQKBrE8O98TekXj1QOa6ad04ZIj/3sATW2/S5v/kLeXxxfTXFe6eHqqQUxApC6aW0s1Qs3gDSOG7OBJkZYx8fGiMi7yBO71XdS00wPuXISwVHDNK8gFPP21FE+Uo1pY8xKnEWVVOgD6K9hNz8ogVyGjza433ZnO+Gm8zOx3rhSbihKgDVJcO4GfPQHVaNyDeqJKmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOhd+aTUec296cG+ZJ3XXpdxb+0fLwFasVnw7e6GbCw=;
 b=GJIE+OTKP27l/VhpL92g6SThkFylFYVVVRmVNttK3KS6CiObd7N2AfwoKeOpQZ+z45GKJDu/1hpDfQ7gf6jc0kSdd93+GCf3eR7fo2G81gykszjre18BnRD18bklQ+a8McYA0qNN7AXgr04DLhJeBZMROipudGaSu0/4GJIFfdc=
Received: from MN2PR20CA0064.namprd20.prod.outlook.com (2603:10b6:208:235::33)
 by SA3PR12MB7951.namprd12.prod.outlook.com (2603:10b6:806:318::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 10:59:13 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:208:235:cafe::98) by MN2PR20CA0064.outlook.office365.com
 (2603:10b6:208:235::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 10:59:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 10:59:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 28 Jan
 2026 04:59:12 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 28 Jan
 2026 04:59:11 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 28 Jan 2026 02:59:00 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v4 2/6] drm/amdgpu: Add CU mask support for MQD properties
Date: Wed, 28 Jan 2026 18:58:25 +0800
Message-ID: <20260128105847.2898288-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260128105847.2898288-1-Jesse.Zhang@amd.com>
References: <20260128105847.2898288-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|SA3PR12MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ec1a64-191b-4119-8911-08de5e5c4548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QoW6Th8HwKkLZEbVkU9GTxuXi19koAshAtekoOcMUaQgabxRp1DPsOLPxIk3?=
 =?us-ascii?Q?uSAi1uq5fZZZabWs5bhIvYPJmgWL8CN5NCnM5wYezJ39N0pR1tYpU5xlAhIk?=
 =?us-ascii?Q?MWkAQh0nbvlcenDHbGKdU97Ag27+0ZgHi0Ch+3HOm65TjGZGTtywdZLPWbCU?=
 =?us-ascii?Q?vWIdB/b8Eqv8+HEQY65PVl+lW9UmRd8VuGUeNSP4V648ZFkQ3g705Pf+FPoX?=
 =?us-ascii?Q?P/M0gtum0s+6ewdpIdQU6+rkewfM+aBjs3M372UwDKaSCBb5UVBcsfUipCHD?=
 =?us-ascii?Q?0a5iyWcXprGFIYGgZeURCVZBG1mqsmKH3iaPChzgGJaLv/HdFxFmkFR31DoC?=
 =?us-ascii?Q?ihtQAjosSCWO6ckUYsLNM9DcdeAiGQ/yjOSB+Ag2TwjhrTDvx499iySBot2o?=
 =?us-ascii?Q?qcFCbBmpICQV6GTBqPQrYaDesk+vzph5DsDPfGlPmTVZT6zLP6N2DTxImouk?=
 =?us-ascii?Q?arAIpR5sc5ryYu6TekLuDlwF5SP5Ni5UPgYZJy0Ceyo8sz/rrETyUM2CCMld?=
 =?us-ascii?Q?oJ5AWAXhmq7bcbriW4SxryFBhfXg52/lc5M5oH89AH6tCB9gJtdD8F2t+sMN?=
 =?us-ascii?Q?JlR9V31M3CPkm0rCRtccxWF7FMg6OQmPN39ysNfzs/prJwAsUXyCqE2Tn6d8?=
 =?us-ascii?Q?gJFCeAnet/qsYWNmKHKf8hBIbBMrkDd6lin0n8az5jB6t/9FF6sJDLYRwX7f?=
 =?us-ascii?Q?IehhF4BYm8FVUBJxNsBxJwv/DnzNdSXWNksdIwlhdIhmU/9L6FOs5hwWFwoe?=
 =?us-ascii?Q?PS35+fo4EF9p0ie7tewTrciZoipyN7hUuDns9qpy6XfOmcuMu2Sx2sBTo+1v?=
 =?us-ascii?Q?waiT6plTQ8yu3sYVvWDYd+XCKXhHbJwvSUSkkPNiV+m5vk+BIP/28BCeOjcR?=
 =?us-ascii?Q?riNR+TnOW8egMQV3lFIVtWCoh2jzUE3QGmRdouT4S+NRcsQdFp1XsTtj3E7n?=
 =?us-ascii?Q?Ir4M1evKfzguhcY8lQ6rZtnjBW+Bg11x4IMaTk6/gClnvUI8aUaVt7hgPf52?=
 =?us-ascii?Q?0rFSYvx3CcWGLX/WM4EbJeJ5XERi7WGlC+UmtJkFO6mrJBhqmx8nWdUyZx1c?=
 =?us-ascii?Q?9h6Sv6SUjgVPa7DEaI4c2o3t5pdSz80eh8S3kLSb1FzilMAt6ZLL9nUvXiGv?=
 =?us-ascii?Q?NJmo9BNdOiIDD9XBO8pyJ7p+qb1O5ld6vtGHFsNBFPnNHvWfbX70cf4Y9cnM?=
 =?us-ascii?Q?OCoPpfssl/NzDMZ40dXEUbdDCmIuhQnOBxum9cafEdV6Cv5vNWDLTv5bkb9X?=
 =?us-ascii?Q?ZYUHaboylQk39y7bPD4Tg01DArWKn789IGBiYbyCGr9AvRAsr8dGsdlPIBL8?=
 =?us-ascii?Q?bxuxgdquhkQU9HLcxMep+aLq0GqSzyuSD7apx+t3qOK/EV5y35whV3o0hs4s?=
 =?us-ascii?Q?lbHfbY8dizJzkd4mJr0iI3s/5I7px97SCdhOS22HCGFM9zXPSWR8RQUo9ehy?=
 =?us-ascii?Q?e0+iqdtGYaigOk6rIB4vmu5w85jf/6N3mKmIfOzF4m2r4ZIx5nJMoO6W7k40?=
 =?us-ascii?Q?i6DY0wiAdxjKcElW8o0B/bElZftqpALKNzOWPdOyRilueH3g0Hd+A64vVI/g?=
 =?us-ascii?Q?Z0HNrIu1RgHOU58fBviUZTuzAyJeIEP3JHHURoH5lG4Pv8slLzc/TFZWQ+4g?=
 =?us-ascii?Q?SxJuqdiG9UqzouvjQBWatXUcI+p3lJkD9piUF+RTyjGgFquNg0FUzYSXOA2z?=
 =?us-ascii?Q?hrARUA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 10:59:12.5147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ec1a64-191b-4119-8911-08de5e5c4548
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7951
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

Add new fields to the amdgpu_mqd_prop structure to track CU (Compute Unit)
mask information, including the mask itself, count, flags, and a flag to
indicate if user-specified CU masking is active.

v2: Create a generic function amdgpu_gfx_mqd_symmetrically_map_cu_mask()

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 10 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 49 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
 3 files changed, 61 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 11a36c132905..a8f4f73fa0ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -789,6 +789,12 @@ struct amd_powerplay {
 					  (rid == 0x01) || \
 					  (rid == 0x10))))
 
+enum amdgpu_mqd_update_flag {
+       AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE = 1,
+       AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE = 2,
+       AMDGPU_UPDATE_FLAG_IS_GWS = 4, /* quirk for gfx9 IP */
+};
+
 struct amdgpu_mqd_prop {
 	uint64_t mqd_gpu_addr;
 	uint64_t hqd_base_gpu_addr;
@@ -809,6 +815,10 @@ struct amdgpu_mqd_prop {
 	uint64_t fence_address;
 	bool tmz_queue;
 	bool kernel_queue;
+	uint32_t *cu_mask;
+	uint32_t cu_mask_count;
+	uint32_t cu_flags;
+	bool is_user_cu_masked;
 };
 
 struct amdgpu_mqd {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 6abe5103a78d..73e6988cb703 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -501,6 +501,55 @@ void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev, int xcc_id)
 			      &ring->mqd_ptr);
 }
 
+void amdgpu_gfx_mqd_symmetrically_map_cu_mask(struct amdgpu_device *adev, const uint32_t *cu_mask,
+					      uint32_t cu_mask_count, uint32_t *se_mask)
+{
+	struct amdgpu_cu_info *cu_info = &adev->gfx.cu_info;
+	struct amdgpu_gfx_config *gfx_info = &adev->gfx.config;
+	uint32_t cu_per_sh[8][4] = {0};
+	int i, se, sh, cu, cu_bitmap_sh_mul;
+	int xcc_inst = ffs(adev->gfx.xcc_mask) - 1;
+	bool wgp_mode_req = amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(10, 0, 0);
+	int cu_inc = wgp_mode_req ? 2 : 1;
+	uint32_t en_mask = wgp_mode_req ? 0x3 : 0x1;
+	int num_xcc, inc, inst = 0;
+
+	if (xcc_inst < 0)
+		xcc_inst = 0;
+
+	num_xcc = hweight16(adev->gfx.xcc_mask);
+	if (!num_xcc)
+		num_xcc = 1;
+
+	inc = cu_inc * num_xcc;
+
+	cu_bitmap_sh_mul = 2;
+
+	for (se = 0; se < gfx_info->max_shader_engines; se++)
+		for (sh = 0; sh < gfx_info->max_sh_per_se; sh++)
+			cu_per_sh[se][sh] = hweight32(
+				cu_info->bitmap[xcc_inst][se % 4][sh + (se / 4) *
+				cu_bitmap_sh_mul]);
+
+	for (i = 0; i < gfx_info->max_shader_engines; i++)
+		se_mask[i] = 0;
+
+	i = inst;
+	for (cu = 0; cu < 16; cu += cu_inc) {
+		for (sh = 0; sh < gfx_info->max_sh_per_se; sh++) {
+			for (se = 0; se < gfx_info->max_shader_engines; se++) {
+				if (cu_per_sh[se][sh] > cu) {
+					if ((i / 32) < cu_mask_count && (cu_mask[i / 32] & (1 << (i % 32))))
+						se_mask[se] |= en_mask << (cu + sh * 16);
+					i += inc;
+					if (i >= cu_mask_count * 32)
+						return;
+				}
+			}
+		}
+	}
+}
+
 int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 {
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 585cc8e81bb2..720ed3a2c78c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -583,6 +583,8 @@ int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
 int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 			   unsigned mqd_size, int xcc_id);
 void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev, int xcc_id);
+void amdgpu_gfx_mqd_symmetrically_map_cu_mask(struct amdgpu_device *adev, const uint32_t *cu_mask,
+					      uint32_t cu_mask_count, uint32_t *se_mask);
 int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id);
 int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id);
 int amdgpu_gfx_disable_kgq(struct amdgpu_device *adev, int xcc_id);
-- 
2.49.0

