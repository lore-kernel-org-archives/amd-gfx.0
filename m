Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5385CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 09:34:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DEF7613A4
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 09:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1DEF7613A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C0936E920;
	Thu, 18 Nov 2021 09:34:04 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2061.outbound.protection.outlook.com [40.107.100.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E5196E9A1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 09:34:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5PGfiR5/Crw2pasX+5GcvEYJhNjiTGL8WwOW0lnGwvB803vGPY5PK/vanAQNPxZRq8UsEkP8jQdvLWQYEh6Aj703xtE9g5jmGXp0PaJK2EpcQZH7AnhEClkHDCCGYZ4xBFGGtx7EEZUYVLP8VcxNfEnR8bwpJJZymSPiz8bNAQz61GBfLvRvunJz+6lQyPw2nlbQaHzLUirHdXpkD7UmHgbNp3HoyES+0+VFI7hYyILto6IBS7XnC/jUN7cDGka9hUuD3vl6KJDJnv/zF2v87Mc/jq8dCKEV5k1sV2/ml3EHoVHm5kTnvcVDhOLoNA9DatITLN9KzEjxBZmVudnhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1G5zY0XBcP9t/RQ+o4n/afMrhfxCEFLy57qVIKp1T3Y=;
 b=Pt/1OGg2kgmsYZETHMcR0XKQ/pm2zQhyd/FpWYQu0JslTAg8/5ZNggC9W2nK3OQhUZ66SO+vTEfipUVWg9pqQTj5Jzck/WkCdc0aJmlnCD5AQqbc6pPBV6QfUlU+zwpYIgCUS30yhE6/rBZ2Pf7eoe7GbQDPDy0b6Opn2kltelbWzoZ5NzwSlmjJWPvYNKiCigza/dDPXu6cwr8WLOB/UikLIqCls2+b4RT9NWO2uFT1Y6ypdoZ7zd6XvjaGF9PbVjHxGz6SuKznp+rkn4Ai8buisVi1q3wW0FWS8qZ+d0LLk2EV1W8BXoZI9CJuYNHurARVj78hdcV3MT9X5g4ABw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1G5zY0XBcP9t/RQ+o4n/afMrhfxCEFLy57qVIKp1T3Y=;
 b=dSyThNyBFxshN5HRcVF2eOf1QSb+8rAyMHIRgUioN/FX1/5ZO8I+YWSM8tGnAQqBCruOvzfZESOvIiFosYKKoBJCMnlG6ZZIq3PNxMV+mLJQxchv978vHNmnSHHg0s2LF8I9SEqYKpwcFGXMY+br1bpyWpSalnk3QsmhzH3v2ZU=
Received: from DM5PR1401CA0007.namprd14.prod.outlook.com (2603:10b6:4:4a::17)
 by CY4PR12MB1413.namprd12.prod.outlook.com (2603:10b6:903:39::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 18 Nov
 2021 09:34:00 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::cc) by DM5PR1401CA0007.outlook.office365.com
 (2603:10b6:4:4a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25 via Frontend
 Transport; Thu, 18 Nov 2021 09:34:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Thu, 18 Nov 2021 09:33:59 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 18 Nov
 2021 03:33:57 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 18 Nov
 2021 01:33:55 -0800
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 18 Nov 2021 03:33:53 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <John.Clements@amd.com>, <Evan.Quan@amd.com>, <Lijo.Lazar@amd.com>,
 <KevinYang.Wang@amd.com>
Subject: [PATCH Review 4/4] query umc error info from ecc_table v2
Date: Thu, 18 Nov 2021 17:33:44 +0800
Message-ID: <20211118093344.4361-4-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211118093344.4361-1-Stanley.Yang@amd.com>
References: <20211118093344.4361-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce740415-cd51-4014-4ab8-08d9aa768d26
X-MS-TrafficTypeDiagnostic: CY4PR12MB1413:
X-Microsoft-Antispam-PRVS: <CY4PR12MB141375539BF3AEB6A188BC799A9B9@CY4PR12MB1413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:586;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rW0Ujhfwh8kP26T4A3GOXzMUOU2os5m+XBP2lXscASM33GhtD+mhuyiqDJnZyASlOaxwV7UsYdw7vmY0u3EtjapQUKDM4ofhhmA/5cm7rsV1+shntbZ4NDRWcMrb7O7WrngWHdkpXVx2F7bR2zyBl3otvUX681y/kkIS3w4ZBUn1hIhxPqffEZXwJp9dv4AKphmTw4GupF5TVHrMPAG936g4uG4PelAO/t2ROBKoMwUO6SaOu5AA0zH8AlXE++e+C0lC7A8KfVxs77fBSRrtFpfsk9xZgP+VeAS8Vd5MYHhIXLIiPwT991RVbLhxFyLusSlxOWPAD4UWfI3u0AoZQdpDMXmxABXAb2UOroN1Hd27ArH6DFvKYADeiZKXW2v0hjtM1gRFjL7AjQibYinQhEI1k/gC3y/X8o3/S72BQm0WFjiA2U2teyBku9bMwPaHYBFR0xCvItaSZnzPFVQ4FzgpiwKsOHtp/1idRgHhckB2+wnxUoCgRFf+xwhPBaroj25DM3UjG4InTrHF+6G4GNYvwYQkXLD2Vbk/XAiYB2nUCdux3iPwy/lW/2fhUpC0abIpFbHXnLqqJXIu8U/i9Tm+y1r889vYFZfxG1vxjxrTyBw7RJJD1nFjVRbsX10McUq71fd9ENGLftmZld91022GAWa8aB2FZUH+z3UmymNC6nD+vM3I7dfz+BxPew0GxIkMebNYapP5T+B2M+6zKltqQ531a0R6hiCGnBUz/EI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2906002)(5660300002)(81166007)(426003)(356005)(336012)(2616005)(186003)(36756003)(4326008)(47076005)(6666004)(7696005)(316002)(6636002)(8676002)(86362001)(36860700001)(508600001)(70586007)(70206006)(110136005)(26005)(82310400003)(8936002)(83380400001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 09:33:59.9736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce740415-cd51-4014-4ab8-08d9aa768d26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1413
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

if smu support ECCTABLE, driver can message smu to get ecc_table
then query umc error info from ECCTABLE

v2:
    optimize source code makes logical more reasonable

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 42 +++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 72 +++++++++++++++++--------
 2 files changed, 83 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 90f0db3b4f65..3a4e483cd5e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -888,6 +888,38 @@ void amdgpu_ras_mca_query_error_status(struct amdgpu_device *adev,
 	}
 }
 
+static void amdgpu_ras_get_ecc_info(struct amdgpu_device *adev, struct ras_err_data *err_data)
+{
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	int ret = 0;
+
+	/*
+	 * choosing right query method according to
+	 * whether smu support query error information
+	 */
+	ret = smu_get_ecc_info(&adev->smu, (void *)&(ras->umc_ecc));
+	if (ret == -EOPNOTSUPP) {
+		if (adev->umc.ras_funcs &&
+			adev->umc.ras_funcs->query_ras_error_count)
+			adev->umc.ras_funcs->query_ras_error_count(adev, err_data);
+
+		/* umc query_ras_error_address is also responsible for clearing
+		 * error status
+		 */
+		if (adev->umc.ras_funcs &&
+		    adev->umc.ras_funcs->query_ras_error_address)
+			adev->umc.ras_funcs->query_ras_error_address(adev, err_data);
+	} else if (!ret) {
+		if (adev->umc.ras_funcs &&
+			adev->umc.ras_funcs->ecc_info_query_ras_error_count)
+			adev->umc.ras_funcs->ecc_info_query_ras_error_count(adev, err_data);
+
+		if (adev->umc.ras_funcs &&
+			adev->umc.ras_funcs->ecc_info_query_ras_error_address)
+			adev->umc.ras_funcs->ecc_info_query_ras_error_address(adev, err_data);
+	}
+}
+
 /* query/inject/cure begin */
 int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 				  struct ras_query_if *info)
@@ -901,15 +933,7 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 
 	switch (info->head.block) {
 	case AMDGPU_RAS_BLOCK__UMC:
-		if (adev->umc.ras_funcs &&
-		    adev->umc.ras_funcs->query_ras_error_count)
-			adev->umc.ras_funcs->query_ras_error_count(adev, &err_data);
-		/* umc query_ras_error_address is also responsible for clearing
-		 * error status
-		 */
-		if (adev->umc.ras_funcs &&
-		    adev->umc.ras_funcs->query_ras_error_address)
-			adev->umc.ras_funcs->query_ras_error_address(adev, &err_data);
+		amdgpu_ras_get_ecc_info(adev, &err_data);
 		break;
 	case AMDGPU_RAS_BLOCK__SDMA:
 		if (adev->sdma.funcs->query_ras_error_count) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 0c7c56a91b25..2b37b1c293b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -95,30 +95,58 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	int ret = 0;
 
 	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
-	if (adev->umc.ras_funcs &&
-	    adev->umc.ras_funcs->query_ras_error_count)
-	    adev->umc.ras_funcs->query_ras_error_count(adev, ras_error_status);
-
-	if (adev->umc.ras_funcs &&
-	    adev->umc.ras_funcs->query_ras_error_address &&
-	    adev->umc.max_ras_err_cnt_per_query) {
-		err_data->err_addr =
-			kcalloc(adev->umc.max_ras_err_cnt_per_query,
-				sizeof(struct eeprom_table_record), GFP_KERNEL);
-
-		/* still call query_ras_error_address to clear error status
-		 * even NOMEM error is encountered
-		 */
-		if(!err_data->err_addr)
-			dev_warn(adev->dev, "Failed to alloc memory for "
-					"umc error address record!\n");
-
-		/* umc query_ras_error_address is also responsible for clearing
-		 * error status
-		 */
-		adev->umc.ras_funcs->query_ras_error_address(adev, ras_error_status);
+	ret = smu_get_ecc_info(&adev->smu, (void *)&(con->umc_ecc));
+	if (ret == -EOPNOTSUPP) {
+		if (adev->umc.ras_funcs &&
+		    adev->umc.ras_funcs->query_ras_error_count)
+		    adev->umc.ras_funcs->query_ras_error_count(adev, ras_error_status);
+
+		if (adev->umc.ras_funcs &&
+		    adev->umc.ras_funcs->query_ras_error_address &&
+		    adev->umc.max_ras_err_cnt_per_query) {
+			err_data->err_addr =
+				kcalloc(adev->umc.max_ras_err_cnt_per_query,
+					sizeof(struct eeprom_table_record), GFP_KERNEL);
+
+			/* still call query_ras_error_address to clear error status
+			 * even NOMEM error is encountered
+			 */
+			if(!err_data->err_addr)
+				dev_warn(adev->dev, "Failed to alloc memory for "
+						"umc error address record!\n");
+
+			/* umc query_ras_error_address is also responsible for clearing
+			 * error status
+			 */
+			adev->umc.ras_funcs->query_ras_error_address(adev, ras_error_status);
+		}
+	} else if (!ret) {
+		if (adev->umc.ras_funcs &&
+		    adev->umc.ras_funcs->ecc_info_query_ras_error_count)
+		    adev->umc.ras_funcs->ecc_info_query_ras_error_count(adev, ras_error_status);
+
+		if (adev->umc.ras_funcs &&
+		    adev->umc.ras_funcs->ecc_info_query_ras_error_address &&
+		    adev->umc.max_ras_err_cnt_per_query) {
+			err_data->err_addr =
+				kcalloc(adev->umc.max_ras_err_cnt_per_query,
+					sizeof(struct eeprom_table_record), GFP_KERNEL);
+
+			/* still call query_ras_error_address to clear error status
+			 * even NOMEM error is encountered
+			 */
+			if(!err_data->err_addr)
+				dev_warn(adev->dev, "Failed to alloc memory for "
+						"umc error address record!\n");
+
+			/* umc query_ras_error_address is also responsible for clearing
+			 * error status
+			 */
+			adev->umc.ras_funcs->ecc_info_query_ras_error_address(adev, ras_error_status);
+		}
 	}
 
 	/* only uncorrectable error needs gpu reset */
-- 
2.17.1

