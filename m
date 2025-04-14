Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BFCC369B2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 10:48:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1482810E0FC;
	Mon, 14 Apr 2025 10:48:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UkMTUr+g";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5E2410E0FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 10:48:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ysug+I0jzmdNEGEevAF6OxOih17Tk3lE4H2b1wEOHkH/aT4W9OqGstDJnmxXS0tvJYDIUINDbzXDPpLKTrMFfrF9F5s+fUMgBJTIW9lp/ff4OKqXnKlJZxFD8uMWdJBX3pdNcBrrPpBo2wOc7uap52U9KRE4IxZ00yxW5aqX3sdj+XwB6cfcuN/7axGlaZJMFKNGCqQ9Ldt0R4PiGMehpS+fSGjP6L8FYfMPj+ULWMDxvlZLWHToHqToKuOP+GXiONYwoVSOuzCgBkFBkgX+HiJMCyJS6kK47wniMuKBi+Z4DWOOboP0cNLI9a5HC9Tsv0OKKhXa2+aiH3n8NoVKag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtQ/ZhyxwBSLY8EXoD66bzJzvqKzNYbcE1ns3Jd0Ii4=;
 b=LTErzoou5KylzQ7QKmWQc07iTkZvVBokh88HrK6dlb97XgoB+jDmC5RyGZ1QsGUpeMga1950yjoKzPLkCjWYhntI6FpoWB6EOIkzJck/2/k1RT6/FvVni6MwzRqFJ06l9UoOjVJHvMaEt+WY3LITecqHpH7qqgHiTs9gu4jbfTCSpjFs3uqygcB6SBCZqBGx34pf8Eqmlz4n+GySWyP/EXAIKM8KADHjyJK2Yw0qlb7R4bap0f51r2Mq3H8eVvyWvRtYeXa8yMeAm20psJwvpdfzuTz/F9RWjzoj/gktjMNm0Z27o+31Aqa/9B1C27po1jnLcOBwXlWZFdiCmYaNNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtQ/ZhyxwBSLY8EXoD66bzJzvqKzNYbcE1ns3Jd0Ii4=;
 b=UkMTUr+gUQTFi5w8X1Qx2P2tJwcuq6dvk22G9dG0bf/nXl5rYbPpsWjtVNKf4NUfi4/BAyyTG5ZzipdPwgPVIEmHv57A2emqH6DGzx7tzqjNPp+fAEJlVtPA8rKyNdYuL478F833WRxniXEzQTfxi6ZCAc0OPI106njn/CN2/9w=
Received: from SN6PR04CA0093.namprd04.prod.outlook.com (2603:10b6:805:f2::34)
 by LV2PR12MB5871.namprd12.prod.outlook.com (2603:10b6:408:174::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 10:48:22 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:805:f2:cafe::9f) by SN6PR04CA0093.outlook.office365.com
 (2603:10b6:805:f2::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.30 via Frontend Transport; Mon,
 14 Apr 2025 10:48:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 10:48:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 05:48:21 -0500
Received: from hjbog17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 14 Apr 2025 05:48:20 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <emily.deng@amd.com>,
 <guoqing.zhang@amd.com>, Jiang Liu <gerry@linux.alibaba.com>
Subject: [PATCH 1/6] drm/amdgpu: update XGMI physical node id and GMC configs
 on resume
Date: Mon, 14 Apr 2025 18:46:50 +0800
Message-ID: <20250414104655.336497-2-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250414104655.336497-1-guoqing.zhang@amd.com>
References: <20250414104655.336497-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|LV2PR12MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: ae467cc9-f7a1-4a46-42e8-08dd7b41e07a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ECFDpahxDlcMaot7iS+z5druF2xldchZh0uq4srheXFJA1fV2M2AKvY5AEoQ?=
 =?us-ascii?Q?xjgy2KxC7l6lCg4QtE2cRh8td1xE/wU6Sxbs17RebNLp6TxhcCAZLVWXoJaO?=
 =?us-ascii?Q?4UuQ0G7dUMTlJC2d7V/kE2bqZVmfAkydB6DFSan+r1r07WVGA8cO3fcENuGJ?=
 =?us-ascii?Q?A77w3vjtbLD80dAc0GrvrzpHMALh2SViWqrpNjdYZAk95Ar+REtuRfqgZmz5?=
 =?us-ascii?Q?LrZcvJyut7RCUkHPazyinVSAiH/nSl/dZCfWWmQa2JOa1Nx06zZgWqr1MAl3?=
 =?us-ascii?Q?h8zYvmWZoIdk8BtrcihuX2/rikTCliMLaUDtIrW4bsvXPWN9Bt8MW8kxGhnY?=
 =?us-ascii?Q?fuipvsu95LMyKQuZx8pp8Gulff3CCd6EuTsKzouchybhzgp/FN4Dk5iG/R6d?=
 =?us-ascii?Q?n6tHW7LcZT9tXAMlzIFHH3F+v3SAqBbgLj+Frf0gVDg6gKW+Ihhj+yzjtCIB?=
 =?us-ascii?Q?mvR0CEuKiYrw3MbUjAS/tlONvGtz0WcgDBJUHe9O4Vts5I9VCEd3IsIpMpsf?=
 =?us-ascii?Q?HCBqToQKLuRZF7S5ocI2WA7jN7+YxgsmxPWW6MwSxKvtwdCwUJ9EeZc1cd8J?=
 =?us-ascii?Q?wGTiCPQpS4rIbYqJBW04wRiAETvLvOcvruVaNRmFFkP8chnpudt/yTmrbfRM?=
 =?us-ascii?Q?Trp1PDNh+iL+U3yzIXOSQYzfsk1PVeZV8R9nWneYhAYAo0UQj8mpfYSBaCmU?=
 =?us-ascii?Q?r0Ep8r4Kn+ECPxkzfcqdY5zis+cL3M9xNt+xX+oJ64KcV+KaQ+cwNM/s+lY6?=
 =?us-ascii?Q?UEYN7aYoHJiHbGe7LCzeNPT+fkkaLieuGAnbtR2i+VHevl+HvDLriIt0htm3?=
 =?us-ascii?Q?xK+Kzx/1gnKbWwXxQYypuNXN+Wx4GR0MRM8G73grN2YJ2T5LyzfcePsJJiWL?=
 =?us-ascii?Q?DtLQo9idZEshjsyJsSqBKiH+KfaqceT5hcDLyspMddy+6KTvSZYt8alm+dZt?=
 =?us-ascii?Q?2IrSaz3KYLJZimvfg3XOD2Bp7+E5lq0MM9LA1e5kO6ySc8uZZWbiZ0FjKmuu?=
 =?us-ascii?Q?p8UVlDjeA9PNrMr1Y6JofGMhbXu2WNZn6XiSsNOkNCWMPfDJtDJI2UCYNzZ8?=
 =?us-ascii?Q?qRK44YUNhgH+uJC/qStkWjfe9NXvrPXMTZ3SN+NJKdR6g3TOh4mDQ9pSTudC?=
 =?us-ascii?Q?kb+EgyN6jmA7cPxiPOcKA8g/2MQSQs1B/GGB6YXN83q+twLoNJbif+Dl45mA?=
 =?us-ascii?Q?bQ1kPwLVZskBtqGC60bgrQD9l76TdjgJCpqFONHbnKwPLOG33Uv97wSEQxLG?=
 =?us-ascii?Q?MM309kGCLURwhb6QVHmLqmRFuJA4kEQIc9rRR4xr2O9PQ3viSIk/FwLgBW+Y?=
 =?us-ascii?Q?vDjIFZbuq+lHX/euxlMQbHoljUhAhfznH7Ag+L/glBT/We873T7nZw1foVuS?=
 =?us-ascii?Q?Qdi9J/ZKsi3lGT2HcScjU5NEcj6CEnRAoRyfKtIIFI4zzyVywCCVJ0cKGgIU?=
 =?us-ascii?Q?fSqgK2SpSgAIhPNj/Kwc/Yr4vStmGImD+qCllNxF0lve2iZ8h6DdWUiu/pio?=
 =?us-ascii?Q?Iq5AKDP1edn5v4FxPmCjdKNYOX0IIcl8fCac?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 10:48:22.4896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae467cc9-f7a1-4a46-42e8-08dd7b41e07a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5871
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

For virtual machine with vGPUs in SRIOV single device mode and XGMI
is enabled, XGMI physical node ids may change when waking up from
hiberation with different vGPU devices. So update XGMI physical node
ids on resume.

Update GPU memory controller configuration on resume if XGMI physical
node ids are changed.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
Change-Id: I0bcac2d46fdeed66c9cf7e6a378134769c95df61
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  2 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  8 +++++++
 4 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f212ce3f5d34..12f115602ab2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5098,6 +5098,28 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	return 0;
 }
 
+static int amdgpu_device_update_xgmi_nodes(struct amdgpu_device *adev)
+{
+	int r = 0;
+	/* Get xgmi info again for sriov to detect device changes */
+	if (amdgpu_sriov_vf(adev) &&
+	    !(adev->flags & AMD_IS_APU) &&
+	    adev->gmc.xgmi.supported &&
+	    !adev->gmc.xgmi.connected_to_cpu) {
+		adev->gmc.xgmi.prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
+		r = adev->gfxhub.funcs->get_xgmi_info(adev);
+		if (r)
+			return r;
+
+		adev->gmc.xgmi.physical_node_id_changed =
+			adev->gmc.xgmi.physical_node_id != adev->gmc.xgmi.prev_physical_node_id;
+		dev_info(adev->dev, "xgmi node, old id %d, new id %d\n",
+			adev->gmc.xgmi.prev_physical_node_id, adev->gmc.xgmi.physical_node_id);
+	}
+	return 0;
+}
+
+
 /**
  * amdgpu_device_resume - initiate device resume
  *
@@ -5117,6 +5139,9 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 		r = amdgpu_virt_request_full_gpu(adev, true);
 		if (r)
 			return r;
+		r = amdgpu_device_update_xgmi_nodes(adev);
+		if (r)
+			return r;
 	}
 
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index ecb74ccf1d90..5b60d714e089 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1288,6 +1288,8 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
 
 	refresh = (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
 		  (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);
+	if (adev->gmc.xgmi.physical_node_id_changed)
+		refresh = true;
 	ret = amdgpu_discovery_get_nps_info(adev, &nps_type, &ranges,
 					    &range_cnt, refresh);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 32dabba4062f..3d5f01a1b657 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -89,6 +89,8 @@ struct amdgpu_xgmi {
 	u64 node_segment_size;
 	/* physical node (0-3) */
 	unsigned physical_node_id;
+	unsigned prev_physical_node_id;
+	bool physical_node_id_changed;
 	/* number of nodes (0-4) */
 	unsigned num_physical_nodes;
 	/* gpu list in the same hive */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 8d3560314e5b..7c7a9fe6be6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2515,6 +2515,14 @@ static int gmc_v9_0_resume(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
+	/* Update MC configuration if XGMI physical node id has changed for dGPU. */
+	if (adev->gmc.xgmi.physical_node_id_changed) {
+		r = gmc_v9_0_mc_init(adev);
+		if (r)
+			return r;
+		gmc_v9_0_init_sw_mem_ranges(adev, adev->gmc.mem_partitions);
+	}
+
 	/* If a reset is done for NPS mode switch, read the memory range
 	 * information again.
 	 */
-- 
2.43.5

