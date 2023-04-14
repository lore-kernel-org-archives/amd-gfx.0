Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807B8C77B71
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:53:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2852E10E1C1;
	Fri, 14 Apr 2023 15:53:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A53F10E1BB
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:53:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9qxApMlc5mJXBe2zyn50QXphelTqPE8DOddiO61zPSTGar1sk6WwdJS1qtBzPNr0DsKLUWoFFSnmROv1mu3TGErmKXSNeWqWhaxcuD1qKJ0rrBgb0y1bn42GxsudkuR9cQe31KTAvzEUTdpU66k3dM1lyySi2k8FyX3GZO0u+RDrF8oiMAO5d1Sw0xSjjkLSbofSrVRanG6QAop4anrVgMgVtrW2+2mT3w3NLqLhuKt7efLZvopTcNLqLaAkA5rueZyJSTGJieoWbStwgnM2C6fvGG2rXrc2IIvWj0UVSORsrwx/CealKMPdXqJdN0wuiWsedXVjt+r31AYIdtiXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuu3uqNl0TnLh6cnrxLYwenBw5RrZSSK0okfQQGeFNw=;
 b=Wezys9htuiyH7t4e6OO+4aSvHJJh7GA3JGoxGOg76FQYYzDt7TL3jOsC1Y8oZvoJnY2FDzK8hG+Wu+1/dLZtCVjB0KGkUKq4gj4jLj21nyBbjonS1+oYsupqzFg0QVOElKS8+eumxyZOxKsm/g/m2fpZ7vrGfpIS0O73jkZdKmO2t1sabQtYVnda7OVJ8S6ub2E3Mx1Kl3O/96mPYGIRjToPfg8c6mLke33SitaWR3FEHMQtuv8sCt09AB/z+i921Zssv9VULzqeOjNwLFYc7eMuMCxjVM3RkAiQEnMudh0R1fwm5gABg3c21l8LooBvBYiDp0Hkh1N8TkeTYo0YTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuu3uqNl0TnLh6cnrxLYwenBw5RrZSSK0okfQQGeFNw=;
 b=L73IGELAxBcoCsa+gPeeXbvfxURoroqGYoxJLhwrDhR67qSMiUIuNPL7WiKpLOY61s8klP0j2VzWbOc82J4/og40x3bq8sbEQl8wf3z/vsADVs9WyOq4YIPkCRYxIo1WXNLBmdsqQQPhx/Mhr9IR8Y7wzj5d7rkWd7cLfUJVALY=
Received: from DM6PR13CA0051.namprd13.prod.outlook.com (2603:10b6:5:134::28)
 by DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Fri, 14 Apr
 2023 15:53:48 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::35) by DM6PR13CA0051.outlook.office365.com
 (2603:10b6:5:134::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.6 via Frontend
 Transport; Fri, 14 Apr 2023 15:53:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.37 via Frontend Transport; Fri, 14 Apr 2023 15:53:47 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:53:46 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/66] drm/amd/display: Update bouding box values for DCN32
Date: Fri, 14 Apr 2023 11:52:25 -0400
Message-ID: <20230414155330.5215-2-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT058:EE_|DM4PR12MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: f77d8c26-f85f-482a-bbdd-08db3d006f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zR7ROPf3YzIgc1C0C5bGyTMLzbxxQA6uqBHlQ/1KendXF2q+y56OBwI1b5gcLX2dX9EqTGx8u0133dySliW7Nb4CwX/Fl+IrKwrpY5PzA2F3V5stA6UzUcM4rKI5vpzJLRrqCiA13LsPxi1bkk6QUK/K1bzfbo0gke+NuU6SxMhO0/retnjQrct6g/8IvwUO74tB8Ui86l5ug+3So7mE6PnYm+LhuqLkXU6tS90YMe2nPhmN9Lxi1oSC0L9LjovIcUozgu4sBD6HHL/xQoHHv3yKk/06QrYXjKs4S7YXeTwJMl8duWXl3qNXozZA4bIeXLHRSR6ld+rx+Ox41+IhYzZhHysSzRPrisZ1DKFYHJPafhx9YwD1uh4QW0sgRHcbT9INn/4zT2JmgiedwqWCAknCLCXjdlLNMM4qYA0aTKv/581cUzVeP/jdTWu0ZQ6IRfeXx0rWOex9iVsTSz/mGWIi9w2CtRCikTnO3xnsyPMjtJIkUoGn/0HL6ZL26xFcoIf67MQ78RWUPmnvfydgDU/yrwCSlvRPWX6uvBUYaunvUYMNwabRXIBPjt2PuCrfAdvIC3e+aFmQeBrff29BylzCJes1vQ6rb0zVd4B35tWnCTL8lTLrpTIC86CkJpbFxhF/0EQZexF5f+9tK6i1cbePyrOU8FB3pMWZvEWxZTXevjfOh17TRcMrNh13eCYEfGQc4GB9SDR/hApUlBIQ1SsWZeEOK7B8uXNIxFmUiPI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(6666004)(83380400001)(41300700001)(70206006)(70586007)(15650500001)(6916009)(4326008)(8676002)(2906002)(40480700001)(36860700001)(47076005)(82310400005)(1076003)(86362001)(336012)(186003)(16526019)(26005)(2616005)(426003)(54906003)(82740400003)(316002)(40460700003)(8936002)(5660300002)(81166007)(36756003)(478600001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:53:47.8739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f77d8c26-f85f-482a-bbdd-08db3d006f4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

All clock values came from firmware, but bounding box values can be
helpful in some debug situations. This commit updates some of the values
associated with clock speed and memory channels.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 4548320217fc..f0037cb43dca 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -109,7 +109,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_2_soc = {
 		{
 			.state = 0,
 			.dcfclk_mhz = 1564.0,
-			.fabricclk_mhz = 400.0,
+			.fabricclk_mhz = 2500.0,
 			.dispclk_mhz = 2150.0,
 			.dppclk_mhz = 2150.0,
 			.phyclk_mhz = 810.0,
@@ -117,7 +117,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_2_soc = {
 			.phyclk_d32_mhz = 625.0,
 			.socclk_mhz = 1200.0,
 			.dscclk_mhz = 716.667,
-			.dram_speed_mts = 16000.0,
+			.dram_speed_mts = 18000.0,
 			.dtbclk_mhz = 1564.0,
 		},
 	},
@@ -148,7 +148,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_2_soc = {
 	.max_avg_fabric_bw_use_normal_percent = 60.0,
 	.max_avg_dram_bw_use_normal_strobe_percent = 50.0,
 	.max_avg_dram_bw_use_normal_percent = 15.0,
-	.num_chans = 8,
+	.num_chans = 24,
 	.dram_channel_width_bytes = 2,
 	.fabric_datapath_to_dcn_data_return_bytes = 64,
 	.return_bus_width_bytes = 64,
-- 
2.34.1

