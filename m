Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6E5C433F5
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Feb 2022 01:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 388C910E251;
	Sat,  5 Feb 2022 01:50:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A84010E251
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 01:50:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDhRemmOL12ffaK3ckmgklFVzT/vN17o5s4cmaY4ZxSbB+Pr378UON5eLl2xJTc5LbPF+F2V523Y4okZcEDdEH+a0P1ggUW2H4uHt4IPodqAN2nB+CX7lgTXOlGwyRSTHEBfBCGqd2X2w7cFe4iTs7k/TmE0Jeyfl2GbIz5y956uzmyS+jRzTtSUSbr/j5L0zixb/SqDP+x9mmbK4wihzSYQ1itqFA5ecHk1Go0Cj47JGKlWHw5myLh1/o/sE6rHmvVVbM0H6uyIXS4ljz9XyVZyMhakCd9aIYNaDcXFTnYLmL/wy41Td4ZUhFNlFkOD16lALxZ4H1s74sks0uwzBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Fo6q/M9rvEgna8FPIKJVrGr5721DQ8dEzihaiJrFEI=;
 b=Ghy5E80yRTaemZBXgzXQ4IBFfyAhbLAlJPR2BVcY7eG3eZsdGgPRshezaF/5h4D8bM/SdL6mDWJAgDaN6kNjWKI0n1HjXGBJ7FlruAQq2ovAmsouMxL0PAVcxIdYb2GxAKIqNm/JNqHOCXAUHRflu4c6KAVwkpuD4U4A3Wj74JzHEP6LGBaxUXbWGl/LK2yK2XWdbRJN9cczpoehkl1d/NG8Z1th9nIdOPFLicplUnP6m5cN7aQFK1iRAxKRONWDO8wwJqWSH0xZsfPBTUJLwiLhcJU2x7kZCLk7p1Qr8PkuS+uORUz7xDplpHWwlxa6o7sfMSMHNPopEcb7WtvbMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Fo6q/M9rvEgna8FPIKJVrGr5721DQ8dEzihaiJrFEI=;
 b=uGmpGGNZqRB9dGo7dJogufwg1yUxl0mFs1H1WyW80g9vCF9diSEr5TFrJ98DZ8e84DOhHjI61qVGHqW/mCRGNfRUWTVN0QD9ZeKxtJoXi/Hezt/2p+CLYfXxFl03awc7fDMAuBm99jrYCTpwta7NbLRSiqUycQYxmGBfHziN9D8=
Received: from MW4PR03CA0145.namprd03.prod.outlook.com (2603:10b6:303:8c::30)
 by SJ0PR12MB5405.namprd12.prod.outlook.com (2603:10b6:a03:3af::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sat, 5 Feb
 2022 01:50:48 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::cf) by MW4PR03CA0145.outlook.office365.com
 (2603:10b6:303:8c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14 via Frontend
 Transport; Sat, 5 Feb 2022 01:50:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 01:50:47 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 19:50:46 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/14] drm/amd/display: Fix stream->link_enc unassigned during
 stream removal
Date: Fri, 4 Feb 2022 20:50:17 -0500
Message-ID: <20220205015029.143768-3-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220205015029.143768-1-jdhillon@amd.com>
References: <20220205015029.143768-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 931f6724-68d5-4bcc-87b3-08d9e849ee77
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5405:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB540525F69EBCF12B6E9C3E59FB2A9@SJ0PR12MB5405.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+mAiS+LCsSKxuIMJ9AKzq3HQ00GN9o95nmlDZwr4rtHwfwlWAbOJtyE2UWkkGcJukFssSudRknpaVC8YNNNEHUO/EKcDlUIz5tClv3yQkEiwSkBqCL6duRBuKhz3MI1rgRqV1+QYCnsbwa80ttOC9/DNbgI5Xu7eNwe0rUzNzPDX01Iqq3PHPUti/gGrfbhsGVwNvuEJzXLWbALKRVhdxqHxdr7Tf7vLjnZJ1BN2pjzV01rwofjYz3sYvGnXoZXSWG7orEtXdFxwfahCdd50IejjAVesT+6CBn+L37/sJ+QrCeWcPJEi2k4AkkN3j50qzYsWY1unwnaDnzfCnXqRloTuJU5vJGBztkqcKA48jKXvPv2KVqMCxn0k+RJ0yBb7Aww34grK+DxNPVkcxmS0mK7nFId2J4zGxDhN6srBecouabilAjOXqQQF+r27l/Ot2P/I9Ap6WuXAU+t1BAPSd+iDZLyP+1/znPDvgWYJdE9N6XA/S8F5WZ1V0k/Nx0NXMVRdti/lwrDK4fy5ixwhxmzJ7mZ2D3IUbVFuipOpgfLhAh/UgWo7Mm8d4QHSALRnmkFzd2trCL5Utos4ndvSiHu9Z6qIp32Dxlyf5hmNN518R8aeHpVOyIhe+iILmTVBQALaWA8rZ7HF82vaGNajQVBkvIUJydK7tcK+Ky6eQx2rkUOAEP60U5r+Uv6ByK+Y4mB9YzbsCziVL5rm8uPYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(6916009)(26005)(83380400001)(70586007)(70206006)(8676002)(8936002)(316002)(4326008)(82310400004)(54906003)(508600001)(6666004)(186003)(336012)(426003)(1076003)(2906002)(356005)(81166007)(36860700001)(16526019)(2616005)(5660300002)(40460700003)(47076005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 01:50:47.8984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 931f6724-68d5-4bcc-87b3-08d9e849ee77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5405
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jimmy Kizito <Jimmy.Kizito@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Found when running igt@kms_atomic.

Userspace attempts to do a TEST_COMMIT when 0 streams which calls
dc_remove_stream_from_ctx. This in turn calls link_enc_unassign
which ends up modifying stream->link = NULL directly, causing the
global link_enc to be removed preventing further link activity
and future link validation from passing.

[How]
We take care of link_enc unassignment at the start of
link_enc_cfg_link_encs_assign so this call is no longer necessary.

Fixes global state from being modified while unlocked.

Reviewed-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index e82aa0559bdf..9df66501a453 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1965,10 +1965,6 @@ enum dc_status dc_remove_stream_from_ctx(
 				dc->res_pool,
 			del_pipe->stream_res.stream_enc,
 			false);
-	/* Release link encoder from stream in new dc_state. */
-	if (dc->res_pool->funcs->link_enc_unassign)
-		dc->res_pool->funcs->link_enc_unassign(new_ctx, del_pipe->stream);
-
 	if (is_dp_128b_132b_signal(del_pipe)) {
 		update_hpo_dp_stream_engine_usage(
 			&new_ctx->res_ctx, dc->res_pool,
-- 
2.25.1

