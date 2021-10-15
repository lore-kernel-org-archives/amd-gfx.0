Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1F2C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 00:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BFB360EB4
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 00:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0BFB360EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 633CA6ECB4;
	Fri, 15 Oct 2021 00:51:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2FB76ECB3
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 00:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evIVQVvAHd/KCO74hzzdcJiY9vAzc+d6STvqerpb1Y+pJ7dO7R78niGgIP7xa390+0BV1mMSfy7IZex7RPc0knGyl8lqhxInN4DEesLV2KUCYnaSv41Rdjr5qGHUFtPnNOWiHr+DVKOHjoUCtN+3GOdcu8v4bA+pK8wAei95434P/JXXutJaJSH9GTxag6oLTETAhxipiyrjT02CkXdPHKRrknAb9WAj61Rk/aVbNxCfoW+d6vHK1mAkzmE0Kgkx/i9IcUglRWyWBGnfs+qEF81EpCPIwOSCJ057HWES9zhx2F8aO/Ki+1OM5OuK+2z6tlHrcYT95aSesKn658AnOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BZ09jl5qgRicXAtu0CzcxrdH+If04+qbTZ7uAt+keY=;
 b=IqGP0GTmIEQ5wm2nRh5KA80zPFru7e5hKhg7KZKN4qhseunUUQTgDqZe+IaO9Qvd8/SEsJDYTXjTlhh9iMW53OuJJjfrpI/Rb+2qL4LJUyKyQasSjEXA2XfZ+r53ek89wU4awPlXrPjoK9kMEehJqB7ZU1s8dRuM01S7OeOL64eWdjrbPwS08p1SzWxKGMYCy3XwIsyE/+XZ7qg7Q8jrNu5XQjcDWNU/ZelZzztnc3LlunEU62ljKkshmlLsOfRS6oTzmmr9wzBBgrMTOh2woA+ntKDmex90uhf3qAs3ZCcYt2mPvO+c+/Dhi4WqO9XqZE4OiQFheQgne1SnWgLZmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BZ09jl5qgRicXAtu0CzcxrdH+If04+qbTZ7uAt+keY=;
 b=RT61a/rw4XSW1hca7MUDBFu3WxOJb5oCCsHZOTErBKHu1CrL/9/JlAU8XLeXqrNYkFP+bKtsJoUimPuplXXQEKmr3FV26kW9nu/jVgC4aovk5Cmh6bu8oliNydhjPby7s34Mlje2aXSBNgcDqmzWVkYXuR9cJf6DFwPWgrfr2nE=
Received: from MW4PR03CA0280.namprd03.prod.outlook.com (2603:10b6:303:b5::15)
 by BN8PR12MB3443.namprd12.prod.outlook.com (2603:10b6:408:63::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 00:51:08 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::59) by MW4PR03CA0280.outlook.office365.com
 (2603:10b6:303:b5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Fri, 15 Oct 2021 00:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 00:51:08 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 14 Oct 2021 19:51:04 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher
 <Alexander.Deucher@amd.com>
Subject: [PATCH 1/5] drm/amd/pm: Slight function rename (v2)
Date: Thu, 14 Oct 2021 20:50:42 -0400
Message-ID: <20211015005046.43486-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.33.1.558.g2bd2f258f4
In-Reply-To: <20211015005046.43486-1-luben.tuikov@amd.com>
References: <20211015005046.43486-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47106818-9969-475e-4ef1-08d98f75e005
X-MS-TrafficTypeDiagnostic: BN8PR12MB3443:
X-Microsoft-Antispam-PRVS: <BN8PR12MB344342E88638BCC312D817EA99B99@BN8PR12MB3443.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:262;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OFG97cLu2/AiTZexfKMmS6fY6RQa7nrjd8ew0WvF9Ij3qDhBtpJ0G4CYIsKLUKTUhUy3AZL0I3cap99DV0ySABIKbxdMu3+pcZ/yB3Sr9d+qlXcMhUYYEMqZCi8DDIYSISErWU5OSfIPP+pkDC+rmsUVxOqJKAtB8uRZ+Km9UcRWUM/JJCrv31fVAzem61x7GfwqQx4zRufkVyxj+rQ2R/cmewS1RkMkTsKju5JMmPHq1jUYSGygdp40Caw3jX8p/miMRH1udjtAT54ZpyRaHnBJ7BUP/3IssjaEMHl+NY9rcpDjg6Mp198PXcsdpj4giO3sTJojRWUgrIMtHAM0vw+a3xBeppPpQreY2Xt+mCs2qirH6PrG6TcAbH0NOUPNipGdnJuaspjKCij7ZSz4BltJq9ZDa2QTn5CmaVwVGgeUrUpgKh/Sj1W/aT8Inn75zNYgkndTkpAEqbN5srGIB2NFptJY0PB5nXOikAu3z+8O78iFAj8qDyqSjNiGi/dFfdd3yTfD3VnxJg4h/e+/Nx4qFtGazOpF7xhwiqy+gqpHCNQ7JKGJjQMM9XNyJ6Rmp0BI3kuFlvNqSwuWxj+vFTl8A8/4g2YknM11Vc3M7lrCaQuLAd/PFcANpt2wOsO4GvnsWqXuJy/SMf8n65lC2s92Ls2U64xgTWIy8s/T+uJAdEv4TMWEg2remPGxrkbAPlPotRsTxGRgFl6cgOsV4nVC+7oRHciZUysVdcYf8wQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70206006)(2616005)(426003)(186003)(16526019)(356005)(86362001)(70586007)(8936002)(8676002)(6916009)(4326008)(7696005)(26005)(336012)(54906003)(36756003)(5660300002)(316002)(81166007)(83380400001)(44832011)(2906002)(36860700001)(82310400003)(47076005)(508600001)(1076003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 00:51:08.0356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47106818-9969-475e-4ef1-08d98f75e005
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3443
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

Rename
sienna_cichlid_is_support_fine_grained_dpm() to
sienna_cichlid_supports_fine_grained_dpm().

Rename
navi10_is_support_fine_grained_dpm() to
navi10_supports_fine_grained_dpm().

v2: Fix function name in commit message to reflect
the change being done: add a missing 's'.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 7 ++++---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 71161f6b78fea9..0fe9790f67f5af 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1231,7 +1231,8 @@ static int navi10_get_current_clk_freq_by_table(struct smu_context *smu,
 					   value);
 }
 
-static bool navi10_is_support_fine_grained_dpm(struct smu_context *smu, enum smu_clk_type clk_type)
+static bool navi10_supports_fine_grained_dpm(struct smu_context *smu,
+					     enum smu_clk_type clk_type)
 {
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	DpmDescriptor_t *dpm_desc = NULL;
@@ -1299,7 +1300,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 		if (ret)
 			return size;
 
-		if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
+		if (!navi10_supports_fine_grained_dpm(smu, clk_type)) {
 			for (i = 0; i < count; i++) {
 				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
 				if (ret)
@@ -1465,7 +1466,7 @@ static int navi10_force_clk_levels(struct smu_context *smu,
 	case SMU_UCLK:
 	case SMU_FCLK:
 		/* There is only 2 levels for fine grained DPM */
-		if (navi10_is_support_fine_grained_dpm(smu, clk_type)) {
+		if (navi10_supports_fine_grained_dpm(smu, clk_type)) {
 			soft_max_level = (soft_max_level >= 1 ? 1 : 0);
 			soft_min_level = (soft_min_level >= 1 ? 1 : 0);
 		}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 15e66e1912de33..3f5721baa5ff50 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1006,7 +1006,8 @@ static int sienna_cichlid_get_current_clk_freq_by_table(struct smu_context *smu,
 
 }
 
-static bool sienna_cichlid_is_support_fine_grained_dpm(struct smu_context *smu, enum smu_clk_type clk_type)
+static bool sienna_cichlid_supports_fine_grained_dpm(struct smu_context *smu,
+						     enum smu_clk_type clk_type)
 {
 	DpmDescriptor_t *dpm_desc = NULL;
 	DpmDescriptor_t *table_member;
@@ -1084,7 +1085,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		if (ret)
 			goto print_clk_out;
 
-		if (!sienna_cichlid_is_support_fine_grained_dpm(smu, clk_type)) {
+		if (!sienna_cichlid_supports_fine_grained_dpm(smu, clk_type)) {
 			for (i = 0; i < count; i++) {
 				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
 				if (ret)
@@ -1235,7 +1236,7 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 	case SMU_UCLK:
 	case SMU_FCLK:
 		/* There is only 2 levels for fine grained DPM */
-		if (sienna_cichlid_is_support_fine_grained_dpm(smu, clk_type)) {
+		if (sienna_cichlid_supports_fine_grained_dpm(smu, clk_type)) {
 			soft_max_level = (soft_max_level >= 1 ? 1 : 0);
 			soft_min_level = (soft_min_level >= 1 ? 1 : 0);
 		}
-- 
2.33.1.558.g2bd2f258f4

