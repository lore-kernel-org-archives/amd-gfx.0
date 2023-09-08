Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41469EE57CA
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 06:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 718ED10E039;
	Fri,  8 Sep 2023 06:34:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 664FE10E039
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 06:34:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tunwc2QBGxT67Q4Bfzlz+74dWt551E/Q6unwbH26v00teQwnkCKC6TFyc7+Vssd+CaKMOZ1PMY13GG+f01aUSc7AfGGS1WXs9J4ioRFYBiHiKiLw8oPFlWXK+W1mi27RbSFi4TBPk6E3b+9ePS+czebMJYw18uiOgrfWzuI5/HhO6v2MppfJqyFyZ7VORL13Th0InU8k3tulOEcDDeeTHSQFeQ0eNc4PAdW7FG1EEKPcecb3ujIQ5vzkoU/sf2xy0zFaKOB9OaS4nmkLT2aN/83cyqK0eBcb5ZsQ/uWCJ675w1x0a5F7S/oCJZW8CWW/68U5EYbkR1XcSzFwHNXdlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zX062Crg+d2TXSXOALhCfX0/LHSZ3g9/ZnS0Kb6QNh0=;
 b=QWN+qXX8QIrb1yx3ng8XDd+4hfsm3NqziNz+6P4k7gR68XL6WUU0OBKr7d6f263727H3Z44xKeOBXdRXRQcnHflBHFQ4wRAOFYGlVtWAvfBrgwcFOK7V4uXD7GPxfrKM4gIr5KudK6dpbioKBR8X+nsAJwOhEt2q+4W1u7SwMEF/Ytdoh/gsWzx62cfnc/OTpbz0vX9I8kgInhP9utlsCyHfcw7Ae+B+Wp1XXAVn7nje5Ew3G00SEHC8IXKspZNUvmyquVIlUvNCTbzuZz9ZCTJIJuNi2bgVfQrXDCuupyz+jAMuo8dJyjQh2B0/RsIxEVUqfIMimzLzd9DqBx9HKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zX062Crg+d2TXSXOALhCfX0/LHSZ3g9/ZnS0Kb6QNh0=;
 b=pu0y3+Nw0q9vZaYU8C50fb44p8udEf24e93Y0F5Hxayn9OCQ90U5P8Cm6TttNKGNo8CY6+Wx9eajx+uPZZGuabG3kDGk+YGlg7kTqRvgyWJ+w2SrDTre6d4DdNvLXoI3H3FzL1PGpnfdG3qy2xRfXivNhJh7mdNqahl6DKeeNx8=
Received: from SN1PR12CA0048.namprd12.prod.outlook.com (2603:10b6:802:20::19)
 by IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Fri, 8 Sep
 2023 06:34:10 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:802:20:cafe::20) by SN1PR12CA0048.outlook.office365.com
 (2603:10b6:802:20::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Fri, 8 Sep 2023 06:34:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Fri, 8 Sep 2023 06:34:10 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 01:34:08 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: update smu_v13_0_6 smu header
Date: Fri, 8 Sep 2023 14:33:53 +0800
Message-ID: <20230908063354.2478663-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|IA1PR12MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 767033a3-a732-4d3d-11a3-08dbb0359c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hXtLbOlIg4oMB9pl8EFq+gibtjFVzX2AK7AfQL9l7oMAnKQMs9c09isAuMkoam7vr9VAzi36J8veI8l0HrfRykYPsU1piqJDUXK5p2ricDyAyYGQGoUvNqj6aONPCzVWxgdqzqb361kSWlZ9BABj60z12bmDtSMAzFe7Q8DfN8LpzE0ooHk27XBt6yB2XDRoItQtiLJ8dM3M1VXyMvfru5Wx0u/rHQExNAiFptwv7GdlkwykXtUhuMcRnxnOLcAjKc5/53Uk6AVMetSQfKPKX3XNXYMiXq8gNBCjwrqmdfZHquahe9qvSLl0NUyUcIOouICwbzVCw7X2QIoPAmw8VrgrxNCFV5s+BsnLgjZoIsvffDhstzccZ8XGvZVBXpih/D+eX4WCSgdVs8Qlx4iYfC/7oNBWj9hm8iMzTksS0MRLRdBysxboGsK8IywR7/mFhPNyPUnODHeokpn21TXsmaJcpNgFa6FqdKyUoal0J0t7wWVFMluxPB/IfDIJhZgVSd2LZ22aXXVZrJozkMVWJO/OdXbi64qcDByUqoy5wYK9Qrm/ya1nLB2ijQY9wum116+4wHJgxQVhrRfTHg7HS8yhH33ZmChxxzAlREuwqfjY0nUuwZqSQphqFtVUKSUsMyRN8WX9ILBjtFaEvAtPlOif2T9jQGqpT5nLS7o+n9qfVotWbOXc/d07dWFX7SNYHrekH+L4seKUqvYQ+SjJ+8Fuvg0WxgJBi4LHtq1Px9QVnR+nE9r4BdmNZteE176mH2mll9RfLIyjyQv9LZ9p8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199024)(186009)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(82740400003)(6666004)(16526019)(86362001)(1076003)(7696005)(336012)(26005)(19627235002)(36860700001)(478600001)(47076005)(356005)(15650500001)(8676002)(70586007)(70206006)(83380400001)(6916009)(40460700003)(40480700001)(8936002)(41300700001)(2616005)(426003)(4326008)(54906003)(316002)(5660300002)(36756003)(2906002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 06:34:10.3460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 767033a3-a732-4d3d-11a3-08dbb0359c3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7495
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

