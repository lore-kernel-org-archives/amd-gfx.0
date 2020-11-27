Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911AFC63798
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 14:11:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96561206B5
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 14:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kFAYQu9y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96561206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AC316EDE0;
	Fri, 27 Nov 2020 14:11:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54F106EDDE
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2020 14:11:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXYNT9Ezgnoi4MHHhtALfqSHp4Q1v7jQScYw/g3ltexDktwmk0+AeiP9AOtQraNKTnefStOLTYaAblkolz3SsvMFcrbUPYeVWiaeXnpnmcFIB/MzOu1PNBeJuEJJXeqMWeQWQZF1MUpZefeKmoTbo+06/YpGDOSCU1z3Mrg+ZdZuEWf0yxkLC96p+LAVSb4/U9Zz7GRA9o2bLa0ya6+cl7cFWWLS0vhPQ0RXGuk6eHeMcvqiZ8lLNTzpNN6gm0R2xHEclZGifx6pdq6a0WWLwxoEnxwcprkV20y9P1rk6MVI4zI6gCqodmSjy04XIQUjjxQKBjlkgDaix7YOvdWfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eeoq+2A6RWC8OM+ZTMlK3yEhbdYWv4BBRZQKNyqFWAI=;
 b=kBWM6MBkD3qTvVHquQ/2EUL+s9Q/sblu5eJ8oOkocSVkN9hTk1l5i4WxI6h0vpwUOrY3Y1K8i5zXsfg3fEOVwdhrQQf25nLrVhadeSUbLOYCkCP1zd5FNpvifoMY2uYEdTHeZGFg8ks9rYRAoPzDmV+mUuFdeCofaJqo7SoeNEaABwnKQXUP6sZFTtHmxLFlgiZnxB4EFMWnFM2gCHyyEhLBRtLJdheq71ANR9gq70V9xaUDcwMMiRX019WXb+vjth+74DLgiDd6LggRIZZBTG9s5OOlSBFFwcxqAnvi/HRPCfb1M8d/VMWJ/PMKKlFZDtmR2Jus7oh5kguaKddLJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eeoq+2A6RWC8OM+ZTMlK3yEhbdYWv4BBRZQKNyqFWAI=;
 b=kFAYQu9ydFDHVWaSO2x/yyiPI0QZ/nY7EOHdPBpfUJy35M7DXe787HkioHpnE2Q8l2Ny5scKo/PCEhcepvPAgMemWtMj20CXt8D3owPngFhsdTm0a87jah0aSFad1ZJCcS/5rAHqc6wZvcsDw/lOXxvDMLb3KoEJG/ql8I3dhX8=
Received: from MWHPR02CA0018.namprd02.prod.outlook.com (2603:10b6:300:4b::28)
 by BY5PR12MB3954.namprd12.prod.outlook.com (2603:10b6:a03:1af::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.21; Fri, 27 Nov
 2020 14:11:16 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:4b:cafe::68) by MWHPR02CA0018.outlook.office365.com
 (2603:10b6:300:4b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Fri, 27 Nov 2020 14:11:16 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.25 via Frontend Transport; Fri, 27 Nov 2020 14:11:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 27 Nov
 2020 08:11:14 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 27 Nov
 2020 08:11:14 -0600
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 27 Nov 2020 08:11:08 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/11] drm/amd/display: Revert update clk_mgr for vg
Date: Fri, 27 Nov 2020 09:10:58 -0500
Message-ID: <20201127141107.7731-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127141107.7731-1-aurabindo.pillai@amd.com>
References: <20201127141107.7731-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db0a4f06-56d3-44d1-dce8-08d892de4dd3
X-MS-TrafficTypeDiagnostic: BY5PR12MB3954:
X-Microsoft-Antispam-PRVS: <BY5PR12MB39543DE41963576B879C7BDE8BF80@BY5PR12MB3954.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:15;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AFV+xaBJ3e9ASncAyxnJCu+f8N/X9aDMlnl7IhQBDUof9QZwHyHnTIizpFL3t/n7vXPBaisALfnUElzV4RzJyXcl/EYk30pbeqIBn4oN+d4ZPH6pXyzefTwNHdSm8j7oVjjbYYCOW0U43XTSBJtR6R6MUzTPM6yo4QIXCEFhQ8QSCyT8J1wq2Y9RtN8s6dTpPhIz6iCzvNl6eTfEiyNsX3qg5py1NB+CaI6M55M0ywFRJ3yQmCm0wubBE0XVg0VoMvoOa7jyjzF440kGNCR8T1PfcmRIvCoV4yGS143nnMtx3qKsHei2c0E/naQCDppaopVZz0OevJ/TbBk10K0WpmD8k+b9gFUsBsOBm4Z2bmeQ9kazVBsTPVVLRB7Mg+pTzYE60exfmDzJm3IXa0+2og==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966005)(36756003)(6666004)(44832011)(316002)(70206006)(478600001)(26005)(70586007)(6916009)(7696005)(8936002)(4326008)(54906003)(186003)(5660300002)(82310400003)(356005)(2616005)(81166007)(47076004)(83380400001)(82740400003)(1076003)(8676002)(2906002)(336012)(86362001)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 14:11:15.7391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db0a4f06-56d3-44d1-dce8-08d892de4dd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3954
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
Cc: Eric Yang <eric.yang2@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Eric Bernstein <eric.bernstein@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <Eric.Bernstein@amd.com>

This reverts commit 15033eeab3f1b6177d87ae353c3d9b554b1d4b53.
It caused a regression in internal FPGA tests.

Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c |  8 ++++----
 .../gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.h | 10 ----------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
index 9a8e66bba9c0..98cbb0ac095c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
@@ -32,9 +32,9 @@
 // For dcn20_update_clocks_update_dpp_dto
 #include "dcn20/dcn20_clk_mgr.h"
 
-
-
 #include "vg_clk_mgr.h"
+
+#include "dcn301_smu.h"
 #include "reg_helper.h"
 #include "core_types.h"
 #include "dm_helpers.h"
@@ -631,7 +631,7 @@ static unsigned int find_dcfclk_for_voltage(const struct vg_dpm_clocks *clock_ta
 	return 0;
 }
 
-void vg_clk_mgr_helper_populate_bw_params(
+static void vg_clk_mgr_helper_populate_bw_params(
 		struct clk_mgr_internal *clk_mgr,
 		struct integrated_info *bios_info,
 		const struct vg_dpm_clocks *clock_table)
@@ -709,7 +709,7 @@ static struct vg_dpm_clocks dummy_clocks = {
 
 static struct watermarks dummy_wms = { 0 };
 
-void vg_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr,
+static void vg_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr,
 		struct smu_dpm_clks *smu_dpm_clks)
 {
 	struct vg_dpm_clocks *table = smu_dpm_clks->dpm_clks;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.h
index b5115b3123a1..80497df20ba7 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.h
@@ -39,15 +39,5 @@ void vg_clk_mgr_construct(struct dc_context *ctx,
 
 void vg_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr);
 
-#include "dcn301_smu.h"
 void vg_notify_wm_ranges(struct clk_mgr *clk_mgr_base);
-
-void vg_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr,
-		struct smu_dpm_clks *smu_dpm_clks);
-
-void vg_clk_mgr_helper_populate_bw_params(
-		struct clk_mgr_internal *clk_mgr,
-		struct integrated_info *bios_info,
-		const struct vg_dpm_clocks *clock_table);
-
 #endif //__VG_CLK_MGR_H__
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
