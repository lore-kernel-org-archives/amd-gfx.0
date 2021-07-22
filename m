Return-Path: <SRS0=tcRC=MO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65144C636C8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 03:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A82D61106
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 03:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A82D61106
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF7A06EB9D;
	Thu, 22 Jul 2021 03:21:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E07F86EB9D
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jul 2021 03:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1+5j4NSWhRvlB/iY+6fInekJmZ7uluQwZmDxWozgiqK2w9U+nMX155RuoYSO0BOOFCUJALL3S0tOfun3MVzKBzQUXThdIGQdnwfYiQqYpsD/XB/ewD6LsTVZSSRKtjdSAyEr+0CPYYWHRB3+NHij2Pr2hbC89f9wn50XtAEGr+qrVm28oJUShmxZwSD0gkbQLfHrOMUAeSLnLitu8VFNCm4qQdgYIUU3ZOLnE1cqkiDw8rlN3AlatIK/8Lre4v9R1Ris4mS1YC/dpH+sxWNX+50wS90ckDgSLPyo4epSuMCepaL2ZSnoV5C6A1Tsg5uJfkCYm7tQGekSb8Rb3Du0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUJ5WtKjlH2lh9N8MjobU/qoXw0cn6wySuZmvlOinmw=;
 b=ggPXfphEiCFgzwJy9IpvylXJ/lkaGHtO05H0PN2XA7uUMD32ic8L5WlYK8gNUBM4nEO5JFzDoqKQItBZ8pXc/FAD20FIbbByYmKgR8CFpGiGoCI0IcOjvVA3W+SYijZTXydtVPEORnvfs0NPQwJEUe7oH79/dY0Vlo3RmXBIM3xc55+2E4sh/Lnm9yyfDbAFRZlxgH9kgndIwxKaz9kfd4PuypGS4B0RMRmF8vwJDGK6M2Q+qqiSb0uiqyRZoj2/DMfyn4wh6lZnc0uoLgpNMNl39DQhdQSYwnon4U5Qw1o71vUzC9ET9rq5HfSG0XEcATGU0vdjVi5QtmpvWB+5LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUJ5WtKjlH2lh9N8MjobU/qoXw0cn6wySuZmvlOinmw=;
 b=G3azpSRp397YBZVYOF9IBHXJ8Ft4MicEo/I8ys7jYaHQEnoRqJFUl3L0UItdMedB7TjwPGD++Q8Xlsul0xB53rD1FVEtMWkXzu+sMBRFbZAsarLbCYhqhbR+YIbhUctM8+akz+Z0JZJXjWekOUOZm9Fhf8ztDtxpt69GHQrnOuo=
Received: from BN6PR14CA0032.namprd14.prod.outlook.com (2603:10b6:404:13f::18)
 by DM6PR12MB3819.namprd12.prod.outlook.com (2603:10b6:5:1c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Thu, 22 Jul
 2021 03:21:14 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::63) by BN6PR14CA0032.outlook.office365.com
 (2603:10b6:404:13f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend
 Transport; Thu, 22 Jul 2021 03:21:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Thu, 22 Jul 2021 03:21:14 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 21 Jul
 2021 22:21:12 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: restore user customized OD settings properly
 for Sienna Cichlid
Date: Thu, 22 Jul 2021 11:20:46 +0800
Message-ID: <20210722032046.767094-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210722032046.767094-1-evan.quan@amd.com>
References: <20210722032046.767094-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5599ab36-5a68-4c9b-21d0-08d94cbfc2d5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3819:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3819DD38E8223434EA55216FE4E49@DM6PR12MB3819.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OeE9x5eRAaGcrD17ypplzV2/5GdrzR1wDrYwGCUdaAhTJi8JnmaerG5kBl+7V8EEUOuDgkKvdiz2Rx8Ds7Nqe3Ng9QADGZgvhdWkasSxGlMMbsdeO7rq1jIkYYFCdyeUT62FoeNQKdmtgacRMEqhooMTMqWvhtkh3MrSxBYjRMabezrC/bTEUWyy3HPgYl5pBe7xWvgSs0pWgAFqtCNJYUNObOCi31G3Dl0hl3WAIAg/OnHjsK14XBcyMg7p1rDkTWm0UkvEAThs6cFGMq6GjbtmQFU4SuRyKRyrMT+WfDrhDeWIsZfsX7N1eXPU6T6JbAuxq4bqjY3xXU9lwRTmOs5EfcjKsPx3B2zkK9gtulMG6wf3rzQRVD4z7UxTHXuDkt94L/OzUcGy35syVycYEdYXkJuucs3pNZZWj/HdqXAUamaroFz0nZQc53LPpIXajoln8VhnV6elZYrEA8Tm4eUYFs10V1C6cr8Efo4EH28Ft3Yr0pyZuKABqWB1b6n037m4sm10sQSJ48rbplCaPC5KrizXjXZyIYEutBTbolPJWmj5LBAOZ8d3/GyY+0pE+Psu7O4qFM1Av5YCekPrYa8LjIx3snZB6/7RgLn2yhePhJY2v2vBBlq381JHHdTYfgSIb/y2HMZZxgr04x4PZL8U2lZsm1qPgtOG2iuZzV2l7iB/BdIkZ9wCpVun/ksQsUUtjYl+ZQNoxUIYrSOYNufZeFVqfQ2Wf0tc9cX8sqA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(86362001)(6916009)(70206006)(36756003)(26005)(16526019)(54906003)(44832011)(47076005)(83380400001)(356005)(2906002)(1076003)(336012)(7696005)(8676002)(5660300002)(8936002)(186003)(426003)(2616005)(70586007)(316002)(81166007)(36860700001)(6666004)(66574015)(508600001)(82310400003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 03:21:14.0308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5599ab36-5a68-4c9b-21d0-08d94cbfc2d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3819
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Properly restore those committed and non-committed user customized OD
settings.

Change-Id: I25396df0b3ecdd7a0d9fc77ed220b0abf1fde020
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h           |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c  | 15 +--------------
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 16 +++++++++++++---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c   | 13 +++++++++++++
 4 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 385b2ea5379c..7bf25efc3936 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -302,5 +302,7 @@ void smu_v11_0_interrupt_work(struct smu_context *smu);
 
 int smu_v11_0_set_light_sbr(struct smu_context *smu, bool enable);
 
+int smu_v11_0_restore_committed_od_settings(struct smu_context *smu);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 4752299d7f91..fbd29129550a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2513,19 +2513,6 @@ static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABL
 	return ret;
 }
 
-static int navi10_restore_committed_od_settings(struct smu_context *smu)
-{
-	struct smu_table_context *table_context = &smu->smu_table;
-	void *od_table = table_context->committed_overdrive_table;
-	int ret = 0;
-
-	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)od_table, true);
-	if (ret)
-		dev_err(smu->adev->dev, "Failed to import overdrive table!\n");
-
-	return ret;
-}
-
 static int navi10_run_btc(struct smu_context *smu)
 {
 	int ret = 0;
@@ -3289,7 +3276,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
 	.set_default_od_settings = navi10_set_default_od_settings,
 	.od_edit_dpm_table = navi10_od_edit_dpm_table,
-	.restore_committed_od_settings = navi10_restore_committed_od_settings,
+	.restore_committed_od_settings = smu_v11_0_restore_committed_od_settings,
 	.run_btc = navi10_run_btc,
 	.set_power_source = smu_v11_0_set_power_source,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index e0638dc3f617..f0a7dc1d1640 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1957,15 +1957,16 @@ static int sienna_cichlid_set_default_od_settings(struct smu_context *smu)
 	int ret = 0;
 
 	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE,
-				   0, (void *)od_table, false);
+				   0, (void *)boot_od_table, false);
 	if (ret) {
 		dev_err(smu->adev->dev, "Failed to get overdrive table!\n");
 		return ret;
 	}
 
-	memcpy(boot_od_table, od_table, sizeof(OverDriveTable_t));
+	sienna_cichlid_dump_od_table(smu, boot_od_table);
 
-	sienna_cichlid_dump_od_table(smu, od_table);
+	if (!smu->adev->in_suspend)
+		memcpy(od_table, boot_od_table, sizeof(OverDriveTable_t));
 
 	return 0;
 }
@@ -2136,6 +2137,14 @@ static int sienna_cichlid_od_edit_dpm_table(struct smu_context *smu,
 			dev_err(smu->adev->dev, "Failed to import overdrive table!\n");
 			return ret;
 		}
+		if (memcmp(table_context->overdrive_table, table_context->boot_overdrive_table,
+			sizeof(OverDriveTable_t))) {
+			smu->user_dpm_profile.committed_od = true;
+			memcpy(table_context->committed_overdrive_table, table_context->overdrive_table,
+					sizeof(OverDriveTable_t));
+		} else {
+			smu->user_dpm_profile.committed_od = false;
+		}
 		break;
 
 	case PP_OD_EDIT_VDDGFX_OFFSET:
@@ -3902,6 +3911,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
 	.set_default_od_settings = sienna_cichlid_set_default_od_settings,
 	.od_edit_dpm_table = sienna_cichlid_od_edit_dpm_table,
+	.restore_committed_od_settings = smu_v11_0_restore_committed_od_settings,
 	.run_btc = sienna_cichlid_run_btc,
 	.set_power_source = smu_v11_0_set_power_source,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 28fc3f17c1b1..323126a7ca49 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -2113,3 +2113,16 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 
 	return ret;
 }
+
+int smu_v11_0_restore_committed_od_settings(struct smu_context *smu)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	void *od_table = table_context->committed_overdrive_table;
+	int ret = 0;
+
+	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)od_table, true);
+	if (ret)
+		dev_err(smu->adev->dev, "Failed to import overdrive table!\n");
+
+	return ret;
+}
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
