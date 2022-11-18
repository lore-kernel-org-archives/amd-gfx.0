Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE84C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 17:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D97BF10E78F;
	Fri, 18 Nov 2022 17:01:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFEBE10E792
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 17:01:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QO8EKzfUXw1xqhxFSvEmMqtLWIVlbJBc4T0PqGppI0dkIN5Ar7POeSa3ZaprEPtwnsdg9MO0tviL9Iz529sPkz+3L3eTe/tdqLJtSlDAqYpznLHgcOqcAhvXWStfU2n7v7jxqstFcLRNAs34AMNlyROvknh104JHy9tolJMVOXGznk3/iCYglTDImYs3CTOMPbO38dWxPatSAF9Uzy55eRtb+X04sedFFWk0ryphqiAJ6dhaA9uFtXnH6MmZ5mAsFrQqhLv29l5b8WvVhLJcP5MqEtHR/vygArSNkG5PWiOwj8EzsYXF22tJ9kTbI9/dFvgUnyxdDQ7zrhjVGYPmZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpnM8bYBshWzaczOsi0zDDwqW0kxUCI9t0iPWjqRbPM=;
 b=UdX2md16ShnQzv4iGBB6P3J1GNoOoc2/OYAwudmM2tD+gHFELTuywzkw969lq79gZy992MrJuqLt1wdLYa3314BtTv+mwtlCgkOga/uuWKtRlBdnXVSs6XtC4YSE5eQqUbcZBnzJHRATDBRF91P8l/UzEA2dDpMpn+0bXBLLMQtDAkwEFnA6z5L0xdJqTXiGiHr1C/gtK5DRKU3FNyGg6mZWqA+C4lQkFduqh5qr3H6Zb1qgNxvaEO8Yo/s+Vx8CmZ7eBIJFmxDKASODP6GC1I6FtWclxGXu5k9Ko+EyS5KZVv/Bfmr7tFSUyNfABb4M9a+U+UaBEzg3XCENA/vyyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpnM8bYBshWzaczOsi0zDDwqW0kxUCI9t0iPWjqRbPM=;
 b=ur08F8AELqXavMH+70q4U4eGWe3X64jgDYnAAW5qMtqC0Bvf3QqstnP+7z6eyZlLtwbOgFrG8C5GKxbMKpozXt28cutUghCnsEZ1D+sheyYoOpMtMZBMAK5AcV+aGZwBhJydU6kpcJ2wP+73OD2xeDg+C0XAV8QOcEx1cyJJibU=
Received: from DM6PR21CA0023.namprd21.prod.outlook.com (2603:10b6:5:174::33)
 by DM4PR12MB6062.namprd12.prod.outlook.com (2603:10b6:8:b2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.19; Fri, 18 Nov 2022 17:01:16 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::70) by DM6PR21CA0023.outlook.office365.com
 (2603:10b6:5:174::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.8 via Frontend
 Transport; Fri, 18 Nov 2022 17:01:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 17:01:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 11:00:28 -0600
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.34 via Frontend Transport; Fri, 18 Nov 2022 11:00:24
 -0600
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/22] drm/amd/display: Use viewport height for subvp mall
 allocation size
Date: Fri, 18 Nov 2022 20:59:24 +0800
Message-ID: <20221118125935.4013669-12-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118125935.4013669-1-Brian.Chang@amd.com>
References: <20221118125935.4013669-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT046:EE_|DM4PR12MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: 3adf84dd-18eb-494d-6034-08dac9868177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9igq8Kgz4plqPnAQT5kQ4mcFfFf5lidnemgl1JQ8lCtORFESTK2ZsM0+BAnwyQGjuCmAjOMuYmPp1daLjvle9DB5zRiqwZnjMYBkadR+vj8FHTrQ8m/roHcAYEWck7xvaMRRE5BVkbXCzl5+CDYT8Z73E2ZpGA8Sjfs6qKqZaLvcfFGZkamGmkGvJRO302v+0Ovv3npnukcfe0yb9CZiUEpB3e7s/16wZ+3K7TprlcJ55GawSqh2Uuu7w5H/sTywhWel63pPD4OxlNHvPuwg3RaXCi5AWYdpLNySZ96TR7i1tzW9+8/Ab6KdxEheH24sHg2A65a/rSyqQCZoALqVU0jiYPd0R8TfUM63O+I2IIN4wbhPYTlgemWnI6GIVVWz2JWvH+u3lhUbjseX4J9JHNUg4uTNsdyVi/Nljr3H0TmRVhDE7a9KQ9Jf74m25YBFr05sCVo6np0uzWAIJXrMZSGhjP6I9rz9AvkQUzt0EL6/ecr5SrqSqOUAlCjir7+LO7rDPo7Yh60M+eE5IbNLLWT5nyCOLO3jYxdKjs7rmKPGk29BRzjvR1gdjnCW2eF0eKP5OqpaJxx9NjDJCxHDX7KpMJ488peQyf1YQUdoDGKjCKTVjedZ1uk28GCg+0DA7LUSMGxh+M+NQYa7P4qTPIBZbuv9Ra2Oa+PPU+PxZwKmOXVf1BOxtJ7PFVw9MpXhJnE9sK8MiTZVr2ycHMmfwmFnBU8pV5y40uVNKZmUodqv1oiJ6VDikaTEpdV6hYC84V1RPnJm0tlx4HBcUHR8qg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(36860700001)(40460700003)(86362001)(40480700001)(36756003)(356005)(82310400005)(6916009)(54906003)(81166007)(82740400003)(316002)(7696005)(478600001)(83380400001)(186003)(2906002)(2616005)(5660300002)(8676002)(1076003)(47076005)(336012)(8936002)(426003)(4326008)(70586007)(26005)(70206006)(41300700001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 17:01:16.0450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adf84dd-18eb-494d-6034-08dac9868177
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6062
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>,
 Dillon Varone <Dillon.Varone@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY?]
MALL allocation size depends on the viewport height, not the addressable
vertical lines, which will not match when scaling.

[HOW?]
Base MALL allocation size calculations off viewport height.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index b03a7814e96d..fa3778849db1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -111,7 +111,7 @@ uint32_t dcn32_helper_calculate_num_ways_for_subvp(struct dc *dc, struct dc_stat
 			mall_alloc_width_blk_aligned = full_vp_width_blk_aligned;
 
 			/* mall_alloc_height_blk_aligned_l/c = CEILING(sub_vp_height_l/c - 1, blk_height_l/c) + blk_height_l/c */
-			mall_alloc_height_blk_aligned = (pipe->stream->timing.v_addressable - 1 + mblk_height - 1) /
+			mall_alloc_height_blk_aligned = (pipe->plane_res.scl_data.viewport.height - 1 + mblk_height - 1) /
 					mblk_height * mblk_height + mblk_height;
 
 			/* full_mblk_width_ub_l/c = mall_alloc_width_blk_aligned_l/c;
-- 
2.25.1

