Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8613DC25B74
	for <amd-gfx@archiver.kernel.org>; Mon, 27 May 2024 20:19:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9F0710F89B;
	Mon, 27 May 2024 20:19:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y/ULpuA5";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9035C10FBFD
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 May 2024 20:19:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioM5yIE2i6rgEY+BC612yozaV5agXCZltRDxP61GagD/MCq4c6rgoBXla1tsyPe8LPX/WPo12WA3eZf7+DhaTMoopHWSrsfqHVvUuvTLHOy681NsKxR7g835k0iyXRCABFnUD9C1lCjrxZ1Gzqr/AzXOLhyLoyzn3nX8jnE7MFxNtVcZP4hu3A13ABBqQYs1+PMQ4Re+XPapiuTax+NSuAP7aTBylHrwaOJhrxU3UQR8egkkwDiawLERhsDh9jCo4yUDsV2s6mIL9udddfohFRAub/qiSgZ5+zpL/urmuTbQ80mO060bguky9RPuWudylz4KaMc2M3qCqNlvgea7Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4C4ls6jWGGM7Pbf/Kbkoj24V5zbOqS6fCn0RH+zRDeA=;
 b=a3BT8DC5WhUp8FqXCVyXtr8McHnR06mzVBFfKT9eiEGZaogv1Z3yGfD0Ie7CtdiLjTwT+5Zt3Nahtld8AoGOBirZnzUE7IQIIhqpMNMKVEpyXT63xphUlF2UxG2GTJmqr+T7wbVV1KJVURBU9HlKu+o7oIG813VhfdzxU99zL8aKvm8R0pfjRn1nzgr2US9VjT+gDTqAcBJrtgMQCbgLz1pmI9EMxg03g7yby9Xp7dWy4ZY3sPG8PvhGulvQpUxIqPraDQBpKdo+LjFTikfuR0sBz55/WyqWDLWA8M9jCMmso3TEQ8O31hCZKIdDdStUG8vKZW0Waj+ydOkZ87Wcxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4C4ls6jWGGM7Pbf/Kbkoj24V5zbOqS6fCn0RH+zRDeA=;
 b=y/ULpuA5IvGp0kYqSfj/oc3R8XFN4RWUJUCNh09YyWbSPZTysWLnAdbkg3A6yrX/AXFvYg9D48SnXGCWjyWwBx+EVfMQvYGnyTSyYu5OexortctsjE9217wipdN7E78Lh0DBqnCWUnZ9oW/9qIR4J/wYbuUzxzziWGWcTgUAZWU=
Received: from CH3P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::33)
 by SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 20:19:34 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::31) by CH3P221CA0024.outlook.office365.com
 (2603:10b6:610:1e7::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Mon, 27 May 2024 20:19:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 27 May 2024 20:19:34 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 15:19:33 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <lijo.lazar@amd.com>, <zhigang.luo@amd.com>
CC: Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH] drm/amdgpu: Add lock around VF RLCG interface
Date: Mon, 27 May 2024 16:19:07 -0400
Message-ID: <20240527201907.470066-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|SJ0PR12MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: 438ee0c3-3d94-4cb6-44a5-08dc7e8a5328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oEnV3jZObPn3oOXl8KSUsuWT0Trt4P1sOxO41tSWAqhDCu8wcbcGZUXYPeYC?=
 =?us-ascii?Q?wid4ZzzDhJ85M7/z1e0QfIYroTZz6AUkxHU2FhYdNHW9gJweYIaiO6TQ1u0+?=
 =?us-ascii?Q?2ziVkVdAwIKSUReOUPLFCJ7t/fevMc9tU3HBB6xVNGw03FManA4mHR6W6X7S?=
 =?us-ascii?Q?B666IkUEI9byi9Eat3CBOxitmmtvb18xv5BUxfUdZls862ZV6dWc48qUFZMw?=
 =?us-ascii?Q?B4VnTctrRLkZIO93lYbFOb4EDtyTo5PGRaiGj5kcWuBmWca9Dr6wDMHx/lg2?=
 =?us-ascii?Q?hqgNRog7p0GBo7aag6mQOsUxz5bjDJUvggsNnMhzvpCERWl87jaqy/00TPO6?=
 =?us-ascii?Q?ze3U8jGcjxKjd01ioNZAzmFlcSq4eFCHIqxuI2qL0SLqyiGbnpeaZc0GwgFx?=
 =?us-ascii?Q?Ap6x28F9rtYhqGvv4fdLiCyrUTChiWXdn0rZvcV6suPMEk+1P1m6u5D5Yb8r?=
 =?us-ascii?Q?zz04l8Z6FxdkVQxAez5kxXbiELR7sas6AlgUxZYlIsY4tJEbcK8ScNysRttf?=
 =?us-ascii?Q?NiFW5CYrALUjsAhtKm1TP4KwKly7fiUBZ0xyw7GJGV0bcmRzQ6vj9Ef0ih7y?=
 =?us-ascii?Q?5OowGhr6yEEgqv856EbcFjUR9ErhVL8xpwaxCo0305nbAXGs0waLZE4EwZ9q?=
 =?us-ascii?Q?OVeQK9ITQoqwiLYWdkoN5X9ACrfVqWHyt5HHaqMS7iEpfiwqPGfkKTlY8RWG?=
 =?us-ascii?Q?IJEdFxxtygEo4jvcn3eESJASiEXaRC7hn8QYQcZN1eLdn9G2+LGwHDvGNuu4?=
 =?us-ascii?Q?3xq2zYN/flcrSpuoA6hWKY6bDVCg8oocBwUtTZD3ag6+P1boDJYK7npfc9ss?=
 =?us-ascii?Q?kRqLHZd8TVABgcBf2VjfIjDHndUPzxrkYWcUBKgsULFTwm5gOHzYq4ia98Ux?=
 =?us-ascii?Q?mXCzTYQVciweXxpBJ2d/GTIzAkZRFNTvcPk8UziAtd3eswISTQRHu2PFq6dU?=
 =?us-ascii?Q?t2Yilp4FyePDdwTlQv/2DSGiJIHP6y2eZ73UUlkathxRMy2pbm01D6/uYiVK?=
 =?us-ascii?Q?eoRNZ707LL0LKqq4yG640ytO/W6ITWZZwNj/mowtj3otO6xJ1VQi64AXJSug?=
 =?us-ascii?Q?BPpX4wZE87uDTuSpecUVEGZBT9el6750uca36PD1JnJ7INcYpvraig8/gZI3?=
 =?us-ascii?Q?heYsxhXknocxb/V0uykOLfFKKALzC57p/a4dczmE6ou0O2lyhtWQL7onxDAg?=
 =?us-ascii?Q?reVFKIxQgepZc6ROUfgTnOHzeePQM48ysP9/jLTe/5lpEwIZfKfzgI9npos1?=
 =?us-ascii?Q?ZBnr+qOiJfZZG/sW5cSmBc/ud5wTRKvs9jMCilnkoKOJCV80cQKod5e2kTJw?=
 =?us-ascii?Q?N3XuNu6o3Mu3rIHnWZiIM/eElxFz/K/TqbxTCFZ5+lbqJCOAsee/PjARfo27?=
 =?us-ascii?Q?iYtNxY0wJwhlvyU0L24FyQnq5Fq5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 20:19:34.4096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 438ee0c3-3d94-4cb6-44a5-08dc7e8a5328
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6685
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

flush_gpu_tlb may be called from another thread while
device_gpu_recover is running.

Both of these threads access registers through the VF
RLCG interface during VF Full Access. Add a lock around this interface
to prevent race conditions between these threads.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f5168b4c3b03..6711836054f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4049,6 +4049,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->grbm_idx_mutex);
 	mutex_init(&adev->mn_lock);
 	mutex_init(&adev->virt.vf_errors.lock);
+	mutex_init(&adev->virt.rlcg_reg_lock);
 	hash_init(adev->mn_hash);
 	mutex_init(&adev->psp.mutex);
 	mutex_init(&adev->notifier_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 3d5f58e76f2d..a72683f83390 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -982,6 +982,9 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 	scratch_reg1 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg1;
 	scratch_reg2 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg2;
 	scratch_reg3 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg3;
+
+	mutex_lock(&adev->virt.rlcg_reg_lock);
+
 	if (reg_access_ctrl->spare_int)
 		spare_int = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->spare_int;
 
@@ -1038,6 +1041,9 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 	}
 
 	ret = readl(scratch_reg0);
+
+	mutex_unlock(&adev->virt.rlcg_reg_lock);
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 642f1fd287d8..0ec246c74570 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -272,6 +272,8 @@ struct amdgpu_virt {
 
 	/* the ucode id to signal the autoload */
 	uint32_t autoload_ucode_id;
+
+	struct mutex rlcg_reg_lock;
 };
 
 struct amdgpu_video_codec_info;
-- 
2.34.1

