Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC15C021B2
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Feb 2025 17:13:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0488B10E25D;
	Sat, 22 Feb 2025 17:13:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dAtg3tC1";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B124C10E264
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Feb 2025 17:13:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWMeDJCTA9A+gIevJZpzYs3CVbJeSetGWoW4qVEMmsTb8GNeQmPSBE29iM+kWSIPG0gujNTA5cRti5ndNq5xPzRt2Yp2buHCFhUzh6G1YJIlslJc9Cq1/gRQp2lDNcBUziktBam5+zvrl5R5J2F0IIx74A/UTBQKKRpRePW01pYGy1dIvkiv44tV7ItjNsJtp+T9k3wKoA8SNuzjDJRW7VRc6WWoEPOLt9zLhJ692KiueibuZPa90jJ9ww3vDgkIqvZPqbXhDb5Pv6i8bLfcL1BiiovqCDm0bXl+csLjqCw5SVCvBMY3AXBR9ERDJbJn2s20o2wEAj0dd6jxE6gnkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQswwUGPQC676VHgYDDjeClsw0Xx70DThqpXclbz/NY=;
 b=v453JYy2V1g6l0zGOnVNdSHfbo1VJhxB+cJGbxELCvo4jqe4ATjzUYOxP0Gft/5EVLHJ8t2o8knbVbqiew+1FM7LNz6GHzIQpFufERODhMjc77zoJK9nIAYcHB7fSx2ump3iJDP/KDWYs02dwG43C3PCkgzPAIseXP0m4d5TxWBNgTTqkz6Jko18Hoiz+UvIH6elGR/GfLnmCzHyU3dxHeVUOwsHaXlXvFoCnmu/0FZerm6L9hQWYjHWZ8mAu0fqk+MhQsk2cYbYZIRRTup+2PmqmSuCSKZJTJh+3UhzAe+KfXygDQC1C1a4sMr6jluDwijHe+oO/qbGEy6HkWclHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQswwUGPQC676VHgYDDjeClsw0Xx70DThqpXclbz/NY=;
 b=dAtg3tC1ISyoVh48hHVyffrO2DoTO47bWbMferUX03iRc6XwZWdraAgJw0xJHhIMmAEh8TqzGFqBo7s7j58qVfyuhHJmt8XmbHqki3GBnnPdpuFMXaQfYQEpmbCSDcH8XbOzIv1up84AiIF4BuzSJ359PXpOlGzbxpVstatksxo=
Received: from MW4PR04CA0095.namprd04.prod.outlook.com (2603:10b6:303:83::10)
 by PH7PR12MB9102.namprd12.prod.outlook.com (2603:10b6:510:2f8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Sat, 22 Feb
 2025 17:13:28 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::77) by MW4PR04CA0095.outlook.office365.com
 (2603:10b6:303:83::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Sat,
 22 Feb 2025 17:13:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Sat, 22 Feb 2025 17:13:27 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 22 Feb
 2025 11:13:24 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/pm: Get metrics table version for smu_v13_0_12
Date: Sun, 23 Feb 2025 01:13:12 +0800
Message-ID: <20250222171312.791450-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|PH7PR12MB9102:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a26ef01-4ccd-4437-52fc-08dd53643913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JUn8ruk1DFjIa6XW/Am2HKxbMQ+p16koNv2qiKI3UICKeRasJUOZ7+rH12zd?=
 =?us-ascii?Q?pcV5rm4EB41vFm+P7C6ji2ReGU+CsjMcr1H2b5thdKkN+0NLV3VnWU6RDWzH?=
 =?us-ascii?Q?ThhAwNAoga7ySdCrFX5c1s5z7sYEUV73s2SHsihEBnrvRm8pBV44tdcqGUJl?=
 =?us-ascii?Q?v6qDTbbXEv5QfR78zMI+3xnCK3/0NEoDUnsqTTrG2QlnZzB1zwn74BLZLAev?=
 =?us-ascii?Q?vgOLxpegc/in8ugDoRAikgKYj74JYn7Lw1g/A4vCkz4hYUqxfxg1BysXJ3Q1?=
 =?us-ascii?Q?lKJ4yT2+LsTX3lw6V6/V2M+fGgR/ztGrP3sBh37PaVotnj7CntNUp8TAV/s6?=
 =?us-ascii?Q?n33PUyj/Kiu1TK2g80XOuTnyrbzgOtdE/7ViVy0KrY0+O4aBwDNVfISbMH+r?=
 =?us-ascii?Q?90xarO11ojFc6237CbBNk+HamxCR8HuStPwYKzelITBurh4iXbMOBcQkvwuG?=
 =?us-ascii?Q?B+NZul7/EUaew8AZMk4M8ISxcmtsJ1b5jj9u4KkmQiGUWpFJ08N+kPNdus+D?=
 =?us-ascii?Q?ejXEY/uBly7ATv8iazn7c3wieV0gh9FQmBMfMWrVx0BAJaklVafyFhcLYncf?=
 =?us-ascii?Q?ivdpN7eGqnaemAqaRfEhc3L8ZrTOXPN/ie8xW0OUDTJsOVw6a2HMsUIr3nrX?=
 =?us-ascii?Q?y+VBaiTV7nXoRMAyS7l7I6aaSUcPhqaA6SwHW7nNGmWgUbsaFUrQ3QfziUSI?=
 =?us-ascii?Q?I4FjvcJ9G0w5O1wf6IFErB6lsOjJfJDcossGl9sX1bncoszbYkDguInL9q9G?=
 =?us-ascii?Q?H6oITzkXYGVOrVB62lnWrrLmkXs7zQJmynqeW3S6vtlHu3tp2+j4Ci9WH/iw?=
 =?us-ascii?Q?DiR52/TXb8xUdAXaJEZJ/9TinlcrXlxAXfhaaqxCmBfnVENXVBulsLuoc6yI?=
 =?us-ascii?Q?sasqsYkwovYy0b/vdIzhn1KPcmIQrQPXhkzHL4xHhjp4MtUEOLRosJUGTy7C?=
 =?us-ascii?Q?ak6KUiUITGSxxyEYQZwHK0kHruR5NK+nruZhGmY9K4sZRKsuvNv+rMrWb1kM?=
 =?us-ascii?Q?/IEoumGMXEdcp1jwM+V+NiUoDgWL0QND4er6foC7psev2ibrd6MATImC65og?=
 =?us-ascii?Q?zhyUxI0WF8qMzcWrx3YHskOExKAC5Zs5Nh9LAQSB3neb7a8wVp6tzNzg5iP9?=
 =?us-ascii?Q?wgA9XmmCvDrEYMgdZmsxAqJwEt7Fl7buv5LAsuhfUvN0JoHGCP8OXqnxF8ed?=
 =?us-ascii?Q?LQBRH2SkNXJDxZRhO290JF4tgQ3ZhsETvXdUvckQK0F7JVy706Sfojyg4bQX?=
 =?us-ascii?Q?6DpDphLRRU8BfgzNqXszTF2koqadyoOyFHiObDuWZGIQcXTnRk6q+pHT5HUv?=
 =?us-ascii?Q?hQsmzJuwBKWB+aumLyEtF3T3/YXpWr/D/NIXUZ9DCEJcmGLtWxbmTxTUW4Zz?=
 =?us-ascii?Q?qegomW5vJi3SuRJVWvkLBcXV56fwMWJ5CSuo6SRrcLpKCK8vM+PBz16yNPmV?=
 =?us-ascii?Q?tZZGl4/UHRbVQHid7axoKUNVCDD4rs+k3TXrmL9VfZSLo2+RZRZ0V366CRyJ?=
 =?us-ascii?Q?+wgnfT7EWcokWAA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 17:13:27.4318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a26ef01-4ccd-4437-52fc-08dd53643913
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9102
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

Get metrics table version for smu_v13_0_12 and populate pm_metrics

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 5e7e97d90805..5e80b9aabfc9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -208,6 +208,7 @@ int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu)
 	StaticMetricsTable_t *static_metrics = (StaticMetricsTable_t *)smu_table->metrics_table;
 	struct PPTable_t *pptable =
 		(struct PPTable_t *)smu_table->driver_pptable;
+	uint32_t table_version;
 	int ret, i;
 
 	if (!pptable->Init) {
@@ -215,6 +216,13 @@ int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu)
 		if (ret)
 			return ret;
 
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetMetricsVersion,
+					   &table_version);
+		if (ret)
+			return ret;
+		smu_table->tables[SMU_TABLE_SMU_METRICS].version =
+			table_version;
+
 		pptable->MaxSocketPowerLimit =
 			SMUQ10_ROUND(static_metrics->MaxSocketPowerLimit);
 		pptable->MaxGfxclkFrequency =
-- 
2.46.0

