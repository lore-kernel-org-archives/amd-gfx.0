Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401DAC2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A552082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Axf12Dpe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A552082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7BC26FC49;
	Fri, 31 Jan 2020 22:17:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67A826FC3C
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AN8xnSJWprYwPaPqjLXBukgUKfjbfLW27lHwfEZeBCVC92p3ccNJkXLgyelv0Qbl/IJ3uBY6ArleSjoL1OoUp9eOHsZZI8fw9vbohI6oLcuM3BUcAdPj9UHoiRYHGYWBnZbDguewu1eo4rIc/KBMNbjFinOAH7ixF7vIES8N3NCWChdjiebpE7Gm5sNPDjktj4ENnSVlR6n4DPBwBlwUJJXO6+KAkpfXjWGVXWr+SV5vBrblvcGdPu1mD54skyN01P8NgCJxgGggWgHmeh1Nep+oWFRPLagKGpz6M8jc1yWzHODKVGgd1kIkUGRaEjIU2PUg5vvFgLHY6Q1SUQYABQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVzstDqJgvLO4L9r1SBR0cHIs+dsvDJZx8hRoYQNVcY=;
 b=YBptkvef1fNKOnvUDY+owOtiDDugUeZbxhgOmnW2rDK04KnRUe81Gyln1QxsJlyP/+Uymlpm1q6JnUbUZB8f/kF1EMNOVGaOXdhXhP0hSO+xiU8+tiPFW+rZfduYOUtONYY7CCCTr5tgAgsNe01mnozDOeoGDH7RYcm8GiVqxgYdSiKyw7Gn7xaGKErmrwZRi5XRmHREwyuAebRQ0hpwPCDzbUT2ii/Ap9ggnVB7dQtXkV5+wwiG2YKl6+fS6yQT0g08vAg1pbotDtqq3hmbiGRV93QwEvBV8+ChXeEERxAy/cQyJARrIvnm7x08ylHUYQuV7LepifpL3p87CGm+Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVzstDqJgvLO4L9r1SBR0cHIs+dsvDJZx8hRoYQNVcY=;
 b=Axf12DpeaTLn47FCY9w/BG0x0e/ZdYdy/4Eaq+iIiT2F97G5GKwktWnf9hNauHanJKx9issksuk6vsK3OPrIMov9A2iTmfUnlxrTB4K5qaGzkxGhDQSF/GXCTIPVkCTzAgxt2PiWcxzQJNySKIj6xABdfOWS4Se1x1F2A34dL68=
Received: from DM3PR12CA0084.namprd12.prod.outlook.com (2603:10b6:0:57::28) by
 DM6PR12MB2715.namprd12.prod.outlook.com (2603:10b6:5:4a::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Fri, 31 Jan 2020 22:17:18 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::209) by DM3PR12CA0084.outlook.office365.com
 (2603:10b6:0:57::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:18 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:18 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:09 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:08 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/33] drm/amd/display: Use dcfclk to populate watermark ranges
Date: Fri, 31 Jan 2020 17:16:29 -0500
Message-ID: <20200131221643.10035-20-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(136003)(428003)(199004)(189003)(36756003)(2906002)(6916009)(86362001)(7696005)(1076003)(336012)(4326008)(26005)(2616005)(426003)(186003)(8936002)(356004)(6666004)(54906003)(478600001)(8676002)(81166006)(316002)(70206006)(5660300002)(81156014)(70586007)(40753002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2715; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ebd9d31-85c2-4c32-a58d-08d7a69b55a0
X-MS-TrafficTypeDiagnostic: DM6PR12MB2715:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2715E7227EF116F075ABEDE7F9070@DM6PR12MB2715.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bcrF7H/Uq6DYvzdz2x4mTKWxyj/rKlYvZ/n3T1W7P8GSGlwCtbM/CfJvig32Tn6UgTx+5EWGzUdqD9RYX5NMh5XfDhg4QWNbmolNgKqM6AXN7I4wP98CcX4vv+AJtVrZpOE1tO4cFksU31UdaFZ7/RFs0yTFXh1VdgR7cDQd3bjeOR8FyhaapJ+fkXf33ErsrPNB3kEHU8vLgO5UmWJRhVx5FWiWYBCdEDlBm843VV5wcu3Wd0gfpXtYNiUT+no7SbmMhAL49P6BKfn5T6UZzU7xuYL16m6WCdJVFlZE4duXFXjzErXjw9mrfZB3l47k3rxZyzOBsFExAz9WyI1n52s+rSE3Umj7SLxptmLgYuodpdp3+HIP9Mzs9hxi0fLDXMBCEY8swuAnN7RTa0Prsyg88bNJuT3Ho9B87qYZDIdA379HnPXWl1knZV61YKgyKB/aTtRvef1hX8WHQ2AReCEr+bILBUtLqlW0ccUKVwVNJllN0Q/jjoGglmTClS41
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:18.1336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ebd9d31-85c2-4c32-a58d-08d7a69b55a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2715
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
Previously drain clk was unconstrained and fill clk was constrained on fclk.
We want to change it to fill clk unconstrained and drain clock constrained
to dcfclk.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 7ae4c06232dd..034a5852a416 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -412,19 +412,19 @@ void build_watermark_ranges(struct clk_bw_params *bw_params, struct pp_smu_wm_ra
 
 		ranges->reader_wm_sets[num_valid_sets].wm_inst = bw_params->wm_table.entries[i].wm_inst;
 		ranges->reader_wm_sets[num_valid_sets].wm_type = bw_params->wm_table.entries[i].wm_type;
-		/* We will not select WM based on dcfclk, so leave it as unconstrained */
-		ranges->reader_wm_sets[num_valid_sets].min_drain_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MIN;
-		ranges->reader_wm_sets[num_valid_sets].max_drain_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MAX;
-		/* fclk wil be used to select WM*/
+		/* We will not select WM based on fclk, so leave it as unconstrained */
+		ranges->reader_wm_sets[num_valid_sets].min_fill_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MIN;
+		ranges->reader_wm_sets[num_valid_sets].max_fill_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MAX;
+		/* dcfclk wil be used to select WM*/
 
 		if (ranges->reader_wm_sets[num_valid_sets].wm_type == WM_TYPE_PSTATE_CHG) {
 			if (i == 0)
-				ranges->reader_wm_sets[num_valid_sets].min_fill_clk_mhz = 0;
+				ranges->reader_wm_sets[num_valid_sets].min_drain_clk_mhz = 0;
 			else {
 				/* add 1 to make it non-overlapping with next lvl */
-				ranges->reader_wm_sets[num_valid_sets].min_fill_clk_mhz = bw_params->clk_table.entries[i - 1].fclk_mhz + 1;
+				ranges->reader_wm_sets[num_valid_sets].min_drain_clk_mhz = bw_params->clk_table.entries[i - 1].dcfclk_mhz + 1;
 			}
-			ranges->reader_wm_sets[num_valid_sets].max_fill_clk_mhz = bw_params->clk_table.entries[i].fclk_mhz;
+			ranges->reader_wm_sets[num_valid_sets].max_drain_clk_mhz = bw_params->clk_table.entries[i].dcfclk_mhz;
 
 		} else {
 			/* unconstrained for memory retraining */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
