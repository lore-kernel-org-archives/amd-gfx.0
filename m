Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE017EB28EC
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 08:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C65510E566;
	Fri,  6 Feb 2026 08:31:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1WVd/fJm";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011043.outbound.protection.outlook.com [40.107.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EC7B10E566
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 08:31:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgqEqT0Kr82VgbpqzHmlBPtu1JtX4lM2w+FyiGsXsPxedQC6738+QmeTGw+wKZc6drpKN6jfUXZUkZ40uKLA9Z4bI+7XZBP8JP91KLyXR5KGbNowm90zZ8+Qd8S6CyqMyX6NaaaX1Vg3h9MffLtuZh2wyj0KQpug5HW5uXf6s4YJvTueeH8uQ2kM+YdkTnN09/yFc99fTFAVGBwD9kkzB2isaNbFqH7BS78TVse8RGxegSpj9GaTMdyKiUcTl1tL9iA/IY53TmrCtsfNlcEUc9AnS71/PIXEuc8FEKxtLXvsb40j0ATMyobLaHQh3QT6Q441U9R6EYzRUnT/EwL2BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wq4cnpHEu67+mdQnyrrultxdvROLuBNfpwrQekjk7rU=;
 b=G6TVGU/d+P01dXc4zjuZSadYkrWPmVV+502r6gbMnu0cYMOzfQc8vEqHKhsmrO+8RgwU4Il3QNyeluo8/SpLKbyLpxv8LgxvQyUnFt5slLb3OMVW0jMnB/1Pdf6svYS1RWfu2ZLQvLZYLemyZghqTNmpEq3A8kjPxJRlhDGERH2l5h1DfSFvMpxAbT631AwSmsqSoMLI+DXmGMhcoumc0YSS3aXgips74uAQD5LDiAjZ6h8Zm5AODqhjP/97TVZMuHUGb2Wg2GaosQBBopwpAalaW5U8EZ53NmPRGJ5YcnRcles/pUmARAdtgVdSpaUKjklPcS27/Evc6Ui61jTCOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wq4cnpHEu67+mdQnyrrultxdvROLuBNfpwrQekjk7rU=;
 b=1WVd/fJm1/sX6AR2/xCYVcfywShywEepa9j3l5GFqisIjUXS3+bVsb3BSnyy+Wt1cCn+9/W5miLC9GJLUt8gUT9RsqL5zH2B5vNfCDFkLhXCarxWof6xEvk/Z2KcEUz6NM9rwkI3WkyIxKYQeZ2BIt01xneOC/0tE0M0zIIHDBU=
Received: from IA1P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::11)
 by CH3PR12MB8970.namprd12.prod.outlook.com (2603:10b6:610:176::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 08:31:47 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:208:464:cafe::10) by IA1P220CA0022.outlook.office365.com
 (2603:10b6:208:464::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 08:31:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.0 via Frontend Transport; Fri, 6 Feb 2026 08:31:46 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 02:31:44 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH v2] drm/amd/pm: Add acc counter & fw timestamp to xcp metrics
Date: Fri, 6 Feb 2026 16:31:28 +0800
Message-ID: <20260206083128.4134355-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|CH3PR12MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: 88a46b72-b5d0-4118-1a42-08de655a2a4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?96f1aEF4KICNGh32lLCKC7DosGKV6FC9BKROXy0NMeH6FUaLXIfT5c+pFmHS?=
 =?us-ascii?Q?Z1nCPvAzN4XXaDUdDiAtU24cdOKD8YMDL8IySY2nM9Ctc94/01Off3Nx1RhC?=
 =?us-ascii?Q?7FixUOP53oTeJWogi5WBcIMhed/YfaNYKqOzNXU0z0v0mR7THLufnlNC5Uh8?=
 =?us-ascii?Q?pxUuHuvw2eZMOQbXk3vx2SnMBkPJeeknj/p8Uh7fil3/ymkGei0MrD4oaNF+?=
 =?us-ascii?Q?nBThiLNf95GCUnT5WSmuSMYxJYuyljFHzgHYkQidfK7KZpFrP9KuY3CvbvHE?=
 =?us-ascii?Q?KBaoBLlyXXOjCjXIDubjyKa4RuNmovfAi6dJ+Hgjydy/TEev6HUvRz9Lqo3h?=
 =?us-ascii?Q?nCzuFveyTp2avb2/SJJcdcpoMDYRAVhfH5uJ+qK2KzkaQRKx7Y+FHLE6khHP?=
 =?us-ascii?Q?Dvvxt/gdHf6NdQBFzDdxTdhOYrzFOthVRTojEn8uaTncwfJSjqVDO9FVWLnm?=
 =?us-ascii?Q?PeU+LArud04Lt8BcLa6zYJxgmrnoDoH618qf7OWqZE2yO4mgsxzpaulO1or5?=
 =?us-ascii?Q?kRKx9/XJq9jD7hRtFnFWf36NYZWskKuJA5nO9l5G7R11ZLcAlG7RN+6U/7eA?=
 =?us-ascii?Q?akeWIe6j9AHrSkhITzlZYhpSdMBSSkx0HuxnZJEjPsug6eNOhymukpNEabco?=
 =?us-ascii?Q?hdKZzC9bTLwSFaDSZDl+O2fDo6pslIEDKjTclMpKnHkivzJ72o34Q67dxzoD?=
 =?us-ascii?Q?KlQ0cLDq8OQNRJdKaqia1DZDuDV4rdIW8ST2JM1iSmA+mY5sQWyk4+AAGYVy?=
 =?us-ascii?Q?sanCDoJsDaxq/S6XTZWN3YZZhsJI7qmMxm3qPENlk1YO0FciQAVLYe2pPP2j?=
 =?us-ascii?Q?0FtdK5P/V1ItlxfRTPsFCClEgaKubprnLMhl2TPWk4MjoaZn2q6rzOHpRl//?=
 =?us-ascii?Q?PurDggn1HoG23yPy75u6Di9BXwzBZNzq6OihHpLxWEeBxvhzzyAZBKv5IjRm?=
 =?us-ascii?Q?M5+jSWH4nbdBCfLR6ytxBu3m7eYOC9gjKRtQBNMdCNaIQBKGybBbDwt07Lku?=
 =?us-ascii?Q?TikCPsYzYbtZ3UyNWc3qLeCVuObIPQNv1sw9/6C3l5ZAThW9wvjV3Mhy26KG?=
 =?us-ascii?Q?xeFM2bxsh943zwT0Q7cxaKf1i/MZSPEAEG6tRentiHWRbgfKOkg6h5jsq6GL?=
 =?us-ascii?Q?ZH/hyLdu8BOnzwDtFNAwxO3kqco3dHzEt4nhSMZ9MLAdDFZDNmHRVvnY0ibF?=
 =?us-ascii?Q?/wJFaN1baR32QxwYJmGYXkxEgXqa9WBzxcHhXogYnlQzH6rU9+a649m3LbmU?=
 =?us-ascii?Q?4QyIkp8uradGH6cQ43A2y7WLaeizpg/wVc0/rin1Nrl+2TZrIuYEkk2TPyoR?=
 =?us-ascii?Q?yPTZ4uGagoawridSq5DX4HGPEZb8qs7yG8kvXhgBkeIiiIWVp+iDeq0D8C1X?=
 =?us-ascii?Q?662bDAKve4AjLprPCTo0AEkLBInwKz3JlmBiFH6tH1PgilNj8OJx85n3hEwS?=
 =?us-ascii?Q?8OrKnzNHYym7mreqPS1rtvCTp28bkyjIcrr1HsJai0010UdKvGBsqa7M5b4I?=
 =?us-ascii?Q?VtehXrB64rpY2DlahINYlk0or7ZfIMIo0BePphmwCqsG6NHcaFUM0zXO4+q3?=
 =?us-ascii?Q?cMv+Y5pzko7i2igjFkTb9iOf4p2UmBZXMV8vOJq9uCyUZMmABFpq2HuhPJZv?=
 =?us-ascii?Q?68ZGzsGz5nauVK/pcmYI0JlRcq+drqobFiQwMuDnUlYn79MzuMZQaywOQZc3?=
 =?us-ascii?Q?ih9+3A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WXzGscxqbBREEPwoSh0OpZs5i7RlasGpQUTHv8nnXBaWQiE/NxyJUFuoR6gJpB5lrPenn8u0Ite46SuDvBTVmNlQ9lujnmjSfEn8KpAOLt1PQk4YP0mNX05Kcq8vUUa0CM1BmbbssI3CbyIq9zzFScQ4gYfqBjd0tZfAFDAANK6kYwmncSx1deaJMiTcEOlA7w1nztf/LfIHdV9XJqTKjjV+i+nhL750j8lNoTgQWrhB11pKG4ipHMEYvk0ksvfjix0RnPKeuHzwwk1nvt1lBW6pCS9mbFi/GlWhQXZOKnSJScBVSYpQ+gQLMazCWbgE3GyZchvQn/YL30gkUmdtExvZIRZMGxC49aazoZbfNyzzfuMiP095IsmQiFYTUWrHqDl6DC9X6MHmPBfMYhhch98aCi6MogjvQ8cHJ/yVIeH47qO3aYrVepU+WVyCnU1b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 08:31:46.3738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a46b72-b5d0-4118-1a42-08de655a2a4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8970
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

Add accumulation counter and firmware timestamp to partition metrics for
smu_v13_0_6 & smu_v13_0_12

v2: Use U64 for accumulation counter (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  | 6 +++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 3d60d3c1e585..f2a6ecb64c03 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -823,6 +823,9 @@ ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_context *smu, struct amdgpu_xcp
 		idx++;
 	}
 
+	xcp_metrics->accumulation_counter = metrics->AccumulationCounter;
+	xcp_metrics->firmware_timestamp = metrics->Timestamp;
+
 	return sizeof(*xcp_metrics);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 3a9210083ce3..07592e285cf5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2668,6 +2668,8 @@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct smu_context *smu, int xcp_id,
 			idx++;
 		}
 	}
+	xcp_metrics->accumulation_counter = GET_METRIC_FIELD(AccumulationCounter, version);
+	xcp_metrics->firmware_timestamp = GET_METRIC_FIELD(Timestamp, version);
 
 	return sizeof(*xcp_metrics);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 0588a5aa952d..07d4cb6562b0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -259,7 +259,11 @@ void smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table,
 		  SMU_13_0_6_MAX_XCC);                                         \
 	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_TOTAL_ACC), SMU_MUNIT(NONE),  \
 		  SMU_MTYPE(U64), gfx_below_host_limit_total_acc,              \
-		  SMU_13_0_6_MAX_XCC);
+		  SMU_13_0_6_MAX_XCC);					       \
+	SMU_SCALAR(SMU_MATTR(ACCUMULATION_COUNTER), SMU_MUNIT(NONE),           \
+		   SMU_MTYPE(U64), accumulation_counter);                      \
+	SMU_SCALAR(SMU_MATTR(FIRMWARE_TIMESTAMP), SMU_MUNIT(TIME_2),           \
+		   SMU_MTYPE(U64), firmware_timestamp);
 
 DECLARE_SMU_METRICS_CLASS(smu_v13_0_6_partition_metrics,
 			  SMU_13_0_6_PARTITION_METRICS_FIELDS);
-- 
2.46.0

