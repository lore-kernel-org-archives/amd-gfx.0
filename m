Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38658C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 06:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8747A10EAFC;
	Mon, 24 Jan 2022 06:44:08 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2075.outbound.protection.outlook.com [40.107.101.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A63F10EAFC
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 06:44:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mv/BhA1fGUO4qAinjbouFoeaPMApURHGQcKlWkcbppKoUdvjhYRQll4LFpbU0SF2QDfS9NVMtz30J5zG/krk6znwGe2Ozaa6okHNUNrC6xFCWatB5UEIHAZDAPETACo149R0mqDfgt6zPcG3wKSs8LKdjjzHdpy+Gf/CktaCO4oqU8Nssyflq68yeNu0Yf+REnVAQl76115tYRCQ2GavZG8p9i0YW4Kmq1gOH1gnPin2uKS6WcyEWgH2TvS0YFax5fG8OtCnAcyeAqWOarz8y+Ir+797zI8wg7rOIS+fmBCc3rmUdKp0bbrSkFWqv01Ml8e/GgHNGNzZIIKRtHTc7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jn6FU0k9El9mCb1IJP7elGR4Nv7DXjPgEyHsmglzng8=;
 b=OkZqMVvNLWVGTRjxVn2cMb34TGC39oERXva/FxiNbqIao8Du1d9N8cb9N/I4RAiwWhoDU4IaKzwRxU2Hsou8rLDWqfKR6JhtOvxb2hCNUe8iqTZXs4fPZP3R+YGRldWHTm4BxTuTQJ/we4E+J/v04WTj2NlWbFscG4+YEb4YmAv2+ED2W2dsOqtngi0LNEJhoZpP3fhS3XIE+44xXvOM3O2Zxtm9bJMkvMmxTbq8Bci5rK1CiV09DAr0OixjNbjBYrMlKT/nwt5OkLqdMfHQifI2i9epNTgzq7s2e2SBxjO1vvSMSTXAH8+GTPHP8+z5qm6+ynphNpXqSAjAWAptUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jn6FU0k9El9mCb1IJP7elGR4Nv7DXjPgEyHsmglzng8=;
 b=FV3luvT7qF+NjcFHnwyqm8MCedHBwCVwbj7BM7d4zR6y1d4WGBghVI0A6FLe4Cxp3bJnjfrY3HFbHoMc6ksEIsm6NT0+u4NNBamN/8TI+FLvKYX80ASzFimwERH0wG1/DAZzStuPgfbPLiZCZ+E4olIvKbPA3YANvXazxTvLhbk=
Received: from BN9PR03CA0975.namprd03.prod.outlook.com (2603:10b6:408:109::20)
 by CY4PR12MB1703.namprd12.prod.outlook.com (2603:10b6:903:122::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Mon, 24 Jan
 2022 06:44:05 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::41) by BN9PR03CA0975.outlook.office365.com
 (2603:10b6:408:109::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12 via Frontend
 Transport; Mon, 24 Jan 2022 06:44:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Mon, 24 Jan 2022 06:44:05 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 24 Jan
 2022 00:44:00 -0600
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: use existing fini_smc_tables function for
 cyan skillfish
Date: Mon, 24 Jan 2022 14:43:42 +0800
Message-ID: <20220124064342.273055-2-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124064342.273055-1-Lang.Yu@amd.com>
References: <20220124064342.273055-1-Lang.Yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c7463d7-2d93-46a7-dd99-08d9df04ea2e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1703:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB17034DBE51AED6865028D943FB5E9@CY4PR12MB1703.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E1uVunJ25d9sh4Uf0SItP/KzTl8RZrI4AcuRks/vKfMUkWBygapxAtmcPs6vAzYCoqfa3AvTUDwiHp1s2Ycq4js3/fxBBzlCITeGFQJiTHSESAPh2970DENi+NplBuaXlvdlXeVEqbbb4bmHTptNnzc4zdHP0g1xhLFivAM1eR2h3XA1MudBu4Qd5pc06zfsC2s4XNoQCMt+LC67+XZj/bA9mNlitTTakse4G764PRYX8RIsT8BwEoq2ddNt18ecIaorfb4KoxDIip7nWhN7p4P1E3pRe+JwVOvBU2vDG+SZbyhfJuNTPPGZZ0zjUnarYN7czOJ0o72sL+4HNpWNb42e3BjJjVVk+Lp/kor1t/FJVUo4wvAbc9LiLgBqURuglwG1XXP28KAJjoBlKf0R3403whBHcA70AQoWqFB2nY1CBSPOw0ejkAwtMBe3yQW7pVqeSARWOqV6FvxCnzF/XFF+DcmyM2M0D1eygtpxyq64v85IhqIyTy2obDqGLHUNrUniSAYhv/YTXu0IR6Y/kpEgflwK+4C9/ebCOz4sURm99n+MJA3nIlo+Gy3YJxp966sGaMniqpzk/pJRwVjYjLcAZxCkhchsCDpHt90UJfsxxYC2Xj+J2sJAfgU91OdkJjfY1cOX3kvPgXOWZT9CVuDSJo0x1HG2+cf1Kcvv9EIh+mFAb40ROAplPtxMpL6E14/7AIh2K0y2mcsSyGvlGhtChHHIBmz9t64xtfKmKZH9f39q26lv/N5G40mwwGr4G3ijooNRfKOSYpQiRXHep9bG+/vVfBP8RoQMsaHdXbs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700004)(1076003)(186003)(16526019)(426003)(4326008)(5660300002)(8936002)(6916009)(82310400004)(47076005)(86362001)(356005)(54906003)(508600001)(2906002)(2616005)(36756003)(81166007)(316002)(83380400001)(70206006)(70586007)(6666004)(336012)(40460700003)(26005)(8676002)(7696005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 06:44:05.0970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7463d7-2d93-46a7-dd99-08d9df04ea2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1703
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove redundant code and use general smu_v11_0_fini_smc_tables function.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c    | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 665905a568eb..a2b72d19a400 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -125,22 +125,6 @@ static int cyan_skillfish_init_smc_tables(struct smu_context *smu)
 	return smu_v11_0_init_smc_tables(smu);
 }
 
-static int cyan_skillfish_finit_smc_tables(struct smu_context *smu)
-{
-	struct smu_table_context *smu_table = &smu->smu_table;
-
-	kfree(smu_table->metrics_table);
-	smu_table->metrics_table = NULL;
-
-	kfree(smu_table->gpu_metrics_table);
-	smu_table->gpu_metrics_table = NULL;
-	smu_table->gpu_metrics_table_size = 0;
-
-	smu_table->metrics_time = 0;
-
-	return 0;
-}
-
 static int
 cyan_skillfish_get_smu_metrics_data(struct smu_context *smu,
 					MetricsMember_t member,
@@ -567,7 +551,7 @@ static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
 	.init_power = smu_v11_0_init_power,
 	.fini_power = smu_v11_0_fini_power,
 	.init_smc_tables = cyan_skillfish_init_smc_tables,
-	.fini_smc_tables = cyan_skillfish_finit_smc_tables,
+	.fini_smc_tables = smu_v11_0_fini_smc_tables,
 	.read_sensor = cyan_skillfish_read_sensor,
 	.print_clk_levels = cyan_skillfish_print_clk_levels,
 	.is_dpm_running = cyan_skillfish_is_dpm_running,
-- 
2.25.1

