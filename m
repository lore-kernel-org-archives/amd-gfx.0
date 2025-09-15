Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A2DCAC587
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 02:09:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6ADF10E117;
	Mon, 15 Sep 2025 02:09:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ukJtY9fj";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8360910E117
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 02:09:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0zp3+8Q+y3I4mWy7kgs7ZWAOl1kCmaQSG5Ahz6uLhbsk80N0dMpqFaTrMb2LCcUr6VlQQOUFJrGqtkwm+NPns6iB6C8OQZK8e9iXJEopY8tK1lE9uWfGxNfpEzRewC5PULWE/UJ5jRKCa2uUaorgJdgksSVBDWBAg5khkWBSqgpfTO1rdFJOYnb8R2g56fXLZHcPKiOZbi8Esl40Ph+0Z1qijsmvOPxFayNW280Pw1o8Q8qAzw+QTvPI/N+0Vpgw2FGcxGexfonsX1ZxsckEhnmG/VG3lwzpaphsg7GSCdXQ6K4D9rmuTE6Gtu64rQHrx0+Osq6AatqC4KEJK6UbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfAGOksoOmmvquD9ldymqcJFMZ2PJ2912b4LSlI4ELo=;
 b=NuXqUt+Xo3E/3wWmSXQ7fRG6/CL/NzcGLcs4WoU2uG9ncea4gQnvGKvcbLAEX1PIh7zuWKCh+3zzux/SDkdwv1xSMmN4QpM+1cdcASfx5sWNtGAkt705AJTf+HR8fbI6JnnO2PCZlpy8PvjEw3vZ9YVVPSr293RnN6j/P6zE1d0wpzeDaq4Zr6gS1I6/i/WL0bzB6Zk9RYdy4tmVMJFVWJwzRRaGhkHpLV/feuJEiwylTna9ZS7sOh3te4M8BiN7jn5H/Js6VjOvbmjbtCHpUTWkJKfmmS8bATm59XvgETsMjtrDu5i4Lc0CJuVDF6xw/PlXYAPZ2qWWAU8qtJ/Oeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfAGOksoOmmvquD9ldymqcJFMZ2PJ2912b4LSlI4ELo=;
 b=ukJtY9fjeM5h6yx71aDcz++VLVSusteKMPXp416ebERdkowc6CKSxYngTmNuKk0ocDN2a/+fht+8gLg2WM8ed5+AjaVXdohcL7xIhTWC8x+1nTZRTbBvdAyw+6LSGZDkHODxDkHsVtMFuSRlYrWn2Nys7/+e+7sVeXGMCBQXwew=
Received: from BN9PR03CA0667.namprd03.prod.outlook.com (2603:10b6:408:10e::12)
 by BY5PR12MB4228.namprd12.prod.outlook.com (2603:10b6:a03:20b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 02:09:28 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:10e:cafe::bd) by BN9PR03CA0667.outlook.office365.com
 (2603:10b6:408:10e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 02:09:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 15 Sep 2025 02:09:27 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sun, 14 Sep
 2025 19:09:27 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 14 Sep
 2025 21:09:26 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Sun, 14 Sep 2025 19:09:25 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <leo.liu@amd.com>, <sonny.jiang@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>,
 Ruili Ji <ruiliji2@amd.com>
Subject: [v5 1/4] drm/amdgpu: Refactor VCN v5.0.1 HW init into separate
 instance function
Date: Mon, 15 Sep 2025 10:08:43 +0800
Message-ID: <20250915020924.137122-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|BY5PR12MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb49253-b70e-4e1c-6047-08ddf3fce640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gm4IdiPC6FfCgCcS5KghX6bn7c7JCKi7gl9/ej3IrO4BbDx6nIqigCC/emCy?=
 =?us-ascii?Q?9nngNMXKZW54vV3uNRU5IB0zGCu8zkKIfIrzCOI0mt1uFSgllflFHoNR3h0X?=
 =?us-ascii?Q?cQaCPNQOcHKraVKyumGoX8bhSgLNWzNo4kZxbUXBwrYMZINyFAiXeOr5veJU?=
 =?us-ascii?Q?TMWZ+VFxVBDszqGpbgXH0CoHnSTPQiJIVlUITr/CrEHwcWY3Xz3EyZOMJu5s?=
 =?us-ascii?Q?bUVc3oLL8kxmZ8IyYTYr0FsRmc5GwZlSlWDh6bmZMjjZBrjqM0ZlZehnhMBB?=
 =?us-ascii?Q?k41CW5itxr5vxUu7SdeGXQ24vl1266XicKeirf5n4E5eHSN+kzCflvxq3/20?=
 =?us-ascii?Q?DMSJKQ8QT65EOcJR2u9vOR+NLPLCAqktK1i7/aQg4na+rgUst8hXShnQi+lP?=
 =?us-ascii?Q?T5EFD2h+SavBbPPVD0jZHswWrAfIIzTG7d8WluG3wSx9aJ9IzfUyhnyCsHrg?=
 =?us-ascii?Q?lYLIYb/Ui1vhINdKM4OJg7IRwIgu9Bd/BQnrtIa4mU3dkugeDnBHejmHOtOv?=
 =?us-ascii?Q?HnG6mSRVrlo55bPFBLt4/id5zr5NlopTzX5lqMX0Pl5TAh7wQDFpjCM0cHnT?=
 =?us-ascii?Q?BrClPJfkwQ5nZ1qmoqIDRLt1m63v1nbKU2OaQz9HMsYNLOu6glbkdZF150dZ?=
 =?us-ascii?Q?xonscHbaSALdfVsFC06uoaks4Ch/1yYkLgyBoGISoQEkPG8El81RZqZKJzoa?=
 =?us-ascii?Q?hRRchAsNnmJcAHgTzYB1dHRgqx1ACz/Nb8ohK49NVJxasFvF8hT9OmYYgYEX?=
 =?us-ascii?Q?DGtBCsA9XP1/+yKn/fxGL3jKMMTWNDZDPnpEvMfz0EACEAn110KRO3M29sft?=
 =?us-ascii?Q?QrFHo8CDrvkNhXqd0HzP1ndfkoPOsk2MIwHpDOAku65kArr88oK0flB31S07?=
 =?us-ascii?Q?gAmajrtfAYoWrwL4aHTc7DrCrDENO4qM3gwHfd2ZyqIGRYZLZxuQL5w+g0Eu?=
 =?us-ascii?Q?CqztT5zGQZSYTKb7g/kX+s8QCxAkjByeaoFIyc+gd50jjg9PwvKkTVS5MQbF?=
 =?us-ascii?Q?7j9tbauHLsotEgNSIXoYmmR+Dtxip9gL8hw1hwxvvEz02mLZBDrzeBohhzmO?=
 =?us-ascii?Q?a63zDnlntb7mX/DjGfNTdkxuHmyFf/fODb9PJF+Xqd8rbbuGsHAOCcIt2XwI?=
 =?us-ascii?Q?NnRkiXYtL7X/ae1gWSvHI0aNlS3xdEl/2bLB1S0SLSuGMsgwRGv9k0WXeJTI?=
 =?us-ascii?Q?GAf01CF2l9up+qOPc7hmrAEfah6AOtM6IQvV29uARD7acxTYjYBbdCnCKP8M?=
 =?us-ascii?Q?BAvZINWA4Al9DiqY2C9NEhOCc3fqxAGKpqPytLeazOLprZRqF6VAeHBdLL55?=
 =?us-ascii?Q?+okru4TyL6jG5QXg0zvvY8NVgpWH1w/srWNM7Y/Kt1nDB4dbRXm2DiPkNHYb?=
 =?us-ascii?Q?9afXDXl/nbamtRM0xRywUqmMJZygxbJ5V4jORhEvfqrUOMypjmmgJLRCwKPk?=
 =?us-ascii?Q?UVDU/BGquyMxaIgy38T8L6snjPP4e4rw72YbXdGP1B8sSjyySZDpK8ERXBgw?=
 =?us-ascii?Q?PgMXG3KtAIBY11qPawjGHIVX/vPGuvCSNMsT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 02:09:27.6333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb49253-b70e-4e1c-6047-08ddf3fce640
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4228
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

Split the per-instance initialization code from vcn_v5_0_1_hw_init()
into a new vcn_v5_0_1_hw_init_inst() function. This improves code
organization by:

1. Separating the instance-specific initialization logic
2. Making the main init function more readable
3. Following the pattern used in queue reset

The SR-IOV specific initialization remains in the main function since
it has different requirements.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Ruili Ji <ruiliji2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 27 +++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 9c281ba6bced..3677ea9ffa43 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -253,6 +253,23 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static int vcn_v5_0_1_hw_init_inst(struct amdgpu_device *adev, int i)
+{
+	struct amdgpu_ring *ring;
+	int vcn_inst;
+
+	vcn_inst = GET_INST(VCN, i);
+	ring = &adev->vcn.inst[i].ring_enc[0];
+
+	if (ring->use_doorbell)
+		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+			((adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+			11 * vcn_inst),
+			adev->vcn.inst[i].aid_id);
+
+	return 0;
+}
+
 /**
  * vcn_v5_0_1_hw_init - start and test VCN block
  *
@@ -264,7 +281,7 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
-	int i, r, vcn_inst;
+	int i, r;
 
 	if (amdgpu_sriov_vf(adev)) {
 		r = vcn_v5_0_1_start_sriov(adev);
@@ -282,14 +299,8 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
 		if (RREG32_SOC15(VCN, GET_INST(VCN, 0), regVCN_RRMT_CNTL) & 0x100)
 			adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
 		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-			vcn_inst = GET_INST(VCN, i);
 			ring = &adev->vcn.inst[i].ring_enc[0];
-
-			if (ring->use_doorbell)
-				adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
-					((adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-					11 * vcn_inst),
-					adev->vcn.inst[i].aid_id);
+			vcn_v5_0_1_hw_init_inst(adev, i);
 
 			/* Re-init fw_shared, if required */
 			vcn_v5_0_1_fw_shared_init(adev, i);
-- 
2.49.0

