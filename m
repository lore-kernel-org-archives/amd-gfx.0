Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C726C3DA6D
	for <amd-gfx@archiver.kernel.org>; Fri, 23 May 2025 03:53:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08EAE10E1C8;
	Fri, 23 May 2025 03:53:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="enQcaY5x";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D470410E11C
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 May 2025 03:53:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z48FI+wsMyq/SQQWV7HovtXUWT2PMBPETT4vR5YbYHTcKLOPG1zrXG/9I29ER2Fsu7wAGVXB+S490WR07xANfXwJ2sEAcDVmwzt/MHxfp98tsmuyQj7MYMbwlqCaXbnsdrXGqZrFGbX6/hUeFxeorWfvcGCekZrAUegUjU3GsK8f49ecVc7CGVeqzl877nzKrKiPdAMLB7dtscZCFwqitt/6x7F4PErRj1G8zLMZ7+G1GXw7sT8sjSJgIgaBo1k0kLSJf2f01+ltIyg2qdyO5oRsn0XodkO7G9Ejq6D2NEBK0o8i+hTkV1E4YsPfpgXeZLt5apxC1B/4nwYCqnE5RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1lm1J44s35hBWtjwEnh0wjTaQkHabIVsMayLwRM8cQ=;
 b=PdaUhwes06X+f6EIuChifLuig+ZkHjcUhekbnd4fTHWUqzKh/chtnE8nE65+6kLQRzsJCNnoN5klUrqHpHCbYoR3PQgpLiuq9XUiThmIkAl2kfZmZsJtcP1bfRIklu2prcNBE8aaZ8tU3wdG0YQVUZVgB1SGg6TTYqxNScu0+QZgD37CeVHDMGOqWdNz0EzpDjG7Q0tWWmkIgxMlw24czNGWyM2Wrd++Mth5SeZirc1vSuIpua2WYQn2+lzAwztrNqsfaMIH5XwP0hOoaJDIbMz4/BgIgDfYtjZ6kA38DNyLMJfDVgeSAR8JG7ZYmmDWHhaIqN+WVNIKw0oShJS/nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1lm1J44s35hBWtjwEnh0wjTaQkHabIVsMayLwRM8cQ=;
 b=enQcaY5xDEdHuJCNbU0Hn+nTSMglcCkQoR9la5pUX594sPyAg1CjxxI7WBarLQAvekmFmJWD1KFzsdN43p+wQ3b2YPViaOhcI6Gi31CfqYNGyLr8orKlh66ycFlhWbbIov6aFrmrep/nfXjb31i8BvSRqLN4MeAuNJf9FKBvznw=
Received: from SA9PR13CA0056.namprd13.prod.outlook.com (2603:10b6:806:22::31)
 by SA3PR12MB7832.namprd12.prod.outlook.com (2603:10b6:806:31f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Fri, 23 May
 2025 03:53:04 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:22:cafe::2) by SA9PR13CA0056.outlook.office365.com
 (2603:10b6:806:22::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Fri,
 23 May 2025 03:53:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 23 May 2025 03:53:03 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 May 2025 22:53:01 -0500
From: ganglxie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, ganglxie <ganglxie@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: handle old RAS eeprom data in non-nps1 mode
Date: Fri, 23 May 2025 11:51:54 +0800
Message-ID: <20250523035155.63467-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|SA3PR12MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: 9321b723-db5a-4786-4861-08dd99ad518c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ApYf6huF9ffqk4rzLGkCxeI2G4el+ZFBj4QSEPcOcDxz8hcgEh0LMd+gO81n?=
 =?us-ascii?Q?CUKYSofGvAnWZkhWvEk3CLSHxn/qejdIu4vPW0kXsO5S7vY3SOpqKD29NOW9?=
 =?us-ascii?Q?mqa1rMZL8Oky3fVFCuRxA0iYoANt3lX+7usyJisgV50SqCaPqr/LlS3Qss7/?=
 =?us-ascii?Q?owmk3c2xvnqL7JhrIEDXCBzyXncH0tmar8pA2tKSFpTZa9D5GkM6+xScErrx?=
 =?us-ascii?Q?mHihJGY/fQFS0+UIsTnRlejDvsM2XMurkVnU1ZVfvLj7cxclzQrheqlq3rsl?=
 =?us-ascii?Q?U8FtY+rts4V65TRNz71/ZO1Ad3zwXsAoarbYoK9zdr8XyDoAWfHbV90hBxeR?=
 =?us-ascii?Q?QykCc5z1/g3wG9n8fUqyWyBL2TxbxTld/M9kIz9fmx+3f0wvuV1mCCx4O+AO?=
 =?us-ascii?Q?56O9mCqJv+8BUfF/uwgUn3L9KMe3BiOT/tofvSot/xWZM1yq/fslXdrnPTY1?=
 =?us-ascii?Q?HBDP4sJZ2djFj+Rf3FN3f1TxiYkLYYyCpsPruwHzVxdHgxbNVGXhNsB+93+N?=
 =?us-ascii?Q?Tq4Mvm2DRxcWzpT660EVgUXPxVc13JU9G1PUEPr1ZIckH/OpmAIkFAqt4ntx?=
 =?us-ascii?Q?b/O01WfgLulOADWvQ+c/uvG7UcD6ideRiXohAEBuiKCD1t9XnQHpSvvejfjo?=
 =?us-ascii?Q?mynzpS9hWueEjkKmdvGruMSTLVNotyu8gsZy/Dr/J9/Ojbi6eep/ub9O8aCf?=
 =?us-ascii?Q?yGI8TSjms/CmGSKNC6+wBgBK8x8DmoPMi/B9ss7MMbbPf5thjBP2EvBqOZRy?=
 =?us-ascii?Q?bYmwZwsGaJKm/EXQ/jb+heVYkI6oh18FP77W7lGeVWOuKXg5kamUoFv0id5j?=
 =?us-ascii?Q?d8yuU/aUsJXAJGxCTJkqCZnxUCsbXTkzIV8DUX0Y1q77rqkuHR39NZs50dNv?=
 =?us-ascii?Q?4NEALZjgyI13OP1qTV70MVdW/0ARyrUvpNEXZ3dBfdRWodOqil1jJ14H19Wg?=
 =?us-ascii?Q?lmO6pJkj0ip6rF/AQEggwBVhNzFszLSIxUWzCNG3qO1FAD0OhVhm+pA6AHam?=
 =?us-ascii?Q?LECSQTp7ziDxpWwUhW/aeb54nsZ67dre7yChIr9xykCElmOgInJmcCJEGWta?=
 =?us-ascii?Q?QAmF/dfGQre/hOwTkkkDAlM0h/tzSqJ0fMCBeaP3E44h9nFZqD46CUg4RnK8?=
 =?us-ascii?Q?/4704hyajfJIevydyPXSSSJTmk4zOp/qHVzw4225Us/n/KXI9AC6WzTHBpCx?=
 =?us-ascii?Q?GRuYjP7T4TNDDkPAvYbdvaq32DDf7gX/5MupdeJKWtvTWOcEJpvfypYSAaJE?=
 =?us-ascii?Q?YAnBZFJ2xoXIZgnTFWNcfoMQUj5UxM71q6ZFZMfh7l8bj2yyUdAKeG3vzzoE?=
 =?us-ascii?Q?Z/CevZd+BAqlDZMVGoJfXm61gZh4XtvT77M2y+pS6sSfFArNCnNVgwudGqcX?=
 =?us-ascii?Q?XjiwP85JZjNEmWnjlBiMoCHNlbXztu0CT/sfhXTloZNr7R/OCyOyI5Vje/8N?=
 =?us-ascii?Q?4zedt6k9ipjFrPzxQa9WVOKLn2GtOYPBJlV8oSGgGCiKZGFmlokCJylyoh6y?=
 =?us-ascii?Q?MGO3mDoZbmtXf1XOpEZDPPm/7EGayuK/12SL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 03:53:03.2270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9321b723-db5a-4786-4861-08dd99ad518c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7832
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

Get MCA address from PA in nps1, then convert MCA address to PA in specific nps
mode.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 16 ++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  2 ++
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 071412b8bd55..7d4d31c6ab48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2887,8 +2887,20 @@ static int __amdgpu_ras_convert_rec_from_rom(struct amdgpu_device *adev,
 				bps->retired_page << AMDGPU_GPU_PAGE_SHIFT))
 			return -EINVAL;
 	} else {
-		if (amdgpu_ras_mca2pa_by_idx(adev, bps, err_data))
-			return -EINVAL;
+		if (bps->address) {
+			if (amdgpu_ras_mca2pa_by_idx(adev, bps, err_data))
+				return -EINVAL;
+		} else {
+			/* for specific old eeprom data, mca address is not stored,
+			 * calc it from pa
+			 */
+			if (amdgpu_umc_pa2mca(adev, bps->retired_page << AMDGPU_GPU_PAGE_SHIFT,
+				&(bps->address), AMDGPU_NPS1_PARTITION_MODE))
+				return -EINVAL;
+
+			if (amdgpu_ras_mca2pa(adev, bps, err_data))
+				return -EOPNOTSUPP;
+		}
 	}
 
 	return __amdgpu_ras_restore_bad_pages(adev, err_data->err_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 8c6e55b5b967..c92b8794aa73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -562,3 +562,26 @@ int amdgpu_umc_mca_to_addr(struct amdgpu_device *adev,
 
 	return 0;
 }
+
+int amdgpu_umc_pa2mca(struct amdgpu_device *adev,
+		uint64_t pa, uint64_t *mca, enum amdgpu_memory_partition nps)
+{
+	struct ta_ras_query_address_input addr_in;
+	struct ta_ras_query_address_output addr_out;
+	int ret;
+
+	/* nps: the pa belongs to */
+	addr_in.pa.pa = pa | ((uint64_t)nps << 58);
+	addr_in.addr_type = TA_RAS_PA_TO_MCA;
+	ret = psp_ras_query_address(&adev->psp, &addr_in, &addr_out);
+	if (ret) {
+		dev_warn(adev->dev, "Failed to query RAS MCA address for 0x%llx",
+			pa);
+
+		return ret;
+	}
+
+	*mca = addr_out.ma.err_addr;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 29ce6b1d214a..ec203f9e5ffa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -189,4 +189,6 @@ int amdgpu_umc_mca_to_addr(struct amdgpu_device *adev,
 			uint64_t err_addr, uint32_t ch, uint32_t umc,
 			uint32_t node, uint32_t socket,
 			struct ta_ras_query_address_output *addr_out, bool dump_addr);
+int amdgpu_umc_pa2mca(struct amdgpu_device *adev,
+		uint64_t pa, uint64_t *mca, enum amdgpu_memory_partition nps);
 #endif
-- 
2.34.1

