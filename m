Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A8DC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 05:51:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62D7510ED64;
	Mon,  7 Mar 2022 05:51:49 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2040.outbound.protection.outlook.com [40.107.96.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0802610ED6E
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 05:51:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTurdH9tzffdj9AVHUiooeG0B/vgOUqXc/4OjWhjHrRPrwF3VIp/lxmtM5CYoTyb9jq3MIMIZQ4dktmYUbXACKxltjwD9YfkMOvRC0xZC0YvVsd5ShexwtXg8D6DsgEVS5OfyzYlHxn+J8aYjra422N2D+ZbrDqocSb3kMJc4mGVU/7o0/kQQDjLAxD3dE9zdjpD9lXAFqSyNlOLKGkjHmxP+jWMtnk+odjFEtGZ/kc8I7UgEMHPkrCZJ4vKv8eISgkiO8+5Atkwu9KUE98NposamlI4bABgs8pB8LZGcUyESMM9VguLuWszsyBbOAP0g1MOUtYKIbdeEe6x0Ccc7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXlYwsylj92luSywMP7cxPRmJaY4xCsYC3GPuKGJIIc=;
 b=YbgL+BnJS2XLanKYH4QeEa1NigK6Qq4jUfNbgoDwEDHOz1m9BVcx6eItmmpUDekcK3uM2agRg/DQi4/t49QOazHkzJUBvoROOpC3Sard3Wdgqg9xpsyp3IlAwkobE4TYL2hw9hhTK2CKuydi6I6ipuAaL3dQs/4lzcmOlV4bi3ibk4woNfbm+tmJA5L8Vta12shWLjl0C7cEtJnrPpG+uhweWDkeafFzIIbsT35CshzqHe2A3/0tiZB93R9WSQzfdUL/1w77zGaJCEaD5bPzHUxI5jpiZz2hP2ICjrksDbxprhonxuluGdQpUo6sNnrYY2j/42LjbkjfRuGt/DxuNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXlYwsylj92luSywMP7cxPRmJaY4xCsYC3GPuKGJIIc=;
 b=iSWF80rckFoFrWRUAapi66lbrCSfJW31uJUfZZTnE2FTa858aKBYeJwfrO4iR6/36YzgFzid7uvjJKU2yw+nhW68a0RrzcBloMxXaXUzyyXi4vYLWtMpMKEh1tqfIFQ49LjGLMB4oudPluL/GV1EuRFa1VoY+8+u2/H4udm2kFU=
Received: from DM6PR02CA0093.namprd02.prod.outlook.com (2603:10b6:5:1f4::34)
 by MN2PR12MB3839.namprd12.prod.outlook.com (2603:10b6:208:168::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 05:51:44 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::b6) by DM6PR02CA0093.outlook.office365.com
 (2603:10b6:5:1f4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 05:51:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 05:51:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 23:51:43 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 23:51:42 -0600
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sun, 6 Mar 2022 23:51:39 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/21] drm/amd/display: Fix double free during GPU reset on DC
 streams
Date: Tue, 8 Mar 2022 05:09:40 +0800
Message-ID: <20220307210942.444808-18-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307210942.444808-4-HaoPing.Liu@amd.com>
References: <20220307210942.444808-4-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 946a2ebb-8cd0-41c4-28ab-08d9fffe8f49
X-MS-TrafficTypeDiagnostic: MN2PR12MB3839:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB38390CAFB624ABBC229678CCF5089@MN2PR12MB3839.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ohYLNLmSmoGFJy/ZG+0bAxB4mqpyStIdHdgyJJkVhI2xZXX3lBjmoF7Gn56Snz54hVU1YrJBrfwj2rpPAFS301cGyABc4eTnr1jrjDLt4uNMQE6QtNGWPtgswnZT0PDDO/Zd4yKWLD9kmb7Msi/RFIKRMXe38At1eIkFstnG944E899fj+UMFHkmKWRujvGVJnky5LTh6cpbmOO3jvnLiIUkpnjCLwzDtmyzHqVUJ2EN0N7TpC3o6IcF2xanfoz3hTGHpblVDB4P4ULdCzTRuHqAdiNUIDYp2BZ1UaNO0Vl2qrX3UBLy8WEDoRy45NDgUggKqctUyckae5t9CYQJLcJtBsNIvdlDMSp0jC8KIfDl0aaGNvYp3AVgnVNMF0OxAKouEoVvgvBx7N1FiOsOr8uKFRQCGrc8mxtWXRi2zQhA9nKuaV05BZlCLN+TRCHqorX/GTVoahIgfMvdIXWQC3qPGcAtHI/EpEW431eIMTlF8/wTlpSJfkDPqQhbYhsj3TpQzx5ufnS2B2pvIdkQZ2eaRrlq1qiIQTLyte5c9KfLK0vT989q+eaPgJ9I2U7LofCG2mvbEdXe8q+poCgeE87uI0nnHT0FobKTunbgqVIEr0vCCwtyXCfExlYccs8967LAQUmqmtpBoi6gBBJi9lTz4z8djOZ4Uyxv8RZzXI+XRWO45Yb0riMX+rYIUiyrXEsbwNhVn0DoH4ByejMkaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(82310400004)(81166007)(7696005)(36860700001)(86362001)(2906002)(356005)(316002)(47076005)(70206006)(70586007)(508600001)(8676002)(6666004)(4326008)(336012)(26005)(8936002)(426003)(5660300002)(186003)(83380400001)(36756003)(40460700003)(54906003)(1076003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 05:51:43.9410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 946a2ebb-8cd0-41c4-28ab-08d9fffe8f49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3839
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jimmy Kizito <Jimmy.Kizito@amd.com>,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The issue only occurs during the GPU reset code path.

We first backup the current state prior to commiting 0 streams
internally from DM to DC. This state backup contains valid link
encoder assignments.

DC will clear the link encoder assignments as part of current state
(but not the backup, since it was a copied before the commit) and
free the extra stream reference it held.

DC requires that the link encoder assignments remain cleared/invalid
prior to commiting. Since the backup still has valid assignments we
call the interface post reset to clear them. This routine also
releases the extra reference that the link encoder interface held -
resulting in a double free (and eventually a NULL pointer dereference).

[How]
We'll have to do a full DC commit anyway after GPU reset because
the stream count previously went to 0.

We don't need to retain the assignment that we had backed up, so
just copy off of the now clean current state assignment after the
reset has occcurred with the new link_enc_cfg_copy() interface.

Fixes: 6d63fcc2a334 ("drm/amd/display: Reset link encoder assignments for GPU reset")

Reviewed-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c     | 9 ++++++---
 drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c | 7 +++++++
 drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h     | 5 +++++
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fa22f8720a54..8e4310a89bd0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2633,10 +2633,13 @@ static int dm_resume(void *handle)
 		 * before the 0 streams commit.
 		 *
 		 * DC expects that link encoder assignments are *not* valid
-		 * when committing a state, so as a workaround it needs to be
-		 * cleared here.
+		 * when committing a state, so as a workaround we can copy
+		 * off of the current state.
+		 *
+		 * We lose the previous assignments, but we had already
+		 * commit 0 streams anyway.
 		 */
-		link_enc_cfg_init(dm->dc, dc_state);
+		link_enc_cfg_copy(adev->dm.dc->current_state, dc_state);
 
 		if (dc_enable_dmub_notifications(adev->dm.dc))
 			amdgpu_dm_outbox_init(adev);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index 047c626a4a34..42da7f430113 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -272,6 +272,13 @@ void link_enc_cfg_init(
 	state->res_ctx.link_enc_cfg_ctx.mode = LINK_ENC_CFG_STEADY;
 }
 
+void link_enc_cfg_copy(const struct dc_state *src_ctx, struct dc_state *dst_ctx)
+{
+	memcpy(&dst_ctx->res_ctx.link_enc_cfg_ctx,
+	       &src_ctx->res_ctx.link_enc_cfg_ctx,
+	       sizeof(dst_ctx->res_ctx.link_enc_cfg_ctx));
+}
+
 void link_enc_cfg_link_encs_assign(
 		struct dc *dc,
 		struct dc_state *state,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h b/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
index c2f08514a1d9..c6f6baa6e677 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
@@ -39,6 +39,11 @@ void link_enc_cfg_init(
 		const struct dc *dc,
 		struct dc_state *state);
 
+/*
+ * Copies a link encoder assignment from another state.
+ */
+void link_enc_cfg_copy(const struct dc_state *src_ctx, struct dc_state *dst_ctx);
+
 /*
  * Algorithm for assigning available DIG link encoders to streams.
  *
-- 
2.25.1

