Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5808CF3963
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 18:35:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AAE410E763;
	Thu, 19 Sep 2024 18:35:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eDbYtcLj";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76D2B10E762
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 18:35:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkx6iFALCZP2BjnSLvjObMBfqFFvTxvoNflJRsRgj0uPU5GO+OFCq5MVbD8umsm/Qp+JZfK1SlN5hUvQKgbVjJaQZPv8PlOy5IsZwO4RKWxAVZkshPVR99lI7i8SDPlAInTAVO2xlZeJrHkMoIZjjy1TpI/8IX3Njp18p4UIlfiCyTFLhUEZVpIsmUCdq5CwQYe9cIr5o5D1gbQniv8o8BPBaXxaqdzJR5b8FL8cJtnZC8dpZy9SVM2UA7xRYbsFySv6L/7qF3MAZz0yFtkprr5WMHTvmTtMPaHRobOxIIeUISxLAi5w4NsG3A9UfnAi4pGF9cpoun4QfJHucbcnAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zajeOvTWlADw22hi/OGrm4m4ZYPtDMNl5YGxIdRusJ4=;
 b=JieOVcl+xST9bGKh89e7hNZREIlkjRKVFPvCwXqORc9/VmkW4tnB7kclgzcHUxTfC1mqneUM7cYFvDhJWLOtjk9XiNlLcdb0fiqfKZw/o1FXBgNM8boTVAn5LmBABCBPo2n2XHvWyzYno6kq9QXAovV6xPoLp5Vyrj5mF5YrvOW1dmRD9xTXwhl+hvx1bt6wCP0XCygT/Iks2OaqtGPyi5AVswFtfKXoSMCVuPXHmQ6mO7ZfsiLukM77OjrMccOPf6trsK93KDGN5JUvvvsjI/RM6Dc38Da+CcSxYd5Q8hgl4Zir+avfct/Z5y6n15mlPxJ48B/jBCOQ4YUIsSpZxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zajeOvTWlADw22hi/OGrm4m4ZYPtDMNl5YGxIdRusJ4=;
 b=eDbYtcLj3lS1wWGu9K4i5sJR4TstLPoUL2Ip2hgyfNjzcR5YgJIRuGetHc+gqagAq3XmJcVfJwaDdq32yuSJW6IuM83mzZjo7VtbmX0gasTeXMTHBy23BRfSlRuPhgGKyKgNzqQ2qacPVphYxSnQHHYgcxiwvcP87A+gaI4XtFs=
Received: from PH7P221CA0040.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::24)
 by PH7PR12MB7425.namprd12.prod.outlook.com (2603:10b6:510:200::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.29; Thu, 19 Sep
 2024 18:35:00 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:33c:cafe::8) by PH7P221CA0040.outlook.office365.com
 (2603:10b6:510:33c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.29 via Frontend
 Transport; Thu, 19 Sep 2024 18:35:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 18:35:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:35:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:34:59 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 13:34:59 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 13/21] drm/amd/display: correct register Clock Gater
 incorrectly disabled
Date: Thu, 19 Sep 2024 14:33:31 -0400
Message-ID: <20240919183435.1896209-14-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
References: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|PH7PR12MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: ae27092e-f165-4dc8-9742-08dcd8d9c51d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qfRqrC/9IdD6oW+5qvGbY7PFSiYalUZFjL1T+hwB5cqTcNYSGuCKteNV/QgQ?=
 =?us-ascii?Q?qqzOm7gSBw6qSdGhWUJ32aDZC36Xv1cIlsG95Yx2aSf+Ymj3XqkR8m9Ci+cO?=
 =?us-ascii?Q?XF0XjleY9QV4NrCquB6Gog1jpr4AcWLMP0xloMJUfv9pvPi4NM6PAbr8NdOr?=
 =?us-ascii?Q?LkKU4VYrd2Hzn6daBMIuC9kHsZ6+/LMArpRhyy6VNzMgPfiARwbpSKpW7wbe?=
 =?us-ascii?Q?YLrR0v0PI0XalLyBL+dl04YWuYocqrIYdEkITi0L4c8jmpKYjwhINZqcG0kt?=
 =?us-ascii?Q?K5hGMwjsC21LwRueKfQUVSPoRodG1DpeZ12aaiy6UgOlcjIXDivzL1ST/9zn?=
 =?us-ascii?Q?xo9k5vXBFcPrhGCjvYGvrs9luTKdSRjH1wh9tObWE7a+7ouLB2Wcnr+/9bZg?=
 =?us-ascii?Q?kOq4VleaFzmjD9W3gPrPWBryRaefBHeG4wvCkY3iKAaahd2OWxgyfsakF4rh?=
 =?us-ascii?Q?/gzHoe2bAuiRXHbxbxNkIjDsDbgFbFVw8DaHaowz7fAIb6DNl7lXGMrCqSUs?=
 =?us-ascii?Q?qYuQBE4BK+XrQ8n3/ywc5/ZsreOggqDm6BUFyOcdwhdqdP7FecL4jtdfg7zd?=
 =?us-ascii?Q?RM5p0xnmsHfoZqW1eR7lmMPK70ZxFRuUIv3rqutOxE9Fq3LJMQ2NGHDBm0EW?=
 =?us-ascii?Q?D/56dL2ILF3OWCbnI4+mU4aN124zFm5n0k1ndQfRBdIM19JXisHG0XJW6DBa?=
 =?us-ascii?Q?JJpjQqM9pGn0v4zerxUU7MPMGzCf9w2dst9UdujF+d6d9MfWyxp0L1d4IcpM?=
 =?us-ascii?Q?XRMLLpU/xJgKevpy+iYRsIVbkLTrYmlGtyfIJBkYlFQnCHvH0AU1yjXVg+3x?=
 =?us-ascii?Q?/VO7QqusbQpiuku/frwglf9RsDWyerzMMN80uIEe/bCqBiqKku0sdYdGhrzT?=
 =?us-ascii?Q?A5C7S/ewrIIYEObARAF5+AR2h6Pip5GbgTgM1dWrbdyck0nX47C2nKiHWGOb?=
 =?us-ascii?Q?K4Vu/075bSDc0LBskmxeSkoTWT6Rv8zvOKHd8W7tXdu3BYL/LrhJzH3i24wR?=
 =?us-ascii?Q?MJm1KK7+QH6+DtysfynBSvpwJOLS9NZRQGHLRGBkol0b+n4k+Hla5pr5AQFu?=
 =?us-ascii?Q?DrGlCjanEunNONSWhgeEPDud8Yk8DnHfWybXjBa5qXaMjjEO64DOu9Yxc/vz?=
 =?us-ascii?Q?A9CQgWQ9wMTqVlJ9T20IKIL/XqLIFoBYJg6e5N4gp+JtA0MJ+nYgG5642Umx?=
 =?us-ascii?Q?fYBXw8U+Ja9WcMpYkieU8NPu4/tW1snbSmE7q23c+i9FJFKJr9S/VuRfbE4M?=
 =?us-ascii?Q?BT0KxwPuePlTJ/VVBca3TzlmQHBXY9PeZB2QEVT+4hp5wO7kr+FTT9AxtQOC?=
 =?us-ascii?Q?8QKQ3GWOJlhcgRbAw5vYjy0wh77b0BUiBglVEXyfBnty4QNroWiYOEqkt9yr?=
 =?us-ascii?Q?tlwKeZWBFi+KHgHTRrqVpKv2snWDQQfVQ1FIoHwHgGsHiMtyz/cL7SRGpuES?=
 =?us-ascii?Q?BvgOQDybT9FPA7XgBf87Tqm/gm1dejCc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 18:35:00.5540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae27092e-f165-4dc8-9742-08dcd8d9c51d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7425
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
The "dpp35_dppclk_control" routine is incorrectly disabling the register clock gater
when the DPP is enabled.

The "DISPCLK_R_GATE_DISABLE" should never be set to 1 in the normal operating mode.
This will disable the clock gater and the DPPCLK register clock branch will always be running.
As a consequence, the dynamic power will be higher than expected.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c
index 8473c694bfdc..9f885a03eec6 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c
@@ -50,13 +50,11 @@ void dpp35_dppclk_control(
 				DPPCLK_RATE_CONTROL, dppclk_div,
 				DPP_CLOCK_ENABLE, 1);
 		else
-			REG_UPDATE_2(DPP_CONTROL,
-					DPP_CLOCK_ENABLE, 1,
-					DISPCLK_R_GATE_DISABLE, 1);
+			REG_UPDATE(DPP_CONTROL,
+					DPP_CLOCK_ENABLE, 1);
 	} else
-		REG_UPDATE_2(DPP_CONTROL,
-				DPP_CLOCK_ENABLE, 0,
-				DISPCLK_R_GATE_DISABLE, 0);
+		REG_UPDATE(DPP_CONTROL,
+				DPP_CLOCK_ENABLE, 0);
 }
 
 void dpp35_program_bias_and_scale_fcnv(
-- 
2.46.0

