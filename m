Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A464CA5520
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 09:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 114E810E491;
	Wed, 13 Sep 2023 09:32:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E13E10E491
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 09:32:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGfflzpaAYZ5ASuS1rig4BimEXDB5WtLhcVtVpbNCcn18rFLRuK9esu8uEb32fNmDvbGZXY3wbadqK0jjJKxs9waTDKbvQRTFUUhhFmubvVZE66uzGtKAuRIb+POXz9II+FEZ7qrBa377ipSCVzUfKWMkyBeixlwvW9URUTsJHRP/XL6AqIK62Hgkpw8ZTHerfk1yqAR1AnVkoHrSlar2TLLvQ1L3Y+HWpuFfd4KcR2OeblyTDGavwL2oyup5RiA0yWweQmCzMifJWOt7YH/irVMrZfojK27Cf0UZiBnD6rRXmfGutvW7GytBdfF+3LQ97zXs44Lq3kR2UIN4HWbhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuRdDJryr6rbh7/KdwQXOZIKLk7UQdxdPqP0BtsBraI=;
 b=fNmXhYAyD0QnMecs089SOsLeSJqcWg5+XvwwQkCzqM1GOj9qr0J1Q4MrATA2+pY6aX4oiobDpmi6VR96JE2+GCmAWQ2eLsTIdR0HZb7zbVjR/u3KwCpyYFPcmlVYtFyh7Oq3ldzRDwMPF/JvNX7ohr3E1YKQ9eudSdM3wUFDk2gPtQMVBLrsaU2gDzDaaRFv/ksSNvxVcwjbFabXb4X90SH0SDiMa157i4jaunG5kj7rysg7uARTZu3CgIgMAdRWYx4VaxyghYo/2ZJd/D2ZQEuo9lTQ8S1vtd3SLWffe5AyJuA2TrqY5DR9fk1MITAvSBb+AHSXH8g3LRen4cvK2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuRdDJryr6rbh7/KdwQXOZIKLk7UQdxdPqP0BtsBraI=;
 b=2bG3BgIOqoIhesK+uCj6FOJpO531hLCrz9iWaYhX107miFCzIsxJNirI9eS7og6XwWcQkv5gi8wPEEH5YgsWkVQobNaBKNs3XQaDINc2Hto7gwJHYf7dyButyKU9rEIGOD37HGavu+gb+oSDJSlG5WxOFnByEr4Ad2aU4fxecY4=
Received: from DM6PR07CA0095.namprd07.prod.outlook.com (2603:10b6:5:337::28)
 by CH0PR12MB5267.namprd12.prod.outlook.com (2603:10b6:610:d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 09:32:19 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::4f) by DM6PR07CA0095.outlook.office365.com
 (2603:10b6:5:337::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Wed, 13 Sep 2023 09:32:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 13 Sep 2023 09:32:18 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 04:32:16 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amd/pm: update smu_v13_0_6 ppsmc header
Date: Wed, 13 Sep 2023 17:31:59 +0800
Message-ID: <20230913093200.312429-3-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913093200.312429-1-kevinyang.wang@amd.com>
References: <20230913093200.312429-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|CH0PR12MB5267:EE_
X-MS-Office365-Filtering-Correlation-Id: 741c977d-e947-4949-3c0c-08dbb43c531c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EZH20roICTGLoA6nrupatwhUM81MssYOVwyD5G1WNai1WuZZZwxbpTatOO/C5cWdzhiIymnwfI4r3nYgvrgMAJENztL9GDOBMDVIiOud91r4liH7W0ZCAoDl07JDrLs2DXbqPaXwKS3VaLbhb6f+xttHJLQW2AWRpqVZMIPahQONw+E5v3qoE59mu8oElPqzJfs6PPvO19GhKwJgVjZkyaeHgJNeFr2LUaD7aJJyfN86sDTEVaMFemfo5yoidCRUKKFFLFhQ8Gg+2s2yQTsou8uBWjHoylNwKEuktTOx2UUsnEYHE9IGt3fEebz/KKaE8at3fYu90wIDfNja9+spNc7Z8ruOz/lPZgeakUUfAzjxeB24x9JCmmQjrRQ0HtMuozthPXH71vjYgCKiuKA3yxGiM9b2+K/BS8uVZZa5jkuXcFj9NRSkQlDKbypOwkSskhiOiqPff78l8krqapUdTD6FkRvT1g7qSfLUO2bD+MWIusZsfpKyUdo8/yXW2C9OxOubre8S9pK152GjxaE6xHtObr8M2rBfk/uz1/YrYwhrWCd/DyxEjlfrCvwMFbPn2ima7Sh+szA5W7Ud2+Sl/SR5pFdweFXb5cFwLtYToynwE7/b84nFLqUsHh4muTjzscmVVhDAVlFJV8NJxQLmnJ73TK3htN9wAw9TKyT6jdNoINaw1/fJegLSOAbsKtX8jdWpoDD0fRlIu9soCbd58Fv3/nlZqS466bjakyTYa1BN63CI1T2YrKbx9VUW1qhw36uztAIdS7XkwX2ArgJ/zQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(82310400011)(186009)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(6666004)(7696005)(478600001)(83380400001)(1076003)(16526019)(26005)(2616005)(66574015)(426003)(336012)(15650500001)(2906002)(4326008)(6916009)(54906003)(70586007)(70206006)(316002)(5660300002)(41300700001)(8676002)(8936002)(47076005)(40460700003)(40480700001)(36860700001)(86362001)(36756003)(82740400003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 09:32:18.7672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 741c977d-e947-4949-3c0c-08dbb43c531c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5267
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
Cc: alexander.deucher@amd.com, Yang Wang <kevinyang.wang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

update smu header to support mca dump interface.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../inc/pmfw_if/smu13_driver_if_v13_0_6.h     | 88 +++++++++++++++++++
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h  |  4 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  6 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  4 +
 4 files changed, 100 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
index d0833887c355..ced348d2e8bb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
@@ -65,6 +65,94 @@ typedef enum {
 #define CMDCONFIG_RESTART_MASK        (1 << CMDCONFIG_RESTART_BIT)
 #define CMDCONFIG_READWRITE_MASK      (1 << CMDCONFIG_READWRITE_BIT)
 
+typedef enum {
+  // MMHUB
+  CODE_DAGB0,
+  CODE_EA0 = 5,
+  CODE_UTCL2_ROUTER = 10,
+  CODE_VML2,
+  CODE_VML2_WALKER,
+  CODE_MMCANE,
+
+  // VCN
+  // VCN VCPU
+  CODE_VIDD,
+  CODE_VIDV,
+  // VCN JPEG
+  CODE_JPEG0S,
+  CODE_JPEG0D,
+  CODE_JPEG1S,
+  CODE_JPEG1D,
+  CODE_JPEG2S,
+  CODE_JPEG2D,
+  CODE_JPEG3S,
+  CODE_JPEG3D,
+  CODE_JPEG4S,
+  CODE_JPEG4D,
+  CODE_JPEG5S,
+  CODE_JPEG5D,
+  CODE_JPEG6S,
+  CODE_JPEG6D,
+  CODE_JPEG7S,
+  CODE_JPEG7D,
+  // VCN MMSCH
+  CODE_MMSCHD,
+
+  // SDMA
+  CODE_SDMA0,
+  CODE_SDMA1,
+  CODE_SDMA2,
+  CODE_SDMA3,
+
+  // SOC
+  CODE_HDP,
+  CODE_ATHUB,
+  CODE_IH,
+  CODE_XHUB_POISON,
+  CODE_SMN_SLVERR = 40,
+  CODE_WDT,
+
+  CODE_UNKNOWN = 42,
+  CODE_COUNT,
+} ERR_CODE_e;
+
+typedef enum {
+  // SH POISON FED
+  SH_FED_CODE,
+  // GCEA Pin UE_ERR regs
+  GCEA_CODE,
+  SQ_CODE,
+  LDS_CODE,
+  GDS_CODE,
+  SP0_CODE,
+  SP1_CODE,
+  TCC_CODE,
+  TCA_CODE,
+  TCX_CODE,
+  CPC_CODE,
+  CPF_CODE,
+  CPG_CODE,
+  SPI_CODE,
+  RLC_CODE,
+  // GCEA Pin, UE_EDC regs
+  SQC_CODE,
+  TA_CODE,
+  TD_CODE,
+  TCP_CODE,
+  TCI_CODE,
+  // GC Router
+  GC_ROUTER_CODE,
+  VML2_CODE,
+  VML2_WALKER_CODE,
+  ATCL2_CODE,
+  GC_CANE_CODE,
+
+  // SOC error codes 40-42 are common with ERR_CODE_e
+  MP5_CODE_SMN_SLVERR = 40,
+  MP5_CODE_UNKNOWN = 42,
+} GC_ERROR_CODE_e;
+
+
 typedef struct {
   uint8_t ReadWriteData;  //Return data for read. Data to send for write
   uint8_t CmdConfig; //Includes whether associated command should have a stop or restart command, and is a read or write
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 4ac4f2dcc203..021dcbe58473 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -88,7 +88,9 @@
 #define PPSMC_MSG_McaBankDumpDW                     0x37
 #define PPSMC_MSG_GetCTFLimit                       0x38
 #define PPSMC_MSG_ClearMcaOnRead                    0x39
-#define PPSMC_Message_Count                         0x40
+#define PPSMC_MSG_QueryValidMcaCeCount              0x3A
+#define PPSMC_MSG_McaBankCeDumpDW                   0x3B
+#define PPSMC_Message_Count                         0x41
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index f762c01b98a5..7c300b4d95c7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -248,7 +248,11 @@
 	__SMU_DUMMY_MAP(RequestI2cTransaction), \
 	__SMU_DUMMY_MAP(GetMetricsTable), \
 	__SMU_DUMMY_MAP(DALNotPresent), \
-	__SMU_DUMMY_MAP(ClearMcaOnRead),
+	__SMU_DUMMY_MAP(ClearMcaOnRead),	\
+	__SMU_DUMMY_MAP(QueryValidMcaCount),	\
+	__SMU_DUMMY_MAP(QueryValidMcaCeCount),	\
+	__SMU_DUMMY_MAP(McaBankDumpDW),		\
+	__SMU_DUMMY_MAP(McaBankCeDumpDW),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index c2308783053c..6be8299494ea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -134,6 +134,10 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(PrepareMp1ForUnload,                 PPSMC_MSG_PrepareForDriverUnload,          0),
 	MSG_MAP(GetCTFLimit,                         PPSMC_MSG_GetCTFLimit,                     0),
 	MSG_MAP(ClearMcaOnRead,	                     PPSMC_MSG_ClearMcaOnRead,                  0),
+	MSG_MAP(QueryValidMcaCount,                  PPSMC_MSG_QueryValidMcaCount,              0),
+	MSG_MAP(QueryValidMcaCeCount,                PPSMC_MSG_QueryValidMcaCeCount,            0),
+	MSG_MAP(McaBankDumpDW,                       PPSMC_MSG_McaBankDumpDW,                   0),
+	MSG_MAP(McaBankCeDumpDW,                     PPSMC_MSG_McaBankCeDumpDW,                 0),
 };
 
 static const struct cmn2asic_mapping smu_v13_0_6_clk_map[SMU_CLK_COUNT] = {
-- 
2.34.1

