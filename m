Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E71EC433E2
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 253EC20801
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2nkNxPvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253EC20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 899AD6E480;
	Mon,  8 Jun 2020 04:59:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AF166E48B
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 04:59:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1YRTgAF5A81sGbhvSZdYkCwQESWhpci2HB27DmeIpFyszdSm28qzMTdUMQcD1Q4Q8pN3zXymulxMq00ywKJddJvUtgiPXVHKhhpiQQKWjAWOcbo87uaYqtC0LHIWebrU2wWYrI90MLo+OglOiUnn9b1LF4pGfLaGQpv/uOnqgRwhDeizaY+6J4tL+G1EgF3bq/VPswYXm5j+fpJFXzSZaX592VtTyvFm5MlCWMs+pnEA6GBsIioWBd1wqV4N+tbJpUy3ntZ/cZ8iVDRyA+G/y3xR+oOdfC5QKTz2jKTEOGmLQzTUUOGHV0T1LGR+rcUXRK9szVS4apd4fb6ZfDntA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jh/IlvPVif6gt9Iw2gw82rfixjAq4f2SQmx9Nht0zEU=;
 b=evNe/hpcOQd0K9p6yd8snS5iGFMjyJUaVmdFuO07pfVpT8UP/G6M9qtYZ+Ut1YZuLOlC+lOziIyUclx8xB73N1Q1vCfK+uy5d/Ev/shTYxg4xF/QF5NoJYeWBAck/FXuwWiFjbM8Q8KPZqztzk+yLnhcAc6NxzgaGt4FWADg1CvVAsMoWBemCVSPqJipZuyPj0N55TDIaKpHVcrTcP5/pL8GKvUGf8o5qMEy2wq7Z4SjPLEcmrsY2GOtAF/RJoYHJXpzdrsFnrTABoAQXOFhWTfhsVFGrR3yohtZsLm4jiVpj6gQYxT67OCebJGHcKMrFzru/wY9qNdZc2ol/qOE+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jh/IlvPVif6gt9Iw2gw82rfixjAq4f2SQmx9Nht0zEU=;
 b=2nkNxPvIfdg2il7KmqVytyb2ejkTHp7g0rRQIpKUAPgrORbkL40syxvGGwiKgVwMtWqENMqeBsAfUBvNk//KEQ1hjlGB/gSyT3GvskwerEBscXOtZjgSC6xnTzING98VXCX/pEZPG1lzQohj2jiRmwnSRr6WNGRCivJBEs6MLVg=
Received: from CO1PR15CA0103.namprd15.prod.outlook.com (2603:10b6:101:21::23)
 by MW2PR12MB2508.namprd12.prod.outlook.com (2603:10b6:907:9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 04:59:42 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::e8) by CO1PR15CA0103.outlook.office365.com
 (2603:10b6:101:21::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Mon, 8 Jun 2020 04:59:41 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 04:59:41 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:39 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 7 Jun 2020 23:59:39 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/28] drm/amd/display: Add helper to convert DC status
Date: Mon, 8 Jun 2020 00:59:17 -0400
Message-ID: <20200608045926.17197-20-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608045926.17197-1-qingqing.zhuo@amd.com>
References: <20200608045926.17197-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966005)(70586007)(82310400002)(1076003)(70206006)(426003)(36756003)(83380400001)(8676002)(336012)(26005)(47076004)(316002)(6916009)(81166007)(2906002)(356005)(5660300002)(54906003)(82740400003)(8936002)(478600001)(186003)(4326008)(86362001)(6666004)(2616005)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cf83812-4063-4d13-f6b8-08d80b68c128
X-MS-TrafficTypeDiagnostic: MW2PR12MB2508:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2508CE78F04EF727D0ECCA98FB850@MW2PR12MB2508.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rihyHnx56hAnXhAHFkx4gOhA7nWuwlpKNxUkaxZG41cLxaimXr6haC34QsqQzf04KUL7DYGkFsuxVoeWV2RdGo1efBqDpIbLmSvvLI86Ig3t0kLkC1kNcJoLlb3L2KIyV7n19zNTH852ATcUBY/cdyUFetMqNuPY9xVFmkXR8SqAVs8pqdVuWqmeLjgllqjKQDkyi34H941OsVL4A+DKsEezv1ewIknS/V6VQYmaAV3EHpzzyLNngvt+UD3ZeYP+AFP3bvJal7TMXOMe+HBTO3nMSFEwPd3zuDXEl2meculbuZuDulcV0/wdnECv5rLukdRihsxy4mIrCF+MIATG65/Q5dqMojAMgMpvH/5A9AL6zL+ZFP574mHFYlzxVzaSYJg5zc/gcLtgWG4CT6VhIw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 04:59:41.6537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf83812-4063-4d13-f6b8-08d80b68c128
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2508
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com,
 Harry.Wentland@amd.com, Aurabindo.Pillai@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

During the debugging process related to a hot-plug
problem with 4k display, we realized that we had
some issues related to the global state validation.
This problem was not explicitly highlighted in the
dmesg log, for this reason, this commit adds a function
that converts `enum dc_status` to a human-readable
string and appends the proper warning message in case
of failure.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 ++--
 .../gpu/drm/amd/display/dc/core/dc_debug.c    | 59 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/inc/core_status.h  |  2 +
 3 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f348693217d8..9ab0d8521576 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5152,11 +5152,12 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		dc_result = dc_validate_stream(adev->dm.dc, stream);
 
 		if (dc_result != DC_OK) {
-			DRM_DEBUG_KMS("Mode %dx%d (clk %d) failed DC validation with error %d\n",
+			DRM_DEBUG_KMS("Mode %dx%d (clk %d) failed DC validation with error %d (%s)\n",
 				      drm_mode->hdisplay,
 				      drm_mode->vdisplay,
 				      drm_mode->clock,
-				      dc_result);
+				      dc_result,
+				      dc_status_to_str(dc_result));
 
 			dc_stream_release(stream);
 			stream = NULL;
@@ -8593,7 +8594,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	struct drm_plane_state *old_plane_state, *new_plane_state;
 	enum surface_update_type update_type = UPDATE_TYPE_FAST;
 	enum surface_update_type overall_update_type = UPDATE_TYPE_FAST;
-
+	enum dc_status status;
 	int ret, i;
 
 	/*
@@ -8805,8 +8806,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		ret = drm_dp_mst_atomic_check(state);
 		if (ret)
 			goto fail;
-
-		if (dc_validate_global_state(dc, dm_state->context, false) != DC_OK) {
+		status = dc_validate_global_state(dc, dm_state->context, false);
+		if (status != DC_OK) {
+			DC_LOG_WARNING("DC global validation failure: %s (%d)",
+				       dc_status_to_str(status), status);
 			ret = -EINVAL;
 			goto fail;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
index 502ed3c7959d..87d89449b9af 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
@@ -365,3 +365,62 @@ void context_clock_trace(
 			context->bw_ctx.bw.dcn.clk.socclk_khz);
 #endif
 }
+
+/**
+ * dc_status_to_str - convert dc_status to a human readable string
+ * @status: dc_status to be converted
+ *
+ * Return:
+ * A string describing the DC status.
+ */
+char *dc_status_to_str(enum dc_status status)
+{
+	switch (status) {
+	case DC_OK:
+		return "DC OK";
+	case DC_NO_CONTROLLER_RESOURCE:
+		return "No controller resource";
+	case DC_NO_STREAM_ENC_RESOURCE:
+		return "No stream encoder";
+	case DC_NO_CLOCK_SOURCE_RESOURCE:
+		return "No clock source";
+	case DC_FAIL_CONTROLLER_VALIDATE:
+		return "Controller validation failure";
+	case DC_FAIL_ENC_VALIDATE:
+		return "Encoder validation failure";
+	case DC_FAIL_ATTACH_SURFACES:
+		return "Surfaces attachment failure";
+	case DC_FAIL_DETACH_SURFACES:
+		return "Surfaces detachment failure";
+	case DC_FAIL_SURFACE_VALIDATE:
+		return "Surface validation failure";
+	case DC_NO_DP_LINK_BANDWIDTH:
+		return "No DP link bandwidth";
+	case DC_EXCEED_DONGLE_CAP:
+		return "Exceed dongle capability";
+	case DC_SURFACE_PIXEL_FORMAT_UNSUPPORTED:
+		return "Unsupported pixel format";
+	case DC_FAIL_BANDWIDTH_VALIDATE:
+		return "Bandwidth validation failure (BW and Watermark)";
+	case DC_FAIL_SCALING:
+		return "Scaling failure";
+	case DC_FAIL_DP_LINK_TRAINING:
+		return "DP link training failure";
+	case DC_FAIL_DSC_VALIDATE:
+		return "DSC validation failure";
+	case DC_NO_DSC_RESOURCE:
+		return "No DSC resource";
+	case DC_FAIL_UNSUPPORTED_1:
+		return "Unsupported";
+	case DC_FAIL_CLK_EXCEED_MAX:
+		return "Clk exceed max failure";
+	case DC_FAIL_CLK_BELOW_MIN:
+		return "Fail clk below minimum";
+	case DC_FAIL_CLK_BELOW_CFG_REQUIRED:
+		return "Fail clk below required CFG (hard_min in PPLIB)";
+	case DC_ERROR_UNEXPECTED:
+		return "Unexpected error";
+	}
+
+	return "Unexpected status error";
+}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_status.h b/drivers/gpu/drm/amd/display/dc/inc/core_status.h
index 4ead89dd7c41..f932801235c6 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_status.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_status.h
@@ -53,4 +53,6 @@ enum dc_status {
 	DC_ERROR_UNEXPECTED = -1
 };
 
+char *dc_status_to_str(enum dc_status status);
+
 #endif /* _CORE_STATUS_H_ */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
