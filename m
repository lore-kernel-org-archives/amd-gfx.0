Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEA2C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74A2861159
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 74A2861159
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8991D6E52A;
	Fri, 19 Nov 2021 19:44:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D9526E4CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 19:44:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3JR0M/jBDdLSr8awyK1iH0c9RrFHIyecdO4+Ej3RkM2OI1SqLkMCw89/2TfKuz+Bv4M8EqRCxE4RaiVX+GCP6hje1ICYBMHcOfOoiPZlUY5UC5QIsPF1RniUsW5CDWMg75EvWmORJVnvq+uztPtFFqyWCOaQaIjQX3q15KqxsksvG3U+uMIBMwDAGPGi5zu4Mttenb2k6y5NpQYcAPUUK0CvXjI52bh8cT6/cPknIjMYVyYAFFRZrf7IfT79K+99HOQ1sLbQHWBfIjsMJaa2Gwh/rjV3ySOEbYAh5I0Ezak60s4Oux1p1PCuWa/3woDSWlDFBM8vySit2XzOqq0nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxL2wQ3DsEezlRZRE3ooCoJ4cMK3sLE0txOvLs2arYo=;
 b=XUmcv52yNYrnKSwAOULmQNFriREaVX4mA92PisTx3xilPZX4aUgEtuURa+VIPVec5LO/8G1HOS/hPSTFEeDTbxDMFwvECs8gZnmU2gxIfgB2xw5OiP5n9q6rgJbY6oDSiPuu/VOXVP10ACJNb5NYEz6HJ3LYntkUiylDp1YM4afaZydR8hH2kHLOqoWn1xLZSzyr8xjidRcuFutdWXA403e+4IGBcPX23c3Ls8RA75IMKYsbbFyXZTCbb0aUV4pnbkj6c/Om2DtSptRtekpjNlgRGOpzpzMm81NWpuMcRBzOckWNDUWGhgDnD13WkkSL5TY5bm3jg2tdfqHYa3hsTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxL2wQ3DsEezlRZRE3ooCoJ4cMK3sLE0txOvLs2arYo=;
 b=Es5/okwDnKXwj9VqFMmcA8kEW9x4yfTHseUrSuja/tk8mfYrJCznRWbRw4SBIkGzLLtJ3kiPhSlgK4Qth+s9Xh+Ifv7Uh574iveAi0YrCHt/Y2Gz3CF6M5UTAzJKlghWwPAroF+vqbNBsN8zZdUJZjKd7cR1pHVl0610LNQx+D4=
Received: from MW4PR03CA0097.namprd03.prod.outlook.com (2603:10b6:303:b7::12)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Fri, 19 Nov
 2021 19:44:09 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::a5) by MW4PR03CA0097.outlook.office365.com
 (2603:10b6:303:b7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Fri, 19 Nov 2021 19:44:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 19:44:09 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 13:44:03 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/16] drm/amd/display: add else to avoid double destroy
 clk_mgr
Date: Fri, 19 Nov 2021 14:43:37 -0500
Message-ID: <20211119194339.97573-15-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119194339.97573-1-qingqing.zhuo@amd.com>
References: <20211119194339.97573-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba4a85d2-e32f-4b74-a45c-08d9ab94f461
X-MS-TrafficTypeDiagnostic: BY5PR12MB4306:
X-Microsoft-Antispam-PRVS: <BY5PR12MB430610BC8C8917B4D857EE33FB9C9@BY5PR12MB4306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:14;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 11YvUr4O7XrEkRYp2qN2dgtvMTtExr4aa0lWSuw32IIH0/HLaiPyqrTAfXoT1YNptZbnZnivSVxK9e7OXmbSLl/v5/6G9QfLOQ6DUw9Hg5rceOFWa4KOx6ceG8ridjOTMdGJGyrnSh8upg+RRvisQ5UcUoKUzLaUWkdQVidcW+pJofAlKrjcL4YavRDlbLwKU+0M941/RhYYjl0tBU8ulhSzoxaSZGv2Z4PQ93g7fVhdxw52Z6x6ENnYmZJ9WdM8vSrdUeZahMxWdu/v8zZP3ChULEP5dPjITClQLX/iohVOWCc6BPCNOVqMn8UYp1YPjywLrwSKiUtu/1Q/TF/HBUuPAWQxYdLd7tvruGNDhUggbepRUJGohLGYGfWoLOhgNT9Ukeyt56rGoeR/6pk08lI++5IWaeNm77vuFVueTw5Cetf23G9JpigH2sDXp0vevK6brfMdIEBW8D2Ev4acy8cxb3MTELJS6BNuThYAoPcKVFSSzawzzzCMtqh5Dsa75FAgtZ//q0VRQ1/F7Er5X2t8FbZMjyCrcnlPZN7fuOJWBECm2UaYoDR6GRxb3/NgWbuqXG56IS893h3YQKd/ArUQtLktiU1qHKrVQviSBJDPg9iOEZ4YIHWTJLDaRIRtqf5G8JgNtdCKb8oSh2qIo5cYQWTAaf/Tw4kqvmyhYWqBg3OVr+0fRuEYXKd8iwA5ZnPGAMuo6ISkAPRHC8PqITLwJCYaDBLE55lQUY4ieIY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(16526019)(26005)(508600001)(186003)(82310400003)(2616005)(6916009)(8936002)(8676002)(36756003)(4326008)(336012)(2906002)(36860700001)(316002)(54906003)(86362001)(5660300002)(47076005)(44832011)(356005)(81166007)(83380400001)(70206006)(70586007)(426003)(6666004)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 19:44:09.1506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4a85d2-e32f-4b74-a45c-08d9ab94f461
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, solomon.chiu@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <Martin.Leung@amd.com>

[Why & How]
when changing some code we accidentally
changed else if-> if. reverting that.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Martin Leung <Martin.Leung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 26f96ee32472..9200c8ce02ba 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -308,8 +308,7 @@ void dc_destroy_clk_mgr(struct clk_mgr *clk_mgr_base)
 	case FAMILY_NV:
 		if (ASICREV_IS_SIENNA_CICHLID_P(clk_mgr_base->ctx->asic_id.hw_internal_rev)) {
 			dcn3_clk_mgr_destroy(clk_mgr);
-		}
-		if (ASICREV_IS_DIMGREY_CAVEFISH_P(clk_mgr_base->ctx->asic_id.hw_internal_rev)) {
+		} else if (ASICREV_IS_DIMGREY_CAVEFISH_P(clk_mgr_base->ctx->asic_id.hw_internal_rev)) {
 			dcn3_clk_mgr_destroy(clk_mgr);
 		}
 		if (ASICREV_IS_BEIGE_GOBY_P(clk_mgr_base->ctx->asic_id.hw_internal_rev)) {
-- 
2.25.1

