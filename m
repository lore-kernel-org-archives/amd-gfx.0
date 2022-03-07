Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE27C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 05:49:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 008FB10EA38;
	Mon,  7 Mar 2022 05:49:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC8CC10ED12
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 05:49:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwKwhoVe2jcdLyxnmZteryLV6qBtIEXBqy8pwDLatcwZZWHYI5VUFnjWo0X4oGnXuymBn5J+N1bRi9EYRPDfjyjsaBj6kSXJAOJGs2W+rlePGl0DYh9MgR6n7rUgG+9F87E5ahy0T2CjnfLWthAt6jiSF7B8TU+BTlmUAYb/WEASDYoSNa5QiGlT4YYEKnwIFNQcLzzRoFx60Ht/ib6S6yo4BzDPrH+NmA32pxLAUkCWGOLWpk8NBnDR1hxkaxVh7OwKrsWFqwf1DwEyYADl2TokvgaVtyPGC6dhqD7wGxr0CQQh9hgTBbyzBJRH3w8OtwXDkHx+HhOzEJhhDz4aJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoOWWWGxtvlpLaB85yMkVnI5nG2v1kTZrFzFUbOiM5Q=;
 b=m2uFgSoQSh5EOjBppmizPiXwZ3UtbqeMuKyAlvI/nX7ka4LEG93SXe2eKNPXTP2oq58Jojbjf/fM+OSFiZoa8jFsxOFpp0sQZUu211cfC4tBZjBBdELKXL02sVv16X4Ol+9cbvGSJruFbPX2eu6SK8MBGOhk20BZ1srDarjEzkzgp5PDA2Gsa6QgQEFp2OKOTubwbtPldV5T6OhNMCZK82TqQoUe5Q4fZ+2UJcRGLl6LsbSDQZ4jdPFQlsPByyqZZ8vWDu3rr/3v5gT5Y6Hhetav8Mde1zM6LCODgRcZlSWb/N4WhUgnQgn9ZQ+swCOVXaJj3jOm8b3OQ4jjjMtiow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoOWWWGxtvlpLaB85yMkVnI5nG2v1kTZrFzFUbOiM5Q=;
 b=Q2MuxK8cH0hDpgsTkKBN0Rk67IjVRoi8gZBIkRaO84lhmFBkAKyQo46fl1J6thlG6RBPS8UKBvG5lVPeqHRs3s1lF4wCEz+LAuPz9PmtrK/QKYhguBQSMcWrba7OC1NShxdtWmzx5HrGvfU1AaOExIeOmpnnnmCFjTw4Waz+PwE=
Received: from DS7PR06CA0016.namprd06.prod.outlook.com (2603:10b6:8:2a::29) by
 DM5PR12MB1258.namprd12.prod.outlook.com (2603:10b6:3:79::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.19; Mon, 7 Mar 2022 05:49:30 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::b0) by DS7PR06CA0016.outlook.office365.com
 (2603:10b6:8:2a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 05:49:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 05:49:30 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 23:49:29 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 21:49:29 -0800
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sun, 6 Mar 2022 23:49:25 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/21] drm/amd/display: fix the clock source contruct for
 dcn315
Date: Tue, 8 Mar 2022 05:09:26 +0800
Message-ID: <20220307210942.444808-4-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4943b698-360e-4e4f-335b-08d9fffe3f8a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1258:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1258FD7C46B45FB52C74252FF5089@DM5PR12MB1258.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VyktPrz7UA2QTrjq+ActLbEMzQaQqB5F/D+S4FJrI8DZA6qdOjrr868v9MEjHVm2c0nFn2O6MEpof0ImO8/zp5f2yUBzvOVaReEAdnASQxSl4Uq+BeoZ8UWJbhY13Eysh5OMvLlaqT37bOP0P9QzhcF64s/Q6Dj23KiGgeYyUSlp5+zgLkGAR707DOoiLPd7+wdp4i3HGlOz3Ywr23nZxIcGv9sRMT7z/5cilb/lH6ekNd3128fuuGBarWd5MuXfwLoJ5hlFvvF2b+U4P0jqTmpEdcEXHzOnHuHyLwSrOXN0nvur8ODVDVK1IJtdtF8SpN1qBRDr8z/0SNMv/IVDuz+N6lsbYK+sZJG6Cg2WNtw+2HOO7dxWPriIYKb7Uq5A5rk8ZseegEX5JLgn1PnDAKv3DFRU31MvY7lZFgsgG0Y+mHbkaR/O1803eEvAVlqNh0hs83aYVX4lstwc8hrws+l+JZDkoeI69i0WO4VvKdmeYgTnRy60MnbteVK2PGzhNRJmxsmmYgU9Y51qUS02raygemICHMAFwXVzvFVRPyAUp4B122yz2RN3Rob3iPH+00uz51QFQEb5/PKGJsxBhr6rJjkU2W9BHOmj9Y9Nj1tc6+swbSlTNkpkT/4fas+Lz1GKIGaapA0i3KdOYLXzQEqpVFF6M86g/ssroO6Jtf7as1jNiZsJ0XpybkOf+bWU8Ny5TPu7oc64VMlilveYnA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2906002)(316002)(4326008)(5660300002)(8676002)(8936002)(70206006)(36756003)(54906003)(6916009)(7696005)(508600001)(70586007)(86362001)(186003)(1076003)(26005)(2616005)(36860700001)(47076005)(356005)(40460700003)(83380400001)(81166007)(82310400004)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 05:49:30.1496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4943b698-360e-4e4f-335b-08d9fffe3f8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1258
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Hansen Dsouza <hansen.dsouza@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Alan Liu <HaoPing.Liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Charlene Liu" <charlene.liu@amd.com>

[why]
Driver sends invalid deep color ratio to DMUB. Update it to the right
one by using another clock source construct.

Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 9a035e517ca9..d161b8197631 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1760,7 +1760,7 @@ static struct clock_source *dcn31_clock_source_create(
 	if (!clk_src)
 		return NULL;
 
-	if (dcn3_clk_src_construct(clk_src, ctx, bios, id,
+	if (dcn31_clk_src_construct(clk_src, ctx, bios, id,
 			regs, &cs_shift, &cs_mask)) {
 		clk_src->base.dp_clk_src = dp_clk_src;
 		return &clk_src->base;
-- 
2.25.1

