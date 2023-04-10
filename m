Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C713C77B6E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 02:03:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 970F910E04C;
	Mon, 10 Apr 2023 02:03:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDDEA10E04C
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 02:03:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4m0CCCk8VMCWt2nJzQ/E6mnZD73wF8pVyxY8Jt18MAcuOa3uON+oF8gdqkK+dAZR+AftnDw4Ekum0HJApD7bE5uChPiHTLld+kl6y439Vnfrt0RcVk3MXBRNmfkLAfVJB9NotEwEevHMX6MaUZidLbyXeVfqZYxNKBbOdNTVDHQH7jtj3rEs1FucttlB2ZYlut7OZ0XiY3Pv0QppDjlR7KnKH/ug2TAJR6AYsAkb6JIN2kBIqR4pwbuiJPSNmm3a1SJ2/cP7liyL4P0ANxIguS/eRk+u7gLyWtiICbkvt7dYBBqDMz40ZsMWtzdtNl7zcw0dVGRnPR6pJ/Lr8TZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEW7OrgSba+bmalJMzKU9Iz2dQ4XBAahKcQFhUqCywk=;
 b=mY8QIc/UJStjAJDmKaBp3aPorGcm4c5kFXGH8yLlvYboqETfAchiGtb6rfe3UmAcLjlMFOjE3prS+byhDkDZJOXKr9jVvDtQMSzoMXogVsOiyKd56wokof/sseUfS3cQ+shzgqArS48HSmQ1UXqwvo4XBrkZGxPZTfFqEGcA2EmjFsp4a+ymL8xVXFwRVmTH4/en+qS1epnbjbPw+VfgHGNt4hs6uUDZt/I23abX0eJAIts3cVzPDiURVYnebKzTG43Z3TpI265nRm74n+EtQpMzGODMHojNlvm5nMCrNoTXvoR+ctSPBZqzgqmfKUB7DmxVi3S+LalWRBfwQMJDyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEW7OrgSba+bmalJMzKU9Iz2dQ4XBAahKcQFhUqCywk=;
 b=t4DSVCKylQZWvOnWIiaTCB8sipGYV8d49RbPZJb4T4KFl1A75/JHn04oXgYX3CHBCbbdCUM/kW0WnZnjk7KjLyKyr+Szx7z+nnn7nx7OdT/cZ+dgtOz1BzhJ9+aMtH6KvSI0eyfCnmfkeglfeYjKdAdom3roZpVj0F9dHmKXkvU=
Received: from BN0PR04CA0184.namprd04.prod.outlook.com (2603:10b6:408:e9::9)
 by PH7PR12MB6761.namprd12.prod.outlook.com (2603:10b6:510:1ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Mon, 10 Apr
 2023 02:03:33 +0000
Received: from BL02EPF00010206.namprd05.prod.outlook.com
 (2603:10b6:408:e9:cafe::9d) by BN0PR04CA0184.outlook.office365.com
 (2603:10b6:408:e9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.39 via Frontend
 Transport; Mon, 10 Apr 2023 02:03:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00010206.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.30 via Frontend Transport; Mon, 10 Apr 2023 02:03:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 9 Apr
 2023 21:03:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 9 Apr
 2023 21:03:32 -0500
Received: from hongkzha-test-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via
 Frontend Transport; Sun, 9 Apr 2023 21:03:31 -0500
From: Horatio Zhang <Hongkun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: correct SMU13.0.7 pstate profiling clock
 settings
Date: Mon, 10 Apr 2023 10:03:29 +0800
Message-ID: <20230410020330.66938-1-Hongkun.Zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010206:EE_|PH7PR12MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 708877cf-2f80-4f37-3e52-08db3967c990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lohzyyhdiml0/39wLMoDnSX5DCOCRKS+WMS5rxES8Wkq5oSetI/xbfE8Pp8ZhzLwGZpI9GZPtvzJalCqsx+dkAJMcKilXE2hsUwCbSstb8Klzm/JpuosABFNFyeD6NITrNO+XS4GkL/kVAYHfHNNZl1a0ebDWzPIa2SrHdyztjx9qRkgZ6NgydHzciTCUY3kjn9Rk34tXjpKcmMnHKUmf46SrU/+qoLL0N3NBUY3T08XCAzDxgYhhzhvUBNribR7+ZBy5FsRvJnLGZYBX2vgfuiKFeYpEjl5yjXUQ0SXjrlI1kmkqFVahNxKWSjA7lmYrY25ONp1mQ+oHbkVnljR2XNBVtUk1WqiJLQJjCX6mbmhjASoi8sIfMAXBdSQa7l/STVO3y+h5ouHU/E1IrJXj8i1JMhX7si2b5uk2/be6NWMOWASq7vdeTT+hV4Rl3H6uG34ge8V7L2lznJqL3U7Vbm0Ybf5Sf+unJEFnNWUuNUCTF4Y3xeN3EliHmUOWcxLW+mhykqZOpKYs/CWL14zJXowklS/UgmeCNRAkjYb37KHlWOBZzXPYREkSU0F1BtW5ArfSoCQXFaSjlOWhq4zY3Zbsj8DMb5QU9+JvY5jjZrvfovpnFiLvoxFp/PFDQl4xzIoZmrasrQ+GwyEBPr0IS4r95KIvcQP5VBSfDWEaKQtHmM0T9y/50a7TZIJMCX3J//B+3llmZV08bFnqJVDR/9qNGe1Fz2CtGYXMizvtGc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(46966006)(36840700001)(40470700004)(86362001)(36756003)(316002)(41300700001)(70586007)(8676002)(4326008)(6916009)(7696005)(70206006)(54906003)(478600001)(40480700001)(82310400005)(5660300002)(2906002)(8936002)(36860700001)(82740400003)(356005)(81166007)(186003)(1076003)(26005)(336012)(2616005)(426003)(47076005)(83380400001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 02:03:32.8677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 708877cf-2f80-4f37-3e52-08db3967c990
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6761
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
Cc: feifei.xu@amd.com, Horatio Zhang <Hongkun.Zhang@amd.com>, evan.quan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct the pstate standard/peak profiling mode clock
settings for SMU13.0.7.

Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index ccdc2ecab1dd..1b1c6c21c002 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1329,9 +1329,17 @@ static int smu_v13_0_7_populate_umd_state_clk(struct smu_context *smu)
 				&dpm_context->dpm_tables.fclk_table;
 	struct smu_umd_pstate_table *pstate_table =
 				&smu->pstate_table;
+	struct smu_table_context *table_context = &smu->smu_table;
+	PPTable_t *pptable = table_context->driver_pptable;
+	DriverReportedClocks_t driver_clocks =
+		pptable->SkuTable.DriverReportedClocks;
 
 	pstate_table->gfxclk_pstate.min = gfx_table->min;
-	pstate_table->gfxclk_pstate.peak = gfx_table->max;
+	if (driver_clocks.GameClockAc &&
+		(driver_clocks.GameClockAc < gfx_table->max))
+		pstate_table->gfxclk_pstate.peak = driver_clocks.GameClockAc;
+	else
+		pstate_table->gfxclk_pstate.peak = gfx_table->max;
 
 	pstate_table->uclk_pstate.min = mem_table->min;
 	pstate_table->uclk_pstate.peak = mem_table->max;
@@ -1348,12 +1356,12 @@ static int smu_v13_0_7_populate_umd_state_clk(struct smu_context *smu)
 	pstate_table->fclk_pstate.min = fclk_table->min;
 	pstate_table->fclk_pstate.peak = fclk_table->max;
 
-	/*
-	 * For now, just use the mininum clock frequency.
-	 * TODO: update them when the real pstate settings available
-	 */
-	pstate_table->gfxclk_pstate.standard = gfx_table->min;
-	pstate_table->uclk_pstate.standard = mem_table->min;
+	if (driver_clocks.BaseClockAc &&
+		driver_clocks.BaseClockAc < gfx_table->max)
+		pstate_table->gfxclk_pstate.standard = driver_clocks.BaseClockAc;
+	else
+		pstate_table->gfxclk_pstate.standard = gfx_table->max;
+	pstate_table->uclk_pstate.standard = mem_table->max;
 	pstate_table->socclk_pstate.standard = soc_table->min;
 	pstate_table->vclk_pstate.standard = vclk_table->min;
 	pstate_table->dclk_pstate.standard = dclk_table->min;
-- 
2.34.1

