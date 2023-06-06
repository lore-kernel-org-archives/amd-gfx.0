Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7C3C7EE24
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 15:47:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4498410E376;
	Tue,  6 Jun 2023 15:47:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1772110E376
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 15:47:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWDfzwGt1DFQ5Sg+BcPy1e5rs7nYpWIQSSlUHbrXQD/xiZ/I+L5XvGjfd2r4ueQYXQq468rnUzyTEbxCV4eYbhRBkwg++BYyoRKskwtVii2SxP+pwhkSeDZbnTlqC4p3jZw6JDOdfRzQr9mzjQLA7zdpwwXjpClrOoFvkXOV8tqbc2McMcoTHM8QIvfd/RoTxeLGSrYl80yLjPvLF0HIKGFvMZ0lXG+Pk2bMCT+2b40fdahSp+8hSSFbgfuKi927ij/LrAy4jwubjmc+zM7cFpfTgPtnwXLRDSZ6sC2gKxCoQ2OGxBXgbCgKScgb1GJlhnCh6r4oafVjANO2rlPhcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+a70qXYhlhbzFdPIXgFO9O1uCOjDdpX1loyAbcc32A=;
 b=OyyCA/N6Y5MyNs1R8+p+kHnPZpcP5d/5ST6WaAbcHQnwh7QjvrmA5z/frzz6PNVUrRsvrYobaIU9ei2rGuu8bNU66mJ4ImPJ/GLdUQ7TgEFfyjS3VXGJ/iBKfZcVzShL2NelOEspF0QARs1aUBu1JnLM9xIIy3N3IKXRSpS8KW8psqLHNECGh9f+RWmD+eGsS3YIxawpJx08AwVqlCP9RhT3QBQydeNEmx7biYX+5rD1qtML1D0iBBkJ+ZyAA3YeNp6ty7ojOOfs8llkSrdTPe2qtU0wLuemt4u2M2MPoAQ0f5Zqd3dTamLX8nu+rTu/IbHbAPFqqsEbyHKQ9IJCcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+a70qXYhlhbzFdPIXgFO9O1uCOjDdpX1loyAbcc32A=;
 b=RjAq1J9VFo1Emn6R7tPu5LxTEiHx6OGflpKlS+xSNSt6Yx8UJIwHpzKbbDDdBMoPyOfADw5ooIbe2vnpMX5Qvp5SG4nLaTQscKYktQAKtpfDpNHd1EBZs3DWcS3D/7IYV9KEbeJEpAoYBF+YhsoX3n9opguPZWjiqmwP1pUTsn8=
Received: from SJ0PR05CA0004.namprd05.prod.outlook.com (2603:10b6:a03:33b::9)
 by IA1PR12MB6115.namprd12.prod.outlook.com (2603:10b6:208:3e9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 15:47:07 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::cc) by SJ0PR05CA0004.outlook.office365.com
 (2603:10b6:a03:33b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Tue, 6 Jun 2023 15:47:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Tue, 6 Jun 2023 15:47:04 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 10:47:04 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 08:47:04 -0700
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 6 Jun 2023 10:47:03 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Only use ODM2:1 policy for high pixel rate
 displays
Date: Tue, 6 Jun 2023 11:47:03 -0400
Message-ID: <20230606154703.407753-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|IA1PR12MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 73ad11cf-c687-44c3-9ef2-08db66a546d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cQ8Ywm303ihjhqlw0FyEqyf+0z7btPMVd/dxa7qvA8BhsnWpnqTI3jEg2dzoYm8l3CvkM5vCkT7+LtlwJe6qE70/tBRmCt1r4vZYrBb9Qg+bVl8gj2oyh5zG5eR4t2M16kJ5gqlzLi9WbuIh3fRgTlzSIK+Kz4Kp5HqewpXBAISrRdV/xeGMZ6OBWCpY51lL77ohrGpOCgbsgEY7okN9h+54IEBCwX/rD8MPPaf4Snv6kDK6MFS/FNuBU5PLq0XLb9ZKeA2dgsIcuaFQgDYqGqeHWOb8/Z2TcltDjdx04Z/UFmQ/IL+49EnWuV5KqkL/ncJMzZx6KJYcgnobDbHUUif12j4BkO+Oy0gyabgsdLYOy7gtlkWHNvsX3gM75kYQEYhBBnw6AWnF7orhdxC2OCvUwTBKZop97qqYrQbGH8zh2Gmbfx9b9sFxQiUxkSndUbjX0OqEEcxJUqmfL7w7NdEPFYiLzSX+/L+fNT4GNTxY23Q2wcjZfxv+NCAkVXLzutgdH2pygPnGoVXulcP9AdgT6/eu91N6QVwYUkSXuX7nspT0khvAFY4ESPmu4+uUXGvj/yuwd7jh+eH3vrP5rqr3OkSvqPkh7tvGJlWiDOqdNX9EBWxpGiJq7zIiGiW+oIc91UZpdUFepN3L3oBEOzvVDJb1IH1xy/IrtkagmDTJUvJQBbL1uwoizjenLmSPqPUCgf/oEGPry1gm58J5AmzWPm6Hp2Na/i2lfkJEkJv2HCWFyJNdzCYasfa1s4pA9OzoHstmu8bromMIUL8QXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(54906003)(40460700003)(478600001)(40480700001)(8936002)(5660300002)(44832011)(8676002)(36756003)(86362001)(2906002)(70206006)(4326008)(6916009)(81166007)(82740400003)(70586007)(316002)(82310400005)(356005)(7696005)(41300700001)(2616005)(1076003)(26005)(36860700001)(47076005)(83380400001)(186003)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 15:47:04.6605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ad11cf-c687-44c3-9ef2-08db66a546d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6115
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
 Daniel Wheeler <daniel.wheeler@amd.com>, aurabindo.pillai@amd.com,
 rodrigo.siqueira@amd.com, Alvin Lee <Alvin.Lee2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We only gain a benefit of using the ODM2:1 dynamic policy if it allow us
to decrease DISPCLK to use the VMIN freq.  If the display config can
already achieve VMIN DISPCLK freq without ODM2:1, don't apply the
policy.

This patch was reverted but that causes some IGT regressions. To
unblock, the patch is being applied again until IGT failures are
fixed.

Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 8d68f02f5147..2e6b39fe2613 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1918,6 +1918,7 @@ int dcn32_populate_dml_pipes_from_context(
 				context->stream_status[0].plane_count == 1 &&
 				!dc_is_hdmi_signal(res_ctx->pipe_ctx[i].stream->signal) &&
 				is_h_timing_divisible_by_2(res_ctx->pipe_ctx[i].stream) &&
+				pipe->stream->timing.pix_clk_100hz * 100 > DCN3_2_VMIN_DISPCLK_HZ &&
 				dc->debug.enable_single_display_2to1_odm_policy &&
 				!vsr_odm_support) { //excluding 2to1 ODM combine on >= 5k vsr
 			pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index 80bebdf43eca..2f34f01b3ea1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -40,6 +40,7 @@
 #define DCN3_2_DCFCLK_DS_INIT_KHZ 10000 // Choose 10Mhz for init DCFCLK DS freq
 #define SUBVP_HIGH_REFRESH_LIST_LEN 3
 #define DCN3_2_MAX_SUBVP_PIXEL_RATE_MHZ 1800
+#define DCN3_2_VMIN_DISPCLK_HZ 717000000
 
 #define TO_DCN32_RES_POOL(pool)\
 	container_of(pool, struct dcn32_resource_pool, base)
-- 
2.40.1

