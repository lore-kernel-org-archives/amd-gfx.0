Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A74C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2385F10E4F0;
	Thu, 20 Oct 2022 15:51:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23FD410E4F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:48:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vnw6o/FFHnzkMCKJR41Nnj3LuKEmpwjpTs0Hy3cx5geBVYhmKhBa3G0O1jOUqLrfzI9mSfdHEGhF56MODmpF8xp30SjXqqFbo350TVMBQ8qMfJJuEPQ3lZbFQ7KMxbIlDjmSowuVDVTochOehBHZMcbRrLpIsAhIC5YJlQDSo/Kqq7aX7B5MNuRL6SuxDiaV2wjwYVMe/XyigkIul0Aija+sSQbd9nlBLq8zSDmr0V/cQJ4/WwY8TGilPVgCi/v5+tRsXsK6bu3soxgH/kO6U/70lvyeqWIYNi3mI7FTVYb9unVayEkNsTzBMW4GQEpxew1bAF9e0J9w2l6dUzQ+LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=so1Br3AfiuXe9ew99DGQELGrFfW/5bE+kpqPZB96OIo=;
 b=S0gFPBIkN64qjUk44LkVhT48Psd4S+nc0sF6DdFcLicfV+9Pt4EKd1gdWWwVlBytMJvs8IlImbKYUj3tOiDUUjWVMgQIAizPZsF0BOF8m2JcZIgW0IZjbGai01q1FJF6BWU1rSCgg/Wln2wOjAnjIpjinp0lFDfd86uzpnQI6nSu0rO2grheQPC3Nn1tkLZrHRaZT1Le+YIskcP77+Wv6qCLZ/6ulliW84JWuMdykj7I3JPKN19Wo1spRMDMHuBIaRK/rVx1gv24P66MYzEhTo60XB5DMP/qLVKigwJo9B7oIpYwtD4/0FkCC3oazJ87kOw4bT4A/JSsKF7+DrBAZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=so1Br3AfiuXe9ew99DGQELGrFfW/5bE+kpqPZB96OIo=;
 b=mnbKD7noqaLT3Ug9fwRiDz+fm+xkQ94wqptR7cqcetUzVEBHGOUqeXm6RIiHCmqTUIt09/FR27kYnmjz5jRRdgww4x+RHXUm5Dne92suhMe1iOdbvVwArjINncW8MW3mKaf5ndGWp/Cntp944fT3EUDYOKGByGp/ZR2vBfZIx5E=
Received: from DS7PR05CA0046.namprd05.prod.outlook.com (2603:10b6:8:2f::14) by
 CY5PR12MB6297.namprd12.prod.outlook.com (2603:10b6:930:22::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.30; Thu, 20 Oct 2022 15:48:20 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::ac) by DS7PR05CA0046.outlook.office365.com
 (2603:10b6:8:2f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.17 via Frontend
 Transport; Thu, 20 Oct 2022 15:48:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:48:20 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:48:17 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 31/33] drm/amd/display: Add kernel doc to some of the dc fields
Date: Thu, 20 Oct 2022 11:47:00 -0400
Message-ID: <20221020154702.503934-32-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT005:EE_|CY5PR12MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: ce4d7cf1-4872-4a2d-dc09-08dab2b28396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZA2UAyfvJT7PQ4vY19ZWeiahOQdw8f5ZE3qA6rDlbvxPJbukMWkGy4tRaH7K3lp28Zg5DOoemLfXYyrFB6T2p6Kf7DHa8yy354JrCBB46EFX1EcCoFPF2bWTAo+Ggoiw/3E3nuTPQkUdEWljAtOlqd8vhS9hN70u/gfp9Cxm/fCyVzeZydSTTjfAUkBPo9K07rU9mO11e5iox1ipfCvbxv04PaTIh0t1PgKAhMiRdBkNICpkh41wEVbo2OUInmY+YmE236CyjRz21f66pK5QVUq9lrXm2yDGCmdNwf32AP2pVuHmkTkZLxrTwxDtxW86ntMlgd3JPVPYq1/X0jFQ1vFK+fx5H/9HFANUXAeLbH2R4gbKtOLyirHx+Po+dQ/jjpMFadx87jdQXVKNO5Hwp9y+LgaSISXxmqloMyvLaA3wB6HGa2M9EkhSF7CJV7JiXmI0DU36WHYnmIcFlUjZtQUX8Zt70KYfZk6kqSWPSWRhuOCO6J4j6aRJ5BUNL1oux9niFP+YVLmVG97MgngAtk9ZwXtgfMbT7IDTrpCLkJbobA/0gOxF/0v1s6Ra4d3GpsrJN5eqXnTiikzcDlo9ae4o2pYWfRWcjyFPe9ZwQgPT+m1SdLTCDCNYe7A3pec3JbGMmT4izIpHqMpN1I3qYGMlIMkz9YBwgScaoblyxvAEyCJ6RQOyKrvVsVnD3QaKyk81AkcfMSaZNNaceKXmYa8OYbdXdVrLeix0tAMtzXmnBTgRCKQ/nZ/xfjNtP2n/f22JoLPcFXeEElCgnymccZSPRqsoa1loMuJvj8m6rRVUJ5wCKG+oXe4qVwG9PqVJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(47076005)(7696005)(83380400001)(82310400005)(6666004)(336012)(478600001)(1076003)(2616005)(16526019)(6916009)(86362001)(70586007)(426003)(36756003)(26005)(186003)(54906003)(356005)(40480700001)(40460700003)(316002)(81166007)(8676002)(36860700001)(70206006)(2906002)(41300700001)(82740400003)(8936002)(5660300002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:48:20.7190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4d7cf1-4872-4a2d-dc09-08dab2b28396
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6297
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add kernel-doc to some important elements from DC struct that might help
to understand DC sequence.

Reviewed-by: Aurabindo Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  5 ++-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  8 ++++
 .../gpu/drm/amd/display/dc/inc/core_types.h   | 38 ++++++++++++++-----
 3 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index d99f1c4b9584..7caf3139fabc 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2562,9 +2562,12 @@ enum dc_status resource_map_pool_resources(
 
 /**
  * dc_resource_state_copy_construct_current() - Creates a new dc_state from existing state
- * Is a shallow copy.  Increments refcounts on existing streams and planes.
+ *
  * @dc: copy out of dc->current_state
  * @dst_ctx: copy into this
+ *
+ * This function makes a shallow copy of the current DC state and increments
+ * refcounts on existing streams and planes.
  */
 void dc_resource_state_copy_construct_current(
 		const struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 17f080f8af6c..edb4532eaa39 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -166,6 +166,14 @@ struct dc_link {
 	enum dc_irq_source irq_source_hpd_rx;/* aka DP Short Pulse  */
 	bool is_hpd_filter_disabled;
 	bool dp_ss_off;
+
+	/**
+	 * @link_state_valid:
+	 *
+	 * If there is no link and local sink, this variable should be set to
+	 * false. Otherwise, it should be set to true; usually, the function
+	 * core_link_enable_stream sets this field to true.
+	 */
 	bool link_state_valid;
 	bool aux_access_disabled;
 	bool sync_lt_in_progress;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 295845d49cb9..fe34cfde22a6 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -514,29 +514,47 @@ struct bw_context {
 	union bw_output bw;
 	struct display_mode_lib dml;
 };
+
 /**
- * struct dc_state - The full description of a state requested by a user
- *
- * @streams: Stream properties
- * @stream_status: The planes on a given stream
- * @res_ctx: Persistent state of resources
- * @bw_ctx: The output from bandwidth and watermark calculations and the DML
- * @pp_display_cfg: PowerPlay clocks and settings
- * @dcn_bw_vars: non-stack memory to support bandwidth calculations
- *
+ * struct dc_state - The full description of a state requested by users
  */
 struct dc_state {
+	/**
+	 * @streams: Stream state properties
+	 */
 	struct dc_stream_state *streams[MAX_PIPES];
+
+	/**
+	 * @stream_status: Planes status on a given stream
+	 */
 	struct dc_stream_status stream_status[MAX_PIPES];
+
+	/**
+	 * @stream_count: Total of streams in use
+	 */
 	uint8_t stream_count;
 	uint8_t stream_mask;
 
+	/**
+	 * @res_ctx: Persistent state of resources
+	 */
 	struct resource_context res_ctx;
 
+	/**
+	 * @bw_ctx: The output from bandwidth and watermark calculations and the DML
+	 */
 	struct bw_context bw_ctx;
 
-	/* Note: these are big structures, do *not* put on stack! */
+	/**
+	 * @pp_display_cfg: PowerPlay clocks and settings
+	 * Note: this is a big struct, do *not* put on stack!
+	 */
 	struct dm_pp_display_configuration pp_display_cfg;
+
+	/**
+	 * @dcn_bw_vars: non-stack memory to support bandwidth calculations
+	 * Note: this is a big struct, do *not* put on stack!
+	 */
 	struct dcn_bw_internal_vars dcn_bw_vars;
 
 	struct clk_mgr *clk_mgr;
-- 
2.35.1

