Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1547C87FCB
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Aug 2025 14:29:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F82110E118;
	Tue,  5 Aug 2025 14:29:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kDQ0B3ja";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6C8710E118
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Aug 2025 14:29:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G12iFZY4gRCGhl9YnPQH6fBUzq4UkvefPfeqFz5/OVnk51jnCfMldEhLfnoTTDkBD9/fYSTHRlXvPwikCheTrNUI5PTQNtd054hp7tZYf9O5S5CHaQoAOdn1/RWP0AAKSz3ylZdoCcjwF5OhaD5ASRtw02LCfMnMymsY3kkTVBuFLnSGIj35W8gdednFKOI1C9904KO/irFZXxBpqYYutrU+TFIMT2ZPb7K4UHMMoGn4lSAQP5/mO9alg9hSTjY/Jr/FECJVSpFgzxZCzUPu/kzlTS2upMIQAAfxm/49UViGf4askWazWpYEJwxwVnbpXCdVN6HVgN0MpgJG6KZ4Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQCCTYqznorj8/WEZzOPLghAvU472AJ3YgksEC30ers=;
 b=KiNPUakTpzDvj05x703bp2rCrOQI+Pf2f8lFEyxa1zcvvF72ifwGlGYiRrhwHZn6AWYDKPqUB5+HxyYdnYYm4knhesoiQD6u2APBbGhdJ2YBaImzrtFnkk6XWPKnjyPlJOlngWVkklaRU6R0yl/87qb9VwrS55WRNcW4/V5qfg9GUfMO7iMQLdLMwdcY8BduLelzjdYFsqlaEr5A3a2Kjo0i0K/jv6yOM5yccXJ6wzeUxs8NEw4ZLoq6OwGht2phnZin4DvZHqpRf9/QKD/1014k2PO4dIBapZuaY961Vox8VqiOhHGfmEUhvJUXCiJ7DWb7OQQQZwzaJEiidfFPSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQCCTYqznorj8/WEZzOPLghAvU472AJ3YgksEC30ers=;
 b=kDQ0B3jaUmwEgtMix0anqmuf41H1R+hmYKXYod3V0IENo+mLRzU9NLNWOM3wBknRk8SWVO/MlRFxIOCC3leqihm5dOLZ7tsECYSyjPnqi2ybhr/erpm26pTm3vRcWOerFmvXt5LZ/K79lWVhB2KQmwpA1o37c5l2aWF7kreTRq0=
Received: from SJ0PR05CA0186.namprd05.prod.outlook.com (2603:10b6:a03:330::11)
 by SJ2PR12MB8873.namprd12.prod.outlook.com (2603:10b6:a03:53d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 14:29:22 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::c2) by SJ0PR05CA0186.outlook.office365.com
 (2603:10b6:a03:330::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.11 via Frontend Transport; Tue,
 5 Aug 2025 14:29:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 14:29:22 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 09:29:19 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <alexander.deucher@amd.com>, <asad.kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Increase cache interval time
Date: Tue, 5 Aug 2025 22:28:34 +0800
Message-ID: <20250805142834.668322-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|SJ2PR12MB8873:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ae07e5-9eda-4e86-9beb-08ddd42c78b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/KGLHV8IxhADjKV4sarEdWy8Fag541cXfhoH4I463TBvdEQi3JDlOl4K5qTl?=
 =?us-ascii?Q?B98RbwhncyOlavL028FK1tXnCm7Zt38YOJdsJuQyV6lXwoYBaithx01+FOj3?=
 =?us-ascii?Q?B5tMwX9q1NM7h9oGC8c9+i0AWl3DAzUvUE9DM2ZAioSvynW2nlvjzZem0NiS?=
 =?us-ascii?Q?A1UTDxbvC+Erwj4phvPW0xmWhDIYhFzMV2Za3HtYvYwkF0RjxL/mgZQ1I/rl?=
 =?us-ascii?Q?It+rZfhKVhqI97xKORu06HPCyusSHSs7DqDplBpTOdLYZ9jyZH4StCozUczd?=
 =?us-ascii?Q?FRmubtE0/8A6YU7dS7eb3reyqj3U+iczW2RTT+4aiObtjt43+D7LYMjeaQf9?=
 =?us-ascii?Q?pjR+cuYzCuGmBEgRiLm6wva1pYPfTi4ArtwxoUtoOLopp+2PZmIfznme/WOa?=
 =?us-ascii?Q?l4PYSei6HPMuplYXWxCpAWSKb07R1Nlq7wECAc3yftlWS62AWBd/ZDeFjNAs?=
 =?us-ascii?Q?Az8PO9TBcAo5OrSl8Y9lXFwpuw2JwjZPKNWarv4y7LI5Z1anVkm6q0GaHCFq?=
 =?us-ascii?Q?+V5i5lv3sAe7iGWp6yGswMbhr5Xf4NOcsW6vWchwX4zmdJM1yBjvcUIQkjFt?=
 =?us-ascii?Q?pINz+/OovcXo9hJAImDNvm/Iyv1YbAb49POegl8oFLHyRm7+xLSvuc2k3X67?=
 =?us-ascii?Q?iBzB+E09eg3WUHTvGXbe4gpsAfQdZuzbbeOx8DQMCyM4CPoWN5fGEbTjjE13?=
 =?us-ascii?Q?WWY86Ay1qC63F6OkQ5dg/0b+zRltJx/9NPoNhkLl5DXDnVMgU79MpbyCh6OX?=
 =?us-ascii?Q?0s5S7/T7eiKBP8z5Ug6nDl6GX60fS4sxlqSUQUCF53Mbm+3jlGV2xA4+9Tgs?=
 =?us-ascii?Q?QW2ge+mm8JCgGhk9Em1UWL4NExcwtyDwqhMiAivXl+YVJq/uwtr6v3FmXm4y?=
 =?us-ascii?Q?RnHkihsCq3R2/Dygjn+d8xcFVal2LwkN+4YNsjgrnII2VKQZ43Q+QDYQjAIQ?=
 =?us-ascii?Q?YuFlUULBZszMNvyP/qLj3HM/U4IZ/KyW22+2qqpy8GQ0c15ZfinvePIqq+c+?=
 =?us-ascii?Q?uuFljHP+HOkPknPFdu4b+xNbb0864dIwTOCMWCwodhvHiGAt/pHSFkzxAdyj?=
 =?us-ascii?Q?MaWaWoeYQbfWhBAmgTuE0ALdbCbDXgAm1zt674KFEKNWZvnuOIGGB9IaWAJN?=
 =?us-ascii?Q?b42uzcVHI0os8aazYKUBJ7sQBRO12yP5Kbz19ync4aM/2gdiHbcKS0uvmegz?=
 =?us-ascii?Q?msXkIeDq9w/5Wb3SU3kgyomu4F5bKWC3nullwBML486vAyoy1xTueVTpUoSm?=
 =?us-ascii?Q?pxVwNoJgUcFQw/VUxutuq+R7j43EVQ9x4YozJNuDnFRB1pmufAkh8UsHmsoV?=
 =?us-ascii?Q?BknzO9h+gzR8X1TDO+97OUOxQG0NSYFBV8QTnsSDJnfvr2YNt3yKh+MPNnDI?=
 =?us-ascii?Q?ayR7m2Qm34CmGI7n0HkaCZT46n82cB1HPM+KL7uF8KVCXuxkODtE2uqtcJOR?=
 =?us-ascii?Q?MqtnYKhSK67nvGgdWRG4GtCDJmNNtYtRtKmOVc97MRo5ez2uYCI/ikV4pnOt?=
 =?us-ascii?Q?q5VDdC++W4yaomM5MglM2x/nsGD8uBgMbrkr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 14:29:22.3623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ae07e5-9eda-4e86-9beb-08ddd42c78b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8873
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

Increase cache interval time to 50 ms while fetching system
metrics table for smu_v13_0_12

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index fca50f6a8ef6..2ee61c7e8bc8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -372,7 +372,7 @@ static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu, void *
 	if (bypass_cache || !smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time ||
 	    time_after(jiffies,
 		       smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time +
-		       msecs_to_jiffies(1))) {
+		       msecs_to_jiffies(50))) {
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetSystemMetricsTable, NULL);
 		if (ret) {
 			dev_info(smu->adev->dev,
-- 
2.46.0

