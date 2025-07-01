Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB18EC8303C
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3568910E638;
	Tue,  1 Jul 2025 18:45:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CMG7OnUk";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4A8010E62F
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 18:45:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ct1sYgasNTBuvIIKNaXXHGL7DNQlbmyCqin8kOSM2Tc9DC2wnzi1wZTBdNxSQvQZapFUsstqFlCFEuIJw8Q8sgVNPUNKbYxpkj4QwI8qoa1MiuBNdUQoJZDhs4OXZC8JEiy5hSmcRUkuu3JgnNnQE8sKiafZCB+8kQOVkif25KbB8kRgRKXhx5UcZeDPjozS7GkKmwdmQaY7lhVUUHrPAgXCB+mMgggwsikvtuG0OwxzEEnpTc/GuisZuLXCfBeka84S4UjHzGyPzgLqnl8B7uzk2q4XVCGd2s1NekwggdCUeT08itaOsCCJ3rGFWekACV2tJFYIkDqFczC7l3pNuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1x6ZytdluvqGYN6PJFyaufF5Z3L305Uy8gNCAFbvQ9s=;
 b=PbdP/3vHYHQJrdkhlwesqs6HVvWz/Od0NK4pi9ayKZaCnKoY3kmZt9JpcTguhjSUPKD3zX9NPXKXxhBm6fJQ+R16Iz9TvPIfolgum7pkv16p3o8bfpcqvJmym+T8Qs1YtCRFORJ1kWJ9BDhAeB4zzFrI0BVoi4LKfwFxj5SjZ/wst478JRvXUaBIoeYfvhvvKHr+3Upju0rMN47e0YhdRpv9EnV0ZhmPQkkBpCPSLJmmXgeDQMsTu5WW1q+6Ubnu2Zyn3onew1rgZrf1di1gfte1gz2HcNc4U0srCN3pzW6APA4vJCXWJjIbeYRMdModBi7wgMUmEiwBQio79daRbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1x6ZytdluvqGYN6PJFyaufF5Z3L305Uy8gNCAFbvQ9s=;
 b=CMG7OnUkGZdhzjT1Gz/8T0YHn87bdYHKDt7bBBzdaKPoNt+QiBll4wJ/1cNWr9nse1MZh9Wbs9sANdwqq1V7TDmqZnSo3TLEjxFOPUa6p8GoHwVHlsv/sGcKtE4yO5VD+6z1fPVaHd57kc46ydwEWBQIWDfq1F24jOHyZelBCS0=
Received: from SA0PR11CA0013.namprd11.prod.outlook.com (2603:10b6:806:d3::18)
 by DS4PR12MB9588.namprd12.prod.outlook.com (2603:10b6:8:282::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Tue, 1 Jul
 2025 18:45:20 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:d3:cafe::1d) by SA0PR11CA0013.outlook.office365.com
 (2603:10b6:806:d3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Tue,
 1 Jul 2025 18:45:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:45:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 13:45:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 24/28] drm/amdgpu/vcn5: re-emit unprocessed state on ring reset
Date: Tue, 1 Jul 2025 14:44:47 -0400
Message-ID: <20250701184451.11868-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701184451.11868-1-alexander.deucher@amd.com>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|DS4PR12MB9588:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c874dce-daae-416e-b543-08ddb8cf6e2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sKKBpwBnNLigL/4JLPZHu0iXzw1YQD0P8vTC0/HSNzsqicmCnfy2d4tiHwUB?=
 =?us-ascii?Q?4nECHOCwu4DjbbVrYQjaojBqBXiOOv4XN/ddhI/RUn4JRgK0Rij+6NDeA5JM?=
 =?us-ascii?Q?yh8k4fmWjAI29e//cZczDN7gv5fjQrOOj/y2ZfEhvTzMeeXz5utqVOkY6Vy4?=
 =?us-ascii?Q?fo8JAZbN90Mj105AFedo+wOS87fCzO4hSAPoEop2eljpm12VhDQnucSL+5B0?=
 =?us-ascii?Q?wmKcG1Wt+5QXMVkQ3J9XiLH3TTD/o8OV4XEE/StdxQVmF+NWymY6v84sjRQv?=
 =?us-ascii?Q?gP+uLzc6MY8fttRsF89nXSydRXpfKbWpbEA2kHfpn8ISFAbUG62LopR9g4gE?=
 =?us-ascii?Q?rqdLFYRN5D30mR2t4WNiMKACoAGqIh1CFzZq6LQLHcQQ2awRgxnk7RUipM23?=
 =?us-ascii?Q?gQiYuCEes3RLQwOa5zFcRdbq4OocedtojOhDCVu41AtoQVxE3tEP+11dV2kf?=
 =?us-ascii?Q?KWk7egvTsCfGYet2Wx7AsNwg43fp2nsQ01gN7Bwb6y1VL/IJNorEuQvH7OW3?=
 =?us-ascii?Q?rdlQGB/JlL5nuSbsobRWuIUOLGDA+TO53r5NOvvV+YTO/jQrVdBKmGog5Gb3?=
 =?us-ascii?Q?Kf8/cHGJi7yqThOSCBi3XdpXMilb7vqKbbO32P/KpPc1rl3zZwgxGSxGAhEW?=
 =?us-ascii?Q?oqzTwnjWD3gnB0962ctRrxlg2IeBn9BbXwpRiKJknSsev7ZYeetZItXgqwyw?=
 =?us-ascii?Q?1PHwC2fJ2vftGSN4PHAKf4YskbBf1rFGMAYCZkVFQFhvr58YhgLf9/LRC1Sb?=
 =?us-ascii?Q?rpwO3uQkKVStCEDVhkT73BCgN5gNZ58pSw3EUzAYEqQ4LAmqwgVdwauHjS0z?=
 =?us-ascii?Q?fO20RkOtaUSwf8OLF2M8y4RSXkfgc6zLUt/efYa9qu2SeBPJXiZuFgXsUl71?=
 =?us-ascii?Q?slPW7HAz1zH2TgrvfY2abrlitljnFTOXM7zMWNmM7rytzVicUhUHjicV9+62?=
 =?us-ascii?Q?+5Pc/VPeujSwDCw3Ui9ahlWT6IJ4tYY6B0gP5xf3qaXtNpDuqYgcEls3y8N9?=
 =?us-ascii?Q?IkEdoM7R9PeT7WNjoWMq8sxJJ5ZdrO1uEkMLIWBUk+6VgWGcrgHZF76BT949?=
 =?us-ascii?Q?AM2aQu/vu7sMmv2gVQ4tt2trcgdzwxe2INOmZS4dqtYwLRAT3tWQIvvqYqys?=
 =?us-ascii?Q?pAF73RLLaJXczK+HmkPrbErANxdl1DZDNCQUGsjcBSHAbJ9Zu1XTfxMpz8SK?=
 =?us-ascii?Q?D98tYpCeFRWErIew/infO4LXaA5VY1YehdNPyMu0P73QJbyO8qcUH1Rhtw1S?=
 =?us-ascii?Q?4WUljKGmMFHMvei2abbPuUgMykoqoFpjglfqVPqr3bvUvYbtMZESQnOU2DHM?=
 =?us-ascii?Q?HewNH6y4R+XcckQsEg1Bxs6lpm3DKalI6xv1tpt7Dp/qrig+hd+j3DDbQtR/?=
 =?us-ascii?Q?1ANRF9tEdFEZaDMEkK6VrZ/L/NC+cCtHQeMsPdq+JzRO9Vhm4lywwCJF8+Vs?=
 =?us-ascii?Q?VgCf6b6N2cRql2Z07qQjHwSqtqBs7hD8TYGMiF/5xM55gAc4a4g0vbxFkltP?=
 =?us-ascii?Q?2UXLz4LRnxFLX9+/BaLPmk6qfNxyncx+AgFk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:45:20.2123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c874dce-daae-416e-b543-08ddb8cf6e2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9588
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

Re-emit the unprocessed state after resetting the queue.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 47c0bcc9e7d80..5997927ac6db1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1198,21 +1198,14 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
-	int r;
 
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	vcn_v5_0_0_stop(vinst);
 	vcn_v5_0_0_start(vinst);
-
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
-- 
2.50.0

