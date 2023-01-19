Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B248C004D4
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jan 2023 13:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CB1C10E927;
	Thu, 19 Jan 2023 13:16:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2A8010E927
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jan 2023 13:16:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGcYufu0qRx7fZghbWQHiPzFd2JL0Af9ev7z3IJKRZuLB1JVzyYGw9QcOybPkIi+q4x+YhtV6CaWbWfiHkLJCoUv0JDgYTXLy9zoFIb8oykpNng1dzTRQPxkAM1G35OvoORDNXZ0LgIiNN9hwJuMk52l2RinUPxOkAAjU4WdXWzhCMTURLHNxXzNjDDXYtuNpm9Yg4HPvkuEdhwgzgVWCUsMtkDcRPbdy8yMxDrZDL+K9/AAHjBI033235h6Bm8Rk32C9jwRufNuqMR9BmDiEmCeXjp0YiBCX3aF2p20zvGvsIB67K5Zy9TPpVIVVk0LPHZUPH4NgxJWYzc3nNdI7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igdKXaTnasrcUS9lxs+Cw/oF1H13ityxOZk6pcf+6Ss=;
 b=X3ADXjnLsbsM5GMfo+K41lTIRPWihwHpVhJV9Al6dtRcBUzjYS9triPesAgi7md0NyCd5o0uWd1DxXFCvNAd75gziXqrAfhbWtkqH0Fq1sjUO3Z1iA3PatsV/1ppmiSqrUf+zM8R3zEcKlcutIiK1o6Vac3PC3bswPl8bEow/22+z/omaaLsVj/Rh9gTQHSavAluf4CNV03tRfzp44whPXZ/2/QnYiyt2rVO5OxJcbzqUn9WazA0li/4byDCZApmsCkB4q0fAKYym5bjPP5m0fdzlnbRhXuRY3ZND8FUZoky9ZbaMDxt1MFe2a1Wxm10UvvH43kUBSucLHkAoZm0Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igdKXaTnasrcUS9lxs+Cw/oF1H13ityxOZk6pcf+6Ss=;
 b=D36YIF1NgKEpoIHb+rWrfdQrwr3wRFw76Q2jWCnKUhr4sSqpFoeN+miNepiJhFZXOiAnWV5ieUR80RY6KxdID3Yf9hHnbCd4jhAVCSy+LT3R+5SpXJyDBxoJQyy9Psg6vOFrDSuAb6FHQhXhTeMmaY/x69Q+CcTwMTNYGgzrBt4=
Received: from MW4P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::11)
 by CH0PR12MB5186.namprd12.prod.outlook.com (2603:10b6:610:b9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 19 Jan
 2023 13:16:20 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::69) by MW4P220CA0006.outlook.office365.com
 (2603:10b6:303:115::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.26 via Frontend
 Transport; Thu, 19 Jan 2023 13:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Thu, 19 Jan 2023 13:16:19 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 07:16:17 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Allocate dummy table only if needed
Date: Thu, 19 Jan 2023 18:46:02 +0530
Message-ID: <20230119131602.1247923-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT011:EE_|CH0PR12MB5186:EE_
X-MS-Office365-Filtering-Correlation-Id: 929f311e-c66c-4ff9-2aaa-08dafa1f5a71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EjOsbzxT5mvxfHIZuVbJ8YOgJGIHIdBW8y8XvuLwWm88bve87aS853VQcPGgEUaoK71/vQ+BFWiT+J1Xiy3kQFShXPvaLQoY1JVO1KkTDW2P/LBMY/bKWy8bySWkP8Ge/l1XQC8dxR1KK4vlfmBYlpOpTpNfETmn5ihVwfSeAl4REACtfBWw2ZMCss2u5vHaX3snsA24ZtDewCASBTKg36mwoVWoHdgnZzEEJX0UU+ykGw1LoE0o8MODpHZb4GSxLTzvj5BHX5HvJ94RNvdvAoJx8WD9ykf0u/r6HdNII2PP0roskukfEa6nf4zsQZm8dUXcK0kiP6KEj0c4AS9MW3R/FY+CEElCfpUL9ZYc5xPIF4GFVhi7BdnhTdGaQNPL0Qh1cKUcqnsel8QNYEmFM10og8kRo2n4d8f7m90YcXBqbWeVM4uk+buu1feTca1LZKmQNkr/eaYp9j9OJhXsyTDCjkAK4bg18czS9InDgcjW4XcdsHt4lKO8tjlRANv7fUzRfcBs7h7R5IdOeXi/FBhq4ol6+0bICDe894iUPjiRL/5l0mlX/gUXeg8N+Q/C+gBkiluR+ZNOB0xTlao5TfUW0gpImqitWEGp8SR5gwHfTuh4SHk9mo5aT3l7FCWXdgSUMw/KtsjYIiKvji1eRAjPpntlTGqJ8ASbC2DNXBqazyBpCnyXyH8i8Q2ahaeTpIHsMgAF/+46CPQLIWT9umRwnmcGQucsRS+kXlJa/gI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(356005)(44832011)(2906002)(70586007)(8936002)(5660300002)(36860700001)(82740400003)(81166007)(70206006)(426003)(54906003)(6666004)(7696005)(316002)(86362001)(47076005)(478600001)(36756003)(82310400005)(41300700001)(40480700001)(8676002)(6916009)(4326008)(186003)(1076003)(16526019)(336012)(83380400001)(2616005)(26005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 13:16:19.3236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 929f311e-c66c-4ff9-2aaa-08dafa1f5a71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5186
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Only Navi1x requires dummy read workaround. Allocate the table in VRAM
only for Navi1x.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c       | 5 ++---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 6 ++++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ec52830dde24..612f62529575 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -904,9 +904,8 @@ static int smu_alloc_dummy_read_table(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	dummy_read_1_table->size = 0x40000;
-	dummy_read_1_table->align = PAGE_SIZE;
-	dummy_read_1_table->domain = AMDGPU_GEM_DOMAIN_VRAM;
+	if (!dummy_read_1_table->size)
+		return 0;
 
 	ret = amdgpu_bo_create_kernel(adev,
 				      dummy_read_1_table->size,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 0bcd4fe0ef17..95da6dd1cc65 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -494,6 +494,8 @@ static int navi10_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
+	struct smu_table *dummy_read_1_table =
+			&smu_table->dummy_read_1_table;
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_PPTABLE, sizeof(PPTable_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
@@ -513,6 +515,10 @@ static int navi10_tables_init(struct smu_context *smu)
 	SMU_TABLE_INIT(tables, SMU_TABLE_DRIVER_SMU_CONFIG, sizeof(DriverSmuConfig_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 
+	dummy_read_1_table->size = 0x40000;
+	dummy_read_1_table->align = PAGE_SIZE;
+	dummy_read_1_table->domain = AMDGPU_GEM_DOMAIN_VRAM;
+
 	smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_NV1X_t),
 					   GFP_KERNEL);
 	if (!smu_table->metrics_table)
-- 
2.25.1

