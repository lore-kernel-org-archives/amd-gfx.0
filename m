Return-Path: <SRS0=AA3p=DL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597DDC4363C
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:20:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E2D206B6
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fKy4sTqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E2D206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB3F889E03;
	Sun,  4 Oct 2020 17:20:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6058789E03
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Oct 2020 17:20:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gz2c0fLKUxVX1178dZeTMKjZcIfRKEKQL01A3y7mAuEAzL+uOY4i+d6oJYkxebqDWu1sQp8Sij0JTTfSSuZZQVBE8bbYowab5utmDtbRBIXZ857FFwNyM0b1VWVj4IhQn4PrpgCOJEGQpSNROu79z034tWucZENrCqgfhbntJ05nxlG/XIxlmsKMq3ar3SYd2sBaJu8fUVy88PVLhHEM7hDLumGbya8qCA4+igFYzPn7jWElRz6LDchZHrW7d3EMxilppY1eqo069Rz7KtM1/OhgcgYwbwrhYAyp3E0lHoqnvnL3PgOg7aR4ShT8h+Yjdz0+A4ByEMd42ug6QI+4iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SxBPjvA8UdZKSo8AP8mDFwsrcY7CXxdyS7gLXZ2/Mg=;
 b=SMDyG0vm1tMHCSxEH32+PWNLBUmn4SlERne2dhgi1FmgalZVufZgTmoAmQCycz0BiQpvFuBOmHbnuMNeItf+/0cbE0Z5vTlJqnalXEmOnDDFueAwonTJijMnn3KjyWjptJO7p95YZamfP0wkAeIfmn5WzB//f/0RB8nJ+4talkVj3Q5cHY2/F0L0uKXyqrwJwu3JIlcG64RCLvq103opH4dBsaBXpLhNVl5DPS7iRGTw/UseEh4Ndw7dvVYvz4fbmdn8h0xwhHUyDLZMWJ86KWp47IdvOEDJzAUfGrJAQKGGzOv60L77t6ferNlrVRRxrumAhBP6sDM1TjLBl3SLMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SxBPjvA8UdZKSo8AP8mDFwsrcY7CXxdyS7gLXZ2/Mg=;
 b=fKy4sTqkBfwjCvdmfdJZ14jktVhPpl2LZdOSDRz/Qh6AoDkR7zcrl2BKx+N3BWAJ+Kf2hMFlN++lkLiyhe+ZY9dzD6Buo47AP/CUvR6JA+N8MO3IkIdWh/ZdgBLNJ7PTTzWEFynA4VT9qSTKejAs84+BeSZUvYs9jCrZmdauhbs=
Received: from MWHPR17CA0068.namprd17.prod.outlook.com (2603:10b6:300:93::30)
 by BY5PR12MB3745.namprd12.prod.outlook.com (2603:10b6:a03:1ae::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Sun, 4 Oct
 2020 17:20:12 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::1d) by MWHPR17CA0068.outlook.office365.com
 (2603:10b6:300:93::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Sun, 4 Oct 2020 17:20:12 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3433.35 via Frontend Transport; Sun, 4 Oct 2020 17:20:11 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:20:11 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:20:10 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Sun, 4 Oct 2020 12:20:05 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/18] drm/amd/display: Program meta addresses correctly
Date: Sun, 4 Oct 2020 13:18:09 -0400
Message-ID: <20201004171813.7819-15-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201004171813.7819-1-eryk.brol@amd.com>
References: <20201004171813.7819-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35788c31-d1e2-4fd8-dfea-08d86889c06a
X-MS-TrafficTypeDiagnostic: BY5PR12MB3745:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3745D9FCB58052DBA75654FEE50F0@BY5PR12MB3745.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYPqPLjTcGgye9f3PnYEG0MLykstocjOHFtqC16S0z40fYJlqQsA7ooe6PoBYp04BJk/isFRBqo9Hm45CLKLIcUaz1tkkXrCCFvMR4YjEitjWLmcqo5EVrcR/JrmHgpxgI/gNecD3GY+bmOW80Psk/Zhs5N+vtsquE3T+8BrQKLfezIXrxlLY6U2YRcdcGo+hmWwQvN2dyNxhN+cPDgnnvHrY+N59cC2p1lttS+kn7GuaDVO+fBW55iXRNckMlRdghI6cLNZ2gUzxrML/Wk5W+wWuilSIziRaojtmKI650LbgnBqqCIbALuYW5lOvbz4Ym7fzeZeE6QhMr/TZR+aN4YOHk8ljaJzXZOaK9Enx/QBgFJGM5jLp+L5w82ik83beQHg1dMqwvfLT+Hn7D2U5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39850400004)(346002)(396003)(46966005)(2906002)(82310400003)(54906003)(82740400003)(26005)(4326008)(186003)(81166007)(1076003)(70206006)(70586007)(356005)(44832011)(316002)(336012)(426003)(36756003)(86362001)(2616005)(478600001)(5660300002)(6916009)(47076004)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 17:20:11.9164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35788c31-d1e2-4fd8-dfea-08d86889c06a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3745
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
When forcing 3D mode in DAL, we set the right address to be the same as the
left address. We need to do the same for the meta addresses.

[How]
Program right meta to be same as left meta.

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c        | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 86a0d46ff2e4..9528e3a46b28 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1535,6 +1535,8 @@ static bool patch_address_for_sbs_tb_stereo(
 			plane_state->address.type = PLN_ADDR_TYPE_GRPH_STEREO;
 			plane_state->address.grph_stereo.right_addr =
 			plane_state->address.grph_stereo.left_addr;
+			plane_state->address.grph_stereo.right_meta_addr =
+			plane_state->address.grph_stereo.left_meta_addr;
 		}
 	}
 	return false;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 01530e686f43..04b939f3cdcc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2034,6 +2034,8 @@ static bool patch_address_for_sbs_tb_stereo(
 		plane_state->address.type = PLN_ADDR_TYPE_GRPH_STEREO;
 		plane_state->address.grph_stereo.right_addr =
 				plane_state->address.grph_stereo.left_addr;
+		plane_state->address.grph_stereo.right_meta_addr =
+				plane_state->address.grph_stereo.left_meta_addr;
 	}
 	return false;
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
