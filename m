Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD4DC5CFEB
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 15:51:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6EFF10ECB1;
	Tue, 11 Aug 2026 15:51:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Grvhrc8U";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012048.outbound.protection.outlook.com [52.101.48.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0167410ECAE
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 15:51:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRLtZ4q0OIrrkmYaLRe3ccJnP0IUJ5s9LOinFYZLXuIDlS++89XgvosRZniLMnMsG2wNqaFEC/o9qFs92LCfPixiQgoiqqilqVMVnjzxxKpWAOYOTTwPypMvuXP1Tx/EhaBW8gdBSL+PuRxb4wWJjXoFqp1z2j/RJNxGynVqO5NOQ/TCsGGfTdE6p7LlkfVIviNozDaMTO8YWXiY9kESeUnRh9LplAwSqSmBsDHqZx46Gnp1xM83FdFrpD4xUg2bGLOwuh7sJxrO/vp6C5ssuHZ2O9Mz3UTzMggsTaKAs7WxDjXqKV7clcZX5bgPlDjRncdhIyj6AJEyNlP/GAfN+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkzm0rCLU2E8FlOKDAdYsbBvnezdl/+kkcJCbWXy2+M=;
 b=N/D/2wJv0Qxepx/Y9QpgBWXP69YWdqZsvjh5UJYOkKK1xuowzrI33Z+KXk3cATF5yMmDosNbhtbKPb5sRynrGlqRiYYBMBG+rCROIJNBw4D2Jub6KC9B3XYcrAua819a9vK3CEiY7QwOvsVZtvl6y8WOh3Bbht4Ezc+lkECSMyw/48JHC+E5T4o+oXqKXjAZJvCfn1ZNLK6DI2zke2c2DGbAYREstEGEmkjGdHl2e/KgRHWiPgqkwRLERwyck+grF6wEEWCo9xKKv76PHOtXuOd3r1FtuQW1H+RTbG5/gQpOZRqXqsT18MbFPxyjI6shde63iaru9iPiiQi4BtYJLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkzm0rCLU2E8FlOKDAdYsbBvnezdl/+kkcJCbWXy2+M=;
 b=Grvhrc8U/7SlRonvds9pMjqVsiZCnFn/2FU/2xpB0gxwvWtTAUjD2kSS3S9B/m5q/h1fCMOaZA4U5kehtg2CHRaErfCyFtTBkevmSitieLZGL6wWOakRaEbNd0dTmrjx/4RIAy8vXxcQHWmPq9tqigh0UqmolZmto7WCEAbA3OM=
Received: from CH0PR03CA0377.namprd03.prod.outlook.com (2603:10b6:610:119::31)
 by PH7PR12MB5782.namprd12.prod.outlook.com (2603:10b6:510:1d1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 15:51:22 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::51) by CH0PR03CA0377.outlook.office365.com
 (2603:10b6:610:119::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 15:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 15:51:22 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:51:21 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via
 Frontend Transport; Tue, 11 Aug 2026 10:51:13 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, James Lin
 <pinglei.lin@amd.com>
Subject: [PATCH 21/24] drm/amd/display: [FW Promotion] Release 0.1.71.0
Date: Tue, 11 Aug 2026 05:28:55 +0800
Message-ID: <20260810213010.1703162-22-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810213010.1703162-1-PingLei.Lin@amd.com>
References: <20260810213010.1703162-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|PH7PR12MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: 836f74d0-3bf7-4ad3-dae1-08def7c06472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hDarJvhjMTBOC8xRNLBko//GMh/qVNmesn8BHpsYxLovwGWpvLARgeN3YqxhtoAX7I2VYMi6iXhRKL/HHwv72Jy1KCbRHCHU2weNrYLtrMbSLo0nbSKYXRoMqstCKIkyQ04gQcXD36bCoPVgWIi75ciBWj14I7WNX77pCjQKGyW6URu2U9NOOcw1HfuUwz72QBxwuJZ5wM5q2E2SsLAHkKMLfxiN6TbbFMNd8wJH6LDSPUQ1qDCz9GgAESlasXjETvonQEUhKu+B50pRW4tdTTucizq0o/VPKbe9yOHERKHjnkDN6CDaDADW53I1k9ucT+Ns+2kQhNVJZs20eOqh/klfMi3oB4paYnqspHH0NP1TemSuKo6kDNOcrEyixMNb/DGfhCbV++6HZa9wMTVWDyVKm9jxUBvkxK5ugwuIu+qUIhmG3Mq66CCMpEIFMqQYu5kJU4KgWuobBGMQHEPuiSerZSt5qABeOcghyjY77AupDMaE33BxQjia+1AwXB/caMJ5D3QIDHIdzb7Lag8YVv6yQt/k956SkuvMP9NC4HqQ9+sKiyHDhxZLomvKiX5VVFl3Z55G/eVoCJdHoKdDbFulGpV3RsCR0iqKToMkkOeSHRoQ+VVljlQHKRw0Q+7eXf2GjwNa/kPoPP1/Mv0l1w1hv24S0JaOeil0PPtmp5pKxXBQLRmTExK72mXnSTz3UlcStxn5pj73cA3CRDDlrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C4EMMhbV/Qws8/c9Yfeey+mumz/fmmAPFj8tAGz6l1EWJOD/yjX3d5wap2fvJpC3+DkRpM8LTDQN0rhgorticzvHYKgW6r+pyba1BMI55UxFOqB3pC14GasHYM7B2g6ckr2U6cPrJJAt6BNvvrOlswzY6OJGveFlayrdhYze/ppyiv9JoGeESlC0BOkNhN6be5/0w8VDOuTW+0Ve7YwQh02ByYLXhOXRPRAoG8OFQXVHFeId85p2WVuH56t+5gKZdbHNxdDvMApUXvVKSnaFoSlU6k4Hv1fjfojAevIb/6QVt1Q0TeXdS5Nip+3aOqllLX632ZTRLM2Pcp+PA4orjI8z3kpXDZoe4FCKL/QygUcD3jf7XQzMD+lPXWU+lqAJjVxmwrte9z5WzHN5WOYoSSz/K1/a3jERVXE66tf0pXv+wZ4BS0K5e0zbUP0lvJaE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:51:22.3635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 836f74d0-3bf7-4ad3-dae1-08def7c06472
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5782
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

From: Taimur Hassan <Syed.Hassan@amd.com>

[why & how]
update DMUB_CMD__DC_BLS_DCHVM_INIT definitions

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 1d10fe8f1998..105a0f8762e8 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2955,25 +2955,6 @@ struct dmub_rb_cmd_idle_opt_dcn_notify_idle {
 	struct dmub_dcn_notify_idle_cntl_data cntl_data;
 };
 
-/**
- * Data passed from driver to FW in a DMUB_CMD__DC_BLS_DCHVM_INIT command.
- */
-struct dmub_cmd_dc_bls_dchvm_init_data {
-	/**
-	 * The value to program to rIOMMU PCTRL register. x86 cannot access this SMN
-	 * register, so the write is performed by DMCUB on the driver's behalf.
-	 */
-	uint32_t riommu_pctrl_val; /* r */
-};
-
-/**
- * Definition of a DMUB_CMD__DC_BLS_DCHVM_INIT command.
- */
-struct dmub_rb_cmd_dc_bls_dchvm_init {
-	struct dmub_cmd_header header;
-	struct dmub_cmd_dc_bls_dchvm_init_data data;
-};
-
 /**
  * enum dmub_idle_opt_dc_power_state - DC power states.
  */
@@ -7225,6 +7206,25 @@ struct dmub_rb_cmd_ips_residency_cntl {
 	struct dmub_cmd_ips_residency_cntl_data cntl_data;
 };
 
+/**
+ * Data passed from driver to FW in a DMUB_CMD__DC_BLS_DCHVM_INIT command.
+ */
+struct dmub_cmd_dc_bls_dchvm_init_data {
+	/**
+	 * The value to program to rIOMMU PCTRL register. x86 cannot access this SMN
+	 * register, so the write is performed by DMCUB on the driver's behalf.
+	 */
+	uint32_t riommu_pctrl_val;
+};
+
+/**
+ * Definition of a DMUB_CMD__DC_BLS_DCHVM_INIT command.
+ */
+struct dmub_rb_cmd_dc_bls_dchvm_init {
+	struct dmub_cmd_header header;
+	struct dmub_cmd_dc_bls_dchvm_init_data data;
+};
+
 /**
  * Data passed from FW to driver in a DMUB_CMD__IPS_QUERY_RESIDENCY_INFO command.
  */
-- 
2.43.0

