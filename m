Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B38C02190
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2025 07:52:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FAE610E337;
	Tue, 28 Jan 2025 07:52:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bLEMbln3";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8730410E337
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 07:52:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWwNLrRYqkqhvzr6+52p2dtSjKGrRSYODyCl++hfB7INlc4BF4dA/5yDuwtFqujt/XvNT605c9kw4h+PnHgv8cXYsr4CR9H4dfC+jfYYh+60gePEDRHyKQiRIi4i8GZ1nHQhQW14g7FkbNA6W7yo32hsh1ck81QZvAz8qTaZnuHmN95whB/uJfMCmjNDdDCezPSxNIecJe5GAmOeVmVixEV7u01W/bxDfIrxOy9CQGUinjnE7xDFvqUIeXY/8339kiAtBywF0klAvUfnAs5XdH7GXL7kNJYTgwgzz8njjJrLYTBpGJgP6eGGieWWPvAS9h7e5/kWP58cinY5lqpMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bF47YPRGQwIqhm2ygimVEeWzHXpE9MxUxZ3xSwrsqUA=;
 b=M743ajwt0Xy1BQhu0wEYoBkdAGEWMzjnsoSi88U2howgrkZteGH2M3PSgeeMp/dh2qz1XlhOi0ACmOEP3Zs2enaprYO18coDliuNrcM3BV8byPe1c21YQCYDEw60G9PPh+KcLEHnut2Td+M7vc05Hb1AQTqolBvOgxq5LmEYZX+JAC8B+ILA//hwPW9jJKv3NXqzyGRPcKqPU08soRImrjaELgR0ukiufE8SOXmZuRlKRL2H/KzcLBPjFnjhMq1pYkWaOtnewhd2ArmnYDjzd4biEY7QvKh6jcIaDdSc4+S8q6/tEloRwmxx9g9lc7R+d4RicfqGOO05G4ZSdbJkJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bF47YPRGQwIqhm2ygimVEeWzHXpE9MxUxZ3xSwrsqUA=;
 b=bLEMbln3Y7t/hPhoyeNGzRChhtIMwhW1tU3EnQ24cqY8Cv778wl78N90sB/IoB6gNHBbFb+72Ts21r/VTunxxLdfDnuvl9cMZdDNcM8RGcA1fHuLwuePlxzsbNH4WdoOyghkgGJ4QueeOeO4QPwEX94z4nx+oJgfuEiUIaEWeQM=
Received: from BN0PR04CA0188.namprd04.prod.outlook.com (2603:10b6:408:e9::13)
 by MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 07:52:28 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:408:e9:cafe::30) by BN0PR04CA0188.outlook.office365.com
 (2603:10b6:408:e9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.23 via Frontend Transport; Tue,
 28 Jan 2025 07:52:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 28 Jan 2025 07:52:28 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 01:52:25 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Clean up IP version checks in gmcv9.0
Date: Tue, 28 Jan 2025 13:22:07 +0530
Message-ID: <20250128075207.1695418-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250128075207.1695418-1-lijo.lazar@amd.com>
References: <20250128075207.1695418-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|MW4PR12MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a7ab0e-06f6-4e4a-c2ee-08dd3f70b658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9HKONn89nJAku57zU+7MELpb4GYJAggKQ4zoBhEJAyhHFW5aMxCCXiTtvD0I?=
 =?us-ascii?Q?YZMzggPMfKqMnCQUHrVavODRTgSGTGkqsFn1lF1oAM04u6RZPgfVsbYQZ2cI?=
 =?us-ascii?Q?4bycWfCFoILEGUGoR9ooDSOLDfzdyffZ0P3FqqyKjulT8bM9BbRLs2dZshI3?=
 =?us-ascii?Q?CWSqnldWBHgvXd51HsG2Uw76ysayUHdeH+LhK9HeGPg63UKM4SwQDUIVJEA+?=
 =?us-ascii?Q?hVKuH2AFB3bGhrG/wW4qrC3sRqkL5IQI0qzxTjjH7QkmmBdo4Eo4BZjAAo8m?=
 =?us-ascii?Q?f5q0YJ07GIcjmLu3h3GV5VAwsV64X8jVAc3BJcMY05+D8VJrAYSZ9+QN1AbX?=
 =?us-ascii?Q?Wu01VszvTnYdmo242pUlj1bPiW6Q9UlaHugvJtW3uz/fqhA4/6s1uJpp9T2x?=
 =?us-ascii?Q?pYTuymTpETzt8oKqzRtpkp/StGzuDbbtlothrwNDDYwl2RnMhRquDgKLGJWp?=
 =?us-ascii?Q?tQ/HKZ1tfmAcKblf2l4fuG38DpRtdENHi+KMj3sSnxLsze8LYhEGhhAixGGp?=
 =?us-ascii?Q?PfU31LYyjfY4df+S/F8PpizUMipqZA2yVZHD/SxrlCdancFPf44f8cXvFhvb?=
 =?us-ascii?Q?EaxQjeV0Om4OgLmSSFgEB31deDXtqRFjYi05hXZjpWgDd1xiPHnB+VAa7WEO?=
 =?us-ascii?Q?RKHF5IPh+J84gl9SJnJIOtrSFvTvocpVTYXlBtegAjwCDiSEP8JCYfYGuJWz?=
 =?us-ascii?Q?LKIbz0x9BjRuN44fK63j7FmJFWWR2SnfoZK5+lFB3MLxjsAKzAg1781/Vpsg?=
 =?us-ascii?Q?tgX0kJpJovea4f5x1rJ+L8rkgz0MBE6WKDIm3eDX7by4LdhISJPnw/E0DEVu?=
 =?us-ascii?Q?K7nN+m80gwk468eGVsQJMdoOkRRvSDv7c/r7siH/aX4fJJD1aQ+UqOvTe3wz?=
 =?us-ascii?Q?GqXTheXN8xllpMGVcOBsPhAY/6lvjOFYvqKsHP6cIs6UNcCtdgSsQHbep0Hk?=
 =?us-ascii?Q?mFkfLheeqD03HOu5QKBApYpJrRa1zt1yCVuQextPgPToODb3SQ3Am2uMhkJE?=
 =?us-ascii?Q?AZGhYcqNHT6il9e+Yu47J4ibZdmsZ5bKqj6mf6f9EP2UEaRYM0simlG20kSO?=
 =?us-ascii?Q?LrEuc8F0GZVxioUin8JhV74mR1jMptHPutxTIZ+9O/Cpio7qpstww0yN7Tjn?=
 =?us-ascii?Q?C4bFMFb4jLHUgvQHCrO6/c3zsDwHcWHyw6RfpNAfbgtLOQ0uhwUHxUohxUNi?=
 =?us-ascii?Q?1wYY/uzFC9yKvh5PpDvuf5gve20yxsuf0EMwWfb01ck9p0db5a1NT5C/FxG+?=
 =?us-ascii?Q?asxWnYBkck+4unMPkra9tZQkdmMoKUu1S3ViBZyprPdivfEu0c/95tkBKN84?=
 =?us-ascii?Q?UhdTJr5LtGUJTGSLFGLXdjXY+nThVakZDGGKZYFVLNO+VZKwLCvl/tgnxu6/?=
 =?us-ascii?Q?yXu9u3o1Dv45M3hlPUKBEirXrb/BEkgL0GwFIgZ3zF5x4silm31NrHrAXbv0?=
 =?us-ascii?Q?3yNiwL9b4Lmwu37vntMG0a4XpK6HMF9d216JGcgZIRXusV0jtmixmvTijozK?=
 =?us-ascii?Q?gUhpfZc62Q7Q7mw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 07:52:28.4010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a7ab0e-06f6-4e4a-c2ee-08dd3f70b658
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7309
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

Clean up some IP version checks in gmcv9.0

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 49 ++++++++++-----------------
 1 file changed, 17 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 657f132405e4..51f249171f5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -411,6 +411,11 @@ static const uint32_t ecc_umc_mcumc_ctrl_mask_addrs[] = {
 	(0x001d43e0 + 0x00001800),
 };
 
+static inline bool gmc_v9_0_is_multi_chiplet(struct amdgpu_device *adev)
+{
+	return !!adev->aid_mask;
+}
+
 static int gmc_v9_0_ecc_interrupt_state(struct amdgpu_device *adev,
 		struct amdgpu_irq_src *src,
 		unsigned int type,
@@ -647,9 +652,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 		addr, entry->client_id,
 		soc15_ih_clientid_name[entry->client_id]);
 
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
+	if (gmc_v9_0_is_multi_chiplet(adev))
 		dev_err(adev->dev, "  cookie node_id %d fault from die %s%d%s\n",
 			node_id, node_id % 4 == 3 ? "RSV" : "AID", node_id / 4,
 			node_id % 4 == 1 ? ".XCD0" : node_id % 4 == 2 ? ".XCD1" : "");
@@ -798,9 +801,7 @@ static bool gmc_v9_0_use_invalidate_semaphore(struct amdgpu_device *adev,
 				       uint32_t vmhub)
 {
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
+	    gmc_v9_0_is_multi_chiplet(adev))
 		return false;
 
 	return ((vmhub == AMDGPU_MMHUB0(0) ||
@@ -1278,9 +1279,8 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 	/* Only GFX 9.4.3 APUs associate GPUs with NUMA nodes. Local system
 	 * memory can use more efficient MTYPEs.
 	 */
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 3) &&
-	    amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 4) &&
-	    amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 5, 0))
+	if (!(adev->flags & AMD_IS_APU) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 3))
 		return;
 
 	/* Only direct-mapped memory allows us to determine the NUMA node from
@@ -1555,9 +1555,7 @@ static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgpu_device *adev)
 
 static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 {
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
+	if (gmc_v9_0_is_multi_chiplet(adev))
 		adev->gfxhub.funcs = &gfxhub_v1_2_funcs;
 	else
 		adev->gfxhub.funcs = &gfxhub_v1_0_funcs;
@@ -1634,9 +1632,7 @@ static int gmc_v9_0_early_init(struct amdgpu_ip_block *ip_block)
 	 */
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 0) ||
 	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 1) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
+	    gmc_v9_0_is_multi_chiplet(adev))
 		adev->gmc.xgmi.supported = true;
 
 	if (amdgpu_ip_version(adev, XGMI_HWIP, 0) == IP_VERSION(6, 1, 0)) {
@@ -1645,8 +1641,7 @@ static int gmc_v9_0_early_init(struct amdgpu_ip_block *ip_block)
 			adev->smuio.funcs->is_host_gpu_xgmi_supported(adev);
 	}
 
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) {
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3)) {
 		enum amdgpu_pkg_type pkg_type =
 			adev->smuio.funcs->get_pkg_type(adev);
 		/* On GFXIP 9.4.3. APU, there is no physical VRAM domain present
@@ -2087,9 +2082,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	spin_lock_init(&adev->gmc.invalidate_lock);
 
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0)) {
+	if (gmc_v9_0_is_multi_chiplet(adev)) {
 		gmc_v9_4_3_init_vram_info(adev);
 	} else if (!adev->bios) {
 		if (adev->flags & AMD_IS_APU) {
@@ -2239,9 +2232,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_gmc_get_vbios_allocations(adev);
 
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0)) {
+	if (gmc_v9_0_is_multi_chiplet(adev)) {
 		r = gmc_v9_0_init_mem_ranges(adev);
 		if (r)
 			return r;
@@ -2270,9 +2261,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->vm_manager.first_kfd_vmid =
 		(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 1) ||
 		 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) ||
-		 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-		 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
-		 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0)) ?
+		 gmc_v9_0_is_multi_chiplet(adev)) ?
 			3 :
 			8;
 
@@ -2284,9 +2273,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
+	if (gmc_v9_0_is_multi_chiplet(adev))
 		amdgpu_gmc_sysfs_init(adev);
 
 	return 0;
@@ -2296,9 +2283,7 @@ static int gmc_v9_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
+	if (gmc_v9_0_is_multi_chiplet(adev))
 		amdgpu_gmc_sysfs_fini(adev);
 
 	amdgpu_gmc_ras_fini(adev);
-- 
2.25.1

