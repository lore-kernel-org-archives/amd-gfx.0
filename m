Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B8DEE57E2
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 08:39:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A09B10E882;
	Fri,  8 Sep 2023 08:39:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A74D10E882
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 08:39:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d98TqYN0tqAZDPj1pUookZf5FPutqyQFRF3y2YEs7sI7uGdFoNWpFxHFAJg5VXhUyweIakS0lMfml5ZnizQVsrSu5LQ6RBhQNX41/lFWEXl27uLMncSGkSwIc/9aNJoomtM3oidX5rruBKL0qL/6shfa2spipmSe5Gs8yGGJoXNzlOYBuJmA1NY6rq8ggMGVwyDjnd4BQ+3vuZrLq1V6RT+NHO7rEmCPNpDnMTKowasjsnnT4aTDoJjL+JbjeM7HZwikouc8oKE7YwFSy33/d1o099J0dCKqanrHMTvNMLp7pHA969lXzLekFEBVlLFeQR7hjZEatK7FQwjAn/DJZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zX062Crg+d2TXSXOALhCfX0/LHSZ3g9/ZnS0Kb6QNh0=;
 b=ZBtGzs1CBxGoUv6QPtf/S5/ivb1am4rmWMsjxj8FcujXv1x2V2CLOwV5/fFKbcHbjkAcQlaALur8fQh/dMqXW21axUQjYMJEiczy0UzgNtgR0UPXr1DL+GhmQMuuUxCYLcVAtgIdk+CtU78Dk4sJAP4VmS2hLbDMJTI2bseZihiGEOUyYN8EHjeb1mMlHMDiQlrVZyjODQDi6h5NL6AaWekws86b4y2VtFa0+rrEWmj/Y3Bru7ip2CBXiyEN3QsUL3eGtCyvwCxNzl6Gy9OiANAbjwamvrZVPtv69XPF+xyxdA5xfCIQmNim7Xdg/BMrozyRmMeYxNlxSc0ICnER1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zX062Crg+d2TXSXOALhCfX0/LHSZ3g9/ZnS0Kb6QNh0=;
 b=vGue2jWVFHD0BMFKvgsz8JJd2W3BkW1o37wObdSU68S8/W583w28xmyMweCLU30AWpnTKwZn9KYeQi5v5GhO9JSs20jndVNz3QWQ2R5A5BIStAx0I2tg5SiVOPt7r3CftQgEaHBeqP+7fx3md5VFuhEPYxy8vJBdFLqF29IEwb4=
Received: from MW4PR04CA0363.namprd04.prod.outlook.com (2603:10b6:303:81::8)
 by DM4PR12MB6639.namprd12.prod.outlook.com (2603:10b6:8:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 08:39:20 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::af) by MW4PR04CA0363.outlook.office365.com
 (2603:10b6:303:81::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Fri, 8 Sep 2023 08:39:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Fri, 8 Sep 2023 08:39:20 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 03:39:18 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amd/pm: update smu_v13_0_6 smu header
Date: Fri, 8 Sep 2023 16:39:03 +0800
Message-ID: <20230908083904.2509460-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DM4PR12MB6639:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d1022c-9c38-4822-0ebe-08dbb04718b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hf0A3YhdQMsEyKS+kJo58jH93K0MWo56zJ+qt0FEmWFU+yGQ1ohmCCAZI6YysvJTtOVeVmD00uCcL1ZzbPMlYff1VCuXaDu/eNQBvIk/Vindc6GNKtWo94uvARUpo81fGOkD8SPzrXjIx58TmPzE9Fyx5WINMYBa95vqNmnxcu2rREY1wjHWoLRDz6Oljt3RzVqdzQJZj8ygN5aPBNhYck+PAHgc/pnecGCMVD5mZEbe6e8S17XzxcvgIvNOZmXXL9oQ7Ief9F3NcwrRkbe7wE3ijTU/ykxpQqewO06QDCIyXyDWrcYwf72/u8TsNB8mguq0fYfFl7ETJsCXMSUCgreV5RY7TrZ75eyBEzEr+bSIY2O90bROIYV6qL9RTAdDGkqlL+jP3cgiLSiFEFV7vcXPLmFnD7tT2SAvKVt6hcpScxax2XrQzogSBbO+1RRPDfDCmUGYR+8dkRIclmpQ/muBlNlb2/ZMUPRWuAJOdj7VesiqhlDnDI1TnMG8KYc/4+jRV0X5DdFAGxaf+1wxcyjN5zLbi2Atfg4zOMBoSM96cjZejnL/CJ/OeY5rplKnvAmoOKQLEvoq9buQSP9tnEKbSWlhWxhZOBVnwLa7cDz6/MornynsKu1njmNLu9fQyPRL6W1CU4itO5QCbcMQvbG1NCbQN3UBr+IwLvtuAkw6iqX+PsZ7TKhX+NljESusHs1RZg1ygkC3xv7L3NGK8/HRXLUxay+RHoARb6fzA7MjqcfXs36KW5o5/dZMOK7ZA90Gm2u4tQTFpce0cDEPIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(1800799009)(186009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(7696005)(41300700001)(40460700003)(316002)(356005)(81166007)(82740400003)(36756003)(2906002)(478600001)(19627235002)(86362001)(70206006)(54906003)(6916009)(70586007)(6666004)(15650500001)(40480700001)(2616005)(83380400001)(5660300002)(1076003)(8676002)(47076005)(8936002)(4326008)(16526019)(26005)(426003)(336012)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 08:39:20.5442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d1022c-9c38-4822-0ebe-08dbb04718b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6639
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
Cc: Yang Wang <kevinyang.wang@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

update smu firmware header to support smu mca debug feature.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h | 3 +++
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h   | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
index ca4a5e99ccd1..d0833887c355 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
@@ -132,6 +132,9 @@ typedef struct {
 #define THROTTLER_THERMAL_VR_BIT        3//VRHOT
 #define THROTTLER_THERMAL_HBM_BIT       4
 
+#define ClearMcaOnRead_UE_FLAG_MASK              0x1
+#define ClearMcaOnRead_CE_POLL_MASK              0x2
+
 // These defines are used with the following messages:
 // SMC_MSG_TransferTableDram2Smu
 // SMC_MSG_TransferTableSmu2Dram
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 70a4a717fd3f..4ac4f2dcc203 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -87,7 +87,8 @@
 #define PPSMC_MSG_QueryValidMcaCount                0x36
 #define PPSMC_MSG_McaBankDumpDW                     0x37
 #define PPSMC_MSG_GetCTFLimit                       0x38
-#define PPSMC_Message_Count                         0x39
+#define PPSMC_MSG_ClearMcaOnRead                    0x39
+#define PPSMC_Message_Count                         0x40
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
-- 
2.34.1

