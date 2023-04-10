Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D4EC77B6E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 02:03:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8FD310E068;
	Mon, 10 Apr 2023 02:03:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22DCB10E068
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 02:03:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eb1VYkFSTVw1qsOBjJeQWF0MRtqOSYm8BIIX7Aw7RzMe22CzGG1Hj/0zG3+QLC4FjaYldj8SOENKMDYNGZ/nfVrejKWB/0dolt7CV0qnb1kvjJEEeQjPs+xVe5YXCaOLW+DysN6OU51krGoBZmEI5vDlY2asUkCZxhI5v4Ckf1mVJAp3Fb3D/9vST2jr3V7u58ANWGb6T69Tmkw1RrNXCkqQcSzoYL1Fx1CwuIN6uPgZdkh3Quy7uGC28PNCxIyx7+11+25j3q1IIU4p6kHigiIRLh7xWvsCfvl630KRW48bkbkRx+0IFwJTBckadKC+rVGvvdFISOVbGC1JMtQwwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDwVfutUkr06+yJox3Uvna45Yo8IuzDohsp2UGfwyX4=;
 b=nNMk1Gn+oyStF5pv+zbEycBIGBag5AOy0rpR7q8kk51RMXhTUu5pbZ59qiO6p68+ZaD079dAkmNNBbjhiZXltQKQ7mr2hr2knFzNQys5KpsQZvkRJrLR2Q32pysdCJ0/BMv+MVbUDNWO3QovEwbE6ooJ1nIfkq1VTTjoL+xL5P0Som+GG14u9JFZSx0oBABbuyr9nHdmPQFZ72T5bVZGdZ2iXj1i8ZlgUb7gpp5JVhqBZcox4f6sPXFAqBQtHpibjxiGGIudOQ2+TnYcs3qGTj8O8rfi53xcZdUobT9xTWmYxyhmmTRnO1OnTtKICXrLJ2r7qYFnnmP1JZXMl3LFLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDwVfutUkr06+yJox3Uvna45Yo8IuzDohsp2UGfwyX4=;
 b=FSV7pW+VcY0jPmfLI6lgLcET6MgGdpjTeo0YVjpu5aVzYQlYiNrNn1BY3y4pKELCr2D5hvUN7b3bogn9XZNV6zJgWp+R1Qr80d5gr7ySFgJ66z9CZlqnj5VSQBpKNNcLHrM5XwlVeV2Euyo1GO55GS85bOUrKXXlyW9lH9I+9L4=
Received: from DM6PR02CA0045.namprd02.prod.outlook.com (2603:10b6:5:177::22)
 by SA0PR12MB7076.namprd12.prod.outlook.com (2603:10b6:806:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Mon, 10 Apr
 2023 02:03:35 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::b0) by DM6PR02CA0045.outlook.office365.com
 (2603:10b6:5:177::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35 via Frontend
 Transport; Mon, 10 Apr 2023 02:03:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.20 via Frontend Transport; Mon, 10 Apr 2023 02:03:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 9 Apr
 2023 21:03:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 9 Apr
 2023 21:03:33 -0500
Received: from hongkzha-test-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via
 Frontend Transport; Sun, 9 Apr 2023 21:03:32 -0500
From: Horatio Zhang <Hongkun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: correct SMU13.0.7 max shader clock reporting
Date: Mon, 10 Apr 2023 10:03:30 +0800
Message-ID: <20230410020330.66938-2-Hongkun.Zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410020330.66938-1-Hongkun.Zhang@amd.com>
References: <20230410020330.66938-1-Hongkun.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT021:EE_|SA0PR12MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: e1eba024-8d7d-4d2f-b2f1-08db3967cab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: grC11pEm0NS82dSNPwioSHdm1BrhFBjmwd6JBLUonkc22j1UB2TG2U/AtHzgJvyI3yNuiemUrDAw/IBnZYLk1AybFDjSjOnu3F4+AIw4R04Yvg0iHKF2PEYywOc6p9MsehCYPIOoLCZh+NIarjzAvNOUoReJPXOJFDyVrLOuaLq5pVP0nk9kdfe10G9+J8MK2EE8tbXUZIE2nLuAWcCpK3RrLZC0Jj2k1ggCn08NEHYyM+FME6uj49RnyNf52x3wjN6eun0dau2EcFy43mLUp9UE1PXH6HUKieWb7FA3K7WeTmkQNAC1gk8XXVCwvCktwk+B7VrZdovEzgFQikIkrEsyM+1AijRGM95FNQEssKjmDY4SL+0CYzx68KEBfctK2vp9H7wYeE84nw8G145S00pGUYiwvIS1YVKFZA/2hU48eaJoFLivjVpFzX8k7VbsziVaVUN12Un2TbJCrQP32gdNKgy1uk8MfVA18wZ53dOxnDUPR8I35EpPIh59ym682uk3QfuMjWxYj5m4cgYgtPD/5IvpUzoR6eCNJedzjiOjguSjqrFnv0OczaHu9GpT92L8J6phmWKck2i0MFfdwB9c8ONa8PvCB3fXlfE88/KfgW6rl8gRbjBmm/XY1ZgMH546diID/agZbMYLhH80YPyzYwpzOHQTQ+zJKSAmZMpHNXRXCho1bqSRT5y59Oxba/7sCHEK+ZIY/H2JNE6nHC9tNaooTmPl3AWZQ/WRdBk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(82740400003)(40460700003)(356005)(26005)(81166007)(70586007)(7696005)(70206006)(8676002)(41300700001)(4326008)(6916009)(86362001)(36756003)(478600001)(54906003)(316002)(47076005)(83380400001)(40480700001)(186003)(1076003)(5660300002)(2906002)(336012)(426003)(36860700001)(8936002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 02:03:34.7596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1eba024-8d7d-4d2f-b2f1-08db3967cab5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7076
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

Correct the max shader clock reporting on SMU
13.0.7.

Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 61 ++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 1b1c6c21c002..e85ea1eda50e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -575,6 +575,14 @@ static int smu_v13_0_7_set_default_dpm_table(struct smu_context *smu)
 						     dpm_table);
 		if (ret)
 			return ret;
+
+		if (skutable->DriverReportedClocks.GameClockAc &&
+			(dpm_table->dpm_levels[dpm_table->count - 1].value >
+			skutable->DriverReportedClocks.GameClockAc)) {
+			dpm_table->dpm_levels[dpm_table->count - 1].value =
+				skutable->DriverReportedClocks.GameClockAc;
+			dpm_table->max = skutable->DriverReportedClocks.GameClockAc;
+		}
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.gfxclk / 100;
@@ -828,6 +836,57 @@ static int smu_v13_0_7_get_smu_metrics_data(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v13_0_7_get_dpm_ultimate_freq(struct smu_context *smu,
+					     enum smu_clk_type clk_type,
+					     uint32_t *min,
+					     uint32_t *max)
+{
+	struct smu_13_0_dpm_context *dpm_context =
+		smu->smu_dpm.dpm_context;
+	struct smu_13_0_dpm_table *dpm_table;
+
+	switch (clk_type) {
+	case SMU_MCLK:
+	case SMU_UCLK:
+		/* uclk dpm table */
+		dpm_table = &dpm_context->dpm_tables.uclk_table;
+		break;
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+		/* gfxclk dpm table */
+		dpm_table = &dpm_context->dpm_tables.gfx_table;
+		break;
+	case SMU_SOCCLK:
+		/* socclk dpm table */
+		dpm_table = &dpm_context->dpm_tables.soc_table;
+		break;
+	case SMU_FCLK:
+		/* fclk dpm table */
+		dpm_table = &dpm_context->dpm_tables.fclk_table;
+		break;
+	case SMU_VCLK:
+	case SMU_VCLK1:
+		/* vclk dpm table */
+		dpm_table = &dpm_context->dpm_tables.vclk_table;
+		break;
+	case SMU_DCLK:
+	case SMU_DCLK1:
+		/* dclk dpm table */
+		dpm_table = &dpm_context->dpm_tables.dclk_table;
+		break;
+	default:
+		dev_err(smu->adev->dev, "Unsupported clock type!\n");
+		return -EINVAL;
+	}
+
+	if (min)
+		*min = dpm_table->min;
+	if (max)
+		*max = dpm_table->max;
+
+	return 0;
+}
+
 static int smu_v13_0_7_read_sensor(struct smu_context *smu,
 				   enum amd_pp_sensors sensor,
 				   void *data,
@@ -1686,7 +1745,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.dpm_set_jpeg_enable = smu_v13_0_set_jpeg_enable,
 	.init_pptable_microcode = smu_v13_0_init_pptable_microcode,
 	.populate_umd_state_clk = smu_v13_0_7_populate_umd_state_clk,
-	.get_dpm_ultimate_freq = smu_v13_0_get_dpm_ultimate_freq,
+	.get_dpm_ultimate_freq = smu_v13_0_7_get_dpm_ultimate_freq,
 	.get_vbios_bootup_values = smu_v13_0_get_vbios_bootup_values,
 	.read_sensor = smu_v13_0_7_read_sensor,
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
-- 
2.34.1

