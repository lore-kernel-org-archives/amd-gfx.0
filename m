Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE61CE79A8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 03:22:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B273810E437;
	Wed, 20 Sep 2023 03:22:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D447110E437
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 03:22:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0yi5rYaTHN3Cx7xC8AUxR1fLhY6voUovQzcYyrjNuXs7y4JW9YVnunHNMmbyVMUgCZpEF0NdUxr2kGCPb1/j9ukdmkM325q9jSicWvQYyoIZkyMylxwMFodVcFWvgbmRebIh5pQndUg0UonzvELaAYtAYix3t91IdBEmX6BHClKZEU8AJRtR16ec1cN17Lctvx5nAWw3XNApld3Kh613fvoEnaQY+GR85LC7Eqln6hR7S3YaD/mser4Y6FSjCW2XwYm63kEB2Z2HYEGGZxsteSOBARDhz1b+2/A2ttharbKr/mEpHR1dNr72L7tK0ZcDN9lvmDgopoCLAH3idNARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H97DACu5/wzdFoRwH1H/VWypMLFPGw4+c69Lq3/lPPk=;
 b=OMI0YjcaK3NGaVhOgYT33ctWAfyFvOcAB/hnHZ0tBU0iUDpdYgWQ0UsSqYBS2EWlICREEgKY6ngYTn3DMppvMx1MgoB2+SfpPKJPRY0qMY9DBfiuVIvv4oB5/YX5LLf28xg6bh3MYJJnIUVy73jv/2ZJOBNqSpW6uTjXQgiSfDcAhb8Nv9DodMmH6BClnjI9+3IO5XwKl7mn7kRKKtWKBxVv5OcfsPSrz1ILh+MstI8HgvxttN95A7EWZRpZ72naEhi4s7SdY9+NU+yc1VZ09rIaXDfOtU+TqU1RZKCq5JX5vi264s1wbFNYVjycCQ+Uq9GvbuHlnhduIWX77su4vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H97DACu5/wzdFoRwH1H/VWypMLFPGw4+c69Lq3/lPPk=;
 b=q4GAhXBZgvVMefQkxOZvogyYoCkjOXvbiDGRKJ/zmA/kB8eUEHEh9D6gi+b2AtmMeKTzfm3hhy63s3V/EgtjfvOOQRHHdUU/AnC9Izm2xkB66D+AHtIu3PpUCutP9PwQk0zpEgIf7ckGpJCXtuZ4/lMHMpzxw2pVuoluvBDBKCg=
Received: from MW3PR06CA0027.namprd06.prod.outlook.com (2603:10b6:303:2a::32)
 by BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Wed, 20 Sep
 2023 03:22:14 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:2a:cafe::6b) by MW3PR06CA0027.outlook.office365.com
 (2603:10b6:303:2a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Wed, 20 Sep 2023 03:22:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.0 via Frontend Transport; Wed, 20 Sep 2023 03:22:13 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:22:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 20:21:44 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 19 Sep 2023 22:21:39 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/19] drm/amd/display: fix incorrect odm change detection
 logic
Date: Wed, 20 Sep 2023 11:16:23 +0800
Message-ID: <20230920031624.3129206-19-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230920031624.3129206-1-Wayne.Lin@amd.com>
References: <20230920031624.3129206-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|BL0PR12MB4849:EE_
X-MS-Office365-Filtering-Correlation-Id: d117d34d-fd8c-45db-5cdd-08dbb988c8f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LILNFwvwkcYEh5FAeh0D9XPi+QIVxIS34s+3RP10MftodhuE7+hwz7MKqGQXym1la7yp7mT2f2VyRkagGniMtysPjbhKdFEf9qVSAi9SWfEoQeZ9P1M6zVMxwLEtU2hGsZ/yyn8W6V1iaIb54EsFxMhG/GJr5zi/nC70eigg3r03woMaQiShtH0+gX369Mejz9Np+9DUnGJMSE1Bv8qD6JC/sJ1zli8cztHRZg9pRsxLuLr19sFf6AkgTvGPDo/fWCEZxnemXPyOd99o5rjkQYg+ZhkLFhN0XF+jR2DKTS0mpXd2Cmc3vlC/6hmjYWXmK1awvzltr6LNOISWWkZ3am5Xko9IN3c5V2S6RSgAc6vJnk01EosraaDNdrgssoHPBcBOmu8H3JLdD7UNIsKQzeDPnHiTpNzr7ACfEXyOu2LGaAqHmTng6MdVf4eZEsGdPMw0kDkgYMiPg9ZBEg87zUSMHAt6o4ioz8Az8IqP3ln1ewaND5Ynb/e4UFcfYE9BEGRq4IbeYFf69LGKzIDyhr6jaK2sPN6T5rAmqv38yECvOMxk1jopfH03oUP0/RqRNluYSjU6UJ0ApyykWlwr72+Ukcs10+k/0FxKLa+fHIMrlZRKdZSLGis/Q/HqNy64ncTE3Cys+3fNuzxIParPVi4cpIu+IIGfanL30RCzqHTL14maNDWVUJ7glTcnhH9/lOZn2vZv6FmVvKUJh7xkAZN9C5+ErquF2GqrNAlJz9JmgBp39XUbl8jAuLsArLHBD1vqjC4cNfpsWBJ4tmjMVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199024)(1800799009)(186009)(82310400011)(36840700001)(46966006)(40470700004)(7696005)(6666004)(82740400003)(36756003)(40460700003)(40480700001)(86362001)(356005)(81166007)(36860700001)(26005)(426003)(2616005)(336012)(4326008)(47076005)(478600001)(2906002)(8676002)(1076003)(6916009)(8936002)(5660300002)(316002)(41300700001)(54906003)(70206006)(70586007)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:22:13.9577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d117d34d-fd8c-45db-5cdd-08dbb988c8f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4849
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
The current ODM change detection only compares first two ODM slices.
If there are 4 ODM slices and the change is within the last two slices, the
logic fails to detect ODM change and cause us to skip ODM programming
unexpectedly.

[how]
Add a is ODM topology changed resource interface to check any ODM
topology changes with a more generic method.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 23 +++++++++++++++++++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  8 ++-----
 drivers/gpu/drm/amd/display/dc/inc/resource.h | 10 ++++++++
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 614a1fb08809..e9837c0ce7f6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1925,6 +1925,29 @@ bool resource_is_pipe_topology_changed(const struct dc_state *state_a,
 	return false;
 }
 
+bool resource_is_odm_topology_changed(const struct pipe_ctx *otg_master_a,
+		const struct pipe_ctx *otg_master_b)
+{
+	const struct pipe_ctx *opp_head_a = otg_master_a;
+	const struct pipe_ctx *opp_head_b = otg_master_b;
+
+	if (!resource_is_pipe_type(otg_master_a, OTG_MASTER) ||
+			!resource_is_pipe_type(otg_master_b, OTG_MASTER))
+		return true;
+
+	while (opp_head_a && opp_head_b) {
+		if (opp_head_a->stream_res.opp != opp_head_b->stream_res.opp)
+			return true;
+		if ((opp_head_a->next_odm_pipe && !opp_head_b->next_odm_pipe) ||
+				(!opp_head_a->next_odm_pipe && opp_head_b->next_odm_pipe))
+			return true;
+		opp_head_a = opp_head_a->next_odm_pipe;
+		opp_head_b = opp_head_b->next_odm_pipe;
+	}
+
+	return false;
+}
+
 /*
  * Sample log:
  *    pipe topology update
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index f2b20319f0bb..5738a5f00b56 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1430,13 +1430,9 @@ static void dcn20_detect_pipe_changes(struct pipe_ctx *old_pipe, struct pipe_ctx
 	}
 
 	/* Detect top pipe only changes */
-	if (!new_pipe->top_pipe && !new_pipe->prev_odm_pipe) {
+	if (resource_is_pipe_type(new_pipe, OTG_MASTER)) {
 		/* Detect odm changes */
-		if ((old_pipe->next_odm_pipe && new_pipe->next_odm_pipe
-			&& old_pipe->next_odm_pipe->pipe_idx != new_pipe->next_odm_pipe->pipe_idx)
-				|| (!old_pipe->next_odm_pipe && new_pipe->next_odm_pipe)
-				|| (old_pipe->next_odm_pipe && !new_pipe->next_odm_pipe)
-				|| old_pipe->stream_res.opp != new_pipe->stream_res.opp)
+		if (resource_is_odm_topology_changed(new_pipe, old_pipe))
 			new_pipe->update_flags.bits.odm = 1;
 
 		/* Detect global sync changes */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 170d6ab81aef..00230a7fbe25 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -447,6 +447,16 @@ int resource_get_odm_slice_index(const struct pipe_ctx *opp_head);
 bool resource_is_pipe_topology_changed(const struct dc_state *state_a,
 		const struct dc_state *state_b);
 
+/*
+ * determine if the two OTG master pipes have the same ODM topology
+ * return
+ * false - if pipes passed in are not OTG masters or ODM topology is
+ * changed.
+ * true - otherwise
+ */
+bool resource_is_odm_topology_changed(const struct pipe_ctx *otg_master_a,
+		const struct pipe_ctx *otg_master_b);
+
 /* log the pipe topology update in state */
 void resource_log_pipe_topology_update(struct dc *dc, struct dc_state *state);
 
-- 
2.37.3

