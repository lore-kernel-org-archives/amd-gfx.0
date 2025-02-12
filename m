Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A55C02198
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 15:16:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10D9F10E8F2;
	Wed, 12 Feb 2025 15:16:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xpwr9T9o";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9370910E8F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 15:16:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0vo+JeSUrfzxqCVGEBp2sTaiqCmS1tsc4SFmURk1XEWA79MnjNFVHX/8ZrmuXWmKYqMbMrp+6lcI8lFJx5acapD3IF9DSSoyfdbHal0sXUz+JHIwkwhRB3/2PctY5gF0FJiX52MeGbbNChOxGZ4/QmjdjGJXyhVLl+Kgd4A9SD5KlZLUoPWj9upLcI22VeuFcLInhNNQIhfkWjp+vNOEB7wVd62p124UqNbqPNKGQfJ9hMZhz8IY+txclbu1GOlOqzEmiK/HUDDbfRh0fQLujqYUDwAkyFLSwRbGHktjaGdyWjzxUXcPbHCZC2Mtx04KF0zRE989mdD5/RpbilODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFLg/Yncg7uc6QsbH5DLtNz/tOCeNuQyHtiq+vrJuZ4=;
 b=yiFSOeaqp0iuXQfl2Dk0rREcUIg/cAuiiC81zeYQIJTy15LG4XB6AlXVFEhMcLxbAhKXZZhK8YXb2KxtVFfTyy8Vc10yP7MvzlM/PZUFKblQV62znBxAafEKPkiaVPGx1owVdyhFyTOak8T9DLMDWgOLbRkogkvg+HZO6keCO/w+eHLwAKDBCgTu7XTQDMVz6yv200AXzx59Ji8uXl37suOukqBFw0qHXODiOR0J3UhpOBK9xwcknzgYJEd3kTHwLVFYYO4ngLiYz3G5Qsp6lpd2Yb2QXVbnYjMqiSaKsM0teNEKQWL7gYzX2G/q056Ymske9yq5t5zBimISq5BoFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFLg/Yncg7uc6QsbH5DLtNz/tOCeNuQyHtiq+vrJuZ4=;
 b=xpwr9T9oKtB4vSlvTdwk53pAuo0WNzAraqpSXPoaFn7PFzhbtsa01SAOP15qRKjg+I7Mfc2Y4L0Ep9GVB1n02NSYZwW7bfxH9JDZsXwatXV0kiNNNcL0ZpSE86BNUJ2jnmh4eUVd2q+v+gpQRsLnqfWrn2OaUiZ7V14HKNdOGME=
Received: from SA0PR11CA0069.namprd11.prod.outlook.com (2603:10b6:806:d2::14)
 by SJ2PR12MB9190.namprd12.prod.outlook.com (2603:10b6:a03:554::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 15:16:20 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::a9) by SA0PR11CA0069.outlook.office365.com
 (2603:10b6:806:d2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Wed,
 12 Feb 2025 15:16:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 15:16:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 09:16:19 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu/vcn4.0.3: drop dpm power helpers
Date: Wed, 12 Feb 2025 10:15:59 -0500
Message-ID: <20250212151559.2683916-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212151559.2683916-1-alexander.deucher@amd.com>
References: <20250212151559.2683916-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|SJ2PR12MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: 275495bd-0f49-4fd5-0895-08dd4b783491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wI+z8mgRMT+LhOY3OYcbpYWdK4HwdUR8pO6VG9PjhKgyOgWf7s7Nc6uaB8qf?=
 =?us-ascii?Q?VvopexGce3fY4P2JKOmsDXpAEBiQ+UMVgHhXalcnXFTqfZeqaYuo7SMHr8/T?=
 =?us-ascii?Q?zSarUFrf4U+eL/upnxZVFgMRAFBDTvV2xyEi47t2blOqOP2EZ+vfMQLx3xHx?=
 =?us-ascii?Q?5dWlUUYjPRm70puqHYW2Algg8taOiSksm+f/g3Cdlbhx0tYTjxjs5eu+1XR6?=
 =?us-ascii?Q?iY724qr/JHwBTzh4wOsFbyG3FWOE+gA9kkJOhaX5WR4uZcYssk27jja67g6/?=
 =?us-ascii?Q?1wVA3uRPVclMcNXIuCX4TWSQtJFN4DQSfW/kjo/mMgZu1L24YhX5gEqoJ0S6?=
 =?us-ascii?Q?4oDncyYovd29kIOklpe29gtywSW6WxXnCFadODaKdtH4yeX5yMh3O8k47g4C?=
 =?us-ascii?Q?d+RhCSBgiojlxmB4wWG3zZ8CU2AfH/fgmYufI7C9hrGcGO3oVQGEKU1RLJ5k?=
 =?us-ascii?Q?i5+lbY+Tbxwt8nGTMvtxFiIrjhSHNL9N33KYmvAwOYOoCc9V6mkH7sHhL2Mg?=
 =?us-ascii?Q?bF+unQMUVjVuj/0EbJaf+E119pgdNxw5u58Jq3MQXUUcFgCNYuw5KbSm8aV0?=
 =?us-ascii?Q?zz0pRAs4TEZ7JRICSlabO0+yB+D94YXhdYiTo5IwJpg098eL/T8tE/ertXjO?=
 =?us-ascii?Q?QIA8TKW9HAfAM9QO0IONREsmU3H1UKMwvIc/XMAofih6y4Fmu6BcEAL3JOSf?=
 =?us-ascii?Q?NjkCk3jZQZvY9qHPTpHo7Zh8xI7b9MGZoLu7epraENum5csUVa1yxF/ReSfh?=
 =?us-ascii?Q?ygFs1k7IDS7KRRY3pateFFDBokuzo7aKnSDGOg9RdeIeT2+fpb3QYrUfG8D0?=
 =?us-ascii?Q?8/W04mPFvPCfTbgMCpKzgI2JRZg7ighPH3gImFOa2ItiO6wN6XW5xOfjA30q?=
 =?us-ascii?Q?fx0e+P2WLUtmtSC1oE2yNM7aYWLKpWW1R/Z2RqJ2TlW/GA4EebtDZbXKcea1?=
 =?us-ascii?Q?yW/vo3OWpfGXwvGd6okpmBGKc1lqhQKAe13KpSJJi7+VHfCxIH57XjHL5Oyz?=
 =?us-ascii?Q?Bv/85XJYJp3QHwTFxD7zgW1N6lmuqLyKt3eL5oRYtm/0mUTT+Czm5U94mGm/?=
 =?us-ascii?Q?n6snkrR+k2yu0tHuM4rCZ2WuusQsaAVQ7ikIAwXZqsobsctB9ZpM9FmxO8V5?=
 =?us-ascii?Q?5JelRBrT6hwKwXZ+MWXGwEgjQztQi1/FmEqwKA/KlA7jDcaah4tPgTC4wG5j?=
 =?us-ascii?Q?TtzgB0+S/Es8xaB1kCtIo84jiGTgsl2S4GQj1M1iduKFFtHTJ4ku14fx65tn?=
 =?us-ascii?Q?O1Ov9lIwJoUxkftkUwulkK6Uwtt8WOzfpu6VXqJ12jx4VekLgqcF+jGCi0Cj?=
 =?us-ascii?Q?3qGTNGvpgchp7zYNRxVUiHCHvyzvM4Iz+MWth7RqMwKgPM6I40FUHt5pX2qR?=
 =?us-ascii?Q?mvNZL5/DQTQvyUb66IzJilbLPOuTtIvbDzDxA9qNpHGfCcVSV6PGpLl4MSUz?=
 =?us-ascii?Q?DBY616eobOOP1Li1KJM4BVrDZzBx+GEdh3S5/aVLV5vHiaesAanQiyODBFZs?=
 =?us-ascii?Q?ezDhY/kgWCeBbCU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 15:16:20.5776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 275495bd-0f49-4fd5-0895-08dd4b783491
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9190
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

VCN 4.0.3 doesn't support powergating so there is
no need to call these.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index e09eaf4469ddf..acda694eb74ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1127,11 +1127,6 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev)
 	int i, j, k, r, vcn_inst;
 	uint32_t tmp;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, true, i);
-	}
-
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
 			r = vcn_v4_0_3_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
@@ -1403,11 +1398,6 @@ static int vcn_v4_0_3_stop(struct amdgpu_device *adev)
 		vcn_v4_0_3_enable_clock_gating(adev, i);
 	}
 Done:
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, false, i);
-	}
-
 	return 0;
 }
 
-- 
2.48.1

