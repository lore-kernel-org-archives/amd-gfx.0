Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1F7FD4612
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 03:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAEA110E07B;
	Thu, 26 Feb 2026 03:58:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mMRFTCFp";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010026.outbound.protection.outlook.com [52.101.56.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DEE510E07B
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 03:58:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1yimuHPscGW5aUwYKYDJkrvHE+CXm7oa8O6pa/s6MyMsEt9E/rUVu64Omq6PNw0vm6bLweOYcYg0cpzd1P9vcmX7LptEvtA7w/WV39154ZyWj3s/+S4w/vYRW0hGVQ53zxfJMDBTGcSt6NIyfPb80yLhrUemhUZMo7+hDWvEHT06Z9AbJC78WelEcLRVSDw5qn019Dbro6rg4v60eUpMr3oHmuOcrLU9srhWXmJgen/B78k889CJ+oEa0zh3XTaA0LiE1y6RjTPd1pU4RjY1v82Z4J4PJYzyqeVHeryEBA8PUSklwfp/sQ09Gsz8xac043bOb6J0gAaXms+qpTNEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cifjv69Vv7aVDp2DezSBLPApMAaNxMXSBF6orpDLTWY=;
 b=jHifQn0N39S8mbw58cdYBEQrEIl6jwqyWuDxU2SAopF20D3qmC/i6RLrdnz0EoJhb3c4Hr48AsCLq3tBNpPe6a+raHX4QS8p2ruBdb6vHwriXUpi3NaJgWgoNZjUKNN2ryH8flfMDM5qTo4/zHNwhjLKwQ+p5SmIBJ/ct7qY5hZO1IRTvw7qy/x10gwRqmG1PfWJMC94YQrI8jKJe+Sc0nGanyabe6ZoIhb/6DRhGZObnXLfGM8xugPh4IVIrSZ+m7/IsN6zNF8Z9lFlO/ADY10eWazMbjNWnN31uNAlRK5q2EKOFNvZ6517NjN3ZUOx6M8y+ONWpoagThhNeuZqUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cifjv69Vv7aVDp2DezSBLPApMAaNxMXSBF6orpDLTWY=;
 b=mMRFTCFpxKUAmB5HlK30L7LUGmVXd0rte0ZXse3PVggnZBIZLgryfcFeO2XmD7NU2FVB/PKbxxgT6lPni82xVvarm6r3Qtb/sqpF/wy5QDgJ02jXxV83WLkhcR8J5TnDW51kB2GIDtBA7Qs0yU1e0E9IfKCJMgfcPVCWZiRDMy0=
Received: from BY5PR04CA0030.namprd04.prod.outlook.com (2603:10b6:a03:1d0::40)
 by MN2PR12MB4174.namprd12.prod.outlook.com (2603:10b6:208:15f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Thu, 26 Feb
 2026 03:58:02 +0000
Received: from CO1PEPF00012E5F.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::59) by BY5PR04CA0030.outlook.office365.com
 (2603:10b6:a03:1d0::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Thu,
 26 Feb 2026 03:57:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E5F.mail.protection.outlook.com (10.167.249.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 03:58:01 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Feb
 2026 21:57:59 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: remove invalid gpu_metrics.energy_accumulator on
 smu v13.0.7
Date: Wed, 25 Feb 2026 22:57:48 -0500
Message-ID: <20260226035748.502909-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E5F:EE_|MN2PR12MB4174:EE_
X-MS-Office365-Filtering-Correlation-Id: fda64ba3-2da3-405d-1483-08de74eb3cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: b+5pjQngcw2ExlFAXi3/Uii+gop6lgIrAPB7eSOdRfF5lMMi4bm3oDBg7NefVApGaNXOmugNGz7omSzdDyZ/AMT5L8Ak0SDq3+AirsCbjyjS3vEipwR5BxJr9+XaFFCm3BXBkeEq4qWo8ohVvFvyr46VeZ9x3/X3B/c0boJ44YPebkRZvOsPk2A+X3AD6jZiF9oSMFTuQ8aORYyfTCCii0sKBGbU2RtSCE+6lXuSXw002G7C7EKNdd4QxRT7umavNlid5FwEkZnKXGH4LZqr5mPlzlg8jjvIinuLCiZHIwfGAXwMbCb87/KJNJSYrW3Vkh1EFB2vRUg08ySfC74UdxheckStMY7s+2bTn9c682aPwaeqxWbtAvveNSOWKsOc9nMuUj2mpCRHIN3lvKX7E2uOckE/T9FtnKWiA/hoHvMvsUT1SVtPCdpORm2NVauZcPTMQG4f7R8nepwvJzJsqpb5TnMR+Mx3fw+3U9wpt/tsLIeb48JqKka9+2bkeZtDHFTKxc28P3zvUY0PE1IfdFwSO/XcsyrE9uZBt46PFlQO1erhp9uOqYyNVtlQAryvsK8bzyKcyKHto7JOZzeBi0aXKiMyzpmYatI1+QSxnO/p1JXypZMQo2J6wXaRaB1P2C20Kyo7I4pTpOJufy+LOkIyhVhQbnnfzz205rsl6OrzS7Er8yfeC0AH+UU2XhnRppGv/2psuFYt8Q/x6Q6EScl5WfhEQ/olhmsanyxZQ9TrPbmBcLiEZISRQG4Dff8NLZghpCfWB/2Fa/151sawtOCHN8OMkFmOAQwLTzh2VnmMA2rAUrRVdj3ECzD9QOwyelSObpYlTUTi05Rp67ssFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IuemvkLW+v03qu6l3OLB2Et067v/EbbMZtYzd1rJ3MnAQDDw+1HCO0xkP4tRrV+mB1TRjzPglICB1scBcVwBAyyMFBv2mX7XtkzaQmWk9dtSk/OJ+Vn4axuCW3ORaIpky014wxyLqYQ04+CTeSvpT6dO6LuTK7Al6ZTgd5ZpV+yVYhbxfeD3DGMmLwUH6XNNrIeL1dL2muhVbPCSBTzh+gGsBI2SvBwoBi4et+zfmzMIkjqJ317APxlFhwWwNaJxpCrJr5VUNObp17DHZCpW6Yan8v+q/pfZAhl37WvkE9NuXCph7ZUwP8QzQsX+k+THNLA7tSrZK0/qkUE2labrcDG1jVsiu84kFzEmkzByiNCTZdxdro4ClEaY5J30nouzgbhAtP+mlxF0ZFTXpkk2AeT5sxiQShTgjcWBd/2eUwoPvHP4DPy/EQB2sNweVdop
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 03:58:01.7793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fda64ba3-2da3-405d-1483-08de74eb3cc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4174
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

The metrics->EnergyAccumulator field has been deprecated as of PMFW version 82.20.0.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index a6c22ae86c98..4f729f54a64c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2066,7 +2066,8 @@ static ssize_t smu_v13_0_7_get_gpu_metrics(struct smu_context *smu,
 					       metrics->Vcn1ActivityPercentage);
 
 	gpu_metrics->average_socket_power = metrics->AverageSocketPower;
-	gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
+	gpu_metrics->energy_accumulator = smu->smc_fw_version <= 0x00521400 ?
+		metrics->EnergyAccumulator : UINT_MAX;
 
 	if (metrics->AverageGfxActivity <= SMU_13_0_7_BUSY_THRESHOLD)
 		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPostDs;
-- 
2.47.3

