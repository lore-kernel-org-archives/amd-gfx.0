Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C25C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 03:20:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92F8F10E249;
	Tue,  8 Feb 2022 03:20:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D53010E249
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 03:20:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjX9Rix25L/1artC5QWKyJ6ui1DDL+ZKNcEnvQLRNKtB0gssxUWm4dFzVf4wgbFCv1sljadZManTC9EZAvd1GAyugZ5WqTSy8RhxuzVnk5x6c5f+CPdsi7f8wPPWxHVfIT6McLRAh7ATIe5ANCkvwRjIT15Q0tU4GFb8NGZWgoyB1AL13P8wnObcuB45+DIPlBxW2fUpUb6wt/rcN77gDZCqkgNd0K9X7Qcb/Tcd7SbODXJ4w3S/+Ckl5ZcEMvOoeEKStChR3Vg8KJiEUhR5AwU39WuxawzhPy3X1Icq1x9JHtvFyKid/o4y166GON69Ua8YbgCIlH1UaGYO0Lqudg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3v/c5J5v6dW2yTsMjE/InG0kkL6Y6Y2OhxNz8375DQ=;
 b=IUII2OmwPfMlxXxTpWSlHm18L3RXZgoNUE2UW4arQorHwwVqQjYgB93E7ZO3V5mIMnonYKPDpB2YR5AA8I7i4IAVeq75Q3w/+mFNeiYj/BOm7xtYfeQbqKZWWc1TFV4zXl/KfPRdNmxER/HPh8tj5axXGL5++6uet8mQ2lTkX/18O8Md7aN5BkW/M7aLl4k1fkvvza1IIUEfhbl0eq821GQlWoeO2gqQJ7gdWnOziFFTlgM81GGf7julW2tksFUl/lXZB0kBLMZNke72pZivXP1o42eU3LJ5VOFUYroEd/Jk+oeMxnJtVQr5dEPrnM5uJinhALltXa6qR/gohuC4QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3v/c5J5v6dW2yTsMjE/InG0kkL6Y6Y2OhxNz8375DQ=;
 b=NnoTQCkQtI8Xm3cxG97KtqhpPZ+c/ctXp1k15tXwwAg6RVitMrpQPyDXWcbkkVBy+9Y5MtuIgkGDHJjYmVouN7jdrQbJtPI7sw3YY4QIBSgxSUqSlF1+Pd5eiY1cDke5V9hHuX15FeySNTD9P7qA/6VL+babpL97GYvhRHmBMqU=
Received: from DM6PR03CA0063.namprd03.prod.outlook.com (2603:10b6:5:100::40)
 by DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 03:20:31 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::73) by DM6PR03CA0063.outlook.office365.com
 (2603:10b6:5:100::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11 via Frontend
 Transport; Tue, 8 Feb 2022 03:20:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Tue, 8 Feb 2022 03:20:31 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Feb
 2022 21:20:29 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/7] drm/amd/pm: fulfill the support for DriverSmuConfig table
Date: Tue, 8 Feb 2022 11:20:04 +0800
Message-ID: <20220208032009.763982-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220208032009.763982-1-evan.quan@amd.com>
References: <20220208032009.763982-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff1323d1-a44a-413a-566d-08d9eab1f69c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4236:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4236139F8674EA01A34FC172E42D9@DM6PR12MB4236.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y2EM0CBt6l4f2v7s4MQJf+ebQbEvxZSZgIbyVtUDIGdcNt6SVEQY+jO/X77DSL6WrDDl/W39yP33thANZgDKycf189ehSjxAJw1kLaWAcNTssPOwXknLCRYayH/9dRDd/Mr+6XsWpQy3JSfL3A+I/jKXLZks/O/sd7sNIYjvGUNWWD+00CyYfHYtKwl6KrqmRvRNfKxcxNS9BocXyp/SDXcoS2ogUFtMZElVCLWeLB2eWZ7p+or7v/2kaNyOz5D6WHN9z/xlKwSo+SkJwcL4YlODsxNqEZ4j2z6r3RyVaYFv8oP3A25rxfiCE+P6IwecZ0VjeAh8QanTRoMv8OXAsESoYir569fQI79ebQRCHqo0qIa5Sp0Bx/uVzLErb50B2S7/TI5/c8RrMPGCoSXCFiXBceVrw2mzWZZ2Wq/YhBnxK3ZgggXahMiUDRS0+59DqI4i80RLHWzR08YSxXT2lmkBmi79mo6fBbVwdF3YTOBao7TZC3zscjgZCQLnxTK9CFSl9lo4MF37IYw06TCG7ZI9qG4chl9HPvZ2KG7t5codvMO5bP0izXs78r0m0HOj1BHIq5sdHghUd40bxqnirGECsG8ZO38cJcORSw/8+SGMj2aCZ3QFw5rwROgA4ozufcA+JOk9s1W0cIdjqNpZ0MXC/9zRf9EdVjg8aaLk7sLLS71UVw5PzGy7pkbj+VhRfLKAil0+7fu8UwyZ374YFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70206006)(2906002)(6666004)(36756003)(6916009)(4326008)(316002)(70586007)(54906003)(356005)(81166007)(508600001)(7696005)(82310400004)(426003)(336012)(26005)(86362001)(44832011)(36860700001)(8936002)(5660300002)(186003)(47076005)(2616005)(8676002)(83380400001)(40460700003)(1076003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 03:20:31.6250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1323d1-a44a-413a-566d-08d9eab1f69c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable the support for DriverSmuConfig table on Navi1x and
Sienna_Cichlid.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ie510f8b06b7a4910b1574b6e9affa875805ef868
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h       |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c     |  9 +++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 13 ++++++++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c      |  2 ++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index fd38f628da3f..51a32ac39990 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -337,6 +337,7 @@ struct smu_table_context
 	struct smu_bios_boot_up_values	boot_values;
 	void                            *driver_pptable;
 	void                            *ecc_table;
+	void				*driver_smu_config_table;
 	struct smu_table		tables[SMU_TABLE_COUNT];
 	/*
 	 * The driver table is just a staging buffer for
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 467477974962..4aff185f0cea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -510,6 +510,8 @@ static int navi10_tables_init(struct smu_context *smu)
 	SMU_TABLE_INIT(tables, SMU_TABLE_ACTIVITY_MONITOR_COEFF,
 		       sizeof(DpmActivityMonitorCoeffInt_t), PAGE_SIZE,
 		       AMDGPU_GEM_DOMAIN_VRAM);
+	SMU_TABLE_INIT(tables, SMU_TABLE_DRIVER_SMU_CONFIG, sizeof(DriverSmuConfig_t),
+		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 
 	smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_NV1X_t),
 					   GFP_KERNEL);
@@ -526,8 +528,15 @@ static int navi10_tables_init(struct smu_context *smu)
 	if (!smu_table->watermarks_table)
 		goto err2_out;
 
+	smu_table->driver_smu_config_table =
+		kzalloc(tables[SMU_TABLE_DRIVER_SMU_CONFIG].size, GFP_KERNEL);
+	if (!smu_table->driver_smu_config_table)
+		goto err3_out;
+
 	return 0;
 
+err3_out:
+	kfree(smu_table->watermarks_table);
 err2_out:
 	kfree(smu_table->gpu_metrics_table);
 err1_out:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index c335f398ba4c..978c0ebe9d19 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -475,6 +475,8 @@ static int sienna_cichlid_tables_init(struct smu_context *smu)
 	               AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_ECCINFO, sizeof(EccInfoTable_t),
 			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+	SMU_TABLE_INIT(tables, SMU_TABLE_DRIVER_SMU_CONFIG, sizeof(DriverSmuConfigExternal_t),
+		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 
 	smu_table->metrics_table = kzalloc(sizeof(SmuMetricsExternal_t), GFP_KERNEL);
 	if (!smu_table->metrics_table)
@@ -492,10 +494,19 @@ static int sienna_cichlid_tables_init(struct smu_context *smu)
 
 	smu_table->ecc_table = kzalloc(tables[SMU_TABLE_ECCINFO].size, GFP_KERNEL);
 	if (!smu_table->ecc_table)
-		return -ENOMEM;
+		goto err3_out;
+
+	smu_table->driver_smu_config_table =
+		kzalloc(tables[SMU_TABLE_DRIVER_SMU_CONFIG].size, GFP_KERNEL);
+	if (!smu_table->driver_smu_config_table)
+		goto err4_out;
 
 	return 0;
 
+err4_out:
+	kfree(smu_table->ecc_table);
+err3_out:
+	kfree(smu_table->watermarks_table);
 err2_out:
 	kfree(smu_table->gpu_metrics_table);
 err1_out:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index d71155a66f97..b87f550af26b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -473,9 +473,11 @@ int smu_v11_0_fini_smc_tables(struct smu_context *smu)
 	kfree(smu_table->hardcode_pptable);
 	smu_table->hardcode_pptable = NULL;
 
+	kfree(smu_table->driver_smu_config_table);
 	kfree(smu_table->ecc_table);
 	kfree(smu_table->metrics_table);
 	kfree(smu_table->watermarks_table);
+	smu_table->driver_smu_config_table = NULL;
 	smu_table->ecc_table = NULL;
 	smu_table->metrics_table = NULL;
 	smu_table->watermarks_table = NULL;
-- 
2.29.0

