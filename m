Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF20CA0EE4
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Aug 2025 11:17:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 904B110E928;
	Fri, 15 Aug 2025 11:17:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hju4hm2x";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1415C10E928
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Aug 2025 11:17:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWBX9pbtRO3RcedncDy0NvOvF+1ilOEQAqjbXrvHyBB5285LAzNvO0YMZtrTbci0NPdcmWGWHbC57DTXcKUToVyKX1duflTohN1KxiDpPuU5i1dp6kQG0ZbBsbMOKvdoxYp3F/bck+gYUFqfbe15AgIaJ3eQw70vK6IYJ+IEzm+SQCiw+FBvIGFo0TO4GUUCWwytF/t9SnNpL2e9YNugx+TCqcvvPROa3jF9P6nqNgD1w4Jg/4rlANBuGcQjI724hMqiZvgPdDavMukTyrAKiWWJ+C85w9sOuYU6JOOaItGWKvfDBeVV8s1w1I8imR0J0NhWcnbjHAUbcr3UIgP5rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAGMkc+r3gvrNFbq7A0SRo4MH8GeXjc0o3NQkwbWPNU=;
 b=BMddHkgycinb/ErdwFtA29YY7szXxtwaH2m6rJYxRdRZwupiAVbg75/0Wk64MOikxTvs6IyiuXLgQ745Qfy1yv9a0MG2YWM4nGHE8iwUwVLVdGtqtK5y0IqnFDkr0zbEIoQpC6H+74ehW27j1ftpDVCpcI/qwM8zCbEnd8v7ZOMJ1I2t2XOZQ65JZikqkfBoK7Tc5cQM+4kLDlXmbgPi91KcB42Of6fnMWq740IxgG+ikzgVlydH8SLDD9e1BFQasqluvL3ZAwUu7baTcOCgEH37vB7N14AdWgtT3WvOdb3dxpvri5a4vO17tsm66xwbMiE8ayfs61KAvGilNIsWiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAGMkc+r3gvrNFbq7A0SRo4MH8GeXjc0o3NQkwbWPNU=;
 b=hju4hm2xDEyF2FuKwxPLI30dQRvVnv3QMWpvSbJ3AfuFfAlkQJdIca42Vy54YD5qG4GLcXpAFfNWtFM1+0rtlOmADHUUs7Y9i2zbIqncrCnuEElb7/5V7BsVG+aMvpAUVV4as7a607xbnTUGiJA2p86E9W/UERl/v17kW0ItT3w=
Received: from SA9P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::25)
 by PH7PR12MB5617.namprd12.prod.outlook.com (2603:10b6:510:133::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 11:17:43 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:25:cafe::91) by SA9P221CA0020.outlook.office365.com
 (2603:10b6:806:25::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Fri,
 15 Aug 2025 11:17:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 11:17:43 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Aug
 2025 06:17:41 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Add vf critical region check for poison injection
Date: Fri, 15 Aug 2025 19:17:11 +0800
Message-ID: <20250815111711.114228-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|PH7PR12MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: e8aae86b-1fc7-479d-6d07-08dddbed5aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9wfh1FMFZhBmN30vlZ12HW8k5JIFgTgqNW6YVpjE+oJPqbNaRkVgDZfL7ouz?=
 =?us-ascii?Q?fduuyF/hgWizGItcb76wsxfBsaZeN1a7HlPkH81mrEa3uIaQwLbOXdZ3lkbl?=
 =?us-ascii?Q?1zS85Aysat3YzQIEqBFrZ8jCnEH/zg/7Mb2Hcs4RfCFpy++zzs+/je/kDPZm?=
 =?us-ascii?Q?opJtmHEs3NWJqvNL9iXxc9GKdD0oM3rJgzRPzdDM9o4XiSu16VghayoIRVuH?=
 =?us-ascii?Q?ErCVb6IGPhJnyi7B3jnlQUvlswJssmHHGFJzjjTBGvLJMvgqVlvC+GFv8Yr4?=
 =?us-ascii?Q?hTzlTTQ5tsqbDVP58xpEMpXPuf48cfzQ6+cZknwrZ0hnNbe0V9/h2hkIyipX?=
 =?us-ascii?Q?0NnWk1V+q0J4r85yZ4rdFCgRpoTp6Q0S+9h+oPU6dsyldx89gFqkqG47PHXH?=
 =?us-ascii?Q?cj1CusYophaj+dTOJLYXaa4rJR6ffpzVSrWksep4nkOQfxIihQo4f/jKGpEJ?=
 =?us-ascii?Q?VdYXd6CqXjaUQ8lod8B/HpF0R1S5e5m7HJPmoNP5ocbBH7h0nhJGuge2Zt/X?=
 =?us-ascii?Q?qPwyRsVnZu33/kEecJ0tvlWBNNaQu664rxQRoYttMcrNye+tOstgJEZxrbtF?=
 =?us-ascii?Q?3NQxPZZ09Wfsk0qHF+VvlY912uTqbhHSMqjyRspzEG9TdqvfBuvLSFE2a/pc?=
 =?us-ascii?Q?rkS2PSmgrLiYQQcmSFJGFOP/vKxRBsL8yfEdZ5CANh8KQR0Xa1mZ0moqdqaE?=
 =?us-ascii?Q?GUMqePNTML+B9CyzowqykbYFGT6E4Lol4cFbKkfO+JSlMJCKvCpWMzxPHQqi?=
 =?us-ascii?Q?Bwv1P6Z5IRCgXGpJyxT7q84QpSiBJzLeCu+9waMvLhsCro2+Y2iodnSNb83q?=
 =?us-ascii?Q?I3kc/58sVR/li/XHP5EVJYqTNX4zj7i31KppEyDwRhLzcAbIVi1t+mpQPUt+?=
 =?us-ascii?Q?yJDT3R0NA6AGjzWeFrft7fHxtMB6gJSLslgAgKPlbWeDckYPRF7fTD4ntDyd?=
 =?us-ascii?Q?Q+EVludqmmk45qGbJY3bZVM/S+wkkLKR526jpjwyGWcLn2FCbz5ZL5qQNbc2?=
 =?us-ascii?Q?5E/dGS9NrTfZbAM5BdjZOBtHxy2FdgaTIpGL3Q8YSIdHzk0kyXNojwuyF09U?=
 =?us-ascii?Q?CMITcSNFbtySLg3szHFcAV+YXS3B+86xCT5RczlDImIJAdgouTmYsFGtdaNm?=
 =?us-ascii?Q?3Hqx7lkUaQH1fBKHcc4xdAiwayaRhVNSsHM/dcRdlEfHMQdCI1fB3Dgwb37p?=
 =?us-ascii?Q?9ofL8MxZ+mqhIBxK67Cwa1WW+BQUTs8kHAQyyiqShiS1P1LFUPJWNIaX5USD?=
 =?us-ascii?Q?nCRjkbf06t5ftynNusHJrljvnZYHRrWi9gSZTi04POlzM6hs3PC+TCW4qm2F?=
 =?us-ascii?Q?UUQtDixz6JYjd4fZY7CjyfRMO0AscRLjZmt948P9Qn+r0XuoJ5Y97o4xtvsm?=
 =?us-ascii?Q?Y/a9mcS47Qvht5mg0xmTtJW0CQ7JFWyoGQoATDBekE8q+Xf7IZvRxswxoy5q?=
 =?us-ascii?Q?Eb/DaXMy+AEPj5VszKA8c6kEuNMMFCC1RriDQlyJOowOHMa4yHiC6sdwPHGh?=
 =?us-ascii?Q?6Pku0tfgauiFNLp2jyIqkNuy+0t1CmqikQ8A?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 11:17:43.0606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8aae86b-1fc7-479d-6d07-08dddbed5aaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5617
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

Check poison injection address whether in vbios or data exchange
region to aviod hitting vf critical region in SRIOV.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 38 +++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b00cbb927ca8..158aa4ac9327 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -212,6 +212,31 @@ static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_t addre
 	return 0;
 }
 
+static int amdgpu_check_vf_critical_region(struct amdgpu_device *adev, u64 pa)
+{
+	u64 offset, size;
+
+	if (!amdgpu_sriov_vf(adev))
+		return 0;
+
+	/* check pa whether in vbios and data exchange region */
+	offset = adev->gmc.mc_vram_size + (AMD_SRIOV_MSG_VBIOS_OFFSET << 10);
+	size = (AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB << 10) +
+	       (AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB << 10);
+
+	/*
+	 * Add an additional 4MB to critical range as we cannot reserve allocations
+	 * done during guest sw init
+	 */
+	if (amdgpu_ip_version(adev, UMC_HWIP, 0) == IP_VERSION(6, 7, 0))
+		size += (0x1000 << 10);
+
+	if (pa >= offset && pa < offset + size)
+		return -EACCES;
+
+	return 0;
+}
+
 static int amdgpu_check_address_validity(struct amdgpu_device *adev,
 			uint64_t address, uint64_t flags)
 {
@@ -223,16 +248,25 @@ static int amdgpu_check_address_validity(struct amdgpu_device *adev,
 	if (amdgpu_ip_version(adev, UMC_HWIP, 0) < IP_VERSION(12, 0, 0))
 		return 0;
 
-	if ((address >= adev->gmc.mc_vram_size) ||
-	    (address >= RAS_UMC_INJECT_ADDR_LIMIT))
+	if (!amdgpu_sriov_vf(adev) && ((address >= adev->gmc.mc_vram_size) ||
+	    (address >= RAS_UMC_INJECT_ADDR_LIMIT)))
 		return -EFAULT;
 
+	if (amdgpu_sriov_vf(adev) && adev->umc.ras && adev->umc.ras->get_retire_flip_bits)
+		adev->umc.ras->get_retire_flip_bits(adev);
+
 	count = amdgpu_umc_lookup_bad_pages_in_a_row(adev,
 				address, page_pfns, ARRAY_SIZE(page_pfns));
 	if (count <= 0)
 		return -EPERM;
 
 	for (i = 0; i < count; i++) {
+		if (amdgpu_sriov_vf(adev)) {
+			ret = amdgpu_check_vf_critical_region(adev, address);
+			if (ret)
+				return ret;
+		}
+
 		memset(&blk_info, 0, sizeof(blk_info));
 		ret = amdgpu_vram_mgr_query_address_block_info(&adev->mman.vram_mgr,
 					page_pfns[i] << AMDGPU_GPU_PAGE_SHIFT, &blk_info);
-- 
2.34.1

