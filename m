Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2D2E87834
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 15:13:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A96C810E6B4;
	Tue,  3 Feb 2026 15:13:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UsxJtFhw";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA75710E6B6
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 15:13:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIMxo7bzidluzcqMh+Q7zNva24rdkL+wgwQSocDS/RGdoX+gMEpKwycJCIJTs08giWDsXO2Zle71rvQ3WXcXc4RzJxnOH3sTxm7fSL8GExdAnAyZgyGUB3pdYtcr2pJgc7QTRdzoO5yi6HltMwGF2F4B1p+2dHzo1WL0LTFvAmhbAl7W/agJ+WDEf9DSSbcWSh28AT2RWMOL+rgT0MawU7jVnpEqEz+2LABtbsqq+nD8OxmnbOzPFQ9qqAhzsa3ZS5ZjmK2dZ9LxONU4ZLfrUgeKfSP2asDl4jpN0VS21W8B5GLN/dKW59rfZjv8DuutVu15BeAHpNtIm1hN2aK8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqP6IGSNPcO9sxiz0PIe2sFsAzIYE0z801UYYmIb/Pw=;
 b=KqxEnPxv0seZuVm8XTz88IAgHkGYXqozpILcrlqYs3yw5iFS8nq5fkPzlomXylN7C7qqtD3+fpwOmHGB9uENxOZ8xOvljG5WeSOq1Ph4FsZnmxG4DZ92myzXpKjlTy/0ja7fefBoeXLe3M1v8mj9muwftlLnWobEaXzHgnf2N5ZVRFpVpA8ZbA7xt1TGtKAl2TdrwpTDLs95JYjnday+jh3zV8LZ0kTnKogXI1qI5o5HlohM83ZS4FtTsPLdsz/7lxVa/AxgXuv/WHWt3lJ3lGNkYH0Ba//PVVFrV3vktdV9NzXYp8xa/UkETe3jMqKUbqqH3LEPyiElTdCV6u0LYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqP6IGSNPcO9sxiz0PIe2sFsAzIYE0z801UYYmIb/Pw=;
 b=UsxJtFhw7hg4a/Q5V5ErdzoDIX7lkTqbp7KMdqaJruounTB3kBCWAl4oiI1vvun+kh54qLWygMWLpkeo7GpAQ4xERyDF70fj+X7TnJjsDZv9dJaHaY9ng5nt4WxyxFV3rn5CvOEjgI/jxQop3g1ghlOhVBTYgeuvEMO2BeJHwbI=
Received: from BYAPR05CA0091.namprd05.prod.outlook.com (2603:10b6:a03:e0::32)
 by PH8PR12MB7373.namprd12.prod.outlook.com (2603:10b6:510:217::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:13:44 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::d8) by BYAPR05CA0091.outlook.office365.com
 (2603:10b6:a03:e0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 15:13:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 15:13:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 09:13:42 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 07:13:42 -0800
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 07:13:38 -0800
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Carbones <ncarbone@amd.com>, Joshua Aberback
 <joshua.aberback@amd.com>
Subject: [PATCH 11/16] drm/amd/display: Revert "Migrate DCCG register access
 from hwseq to dccg component."
Date: Tue, 3 Feb 2026 23:01:53 +0800
Message-ID: <20260203151229.3673042-12-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
References: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|PH8PR12MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 8317e072-f2e5-4a10-26e2-08de6336d275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yVQNgMSyo/e47hkrOVHI/yc7rO+cUwixkxMOc+C/T4ruYLSrdTgdlycMIPJe?=
 =?us-ascii?Q?hRt7ZVuBCN5m5+MJTuOalEqQoW2qxN+rhDLT/dJ4l25cbc4xVdmBuf4jKQS0?=
 =?us-ascii?Q?Aums1Ncm3R/YStus9X/n9lfmFr+9ZpEgu9sqyXlLATqLPKfEmN1TVRqXeUYF?=
 =?us-ascii?Q?QHDsMWxDNKDPoN2mxrEqwdJB59i3C+CFfRB71q2t5qM/V+fos1g3n9rtpZ2r?=
 =?us-ascii?Q?wy/HvudJGketOsGIkFixod5QKlzuMwMWjsFN8Mt4P5ZHpw69GlAQLR0t0lV+?=
 =?us-ascii?Q?MnhVwNDBqmyY4zE9fGk6Oq43/RiQmX3zJUKEJYX+f23ollrw+p+iC2/6aB+8?=
 =?us-ascii?Q?yRmSoNVQokRk9neenAF1Vlfx2dkkPXu1RJxjzscxfm8CgUbGrz3xByk8aj2d?=
 =?us-ascii?Q?cOx8KIknxlymY8zVdEOtCxw+i035urjsx5qegiZRJ17nm0GOqW4YRrGnawH6?=
 =?us-ascii?Q?pf4ztU2LWphbTUrQHfdKO/g+y8fXKtF+c2gts5bBJzHriHNDK11sSlwqt+TI?=
 =?us-ascii?Q?vLyiN3kTrQWgHzkyrkYuQOxQIK8CYWHZMbrAT2uxEKF+G9/Edcq0RCEoyEmB?=
 =?us-ascii?Q?FhwXmD9utniCelv0vvjAuHPUomsDbfOjtWr9axIws16YL4rP6Gw5VjzyFK/7?=
 =?us-ascii?Q?rLExh50F/EBLa0eTlPyC9vIFb+5HE7cTSEfN7BSdS+DiNyZjINeot4HVDuGb?=
 =?us-ascii?Q?B4zjHaK1xH6cULhiwFPznWpbsgK1GLErTc3MlYOV0JGtSmMiZHO8xyLYVWK2?=
 =?us-ascii?Q?oB2vLXNVLB+KH+HDfAWQRvs5VyjVhZgYItLbYXwSVAyYYcjnGV6Fu7iJo5NE?=
 =?us-ascii?Q?wXZWxzkxbJ3P9wRzV2w0pyYOge+vI/aHuiYjwAAVCg1IJFsJsdKjLQIANgLD?=
 =?us-ascii?Q?iGo4o16HGswssFCWIitXZ+4PGVXHfLHkhaHjJQBteXWeFvwFCKYec8lHlwb1?=
 =?us-ascii?Q?5kwf/0emicYX6ng9a/gQ0BxDH5RRacXNwa1o4p4wmFXY/o1pyCScn0cYjlTC?=
 =?us-ascii?Q?CUa0a9syhYGjiOCY8GkBPWuKryZJ+4nub41zVYM0FW4F8wSrwo4ocSG58PI/?=
 =?us-ascii?Q?CMb1oelMq1vu4u521sV1N5SA3jWOipfMoCB8E5MKoqjVx3fSxrnvbln2dPaB?=
 =?us-ascii?Q?0NqFM5e47PTKytpMVh3MQYIdjfd01ZApuIzKwgXomPwGrvtNm+I7Y8XLFJGP?=
 =?us-ascii?Q?iyfctxrYBn1HmmQScVZKcpnTS3NcRZ2uC4df9ElIj2UpdDJP0jaUqUlH9+zd?=
 =?us-ascii?Q?ZtmZTZqM7Syd2fm3+hQeqE2VSsu+XIWb9Z6L11mqM1ImnmXWR9AQ+iTrh6yP?=
 =?us-ascii?Q?ltW66W92AF5blApVD5ngIIZdgjxlIcXBc9ZZqa8IKA2Rj9MI6ohdcjPUg2wR?=
 =?us-ascii?Q?aM3oOYTVH15pv/hmls4enu1H+Y/ojMgWovoVQZOfLimVuCPAJ6Ma+pxGRZcR?=
 =?us-ascii?Q?2XcQgrokdPjzFNYDIBqYAhWpTrPFUJR0lKaM4zIBdK4P4Wzs0GsBl1s8HQk3?=
 =?us-ascii?Q?dSP49rpgVYx0UIOMgUASpI22hxo4xgGoCTp9VJPmg74oESNpFx/maryjmFox?=
 =?us-ascii?Q?pBj4p0RKk7/7t/Zhxw/WLVqZky8tzqzxgyE2vvw1uAQv6wMN5dpdVGsUK1UL?=
 =?us-ascii?Q?7k86Sd1NfZO9BPNBcPHNaWoftoX8BwLC7UYYZNR2WFtFse0nNoigvyhPWHLl?=
 =?us-ascii?Q?l77Myg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0/fZhhb1yaLbQeuBQrPRnQGwZ4Q+XwkKp6b/FJo2CE3r+YhwXCLBxVNliBen2Mvlnlqyp2tVxaoqvIIB2YqbrDZnoezDBxm/2lGK3aaiIg8/QPiQWYsuIJMJnOsWbwruempyBj1G3mgsphGc1FEbQIsIEgU18K7X3RCVwbcYSAeVmGslE5IzpHyZb8yIqGTRXtLTPWeBpdOsztBLSHekNUbbRxvXZToKVbgNSAboGjdLp5NbKoDBt8znEVl7xalctZFJ0GdoInRKW5oujGL6LSxc+SOe0+CoiLy4SwuTuwD8YX3i8WNQ2SaZ4N/cqO8vCriQiT86RaJgX0vxK14kHh0/6P4YIDYhWrFBmRJbh18CHUI3EkoJBxQ6WRJ5PuGeGpba/LDGqULhY8Lr1W8Zk7wYBrl6SFCULRUO7AmyQYot7UG45qHbw8q5NuBrYdJ9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:13:44.2092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8317e072-f2e5-4a10-26e2-08de6336d275
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7373
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

From: Nicholas Carbones <ncarbone@amd.com>

[Why & How]
This reverts commit a90acf60ab9dc283d0a13ede90e393c702a985c7, which
causes regressions related to HDCP when resuming from S3.

Reviewed-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Nicholas Carbones <ncarbone@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.c    | 54 +------------------
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    | 18 ++-----
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  5 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 29 +++++++---
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c |  5 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |  9 ++--
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  5 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  5 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  5 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  3 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  5 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  4 --
 12 files changed, 49 insertions(+), 98 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c
index 50b98822b6fd..33d8bd91cb01 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c
@@ -131,54 +131,6 @@ void dccg2_otg_drop_pixel(struct dccg *dccg,
 
 void dccg2_init(struct dccg *dccg)
 {
-	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
-
-	/* Hardcoded register values for DCN20
-	 * These are specific to 100Mhz refclk
-	 * Different ASICs with different refclk may override this in their own init
-	 */
-	REG_WRITE(MICROSECOND_TIME_BASE_DIV, 0x00120264);
-	REG_WRITE(MILLISECOND_TIME_BASE_DIV, 0x001186a0);
-	REG_WRITE(DISPCLK_FREQ_CHANGE_CNTL, 0x0e01003c);
-
-	if (REG(REFCLK_CNTL))
-		REG_WRITE(REFCLK_CNTL, 0);
-}
-
-void dccg2_refclk_setup(struct dccg *dccg)
-{
-	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
-
-	/* REFCLK programming that must occur after hubbub initialization */
-	if (REG(REFCLK_CNTL))
-		REG_WRITE(REFCLK_CNTL, 0);
-}
-
-bool dccg2_is_s0i3_golden_init_wa_done(struct dccg *dccg)
-{
-	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
-
-	return REG_READ(MICROSECOND_TIME_BASE_DIV) == 0x00120464;
-}
-
-void dccg2_allow_clock_gating(struct dccg *dccg, bool allow)
-{
-	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
-
-	if (allow) {
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);
-	} else {
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0xFFFFFFFF);
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0xFFFFFFFF);
-	}
-}
-
-void dccg2_enable_memory_low_power(struct dccg *dccg, bool enable)
-{
-	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
-
-	REG_UPDATE(DC_MEM_GLOBAL_PWR_REQ_CNTL, DC_MEM_GLOBAL_PWR_REQ_DIS, enable ? 0 : 1);
 }
 
 static const struct dccg_funcs dccg2_funcs = {
@@ -187,11 +139,7 @@ static const struct dccg_funcs dccg2_funcs = {
 	.set_fifo_errdet_ovr_en = dccg2_set_fifo_errdet_ovr_en,
 	.otg_add_pixel = dccg2_otg_add_pixel,
 	.otg_drop_pixel = dccg2_otg_drop_pixel,
-	.dccg_init = dccg2_init,
-	.refclk_setup = dccg2_refclk_setup, /* Deprecated - for backward compatibility only */
-	.allow_clock_gating = dccg2_allow_clock_gating,
-	.enable_memory_low_power = dccg2_enable_memory_low_power,
-	.is_s0i3_golden_init_wa_done = dccg2_is_s0i3_golden_init_wa_done
+	.dccg_init = dccg2_init
 };
 
 struct dccg *dccg2_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
index 237a684ded86..8bdffd9ff31b 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
@@ -46,9 +46,7 @@
 	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 2),\
 	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 3),\
 	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 4),\
-	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 5),\
-	SR(DCCG_GATE_DISABLE_CNTL),\
-	SR(DCCG_GATE_DISABLE_CNTL2)
+	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 5)
 
 #define DCCG_SF(reg_name, field_name, post_fix)\
 	.field_name = reg_name ## __ ## field_name ## post_fix
@@ -83,8 +81,7 @@
 	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, ADD_PIXEL, 0, mask_sh),\
 	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, ADD_PIXEL, 1, mask_sh),\
 	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, DROP_PIXEL, 0, mask_sh),\
-	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, DROP_PIXEL, 1, mask_sh),\
-	DCCG_SF(DC_MEM_GLOBAL_PWR_REQ_CNTL, DC_MEM_GLOBAL_PWR_REQ_DIS, mask_sh)
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, DROP_PIXEL, 1, mask_sh)
 
 
 
@@ -133,8 +130,7 @@
 	type DISPCLK_CHG_FWD_CORR_DISABLE;\
 	type DISPCLK_FREQ_CHANGE_CNTL;\
 	type OTG_ADD_PIXEL[MAX_PIPES];\
-	type OTG_DROP_PIXEL[MAX_PIPES];\
-	type DC_MEM_GLOBAL_PWR_REQ_DIS;
+	type OTG_DROP_PIXEL[MAX_PIPES];
 
 #define DCCG3_REG_FIELD_LIST(type) \
 	type HDMICHARCLK0_EN;\
@@ -519,14 +515,6 @@ void dccg2_otg_drop_pixel(struct dccg *dccg,
 
 void dccg2_init(struct dccg *dccg);
 
-void dccg2_refclk_setup(struct dccg *dccg);
-
-bool dccg2_is_s0i3_golden_init_wa_done(struct dccg *dccg);
-
-void dccg2_allow_clock_gating(struct dccg *dccg, bool allow);
-
-void dccg2_enable_memory_low_power(struct dccg *dccg, bool enable);
-
 struct dccg *dccg2_create(
 	struct dc_context *ctx,
 	const struct dccg_registers *regs,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 5243177c1faa..9613d1ceb5dc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1887,8 +1887,9 @@ void dcn10_init_hw(struct dc *dc)
 
 	if (!dc->debug.disable_clock_gate) {
 		/* enable all DCN clock gating */
-		if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->allow_clock_gating)
-			dc->res_pool->dccg->funcs->allow_clock_gating(dc->res_pool->dccg, true);
+		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
+
+		REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);
 
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 307e8f8060e6..0ee3a0041c61 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -357,10 +357,26 @@ void dcn20_enable_power_gating_plane(
 
 void dcn20_dccg_init(struct dce_hwseq *hws)
 {
-	struct dc *dc = hws->ctx->dc;
+	/*
+	 * set MICROSECOND_TIME_BASE_DIV
+	 * 100Mhz refclk -> 0x120264
+	 * 27Mhz refclk -> 0x12021b
+	 * 48Mhz refclk -> 0x120230
+	 *
+	 */
+	REG_WRITE(MICROSECOND_TIME_BASE_DIV, 0x120264);
+
+	/*
+	 * set MILLISECOND_TIME_BASE_DIV
+	 * 100Mhz refclk -> 0x1186a0
+	 * 27Mhz refclk -> 0x106978
+	 * 48Mhz refclk -> 0x10bb80
+	 *
+	 */
+	REG_WRITE(MILLISECOND_TIME_BASE_DIV, 0x1186a0);
 
-	if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->dccg_init)
-		dc->res_pool->dccg->funcs->dccg_init(dc->res_pool->dccg);
+	/* This value is dependent on the hardware pipeline delay so set once per SOC */
+	REG_WRITE(DISPCLK_FREQ_CHANGE_CNTL, 0xe01003c);
 }
 
 void dcn20_disable_vga(
@@ -3140,11 +3156,8 @@ void dcn20_fpga_init_hw(struct dc *dc)
 
 	dcn10_hubbub_global_timer_enable(dc->res_pool->hubbub, true, 2);
 
-	if (hws->funcs.dccg_init)
-		hws->funcs.dccg_init(hws);
-
-	if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->refclk_setup)
-		dc->res_pool->dccg->funcs->refclk_setup(dc->res_pool->dccg);
+	if (REG(REFCLK_CNTL))
+		REG_WRITE(REFCLK_CNTL, 0);
 	//
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
index ce18d75fd991..6298bd87a18b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
@@ -367,8 +367,9 @@ void dcn201_init_hw(struct dc *dc)
 
 	if (!dc->debug.disable_clock_gate) {
 		/* enable all DCN clock gating */
-		if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->allow_clock_gating)
-			dc->res_pool->dccg->funcs->allow_clock_gating(dc->res_pool->dccg, true);
+		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
+
+		REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);
 
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index 062745389d9a..e2269211553c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -33,7 +33,6 @@
 #include "vmid.h"
 #include "reg_helper.h"
 #include "hw/clk_mgr.h"
-#include "hw/dccg.h"
 #include "dc_dmub_srv.h"
 #include "abm.h"
 #include "link_service.h"
@@ -88,10 +87,12 @@ int dcn21_init_sys_ctx(struct dce_hwseq *hws, struct dc *dc, struct dc_phy_addr_
 
 bool dcn21_s0i3_golden_init_wa(struct dc *dc)
 {
-	if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->is_s0i3_golden_init_wa_done)
-		return !dc->res_pool->dccg->funcs->is_s0i3_golden_init_wa_done(dc->res_pool->dccg);
+	struct dce_hwseq *hws = dc->hwseq;
+	uint32_t value = 0;
 
-	return false;
+	value = REG_READ(MICROSECOND_TIME_BASE_DIV);
+
+	return value != 0x00120464;
 }
 
 void dcn21_exit_optimized_pwr_state(
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index d58f2cf2615c..cfabda421eb5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -800,8 +800,9 @@ void dcn30_init_hw(struct dc *dc)
 
 	if (!dc->debug.disable_clock_gate) {
 		/* enable all DCN clock gating */
-		if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->allow_clock_gating)
-			dc->res_pool->dccg->funcs->allow_clock_gating(dc->res_pool->dccg, true);
+		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
+
+		REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);
 
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index db2f7cbb12ff..fa35d538a10a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -247,8 +247,9 @@ void dcn31_init_hw(struct dc *dc)
 
 	if (!dc->debug.disable_clock_gate) {
 		/* enable all DCN clock gating */
-		if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->allow_clock_gating)
-			dc->res_pool->dccg->funcs->allow_clock_gating(dc->res_pool->dccg, true);
+		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
+
+		REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);
 
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 37300e12e645..11f32dcc0a3e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -961,8 +961,9 @@ void dcn32_init_hw(struct dc *dc)
 
 	if (!dc->debug.disable_clock_gate) {
 		/* enable all DCN clock gating */
-		if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->allow_clock_gating)
-			dc->res_pool->dccg->funcs->allow_clock_gating(dc->res_pool->dccg, true);
+		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
+
+		REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);
 
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index b5a4cefbd35f..0cbd75ab61a1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -286,8 +286,7 @@ void dcn35_init_hw(struct dc *dc)
 	}
 
 	if (dc->debug.disable_mem_low_power) {
-		if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->enable_memory_low_power)
-			dc->res_pool->dccg->funcs->enable_memory_low_power(dc->res_pool->dccg, false);
+		REG_UPDATE(DC_MEM_GLOBAL_PWR_REQ_CNTL, DC_MEM_GLOBAL_PWR_REQ_DIS, 1);
 	}
 	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
 		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 9cda39d0ed95..55b22439cf1b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -326,8 +326,9 @@ void dcn401_init_hw(struct dc *dc)
 
 	if (!dc->debug.disable_clock_gate) {
 		/* enable all DCN clock gating */
-		if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->allow_clock_gating)
-			dc->res_pool->dccg->funcs->allow_clock_gating(dc->res_pool->dccg, true);
+		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
+
+		REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);
 
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index a26d31ab7cba..1e6ffd86a4c0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -224,9 +224,6 @@ struct dccg_funcs {
 	void (*otg_drop_pixel)(struct dccg *dccg,
 			uint32_t otg_inst);
 	void (*dccg_init)(struct dccg *dccg);
-	void (*refclk_setup)(struct dccg *dccg); /* Deprecated - for backward compatibility only */
-	void (*allow_clock_gating)(struct dccg *dccg, bool allow);
-	void (*enable_memory_low_power)(struct dccg *dccg, bool enable);
 	void (*set_dpstreamclk_root_clock_gating)(
 			struct dccg *dccg,
 			int dp_hpo_inst,
@@ -337,7 +334,6 @@ struct dccg_funcs {
 	void (*dccg_root_gate_disable_control)(struct dccg *dccg, uint32_t pipe_idx, uint32_t disable_clock_gating);
 	void (*dccg_read_reg_state)(struct dccg *dccg, struct dcn_dccg_reg_state *dccg_reg_state);
 	void (*dccg_enable_global_fgcg)(struct dccg *dccg, bool enable);
-	bool (*is_s0i3_golden_init_wa_done)(struct dccg *dccg);
 };
 
 #endif //__DAL_DCCG_H__
-- 
2.43.0

