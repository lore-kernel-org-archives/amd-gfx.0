Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CAAC02198
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 22:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62D7A10E2EA;
	Wed, 12 Feb 2025 22:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PbS1U28R";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A16A10E2EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 22:04:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEjo1iIh7AgQYNGITUwWJvKaK4ai/wrPTslgf8F9VsyJ84HZ0euGXyw6KyhpsOtmvjO98pxvihRZyplZuP/cSL+VPwfIaNFyZsFMjXI0YzGBZJriKKcRhvch7n2WsV5Ma7ysG7QJ1RaUmKdZ9aIsLh0M1Vz4BntkAEyPiU4AxZY4W4cbL0Unay+NV3Q5N+oICnZs1o1VRQY77WXmhaGnW37wdeXJGL8Lfa80vUMd17gCWmIcjAgiTt6uRGEUuniJMrPJX284TWX2OZlj3vBFVNa1HSxtl3+aqjVJcJ6G7BZKp0g/33IyLXHYJ3ogSeAmXH1a4LHlacRAEUms+2Zf8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYOmb2Ss+kMDdA61Gha/2c4pr2zyXxF+U6Z4kecLtGM=;
 b=XXG8f0v3IxqXTaLY1dQexun0G5WHl3K4xfKXJDdrfYxia12HMLLsZ9QrKFYiPI05Y+Oqu1+NyswooKW5+c4S/F4QQpRB1zembT+bo5Xpbq+38aJQUJ+P9xdeax9qhGM4iLq47sFpV1Ywm0doOxTermcNhaUDxKyrbn8MWvFxEg0iqMolCTSovPxaT9COLJI5nowscFMY9D4v1F4AtT+gqJ4SrToBvQ2XBAJPSmnmdVWgtgCXVvcapecnzfWwBJsmHRsK1zSJ8nPa0za4FOLFTisRhnRgZYiuafdsPc58dGwaP0dPO3uGbrKLqtdz35ueH81EJZfxZE9qa38B56RsKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYOmb2Ss+kMDdA61Gha/2c4pr2zyXxF+U6Z4kecLtGM=;
 b=PbS1U28RU/GTxFqZUXGIXhhbt4EFxTc+iewdTiGwibahWLUTvIpCxw3tEiVP6z3f+igywlnJ2DrzAyGRwZiT4yRBkCUQe0r/3kuYWADFFyL5V4JgS+Znf+rVDIEnK2fyOFBNu6GJXoXeE2TWHpE7lrX4E1XNmx+hxL8o3stK1IQ=
Received: from PH7P221CA0059.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::29)
 by CY8PR12MB8066.namprd12.prod.outlook.com (2603:10b6:930:70::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 22:04:10 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:510:33c:cafe::ef) by PH7P221CA0059.outlook.office365.com
 (2603:10b6:510:33c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Wed,
 12 Feb 2025 22:04:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.0 via Frontend Transport; Wed, 12 Feb 2025 22:04:09 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Feb 2025 16:04:06 -0600
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Don't modify grace_period in helper function
Date: Wed, 12 Feb 2025 17:03:40 -0500
Message-ID: <20250212220341.373072-3-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212220341.373072-1-Harish.Kasiviswanathan@amd.com>
References: <20250212220341.373072-1-Harish.Kasiviswanathan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|CY8PR12MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: 316ab56f-5d32-4d11-4af8-08dd4bb12d50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9KfA8eenCD5Do9XDCyVcqU3+CVZlZSJKmx+lyjqryUzL9V0u6ZOrAx7ryTfI?=
 =?us-ascii?Q?J4wcCw/5IHxph/PniDWSwetboC/9fq0faBQ2s42+gVioFQW3SZpDoZam/qRB?=
 =?us-ascii?Q?flaLygEdXD9N82C6XFMatWEAXF4iahs1w8dGR11WJ+oCxoAFMhaKYQHTepGg?=
 =?us-ascii?Q?yFYmPtC7q7bEkLYWoTbGfFKdLXiU/3mIygRw4u70sWCzGC4cpDBEuEbQsRlC?=
 =?us-ascii?Q?RS6X559hIjrOFoKGM4MAg50BxtCOekvvcCFh2dKgnxewgtd3t4TgPQ6IMXFM?=
 =?us-ascii?Q?edtqQhFiQ53iG3Ekwll3h4baO9wAxcLDcy0KKtpHMiuNRIp3OwAvMDPF3rFb?=
 =?us-ascii?Q?0T/uRhC5hhSLWpMC3Nc4TZJvij/Knvuvx66Lye2FkS/EzIOqp3E72c1LVJlR?=
 =?us-ascii?Q?uQxlPP6N9ftj8lC6ArPjIXuaOveo3zZZ0ldKmp/RKtBWPAmQXxnM25Syi0Cv?=
 =?us-ascii?Q?Jv7wkUFn7aMwSj+PcHvDdmeOshn2DkNHOmeonjG+tmexhcls3ZNSKdPlYF9Q?=
 =?us-ascii?Q?Dy6aZsX2Q+S/ediv8N8bmoLHRbmB8BfBfPatmbFmZ9esH1Udi6QgLIgDFK9d?=
 =?us-ascii?Q?saPbytCFMp1WgIAdNohwL49iCX8WT8iQjdpHTbpUH0mHbrEsGo6vGqewDppb?=
 =?us-ascii?Q?j+VtgRlHXdZhv9mCYZBa8tMVkxJvdbzzk3VR7lshBQdqomGK6JTEM8Or9axu?=
 =?us-ascii?Q?H+oWfPxSZ3SfroYLVCDgQRzmakofDYt/odHk0hwDJvDyxsZamCd22gV++Soa?=
 =?us-ascii?Q?PjrKVVB9VavQlaXB8fbbsc2bCN4G2500KLuM/c0bAYeyaavw1WamlnpwAMIM?=
 =?us-ascii?Q?XEoF68Da+b9+6jGGd72fG32cmK/CKqeAeRBDZPja/EjhKZ9LI6MCRBks6EjX?=
 =?us-ascii?Q?j46q9atALg+3ijckyU/O/fQXwSniZQjaVA0mFBtyaveROIjCQwuALIWaeU3e?=
 =?us-ascii?Q?uwFC9iSSW4m3xV3paznUUT8l1wHXl4hmoDlZhEsMpUy4xmFg9y8Ugpu2ne97?=
 =?us-ascii?Q?0tQQmnTbRQCFP3G1SBwjqz4PlueL2nIVYhj3LRkIEbzjn5btw/M4ECK7TjKa?=
 =?us-ascii?Q?JcLYIsZzq0hshUFZ3DK6hbFWWDN9jividrOkrezDHMNePgL78gKLA6Br6Hma?=
 =?us-ascii?Q?eVgDhwPFzXfA/Xju31/bAZHsOy/wF49sUNuXLjuorvtRdJVheqr/1mebSQNv?=
 =?us-ascii?Q?/rl0+vTYjfp9FlQyDoZgAnfh7EUcLLRSTQsWPTRPI73YHBiuuwpK4NpM5d+A?=
 =?us-ascii?Q?lWpExG+lbjqlnpQbNZcmW4taVTptpqIbT4RvRNbLFHWGMI2BLqidlqGdqpbJ?=
 =?us-ascii?Q?y1pNc+wgO26tONMmSBO5iT2dKaNop91OZA0C9q+TYSdDTfOoVVhqVVPkeeze?=
 =?us-ascii?Q?ZfdsveA23iV8JeNv38J2fak9rojYECN8L37whPpm/3Cxeg/9DmwK01dwNnOg?=
 =?us-ascii?Q?FIQu3ToP+Xr6qfu1ABI1/DtEuY3LFzCAfFfgwuogK7qcoWZub9qA0xMK88OB?=
 =?us-ascii?Q?TsPjBmRSWSFrvgc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 22:04:09.6447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 316ab56f-5d32-4d11-4af8-08dd4bb12d50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8066
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

build_grace_period_packet_info is asic helper function that fetches the
correct format. It is the responsibility of the caller to validate the
value.

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 18 +++++----------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 17 +++++---------
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 23 +++++++++++++------
 3 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 62176d607bef..8e72dcff8867 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -1029,18 +1029,12 @@ void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
 {
 	*reg_data = wait_times;
 
-	/*
-	 * The CP cannont handle a 0 grace period input and will result in
-	 * an infinite grace period being set so set to 1 to prevent this.
-	 */
-	if (grace_period == 0)
-		grace_period = 1;
-
-	*reg_data = REG_SET_FIELD(*reg_data,
-			CP_IQ_WAIT_TIME2,
-			SCH_WAVE,
-			grace_period);
-
+	if (grace_period) {
+		*reg_data = REG_SET_FIELD(*reg_data,
+				CP_IQ_WAIT_TIME2,
+				SCH_WAVE,
+				grace_period);
+	}
 	*reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 441568163e20..04c86a229a23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -1085,17 +1085,12 @@ void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
 {
 	*reg_data = wait_times;
 
-	/*
-	 * The CP cannot handle a 0 grace period input and will result in
-	 * an infinite grace period being set so set to 1 to prevent this.
-	 */
-	if (grace_period == 0)
-		grace_period = 1;
-
-	*reg_data = REG_SET_FIELD(*reg_data,
-			CP_IQ_WAIT_TIME2,
-			SCH_WAVE,
-			grace_period);
+	if (grace_period) {
+		*reg_data = REG_SET_FIELD(*reg_data,
+				CP_IQ_WAIT_TIME2,
+				SCH_WAVE,
+				grace_period);
+	}
 
 	*reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 6a5ddadec936..ecabf95d972f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -307,13 +307,22 @@ static int pm_set_compute_queue_wait_counts_v9(struct packet_manager *pm,
 	uint32_t reg_data = 0;
 
 	if (wait_counts_config == KFD_INIT_CP_QUEUE_WAIT_TIMES) {
-                /* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
-                if (amdgpu_emu_mode == 0 && dqm->dev->adev->gmc.is_app_apu &&
-                    KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 3))
-                        wait_counts_config = 1;
-                else
-                        return 0;
-        }
+		/* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
+		if (amdgpu_emu_mode == 0 && dqm->dev->adev->gmc.is_app_apu &&
+		    KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 3))
+			wait_counts_config = 1;
+		else
+			return 0;
+	} else if (!wait_counts_config)
+		/*
+		 * NOTE: The CP cannot handle a 0 grace period input and will result in
+		 * an infinite grace period being. This is not an issue here since 0
+		 * would just set it to default value.
+		 * However, grace_period needs to be explicitly set to 1 for avoiding
+		 * any breakage for existing debugger user interface. Currently,
+		 * debugger interface expects value 1 when set to 0.
+		 */
+		wait_counts_config = 1;
 
 	pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
 			pm->dqm->dev->adev,
-- 
2.34.1

