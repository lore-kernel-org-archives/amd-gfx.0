Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F59ACCA47C
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 20:12:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4455112431;
	Fri,  3 Jun 2022 20:12:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D190F11242B
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 20:12:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLfdvzAQXqnCznfJCfYdYKmiVMDTu5Uf2k4QzUASA+uzdYHKvJfS1CQeKmEnE8nItHfNAY71UFH8X3TqhvC9G/HMDgo5T1OHGxa9YQoaY79ZPPwW9bW4pD6s4SFckxrDkqf2Qn+23/p1PCP2oLpxgCrPb0iu+f1/7BFGdkSjvCN9MNEx6/f4q1U2WU2fk8O/TYeBqEYLXSRuKMlJvrqXNb7N1Opmv2JOCWAOZHPjXOOfGpXj5MTTMjRcRAk4NOsghJciGX8PjbgwAJlcfOwSEIbolKfD4XmJuW/gwzP8f4WRVaLAS6xLtrAMN+lEB+jyfFSfBoqw3DW08SQ5fLA+Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPXQ+oQen9sYR5xb7qkTaz/Pco0h9UP7+gXvGqUfMZw=;
 b=lLKgfv2NPbjanwyCQnon8/2uwJCHsaJJagVOPdPC8m65X6DrrO3A3J3/KelHfyUKvOfmnEDiHbn9qSwn+VV8Cq/A28OP32kwg2BKsD/R2uhBrnYEV9s26C8lKSTSba2Ze7HX/G4kDUkDna5j6f/iI1KCVNuLCCuVc4msWtyul/3Ax2H09G0OH9vL3D1febUypHA5obp3fJhC/e8gK0Q3eRsoW+t7KEzjvcObNLlNmzGhU3/IFK2Mk0kaVOI2bPnGG5c/IekaMpWyIpktXdScSOnQA+wTSwVBXqpE0slOkXWPGbgvWi+YjFpTL8dwDgENzzrdXlWT1QrXcaHgPuBqWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPXQ+oQen9sYR5xb7qkTaz/Pco0h9UP7+gXvGqUfMZw=;
 b=XGPIbDaZU3LPSIfsNzmblSdYZM6Wfzt6Gj7VUSjxwdtCeLfUnnroaA9RoD5BU4xB6/4QNfe6t39b/2ptJ6Mimko1ikbLyIVXlklIzf3nkI2V3A0ll9YKNb6CK3kv2vHoZik1aFiLPSFgdsIma1f4oAxFJFISA5IqQhVdK6ZjlTw=
Received: from DM3PR08CA0001.namprd08.prod.outlook.com (2603:10b6:0:52::11) by
 MWHPR12MB1757.namprd12.prod.outlook.com (2603:10b6:300:111::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Fri, 3 Jun 2022 20:12:43 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::bb) by DM3PR08CA0001.outlook.office365.com
 (2603:10b6:0:52::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Fri, 3 Jun 2022 20:12:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 20:12:43 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 15:12:41 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/16] drm/amd/display: Fix dpp dto for disabled pipes
Date: Fri, 3 Jun 2022 16:11:42 -0400
Message-ID: <20220603201147.121817-12-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603201147.121817-1-hamza.mahfooz@amd.com>
References: <20220603201147.121817-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb071e2f-7ced-45c8-b1be-08da459d6af5
X-MS-TrafficTypeDiagnostic: MWHPR12MB1757:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1757326B8EB49769232D2778F4A19@MWHPR12MB1757.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PzNgvVg4bcf2QNpDqFifBb1Tw0wXG5A2Ld9Hj0ihFa9XeXMNotUzXSdhcQnasKCYttbqiJRuc/0kZWwcMtRjRQ3tlQqIQP4Z1p32YZR7zdnfF6NIR9xiB2s0/qMHn4//K8noR1gfzbR939bdcNFumy6PsfnGLPYWaA8eqhF0wGuuuvHwGLBLejQPc/4H5vg5mXuqx6tiZofv3P4Vf7DPOJRNeGtvMr9ouAb/PqZPNTQBVBXKatGrdENY6Qx8VTFyx5z+rBFfhPkB/bESaKBiwh7QL4bsGPsSX/wSImsk3/x+NSitlI95ppy5OG7EkqdVvKG1UGIkvF63GMMmktZlUNsBiw5ZHMLYnjvHb3kz4GNpFi5sVrjfKfspRSDCtGBFaXCtcns+PianrwxZfw/JY1ziPeU4HFhhnANvhfIGKiXBnK0ci4CMgYH/eTUszS0GmKd0NnAHuxw5Zvj6ezBOe/ga+3+0Qfx8So0cHM9EeDD4PnTdumAdzkxro8kvx+Fr/wCy1oB2ZM+228C1i/wZFLlCCMQuSvrbnwS06z2Zfa9wcWtStgg5OF2fRidw/Lnxy2iSe5xP4hlRYpKWfbEzhLX2SraeXLbHF/pT7M8mFRJ2krUufGsvKAhW9e9TpNxM2ilD/lvTqS6mZx4UUzBdqmUx/7gw1lMM9kfniOnQFe/TptTJJiSlEXtDK8fi0jCrqgEqPoCaML+XnbFZVhPKMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8676002)(356005)(44832011)(26005)(47076005)(40460700003)(8936002)(70586007)(36756003)(4326008)(16526019)(2616005)(186003)(36860700001)(316002)(86362001)(82310400005)(1076003)(5660300002)(508600001)(2906002)(81166007)(83380400001)(426003)(54906003)(336012)(6916009)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 20:12:43.1921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb071e2f-7ced-45c8-b1be-08da459d6af5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1757
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Duncan Ma <duncan.ma@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 Hansen Dsouza <Hansen.Dsouza@amd.com>, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Duncan Ma <duncan.ma@amd.com>

[Why]
When switching from 1 pipe to 4to1 mpc combine,
DppDtoClk aren't enabled for the disabled pipes
pior to programming the pipes. Upon optimizing
bandwidth, DppDto are enabled causing intermittent
underflow.

[How]
Update dppclk dto whenever pipe are flagged to
enable.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Reviewed-by: Hansen Dsouza <Hansen.Dsouza@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Duncan Ma <duncan.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index ec6aa8d8b251..8b2c15a3cd92 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1412,11 +1412,15 @@ static void dcn20_update_dchubp_dpp(
 	struct hubp *hubp = pipe_ctx->plane_res.hubp;
 	struct dpp *dpp = pipe_ctx->plane_res.dpp;
 	struct dc_plane_state *plane_state = pipe_ctx->plane_state;
+	struct dccg *dccg = dc->res_pool->dccg;
 	bool viewport_changed = false;
 
 	if (pipe_ctx->update_flags.bits.dppclk)
 		dpp->funcs->dpp_dppclk_control(dpp, false, true);
 
+	if (pipe_ctx->update_flags.bits.enable)
+		dccg->funcs->update_dpp_dto(dccg, dpp->inst, pipe_ctx->plane_res.bw.dppclk_khz);
+
 	/* TODO: Need input parameter to tell current DCHUB pipe tie to which OTG
 	 * VTG is within DCHUBBUB which is commond block share by each pipe HUBP.
 	 * VTG is 1:1 mapping with OTG. Each pipe HUBP will select which VTG
-- 
2.36.1

