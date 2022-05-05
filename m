Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992E0C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 20:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24A4510E450;
	Thu,  5 May 2022 20:06:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04B1B10E450
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 20:06:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKy6E2o0cp1S4NY6blFudyil6+GM3kdFN3R0C7LPlXRy8dkqfSbcFqcuRstzu6X6K3HV4kj93FmrarQE2Pbk9MXVIgnBuLnFi4HoBPpJlzbqAQkINfcLjtEKetf2XETyM7GOwTRU1Sa/WrQdHNgf3qV7+7PEBPPGJjZ/KbHpZjbt65nIEeHsmlaIDzCH/Yv1G8k2DCjFYYGx9gJbKePkuG1WpFx5YojZHTdjW/euIvbtSZNYdtLin4K+iU3LmyVhB/EJgSmif8940nsZ87rpz12gyey0eTD2KLQb2uZcbwbMBs2QTp/kFe4piSAwvCyVrEecODsNrc2xVzsUUz7vjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtaVoSwNv8IlZK+KChXwXbXuqAKfEaDeaUDtRPKFBWk=;
 b=eERD1T8NMebHjhB20/+I2mCBG8D4x+XVHuz2vXJ6S3FQPGbgWMazTUhIN91LQaC/X4CSmIo5TRWCpUCMht7F4PFkOhK3gzQMCs7d4jdfv7RByXhYNgP27eCX5KMcPS5itpijtc8u3757eRjVEV6ex7aJUbYBSHpL9NiLJKEht4eZ2cGkMdHL2cACKPOw5CiPmSxcVV0XEZVAsIC5Q1K5qSojErHc7o8A5I9vUqJKM+mx33WzpJ95Hi3Mb3k/qGA4/H54nbkxxnPvnp6lTUtB1XWXY0TsIZtTUny2yb3H+fMS6aI6zZA3oE7b/LCyssft5oiNrhychsg7B5mmUhSq6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtaVoSwNv8IlZK+KChXwXbXuqAKfEaDeaUDtRPKFBWk=;
 b=TO0oEjI0+n2hUt7T6IBY/iddkhLzHegG7Ao7eBYz94esVkbh2FEDVDFQqTsIHKTwRj/axk0E+Ib9x6UQuKvwXLOmwCFJrEYPPF9mWijrEmpNJ5967okc0+A4DiVOzCnt9NqCfH/T8ONd78LzKmFdqA9z48+TnkmQD+IRYH+FHn8=
Received: from DS7PR03CA0063.namprd03.prod.outlook.com (2603:10b6:5:3bb::8) by
 BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 20:06:03 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::bc) by DS7PR03CA0063.outlook.office365.com
 (2603:10b6:5:3bb::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Thu, 5 May 2022 20:06:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 20:06:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 15:06:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amd/psp: Add C2P registers to mp_13_0_2 header
Date: Thu, 5 May 2022 16:05:35 -0400
Message-ID: <20220505200538.1293584-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38ec0c91-eed6-4627-80d2-08da2ed2ae8c
X-MS-TrafficTypeDiagnostic: BN9PR12MB5356:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB535666821B482A29FCE8EA1EF7C29@BN9PR12MB5356.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+UPixPc+0ka0g2jfFQ3/PGk54OYF9b7uqUdThOTb80BdHP/62wQ7DphZEmLcGOsDG8cS5gKo9ytnqZ17jbp15T1gFpwGDn7bP/U/uurZRhsMoikaUsQUprtNegcLLuQ5M8e2ou2oK2fz9zPhucik+XjlXChAmhPJYXzNGuQr10pGemlg1xaQEnv9ihH9FdMcKXhDhdxWnAFYAK4NRYAFYiSgJ+GZwSMAsG/8N8+VGR82pcbq3y6TJXYBkENZWEMZWgz8rL+mkGP1+qjMLg0XYjUwKqe4gkvhr3lOQR8FUkdObS2GJiXKr0ydFzy51fDC3EmshPPkx4sZERpM6lne3xbTZ5jzzLDbJY+EN0ETBEZPvyd9moXCl/7xBT5kouVyb/0C8cGYbPCJ45/mGYHFcPOuHqrmtHB17uUxG8AcU1aGtlpc6+KHes4mkbeTtCOjwtLH1GVMFSrYo6Cf2XmsF2JGsOSN4zQj9R13GJt/BnAmUk/KfHLpZAaaIKJAhDPAktnzCipi4DhvTSDgKQL2p7ktDau7x3o4H8RPMWg1GcAiMu8ROjl11/orYHYOgulq8+h3mV/WJ8Oe0gvBs32doa43rrn5KKLo+9W6ZwdqWm+BJ2MYgzZdDe+il9A+596Q0xN69gkaYyL+aSJbh5StE06GVLBuZQIUzfnM8InZUF55j9Fa4Z1dQDgM1S7F7IVracupBJ5YtaKCXHufSw2JQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(356005)(40460700003)(6666004)(6916009)(2906002)(508600001)(316002)(5660300002)(86362001)(36756003)(81166007)(82310400005)(36860700001)(47076005)(2616005)(16526019)(186003)(336012)(426003)(7696005)(26005)(8936002)(4326008)(70586007)(70206006)(8676002)(1076003)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 20:06:03.1550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ec0c91-eed6-4627-80d2-08da2ed2ae8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5356
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../include/asic_reg/mp/mp_13_0_2_offset.h    | 48 +++++++++++++
 .../include/asic_reg/mp/mp_13_0_2_sh_mask.h   | 72 +++++++++++++++++++
 2 files changed, 120 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_2_offset.h b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_2_offset.h
index 0b1e781fed7e..f6c0e2d2cee3 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_2_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_2_offset.h
@@ -172,6 +172,54 @@
 #define regMP0_SMN_C2PMSG_102_BASE_IDX                                                                  0
 #define regMP0_SMN_C2PMSG_103                                                                           0x00a7
 #define regMP0_SMN_C2PMSG_103_BASE_IDX                                                                  0
+#define regMP0_SMN_C2PMSG_104                                                                           0x00a8
+#define regMP0_SMN_C2PMSG_104_BASE_IDX                                                                  0
+#define regMP0_SMN_C2PMSG_105                                                                           0x00a9
+#define regMP0_SMN_C2PMSG_105_BASE_IDX                                                                  0
+#define regMP0_SMN_C2PMSG_106                                                                           0x00aa
+#define regMP0_SMN_C2PMSG_106_BASE_IDX                                                                  0
+#define regMP0_SMN_C2PMSG_107                                                                           0x00ab
+#define regMP0_SMN_C2PMSG_107_BASE_IDX                                                                  0
+#define regMP0_SMN_C2PMSG_108                                                                           0x00ac
+#define regMP0_SMN_C2PMSG_108_BASE_IDX                                                                  0
+#define regMP0_SMN_C2PMSG_109                                                                           0x00ad
+#define regMP0_SMN_C2PMSG_109_BASE_IDX                                                                  0
+#define regMP0_SMN_C2PMSG_110                                                                           0x00ae
+#define regMP0_SMN_C2PMSG_110_BASE_IDX                                                                  0
+#define regMP0_SMN_C2PMSG_111                                                                           0x00af
+#define regMP0_SMN_C2PMSG_111_BASE_IDX                                                                  0
+#define regMP0_SMN_C2PMSG_112                                                                           0x00b0
+#define regMP0_SMN_C2PMSG_112_BASE_IDX                                                                  0
+#define regMP0_SMN_C2PMSG_113                                                                           0x00b1
+#define regMP0_SMN_C2PMSG_113_BASE_IDX                                                                  0
+#define regMP0_SMN_C2PMSG_114                                                                           0x00b2
+#define regMP0_SMN_C2PMSG_114_BASE_IDX                                                                  0
+#define regMP0_SMN_C2PMSG_115                                                                           0x00b3
+#define regMP0_SMN_C2PMSG_115_BASE_IDX                                                                  0
+#define regMP0_SMN_C2PMSG_116                                                                           0x00b4
+#define regMP0_SMN_C2PMSG_116_BASE_IDX                                                                  0
+#define regMP0_SMN_C2PMSG_117                                                                           0x00b5
+#define regMP0_SMN_C2PMSG_117_BASE_IDX                                                                  0
+#define regMP0_SMN_C2PMSG_118                                                                           0x00b6
+#define regMP0_SMN_C2PMSG_118_BASE_IDX                                                                  0
+#define regMP0_SMN_C2PMSG_119                                                                           0x00b7
+#define regMP0_SMN_C2PMSG_119_BASE_IDX                                                                  0
+#define regMP0_SMN_C2PMSG_120                                                                           0x00b8
+#define regMP0_SMN_C2PMSG_120_BASE_IDX                                                                  0
+#define regMP0_SMN_C2PMSG_121                                                                           0x00b9
+#define regMP0_SMN_C2PMSG_121_BASE_IDX                                                                  0
+#define regMP0_SMN_C2PMSG_122                                                                           0x00ba
+#define regMP0_SMN_C2PMSG_122_BASE_IDX                                                                  0
+#define regMP0_SMN_C2PMSG_123                                                                           0x00bb
+#define regMP0_SMN_C2PMSG_123_BASE_IDX                                                                  0
+#define regMP0_SMN_C2PMSG_124                                                                           0x00bc
+#define regMP0_SMN_C2PMSG_124_BASE_IDX                                                                  0
+#define regMP0_SMN_C2PMSG_125                                                                           0x00bd
+#define regMP0_SMN_C2PMSG_125_BASE_IDX                                                                  0
+#define regMP0_SMN_C2PMSG_126                                                                           0x00be
+#define regMP0_SMN_C2PMSG_126_BASE_IDX                                                                  0
+#define regMP0_SMN_C2PMSG_127                                                                           0x00bf
+#define regMP0_SMN_C2PMSG_127_BASE_IDX                                                                  0
 #define regMP0_SMN_IH_CREDIT                                                                            0x00c1
 #define regMP0_SMN_IH_CREDIT_BASE_IDX                                                                   0
 #define regMP0_SMN_IH_SW_INT                                                                            0x00c2
diff --git a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_2_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_2_sh_mask.h
index 0af8e95dadab..6e29a185de51 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_2_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_2_sh_mask.h
@@ -484,6 +484,78 @@
 //MP1_SMN_C2PMSG_103
 #define MP1_SMN_C2PMSG_103__CONTENT__SHIFT                                                                    0x0
 #define MP1_SMN_C2PMSG_103__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_104
+#define MP1_SMN_C2PMSG_104__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_104__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_105
+#define MP1_SMN_C2PMSG_105__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_105__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_106
+#define MP1_SMN_C2PMSG_106__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_106__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_107
+#define MP1_SMN_C2PMSG_107__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_107__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_108
+#define MP1_SMN_C2PMSG_108__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_108__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_109
+#define MP1_SMN_C2PMSG_109__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_109__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_110
+#define MP1_SMN_C2PMSG_110__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_110__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_111
+#define MP1_SMN_C2PMSG_111__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_111__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_112
+#define MP1_SMN_C2PMSG_112__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_112__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_113
+#define MP1_SMN_C2PMSG_113__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_113__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_114
+#define MP1_SMN_C2PMSG_114__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_114__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_115
+#define MP1_SMN_C2PMSG_115__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_115__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_116
+#define MP1_SMN_C2PMSG_116__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_116__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_117
+#define MP1_SMN_C2PMSG_117__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_117__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_118
+#define MP1_SMN_C2PMSG_118__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_118__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_119
+#define MP1_SMN_C2PMSG_119__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_119__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_120
+#define MP1_SMN_C2PMSG_120__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_120__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_121
+#define MP1_SMN_C2PMSG_121__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_121__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_122
+#define MP1_SMN_C2PMSG_122__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_122__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_123
+#define MP1_SMN_C2PMSG_123__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_123__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_124
+#define MP1_SMN_C2PMSG_124__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_124__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_125
+#define MP1_SMN_C2PMSG_125__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_125__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_126
+#define MP1_SMN_C2PMSG_126__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_126__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_127
+#define MP1_SMN_C2PMSG_127__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_127__CONTENT_MASK                                                                      0xFFFFFFFFL
 //MP1_SMN_IH_CREDIT
 #define MP1_SMN_IH_CREDIT__CREDIT_VALUE__SHIFT                                                                0x0
 #define MP1_SMN_IH_CREDIT__CLIENT_ID__SHIFT                                                                   0x10
-- 
2.35.1

