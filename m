Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EF8FA0C42
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 07:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 047DE10E698;
	Wed, 15 Apr 2026 07:43:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EGDyrBID";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03C0B10E698
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 07:43:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oze+hpu6g44dG+RQ/dN4NlO04MHTyxKUJn+6TOR5U1n/+b8Pw2npVCXZfnXGFR4FdyGyHKV/HllYjk+HPqlY3Ddsb41oXsZ+GiYzPTULbL2RaTYOvd0ZjDyAg5d+4mHcMreAD91tZsx1lGEAVmrQY47MT1G+b4buQ/IX3WOp0WQiFhsFT+QIfB7E9vNBeyigoXzFqBAggk3JzlLsp6BHtpXGfzpALctMFZwGBt4uDgBtnC+yECNdUqji65ZQARouHcW9816G+FVfujSpUv82W8BS6J8ceTQAFRbc8IliGFCOsD2tiOVcUKsUTnvLDBdycSOAv4k/p7fXx4IhxaI0+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEH5L4y/E/hoK7SAoGuYD2WbeSjk0MQ/1KxKKQbg1kE=;
 b=cpaDiAQrLqeNBQAXHilmUGd8Ud4GGeowDB4OsTQuIMCMhvWFEtHPFOGH99mjqs6nCkHwaAUJy6YTaxpxpnDg3qR15G0gPKiEJYnE6nhF83O4LVJniwdqvmt6/Y5SYWIKUBZpOXIyp9YtVzpyJqkhmgLl1k0Vgqr0fFafWSkMDtwsyx9ZoN8TU/kO7tNJ5LNAH8Uu/FzLDiGCqDrHGE9z/sdbMS59ld4CWNPJXgYS3mPz0Ymu52DX1nJcWTrMd2NaNFtYUVoKetfjeYmhDKxxcFNMX6L3y7aTySRPDY+6+Z8E0M1iAA5h7mlby+nWqpM0y7zc0w5qAJBrszcUpkYm+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEH5L4y/E/hoK7SAoGuYD2WbeSjk0MQ/1KxKKQbg1kE=;
 b=EGDyrBIDoDdC3qmU5OFWWuJvAc+yeIfKLb2XffFOnjcT5CVN80oPRSnOmFxPkbJIJDnG2sAgcU+ey1it6hpO2w7TZZk/MtFcreIBmwZDn0hb11ptL68p6e5Ck3gFPEBRbgLhcQyhq3V7QVEyA07cftAmetnJ6egOZ2+zZNAKdgE=
Received: from MN2PR04CA0026.namprd04.prod.outlook.com (2603:10b6:208:d4::39)
 by LV8PR12MB9263.namprd12.prod.outlook.com (2603:10b6:408:1e6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 07:43:21 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:d4:cafe::ff) by MN2PR04CA0026.outlook.office365.com
 (2603:10b6:208:d4::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 07:43:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 07:43:21 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 02:43:20 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 15 Apr 2026 02:43:17 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Ilya Bakoulin
 <Ilya.Bakoulin@amd.com>, Sridevi Arvindekar <sridevi.arvindekar@amd.com>,
 Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 07/19] drm/amd/display: Fix double free
Date: Wed, 15 Apr 2026 15:39:46 +0800
Message-ID: <20260415074223.34848-8-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415074223.34848-1-chen-yu.chen@amd.com>
References: <20260415074223.34848-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|LV8PR12MB9263:EE_
X-MS-Office365-Filtering-Correlation-Id: fd402b07-2e89-47e8-256e-08de9ac2aab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: +KA+TLvbEs5uEImm4wryq488P+wMWsZkkryJqyXLBb2DkrIE1RMfBcX25wYrC/cVWMkWsFqqRcY9WuEOfJlstp8slRjJWBt0z9WFyUe6aEE1j3aB69QMbO8v2na1qlnSMZGa2ZRnmcvxdeTaktv8IkXv39QjE90T4v2QvLaZI9YjfecldS25UZO9snQYYXcE0djZrKEGR1/y/CVtCYrbeoTSzlSH/QHtL1YjrbTcqza2fU+mh1Q9nYYwlJsUugkdkA4ROFZG9ivh3glOzxpzgj3pTTUF/2p9dzofSdCPxIJuZ4m1tbc0EdWXt/MOtCK5joxk6LeECaLrAbd+hov26qQkFPQSKYpdAchBIuTQju/oqwGAFRFh/M8+izg4f1Q4lNU+oYQ+94F1Z5uqhWRs0ZPfpxTCVuQN+df8C0UFNNRolaTYIQVvYF9vOKsOuORDry8k+FYoakkFVJZldXxQhfgK6x7XHifd2t+h7U0wijH6JxrOwSysLrLU6oyu+KU7TdRPJ/J/X4lr+lfpXlOWr8Dn+zXbYnz/YbxgqY4BnNmJqHxHeYBUi4qUjGfGiwhBZu6uA8G3pLgdKzOpViUZUbYnToGxPABI125UfhLxGIoIRYTYdRg8uqJXKlZw0ttDgxg7OEmyT95BfQFwqdPApHfE3lhOif4zUkTPBCFPdmMYw30OcZQmhPtGTlTHlK2VUmP4j7yXD8WzIalXVKwBeEkzn0sbpNo74O7DUyrEsZR7Z3I2m5QGqmV+I4MQ5PRNr9Kvmlnb5+mJL7FgEuZQuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9O4rOECORK94j6DwG/ij6iAT+f2WoINafm8lisJpYcObsrMSAgq7A7HFDCFYGJtP5OyatPLerkYUqTlvuQe+lSv8X2GH3md+Skv9zwYM2J+lWo9uMvedZROpklswaV58tBDMPRIWzfKIv9hOkoxxs7+WuLDrtN2XHPB2Z4rAfy8eQUYsrmppCwJVtJIefmS/p7pgdQaS/EuGskSEUJuhHTgztbvtI+BiWoqvT5huxYv3fmoOksraYV4IdS7sWFfrhMu+j/uIDl/8l/69OtbDDad9xADc63ctf74lvpH5nxYrpoyF1jz8XdlKV7983jkhiCmlT7wHSFl+OIPu/sKohOSXkTmRxafR/3gzTs2fs4FSYBZI5HuxlswvRQyOClkaLUzOHYXnH12eMaY1MwR+U1VzXqimgBPU7l99oUDdPSbMDkqagjgsyefEB8XUZwLU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 07:43:21.0818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd402b07-2e89-47e8-256e-08de9ac2aab1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9263
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

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why/How]
Reset pointer/address to avoid double free.

Reviewed-by: Sridevi Arvindekar <sridevi.arvindekar@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c   | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index 72b0f3f8c2fd..e39fd97b3ffd 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -736,9 +736,12 @@ void dcn42_notify_wm_ranges(struct clk_mgr *clk_mgr_base)
 			clk_mgr_dcn42->smu_wm_set.mc_address.low_part);
 	dcn42_smu_transfer_wm_table_dram_2_smu(clk_mgr);
 
-	if (clk_mgr_dcn42->smu_wm_set.wm_set && clk_mgr_dcn42->smu_wm_set.mc_address.quad_part != 0)
+	if (clk_mgr_dcn42->smu_wm_set.wm_set && clk_mgr_dcn42->smu_wm_set.mc_address.quad_part != 0) {
 		dm_helpers_free_gpu_mem(clk_mgr->base.ctx, DC_MEM_ALLOC_TYPE_GART,
 				clk_mgr_dcn42->smu_wm_set.wm_set);
+		clk_mgr_dcn42->smu_wm_set.wm_set = NULL;
+		clk_mgr_dcn42->smu_wm_set.mc_address.quad_part = 0;
+	}
 
 }
 
@@ -1101,7 +1104,10 @@ void dcn42_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr_int)
 {
 	struct clk_mgr_dcn42 *clk_mgr = TO_CLK_MGR_DCN42(clk_mgr_int);
 
-	if (clk_mgr->smu_wm_set.wm_set && clk_mgr->smu_wm_set.mc_address.quad_part != 0)
+	if (clk_mgr->smu_wm_set.wm_set && clk_mgr->smu_wm_set.mc_address.quad_part != 0) {
 		dm_helpers_free_gpu_mem(clk_mgr_int->base.ctx, DC_MEM_ALLOC_TYPE_GART,
 				clk_mgr->smu_wm_set.wm_set);
+		clk_mgr->smu_wm_set.wm_set = NULL;
+		clk_mgr->smu_wm_set.mc_address.quad_part = 0;
+	}
 }
-- 
2.43.0

