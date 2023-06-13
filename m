Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB38FEB64D7
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 23:20:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A42010E3EE;
	Tue, 13 Jun 2023 23:20:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3EA910E3EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 23:20:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UU/hpd77i+l4iHGjeBEBrpW2q9qNPxVbhNznaldDIGv0HtzPd45mLpQ2RXLc9KHRMN8klj/xnds6XnFeFMtpZPSQv9JxsJdoBtd4mkikblsr8mR1jSDqn3rvq3My3JWhB/9Cu8btG5WPsKhrYh5L1SPkMt3sjUNV8OBwUo0F9zofIO/1q2rKzBwUc9ajRc/0GqIKR9xD8NtJN02Z1Yf3yWLuT4e61usuK72BjEckKD67Wj7vkmZ+jIpJOELlV82iy0jtyFKb4MXTHS3tQnrK6DX6q417khztuF3bTSQDjuvI6jsCSShYsg4Op4ht4ZMu/qSUGOChiBsuRMqaHZ2Lug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsdrvJq8eTjMQlhiKZYUNitj9Y4IhCwsatHPccVuKd4=;
 b=JG1xstJpf7qhJGzgH/qXT11Vf/T0UDLQRJMiHZ51t8BHRFef6Rl7dlacZNvNg4tuxu6GjUuCuEe4Yt4WEqF/Truj5xhFJw5oCLpuScBiY/eDbKpX4Rf0dZDb7Ap3Opl5I2dqTjKWrf42co+fhqfmI6qFke/J6xoR3pXCwaEcTBbMI0njprjNiS7kVRrix1zelGDVGvVTquarYke+maSzJJbAHavZwx7TfLGpJT6J4YUyvmSzxSRM4Y9+6i7HvoIrOkPfv26yJleGoxD96Yv/nXsYP5Jx9nAHRBx3aqpBLKlWIRM7V1JonA7pSDUf373PYrthQRpsp+GttwJQtuFW9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsdrvJq8eTjMQlhiKZYUNitj9Y4IhCwsatHPccVuKd4=;
 b=cj2zgWdpsXICzLmo0B4jEAsJkrMTf6DooIf+niwEO151ieWEFH4QlgeGCeziriJ/nefmYJcgGoMDVkbm7NWGie35rCpRWXlmoymGaZrbCqkq2Nz2gr25A027tcgOCiu7XGXbJAbIDxBV/w6kT8zjrS1nGNqTWRzjkAmnIcq5PU4=
Received: from DM6PR17CA0004.namprd17.prod.outlook.com (2603:10b6:5:1b3::17)
 by CH3PR12MB8257.namprd12.prod.outlook.com (2603:10b6:610:121::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 23:20:43 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:1b3:cafe::6b) by DM6PR17CA0004.outlook.office365.com
 (2603:10b6:5:1b3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 23:20:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 23:20:43 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 18:20:41 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/pm: Align eccinfo table structure with smu v13_0_0
 interface
Date: Wed, 14 Jun 2023 07:20:29 +0800
Message-ID: <20230613232029.3499844-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|CH3PR12MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d89e9a8-f1e4-43df-868b-08db6c64cf43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0oi1OTYvdsENGUbyKY3hJCHnFBN74M+F1WGhHLN0mixfuCsrb38v6QW6ElvclUGl9GEdl94LXQ7BwqPZNzHe9TB9u7ZnUBtIKk2W8VQhIpnfnaO//BfddP8U54Su2tUHfHoYhPZiKZZRxijtlLRoPYyLZ4AMdAPCZKO9T7mvfwT5nHW+OZQxvEgMbvcM0EJX0/VTToLBhxGDJhhJWplvRQZRF8jcl1BdYXK7+hALADOoQ3FX1clGumFOvoBA4/9iKJb2/mpyg61w0oB7KlOn9Bpy+3UyULJLU7IS5CnPZDUXTaKa+6OgmXVbC+nT9FRbX8qTbJEY2n1Wd7p+ufw3NfdBBlVamzJ349s2AlpYZgIesiVXGe6n+6qC+2+8h2ADOvoExghLfGETvPs6sFWkEIJK7I1IXVhR+9z0DF9XigK8P+hHteqUOjDnq6EB0461Bq7E35p5fPi7tOOmYybyXWtKEW5E1i17gyAZ8n6rMV4c1RcFvO46ZKiuTwX6Dtjf44EKhODp4nH/bfQq+NFKRBxMQ5RT8t293hZ5QwarKY9p2iM8WTNvsSQJyeXgJOtBDWWOJrNonotRxCMKczfeltOxOyg1yGPNjBvvT1/DbI2gIq2ym+qe4R+fRsbVYu272qxd1ITAfa0OS3OUVNxhyEZNZuuNt+PBEZSF+9R3H3FdFdoKektukz+mtJIx4ANQB7vHp6xVCCs7KIXjRmkijsAoJp///xj/06ym4MC16WqG7iJaMPsZ6HvcFmgCu1kW99hZiQ46tphFkYGrbL5TQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(54906003)(2906002)(36756003)(426003)(82310400005)(40460700003)(5660300002)(336012)(44832011)(2616005)(7696005)(40480700001)(86362001)(6666004)(478600001)(41300700001)(47076005)(356005)(26005)(82740400003)(6916009)(316002)(4326008)(70586007)(70206006)(81166007)(1076003)(36860700001)(8676002)(16526019)(186003)(83380400001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 23:20:43.1801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d89e9a8-f1e4-43df-868b-08db6c64cf43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8257
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update eccinfo table structure according to smu v13_0_0 interface.

v2: Calculate array size instead of using macro definition.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 413e592f0ed611..cbf0b2d738c1a6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -46,7 +46,6 @@
 #include "asic_reg/mp/mp_13_0_0_sh_mask.h"
 #include "smu_cmn.h"
 #include "amdgpu_ras.h"
-#include "umc_v8_10.h"
 
 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -2580,7 +2579,7 @@ static ssize_t smu_v13_0_0_get_ecc_info(struct smu_context *smu,
 
 	ecc_table = (EccInfoTable_t *)smu_table->ecc_table;
 
-	for (i = 0; i < UMC_V8_10_TOTAL_CHANNEL_NUM(adev); i++) {
+	for (i = 0; i < ARRAY_SIZE(ecc_table->EccInfo); i++) {
 		ecc_info_per_channel = &(eccinfo->ecc[i]);
 		ecc_info_per_channel->ce_count_lo_chip =
 				ecc_table->EccInfo[i].ce_count_lo_chip;
-- 
2.25.1

