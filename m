Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91922C369CF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Apr 2025 14:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BF8A10EBAA;
	Fri, 18 Apr 2025 14:07:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w7g6S9fa";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6566910E115
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Apr 2025 14:07:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHeZ9lB6L7E4s5yXjjMsDHC8Uz/AIp6uwZCaN6mRVYg3eRI7yXxhC2fn+0DxOGxuUXnNkGgeLorCY+PZ0n6bopyZtDjxc91Lgf65KuMIUpeVN1lkj+TeQFNOssrv/jOICxUBW836FnqWA+oJAXr7GLP34donPj8SOdzhZ/Oa53HuOI39fl8zyTBjue3Uby+bYoec1uuBtr8B9TXzZLqq4UJM1BngUpCIV1P+cN02ZruuYighv30FVrKJHc+wJtzYjjiCJqJb6V5a/gB/lV0ctCllXsi7PCeWYDlCWhsfpUXzwgGthAINVVtQT6K3T4RYN9jUz95XziUKm5Y7TrE+sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ss15WRTRTmLL0DOg5skMOpAOTaQlyMW4KM5uiJ4e5X0=;
 b=jTSZXDyrDTfurJSQmzou2gu1I0YKR0j/QJqwc3S7GWgol8VW/a1SaXIzgq0zwsq3lO74k4aNfVyoANGhjyQU1rs6dmUxHL60cqGIIUx21HbI5xkkzSJAWjTeNQFO1sLo96SKU7KFwuST0JMB7X4nc0E9uv9LlY+S/CLA4DuHc14IP8CRUK7fF0h++p97LIMraFJcnqj2Y9HHxHcIzE8H2lk+BhNagLdjh+zyx7wOhLiCYdY5KLTqEc13NW/ODmoFJuTjLM39WCrOC2V9POfgyaSXWg2tlVo/VdNw4JBT5igeTDYRbJc1fpyCi0tJp8F0MV2G/vN/8ZxosFgdrBqNtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ss15WRTRTmLL0DOg5skMOpAOTaQlyMW4KM5uiJ4e5X0=;
 b=w7g6S9faIgDZjN8pnRdY1byCkw/ROE7uasKNwjWtD9sRrJXtpT8B+fB8JXi/QfW1aeuw7rcIMv6RXcT1Q0eqg/HC5um3BBXEzi45Z5OrAmB17jvmc/k32Nw1uZV45nei0QSMoSdmPGfH+ojOJZy/01GW9/GyVuYUMZu3/8CbN7g=
Received: from PH8P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::18)
 by BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 14:06:59 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::16) by PH8P221CA0016.outlook.office365.com
 (2603:10b6:510:2d8::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Fri,
 18 Apr 2025 14:06:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 18 Apr 2025 14:06:59 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Apr
 2025 09:06:56 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH v3 6/7] drm/amd/pm: Add voltage caps for smu_v13_0_6
Date: Fri, 18 Apr 2025 22:06:32 +0800
Message-ID: <20250418140633.420887-6-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250418140633.420887-1-asad.kamal@amd.com>
References: <20250418140633.420887-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|BL1PR12MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: b49d8f38-d4fe-4831-62ed-08dd7e82490e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Pz1CSBlOiTmvgr9/t7piUANgyocCaHOKyW/gDoX+C4qy7rmrHZwBEUYnuRMN?=
 =?us-ascii?Q?wB76mSowJTOQDnvfxwOwiM4dVSMyqNrH53HS8SchBPm5mV5TlR0rDey5deg5?=
 =?us-ascii?Q?jxaPVv/uubMMCIKJ/9fyaoevse40lVG5mineX5Uwha9EOhxrFCNbh30DKrGY?=
 =?us-ascii?Q?a/VV2bXLyv+tsFkXHm4o/Da39Orxg5mn27w9nMGJ3tRkv5hj+XYBTwsXDkXn?=
 =?us-ascii?Q?L9gnNah5o7K2MjsbcV+vRwyZwBvB476wxlPpMXIy3eZyOiGUQXF8lwI739Gw?=
 =?us-ascii?Q?xliaY/mMA/brZsZC8SOWoA4l7ujqH6RuND6sctNoCDR1FYh71+dFoim3238s?=
 =?us-ascii?Q?rLPOTbp7SOLSLd7ZL5lzuzh579BVMT1HYRY8iVmE3MIGgMheleQtpQbZQTYX?=
 =?us-ascii?Q?ejS183TGR3xLTiNuD9ZBHwpIv3+TFYl22Zoi3TFwpZhJjByTi/k+8E+6OnZb?=
 =?us-ascii?Q?u5t03zzsHqUf0OEgjQEPSk+AQGSlzHWLodkuWt1QdYHHMhg7cwax6MaJz1CN?=
 =?us-ascii?Q?OYkwZYwvhAyMR2WP3EPMLK0OXtZSP54hnxVJlircDrPl3xMz0hbIbkkWgKJQ?=
 =?us-ascii?Q?LlHSCgafT7iMPFOieSxchXYypmUDg31GLpyXN4XfZdo26XCRU5Tn6fATLd3/?=
 =?us-ascii?Q?URXHkITCifLFz8/I18Dw+i7/WXpPzNGWRhnNKK1galkgae4Q+294YqyEYo0n?=
 =?us-ascii?Q?HsTUEg48x3VTzGLOMmTxCC0dNbznT34f0ahXmjaIy8JLGzLsuhKrpdOckG2T?=
 =?us-ascii?Q?wRb208NdBMzOTkNr2JHsdCdq84Jo22It9y9EprzRPCg7rDM0kLYiE1z2/Qwp?=
 =?us-ascii?Q?kLGC6+LpE7h+KxrTVQTW37siLek4zc9hfhONdZ0cTxJ9eS89Y5ugCCLEdhj/?=
 =?us-ascii?Q?v0c0Qzpyrh18LBiFVNlcLTQgemStKRV4/nOihxkJDuUH+BdQScAOdRWQfr6u?=
 =?us-ascii?Q?OFFe7IIQODLJg4/YpRRm9LT0b/mAzFwbj4nHqNbv8lZ3uD+swZFk/urNCh+W?=
 =?us-ascii?Q?jvvjuLEXrSn7N03zIc8IaFWWA3hv9eJuqWtfDdIGOspgpE2z87/8EQZZAisv?=
 =?us-ascii?Q?FvxwlXz21BHW/uzXlxMgrSu+4bMicGjXypn2WlIauz+M++OkD2X5gq7kfw7v?=
 =?us-ascii?Q?PQ1S/DGlpoOpNFgcjuNUMaFc8HlEHSOOy97LMW+80D2GcIwdoVTHyHoUBtli?=
 =?us-ascii?Q?9O8FA9Aagy07jHlTI/tfCvMPv82tkR5xVTiOrMvNnVdi0Z092gxjRyp7tDKN?=
 =?us-ascii?Q?thrxpQH8FEuGPODfH+dm9j9WyJqcwiMrbCxBHpNCZpWSnBR8I/zsuOa3gQ06?=
 =?us-ascii?Q?2AqEeJt7tvWete+5o3lE6Iy27izGV1fUMWHgsJXAqlmWcnCXdF957EimhK1P?=
 =?us-ascii?Q?9Nw/9cgXhzxkLmiL6YCaQiEQE9IvDJfhk7RLCZt3XitpZMNy8kMwLrcSXzux?=
 =?us-ascii?Q?eQjTpeGLoo0IF3Aj3I1RDsUVWC1woqe0qBjdEE2WDfG+IFZ27NIZuv3E2SfB?=
 =?us-ascii?Q?0+XU+QHUWolEiRaAJkII5ymwJfcwNQRm9Yvy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 14:06:59.1600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b49d8f38-d4fe-4831-62ed-08dd7e82490e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923
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

Add & enable board voltage caps for smu_v13_0_6

v3: Update version check for board voltage support

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 469cf0800a5a..91b1c2af340b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -392,8 +392,10 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
 		if ((pgm == 7 && fw_ver >= 0x7550E00) ||
 		    (pgm == 0 && fw_ver >= 0x00557E00))
 			smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS));
-		if (fw_ver >= 0x00557F00)
+		if (fw_ver >= 0x00557F00) {
 			smu_v13_0_6_cap_set(smu, SMU_CAP(STATIC_METRICS));
+			smu_v13_0_6_cap_set(smu, SMU_CAP(BOARD_VOLTAGE));
+		}
 	}
 	if (((pgm == 7) && (fw_ver >= 0x7550700)) ||
 	    ((pgm == 0) && (fw_ver >= 0x00557900)) ||
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index c7a07aa5ef14..5313206ae4bb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -66,6 +66,7 @@ enum smu_v13_0_6_caps {
 	SMU_CAP(SDMA_RESET),
 	SMU_CAP(STATIC_METRICS),
 	SMU_CAP(HST_LIMIT_METRICS),
+	SMU_CAP(BOARD_VOLTAGE),
 	SMU_CAP(ALL),
 };
 
-- 
2.46.0

