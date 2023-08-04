Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FE0C001DF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Aug 2023 14:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 888C010E0AE;
	Fri,  4 Aug 2023 14:33:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A99FA10E0B4
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Aug 2023 14:33:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mI0VOZl39qXqUNAWFs5dOUWQPwfe8LsKy+dsorSWHS9nVEeOhWCUOtEGtc/e9fZ2TFf/zxNgeKGdHyembocS1kngWYHGukvBrkDvJbrSGpW5M1YEXMPrquSqeOCfHV91K/5F6wk/MjgIXt/PZH7E/y2EcLGAVeALzNGJpvGOV/wGJre09xUVV89qw34D2FYuwleC2RV1zWdduWB1i9n0R/tUWo9zxTg2wY2HTrbKQGE8pAafR++lLI78yMcPeAxrRTt7njyF5r7KBkrh0GqOobB1c8dJoXIaP6Q03a/Bb9yMwRzKPgKWKNR5kt+w2pIF6QBKrRWwC8sB6ddnj1GRAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FU3QdP3ugy4vM8dBSSGDii2gL3w7VSpLumqo6RVuhGM=;
 b=MUZcHXV17rakyeNF2QXU4ye7cfoy2A/NX0AFp/SEHAhDnkoIITi7JBSCAAX++ijRNa49BtPDj+GTVrqNSKhjo81Pn+IkbUVvuPum5mdSO+01OVmFuWNP30ZreNMSoSWOPrcdFCuvMxakQHskgOupl+y8dg+xKUqA169XElKzBjvL7xfu6HpRLOmOyQkHnzDZX2cLgbw1BhB3X9/jrBTiUki8NI6/DW4y5runnmfPrOUnVP5YtNSBa822wP+u1bc0eTWJq70+3FVs3PdLhShJ/IGT3+PI/TA9OXE4aMrM2Fdia42IN3Lk8EKItR/1+h53FAV16eu1aOGNLsOlLFEtsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FU3QdP3ugy4vM8dBSSGDii2gL3w7VSpLumqo6RVuhGM=;
 b=pOjtlVGuOOW2YkqfcnrPevY/cV1614BxrvogJilVlCzdpEoQl0m2K2NaQrgJvPiM39PIHm+kF4RXT5HIOp582a/x60mttfWd9JNcz/lU99D+YcCjti6VNTU2JwgEybjfUOt7J/Awn4ZLKJKWQ1dS9xZEuikfy6IfEzF/iULQ3hI=
Received: from DM6PR07CA0075.namprd07.prod.outlook.com (2603:10b6:5:337::8) by
 CH3PR12MB7620.namprd12.prod.outlook.com (2603:10b6:610:150::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.20; Fri, 4 Aug 2023 14:33:14 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::7e) by DM6PR07CA0075.outlook.office365.com
 (2603:10b6:5:337::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 14:33:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 14:33:14 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 09:33:12 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: avoid driver getting empty metrics table for the
 first time
Date: Fri, 4 Aug 2023 22:32:58 +0800
Message-ID: <20230804143258.1992824-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|CH3PR12MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: 411f2839-f0be-4b88-7048-08db94f7bcb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7eb+ReEMFJCzZLrVH1Iu2IgfbRNSxZ0OzS9OE9UdvovYZ3+CNWv77K1h+BA3ILRYpeF/DWeqEnCcvq0EHQy5E3v+YQXUFgtDatclBg4W+uS2uUJQz56E7TqTpnAL3uCTNDtHxmpgOCXG/5n5JctsjLDe7AXnWHrGK5JnQrDfCHx29KlZy5719BE7ODSvSns+nCVDHx7vMRxERZpF30Rn8rvTyFXmT7mAth0xPY3GZecaiq5DG6nmYDKYj3s7Z7ibTLU2M85QlwIcn6vFYyMrO/TdUnXomg9VcuHHSJq8JSXKKtIWtwKm6n2ERqUWYrZ7vK5yz268+rkuJV9eTiSoR/K3WtT8wC4xNxoDbF1eyF3ABHaf/6lp36THTVP9TKYPFEuBSIaPkLZFLFhjGD/lz8eKfIOO/ixKbMRPX9Q6zRiVvHbIbAl1gx1Ym9D5DEy66cSn2G8kl9SK6CWQLb0LSyfdaEZbMLaCugpgiuALHb+JtlO5Fprbxspif5FwG45AINegnv/lx6DtANOKfMc1xFJkNCfyZsSb+NWfAb9Bek6GaeB2cgTBR4WbkAORm1+XL0//Wy630/RfxIB70r9VQmgYrUgbbkdNfvPsLlMhOBxGZbID8soPbj2yo3klZMHS5owRl2nNxhnQWbiQ5ffOzAXfk+K58VA89e1LS5TFj6tJdtNjVuKY3tmILqx7h7qLJ9X1oKI8NSbeXDe6Ve7DfQCN2WQOre4mXZ91qD97tXA6x9tJ+CzvQC0AR+ek18TJvRTUvZcr4kOgrUFk1mYL6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(82310400008)(1800799003)(186006)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(4326008)(82740400003)(6916009)(70206006)(316002)(83380400001)(70586007)(7696005)(54906003)(6666004)(356005)(81166007)(478600001)(41300700001)(40480700001)(5660300002)(36860700001)(36756003)(8676002)(86362001)(8936002)(2616005)(426003)(47076005)(336012)(1076003)(26005)(16526019)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 14:33:14.5763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 411f2839-f0be-4b88-7048-08db94f7bcb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7620
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
Cc: Asad Kamal <asad.kamal@amd.com>, Yang Wang <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yang Wang <KevinYang.Wang@amd.com>

add metrics.AccumulationCouter check to avoid driver getting an empty
metrics data since metrics table not updated completely in pmfw side.

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Tested-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 6253ad13833c..5adc6b92bc49 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -325,14 +325,24 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 	MetricsTable_t *metrics = (MetricsTable_t *)smu_table->metrics_table;
 	struct PPTable_t *pptable =
 		(struct PPTable_t *)smu_table->driver_pptable;
-	int ret;
-	int i;
+	int ret, i, retry = 100;
 
 	/* Store one-time values in driver PPTable */
 	if (!pptable->Init) {
-		ret = smu_v13_0_6_get_metrics_table(smu, NULL, false);
-		if (ret)
-			return ret;
+		while (retry--) {
+			ret = smu_v13_0_6_get_metrics_table(smu, NULL, true);
+			if (ret)
+				return ret;
+
+			/* Ensure that metrics have been updated */
+			if (metrics->AccumulationCounter)
+				break;
+
+			msleep(1);
+		}
+
+		if (!retry)
+			return -ETIME;
 
 		pptable->MaxSocketPowerLimit =
 			SMUQ10_TO_UINT(metrics->MaxSocketPowerLimit);
-- 
2.34.1

