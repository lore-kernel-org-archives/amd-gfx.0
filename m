Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A9BCE79AE
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 03:21:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D671310E435;
	Wed, 20 Sep 2023 03:21:22 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C69FA10E433
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 03:21:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFDYUe6MGGJfgryZzi5T7jKAH/rSP/qQJ66oebE9HvBSWNWzAFTOjzViJotJQpuxl5gMBjlMBtbCUOuAx6owL3sd7eZOrusNp+2b6fAe1dx39Lnxo+kB5lOR61yR8HKQb41c67ODy2iO/O3OMnjIcLfvbdCfimzbRloDvg6HkYeILCgYO0QhEHsnSyDFTITZ3ckkkyF9uywDBWaYejrp5zyzh9CFOx5gwAxqrhzldxjJFiv1/rRdzXt3Lem4Zm6YyYL0S7b/igPdPth66Czx765rhFu7x/yBhZDu06NFnOYpCOD6QfNuy/+ynlfdkRj1FSRdSFQjkBBJNFbsYV7z/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otPSTkRd+xSCGjsXOazUOlWRDZkNyIlQugBdrt+Pg2Y=;
 b=caJNJ0do9edju9ZNhJNtgEH/o8eN6g39zbNsM4B7DWlnrp7oYJ/ficpu8lQt4JtpQkyxp/cLnaFIxUB99t82qhb10FBkhozh/xEpV+A9fQ76cbjbmsSgq1ySZ6ShpILDKXg0LIhl5yGtfYlG7GuYA0o/xhS8QCqtSfpEzZPbnGEStoVhFqhuNQv50PkGr64C1LxCKNf4Al7gLSoRpKQJc0AeUUtd27ZCjMDus2bxGNxJnZKwnyOkJqSajS1YKJ46CIodKzvyFe04PuyoHloeCuX40WRm8XlJR9X9w8LB7LfdLpNIyIx9VhWdFmwegkUdsflguOF1eEIFPI3dfcOwPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otPSTkRd+xSCGjsXOazUOlWRDZkNyIlQugBdrt+Pg2Y=;
 b=i830lzStJQfCWOC9uLaYeDdXX09/N4ihLwlUqekreTPfTH/FIv6AEo2k0vxC8u/7+IRQGGiJXDi3FBtll2XGnIc761vVx8eSArmHGGBVWgzoFdpdMoUTWiie/vPjqpk17MmpS5zSIxYGRVWoVN4dStPL5eabz83ITXumh7IuUwc=
Received: from MN2PR08CA0002.namprd08.prod.outlook.com (2603:10b6:208:239::7)
 by DS0PR12MB8563.namprd12.prod.outlook.com (2603:10b6:8:165::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Wed, 20 Sep
 2023 03:21:17 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::c7) by MN2PR08CA0002.outlook.office365.com
 (2603:10b6:208:239::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Wed, 20 Sep 2023 03:21:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 03:21:17 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:21:15 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 20:21:09 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 19 Sep 2023 22:21:05 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/19] drm/amd/display: add get primary dpp pipe resource
 interface
Date: Wed, 20 Sep 2023 11:16:21 +0800
Message-ID: <20230920031624.3129206-17-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230920031624.3129206-1-Wayne.Lin@amd.com>
References: <20230920031624.3129206-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|DS0PR12MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: dee39e23-6489-4531-0275-08dbb988a73b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dg7VgIBNv/5wXhS533Y7PdDQ5ih8/UPyUUBILyQik0PgxTnhR7DheXVU136UMXiUqGRZMwhtLsOERjB/F8SeAc7AUI6/5Uz62DQyCgjL4gyQAFDJIPtRafYZCGHYpYKEgxjHg4Re//krQGCJG5Q5uUgWL9amzOyXcRDwmBu/Z0cf2CAYWlREU8R7JrQA9T0DoM1x8iFFAKaIo94MOuJr+jvzJBXP1LeX+Ta6w2uv4lQQJyQmOy7ZLsyUhgesIm15TnXmhG4BnPpMsCyBMhUDP0hKMvMutorPeBZCuUb+78Qz6/NSJMDkm68ZScG9/lIiQ2aLpJJxT7MRrB4CTWWzXcMxgCg4ixtoqLdlvuZDiYqdu0ozbJXrxupCCDJ0ODREjC6klNzSnZMyFVctHMLEg+0mE6LLLSHSgQ8+4P3Bo3HHQr2bgJIwFG4MU3UwApcpISsVvU2pE8mHT0RY0Pn2m/AaKdNCGHV8Q4Ncc4z1sjSrfD5W4rTGkotccAsYA+pHxDRjeNVgpkRCRf785LjYxzcbEJUEErENolnS95CVDEAh3t0R/cYlx3rX5lhqkyEexGbCVUHHs8yBuOYOwUuu9YppbOqRF0kwSQUYt+NPFn5g+iTHBoFdi2z/fr1nVRrFDbi5Ai1f2vi7FY3MmD+8wqVCNltGdUHy+9KI4ck+RkaHZRJw3Y3n3Oike9a2axjJYUVOAKrfk1aElZeTYDyQ1oo9voH2R0XKEmzjcaUEr8EA01Ju/WbCGpnCnW3i5GPBC4QjbmKkIOpoGE2JXsPvBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(186009)(82310400011)(451199024)(1800799009)(46966006)(40470700004)(36840700001)(1076003)(40460700003)(70206006)(6666004)(2616005)(86362001)(70586007)(47076005)(478600001)(7696005)(26005)(36860700001)(426003)(81166007)(356005)(336012)(82740400003)(54906003)(8936002)(2906002)(4326008)(8676002)(6916009)(5660300002)(36756003)(316002)(41300700001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:21:17.4941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dee39e23-6489-4531-0275-08dbb988a73b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8563
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
Cc: stylon.wang@amd.com, Dillon Varone <dillon.varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Need to have a helper function to find the primary dp pipe of the plane
associated with a dpp pipe

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/display/dc/inc/resource.h     |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 436892450936..614a1fb08809 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1805,6 +1805,20 @@ struct pipe_ctx *resource_get_opp_head(const struct pipe_ctx *pipe_ctx)
 	return opp_head;
 }
 
+struct pipe_ctx *resource_get_primary_dpp_pipe(const struct pipe_ctx *dpp_pipe)
+{
+	struct pipe_ctx *pri_dpp_pipe = (struct pipe_ctx *) dpp_pipe;
+
+	ASSERT(resource_is_pipe_type(dpp_pipe, DPP_PIPE));
+	while (pri_dpp_pipe->prev_odm_pipe)
+		pri_dpp_pipe = pri_dpp_pipe->prev_odm_pipe;
+	while (pri_dpp_pipe->top_pipe &&
+			pri_dpp_pipe->top_pipe->plane_state == pri_dpp_pipe->plane_state)
+		pri_dpp_pipe = pri_dpp_pipe->top_pipe;
+	return pri_dpp_pipe;
+}
+
+
 int resource_get_mpc_slice_index(const struct pipe_ctx *pipe_ctx)
 {
 	struct pipe_ctx *split_pipe = pipe_ctx->top_pipe;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 6777b07d0727..170d6ab81aef 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -409,6 +409,12 @@ struct pipe_ctx *resource_get_otg_master(const struct pipe_ctx *pipe_ctx);
  */
 struct pipe_ctx *resource_get_opp_head(const struct pipe_ctx *pipe_ctx);
 
+/*
+ * Get the DPP pipe allocated for MPC slice 0 and ODM slice 0 of the plane
+ * associated with dpp_pipe.
+ */
+struct pipe_ctx *resource_get_primary_dpp_pipe(const struct pipe_ctx *dpp_pipe);
+
 /*
  * Get the MPC slice index counting from 0 from left most slice
  * For example, if a DPP pipe is used as a secondary pipe in MPCC combine, MPC
-- 
2.37.3

