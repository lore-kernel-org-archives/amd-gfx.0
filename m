Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5ECCF8843
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 15:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87B0F10EA33;
	Fri,  4 Oct 2024 15:01:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Di+8fkHa";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AED1B10EA33
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 15:01:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDGRAoc2qa9tm3dptsSEQ99uGihxzGC/4NlSSxgzlJlpi2xiHcr5pj60pIdU/wil10v04ATTnCYqlyVXYKpEaDiZUBPAIwGggDak6SSoAe+bcB14FILjMZOi5Gx1ehu7/1INs5K+G7qEtHGpuE/a6BwcjwAPzoFDvjhokJ9wF1c8DepBGebY/PoSbGZEs25XqgKOsnGuDmbmbFg9+0yQyEnUFZwh+4RqGq7y46yxWv0pEHS0TR9Dqkrl4TkQr15KU8JPN9B3VthB48BdFbOZdDnJR//Pb/IaeBCz2NK5VkSpKkZ13u65jteYMyhmPL4lA1JkrPCNyUu8B9UTPpfcAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqR9SrMdio8ON38HtrDcToXbiPFFm+aAUkx90INWicM=;
 b=ovGNkk5n+iuU+xet/Xz1u0WKUUQ4isDf47dbpX6ozili6Deatisiad9z2oTvmRIo2M3o+LI3PX9RyYonsrHSvJjC56E91Wn+uXexqgnVSvH5d3E6P63RXEnTQYDldMdWCSXV++/K/9mQ+Rpx0ZtnBHNImBPtzMXmJyALvp1D4LTFgIJhSCopfPeonMHdk7K2zW+k3AkAGJlaUEmcUNNyS3DWUwn9LrbxsfRhRrFn6KdTp4hrCIDTW2PzM5zcncTIsF2EXh+bvvzDHWl/0twkwsuzlDrJthC5eDzIZXF/GWrIZBVD0Uy3oIv6HRvUf4nWs4ehZx6c4P3t33bVFiPWjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqR9SrMdio8ON38HtrDcToXbiPFFm+aAUkx90INWicM=;
 b=Di+8fkHawU0JCg6vryos1Gq/97Bc0v5KV7HXLEOUUUBzKz/X1WiAspX8eSKGgoUtBQafhcMo7SlmqW7YTVe6ZYDwCJTfOVZ6RkmX8iHfzjlbn63YU5fq1GewprirNWyxq1i0ZYSaB9EkpWTLYCLkO7DO+U9YjJRn09BUjtIFn+0=
Received: from BY1P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::12)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 15:01:25 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::54) by BY1P220CA0025.outlook.office365.com
 (2603:10b6:a03:5c3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19 via Frontend
 Transport; Fri, 4 Oct 2024 15:01:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.0 via Frontend Transport; Fri, 4 Oct 2024 15:01:25 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Oct
 2024 10:01:21 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <le.ma@amd.com>, <hawking.zhang@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>, <charis.poag@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: Fill pcie recov cntr to metrics 1.6
Date: Fri, 4 Oct 2024 23:01:02 +0800
Message-ID: <20241004150102.327639-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241004150102.327639-1-asad.kamal@amd.com>
References: <20241004150102.327639-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ee5d19-f339-4e2e-964d-08dce4856abd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VXc8GLilOHhWqB366SlhuWM9fdPZmsvAPav0VsURJc5tiJIa13np5g4yv8dV?=
 =?us-ascii?Q?rDOH/c6eM+pGdQFU1+cB579SPJYPttrBuxfCEW9iEpx5LUzcSqdRkYneSVLi?=
 =?us-ascii?Q?auD0TJEoyJ+Kp9J1mkSkBzmN8uAzsVge12Xpf5tCN8VqEVDl/A44yi65/jKr?=
 =?us-ascii?Q?MKbHEuleG+pu8sW511BhF/uioRRbHRYOGvrjWcXdV8NO2TZiBEVjYQLS4PRN?=
 =?us-ascii?Q?BipuP8lyTk9YXF7j5whF5TFy7tgRjVTgpAXtt8e+XVhqCRa3iRelXelABHqu?=
 =?us-ascii?Q?CG0r1o2E+zNyz0XlYIKTpARJJwAF5+nFptw3oFupP1+o/qqJcYjSysNRLUqp?=
 =?us-ascii?Q?w0fnpuY6ZNCd2BbfU+XHDvDBA6tJuigNkFvHZn/+rqThHWvvrDVB8yZL7Bzz?=
 =?us-ascii?Q?KuPTmrSqDnVHullNvjNfuxtVFr72ggSNx+zujG5arzL4az19fDTHHLi4VTg+?=
 =?us-ascii?Q?KZegZR8kU58S1LE1RDXYvMqkjg8lCDPuju8GeX23Isu1VRqhyfk20juO1Ain?=
 =?us-ascii?Q?8cf0ez0xkRK5V3ZvZNnUB/Va6fi6P7QES7OhHAdbFBAq2xEZIkQRt4rbVLlk?=
 =?us-ascii?Q?fSzmzdTubWgxzSd9b/HmF3usFLVX2yuN2nV7qaPuWkEFTIxBFGE28Qg6Bhpo?=
 =?us-ascii?Q?6miXaPzYGRRky5eo5+q6ABZhuNoHJJ+4Zm25/eK5jGmC2nf51oRrW/72Z3Y1?=
 =?us-ascii?Q?2NcvUtGaJYUrHeZSUPrQJmR0nxm3/eJgQAcrLPQ7U4xXHkCV4xjvs5TYSFDu?=
 =?us-ascii?Q?ga6hW0pf6SbxD4HIQkaSgsoi4cumyyAAeQL72rRwJ5wlFgWcy2pUKtzmqKeZ?=
 =?us-ascii?Q?tkcZbdmwbq51IEve0E93bd9QpTCQjipSI6vTIRimIc/3HMKXPx8MxnVpD79l?=
 =?us-ascii?Q?fh9lgr8TkGMRC4SJp/u35AS5CmhUct88ILMAJVTp5pLdKi8fKKXDcG9W5HiH?=
 =?us-ascii?Q?o8PUfbmh5+y+5/ieXXonxjE+1Q6umpYU0SPHF/zm52iu3jsEF7ohE/BJSf38?=
 =?us-ascii?Q?d7/Uq2alCjBNJHTC6GTD4aPEivnd1BKu/isKs9+GuNEfhtB3Q8ZGKIizWC/v?=
 =?us-ascii?Q?Q79Tg3z39L/8xv54OQAdv+CvwDXBneI/cUByXO9irn4K4KFWcuFYJSxWjtUZ?=
 =?us-ascii?Q?5TUYuIclNIi5tP8IXt/O203kPXg58v+qhkW4pP+/+TqQHPaSLce+wt27mnJl?=
 =?us-ascii?Q?JYLBUwNnrOByeTiv2bC4ISgcB20BP5Ak35AR/Aw5GCVFyPABZdp7X2M0Z/QH?=
 =?us-ascii?Q?7luZOaM7ey4EcSpo4PCU1ul2VLU/qswZvcC0dmOkc6csP1+ez8aKgrksiI/T?=
 =?us-ascii?Q?zIdBsP8kOd8CwkJZWUoNOuSKfRAnR6KaaQQsrszaVBaq/w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 15:01:25.0798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ee5d19-f339-4e2e-964d-08dce4856abd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386
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

Fill pcie other end recovery counter to metrics 1.6

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 52f3c537bb3f..a85574a46769 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2306,7 +2306,8 @@ static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
 
 static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table)
 {
-	bool per_inst, smu_13_0_6_per_inst, smu_13_0_14_per_inst, apu_per_inst;
+	bool per_inst, smu_13_0_6_per_inst, smu_13_0_14_per_inst, apu_per_inst,
+	     smu_13_0_6_rec_cnt, smu_13_0_14_rec_cnt;
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v1_6 *gpu_metrics =
 		(struct gpu_metrics_v1_6 *)smu_table->gpu_metrics_table;
@@ -2417,6 +2418,16 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 				metrics_x->PCIeNAKSentCountAcc;
 		gpu_metrics->pcie_nak_rcvd_count_acc =
 				metrics_x->PCIeNAKReceivedCountAcc;
+		smu_13_0_6_rec_cnt = (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)
+				== IP_VERSION(13, 0, 6)) &&
+			(smu->smc_fw_version >= 0x557600);
+		smu_13_0_14_rec_cnt = (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)
+				== IP_VERSION(13, 0, 14)) &&
+			(smu->smc_fw_version >= 0x05550E00);
+		if (smu_13_0_6_rec_cnt || smu_13_0_14_rec_cnt)
+			gpu_metrics->pcie_lc_perf_other_end_recovery =
+				metrics_x->PCIeOtherEndRecoveryAcc;
+
 	}
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
-- 
2.46.0

