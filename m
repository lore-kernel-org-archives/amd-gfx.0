Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A713C35274
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Dec 2023 20:42:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75A6B10E711;
	Thu, 21 Dec 2023 20:42:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0039510E703
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Dec 2023 20:41:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7kzxM/o2tlw9ySI+lTpwwaDawHsqEREl006q4P9of3X3FyT0uXhEE5dabusCNxJKnw3Zl1s5ehLUT9SPIcmYGwPksvfYs8IA40iCXHtUbkliycb1uv+BXI+ZNH4ZLX7DjUHLjHnv/Pls2TcEqN6GgCjisXVWLT8eu1xIzra31v/13eWGxwNE+962LlgIfCcLEOFBIZRfSkyH6GuUWiidJ0b9FZB4Ozf6PDY1U301l9xZEk13Zm+qYcRvMiiALzXc6+Us6Ig7asPtR7AC2Fk9ELsAY04s/TATDWruoI8CVyKwx5/xPJzTqzs23JeWLytRQj666nMMVOgNCzqEuCF5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSLe4/RgXVEc4hbWgtUyQsESzcgwwHec/lE9IaVXN4Q=;
 b=bpzfjmN/1yhgUimjEwA9qL+JeWUT0Aej0BrVyflK8cUeNt0G/u4PCRt9W1oBRU+4b3eoW0XnTbdTiHZn9/ixaOQTgu3BmwPa9uv2SNzIwYzOAJJrtqx/esJiAeg7X8k78UrudciNMPtORom7oRRSh/fF9aD7Z9+utOZUHaizADJUIOV6AthxWT/M7dZWPKK29OFFwlw8hJrRpKQv4KmwCCAjj1uq5/NE4f3TZ/EbMxWtTLIrgrLAcVsB5W6zvxXU5DNc90mswZQjljMupSBnZj5kBrvraWe0uxQe6EkiSp5KhE9Z3EQUGB5AM8gHMuKIO8kZQxpy3iimrEYbTrq2sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSLe4/RgXVEc4hbWgtUyQsESzcgwwHec/lE9IaVXN4Q=;
 b=fGqb/vSOmNVs0VzC9/qbbvXz0ok4hA8TfaVFHVK0JMMzEp38uUT282eU04yZn1Z3zBL8rjcV/V8+37AHrKmbrCWXTS6B1MWIn0gPKW8PfD+iOeeHaOoXUzIiWas1kgbCCougJG5H8MN1bU6m2VzwXqHePZs4aGvkRsbFOx/zGnI=
Received: from PH7PR17CA0030.namprd17.prod.outlook.com (2603:10b6:510:323::25)
 by SN7PR12MB8819.namprd12.prod.outlook.com (2603:10b6:806:32a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 20:41:54 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::8) by PH7PR17CA0030.outlook.office365.com
 (2603:10b6:510:323::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21 via Frontend
 Transport; Thu, 21 Dec 2023 20:41:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 20:41:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 14:41:54 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 14:41:53 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 21 Dec 2023 14:41:53 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/display: Fix recent checkpatch errors in amdgpu_dm
Date: Thu, 21 Dec 2023 15:41:50 -0500
Message-ID: <20231221204151.98967-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|SN7PR12MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: cba38013-e2b6-4217-2744-08dc02654499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k2fQc5E81q2p2K8CKZn+zC2xbdvckNQ56y75jKJBiIb4urebcqDPKS996d8D6/EvB1WYU8wXIXrddvKcaQuBgsfSJ8Qv2hYUDOYu1kNJHENacjFtb2ZosuoOvtB59zClgOIG1J+AixLzt8lxqEnlWTbVS3FYTUpnQuLZsg2XH5AFT6QJz0hu68jArdga5weHP9rR6tOk2L/DuAlTze7LsfQf5H/zbJF+p9Ooo2OI/HgyebCPm4HR4QbY8xw1ZvCWrX/YBUvg3g+kB/cWhsPbnWV4BGYJaX6+rL+J6FzPhY/Veb5VxuZJ9tYV3LeFrysMZf2SQhx1iDp5vWrOlpB223Hhlqu1QkS8RPuOAz8bqD6YjwXwbYseWkbMewHXXAUVWiZ8EZz+zZdAIerB/wXmvqePvrIobBqZuiqWSxOBSKLothMvbmAuxVyvp8rVFfj95jj7NCAYT6nz3wuDqhQz3Pa0e0k6jOkGYtkUmWvRaJPKldUbN6II74FQAv38ZdbStVoBO7PJYlkNJ8aE6PJXwKab5fUQ+sWg3A8yxFrJdTT01iRQGV7Jb+xCRnlARJ3qeBWQK2OkTUp/kFeKz7vVDgp3JnjcohNFhl2gDf8IMPR5sVRGqjb8P7YcmZWJp8o1fTDzvgEjRBL5NkpFDXUx5kToVRvXkKhswoPneqfsNnAiudRczYPlTK9WMBfIUL17RDH64Xp97C+OtGTaeGBz7cGumFE3Mnhd8zj4w7pjCi6oQX4SjRClOF/hB4bSAqjUKpldhirSTZnTB+B8fmULrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799012)(46966006)(40470700004)(36840700001)(2616005)(40460700003)(26005)(336012)(426003)(1076003)(36860700001)(83380400001)(4326008)(47076005)(44832011)(8676002)(8936002)(41300700001)(2906002)(478600001)(316002)(6916009)(5660300002)(70586007)(70206006)(36756003)(82740400003)(86362001)(81166007)(356005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 20:41:54.4983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cba38013-e2b6-4217-2744-08dc02654499
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8819
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
Cc: Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 - Use tabs, not spaces.
 - Brace and parentheses placement

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h       | 4 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 5 ++---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c  | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 2d5af83d40b5..9c1871b866cc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -747,7 +747,7 @@ enum amdgpu_transfer_function {
 	AMDGPU_TRANSFER_FUNCTION_GAMMA22_INV_EOTF,
 	AMDGPU_TRANSFER_FUNCTION_GAMMA24_INV_EOTF,
 	AMDGPU_TRANSFER_FUNCTION_GAMMA26_INV_EOTF,
-        AMDGPU_TRANSFER_FUNCTION_COUNT
+	AMDGPU_TRANSFER_FUNCTION_COUNT
 };
 
 struct dm_plane_state {
@@ -844,7 +844,7 @@ struct dm_crtc_state {
 
 	int abm_level;
 
-        /**
+	/**
 	 * @regamma_tf:
 	 *
 	 * Pre-defined transfer function for converting internal FB -> wire
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index c6ed0d854b01..36bf65a8cd6e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -630,8 +630,7 @@ static int __set_input_tf(struct dc_color_caps *caps, struct dc_transfer_func *f
 static enum dc_transfer_func_predefined
 amdgpu_tf_to_dc_tf(enum amdgpu_transfer_function tf)
 {
-	switch (tf)
-	{
+	switch (tf) {
 	default:
 	case AMDGPU_TRANSFER_FUNCTION_DEFAULT:
 	case AMDGPU_TRANSFER_FUNCTION_IDENTITY:
@@ -1225,7 +1224,7 @@ int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
 	 * plane and CRTC degamma at the same time. Explicitly reject atomic
 	 * updates when userspace sets both plane and CRTC degamma properties.
 	 */
-	if (has_crtc_cm_degamma && ret != -EINVAL){
+	if (has_crtc_cm_degamma && ret != -EINVAL) {
 		drm_dbg_kms(crtc->base.crtc->dev,
 			    "doesn't support plane and CRTC degamma at the same time\n");
 			return -EINVAL;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 4439e5a27362..6e715ef3a556 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -305,7 +305,7 @@ dm_crtc_additional_color_mgmt(struct drm_crtc *crtc)
 {
 	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
 
-	if(adev->dm.dc->caps.color.mpc.ogam_ram)
+	if (adev->dm.dc->caps.color.mpc.ogam_ram)
 		drm_object_attach_property(&crtc->base,
 					   adev->mode_info.regamma_tf_property,
 					   AMDGPU_TRANSFER_FUNCTION_DEFAULT);
-- 
2.43.0

