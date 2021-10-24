Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F568C4332F
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D3D16052B
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D3D16052B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46B8B6E10E;
	Sun, 24 Oct 2021 13:32:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A5AA6E114
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhDEnhPe5E+Mu45oLB3FjIqMlqahkWAF0O/vIbswm1sEY2HL6svEG5GhbSAbHmtEJOi0u0gtKdOlC0ZA34esPsLWO5gFq0vmdccGFU6Hr0CFN5sNDPbfq6tY22bTBKKAK7P8olOZRZ27Yd8VrXrF2X/DkOJ+zpLfLaCKeu+OyWj7HZatUcTPtotQD6SWpx6v28H1xCeOXoCFLNOB1gUU2/CVoiG1dfU/D0mC9VAyFpZ6UGwrI0sFZIi6z5OeIzpUSln4QNFZKWqG+aIcBBBHOYS8bBUM2sWDovjqbA0C/ACls4/5dX8DsP3okVnkQ3btFxNExQZxF0wvqmwCiasXyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMEBGxefdNuaz2byOvAyaT4NZu9yTkbzMhjcqY7atwg=;
 b=Vt6aecP8Ca6pRXRfLpCu+CR2XyJFawL/ah/q6jq1CqDaQsE1ZDyKBGinESc5+wDNHw7d/XR3EzCeax4E0RGALwEYOmyz0HIG/FXCoDuzELZXLy4UlLC0lmUTBeghCNLxEf/HJUvRX52b+GGnH4dn4BGfX6DlE3OR7KnBGDdRlsmj8vekUYWB5Fk4X/Dux7IhrUWGFHx9b+Qmn8Ezhv/czjDHaA73juxxLyUHFG0godxGCUrsKDH8Fo+SiqLyTxaGuPhyllVar+NwyUVmx5NcN3d6a/0FjFAv9EyvSE6hyEmaMLDRvr7j6j2Z0xy7ZQbAgAP2LiyLKmt1nJqNrSLbVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMEBGxefdNuaz2byOvAyaT4NZu9yTkbzMhjcqY7atwg=;
 b=g1xE74tEF/oOROcGFbZErGQS/oQkx5gAhpiQaLpDz3qfvvqZ8v9/4si8I8/dvexKoJuY6J8xY9sfmUgyeshUpkpWTAxGfHljoVGm62FApuTJLIbO38oLQosadcepmLGiqb3eI8mHdV791tRryXJpOauRTiR4lqA7TudlrUlKhk4=
Received: from MWHPR1401CA0007.namprd14.prod.outlook.com
 (2603:10b6:301:4b::17) by CY4PR1201MB2535.namprd12.prod.outlook.com
 (2603:10b6:903:db::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Sun, 24 Oct
 2021 13:32:25 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::c) by MWHPR1401CA0007.outlook.office365.com
 (2603:10b6:301:4b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:25 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:19 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, 
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Subject: [PATCH 10/33] drm/amd/display: clean up dcn31 revision check
Date: Sun, 24 Oct 2021 09:31:18 -0400
Message-ID: <20211024133141.239861-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbfbeeb4-fac3-4e51-b44e-08d996f2b75d
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2535:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2535A4AF781736D106F4DB4F98829@CY4PR1201MB2535.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:260;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: niScyvJW/lXUHT3AfZJAOjRbqMjs62hqTt1NC9SzTOwNgOkK4+gG7KmNuJ9/854GaR898F+viTdtVf2TY0mRAg432KgDwLQ7O6ivmYdinAFuzR/UBsnTF2aM90VyMjjB2+tIdhXPjomzthACYBR08lXp0fwvgzJmOXpEa3U2KDROxGURHE429vCT4HlhlirAPLf8cgf8FbAPVNlhrcNHXUPxsael4aLJVLdpABmFHDUmwZ7nQbUVRaloafOw/v8ZTFYSOruDW6JdorTZ3r9aC8G/S36L7YmiJx6Q3xay/pWEAte4yUlRBUlp5C8whqh9mmRODWB80sKA2YhQ1MoJe8YRMyOl5IIRcBjA70fuF6DVTthDB6UImAdHRAQOjghWd8uInMPT7jWMnl0ISEOIQC/uKMNmd/2SHPVsK18LBNoYSCw/FovWGMJSFMEOXDecw542MwAvixU45XvY8cxKVD/63FpC6StB0Cyo5wycUynIlw2+Y+6sBzoFz8aaCF//H9klYQrb/CeMPEfmpI+w4NixLbNRFzjfAjGOxOXgUSk8iLYCrF/0HrrwrwZG5H6HunFC6WN2Vsc9sCKx6Es80yWg+w7YwkzCxnNJiQz9+EgZpDLFsbl7P4L8UtEzQFT+0Kk78JBxI/Q/3c86nscBSMdzoDyQ0mxCSSowMFgzV26pAqO+WTiFPeHIIwxncfoYDjySiJy4UGRYbAJZSYLUkh1cNATXoNfkKI+nD4jk4GQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2616005)(426003)(47076005)(36756003)(6916009)(82310400003)(86362001)(356005)(186003)(16526019)(83380400001)(8936002)(70586007)(508600001)(26005)(336012)(2906002)(316002)(5660300002)(8676002)(36860700001)(1076003)(81166007)(4326008)(70206006)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:25.0690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbfbeeb4-fac3-4e51-b44e-08d996f2b75d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2535
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

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

This is unnecessary in clk_mgr

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index acbda3962650..26f96ee32472 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -285,13 +285,8 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 			BREAK_TO_DEBUGGER();
 			return NULL;
 		}
-		if (ASICREV_IS_YELLOW_CARP(asic_id.hw_internal_rev)) {
-			/* TODO: to add DCN31 clk_mgr support, once CLK IP header files are available,
-			 * for now use DCN3.0 clk mgr.
-			 */
-			dcn31_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
-			return &clk_mgr->base.base;
-		}
+
+		dcn31_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 		return &clk_mgr->base.base;
 	}
 #endif
@@ -328,7 +323,6 @@ void dc_destroy_clk_mgr(struct clk_mgr *clk_mgr_base)
 		break;
 
 	case FAMILY_YELLOW_CARP:
-		if (ASICREV_IS_YELLOW_CARP(clk_mgr_base->ctx->asic_id.hw_internal_rev))
 			dcn31_clk_mgr_destroy(clk_mgr);
 		break;
 
-- 
2.25.1

