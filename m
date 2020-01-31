Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14CEC2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 722382082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MLfsQLFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722382082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25CA56FC42;
	Fri, 31 Jan 2020 22:17:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A2056FC48
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWIcruhjllcoVpuGRMVRRrMkgCD6kLEODwh88ilv0bqknl+ZpMaOGr6ykLFiG1LVr5JdNq5sMqNNsFcJ6QRnMHFaXnDmWufpaTGQARIz99WyOlnrnPmt6RGg4Pf5Dc4R8udJU7PBDoZN5JOvYW63SW/7lBa09mM2DscPRQNBaQ6aOp0Fy17o6TRcs+sF7EA/xeeByh1hUSoRxV8T1heGEEsxr+vmqqJ1URXFx4HSnKYZfTCN1h/HdJSCscwvQsvdn3KaoGpmh80GAeKpcK2LdE4obfhdYhsEXzbXLL4cAo89eO0j9RIM0enDV56HlIsp6s9yEX6D5IVAK0ly2pYLNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCKMS0Y/omgH8jMoCvt/s7x2eHkzEQqAb90aBD0kZ2Y=;
 b=UDFegB+mTrkXP/KBWcMLbmZhuHeqTFFQnZrF+z3QUAMgf3u4D/3yiSCiMPYy0M16B2ZAjP0CuQ6OEwfTOvLCve/ARAZRmVkJuOHc5yqSp9WppbhSI+PL3l23ed2SwhqbmckPJdc3qbG6+M6qjt0xDjtqTxnBrQjpv5VAI+6qqeqWajesAcXUrhrQ47hP52P3neuIfLFzSoRhfCkotnvOorBybPzQ7MrxyKsTW9pkWPn5vUKKCY3cTJbZ9ckXXNwrstBSX9w/5hzfU3H83t8UJEnKk9gdwfuodeH6Xr0ukpMh0skBnbdHaQjrU/ruqL/e7TYkC+dG7B0nvJWzDxv9Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCKMS0Y/omgH8jMoCvt/s7x2eHkzEQqAb90aBD0kZ2Y=;
 b=MLfsQLFbNSPAPdYXfFNFvHA2YpmwsDiILt5Lyowk6N8DnWviG8ZX+w18RrJac+PD7qxLrCmjDjxAiMsP2q33Qj7mUZPS0FTnQiHUiqBHeJgejz6TY44ZNLcj032Nz9hvK9NqAFMp7ofZ1N2H9pgiCyhEc4Vts0ir8h/1TBXOrHc=
Received: from SN1PR12CA0095.namprd12.prod.outlook.com (2603:10b6:802:21::30)
 by DM5PR12MB2471.namprd12.prod.outlook.com (2603:10b6:4:b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.26; Fri, 31 Jan
 2020 22:17:22 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::201) by SN1PR12CA0095.outlook.office365.com
 (2603:10b6:802:21::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.23 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:22 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:11 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:11 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:11 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/33] drm/amd/display: Add wm ranges to clk_mgr
Date: Fri, 31 Jan 2020 17:16:34 -0500
Message-ID: <20200131221643.10035-25-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(396003)(428003)(199004)(189003)(6916009)(26005)(186003)(54906003)(336012)(316002)(426003)(7696005)(36756003)(70206006)(2616005)(70586007)(1076003)(356004)(6666004)(478600001)(4326008)(8676002)(2906002)(8936002)(81166006)(5660300002)(86362001)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2471; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0446355f-7c9f-4411-aff1-08d7a69b57b6
X-MS-TrafficTypeDiagnostic: DM5PR12MB2471:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2471E1B8596C701DB1220D30F9070@DM5PR12MB2471.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9i5ygAy8CjE7geUl8wz2ZJvtZ/qoj8JfDyapMsc1rhWRJp/I4yrei5d0YA/NvOAnSivol76+TsTgHPh1yc1pIXqSXDbpSvA4DOOCRqXVwUrgg5Z5JSH7bqp9z6E8SjE95PkXwCy8ywNwvsY+T3jxceXl1938poC058UnS/1M+1dTGiILSqP3yb8aX1qZT6gm56S3Ns6JqyFg2UOSuyk1X8f/ttbanlOEsHa+moUBFxVG2QloFxwMvTWL9WHSSPTxD0pLrngDgF/EBfaCn9TbAzCKFU58+gNYo/8AjxNtMq0Uzr9AHo4PFSLK5zYEXjuAyiSEGp+nt+W9JK1odXUWt8XVclNfXYPYUkrkQaALCQS86qRcfCinHcD8/jZdsvEoJWPftDta9CZx+Ns+h9WA/nGLFiKJV1VjyYPz6YNaa39Rk9oNq9R4gIax1Br0PLNF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:21.6325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0446355f-7c9f-4411-aff1-08d7a69b57b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2471
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, Sung Lee <sung.lee@amd.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY & HOW]
Having watermark ranges saved inside clk_mgr to be
available for debug at all times would be useful.
Add it to the clk_mgr_internal struct for reference.
Only populated for Renoir, unused for other asics.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 5 ++---
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h           | 2 ++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 034a5852a416..8ecb98c29eb9 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -459,16 +459,15 @@ void build_watermark_ranges(struct clk_bw_params *bw_params, struct pp_smu_wm_ra
 static void rn_notify_wm_ranges(struct clk_mgr *clk_mgr_base)
 {
 	struct dc_debug_options *debug = &clk_mgr_base->ctx->dc->debug;
-	struct pp_smu_wm_range_sets ranges = {0};
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct pp_smu_funcs *pp_smu = clk_mgr->pp_smu;
 
 	if (!debug->disable_pplib_wm_range) {
-		build_watermark_ranges(clk_mgr_base->bw_params, &ranges);
+		build_watermark_ranges(clk_mgr_base->bw_params, &clk_mgr_base->ranges);
 
 		/* Notify PP Lib/SMU which Watermarks to use for which clock ranges */
 		if (pp_smu && pp_smu->rn_funcs.set_wm_ranges)
-			pp_smu->rn_funcs.set_wm_ranges(&pp_smu->rn_funcs.pp_smu, &ranges);
+			pp_smu->rn_funcs.set_wm_ranges(&pp_smu->rn_funcs.pp_smu, &clk_mgr_base->ranges);
 	}
 
 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index ac530c057ddd..ce65678c03b2 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -27,6 +27,7 @@
 #define __DAL_CLK_MGR_H__
 
 #include "dc.h"
+#include "dm_pp_smu.h"
 
 #define DCN_MINIMUM_DISPCLK_Khz 100000
 #define DCN_MINIMUM_DPPCLK_Khz 100000
@@ -193,6 +194,7 @@ struct clk_mgr {
 	int dentist_vco_freq_khz;
 	struct clk_state_registers_and_bypass boot_snapshot;
 	struct clk_bw_params *bw_params;
+	struct pp_smu_wm_range_sets ranges;
 };
 
 /* forward declarations */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
