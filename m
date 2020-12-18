Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1330C4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:30:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CDFE23B5D
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDFE23B5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6337589AB7;
	Fri, 18 Dec 2020 22:30:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E20CD89AB7
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 22:30:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyqMZRZ9xzkj+q3K3JbOwpfaSaWSlQaP26IbHWiEinL6kD+q2p7P3Fxno4sB7nFqZa+k8bnNEaTZbI67WvzMTFxShihMhiyEa+fgmtpU5x6QT88RYOpLimaA0sgatBC5EwXWiFc99Oc9nxN9ZZ3gY/JOCWy1pz23gw4XZvbA8LxL6wROYpw6lkNuoKS0DiHNnJbeFaY0WbPjwgHoq3VcxElNRFQx7hYmqjrDtehbH5WKa05gkNjd/ivN4qTomTLPzxVAclNO1HYb1CCUbl5LTuJVnooe2u0L8Tz094Inb8H5/BIIiy8t7SvBzUZrmZ+PfuYGx8SPWafD556AZQdsew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuYhvGRjdbU1ONVkxnzCLuB59Kje4ipQBkihZM0xBMY=;
 b=TiEMpDSP8+XFVPoFCH2SM+cRODbcP3ByCPRgOQZG6jzjBWSBN01EKgERsp4iis14Gd0to8ll43f8MtAIYKP/L2lLVs6tVKHJ05H/4EYZ9VNlQRG9qkBZ+kuhogtE+OKbg6VHL5lfZDyRTEGn3N9Mj9rtsDC3AXsnnYe8H+25HCgYyo3KAOgp2aKId876Ml5ANL7ifrM75V4Wh8dn62ho9/S6XQFMUChf7hJ70Zj2HGKovk3yMhIMagNQBQmBezyg7OhHEqjgekf/2uoxPQlnEKpIJh+N6v4ImSPFkPafLt8eUg3r3yTRgd1pekq4qbKrEoNik0xeC0jo6oPj+n7sGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuYhvGRjdbU1ONVkxnzCLuB59Kje4ipQBkihZM0xBMY=;
 b=s758n1zQ7xVyxWjvOxe21ng5Ov19FVDEB4OW5Z+lKJdtFzpyTkuUp55w6JZpMFsjPznrLfFScXVEd9KkW9vOOkXizwPVhBylabG4vU4rJOjXjV5SfIyGHvKGh1r0GO+IsURPUEylZfg38T9xZfCc+LviKTvIbId088wr1w1gllU=
Received: from BN1PR13CA0008.namprd13.prod.outlook.com (2603:10b6:408:e2::13)
 by BN8PR12MB2962.namprd12.prod.outlook.com (2603:10b6:408:47::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.20; Fri, 18 Dec
 2020 22:30:14 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::fb) by BN1PR13CA0008.outlook.office365.com
 (2603:10b6:408:e2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.19 via Frontend
 Transport; Fri, 18 Dec 2020 22:30:14 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3676.25 via Frontend Transport; Fri, 18 Dec 2020 22:30:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:30:07 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:30:07 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 18 Dec 2020 16:30:06 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/14] drm/amd/display: always program DPPDTO unless not safe
 to lower
Date: Fri, 18 Dec 2020 17:29:03 -0500
Message-ID: <20201218222904.393785-14-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201218222904.393785-1-bindu.r@amd.com>
References: <20201218222904.393785-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1550e237-7be3-4419-5eb7-08d8a3a47c4a
X-MS-TrafficTypeDiagnostic: BN8PR12MB2962:
X-Microsoft-Antispam-PRVS: <BN8PR12MB29622C311152870B5BCB57ABF5C30@BN8PR12MB2962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: clPbnZipEmjDPVgmy7owRqKVAbBFt7UKIe95tJirSemDCM8QV5FzXH3ckfYBvoXPpnDXc/UN+C4eIA2BUGRbSxgVwfVVGp6oD2gVOpzY5GnoDaTe205n3KpUrtwaFXQA/V4s5QtpFYQaKtTSnawWboKOMmWtKoSHtOXQHso4ytxm9uSohQDBcsSbxQyD8q8XjqoxCFP2FVnpFctfZSnNyGONkD3eRZ9t/AvKYr02jDLCmh3pucQvpOxbBo7LPMFAKT0FPTRCfiuP21PmAzrqTxzsTO9LLhqfW/trg9Kj5mNxJ1K2PrPMI/j6li4HW+3fYGXOR0A4Hggmf6nGsDZaKihRBX75qXg+AZQ+nyDJEqo0WNiTwmPSmblD1tV5z6GLGZUxTL5ZtML6KNNUy+jKjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(46966005)(70586007)(5660300002)(6916009)(36756003)(6666004)(1076003)(2906002)(54906003)(336012)(8676002)(26005)(478600001)(2616005)(356005)(70206006)(316002)(82740400003)(4326008)(7696005)(81166007)(82310400003)(8936002)(47076004)(426003)(186003)(83380400001)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 22:30:12.7698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1550e237-7be3-4419-5eb7-08d8a3a47c4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2962
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
Cc: Eryk.Brol@amd.com, Jake Wang <haonan.wang2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jake Wang <haonan.wang2@amd.com>

[Why]
We defer clock updates to after pipes have been programmed. In
some instances we use DPPCLK that have been previously set to be
"unused". This results in a brief window of time where underflow
could occur.

[How]
During prepare bandwidth allow rn_update_clocks_update_dpp_dto
to check each instance and compare previous clock to new clock.
If new clock is higher than previous clock, program DPPDTO.

Signed-off-by: Jake Wang <haonan.wang2@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index bad30217c7b4..01b1853b7750 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -227,12 +227,11 @@ void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 					rn_vbios_smu_set_dppclk(clk_mgr, clk_mgr_base->clks.dppclk_khz);
 
 		// always update dtos unless clock is lowered and not safe to lower
-		if (new_clocks->dppclk_khz >= dc->current_state->bw_ctx.bw.dcn.clk.dppclk_khz)
-			rn_update_clocks_update_dpp_dto(
-					clk_mgr,
-					context,
-					clk_mgr_base->clks.actual_dppclk_khz,
-					safe_to_lower);
+		rn_update_clocks_update_dpp_dto(
+				clk_mgr,
+				context,
+				clk_mgr_base->clks.actual_dppclk_khz,
+				safe_to_lower);
 	}
 
 	if (update_dispclk &&
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
