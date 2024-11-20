Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961C2D6E2A1
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 02:36:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BC3410E11B;
	Wed, 20 Nov 2024 02:36:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e5qtjog4";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E855E10E11B
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 02:36:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9hevVG36ueUpZlYije8ldEl1YpUCNqRTvz0DK3Ti6ROr6i3WfRWutZdpqfC0xKR/dEPVHGAYpMPTBrHLcL50O+0jUF5L3efkN0Cx/G9wdzLs3ee3uU+HgEdL1LedEdBn0et7fR78Vwz1yAip5ANTWZRiDqtIZviTkxgVeQ95rOmRtvEnfHV8EivZt/i77WYCvrmSn5h4AUiEtzH1Sp9MPf4BPP9D91ug24beFSwvZKIuNDFf7OQT/HMXDigdDS4b9EQBVP9TQdhkNdVOvxow74JDV0YYpyFxTPSvkykDaRE1dJhMxrUbF5/HNRuLgOO9vUd1geeOS57/sP/3Ou38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKehMYx/stJ4xRWgLmFvagAthKjpwbXoxEY56Ot32so=;
 b=Q5JXph6C+oCSjmut93Z2kWeyY3LFiSPmRabNWf4GKWrRujHug5c+e/L8ygCne+QEl25pAIkcBliNQlwxrb1GXKIh84OOMDhf5xG5g+SfOhzdHGVo5nDYleW591KnkZZKlNNscd+MzZYVMsjLh8aDwjH2ug99+i8xtRBZef9sbwAt3y4IqyN+UfvND1LC6zR+7OTwSIXbGkctAhX5z/e0jwxiYDZDAoS3+mKcAzI6WnxRSJFB9Vf5aOo2ZF32E43H4FSV1S2eYtowg1yV8MGQlTS713LZUQJFaHCi1jd2/kmWPxkDDXMFjoL3njZZCzBi8PlGRmNyFVTU8A1a2t+BqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKehMYx/stJ4xRWgLmFvagAthKjpwbXoxEY56Ot32so=;
 b=e5qtjog4P738anBpQMlOUMdDqQ4zyr4LvwJqCvMZHz/9kEwFKp8hrosRB/h5KqqLh67n1kbPXuVGzDtc1CCvMUjtdIGT1FJOSqDK7JrmagRuxcJu+oWcAcdEDDWKRCOQx3QWG2oiDt7VOqsmrHzVGDzcPKTb2RVS6FoiOpirUho=
Received: from SA1P222CA0036.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::21)
 by CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Wed, 20 Nov
 2024 02:36:02 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:2d0:cafe::7c) by SA1P222CA0036.outlook.office365.com
 (2603:10b6:806:2d0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.25 via Frontend
 Transport; Wed, 20 Nov 2024 02:36:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Wed, 20 Nov 2024 02:36:01 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 20:34:22 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <harry.wentland@amd.com>,
 <sunpeng.li@amd.com>, <wayne.lin@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amd/display: Need config check for
 drm_dp_mst_topology_queue_probe()
Date: Wed, 20 Nov 2024 10:34:12 +0800
Message-ID: <20241120023412.322957-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|CH3PR12MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: fa6de1d7-a7fb-4d3e-3fd0-08dd090c1311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1XdxWKEmw01IKXXsvgQYVa8IysN65tSLvcJS0i6nxusB8LmLnxMuk10sfu7/?=
 =?us-ascii?Q?RCMN36+byW85fdZEY6VFpwHFkl+TR4uaMURPO+cDjFYGDVVsdl6tAlqKm2Kd?=
 =?us-ascii?Q?J1OvCk/tk2IFrPm90cBGVAA9gu3EDfQEsL2LPHApdJI3R1dpWdG+aJnStndE?=
 =?us-ascii?Q?To8ztQVSPfG9YV+qBJFwdY2JseYJ9/fga/u8RrACwvxBdcPseOvEi7o2ddCG?=
 =?us-ascii?Q?y5npVzZQ49CrIiYmDGUx+P2SPiWInv9MSHEGIkSvSUMQw7nrZcZ9DuyRmh2I?=
 =?us-ascii?Q?IQR2IDGzM55nbbqUjoaFYRAgB+DA19iSJhr9XB6FzjinKo69E2orRdgDL+L5?=
 =?us-ascii?Q?BHGKzDEbur7XNFdYU3WMpU098nBkBsxGxXvTv1E07ehxgpWuhxCyOoBNoR2N?=
 =?us-ascii?Q?6jYHi/59mwqXY9gyMBIK/vymhbG/kaiGE8TuT15PKoPAkOa6HUWSGY+4++Nf?=
 =?us-ascii?Q?zwSubLpAKhVZm177bnRQF6W2rLksZ5iKzXs9kJz1LgPkSThdwv7k82SgrVkw?=
 =?us-ascii?Q?BGFo/m+PZlpx3moIgOwsTeR09VZj8czoddkSBmcm64NkOk6HYqJXKZ9tm37f?=
 =?us-ascii?Q?vbvaICQKLeAt3DWIeH4x04FArYPobfm0YJMnaRyr2tCm1+jBxM2mRj76F/g0?=
 =?us-ascii?Q?RAe2Cf9xoGHUgSkczsHouN5mKh/hKYhS0he76ygZKmjFS4n6b8uA0wcS7/oR?=
 =?us-ascii?Q?YQw/4blQkLtmCfcdXd6werTBHQVdk4sP0Fb8slQlNOC1xyCoy6OB4/Aij9zE?=
 =?us-ascii?Q?RCu35NI2d/fs0J8fERMxm9Q+GtkF2Y7aNEUMVRvJaMiyp8fsLsEugSrIQCC5?=
 =?us-ascii?Q?uU8GUCcmPvgo7KSs7hRxgGmzdOpHjIZ0NEnN1g2PaCtnzAF61XkP7ZfiRSpK?=
 =?us-ascii?Q?1jMYrihQFtTHyseGpPzdlvJ76rYiJkEatifnvn2iZzSOd94zLwp2eHHXZ98s?=
 =?us-ascii?Q?EOUL9zDbY0CmPVrWZBvpSLZOXBEYrpkWHlF9oh6puUe5nJ8KLnQpkwbNyGyr?=
 =?us-ascii?Q?gctBcKoSOFort3hYJ+ORQQ2qRl1P+x/7hlJN6JffviHLtjNxe0bzyrxxYJtw?=
 =?us-ascii?Q?e3e72UsGMRZHS6U6aOq4GopFYWw+EfRRH8ZZlYGZK1ifywKaCgXPQWSkt4AQ?=
 =?us-ascii?Q?6zp/zAdI0YykpJ9DHNmkyXdbSaqB4w4o7xp7/xbovZTGm6f8AZguF/72P0eg?=
 =?us-ascii?Q?YFKye+D9kNjBSISI8xM2U3hx5e/4vkuLvemDkEp5Sca9Js9sxm5/f99KHv1G?=
 =?us-ascii?Q?iVqBQganH3RTgErLfauQljXRc3i2efVRiWA6Fgcq+/2xxicw3H5Mwg854Mgb?=
 =?us-ascii?Q?bmHIKqw0TmBZ2nhbNCih6urRf2wogNfeduRCSRU7DrXw84zFd5++x3ikDNwJ?=
 =?us-ascii?Q?Jo75kaABV5nSxA4+mFUmRHxhKhbTm1HcYgREgwiK0hMKdDNK1A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 02:36:01.9852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6de1d7-a7fb-4d3e-3fd0-08dd090c1311
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7548
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

There is need to check the CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS config whether
is enabled before uses the related MST functions.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 94f1651422da..21c0242daf19 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3382,7 +3382,9 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 		    aconnector->mst_root)
 			continue;
 
+#if IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS)
 		drm_dp_mst_topology_queue_probe(&aconnector->mst_mgr);
+#endif
 	}
 	drm_connector_list_iter_end(&iter);
 
-- 
2.34.1

