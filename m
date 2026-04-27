Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8C7FF8862
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 07:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A8DC10E5C4;
	Mon, 27 Apr 2026 07:31:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sVgtHd4C";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012060.outbound.protection.outlook.com
 [40.107.200.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BBDD10E5C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 07:31:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqZ706LfTzYAT0g9kCMaSL4DM8PF+r2Mq50rOuFUkPlTcUXlpz+xaqmvwXF6D39be+gbZHWQpfOOl7JCXnRSRb6oUmSDfiou8BmwX68FC7fw9NbTpwVsDcaORj2LEhYsWsNcmQdU+AyzEahzJJigRp4cVcLYzs9rXQNxxYFPgeElSMlMabU+dMuJyaD2FzNEuQdE04rce3swHAykEddNXdFLhrJ5ejdXPx4kAK3StgMGn52l+JUR9eQboqi7Tsv7XWO4HiBwSos+GpxF99sewh9wrlHjNi71xKVGAPWaEP3gHM/WJ7xA7PPShSqdWZ16izWPQgKhUsdU9AtTRIZctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5RljSE5FxG4OUqk6HdlUOKygpAl0s6DugY3Y3VG+hA=;
 b=UXkSlTu/vsb0iLlxOuztpE8aMNzHdju9b8xjlgVsyC3G8+/vxBYWjq2igfwNq4ITzkfHQGJg+2wHaNj0j+fo/SCwOcKtopk0RHxC+ONWGskxtX62t579OxTJJQHRZk1STW0PKwbw2JDDl32CPWAhlJc1TRVZMnsYROmRg6S8BjH8nfI18t2qU7C2l5vanLDWPFGlD9QswYuO4kpuis8ZG0hiBvLsqyBD+EaP/ZWwir4Qq5oPECGmys1x/0JrrXEMPOWtRVwFcVK3mSKLhFZe3OUeUEuTaUswiwMbjM1/14ORXji4GgGUWMHBi5ZcQ0o87i4cSlrSjw6KD9ssJkj3xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5RljSE5FxG4OUqk6HdlUOKygpAl0s6DugY3Y3VG+hA=;
 b=sVgtHd4CwcfYefy9xciH3WAUkIi0HaR/vpBXpBqIe6SQuZXjOQ4JgSN/vImxFAr1Imp0GE0FiHTck8fIFicD5AUaWuAOnkoprDcHXAOw3B+ePLU2gMSuzdjrkMlijz2gTx9DVjg9czarajf5qrTcyQ8kecdXb5T58v9Yi09NZ4w=
Received: from MN0P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::12)
 by MW4PR12MB6999.namprd12.prod.outlook.com (2603:10b6:303:20a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 07:31:01 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:52e:cafe::37) by MN0P220CA0022.outlook.office365.com
 (2603:10b6:208:52e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 07:31:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 07:30:59 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 02:30:58 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Add fine grained flag to SMU v13.0.6
Date: Mon, 27 Apr 2026 13:00:42 +0530
Message-ID: <20260427073042.3547935-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|MW4PR12MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: b325f2a1-b02c-433e-388c-08dea42eede3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: YnB9AIjrWKnG/bU93aTFVCZmsvL4tCTonDcP5rrldbsUyqcy2pWfqbPlL2eYYZxXEqtSM8/CNOkuYFJakqmdF/V9cbJIlc9WmauX5w067pgWV0giqi/jGvpROJ8OtRQ3vJFVm5bjy2aaTlrFTM5aaTisa+iGpQsTdsGdkjMnQROD6Ulz/bErO6nIFIEhURmuMn+kbnaaGvzchTebXl8G+PI7w7l35xE3R77Oy4516WmNmoC8dTaFpNnrWeJTZ5Hm9vG0lt7WLOogpGpkRVtXZk1e39OUIJ4+v+030rsxt+Clx7ywr7JVJqTIe1ziaQhoWggGH0ErD9XmPXIuBg8gJHay87OJRLuq+5IuVOeo4gEjwh4o3jr6zhjL4+1fedr5JSNE/9KUvvREbE54+6iC/tUNMgviLVcHSQ0OCHpd+TOgKPR1hZiqkCrPuBJePBHNUZ9kcSbg0EapR0DipQs1LK9Oy2cHV62FuhsGr3pnQCpADX3g3ts68/sY43jw1Gv2d2TGxsWsjcbh6hxKn23ts1wMyaOA0OwhQ/9XndTB16XGEcj4XvuRAbUHb22Mq22eSEeoZAWZ9D3UmeBow+bF6+A124f/Fv2OCih9kgbIGBoU+rTelsMoHyJnMEF8OJt1sodY8nNXIeVjPHyp7MpmI+3svkVSRVJXntr6OAEJ8EAjM/qgZrterNoOfBlpJu1M2LDt4EFk8tvY0cJAdsRlkV4UP+SgykDwwkLHzMaBaBRlqF7UCUhuCszqEblSS1py82nej98VDUhkmGPJJqqsUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TENSDIRGAiwnhI6pJTEQvBl5b+ThEcUFwRnXpy6NoDKpLm08pXXLTdhLUhzzJUxfp+p36LmMALgGxqvmq+SDw746iPyARevKxFUMNIcal+LPxcRgKU2KLxDqttv8zP0K4wqEDRmK4twSHAnCV4hUEEwY0nW5ihsoe2TWZwFIEeL4wJnXFgyI/lFOUWtj4aE6cvsftOT1IwOH63FhVAWty9NrgqnLU1TMmKT2IA8I2A+qSNtl2gXVVDhDvCQcUN4gFJD8K+4MjYlOeoixNuv949MPBFncnB+XpTMnwEe6Rkm5LoE5yOBn0ZPlDj4tIFSjInzkIE1PWhngvUtrgelI5+zsUGqiaXPBWWWSNoH8JSvMGfuSHDJyzKNKSyLMotj30pcv2EiylcKxPJEulSpz4YjaJsumHDKNKp7+SSPb053kEiq0+zU/C6CyT2SrUUwk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 07:30:59.9292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b325f2a1-b02c-433e-388c-08dea42eede3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6999
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

Gfx clock is fine grained on SMU v13.0.6/12 SOCs. Add the flag to report
clock frequencies correctly.

Fixes: 7380228401c4 ("drm/amd/pm: Use generic dpm table for SMUv13 SOCs")

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 40f0d8a685bf..8d04f6e73fd7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1133,6 +1133,7 @@ static int smu_v13_0_6_set_default_dpm_table(struct smu_context *smu)
 	/* gfxclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.gfx_table;
 	dpm_table->clk_type = SMU_GFXCLK;
+	dpm_table->flags = SMU_DPM_TABLE_FINE_GRAINED;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT)) {
 		/* In the case of gfxclk, only fine-grained dpm is honored.
 		 * Get min/max values from FW.
-- 
2.49.0

