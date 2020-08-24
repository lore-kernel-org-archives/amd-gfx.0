Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84201C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 15:11:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59EC0221E2
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 15:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bO4+d2X3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59EC0221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0D6C6E2C0;
	Mon, 24 Aug 2020 15:11:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B79D6E2C0
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 15:11:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nX1zq5+Xsq3Kmi5Z7B8Nu5NZL5V/WW/oxucVgOfiNPT9QRXyp1J7FZjbPWT1OXjx/ePKuOMdwEouDbMfsoFCqIlgqS+DaHLmEMFAxH+0z2RSFbI66QQYW4Ua6+gAlDgkHmLtnlIT8z5WqzN1aGJPPjKCGsedfh5uRdsPUQRzlgI32pGzBBiWBoD/h+v4wXK+Rdzr6tSaBK3rT6se4rjbBNJGEHU4sm/QrGzTqcZbHAj+Dx3wRvNpSEAOxbVgenk35jY7KIPo82lAT3rf61iJeCNWZBtn+GC0uT5a2Wdo2zn1V7zDdQmsx9ZUyNTi5NyvR5miQdEozS/0CCG5WW+nlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZbRVLhIF0TrVXJ6yDHuW7uTHWFJrXkTMedxBF0C0RE=;
 b=ArFfx+WkaTpNOK2afP7ekw80cfcfb9KEgILZ+yyybLceACrp28pkCbYXPbOS78rVxkmc6H1i3WFQLui6dKcxnq5tZNrgwEvFQ5ZGWpOxkpRMzAvn9e8G70lrhXOYLebOBXxXPeXGBwaGRUvRc0xkevF5gP1oDoxHchJ4rBcqg2OCr4NKEv2fRtG77FvlxC07+g9AsVB5y0ZWvu26N1sOzsklk0QSWrwP1lLtt5pLOYCIfUOAb+FRzB16jOuAvwiI26/TZr2m5+yLcVPfSKc3p3ng09xFRDa2OyZ4RM8gU/dYDSEQcLPXF4UOQrbrjdxxl9J3gO1paJE2UAl5BrOSAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZbRVLhIF0TrVXJ6yDHuW7uTHWFJrXkTMedxBF0C0RE=;
 b=bO4+d2X3pfYeCcvwNAiMftlKDb9GnFD3xH1rR6I4Q9zvnhj6HglVb4rfzyAeJUXfxPVpOYQmklmfy1yHjgrO0OlWFuFg4T6fp/WKnIQdXRuPUw/gMJHFvzHQsWr1eMyXXmswuJ7puBGF26pyBNvcUGciLZoC6kX7CV3phujLrtU=
Received: from BN6PR19CA0103.namprd19.prod.outlook.com (2603:10b6:404:a0::17)
 by CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 24 Aug
 2020 15:11:41 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::4e) by BN6PR19CA0103.outlook.office365.com
 (2603:10b6:404:a0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Mon, 24 Aug 2020 15:11:41 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 15:11:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 24 Aug
 2020 10:11:41 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 24 Aug
 2020 10:11:41 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 24 Aug 2020 10:11:40 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Add DPCS regs for dcn3 link encoder
Date: Mon, 24 Aug 2020 11:11:12 -0400
Message-ID: <20200824151112.4739-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7b0e56c-6ff1-4084-af44-08d8484001a4
X-MS-TrafficTypeDiagnostic: CH2PR12MB3895:
X-Microsoft-Antispam-PRVS: <CH2PR12MB38954866285641240EBFB35FF9560@CH2PR12MB3895.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KHtYFhXhpePti7PPaIjwSbxzZZUp+A9MbWhUr3/JN6QG71sCMRY8mu6y2tv6aXeTDH8rnw6rr0PC9JBQoOgtHGg2vp5SpdjFrHPt+0FALY+5P0D5R/xhzLT9PLp4iv1jhYTCi/CzgTnWArY4W4Kex81LXTDt6cz1PQRJ1jn4lyfFIpQHdm1BffG1wy+iXXLNaJUEOefaIL8dRZA6usteDMuE57XqiA22Di3Y9pi6RUSej1SE9Ce785kcgz4F4xZJW0F/4no68Z+85rOWO87XwpisBnAXFKDwjj0D0qcvOJs/vIgcBNwZD3U+r/cUf+Ho+FetZ7CS+j1Jsciv7yRb8xo7mfWhmBXcwjlXCZDFjjUPc1mh1458HUUlYaYjlgIj6FOnGYTk/o3aIaM57TLcYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(46966005)(2616005)(356005)(426003)(6666004)(6862004)(186003)(8676002)(336012)(6636002)(1076003)(26005)(36756003)(316002)(2906002)(82310400002)(70206006)(478600001)(54906003)(5660300002)(83380400001)(81166007)(4326008)(82740400003)(86362001)(70586007)(47076004)(8936002)(7696005)(37006003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 15:11:41.5182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b0e56c-6ff1-4084-af44-08d8484001a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3895
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, rodrigo.siqueira@amd.com,
 nicholas.kazlauskas@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

dpcs reg are missing for dcn3 link encoder regs list, so add them.

Also remove
DPCSTX_DEBUG_CONFIG and RDPCSTX_DEBUG_CONFIG as they are unused and
cause compile errors for dcn3

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h | 2 --
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c     | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
index dcbf28dd72d4..864acd695cbb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
@@ -231,8 +231,6 @@
 	SRI(RDPCSTX_PHY_FUSE3, RDPCSTX, id), \
 	SRI(DPCSTX_TX_CLOCK_CNTL, DPCSTX, id), \
 	SRI(DPCSTX_TX_CNTL, DPCSTX, id), \
-	SRI(DPCSTX_DEBUG_CONFIG, DPCSTX, id), \
-	SRI(RDPCSTX_DEBUG_CONFIG, RDPCSTX, id), \
 	SR(RDPCSTX0_RDPCSTX_SCRATCH)
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 957fc37b971e..8be4f21169d0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -491,6 +491,7 @@ static const struct dcn10_link_enc_hpd_registers link_enc_hpd_regs[] = {
 [id] = {\
 	LE_DCN3_REG_LIST(id), \
 	UNIPHY_DCN2_REG_LIST(phyid), \
+	DPCS_DCN2_REG_LIST(id), \
 	SRI(DP_DPHY_INTERNAL_CTRL, DP, id) \
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
