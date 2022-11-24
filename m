Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC28C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Nov 2022 21:14:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A00410E271;
	Thu, 24 Nov 2022 21:14:17 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B3F810E270
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Nov 2022 21:14:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fO/SGHKipcEgNyvbg6xpwLOZTjQE48jnQ8doxbkzPFwN6Rb1Z3E0nKct2bGXZa5KsGSlerEj5FXELQi9sNujPWXhNcjYa/n8MrFiemYqeGuvb1uFXUPaJMrGnaPDMEPW1A6bgqRa6a7kcpIlyyUMJL+QH1ojgRpS70Xjgi6rsD7EMdKtOfU3PN5aNWH1YZ5f/ar8ab+J9J1AwpT5qSc/1po9cHrqnTfpD7i4R40t9DqafHv0a/5UFUfdOvsowenbK6E7lceCAIyB75wKivJObWoMGBC3rnw3m1kzOXGYIAfQv2kJoT8y6CvPttyAQmXI0CPK+jFD+igPTSla2h3q/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jweIKILukRDmjqCsUkNEqF6igdXacNiY2wfIbfNqqW8=;
 b=lCVVjJiQVyTNVnOfvCMTfjI++B6PDPrSDsdFOSsmJd9h/ebBa4ECRr46NGG0/1xXYLypxk7O9A5VfNdigtuIGjTrRHOepPn/MqhjIv6U5+4NYfblbTacsNNmiuEAdiL5O91gX0AHWOKh+j2sBZwo0nMSVao86Q45I/pJwB4ucHFu78l7oFSVA+QDZmnd9NuUl66EzHKcaALy6PHQa9u/TczZFcThvxx4OpWBCBL4wokO3OhNf+BXi5OAgQLz3Z1qDUTYnIVptr9AK7tSpjZ4hy+mf0/796P0jKzvNf/2G6RkvfbxxK1D5ftYwUgizg9qBW+7Ltw5eVybo8cZy7KzIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jweIKILukRDmjqCsUkNEqF6igdXacNiY2wfIbfNqqW8=;
 b=5UNsL6pYeYn8zmQwkqevw312DmSGaXco4DdvhtnxgrO6vAxJvVtjh96GMTWZmX51gsIfCNHz2w3/Z15Z/RhKaRNpKMEeX9gHA3PpTi2a5sQUl75r66Agk3RuS3FlifNkzVSiRhwesch/wqbenxp0nOyTBL7ZKYQNCyeXRo9UAJk=
Received: from BN9PR03CA0046.namprd03.prod.outlook.com (2603:10b6:408:fb::21)
 by PH7PR12MB5927.namprd12.prod.outlook.com (2603:10b6:510:1da::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 21:14:08 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::78) by BN9PR03CA0046.outlook.office365.com
 (2603:10b6:408:fb::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Thu, 24 Nov 2022 21:14:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.17 via Frontend Transport; Thu, 24 Nov 2022 21:14:07 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 24 Nov 2022 15:14:06 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/12] drm/amd/display: Fix arithmetic error in MALL size
 calculations for subvp
Date: Thu, 24 Nov 2022 16:13:43 -0500
Message-ID: <20221124211348.214136-8-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124211348.214136-1-jdhillon@amd.com>
References: <20221124211348.214136-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|PH7PR12MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: adee9282-7e00-4491-08ce-08dace60d31a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LCGQfZJFPgAF7tmqiee+BGOgGDN6cXj748sd+PsZ1AjgbcFSojHpnhZUfvNP6akL9wyQ4Ax+UifWKgah6ZaO7FpMc9ZK4FScSbHjYcceogQYiuaujXcokCc20JbD9ApqpIuVaQY/KbyQYEuMfcWf1YzwxQfHXIWlHgqlO58E2gEleELRe5oHDwLkL6Wp//oCFMBFyVzNICWSPVRSm14G1eJKpFrNmqgJNE74ViqhSCtWMNqm3bvMyKlSGztsAo4QevsuX0c/5kZoLxfpGRoufkQxrUop6JiKG3KDrFgPQ6wjjdiCxjOmzf/fXlKZ9BjJkecuBC2bst1ME3wWt1s0YkDmVWh5qrxGJlxFjN2GikXxUBPPUXevvX775lWiDqc3EU5y+LE2/wcYeyTPqBXknzjgYtRldACKkErmpBpbcigpZZDEUODuFnUYscvHRwP4853EP6ShmtGKg5czUFfcix7t6dMuVJfPKLqFOOkRe93PcvmeZj8m1i1I+4HG9BNz9bVgW/vt5bjoCqp/sgZgyHh8De3suZycFF8wtBrcO+PihqWo1J4WxRqYbheuvp5mxAvSTpeFQNiUNbPsxi6GzzcsXW7TIscgUYdalURteDH02v+bV/ceVMgeNShKowJJ++xcyN64M2KvNDF0S77dsZm+DAQ9Z8ywcKMJkttYT3RryfNKvsS2QoFFHYEexdgebjBIUoNUQfylIS+8g+pU4YKZxybc4+VIZ4jckuAnQkY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(46966006)(40470700004)(36840700001)(36860700001)(478600001)(40480700001)(6916009)(36756003)(316002)(70586007)(70206006)(54906003)(4326008)(8676002)(83380400001)(1076003)(336012)(40460700003)(2616005)(16526019)(356005)(81166007)(186003)(82310400005)(41300700001)(5660300002)(6666004)(8936002)(2906002)(26005)(47076005)(82740400003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 21:14:07.9758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adee9282-7e00-4491-08ce-08dace60d31a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5927
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[Description]
Need to subtract unused section of the viewport when calculating required space
in MALL for subvp instead of adding, to prevent over allocation.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 94fd125daa6b..783935c4e664 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -97,14 +97,14 @@ uint32_t dcn32_helper_calculate_num_ways_for_subvp(struct dc *dc, struct dc_stat
 			 * FLOOR(vp_x_start, blk_width)
 			 */
 			full_vp_width_blk_aligned = ((pipe->plane_res.scl_data.viewport.x +
-					pipe->plane_res.scl_data.viewport.width + mblk_width - 1) / mblk_width * mblk_width) +
+					pipe->plane_res.scl_data.viewport.width + mblk_width - 1) / mblk_width * mblk_width) -
 					(pipe->plane_res.scl_data.viewport.x / mblk_width * mblk_width);
 
 			/* full_vp_height_blk_aligned = FLOOR(vp_y_start + full_vp_height + blk_height - 1, blk_height) -
 			 * FLOOR(vp_y_start, blk_height)
 			 */
 			full_vp_height_blk_aligned = ((pipe->plane_res.scl_data.viewport.y +
-					full_vp_height + mblk_height - 1) / mblk_height * mblk_height) +
+					full_vp_height + mblk_height - 1) / mblk_height * mblk_height) -
 					(pipe->plane_res.scl_data.viewport.y / mblk_height * mblk_height);
 
 			/* mall_alloc_width_blk_aligned_l/c = full_vp_width_blk_aligned_l/c */
-- 
2.34.1

