Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CA1CD6E5D
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 02:51:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BC4C10E26C;
	Wed,  3 Jun 2026 02:51:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uLcmk+Zq";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010014.outbound.protection.outlook.com [52.101.56.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0CF210E26C
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 02:51:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0p2s9wd1yS25y96Tb0NS7+HwAMnum6yL+AwsHKfgq+Fk3Snsis8E3RKi9GNfz23GFWohdkYanDkJBm0VXYSeg0LfuOddwOPymJtPqgXZn+45DlF9w9KO/uTTyPqEPDNzAIFRHESHcQI9nuWh/4wnRl+5RWNU6aTxRO7ib46WXc7Ae4eV5ucoMHniYzO5eC3C+nRS3SE5z8lrfYC0zp8D6wkS02krfx99giJdM6IJ4WT4z+sbVYZVs981x0CBdIFwZD17DYy+Z3WtSgdnbkzSPt0rHrUBNPSaYv4kWM44kqVdoHzg0RB6UEm+e+jITPpuKo99TtV97GXsku1/Fd+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=By/3gONsobqIfhBIClE7eemeWBr61wP2Aoo3WKzkrNc=;
 b=jIz1qJRyTlJXVPF1YUi5iN5jj2G6M0OBBdB1tqWhQzW/FmZqsDsAhECf+HS3qYw3FkkmJOnHnQyme0Ep2ZkQKr3WkfsB/zJoK9/spXkCyS+viww5DTbTMOLq+8zxAdoanFxHkdwX3CPpmTicK9TLDTIRwglj1VAvb93B8HilBtbC9kZ5/YKxYZrdy5rJUS+vnxE9sD6Q8g/Nwmi/I/DcqqGcLptyHFIzE6wGnHjS5nBnVL3J0g0+2++47xeQppaqNX5GmmtVIILE86sDz8jGVhoatNDNk/aY5ERCI/xgsTqRXvfYKdGzDG667ZIXSEYIey+HfuIuGMHHX5I+TWNp3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=By/3gONsobqIfhBIClE7eemeWBr61wP2Aoo3WKzkrNc=;
 b=uLcmk+ZqHuTvtwi0PqHLvO+C2Qpzp621aOzSwXxGzu7Tr9rD/cNWL+XZ7VW+1DhlHGeg9GEN6hc+V84GY6QCmdyGOqHEQyNM4H7382rMSotjSRDcdQK+FG0p+XWvQEnVBEoc3Hl9bdR1FaVUncm+4yPzSQ5Un/C12GoifRFs8VE=
Received: from CH0PR03CA0113.namprd03.prod.outlook.com (2603:10b6:610:cd::28)
 by DS2PR12MB9688.namprd12.prod.outlook.com (2603:10b6:8:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Wed, 3 Jun 2026
 02:51:17 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::55) by CH0PR03CA0113.outlook.office365.com
 (2603:10b6:610:cd::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 02:51:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 02:51:16 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 21:51:14 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v1 1/2] drm/amdgpu/ras: Parse all deferred errors with UMC aca
 handle
Date: Wed, 3 Jun 2026 10:51:04 +0800
Message-ID: <e4d35cc1c23f27f1281b2f5c53d30fa712a12f37.1780454960.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1780454960.git.cesun102@amd.com>
References: <cover.1780454960.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|DS2PR12MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: ca7f1916-0b82-47df-e6f8-08dec11afb87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 3GMDQdnc9cZ2wrTd01VUuQ9Z7/eIDFCsiuKiDSftgbtkKohHRqZm93WvuZsv0VURxOHV9YLPPBByniwp8nnRpmQPURn2umzwp0CBd4E6eolXkM0QTCSvlm7AAyrv7A66/kWNXd8GXlGk1EhpMzLEjVMfS0B+6D3knLoa1v47ilFIDMFLTXhzeYAEWAMjJrjYqZ3Vr6emQVlwnnje5qXnGf4PasFbynFbxprFix2q7OHPXMsViAfCQZXRfs1I1f+uo8NGv8QR4m6hCUmRAai5UHM1MHc32JnQAt2aCDI2jAyTHO8YNv89ap5dI9ye9MvgPAl6XaTaLlSUKC7j+5EoEHzAMY9W96wKUL8fQnC/nPbQ1ENd4yytWmoo2FlUf7J3CBozTrKJsaVmyxPiNtP6wBcr5HGI6B8csVF3NYz2Lbm6gK5Klqwrs8MyLT2l1XvsorGjHgqDDPSNVjbYY1Z+fR+b112U9cSDPGhGKFZtFOdvuhrXTJHJzO1JNAY1gOlNh8EKDbhZTQUpAam27KSU6pvYsF5uSuuwKS25ibANqzimvnAPoxm7WUnShL2hQgZ2plahgFewRdVN9h2zLW36XIWrAhzgf1yJX5/wvVZqVYSZ0njqT4+Z9V+VlkfWfeenhwvqCtmre/by+xx+TUc5aFdxGC2psavwBOsZNwefinXL4S0WltY+gzgnNAP4s+ONUOf9D6Ilv3Ai3CIIy8mmSxiriSNqNQMtMgSGBTFPIFI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eAUw/Q7A00u6E8xa4W9ovJH49KdZtZA4z77PUSdfQcXpe29AR6Siq+enOMHAvGi/FFQ3+dQXEgRR9jw9e/hX+EvrlQXZr0yOTbGcOmXFEfNfYi5BhSdxoMb9a5uaMfuR8DBj3yWtWI/J1Cdp8CmKH0bLSAEVEJ7wx/zeAdJLPmaQw5J/ZfVrivChPv0KF9Y/m1enVBiEcWKroLk7V3VTK4iW9RMcCZXCdqvXfpSGMi4kr030Y499JFgn32YNQNEvFkfU7GQVb/kPz43S6/CP4Uya+azgJ8PpEa9csywVBgoDdIVOXaXUdNRfq3f051qPjvNaqczpRlAg6uu/0IWwFOYayHAdmrEb2ZFfgI4M5M9v58zhK+zDND3RMOvvCtsxmGlucEH+1nrNS88C+O21dyKJRNze2f/QvvYOhmm4JZCfr4R94T+3IgPClfGpHtt1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 02:51:16.6020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7f1916-0b82-47df-e6f8-08dec11afb87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9688
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

We should only increase the deferred errors in UMC block

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
index 210fbd8851a6..840610538c1f 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
@@ -213,7 +213,7 @@ static int aca_parse_umc_bank(struct ras_core_context *ras_core,
 	struct aca_bank_reg *bank = (struct aca_bank_reg *)data;
 	struct aca_bank_ecc *ecc = (struct aca_bank_ecc *)buf;
 	struct aca_ecc_info bank_info;
-	uint32_t ext_error_code;
+	uint32_t ext_error_code, misc0_errcnt;
 	uint64_t status0;
 
 	status0 = bank->regs[ACA_REG_IDX__STATUS];
@@ -228,15 +228,14 @@ static int aca_parse_umc_bank(struct ras_core_context *ras_core,
 	ecc->bank_info.addr = bank->regs[ACA_REG_IDX__ADDR];
 
 	ext_error_code = ACA_REG_STATUS_ERRORCODEEXT(status0);
+	misc0_errcnt = ACA_REG_MISC0_ERRCNT(bank->regs[ACA_REG_IDX__MISC0]);
 
 	if (aca_check_umc_de(ras_core, status0))
-		ecc->de_count = 1;
+		ecc->de_count = misc0_errcnt ? misc0_errcnt : 1;
 	else if (aca_check_umc_ue(ras_core, status0))
-		ecc->ue_count = ext_error_code ?
-			1 : ACA_REG_MISC0_ERRCNT(bank->regs[ACA_REG_IDX__MISC0]);
+		ecc->ue_count = ext_error_code ? 1 : misc0_errcnt;
 	else if (aca_check_umc_ce(ras_core, status0))
-		ecc->ce_count = ext_error_code ?
-			1 : ACA_REG_MISC0_ERRCNT(bank->regs[ACA_REG_IDX__MISC0]);
+		ecc->ce_count = ext_error_code ? 1 : misc0_errcnt;
 
 	return 0;
 }
@@ -266,7 +265,7 @@ static int aca_parse_bank_default(struct ras_core_context *ras_core,
 	ecc->bank_info.addr = bank->regs[ACA_REG_IDX__ADDR];
 
 	if (aca_check_bank_is_de(ras_core, status)) {
-		ecc->de_count = 1;
+		ecc->de_count = 0;
 	} else {
 		if (bank->ecc_type == RAS_ERR_TYPE__UE)
 			ecc->ue_count = 1;
-- 
2.34.1

