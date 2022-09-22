Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA584C32771
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:20:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C71710EA16;
	Thu, 22 Sep 2022 00:20:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E20A10EA02
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:19:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dP8EkKrIlv4TjWpLhFWorrGWHnFlxzPPD0W6LPKPxC1xBgcKnS5wjFi9/boolSj9FAy41D4FUz5NPTp+aBtnWs8T3GHd2HAjdhoO3nOE3O502npoyQbS273jYmfxRxiM7f+E1Kdlwix7v856/5FCjt73trkkP6LZhwORQTgMJU1bwTJLH+9b0jD7sCIhQUxqWU9HcLQ08KdjzjbQNI1MyvOTh/q+VPNz4plibCZJPQTRAr3kd3bOHbjBeCz0i16D7jPk1ZV/0btNNofoCncUiS2XdtHt0FEMEfYL+PQ0n39IVgRLyR33CbWDt+OGU3NzlKMoqHwFbeMmMEbVGxdGmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BdCJuNyIFiIp8hK9FXVZy3YjDQiv45PS6FwR5CiEPY=;
 b=NQWrAmk7jifOaBR2YWE4P/tJkIVudR2gU0mCHNYlqdZtXFgHtyxC6lDrG6rVCCmQmOACNc/fA3jPJtYcTm0fj65vX1F6gBj4trMyLqCmCm12dtVQxsPHeVEKe0YG2cWvm/GGP4evxqVAVptZpW4Si6yz3slNF4h+O7NM56S8+Wq1iG6vcyqAJE4tNFPiDOtyqfoLyUUKwOT3hyVgLOpS6DWAsqwiy6PtO4alBluSfNz9gdZ6NJIkpyuPsV/ZAF05hnhN1XdDXCmw0u6d/FwFloLaVZZ76Jpm2MthH4CiIrnDUHZ1pOdqvMQzdVsRH7OdtpvCXnETrUrtLoWRIdsJiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BdCJuNyIFiIp8hK9FXVZy3YjDQiv45PS6FwR5CiEPY=;
 b=wY6lYvfPKjUdBzIGCnmizpQXqydsW3fFSZk+MBS+CmyGBHAW5b37ncd7w8VabYQSX9fP5m/AsVHQENx/3fvcj83WprXsz79TZ6od2JywXPw0WlWAX0Rc3c/XEcoQWN47rHjUH309wMVTG2sd0EQYi21wqWsnwPE8u/EQySToMZI=
Received: from BN9PR03CA0898.namprd03.prod.outlook.com (2603:10b6:408:13c::33)
 by BL0PR12MB5507.namprd12.prod.outlook.com (2603:10b6:208:1c4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Thu, 22 Sep
 2022 00:19:19 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::93) by BN9PR03CA0898.outlook.office365.com
 (2603:10b6:408:13c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18 via Frontend
 Transport; Thu, 22 Sep 2022 00:19:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:19:19 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:19:16 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/31] drm/amd/display: polling vid stream status in hpo dp
 blank
Date: Wed, 21 Sep 2022 20:18:10 -0400
Message-ID: <20220922001821.320255-21-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922001821.320255-1-jdhillon@amd.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT068:EE_|BL0PR12MB5507:EE_
X-MS-Office365-Filtering-Correlation-Id: a258b20d-4357-4762-ad51-08da9c30179f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jSy/3Gh9J8ZeNtdn7a0FbT93+i171B4E65ZeFDuKBkGhSolic/iZ8HPJUIWLh3PnEgvLBCkgfuZva/hIFtGrIZLNFtDT57zds0BlbXLcFr3ycN8FQ7tsOx1E9h60pjSnRKm3PeF9UJePAej3M6VCG4lC6HyGINvX8ZIoNAdwZf/MVkDZ5z1dmjaI+6IPeKJ8TEErmXlbRiqTTYVBpYVs//PLHb2ZMGhU98xMAnCoeHAKYmOYfDQdENTyY6MRLgxAeUC42ftDAXVEu0ELKs2pg4OeK6/dWMDvflmJWjy4O0HdyXrefi1fG26SsZyLuk1V6LrctNkZuFobGVESHnzDH+xiVQqjlSQguPYGj+turUsXfUO3YPtgkAnh/lSbVlTA9JK3hkuVZGTFMmmC6FS/SzgSum45ZeZX/M0hmvyakaMen/yiay+meW9RXuDpCRBv2OBbPyL/f4XrKrkC0KB4NMrf5221N4GWOFvF+1bLZYlnxug9cHj+HEea8L+5fy32SLrDW6mr+0m0gKNfxKV04AvuRTaMvJZKNAEaYnsfUfyFPgP5nXGMyMtV8H/q0y+dkQ1MpLaeqrTlTE4BmllD0pPKw3uxGmeBbZYfnHpNgv7zDGBpTofeKjI+xWF17c1XTcpaY1DrEXvNJzafGAYGBcbkQgQQxbRAND2CFSS714nvttYiynsGCljlYHr5zDK9DnTijsNPRBCcq/lfKAd9ssogUidlM5VydpHMsBJuHPrMuH7SmEP7i9mthUspHz/6wr6tMY35OCXAb84T9aaFO1UleakrBB+Uz2yQJq75ceo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199015)(36840700001)(40470700004)(46966006)(6916009)(82310400005)(6666004)(36756003)(2906002)(40480700001)(316002)(8676002)(426003)(36860700001)(82740400003)(4326008)(5660300002)(70586007)(70206006)(81166007)(47076005)(54906003)(186003)(478600001)(1076003)(26005)(83380400001)(8936002)(336012)(16526019)(356005)(2616005)(40460700003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:19:19.4425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a258b20d-4357-4762-ad51-08da9c30179f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5507
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep
 Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Ariel Bernstein <Eric.Bernstein@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
vid stream control is double bufferred, if we don't wait for video
stream enable set to 0, we may get temporary image corruption
showing on the stream when setting PIXEL_TO_SYMBOL_FIFO_ENABLE to 0.

Reviewed-by: Ariel Bernstein <Eric.Bernstein@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c  | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
index 23621ff08c90..52fb2bf3d578 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
@@ -150,9 +150,9 @@ static void dcn31_hpo_dp_stream_enc_dp_blank(
 	 * 10us*5000=50ms. This covers 41.7ms of minimum 24 Hz mode +
 	 * a little more because we may not trust delay accuracy.
 	 */
-	//REG_WAIT(DP_SYM32_ENC_VID_STREAM_CONTROL,
-	//		VID_STREAM_STATUS, 0,
-	//		10, 5000);
+	REG_WAIT(DP_SYM32_ENC_VID_STREAM_CONTROL,
+			VID_STREAM_STATUS, 0,
+			10, 5000);
 
 	/* Disable SDP tranmission */
 	REG_UPDATE(DP_SYM32_ENC_SDP_CONTROL,
-- 
2.25.1

