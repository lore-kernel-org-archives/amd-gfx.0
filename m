Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23F2CAC5BB
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 03:30:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AAC110E905;
	Thu,  9 Oct 2025 03:30:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kqD11m5o";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2BC210E905
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 03:30:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ruwEnRjho6tO6Tw9fvKLaU3Q6qxpLP3xd7h60hDBw4PDURtTLXuw1maRZ1WRvKa6USvCVfqF5youR2+Otzw33lRa3Hq+HT0Dwrgc7ADlbDN/sZ4x+niUfquDUyqIwEw7zC/MHa66EVXRRXt+BDLJeCrpRTrKlODQk04qQiKyl4IDcXDkNXuxGL+GZXc4uHVPWYcdBy/zBfNaswLeLl+Qi0D16zLzYJzykRdKv+hj2KHCf7bGe8l2EC+hUNezEAf3HapaMO9dsN1UY2NMSg+ySsy+aFh2oa27QDzX4ea77/CzEXfp/JGetqfip99xrTDOl9ADsfsKOOBac321/Ly4ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44RCu7x5cbVxjfBzzAR2J851RoIks73jjEraXfwXWu4=;
 b=JEZ0Txj4Hsy9mYlq1rbpX9a7dyNR1xC2FYaqA8yjtAg3nMLE1ZK6WqVVboaeq/cc6XpqBKF39CnDtW7ILF3ajrVn/wx2Q/8aT1yB9BT0ZZl56nWTQDBQajzv4rAxcGO/jk3ddRocAIrA8C623fJRi6LYFi9vF+SLToTQjDEu+dI7TMyaE+YOmrfTd4U1jI79O175qbE+nK1jWX7MTuVt3YftDUpUL8quHyBofTX/kRNgBQfQ/eHDIKjay2sbocfrgzkzvPRjerDJ6rr3y0hK1s1U3MrJ08GLjbiPY3I8kYUN7bjJ9fSOfRupoMrHzjQ+L4m1a1B978cEdSmKr1L5tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44RCu7x5cbVxjfBzzAR2J851RoIks73jjEraXfwXWu4=;
 b=kqD11m5oHRveTtKwdSjX5MYPWRenzcCz1Nu1IMjiDR3BY7cYYObC/+gcpUCsiNmwVGscZy+2xI+HdtvQIhK0zMzpL5F6CszqXP1TUPXaLzsWA5CgMXnItz8qWPQkNzOAwuwS+/SdYCEvJh/6DhjtpFrwqh2owS/rPcU9e3+PCvQ=
Received: from PH7P221CA0076.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::32)
 by BN7PPF0D942FA9A.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 9 Oct
 2025 03:30:44 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::c2) by PH7P221CA0076.outlook.office365.com
 (2603:10b6:510:328::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Thu, 9
 Oct 2025 03:30:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 03:30:42 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Oct 2025 20:30:41 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Shravankumar.Gande@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH 3/6] drm/amdgpu: Introduce SRIOV critical regions v2 during VF
 init
Date: Wed, 8 Oct 2025 22:30:29 -0500
Message-ID: <20251009033029.24986-1-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|BN7PPF0D942FA9A:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f512e15-0919-4e80-faee-08de06e43a1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XiDCqKGOhj5BpoS8CEI73LdJfe7TqdEhR9foGxYLateapX/O08/E5qIovJY1?=
 =?us-ascii?Q?od97VoMRqzAlRVXu3aIrJl12RI5rTIF6uMKqj079v5L/qLOF9esU4o+xp1xB?=
 =?us-ascii?Q?PTKhX5WEQUjhFPiukYb25V3yoBvSPNlrfw8rucRRrsY4otJlxHixjjp5NZ1s?=
 =?us-ascii?Q?dVd72blv6XuqM0ESLO2O5wHLDuY/dLMoXYnTkaPf/tz6qoCM1BH8cSsapw8M?=
 =?us-ascii?Q?UMLx1RQQdSDK20PO2aYONqifZfCWKgNrH4jrYccOH3pkq4nGcbYEb7uQj3+v?=
 =?us-ascii?Q?Dr8QT0YQ0qZ8ECwBUFC/i9S9Icq2vyYJL4MoKHDTFA/tAqZCUQVQNSE+mZDY?=
 =?us-ascii?Q?S15mnyZ125lBF5guFipxmXjYRaHg7wfOf9mcVBXpdD+Osf04oMTYQpnCDygF?=
 =?us-ascii?Q?LtVMPQ5M8bPWcauFz9t4qt+GiI7nUUMhVhDoUfLd93A0s69w+cAOHW/HKNgB?=
 =?us-ascii?Q?K4T/0Emmbm39YwayhBHsMpCoSOOaBiFfMmlfBGxxtAA5X/ZmuynrTjzQGWe7?=
 =?us-ascii?Q?+6mRtvXpEY/lEOrQNn7+6Xk5D/UH/yI70BOxnOYH1NXU/NB5k81YdBZF1VHy?=
 =?us-ascii?Q?ISB4G7r+pQ87Ljz4YiJbVUysP+39fP8qMNgUYYC36V5yr5E2FVEWmuv7+BGJ?=
 =?us-ascii?Q?GN5eE0g4it6HAEZsDqsMchuJyT9RpD5i/Y+nghXuBW87ObwXIx7eVbq3ofe5?=
 =?us-ascii?Q?P0ST+CrXIVX990Pqjyq1UxJ6LV9NRdPVsoToL/glyQ7dDj5Vc5op72Mzp4M2?=
 =?us-ascii?Q?iCGOOF6FlaTwtdAteYLxdlXSHx/WZqqHx465RY3yDoWsadUoxDaC0ZJgVfSe?=
 =?us-ascii?Q?1tDDfM6ClSIT7Sy9BLqu8vLdozAxzOyPa2A/L64+BTgdZE/6pFgb9Ox10FC8?=
 =?us-ascii?Q?0UmPQ6lc8Q7RcKMVLK0+yi38YnkAA77JqB47ONSc2Od/LZWaCdfB9rnmEpfA?=
 =?us-ascii?Q?R7j7jKweXAPwv6l3YMM6v9f6lQ/j5F6VRE8pWg8Nas1nSYNgRiwLbMsPDmQD?=
 =?us-ascii?Q?Imkg92oMELbLON0GwEJc8JlUXZPKv0BqEkqPFKBp7ogT65uIaoHXkBQvDpsA?=
 =?us-ascii?Q?R7ca+18iGZis2CBAdtW5g5JnWg9Z4p8xnMzUsWcOaOGZgu5k0jpe2QQjMiTU?=
 =?us-ascii?Q?B62Py5UqxjkiZsc1uiu5q89+7sq4NIt/8B1G8NC6SxqP2A+20E025MqgVYv8?=
 =?us-ascii?Q?HQD2Bp/C7JaEl+K+zGB6HZjc16hSl2PE8QGWK44PTfo4k2vCGBO4qKTOGgQc?=
 =?us-ascii?Q?+ZX31gkX1SYtXIyOj4mO2hppj97tZxrJNB47Xp2/FHqV3oHC4SvHDGCaBBJn?=
 =?us-ascii?Q?82D9tfLyAUi2tsGhcqJnwEs/wBWMfdIFGyHdF49IqdURrazAS1A5ZjwCi4uv?=
 =?us-ascii?Q?pqYn88tKh0WBjNaxstgiHRl5sE427rapBidbWEdYMEP67SxsUHlHyO6/girA?=
 =?us-ascii?Q?rejs6+FoWYCMTD8FclfYSsSsJ6ECw0Fl+nWNtRxia3TdSjjmtNawbDK+jCG5?=
 =?us-ascii?Q?ZtfHgZTczcldyrgJNPXWt2oScDBUl3oNC7cuG5lFUUzhRQY1i02CtdC2oDP+?=
 =?us-ascii?Q?GyJl5pNfKSp4Q731fbA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 03:30:42.9677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f512e15-0919-4e80-faee-08de06e43a1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0D942FA9A
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

    1. Introduced amdgpu_virt_init_critical_region during VF init.
     - VFs use init_data_header_offset and init_data_header_size_kb
            transmitted via PF2VF mailbox to fetch the offset of
            critical regions' offsets/sizes in VRAM and save to
            adev->virt.crit_region_offsets and adev->virt.crit_region_sizes_kb.

Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 103 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |   7 ++
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  31 ++++++
 4 files changed, 147 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 929936c8d87c..2a33b950d511 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2754,6 +2754,12 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		r = amdgpu_virt_request_full_gpu(adev, true);
 		if (r)
 			return r;
+
+		if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) {
+			r = amdgpu_virt_init_critical_region(adev);
+			if (r)
+				return r;
+		}
 	}
 
 	switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 3a6b0e1084d7..46c19e96086a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -843,6 +843,109 @@ static void amdgpu_virt_init_ras(struct amdgpu_device *adev)
 	adev->virt.ras.cper_rptr = 0;
 }
 
+static uint8_t amdgpu_virt_crit_region_calc_checksum(uint8_t *buf_start, uint8_t *buf_end)
+{
+	uint32_t sum = 0;
+
+	if (buf_start >= buf_end)
+		return 0;
+
+	for (; buf_start < buf_end; buf_start++)
+		sum += buf_start[0];
+
+	return 0xffffffff - sum;
+}
+
+#define mmRCC_CONFIG_MEMSIZE	0xde3
+int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
+{
+	struct amd_sriov_msg_init_data_header *init_data_hdr = NULL;
+	uint32_t init_hdr_offset = adev->virt.init_data_header_offset;
+	uint32_t init_hdr_size = adev->virt.init_data_header_size_kb << 10;
+	uint64_t pos = 0;
+	uint64_t vram_size;
+	int r = 0;
+	uint8_t checksum = 0;
+
+	if (init_hdr_offset < 0) {
+		DRM_ERROR("Invalid init header offset\n");
+		return -EINVAL;
+	}
+
+	vram_size = RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
+	if ((init_hdr_offset + init_hdr_size) > vram_size) {
+		DRM_ERROR("init_data_header exceeds VRAM size, exiting\n");
+		return -EINVAL;
+	}
+
+	/* Allocate for init_data_hdr */
+	init_data_hdr = kzalloc(sizeof(struct amd_sriov_msg_init_data_header), GFP_KERNEL);
+	if (!init_data_hdr)
+		return -ENOMEM;
+
+	pos = (uint64_t)init_hdr_offset;
+	amdgpu_device_vram_access(adev, pos, (uint32_t *)init_data_hdr,
+					sizeof(struct amd_sriov_msg_init_data_header), false);
+
+	switch (init_data_hdr->version) {
+	case GPU_CRIT_REGION_V2:
+		if (strncmp(init_data_hdr->signature, "INDA", 4) != 0) {
+			DRM_ERROR("Invalid init data signature: %.4s\n", init_data_hdr->signature);
+			r = -EINVAL;
+			goto out;
+		}
+
+		checksum =
+			amdgpu_virt_crit_region_calc_checksum((uint8_t *)&init_data_hdr->initdata_offset,
+				(uint8_t *)init_data_hdr + sizeof(struct amd_sriov_msg_init_data_header));
+		if (checksum != init_data_hdr->checksum) {
+			DRM_ERROR("Found unmatching checksum from calculation 0x%x and init_data 0x%x\n",
+						checksum, init_data_hdr->checksum);
+			r = -EINVAL;
+			goto out;
+		}
+
+		/* Initialize critical region offsets */
+		adev->virt.crit_region_base_offset = init_data_hdr->initdata_offset;
+		adev->virt.crit_region_offsets[AMD_SRIOV_MSG_IPD_TABLE_ID] =
+			init_data_hdr->ip_discovery_offset;
+		adev->virt.crit_region_offsets[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID] =
+			init_data_hdr->vbios_img_offset;
+		adev->virt.crit_region_offsets[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID] =
+			init_data_hdr->ras_tele_info_offset;
+		adev->virt.crit_region_offsets[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID] =
+			init_data_hdr->dataexchange_offset;
+		adev->virt.crit_region_offsets[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID] =
+			init_data_hdr->bad_page_info_offset;
+
+		/* Initialize critical region sizes */
+		adev->virt.crit_region_size_in_kb = init_data_hdr->initdata_size_in_kb;
+		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_IPD_TABLE_ID] =
+			init_data_hdr->ip_discovery_size_in_kb;
+		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID] =
+			init_data_hdr->vbios_img_size_in_kb;
+		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID] =
+			init_data_hdr->ras_tele_info_size_in_kb;
+		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID] =
+			init_data_hdr->dataexchange_size_in_kb;
+		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID] =
+			init_data_hdr->bad_page_size_in_kb;
+
+		adev->virt.init_data_done = true;
+		break;
+	default:
+		DRM_ERROR("Invalid init header version: %u\n", init_data_hdr->version);
+		r = -EINVAL;
+		goto out;
+	}
+
+out:
+	kfree(init_data_hdr);
+	init_data_hdr = NULL;
+
+	return r;
+}
+
 void amdgpu_virt_init(struct amdgpu_device *adev)
 {
 	bool is_sriov = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 2a0627596bd2..5f6014b2f349 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -292,6 +292,11 @@ struct amdgpu_virt {
 	/* critical regions v2 */
 	uint32_t init_data_header_offset;
 	uint32_t init_data_header_size_kb;
+	uint32_t crit_region_base_offset;
+	uint32_t crit_region_size_in_kb;
+	uint64_t crit_region_offsets[AMD_SRIOV_MSG_MAX_TABLE_ID];
+	uint64_t crit_region_sizes_kb[AMD_SRIOV_MSG_MAX_TABLE_ID];
+	bool init_data_done;
 
 	/* vf2pf message */
 	struct delayed_work vf2pf_work;
@@ -428,6 +433,8 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev);
 void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
 void amdgpu_virt_init(struct amdgpu_device *adev);
 
+int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
+
 bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
 int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
 void amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index b53caab5b706..d15c256f9abd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -70,6 +70,37 @@ enum amd_sriov_crit_region_version {
 	GPU_CRIT_REGION_V2 = 2,
 };
 
+/* v2 layout offset enum (in order of allocation) */
+enum amd_sriov_msg_table_id_enum {
+	AMD_SRIOV_MSG_IPD_TABLE_ID = 0,
+	AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID,
+	AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID,
+	AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID,
+	AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID,
+	AMD_SRIOV_MSG_INITD_H_TABLE_ID,
+	AMD_SRIOV_MSG_MAX_TABLE_ID,
+};
+
+struct amd_sriov_msg_init_data_header {
+	char     signature[4];  /* "INDA"  */
+	uint32_t version;
+	uint32_t checksum;
+	uint32_t initdata_offset; /* 0 */
+	uint32_t initdata_size_in_kb; /* 5MB */
+	uint32_t valid_tables;
+	uint32_t vbios_img_offset;
+	uint32_t vbios_img_size_in_kb;
+	uint32_t dataexchange_offset;
+	uint32_t dataexchange_size_in_kb;
+	uint32_t ras_tele_info_offset;
+	uint32_t ras_tele_info_size_in_kb;
+	uint32_t ip_discovery_offset;
+	uint32_t ip_discovery_size_in_kb;
+	uint32_t bad_page_info_offset;
+	uint32_t bad_page_size_in_kb;
+	uint32_t reserved[8];
+};
+
 /*
  * PF2VF history log:
  * v1 defined in amdgim
-- 
2.34.1

