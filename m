Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCB7CCD184
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 20:55:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8946910E241;
	Thu,  9 Oct 2025 20:55:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lTn5Mwo7";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013051.outbound.protection.outlook.com
 [40.93.196.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C10A710E241
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 20:55:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGeYeETw/+Rc8xxfIm46b8zOAWc+48aMG+Tf0u6XRSG3Odf6dyJ4OKP/BzhsnD4JKeo12RyaU0nL1MBeyX4Ur1j0iZEf4cfJJeQLm0JTSUFBM2AI0DSkFP8/GFGWioT2j6iWNpQWr+kRUPmZsoaQb/wTGfqyy4coKLg3xIqrU16Mi7RVOasBg7g0V9SOA4adGxvqvcxVBuqKlBwoy5Ao0ZuXsl8/M+Y4Pd7QZnrigrWLtu2TNrqpn1CwKFlFIlYGM4TW4SJESMQ3PdlYeioVwc7sqiU5TTmvnhyvRitvYFV3hWDHWRHHxWLU0Sp3mij0jrIbY9rflBq6/gZ3GgC9tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPlohmiisSrzAAtdS3N7jqERYWDqL9X/xyZQWzn1UCA=;
 b=bnrZYx5wBTzmCzQGpNCjr/yqsKZWNrtqfBshUVdV5fUbO66gwmUuXS3QIZ4qzU4e83/WsZyrw8Ekzu6Kpxls79e4v76MmQ8yWNlyyVMiUxrbymS/XHl3gD7V7oT8jS9Ge/+tz2rdCwCmWLlMqpi1H+cJdF0jgGHqQbuc1WMG3PwsOD9ZntcC5/0pzG8ZRPKenaqExwN+OZP0Br+mVGTTZCj2GpuEAi9abD7GHSjYdi2MDygpd2vklKdjr+EcKICcv5pbG5sBgvzDGl7gQKIKEYj0+GcYj/t2OBUk4laDQSKoYUXbUIpP8pWnMBs1Rgs6xOUQt1UtWjdHhZ9yzPq6Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPlohmiisSrzAAtdS3N7jqERYWDqL9X/xyZQWzn1UCA=;
 b=lTn5Mwo7V7z4EYPPNVnKXpxEgqqG/BaLOafVLQp6B2q+KBge2U4HVLzRuVMMUNFIR+Oeu0ZQdLY1s7XY4HQ33PtAoJYQk4Rvk41ynXIopnLcRsE5o5vn/mDXFADITXvzXUff4W64Kxzmjmjaa3K6T9rv2JedZ5S93gryxxzFqFc=
Received: from BYAPR01CA0044.prod.exchangelabs.com (2603:10b6:a03:94::21) by
 SA3PR12MB9089.namprd12.prod.outlook.com (2603:10b6:806:39f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.10; Thu, 9 Oct 2025 20:55:56 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:94:cafe::c4) by BYAPR01CA0044.outlook.office365.com
 (2603:10b6:a03:94::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Thu,
 9 Oct 2025 20:56:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 20:55:55 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Oct 2025 13:55:53 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd: Add a helper to tell whether an IP block HW is
 enabled
Date: Thu, 9 Oct 2025 15:55:07 -0500
Message-ID: <20251009205508.175269-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|SA3PR12MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a408e15-1c0a-42a5-08b7-08de07763dcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N18fMrQyXKhF4JBJ8cNZAkYAryHJ8fj1LVwvmUq4cuCDYIsx3ZfeY2uGd8Ul?=
 =?us-ascii?Q?vVy6e/h07IMO6wBBUSjalsTVrivoKt0BzpI+4RHpDZLihagyzjywNKColVtN?=
 =?us-ascii?Q?Mury/h9DF4g1s0tABiqpa5TpnOsN5pwJDWMvYu+9HrFxM84bx/dPCZ3Gjj6k?=
 =?us-ascii?Q?pN6AY1WrHsqdbyL8JhwjuOuhSWes7vpadPbLCZYqOUYKXYyrrLfu/o4buF54?=
 =?us-ascii?Q?GBVufdj17VdMqufcJL0Xq9O6FINNlppSPl39o4xOOOKBrzMRt4/kgU7qMfKL?=
 =?us-ascii?Q?mEyeKUIZvoj4Vg8i7gyJmPglCcqECMv/u02Sr8yDvhh6kQpWcywD9deJdRhG?=
 =?us-ascii?Q?TmxLtip1FVMnDHdH2shg23CV/gFRxYL1/OaBY7tiOd8zQOP3PRlLYdd2r1F/?=
 =?us-ascii?Q?vPSLmkHjRcKl1Dhug6gmu4wr7WVuf12T0j9ViNjaAREaiYO+rfFL7ywqLqB9?=
 =?us-ascii?Q?ArT8VZuaUcC/gANneuuqSKKnIrgfAruuBvODRjYwHhuauDQq+lmlixYIhC8z?=
 =?us-ascii?Q?vABJlAceV9jbDgD9UZu5FHwN14edqi4N6LlLu3TmWlu9KHL4CRUZde2qdyJG?=
 =?us-ascii?Q?izAeYmfZxzMuDuKXmcrR76KNi0TNYGJ7zaXhNdmBtZPJToQPzOZgZYh7pr7a?=
 =?us-ascii?Q?aR6lyerFcWY1v5w1YmP4kXDVzpGMHSsr3XVaxylWamIkinkf+J3unPVTN294?=
 =?us-ascii?Q?7uoqhUyrcKs1BisAjkv0BjmStqyYWMwzWUomDEipfVhK7CIRFLrLHnpyzGeF?=
 =?us-ascii?Q?NJjkwDvIahPOBppJokhDPowDOG/Z5gpILMEMpENe8qRWcRlQ+qEuF1d7+oHy?=
 =?us-ascii?Q?gJ51VqZ12V0dNywTPRUuNcNgIgjBtTF+FVcVHrejmTnXtM7ZdDubpqqJ6wjm?=
 =?us-ascii?Q?B0xVR9DYBbdKAW3phS36MYnmBwBpnlVgfL6Hx9dxWO4koLn61cU4spU4MVkR?=
 =?us-ascii?Q?fpucOeW/1QK9FQAODsA9EvWfxL5jmlRmfP0NVMlJDNNJJGV22pJ7H4s05Shg?=
 =?us-ascii?Q?XfaE5DYPhgzkeU2O8v0ykGtuiH2ZacsDI6BEX7J1WEN+S8Kah9A1zJoRr+2l?=
 =?us-ascii?Q?tr3mpcEiBqTX+7rGIR1canqLzvCEnEQSPkDcHQWHM3NkCb7iRdj2BBUORQZj?=
 =?us-ascii?Q?0GCqhFzPRJ/8UtMZSxogz13nAmyfIOmXTfl3QeTnGbJmTlbfFDV2ex0w+dUT?=
 =?us-ascii?Q?RAB8yafP6KJSxE18uIVuiiB6WSl4JGj3x8IRGqT9lIL5Rdia1iTQecyA0UBl?=
 =?us-ascii?Q?y+/QdAT3a9WIrKBWejTAxnDoPHGfrHNm5qN6O4w2usHaBB3735pZjZxGKiBl?=
 =?us-ascii?Q?wr5oSQNTaujFqvYLFOu/iOx0bbCEDfTTpAHzvNuCn2wG6f0nOPjnzx451hIS?=
 =?us-ascii?Q?Gzxjsatazamm9IesCCXWRar5ddS1FR4tnEeCdf7mvuvrBNBVyzNi0OkMKHHd?=
 =?us-ascii?Q?QmHPMcwtNoGaLTG1kjRkDzIsqgUCBZCONc/9TEXvAn/uR4kuW+ZJ/ot60Pck?=
 =?us-ascii?Q?6jvco3sZK4Z4KJP9sXcEFqT+fFWcY8aN7KU9LJ0xBjX311l+HHFivt/lVxXe?=
 =?us-ascii?Q?FQagsnT0NGLzkiZq8kM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 20:55:55.6161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a408e15-1c0a-42a5-08b7-08de07763dcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9089
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

There is already a helper for telling if a block is valid, but if
IP handling wants to check if it's HW is enabled no such helper
exists.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 23 +++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9cbc8648f837..bd572c101fb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -372,6 +372,8 @@ void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
 					    u64 *flags);
 int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
 				   enum amd_ip_block_type block_type);
+bool amdgpu_device_ip_is_hw(struct amdgpu_device *adev,
+			    enum amd_ip_block_type block_type);
 bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
 			      enum amd_ip_block_type block_type);
 int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f3d42c5b1547..6ebc03f3c375 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2380,7 +2380,7 @@ int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
 }
 
 /**
- * amdgpu_device_ip_is_valid - is the hardware IP enabled
+ * amdgpu_device_ip_is_hw - is the hardware IP enabled
  *
  * @adev: amdgpu_device pointer
  * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
@@ -2388,6 +2388,27 @@ int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
  * Check if the hardware IP is enable or not.
  * Returns true if it the IP is enable, false if not.
  */
+bool amdgpu_device_ip_is_hw(struct amdgpu_device *adev,
+			    enum amd_ip_block_type block_type)
+{
+	int i;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (adev->ip_blocks[i].version->type == block_type)
+			return adev->ip_blocks[i].status.hw;
+	}
+	return false;
+}
+
+/**
+ * amdgpu_device_ip_is_valid - is the hardware IP valid
+ *
+ * @adev: amdgpu_device pointer
+ * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
+ *
+ * Check if the hardware IP is valid or not.
+ * Returns true if it the IP is valid, false if not.
+ */
 bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
 			       enum amd_ip_block_type block_type)
 {
-- 
2.51.0

