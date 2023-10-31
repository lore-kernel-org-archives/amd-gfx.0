Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02F7C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 03:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71D9110E3E5;
	Tue, 31 Oct 2023 03:23:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04D0110E3E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 03:23:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VatIDYSHHgcyM21nRXtGQnGfb6B+csbBQSkuowmmTiBvbg5pDMGEjTJMlm2ZJUvA4eyAOoLvHNnNvEHP6Y5I2ETCHnwjXKkZjj1w2J9fUxmh7LUpBKxJOE93I3PIivg8v1Amtv37tsP4XUFDTq8/0C6XP8FZCwM/PtYSDc9lRok8ptWrdqA5VSJOLfHFsVzmFAydS1d69zp76IJunX9i7w8ptf1eMtw8uM5X5CHjB+uAYl8MQsLG6OwwkTKLf+2Pfxmu6FQHtLdmGWsuxepzOfaAoaCr9W+gPOurzjxeESvp4ntqelUPCUZ9TQX4zVZ2Rb+PW+VJnzzx1G9UvMi7tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNqbCY0t/f0ssC5+E7i1w3stN6+TXMT+qHDXSNn+rmA=;
 b=djtL/bW+K2UDPVjpbHH2eYIaQ/+PGf/vUhpfrNUSI6+DUt/vSpnQSVv2rXMydVBJHZKCggW0nFlx0/6eGTmwrG2baSWJstDUlvohJ85VTXVpjM8unUsxCzut3dK7ChYsml7Wmb8JUwbAJDCZI5f1EN3jiR0Rud3rMXwArcUu1YanqFmDqHK4Ao1nVNVi4IKPHaHUanznXYCpmsVfVRyTEDamNGbXHAhsDA02VQrkJMlbUy30l7eUpUUYLfkPFWubWVMjqk16XfYvbUumVzHIj1Bcey2/YJ71wedEZlXf1/ypRW1dgPTeCrhh/TWpJJLmzZatpMaSSeOtQepx250IDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNqbCY0t/f0ssC5+E7i1w3stN6+TXMT+qHDXSNn+rmA=;
 b=EUARt5ZsZGCSOvmFIv9fIfeguIJdHUVrMnZXR4/lUfgdAHxhEIDFF+IqPhdjrUi0M5FTgC0f253Q1+erFnKuZts85EHykuOOXh7jmZ1QzZyESNtZCxZJdlsqR+5bLFKtwHKspkdfeL3dNlx72tYyVe3EhVxXzyrY2szwRiOgIrU=
Received: from DS7PR03CA0133.namprd03.prod.outlook.com (2603:10b6:5:3b4::18)
 by SA1PR12MB5669.namprd12.prod.outlook.com (2603:10b6:806:237::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Tue, 31 Oct
 2023 03:23:35 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::3c) by DS7PR03CA0133.outlook.office365.com
 (2603:10b6:5:3b4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29 via Frontend
 Transport; Tue, 31 Oct 2023 03:23:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Tue, 31 Oct 2023 03:23:35 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 30 Oct
 2023 22:23:33 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/swsmu: remove fw version check in sw_init.
Date: Tue, 31 Oct 2023 11:23:05 +0800
Message-ID: <20231031032305.2055080-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SA1PR12MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: a568cc39-d033-4ed8-8dc1-08dbd9c0c452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VAm4BhXmsg32gopFrE4T5nDHbEYJu8LHQcCXODiZmTI06YnMTz09kRfdgjUyRbVZLNPvBDnb4GPbWQnkWRYbfFGj/jpmYrfwIMjilqqjHHe5g6o+oLG+dgLvJYVsTy6tOEVyRD9hkgyG+Fcj8z808O34AIiUkbwuExtyf0IAH5RnqNdlIC8X09qBNww8R+2dY3A2bFAOvVvTuAu/DtSTa1pPjtVKCFra3F1uCDJ7YV1cMT0zx7GGVsTYRY5fS8QUr4ZaeIE+quPzyLILfC6DFIvlODWyc6Ro1CbO4nTUCed5dLf2uFk94YcSg95k+I4hTqj0Uyn1bPI/xA94q+IcLab3Szl69bhHTIIO3L3ylHnt1W1aLzuDb2RGhhOEjM4b7lJO1QvU4MQolk/eDkXC2xcMAEdFFM5MfBST793VIjvTh7XbTeR2nqYY9z6N91cdOtyYTLN6Mxx7Milve5JSGdk4Nr7YpYElS+f38Esakm6X9VZ1UeN8B8KNkpQ5mJ5KtGsAHl2rNiY6rYQfS/vz6MbQA5hfilS2SfHC7X9YRQWikzkGYjQC1vIRzIgAozsyUcB5MKGYdHaa4cC4PVXMRLioTdiREbRNkohLDl+x4jbHtX9Xlyohlio5IjPwx+2/Mg1bUwZEe51M1W0wff6fVSRtaAv7YDAXHWK9Q3Mh7gTKCnzac5bkubBgXcM/LDoQR31z9vHtM4CVEI6CvHwRK8vJ57dHmgG/cLK6Ee37kPo58ZDiZbHu9aFUBxfELZrpDH2IAfNLF0Lm4nVxPxAnjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799009)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(2616005)(1076003)(26005)(16526019)(478600001)(6666004)(36860700001)(7696005)(426003)(336012)(83380400001)(47076005)(2906002)(70586007)(41300700001)(44832011)(70206006)(8936002)(4326008)(8676002)(54906003)(316002)(5660300002)(6916009)(82740400003)(356005)(81166007)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 03:23:35.2812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a568cc39-d033-4ed8-8dc1-08dbd9c0c452
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5669
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
Cc: yifan1.zhang@amd.com, Li Ma <li.ma@amd.com>, xiaojian.du@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

dorp fw version check and using max table size to init table.

Signed-off-by: Li Ma <li.ma@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c    | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 3efc6aed28f1..762b31455a0b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -234,24 +234,15 @@ static int vangogh_tables_init(struct smu_context *smu)
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_ACTIVITY_MONITOR_COEFF, sizeof(DpmActivityMonitorCoeffExt_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, max(sizeof(SmuMetrics_t), sizeof(SmuMetrics_legacy_t)),
+		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 
-	if (smu->smc_fw_if_version < 0x3) {
-		SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_legacy_t),
-				PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
-		smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_legacy_t), GFP_KERNEL);
-	} else {
-		SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
-				PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
-		smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t), GFP_KERNEL);
-	}
+	smu_table->metrics_table = kzalloc(max(sizeof(SmuMetrics_t), sizeof(SmuMetrics_legacy_t)), GFP_KERNEL);
 	if (!smu_table->metrics_table)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	if (smu->smc_fw_version >= 0x043F3E00)
-		smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_3);
-	else
-		smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_2);
+	smu_table->gpu_metrics_table_size = max(sizeof(struct gpu_metrics_v2_3), sizeof(struct gpu_metrics_v2_2));
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err1_out;
-- 
2.25.1

