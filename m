Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D8FC83028
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4E0210E950;
	Fri, 27 Jun 2025 03:40:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UnSP60Jh";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32F2010E944
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SjDn4kor1f6I3cpMJ6WT3sqUco3A6AzfyU5A6yN+PekNIMUp3pKcdP8Yl2XCq5MoMChyyFecqFECckmQUOaSF2fnra00Wz0Z9fNI1Mnm4UdK0aRmcKGQDbZ5usDwhFZ5/zM89lrmzVDAwQfzx/bFP8A5bRsF1KaELdXx8AbUpiIROFFr0ypa54GNAfPkWtIH3pNBk6DbmT6scxjTE7xFzwHOR6qzsk+ri4wASKqYj0mJrPi6FLGBWlcKM80qecxbCh5KQqQwDKieE92ArcdPx/6ll8zpA1+ItyFRsMhT8GU8N4sRJDitUAZurZn/UGI+zlVXuSProajGelABxw3gUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1aE+n6vOIIcTyD0tJb3qdXNZ8hyo7zb6YRzBI5AR1A=;
 b=ALw/XX1gCCBEB4UH321z++byZB4MMTBC0eY53BT/6ohy+sSr93yjIw/ZUzlh2K4kY7gbraSVkVcpJSqF7uXpwj2IX8K1cJi4chSqGljewS7nTPNTG2SIUWhXfblcfSJ3B0tKOGsKvF+74xeT2xYgCz5eGDB5GWyzbjn+LaMr7LRGIzD2ENyIRDDpUcnlwU+748eS+f6tPf4ci8RUYH1aQZObBNWXwG7Aps8WmrDYxirAvlbvWfgu0c4DQwlVGhdKhzd3P8Wmk/uLkAQOl9I6lOVfluFWT+hjSdrrlXtoGlvsLsgX37C7IDbmhim4KnBRcwEqKKG32j/Vh8DYDQgIow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1aE+n6vOIIcTyD0tJb3qdXNZ8hyo7zb6YRzBI5AR1A=;
 b=UnSP60Jh6f4U0Qg0jmCjju8nxWD87JGSj5qNP5FWYLvC2Jai4KGM0LuuNdzn2jK8NS+qriSSxE4taw2G7M5I2QtXvFxWKDlmhYxJcAjLX3tYgSoRKRL09hfzApdtHkY8ujLagnsvv7VhjQH2vE1xkYes2PuRx0ujkHp7ITz/GTA=
Received: from BL1PR13CA0181.namprd13.prod.outlook.com (2603:10b6:208:2be::6)
 by LV3PR12MB9410.namprd12.prod.outlook.com (2603:10b6:408:212::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 27 Jun
 2025 03:40:37 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::3d) by BL1PR13CA0181.outlook.office365.com
 (2603:10b6:208:2be::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.11 via Frontend Transport; Fri,
 27 Jun 2025 03:40:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 24/33] drm/amdgpu/jpeg5: add queue reset
Date: Thu, 26 Jun 2025 23:39:53 -0400
Message-ID: <20250627034002.5590-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627034002.5590-1-alexander.deucher@amd.com>
References: <20250627034002.5590-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|LV3PR12MB9410:EE_
X-MS-Office365-Filtering-Correlation-Id: 779b14a7-9d91-4d12-1fef-08ddb52c61ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KhbgM4M2nps5MQZzRrQ3GKVcUH9vbWggErOFTzQzLme5EHvj+Qho0fi9hH+a?=
 =?us-ascii?Q?u7ehdLwiU2LiqrOdN7Y87fDtfp2KVs9HWCIW9Zj1nutbVFatBEZIO5fqiNs+?=
 =?us-ascii?Q?oJoDa0KTOuYEAZAMTRHrkXyyDYEgV8j+Qwsb5vwiNv8IBuPplyQizlFVxTVM?=
 =?us-ascii?Q?huf069wAvkt9COq99VNQXAZAC1Z0BDEDhZ9fK/K4jY6UR2bHH79NaZHzI1hn?=
 =?us-ascii?Q?kzz+x2vu51TXUEH/TyZIuflYbpjFH40jGxWSD4bvf6JHdlIaQyUm9QM30C+A?=
 =?us-ascii?Q?98q0mr/+9iCWLf0VvoZbEpxG5c6I+kGqqCwziY8kA3M6VCiWRlx3+O+819/9?=
 =?us-ascii?Q?y1yfpvVOHvG5l7+aAlvE43rrGKP1J2P1ujWkb27d4EJ13EmDS5wG0Jm0a+wu?=
 =?us-ascii?Q?b+nxvVq+TOrEH5U/6riNn7o38FZSRBO4PV0XwIow30Ax+RdiIbsi+gcDVYxm?=
 =?us-ascii?Q?c5ZCOputXXG6CGBwWzkXYuqX7x5UMKTYC2ZvK3cSSzyfQfeBDutm0ZcUovXK?=
 =?us-ascii?Q?JnzewYkVwFuCN10qdCykxmPAl/uCU/KW47/h6L37FO42vykweeZnY86DMNtw?=
 =?us-ascii?Q?oxmsC8T8KVck5z1MOySUCgIxXChdYYW5wQJIJpFMVD0w8utRbxNLidgsPA7N?=
 =?us-ascii?Q?O9afeiuzgX2+2HbB9hRuvy7tfBXS/9l31GAJTJGwnYAc1llnj3t6wp4bFMcw?=
 =?us-ascii?Q?+45EkeL364GyOCLt7Mc+WJgoQ1A1ofq/9xQ/1l6KTd86XHyzb8eJ2vdueah9?=
 =?us-ascii?Q?sBeIYGmvs90je0yOF2ePeygui80oPssuZL87wJCKuzuS9V/DYlcvrkTvoXVU?=
 =?us-ascii?Q?G6ry5V3mzIjnITGtH/36AMngjlGla2MatL3MPkfKJih/QOc+L3ffMMwHZQTG?=
 =?us-ascii?Q?cX7lbFuNYMwEkfysXd/x3DcP6ehIrS0OsrU1h0HCCqtJeeWmJg8mN3/cNHxx?=
 =?us-ascii?Q?qsIMqDxf0BJBDqjEkY8ay8borcbHMIjstNvEK8PGXdqvcTbFk36NsvI+D1yL?=
 =?us-ascii?Q?BTU1Z7TyO0VH+9liTENr5NUIAnsI9DGrFp9CBw9zQaBofKEfqooba5bwQ3J8?=
 =?us-ascii?Q?tQNmUtb+gFsnJfbgMGHXh1BD8VuuMPYRqisUs2Qn+MuMBIK+9sNo38GPebbb?=
 =?us-ascii?Q?gDGbSAQHbtTb0sytGxWsS4fzMEYAcarWdVPB2AgH/H0Xk/53/l3yLvt5CUPv?=
 =?us-ascii?Q?IyqgZXCclX3iRn2dXgH2QpDX3YR/GS2nWeEMkDvYa8Wpld/qD4UOiUWspJZs?=
 =?us-ascii?Q?b7bDYHn5rVi5H9VHdBBoHKwtfywdGNJo3KbmtUwmdTI+c078WMpMvlAbg0VZ?=
 =?us-ascii?Q?zICcw3o4EOcA04Emw9WWrnUN4aO+bfE1n/Z319gX0iwP6szy+KoEZN34oyfg?=
 =?us-ascii?Q?TMaHC4+p5OLNxEZrsjLEIfW+2CPBEPvlj1Hn+OgoZ2WlH1BhvXySlI6NMw0K?=
 =?us-ascii?Q?PgtkJ5mersyWe7ZWaArxAh91Mtq22RW8ZAIyhkBPRo6rcIV9eeSB18uDiZrg?=
 =?us-ascii?Q?IH6qnDZIgmUzefe2juSMFKtI3gWauX0zHsfG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:37.7911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 779b14a7-9d91-4d12-1fef-08ddb52c61ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9410
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

Add queue reset support for jpeg 5.0.0.
Use the new helpers to re-emit the unprocessed state
after resetting the queue.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 31d213ccbe0a8..351e21494365d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -644,6 +644,19 @@ static int jpeg_v5_0_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v5_0_0_ring_reset(struct amdgpu_ring *ring,
+				  unsigned int vmid,
+				  struct amdgpu_fence *timedout_fence)
+{
+	if (amdgpu_sriov_vf(ring->adev))
+		return -EINVAL;
+
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+	jpeg_v5_0_0_stop(ring->adev);
+	jpeg_v5_0_0_start(ring->adev);
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+}
+
 static const struct amd_ip_funcs jpeg_v5_0_0_ip_funcs = {
 	.name = "jpeg_v5_0_0",
 	.early_init = jpeg_v5_0_0_early_init,
@@ -689,6 +702,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v5_0_0_ring_reset,
 };
 
 static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.50.0

