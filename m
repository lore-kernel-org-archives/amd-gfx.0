Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3559EC388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD8F4222C8
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="P8gxtYlj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8F4222C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AC1B6EDBC;
	Wed, 21 Oct 2020 14:23:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D93D76EDBC
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhtLVSDT5cq4PUf5NMBk23ei80Jln/U8guhsZJx/ZniRdq6z39RLifI/CpTUCZ0/eyKgWfd8+4Kwr0Vrawa6+HgBBFz+G7b3WzYBGxxTBiBaS5/0rWOGsfhVWNsJ8DA5/LzuzrqnskPdIpAvH9ubA04rp7D9jHJ2X+l8VUpZr/H/8SDeXJ2wxZA1Pqkd68QpwfKQHO8qfLkSFrGQ62BJjJouQM6k4LDGw6/CFTmCDCkBjBKJ0AwkDqn583eJBMCuKvEaFDiTT2w/5osY7UKQnGnzsmDKWkqMoevvc+VhmlwbuOsJrz4oZ3sX3S4w4EDo4P84fgQQ+/hPhicMOXdpSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2o7ev7JD16uYHD95wmDWhLDVvZfLselr3MKYjm2YTws=;
 b=SRNsSArUTyEnhQLo2QQWMmh379dCX3ht9vAwGaabZGfwpj9T4j2ynqyRPM4xdooY6zEgeHNouKpam8d43F+VfBQ8Ejwq9RblieQDGW0nZBUtSxs8xIneNxpIyrAb/OvE6ew4c4IzXs/2kxF6ddyc0RotjBik3oLXle37n7+cGcv/CLArUscHOBGoJBBwqsUFP39akpIW7B0ORmPrlHJQbp8YyNvfteJ8d1wpMz7NNqAAf/DoMmNa1XIaq0V/3W1W0gmg+fDGibvF8AGLZeAGcIT0YVTYNp5wf9EhUDq+09fFCcllaqenxmNkpUEErmk3Y4PI8jeyy5lr5Va8Kbfmvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2o7ev7JD16uYHD95wmDWhLDVvZfLselr3MKYjm2YTws=;
 b=P8gxtYljVcZMHsb8/NiJVjavg6IROb1+3rN8iIoE2DOWNzFvr+CbOIpzaN7O7PMWqlh5gKnf9a/lJr6zLkaGAOZYnONH8INW0ag3EcewKG6hgqzR8l4Fd1CDAGOPDusVZ7HeoYi8pLn0GXJsOQhz1eRGbblzbbAMiRo0dNFeqR8=
Received: from DM5PR15CA0033.namprd15.prod.outlook.com (2603:10b6:4:4b::19) by
 BYAPR12MB2773.namprd12.prod.outlook.com (2603:10b6:a03:72::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.28; Wed, 21 Oct 2020 14:23:09 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::75) by DM5PR15CA0033.outlook.office365.com
 (2603:10b6:4:4b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:09 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:09 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:08 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:08 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/33] drm/amd/display: Set WM set A to 0 if full pstate not
 supported
Date: Wed, 21 Oct 2020 10:22:30 -0400
Message-ID: <20201021142257.190969-7-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7410ca43-8dc8-4299-cf6a-08d875ccd5fb
X-MS-TrafficTypeDiagnostic: BYAPR12MB2773:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB277334E572E799AAEBB246598B1C0@BYAPR12MB2773.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: koaxNiVIX90fD3sWEv/p34pIGIwLzQuZbauP9vMn/8bnYlU2Vdie9qxZj52O7iMNovx3N1tcf6iWu8nZuD3rXBQElzM8xtjr6n3OWxKu69o9cd8qd8ixQem1/CSWLZqwG1yPJsbnGhWW3iPDwzw4cHRQbJ6NLByBKsIyvpGM62Fdc5Zxf2dNISWEaZCL6Gm1BxvUO+hPqtGwMat68SLs/4+ULaCr6nsjeKxsj1eHGs30+Wm0ZbSrIiCVGy6vILiacWhV1Bvw5sYw3IF8H3tng7JiN2Oj8P/MjmqtWfQoKhg4hdscNjD3YQ3GFPRFS615/Ev9Rm5nNL0HSzVTGjXDsEUr9YQcY7wIgTEsRjz+V1XHHxmYCEHmkKK+VmD0SMIldFk6pS27JthUm+1w7sKIrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(46966005)(478600001)(47076004)(36756003)(82740400003)(1076003)(356005)(5660300002)(2906002)(86362001)(426003)(6916009)(54906003)(81166007)(82310400003)(26005)(4326008)(336012)(8676002)(186003)(316002)(83380400001)(7696005)(2616005)(8936002)(70206006)(6666004)(44832011)(70586007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:09.5753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7410ca43-8dc8-4299-cf6a-08d875ccd5fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2773
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
If full pstate is not supported, we should set WM set A
to 0 to prevent any hangs

[How]
If pstate is not supported, set watermark set A to 0

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index beaa6b9ae752..8a4eb8e1386c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2313,7 +2313,7 @@ void dcn30_calculate_wm_and_dlg(
 		 * calculate DLG based on dummy p-state latency, and max out the set A p-state watermark
 		 */
 		context->bw_ctx.bw.dcn.watermarks.a = context->bw_ctx.bw.dcn.watermarks.c;
-		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.pstate_change_ns = 0x13FFFF;
+		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.pstate_change_ns = 0;
 	} else {
 		/* Set A:
 		 * DCFCLK: Min Required
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
