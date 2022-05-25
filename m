Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5575CC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B58F10F29A;
	Wed, 25 May 2022 16:20:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D34C10E814
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuStKW2U5CMNrhtfEntaAPPEm3h8BYrO/mj06HC4+EWCIXWW1aRPyXnW6eUyYAKokho9QhDW+tNgLQVWDYNUqvdhVwRswMo5TeoXq5dII4abW60NbM6OITbhEhLjL1Zu1QNPCYEncR43pPGAlIyxxbdvTpebzfgAj496d2o7P8Ru5/cj6lgbyFK8u4X9JoihKHyz1rxMyYJLuoWJfi5q+vYZgENy8Sss7GSvCfGGc/dYdLpUMNdjSO7yCFC9re1EcuIyAg6ULc8G0OkO3/7IDgDMogvQNOCWZlbsJNSUGPk/NqjKSY/L7rAafSuDCixG3RpQe36W0QxVEo0xIueaQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+23HonK6ZBbKSzVGoN4Z4P/kZf2Kh5/PApDMzzK44E=;
 b=aMW31IKsiGBYKZih1lGcE/NYhg6sjx799XR1DLgf6HbwArupMg3w16H8w6eQWR9BabK92kVNx4eiXaaZkKQd8dwWU70G9T3N04ifXD2SVYzv/YUUMk4hS7HC8W56n1y5f2LVno33KyaHyN7IYRUyUYFQgbipSbgX7v5p1qLJVAPEhnv6XpqX4Q8KRNJRb9BrSx43mT8Et/CKdJnG/1wu9rLwVUpnkfG8OV9ZWPBPmy3wSu9UZV+Xj5emGY319Zxj2z3sxPDjEgYkjTqTP6UCe+RGWKGlOMRrkT8tiUHyYAGzj+TpXBHGkeu+XQbljk9FKMhY4HApVyNk2wCIsKz5gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+23HonK6ZBbKSzVGoN4Z4P/kZf2Kh5/PApDMzzK44E=;
 b=d+ADnQwit7UB68GdMOxdhweSx/wBE/ym7l6RbhgB5Q2IMChweUOfHSLdX5IW9E2KBmAEjryFzbmB+RONj7DgPc6QN7OFHS8dPumTFiIYlih6y/HzzvBzed+t4gjUgaF06gbtEaw7dyskFqrR8I7t5JS8aqVvpo4Y8nLe9kIx48E=
Received: from DM5PR05CA0002.namprd05.prod.outlook.com (2603:10b6:3:d4::12) by
 BN8PR12MB3201.namprd12.prod.outlook.com (2603:10b6:408:6c::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.19; Wed, 25 May 2022 16:20:15 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::20) by DM5PR05CA0002.outlook.office365.com
 (2603:10b6:3:d4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 16:20:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/43] drm/amd/display: disable idle optimizations
Date: Wed, 25 May 2022 12:19:20 -0400
Message-ID: <20220525161941.2544055-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66163b24-64b1-4cd8-6915-08da3e6a73d2
X-MS-TrafficTypeDiagnostic: BN8PR12MB3201:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB32015D35409A66E96E6DDC5FF7D69@BN8PR12MB3201.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WS8SG0V4j6RmE7NQHaqv0RYpny0Gx25AjBw5qxhttBWBQ14R8pcUS8VGH47GeO08oxVWfncCFh8VmuQ0gO27p+JcnkCON74l4l1dfv5Zy+7swzj/WZmnv8oNT0x7WLnbdFu7h/lruJq02rniSO0yHJE8kiux70A0DMhrMsFsKBniYAp3L8tMey8TK6F4dCGwjtLQspP/T048KAN7eN9HxOiXYGO2/Q+qN8pSxt1sWWCobT+6n9+Ub3zTJVs+p6BCdJLb4zto7DApVvuHvpQlaXzoicKSBBxrRnwYVl/VfQVb2FmvkeXFPidgTLmPCh7L84cNY+RbehJ04VCnJJMTfVSkIdB5ob89MNsUmmlXvQu3BWwB/4Goi5wA6RWgEPdPdVmxHXfhBHfqzjP/dxY6oOrfiP3RnimsokwL0MmXWWsDNzvof0plnVMjeUkGUP6IyJbAWzP37N280+2uq5f5OR77lkstc52BNzqpbUax9hgCp5HXLwAQhWYc+BHk3vfRDvp+0AkPjvbIvkvIRfUSjZvBF0Ly2hIbFY4GTfLfIm0UWdCwpnYNO7KGO89xgQZ/efqO4A0aqQWGXrd4jeogyBuH6jzsi7yZ/UXVpj3a7SDYwKZJethTCPNRghdk0/T0A9Db7bKKcIAof2/9CnFfgpMsjG6YGcqPL5ahx8T1Z0X18BIjyANONMBAbVohXyNrgPmXjrOnsq/5XRvseA0kSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(7696005)(70586007)(70206006)(336012)(186003)(6666004)(508600001)(2906002)(8936002)(316002)(5660300002)(356005)(40460700003)(54906003)(81166007)(4326008)(86362001)(8676002)(6916009)(1076003)(16526019)(2616005)(82310400005)(47076005)(426003)(36756003)(36860700001)(26005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:15.5877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66163b24-64b1-4cd8-6915-08da3e6a73d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3201
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jerry Zuo <jerry.zuo@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

Disable idle optimizations until SMU can handle them to prevent DMUB
timeout and subsequent system freeze

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 8a10a7a4c3e1..64d1a6bf0683 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -976,6 +976,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.timing_trace = false,
 	.clock_trace = true,
 	.disable_pplib_clock_request = false,
+	.disable_idle_power_optimizations = true,
 	.pipe_split_policy = MPC_SPLIT_DYNAMIC,
 	.force_single_disp_pipe_split = false,
 	.disable_dcc = DCC_ENABLE,
-- 
2.35.3

