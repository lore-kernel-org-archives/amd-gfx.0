Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72D8C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5661D60200
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5661D60200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 025DB6EC39;
	Fri,  5 Mar 2021 20:04:06 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2054.outbound.protection.outlook.com [40.107.101.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 216D96EC39
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 20:04:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZqwzkxB9NDpqG7gKq082joP//KWiByrwxcorLuVUAVGHKw+xP6Oc0WzmyNbDYEuaR4s5zGmKn47FQ2s815Mkekw3eQ/Jb/BeaRe1ZyAzJN4M5Axpotjsn5rQbA1Hm39hMdxIKREFTb6YmT4TtG2Swr6DHNtrG4u7aoseGLFNrZbyF4LISPkHa0F0a7mC/uqpCAjzaC5uNVFKp/IYsf7953u6t8uScIB/MQ+OIzkLFr3PAmO/b6sVBgyzpMUIb6I9lb4i2BBcGf+X/zHROWTNf3PLTXldOUGDFADWxqPFJLZQr48ie3nFurFFQnt2AmQTlQiynFpYt+Sc/XTog2F4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OItNPSN2KWtOH+f6zKSFuJ/ElxgMuYYMk6cJdfa/gw=;
 b=n0MIC5yl8vuYw28wkJ6cbZtQkNBUc0jt0z81yrC4dQ3WfDor3MHD96DMqgsJOGe1UckAh0IE+azk6maVTZw4TrCFRJmF43jB0eXH10vfuCXLUhAOwz/Rl0Si/gnr3ptuHmzN0flYNV+BWBJc3IRPM4ehOvcY1ZImp5tivWW5oBwZdrCdgOBt431E6kp7L2WkcFxEMy2ouLENIZb+hg/ZM7PHo0EYryhO84h/y2w9JFo6kHGO3AOs7LahfjPZwW2TRfwxQOYObSx2HFbLZ/kOfZCyATXSotNgFj6xOsmeOXA16Di7WoGyQheEbvm4JHcuWEc4LMa1HOlg+F2abJtgCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OItNPSN2KWtOH+f6zKSFuJ/ElxgMuYYMk6cJdfa/gw=;
 b=oXFyqRHpnBrMGeNATRUGMrrs2wzH+epesoo2PAiP/fZHTwk7VlN6Hh7lox2blmkCvMArekC/QD0fDnO5k1tiv0oiyoD5jNUu1Z1p8ZppgiNT0AzVgFw+z2q/5DYtvA2gnuKvFc9XzIL93HRkmsz0HJNZQCSIj92BuuWZd5m1Vv0=
Received: from MWHPR20CA0037.namprd20.prod.outlook.com (2603:10b6:300:ed::23)
 by BN6PR1201MB0004.namprd12.prod.outlook.com (2603:10b6:404:ac::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 5 Mar
 2021 20:04:03 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::e0) by MWHPR20CA0037.outlook.office365.com
 (2603:10b6:300:ed::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 20:04:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 20:04:01 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 14:03:56 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 5 Mar 2021 14:03:50 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/14] drm/amd/display: Fix typo when retrieving dppclk from
 UEFI config
Date: Fri, 5 Mar 2021 15:02:50 -0500
Message-ID: <20210305200301.17696-4-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305200301.17696-1-eryk.brol@amd.com>
References: <20210305200301.17696-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d0c9bd5-b7ca-4ed0-e740-08d8e011d20b
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0004:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB00040F93B7AEB0E519613D90E5969@BN6PR1201MB0004.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NrpHcvaHAmlNx784xBP1I781gSzRxkaLiVdQU49J9Y+VLRKt+t6LLikpJkptcW6/bJHfAJjTylga3xUuXZpT0N75rk1DuIpK0FfUoistETHSb3rBD3mnsrv20LmvXL2Hy4zmzH5aIy+hV0JaBUkrEONXiTh2rhvmxOOvmuH+RGpcv8BMtRA2MDgxa2xTsRoCXdOehnn8cqDRCPazN/i/GniUWu07O3nTAlQs1qmvzWq+Mw3D0cqearip8PdglKHSQN7cuJJZRdPXPYNI1DDuC8EB6B7V8F6JdsdNdXRVUxNk7qN0GK80mOHOGzVfachDdhOf8wv2EyTZy7jBOuO9h6Cve5fICI8Qf+xp1DnH7FDvkX+GoCuzEMGaN3shj2FkN0OFpl+5SGGlL3xZOWkuoYW8TXwj3wx3fGFyjI6b3VBVFbwOd0/3Q3fvN9sRDIhzDmNIEKxzljw6aMI6fjDJU0e46yVYLbBNnQBrgL1kzU95VoWZCrioHxG4yavSb7bhEspLzlU75cP0nZyq4IqFzB/S+/To9FH1scPEIC/TrkZYDy5f7XioVC59eT5ZqwKQflilUec72F/WKKaQDmzb59hUyBb7mCYMPLGGvZMRI8zYcKkCUKiRTSrC/rQJX2LmJmUjDN4Jq+bcyNKeZ0kmt2vmLXF+Pwy70Dmn3/hlcPPLoTZ/1lgA/gma7UXObyPO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(36840700001)(46966006)(6916009)(2906002)(81166007)(82310400003)(356005)(8936002)(47076005)(36860700001)(83380400001)(316002)(82740400003)(86362001)(70206006)(26005)(36756003)(478600001)(186003)(5660300002)(1076003)(2616005)(4326008)(336012)(44832011)(8676002)(426003)(54906003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 20:04:01.4487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0c9bd5-b7ca-4ed0-e740-08d8e011d20b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0004
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
Cc: Sung Lee <Sung.Lee@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Martin Leung <martin.leung@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <martin.leung@amd.com>

[why]
In some boot configurations we need to retrieve the currently
UEFI-set dppclk, but there was a typo in the calculation

[how]
Fix typo to make dpp_clk calculate off dpp_clk divider instead of
disp_clk

Signed-off-by: Martin Leung <martin.leung@amd.com>
Reviewed-by: Sung Lee <Sung.Lee@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index ec9dc265cde0..372d53b5a34d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -361,7 +361,7 @@ void dcn2_read_clocks_from_hw_dentist(struct clk_mgr *clk_mgr_base)
 	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DPPCLK_WDIVIDER, &dppclk_wdivider);
 
 	disp_divider = dentist_get_divider_from_did(dispclk_wdivider);
-	dpp_divider = dentist_get_divider_from_did(dispclk_wdivider);
+	dpp_divider = dentist_get_divider_from_did(dppclk_wdivider);
 
 	if (disp_divider && dpp_divider) {
 		/* Calculate the current DFS clock, in kHz.*/
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
