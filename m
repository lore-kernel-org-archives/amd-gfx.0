Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D38C7113D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 06:25:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 782F310E993;
	Fri, 13 Jan 2023 06:25:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B0B210E99D
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 06:25:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2TZodo3bEnSC9G+bMdCwkBO/u3Jg6NHCZPYt7gzpAzFJqCnCegGlMrqoH60uex52LNKrXzUS+Pxgvyl3R5kdGbpmVqiFRokEZUW+T3keLRa+pnTYOg8ZSkCe8p0tpmnquw+/xuNcDz+78uVoWkMyS24W3Dy71ggSgOEnPJzN8DwqpWtpBBQIIcBRilMIc3NVnoy5AcF5kuTu5x+EOeW0xoluNdfIIhmtt2NTPEapuvOrDyX/mkYzrtj930lIDMGgoYE8hIAOmwMGFkjPYubdno72EO+vwQgKpwM1g/e8q/TF2aAwlnCGIu8w8DgbXmoAzIWuvtIO5kE8sgwRicbMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsOW13VxY/MC7Y2BGJUPiDGtuqUMmueEAigtnzElUeY=;
 b=LuoInl2ratY2gWXrZSUJbqRmLfI24EuBhnWTWXnn9QS4yBw0uRB412o2xu+Xw+Y/DqUQH7MjgPDeeH/HHtfakNefKqYfJDzIz+SijVFPumUGs9djMx8C+T4MQgyuLFr64ybAv2oeR9YZ+0XOz/vfIK+KQbSPTVy0xh4d2DNBZ5DvcvEaxndphliInMYK/LJldT4ACP1DRr4vkZBubWRJYFmumwECQn0uXSFBfHfvkMYtMnP8Smyb2l3fnNTgTbdTTC9Me3OJLnEXAEnV2CjZuP6o8nnJTX+KbyFryW5PDFsxVnEyJLT6TcfrKZKAC+TLf6aSYndPopHgFtqVv4bg9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsOW13VxY/MC7Y2BGJUPiDGtuqUMmueEAigtnzElUeY=;
 b=Zp3OI0iLvIFCtEJTkjMU2TSsIj+nQUMMhnm5ScZA693UZ1EWh6rdBTYJpfWRkzD2MSO81drbYNTzoISHaeP3GoAO9MZbzAI62BR4qt+7g4PV5mIfgvvCzuBlfOXZu43nWqfx/Lmk2soITg1u72xtZlD0uQQWwb5t7U/4b8Ww8gI=
Received: from DM6PR06CA0003.namprd06.prod.outlook.com (2603:10b6:5:120::16)
 by PH0PR12MB7471.namprd12.prod.outlook.com (2603:10b6:510:1e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 06:25:04 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::d8) by DM6PR06CA0003.outlook.office365.com
 (2603:10b6:5:120::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.14 via Frontend
 Transport; Fri, 13 Jan 2023 06:25:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 06:25:03 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 00:25:00 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] amd/amdgpu: Add RLC_RLCS_FED_STATUS_* to gc v11_0_3 ip
 headers
Date: Fri, 13 Jan 2023 14:23:55 +0800
Message-ID: <20230113062358.1727355-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230113062358.1727355-1-YiPeng.Chai@amd.com>
References: <20230113062358.1727355-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|PH0PR12MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: 83a65b6b-a665-45b1-795d-08daf52ee7c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e+BvjUDVjr2psEnwCrXvD73xwPLPg0CVOCkPn6UY9n0Nae/KMvHKiou3qlF3rLYjMF/m9EhBaCgtTv2WDO2np6VhhZLfgGyKQwtoK0CkQ0SeogJl4VJ9YygA7Qtl9aKxJB09WTb4Mb7hQpKn+p1NEaN166EXNc6NMoC/cHHn2fAHtaIpK1TqhpnFBSQqyDrEbJvsvxupNzhLvK6mki35wJisueYR3ibr3Nexdt5HUtCim9cv/zqWusI6rA1XiH3hI+lWqWYEgqxexg1tNdX5tHYJ522dhJyQ8S5muIviWd/1a5TCFGsE/VOxkUYzHLvgvxssMnbG8E4FlyEqNTUqI1I1f6AqaUBbuoezPXnz2ZIYaICPrQVB+N4aLQ58pwGrnPdiThZZK5Ez2hZxFOhhPI0LoW3QiombI3v5w5ZYAFwb24eZ/4F8yMqj9rpm8WvIwulaSirxUNq1URJt9hiXN7lWfEe8mxnte7YiZCMXabdS+fqTE9a4+9L8DylpQ7qNcT0AF9MPgR38YnyxwEckVLBTFHSiHps80qJf4hEKYp7rq0CUoOED9hrNpEK4UWonEFbSSQ6IPsADUSwhqx9FVGcZSp5ueDJFAANvQKIMynimVxjJ571wHIFeApAYjFAguZQJOFgitNZ093VzuBsIqNcuDDHiXU7rfiiOT9f0Pm6ml2Nf1Y30jSRAZUVp+1VFPK586TQ2TKwu9jHX2Iib9qCLTyn+uSuw5XkXTOyQku4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199015)(40470700004)(36840700001)(46966006)(36860700001)(83380400001)(86362001)(356005)(4326008)(2906002)(81166007)(70206006)(8936002)(6916009)(8676002)(5660300002)(70586007)(336012)(40480700001)(426003)(82310400005)(186003)(16526019)(6666004)(26005)(41300700001)(2616005)(47076005)(1076003)(316002)(54906003)(7696005)(40460700003)(478600001)(82740400003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 06:25:03.1122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a65b6b-a665-45b1-795d-08daf52ee7c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7471
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
Cc: Tao Zhou <tao.zhou1@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
 yipechai@amd.com, Alex Deucher <alexander.deucher@amd.com>, Candice.Li@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

V2:
   Add RLC_RLCS_FED_STATUS_0 and RLC_RLCS_FED_STATUS_1 register
   offset and shift masks.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../include/asic_reg/gc/gc_11_0_3_offset.h    |  8 +++
 .../include/asic_reg/gc/gc_11_0_3_sh_mask.h   | 50 +++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_3_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_3_offset.h
index 3b95a59b196c..56e00252bff8 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_3_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_3_offset.h
@@ -3593,6 +3593,14 @@
 #define regGCL2TLB_PERFCOUNTER_RSLT_CNTL_BASE_IDX                                                       1
 
 
+// addressBlock: gc_rlcsdec
+// base address: 0x3b980
+#define regRLC_RLCS_FED_STATUS_0                                                                        0x4eff
+#define regRLC_RLCS_FED_STATUS_0_BASE_IDX                                                               1
+#define regRLC_RLCS_FED_STATUS_1                                                                        0x4f00
+#define regRLC_RLCS_FED_STATUS_1_BASE_IDX                                                               1
+
+
 // addressBlock: gc_gcvml2pspdec
 // base address: 0x3f900
 #define regGCUTCL2_TRANSLATION_BYPASS_BY_VMID                                                           0x5e41
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_3_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_3_sh_mask.h
index ae3ef8a9e702..658e88a8e2ac 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_3_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_3_sh_mask.h
@@ -37642,6 +37642,56 @@
 #define RLC_RLCG_DOORBELL_RANGE__LOWER_ADDR_MASK                                                              0x00000FFCL
 #define RLC_RLCG_DOORBELL_RANGE__UPPER_ADDR_RESERVED_MASK                                                     0x00030000L
 #define RLC_RLCG_DOORBELL_RANGE__UPPER_ADDR_MASK                                                              0x0FFC0000L
+//RLC_RLCS_FED_STATUS_0
+#define RLC_RLCS_FED_STATUS_0__RLC_FED_ERR__SHIFT                                                             0x0
+#define RLC_RLCS_FED_STATUS_0__UTCL2_FED_ERR__SHIFT                                                           0x1
+#define RLC_RLCS_FED_STATUS_0__GE_FED_ERR__SHIFT                                                              0x2
+#define RLC_RLCS_FED_STATUS_0__CPC_FED_ERR__SHIFT                                                             0x3
+#define RLC_RLCS_FED_STATUS_0__CPF_FED_ERR__SHIFT                                                             0x4
+#define RLC_RLCS_FED_STATUS_0__CPG_FED_ERR__SHIFT                                                             0x5
+#define RLC_RLCS_FED_STATUS_0__SDMA0_FED_ERR__SHIFT                                                           0x6
+#define RLC_RLCS_FED_STATUS_0__SDMA1_FED_ERR__SHIFT                                                           0x7
+#define RLC_RLCS_FED_STATUS_0__RLC_FED_ERR_MASK                                                               0x00000001L
+#define RLC_RLCS_FED_STATUS_0__UTCL2_FED_ERR_MASK                                                             0x00000002L
+#define RLC_RLCS_FED_STATUS_0__GE_FED_ERR_MASK                                                                0x00000004L
+#define RLC_RLCS_FED_STATUS_0__CPC_FED_ERR_MASK                                                               0x00000008L
+#define RLC_RLCS_FED_STATUS_0__CPF_FED_ERR_MASK                                                               0x00000010L
+#define RLC_RLCS_FED_STATUS_0__CPG_FED_ERR_MASK                                                               0x00000020L
+#define RLC_RLCS_FED_STATUS_0__SDMA0_FED_ERR_MASK                                                             0x00000040L
+#define RLC_RLCS_FED_STATUS_0__SDMA1_FED_ERR_MASK                                                             0x00000080L
+//RLC_RLCS_FED_STATUS_1
+#define RLC_RLCS_FED_STATUS_1__GL2C0_FED_ERR__SHIFT                                                           0x0
+#define RLC_RLCS_FED_STATUS_1__GL2C1_FED_ERR__SHIFT                                                           0x1
+#define RLC_RLCS_FED_STATUS_1__GL2C2_FED_ERR__SHIFT                                                           0x2
+#define RLC_RLCS_FED_STATUS_1__GL2C3_FED_ERR__SHIFT                                                           0x3
+#define RLC_RLCS_FED_STATUS_1__GL2C4_FED_ERR__SHIFT                                                           0x4
+#define RLC_RLCS_FED_STATUS_1__GL2C5_FED_ERR__SHIFT                                                           0x5
+#define RLC_RLCS_FED_STATUS_1__GL2C6_FED_ERR__SHIFT                                                           0x6
+#define RLC_RLCS_FED_STATUS_1__GL2C7_FED_ERR__SHIFT                                                           0x7
+#define RLC_RLCS_FED_STATUS_1__GL2C8_FED_ERR__SHIFT                                                           0x8
+#define RLC_RLCS_FED_STATUS_1__GL2C9_FED_ERR__SHIFT                                                           0x9
+#define RLC_RLCS_FED_STATUS_1__GL2C10_FED_ERR__SHIFT                                                          0xa
+#define RLC_RLCS_FED_STATUS_1__GL2C11_FED_ERR__SHIFT                                                          0xb
+#define RLC_RLCS_FED_STATUS_1__GL2C12_FED_ERR__SHIFT                                                          0xc
+#define RLC_RLCS_FED_STATUS_1__GL2C13_FED_ERR__SHIFT                                                          0xd
+#define RLC_RLCS_FED_STATUS_1__GL2C14_FED_ERR__SHIFT                                                          0xe
+#define RLC_RLCS_FED_STATUS_1__GL2C15_FED_ERR__SHIFT                                                          0xf
+#define RLC_RLCS_FED_STATUS_1__GL2C0_FED_ERR_MASK                                                             0x00000001L
+#define RLC_RLCS_FED_STATUS_1__GL2C1_FED_ERR_MASK                                                             0x00000002L
+#define RLC_RLCS_FED_STATUS_1__GL2C2_FED_ERR_MASK                                                             0x00000004L
+#define RLC_RLCS_FED_STATUS_1__GL2C3_FED_ERR_MASK                                                             0x00000008L
+#define RLC_RLCS_FED_STATUS_1__GL2C4_FED_ERR_MASK                                                             0x00000010L
+#define RLC_RLCS_FED_STATUS_1__GL2C5_FED_ERR_MASK                                                             0x00000020L
+#define RLC_RLCS_FED_STATUS_1__GL2C6_FED_ERR_MASK                                                             0x00000040L
+#define RLC_RLCS_FED_STATUS_1__GL2C7_FED_ERR_MASK                                                             0x00000080L
+#define RLC_RLCS_FED_STATUS_1__GL2C8_FED_ERR_MASK                                                             0x00000100L
+#define RLC_RLCS_FED_STATUS_1__GL2C9_FED_ERR_MASK                                                             0x00000200L
+#define RLC_RLCS_FED_STATUS_1__GL2C10_FED_ERR_MASK                                                            0x00000400L
+#define RLC_RLCS_FED_STATUS_1__GL2C11_FED_ERR_MASK                                                            0x00000800L
+#define RLC_RLCS_FED_STATUS_1__GL2C12_FED_ERR_MASK                                                            0x00001000L
+#define RLC_RLCS_FED_STATUS_1__GL2C13_FED_ERR_MASK                                                            0x00002000L
+#define RLC_RLCS_FED_STATUS_1__GL2C14_FED_ERR_MASK                                                            0x00004000L
+#define RLC_RLCS_FED_STATUS_1__GL2C15_FED_ERR_MASK                                                            0x00008000L
 //RLC_CGTT_MGCG_OVERRIDE
 #define RLC_CGTT_MGCG_OVERRIDE__RLC_REPEATER_FGCG_OVERRIDE__SHIFT                                             0x0
 #define RLC_CGTT_MGCG_OVERRIDE__RLC_CGTT_SCLK_OVERRIDE__SHIFT                                                 0x1
-- 
2.25.1

