Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE871C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 19:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E7D6613D8
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 19:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7D6613D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BCCD6E145;
	Wed, 21 Apr 2021 19:17:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E69EE6E145
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 19:17:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlZVzHzN8GYRUcnzndYcW4+ha+leyeyoKZTKuj2cjjJFqbSBoq5PvZIv2b+R4/NsBGSKKN0A80LtcWS4300LHwov+zH0YRdnlG3VC3u+clTBs1W2b0JXnvjvsWhN8fjRarRf1hawZG9Tz3AcggaNLDPoSrGI62NYMy89JPvORuqDpX90b7Z50Dp0AztolMF195jxwuX0DaHubrlPOOykEm/HXGkIcXONA+tg+cUUVMa4qcR2hpn9jYNR4XuxAK8h5j2yg+Zo+UFSIDbja6AT/ZkFm7bo0FboSNJgvYl01adnLSdKxBNx6e7jSUDhnM0hSaoSxK5q3UNFh3G4/jfrCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEgLfOcnZT2r4BtD4Pma3B0D5a7EF5UPEKngOJ+GFX8=;
 b=Cy7img4BMFjr7sHc0nhS5RnL6H3gpqadFkOcShzbWG1fDRXkMkfJp+R2exsCEx7dH+E1e5JWMDPskyKvEJPIZB5K+CvYOmn6NfKaFMCkpV8hUmQKqccapTv2Kev5tr5zj2rvWJtW7Lgl4N5X9f4t4yt1Vxm6+VCTPWUuzz1jttwu11ElVHA/zItSyTJkR3QO+kOk72wkhZ00ch2FJm30YOKTFTMWVaf4vTT7qRZGuMaxnP+zatuWbxoevvJgvoAYal2RzsysJ9srjUCSwXtYCptbnHXWNEQv1Bi09ja5wSLWgyAeSf6+HlQjtAU3Phi9zZyGQo3bwPyLgGnr2H2oDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEgLfOcnZT2r4BtD4Pma3B0D5a7EF5UPEKngOJ+GFX8=;
 b=cDqs1HNMJ5zN4wjoZk8U+1AoSt+9GCrYPsZp60ue4eefrhKA9FW8XSBQSXtMpsDuqpPoNKW4EY1kzbsmOrwzvIZqbtpc4lQLHy8LrG+50TsX7t40UIyIhkz8KFheqvCKxE6kwovNkErTuViWOKvKZBn3y4JMYPPiMTOjz7MGsNQ=
Received: from BN6PR19CA0079.namprd19.prod.outlook.com (2603:10b6:404:133::17)
 by BYAPR12MB2694.namprd12.prod.outlook.com (2603:10b6:a03:69::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 21 Apr
 2021 19:17:48 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::a9) by BN6PR19CA0079.outlook.office365.com
 (2603:10b6:404:133::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19 via Frontend
 Transport; Wed, 21 Apr 2021 19:17:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 19:17:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 21 Apr
 2021 14:17:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 21 Apr
 2021 14:17:46 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via
 Frontend Transport; Wed, 21 Apr 2021 14:17:46 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: get socBB from VBIOS for dcn302
Date: Wed, 21 Apr 2021 15:17:46 -0400
Message-ID: <20210421191746.126617-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eafa2e6d-6c71-45f0-5c2e-08d904fa2604
X-MS-TrafficTypeDiagnostic: BYAPR12MB2694:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2694781E62A0B6AF7086D6FE8B479@BYAPR12MB2694.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MyD8QcGWtT1uvQl2sFhEGGzYv5RlrQNdrEeEYNN3b8PuDkfiOt1stJACbJeKu+Ho5atxT4SU37YELgZsoClYeS+KUTVPYiZ2c6UZ09k2FsaudypBFhGz6c4xsPtWz+mIV73gNoWhYipuKWaPezxgsl6W9Dbk8vh1UmDa51zWSz6sWT7Bxr0mGPJUWd/Y8oZXmCSY/4dhfFzBr0c0kp3NQuUni66eyfkyo7AynYxKGSK7FpU1EVjtsVhaIRYWGtmKVxoFlklKs/YVJZn12xzZsL6f6d7ceIIkcTonKQ83iJODUajmxm0OuMFqy1Ch2hLRvKrf4WtnZl/K9Uewmzz2uXS4w1qaWRDc94TDAcxt1IipANYCbyphePdBvVL/5wDNkoWScsZHuXcnuvu2Cm5NEyBG6aCbYvUAPKAtn+nUHMjTwKRH+UYQwVNtgPEa6QAP7rxtZ5ZM7807OIYYroaRWnzLfzDs/CuVWIAZHRECpfs9KpFLswAtfi5GZlo6fNPwvoGzhEe0QZOdbLN1HGFFMKApwQckiZTlpIIxGyuGA0Ku5X1+C3s+fDx6Xi6j1LeBLHWA4JHCJvAUxRnoirh8T05YmCQ/o5j9FI7jJCC2QBMEusI7CKdCzCDhbsDYvqcE8twMUMptSde4j9QcbB6OWgbg25PUEsvmtIXn9orqQwDcrWf1B8KIFvyKjq3whfcj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(46966006)(36840700001)(336012)(70586007)(8676002)(70206006)(36756003)(86362001)(2616005)(6916009)(7696005)(186003)(26005)(426003)(316002)(54906003)(8936002)(5660300002)(4326008)(2906002)(44832011)(1076003)(82310400003)(83380400001)(478600001)(36860700001)(81166007)(47076005)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 19:17:47.5361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eafa2e6d-6c71-45f0-5c2e-08d904fa2604
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2694
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
Cc: bhawanpreet.lakha@amd.com, nicholas.kazlauskas@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
Some SOC BB paramters may vary per SKU, and it does
not make sense for driver to hardcode these values.
This change was added for dcn30 and dcn301, but not
for dcn302

[how]
Parse the values from VBIOS if available, and use
them if valid

Fixes: 93669c8e48 ("drm/amd/display: get socBB from VBIOS")
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/dc/dcn302/dcn302_resource.c   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index fc2dea243d1b..f44814d15206 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -1101,6 +1101,26 @@ static bool init_soc_bounding_box(struct dc *dc,  struct resource_pool *pool)
 	loaded_ip->max_num_dpp = pool->pipe_count;
 	loaded_ip->clamp_min_dcfclk = dc->config.clamp_min_dcfclk;
 	dcn20_patch_bounding_box(dc, loaded_bb);
+
+	if (dc->ctx->dc_bios->funcs->get_soc_bb_info) {
+		struct bp_soc_bb_info bb_info = { 0 };
+
+		if (dc->ctx->dc_bios->funcs->get_soc_bb_info(
+			    dc->ctx->dc_bios, &bb_info) == BP_RESULT_OK) {
+			if (bb_info.dram_clock_change_latency_100ns > 0)
+				dcn3_02_soc.dram_clock_change_latency_us =
+					bb_info.dram_clock_change_latency_100ns * 10;
+
+			if (bb_info.dram_sr_enter_exit_latency_100ns > 0)
+				dcn3_02_soc.sr_enter_plus_exit_time_us =
+					bb_info.dram_sr_enter_exit_latency_100ns * 10;
+
+			if (bb_info.dram_sr_exit_latency_100ns > 0)
+				dcn3_02_soc.sr_exit_time_us =
+					bb_info.dram_sr_exit_latency_100ns * 10;
+		}
+	}
+
 	return true;
 }
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
