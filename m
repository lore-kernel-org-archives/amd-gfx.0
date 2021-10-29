Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF4AC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63AE6610FD
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 63AE6610FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0945E6E11F;
	Fri, 29 Oct 2021 15:15:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A71E6E11F
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 15:15:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWbAtwFJ5MUAx+B5po1K0Ozsz/K5Q+LuA1SF9k0Tg5/toard21XxzjPwtkfb6tH5zXiMX87zYWN/rFdFY2mJinljdhfO3GVOkTuDw+c0V4RRAz2wX/yWlkc3ALOPW3LHfyROW3VB6aViDAmyVJ88YRjSCeyLV7MT0AvGsGXsJ8uEf8kswYYGoJIXQvGC4kMYbGINTMyPOlHHE/0zRLkqQTy/9ewb2pd1ZWTTHsx+u9U1FcRfnI9CS0tPONux9sEvJHimyDzEB1Ry580ULJM80uO/rHWSySLujCBx5xbqZP2SUApAQzrJVQJX+mECjHKHI4VSQVz2jkEa8ihO/g+64g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cxsE+XCC62ZUSTT8gzprBgtxNPcytv/pv4YGhdm7Ws=;
 b=NcKcpJAOn1+9n7N8vMe2ZBNzYXLDguznRV8H39KIKaao1058X4XjzLBQQ0JjVaQ2VfW3QsYLSjyaFdoLoIleUbsW+3zUyUgq3xZiE/A0H3udPlt7esKxEW6hEhTMPUwYwseZtOedCHszsBlm8GV1NQhfhbbsUOpQJEZ/R1JsjUyyyNr5+h7HsC0+C+CyOY+vahGp/e8TVYUJbza4dSxrsanToG0g//ShIFnSNv76qsNYPFyxPvycwLdovn1ZOBtJ7WMmD01TAvtkCDUQHc1dVLabHLewly8d9a8LUmmEFZPFrIAD+1ysXh/RjhAxV6LmMXKcOBMcFGqMWYMZANXOTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cxsE+XCC62ZUSTT8gzprBgtxNPcytv/pv4YGhdm7Ws=;
 b=0jZtbJEdw22vavZg0LX6puSSg5OHHDRv7Yfs/A/AwuTm5FqgGofYmqTHQvfHGZjxil9DMfkhdV27+SixgZy8+IQIL8phqKLxx5V2qEUTQRCv3EmxrIPjtcJoW1lbyH07w74M7dhBT9/iHtRMJckEX2Xz5nEkX8HYM8RoM+lwULM=
Received: from BN0PR04CA0079.namprd04.prod.outlook.com (2603:10b6:408:ea::24)
 by DM5PR12MB1308.namprd12.prod.outlook.com (2603:10b6:3:76::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Fri, 29 Oct 2021 15:15:07 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::28) by BN0PR04CA0079.outlook.office365.com
 (2603:10b6:408:ea::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Fri, 29 Oct 2021 15:15:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 15:15:06 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 10:15:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 08:15:06 -0700
Received: from elite-desk-aura.lan (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Fri, 29 Oct 2021 10:15:05 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Felipe Clark <felclark@amd.com>, Jun Lei
 <Jun.Lei@amd.com>
Subject: [PATCH 03/14] drm/amd/display: Fix dummy p-state hang on monitors
 with extreme timing
Date: Fri, 29 Oct 2021 11:14:45 -0400
Message-ID: <20211029151456.955294-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211029151456.955294-1-aurabindo.pillai@amd.com>
References: <20211029151456.955294-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecdc10d8-e5f8-41b5-f7ff-08d99aeee424
X-MS-TrafficTypeDiagnostic: DM5PR12MB1308:
X-Microsoft-Antispam-PRVS: <DM5PR12MB13080AE995ED490569AE22538B879@DM5PR12MB1308.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OwnGIpF3ZbQUyORdEUlQu25DcnYLFoUzFtYHY1zYgzHUIQoF96d58XqUHdzqlNaYGg7Y/80ChZexcEBdNJyWIaUpcYCGJocELfr1+ZkT3VtNLrXm7fkIOckfbL0Y9aOEqkfJrvxHawkJ7PNndTncqXRETV3KfxlHqIk5Q0prBlVps32pIgKE+wx1VShbl/hGvV/bJoUf6U+oILcqjxF2oY0LSV9FPsOba58lhzKlEK1pBJyE+w7uv9hpN/rwWmWJ3NH1Bl0U5mp2Dv9AI7T4pVZO8dum8AYT4VH9ukMxTifDw7uNIe4kduPDHo3asJqb0DCruqzQdbqC6jWPo2Yi8H6Wy6hym4+ewOvsc3i6NzNCOQDvWKXa1fyzjvej7q/1/jTj9Il5IrU8g1L9y4UyRnxeCynOkRvfy9I/pEuWWjl4fIXJcv/1uDmDqvfvPJSx099ynIQGM2GTD07Cw1sNWTVrNTvF3vupdjWaOWGqpdNGyJFGiQLYy3Ty/q22cfWpncFJNUia5mwY0/6W4F8ONsZhNQ4xndsjxWYwjOH8ENFQYlKlOiCEjaPAFgSHI2Xe1mFW+bd09/+OVZA+fntLCdWUg2UMmctlWyoRsAQQwK2K7+rnzcAM/4S57qZIssn6GSir938C4mFIufzMGryf7qew8rdlpqth7Vi8qP+lU5lY3ovL4cgRe35D3E5Xi/S+Zak166Eq/hBEr1O8BLv/zEcJn7VGsfZ1JsKGCE2tixvonsvxd/2EoQOLfqwbV0Gt+HaDkZzc+5ETDEcM+EOJEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70206006)(70586007)(2906002)(6916009)(83380400001)(5660300002)(186003)(8676002)(86362001)(336012)(26005)(8936002)(82310400003)(54906003)(316002)(4326008)(36756003)(356005)(47076005)(81166007)(44832011)(6666004)(1076003)(508600001)(2616005)(426003)(36860700001)(117716001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 15:15:06.9728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecdc10d8-e5f8-41b5-f7ff-08d99aeee424
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1308
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

From: Felipe Clark <felclark@amd.com>

[WHY]
It was found that the system would hang on a dummy pstate when playing
4k60 videos on a 1080p 390Hz monitor.

[HOW]
Properly select the dummy_pstate_latency_ms when firmware assisted
memory clock switching is enabled instead of assuming that the highest
latency would work for every monitor timing.

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Felipe Clark <felclark@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index e50c695e3c96..79a66e0c4303 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2128,10 +2128,10 @@ static noinline void dcn30_calculate_wm_and_dlg_fp(
 		int pipe_cnt,
 		int vlevel)
 {
+	int maxMpcComb = context->bw_ctx.dml.vba.maxMpcComb;
 	int i, pipe_idx;
-	double dcfclk = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
-	bool pstate_en = context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] !=
-			dm_dram_clock_change_unsupported;
+	double dcfclk = context->bw_ctx.dml.vba.DCFCLKState[vlevel][maxMpcComb];
+	bool pstate_en = context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcComb] != dm_dram_clock_change_unsupported;
 
 	if (context->bw_ctx.dml.soc.min_dcfclk > dcfclk)
 		dcfclk = context->bw_ctx.dml.soc.min_dcfclk;
@@ -2207,6 +2207,7 @@ static noinline void dcn30_calculate_wm_and_dlg_fp(
 		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_enter_plus_exit_time_us;
 		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_exit_time_us;
 	}
+
 	context->bw_ctx.bw.dcn.watermarks.c.urgent_ns = get_wm_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-- 
2.30.2

