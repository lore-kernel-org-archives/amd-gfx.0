Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A97ECAAD8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D604010EA12;
	Thu, 22 Sep 2022 00:19:39 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2075.outbound.protection.outlook.com [40.107.96.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4BAA10E9FA
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:19:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEWlTuWT4cY4qZ5cvBcbZYXbnnYpliuY/wuuTsYWMOU3549oPW2wOwbkAm9kw8/h970QRPDGGNS5VPAp5PEFW4Z7QKCE80FaPgbGE8aL8g3Ouv2HgMKrAF8axY6oebwsEglvzMKxamZl6uOjlNchzTPd0xg9spNlBHgpDieRnQovYiuIaZx2s8We5k+oQ55Shbul3+QEcuwo5+Z37iHW/lUEzi3MTkTioUKEmfFSJKcHcprrmH947ee2S0sx8uid+Y0e4ZMGe39na0uGLWa8xrr6A8k5azFpsLs5NRyqZmioR9oXkHDSEYxo6e/ANiSZ1PyFWHWeoY/11OZ4qvtl2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBhXbP2j3WqpOWemWBOgkMJe2HmQ95aOI8kcUPMU4wY=;
 b=kMgtkTQVYoeHGaiNrQrFwL3QI0qFPgDYmVPx4fzRmytr/nsCXMDRrh1Wvq+ME+J4Bl+fXaEgnWyWi218njoXyYevUhAJsVP/ylMdgA513VhLxttjDpqT2Cp5JNOEkyH29BXm9pHzPoGQH+ZEf/UzdtysHpJgmiDPTbAucxeLGExR9UuDbc1CO3doxCHBSWmIwaWvNyp/0ZIucslbXWzcKhkWDpw6LfVfQvVUVaMgXFLUYE8WGbV8Cbd+mrMOOl6ALCPbMLZkrM3hlAblx191aloVkscTbid1G5onnEyOBWhWM+8+NKUzZ0pEaPxtdgURXao89vmMekWbPQwiZ9RQJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBhXbP2j3WqpOWemWBOgkMJe2HmQ95aOI8kcUPMU4wY=;
 b=ay1hDQSo56vDf8RjgzG7g6aKyClzLtKH176AQ5fT9WrIrqg8E9mH42qxPDpYUamSr/Dzk38L9Fu1+6UaSiZXowbX5rpHf8xieKZxgb4KDJeXZKgULdmJfvqlf0Yi893m7iCggQu6UvfhpeqpvMfmTAeqdxv/4/5CftRgPbTpj6E=
Received: from BN9PR03CA0896.namprd03.prod.outlook.com (2603:10b6:408:13c::31)
 by SN7PR12MB7130.namprd12.prod.outlook.com (2603:10b6:806:2a2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 22 Sep
 2022 00:19:24 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::ca) by BN9PR03CA0896.outlook.office365.com
 (2603:10b6:408:13c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16 via Frontend
 Transport; Thu, 22 Sep 2022 00:19:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:19:23 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:19:22 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/31] drm/amd/display: Remove assert for odm transition case
Date: Wed, 21 Sep 2022 20:18:15 -0400
Message-ID: <20220922001821.320255-26-jdhillon@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT068:EE_|SN7PR12MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fadc7c7-dccf-42c6-0ec5-08da9c301a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SWMzbn9D6i7gOsg6y0/FP8R806E8tXxfGlcM1/aWJlDpOU40pOAqEoiHL4PlkVlJeVm+zwleg3WqWXFGtQrjLCXGcnYSjiqpQtvJKWlewMMJuvehkSaqNCOrjTgqYls102URs89HRR1cQDbObRqvKE98i+MsaquhT5f9krP1yvsuO27up7H4cJBQJSgMXOQSDm62jL0omwvFEheTgbzNqxBM/Tz2H/CS+raeHr7YcIyiyBH6R1iUouThO6BwLsfM+QTCjs7xZiX23As/w9JCQqIO8ogxAwomIhhfbvBDMhAyiWOz2iHwXd9eoS09qc8sFZoRjgSg+L9dSqU6/IC/DXc8URMHqblzoak3U0YZ4UvxvP0RQjY3KOTaGqiGNwTZnRTkUNSBIvMxoui7jFt8FNHj+pzNo3VMf5DmLlOQaIof7EilbTuAYCxM80+ITlPMqu067627a2ER4hVP7iuJgXccwMB5FGwojf+GMn9oWY/gowRLo/6iYed3+gy6logmVtlnVa7FdjleefZ2tZAhVus4O0hBdawcahiRbS7T4hq6yaG+akDgd3Yby9Dgqb4R3nYfCgoh3Jq48ovwlaHbzLz9SUR6HWQuxyKvGouOagoVxGsPuNuwrh+W/xmMndK3rinJbNh5d3QtPSIwgm9YzJsCglkiGPJE18+8/9SVIb5NgNXEc2sy5iIsxSw06QypzdlqW7eS3GQRrBRmTNFc1qeUsqvlCY++hf+C/Ix5slFqMfRzzXaCBpi5KJn6Y8oNnJh9vk5ad/DCLmB/sagF3dBTRImP5TtecotiPIJrNe8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(316002)(36860700001)(83380400001)(82310400005)(47076005)(426003)(40460700003)(8676002)(4326008)(36756003)(2906002)(70206006)(70586007)(81166007)(356005)(82740400003)(478600001)(40480700001)(26005)(6916009)(186003)(2616005)(54906003)(16526019)(336012)(1076003)(5660300002)(41300700001)(8936002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:19:23.9735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fadc7c7-dccf-42c6-0ec5-08da9c301a53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7130
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Eric Bernstein <eric.bernstein@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

Remove assert that will hit during odm transition case, since this is a
valid case.

Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
index 0b70247a5d36..f6d3da475835 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
@@ -98,9 +98,13 @@ void dcn32_program_det_size(struct hubbub *hubbub, int hubp_inst, unsigned int d
 	default:
 		break;
 	}
-	/* Should never be hit, if it is we have an erroneous hw config*/
-	ASSERT(hubbub2->det0_size + hubbub2->det1_size + hubbub2->det2_size
-			+ hubbub2->det3_size + hubbub2->compbuf_size_segments <= hubbub2->crb_size_segs);
+	if (hubbub2->det0_size + hubbub2->det1_size + hubbub2->det2_size
+			+ hubbub2->det3_size + hubbub2->compbuf_size_segments > hubbub2->crb_size_segs) {
+		/* This may happen during seamless transition from ODM 2:1 to ODM4:1 */
+		DC_LOG_WARNING("CRB Config Warning: DET size (%d,%d,%d,%d) + Compbuf size (%d) >  CRB segments (%d)\n",
+						hubbub2->det0_size, hubbub2->det1_size, hubbub2->det2_size, hubbub2->det3_size,
+						hubbub2->compbuf_size_segments, hubbub2->crb_size_segs);
+	}
 }
 
 static void dcn32_program_compbuf_size(struct hubbub *hubbub, unsigned int compbuf_size_kb, bool safe_to_increase)
-- 
2.25.1

