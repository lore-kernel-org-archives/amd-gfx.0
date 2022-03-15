Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFAF2C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 17:09:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A89A10E182;
	Tue, 15 Mar 2022 17:09:31 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37AD610E149
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 17:09:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYKhmt98G7KIp9GnWpJp2dRqWRbCNNGJYcvrcQ4y3A5gTTk4Smh6rsXP7bDVSIqC69eC4dXPRcdnSuTmh4AOpK+DXCx7sexQbaXplHnsbwnmmPysCLpyI9ddFHtwD/6X7z5VCGj79s5svAyEOy/HxXPdYxpB8h/Qww/Te+0vk8OtGttfyYhgMUvE3wx3tqQWdW3Tn4wkB3vrWXPCLx/2kvP0Y6DL8VFRxWL3DC3A+JS//Ggu96C2v4LVKDrJwHOFBIiLVZu3iCyAyRoLL2KnlhQLQH/QNpzajayhVShYjrR+6CQsdq/ixr1gI0drmh8EAETXCt3qJGbNheoadLsarA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VasCNcJOEQLQn9ELZX8/9f1eSOvklNZ9vF6Wz+1ukII=;
 b=W1oxcXaDPo7HX+vwq5MimWeT7PDlpaWc6sA8K+Y82cCkyx5AxCic8mGYSOkavZpvTh+FAPhJM/1J3nzG43RHKvKCBmBuU8VVbZDJmWGDq4vEz4F19Q5QPQZ4eOEHpw7yk/gjgth5TFEo5WRvxuMaUEDZyBVQCJ2Az7+VgG2LatqMHZpV2UpjLUhlJmUBxif3AUG8wJMPfZcka8N8AjhRJE56TecnFrN4jq1zKfS/F5In+VUOLxl6qXYpBJmZmvF0IZoSwQDEvfhc1QY9ZY+wo6yBk5LYGZYLTPlrX2GONsPegJWkN3Bgz/HZOHeULwfG2iB5VFaRXCKI/wHWsC3AdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VasCNcJOEQLQn9ELZX8/9f1eSOvklNZ9vF6Wz+1ukII=;
 b=TvTCPGh+JE9uQe0SMrEgJVWBjC7Vi4ysN9SDEX4fnaoc5dfwHBTutam/p6ZIzrMjQzmg7JtLQUWceu7+VUKt27qMrclEbaVLwxB4KsRLMaDSF+3pNutjwzxWMrw8moR3EcyOajhzWXp5OCmKMVSb+igqzJz/3iyWga5oPOBJoH0=
Received: from BN9PR03CA0396.namprd03.prod.outlook.com (2603:10b6:408:111::11)
 by DM5PR12MB1817.namprd12.prod.outlook.com (2603:10b6:3:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 17:09:27 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::4d) by BN9PR03CA0396.outlook.office365.com
 (2603:10b6:408:111::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.20 via Frontend
 Transport; Tue, 15 Mar 2022 17:09:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Tue, 15 Mar 2022 17:09:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 15 Mar
 2022 12:09:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: make amdgpu_display_framebuffer_init() static
Date: Tue, 15 Mar 2022 13:09:12 -0400
Message-ID: <20220315170914.2804385-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 014ea28c-8fc3-46a2-114b-08da06a68fbb
X-MS-TrafficTypeDiagnostic: DM5PR12MB1817:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB181772F1BD88B09C25D7AAB3F7109@DM5PR12MB1817.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZmnFne4x62GM3+FUOPFeGSbqZ6X5WB4LGuCr28yj6yjs6oNOqIjw2NNoQnlyEGCfjYNvWRq7B8mYW3mxSjIGh0F4ah6HdWxS8Cw8yuks0nrl3xGbbTyp3I9fYEpwvjTL+9Uak5hZ2fh9K80TrrdTmJF2uFsY6G1mn70Md4hsjJEdQBiKl4hCB7pYVWPuQ2Ry00MGK9ztvXdh9Gp5KsA4LNOmEUOIhy7RZWVcEROsgqCtsKFCq75JrgB0K/b3q2RjhlG2vx7MVWOfS5adkh2r0p65nK9KIBPbKEl8vaZ7qe/ROPUQhJmxiS2ioohp7u73wbv0eY73ypSRs7nXwFhFGjMIfZuTZy1Wz4OgF3O8tIMWocQB+SVJocWx8pDmxQ8/zYmtCe0XOyAWdfHlmOSdGBeuoClhfgVwYJLqhf+Wv/DN19a01p2CIemKxqZAWSfiygpjq7W6Fk/vp1BClHLQkg9GxNHS3HdqfTvbc3HLiGPqiLRV1h/QAM2kRDlgk9/n7TOMkSRLX6rVjV4r1SR5EhjT9osi65ACxuPCVuCjM1csuR5eYFXKSaUFduJ3clfW230TVcZrDMCaACqBjN31N2xoQ+OKBxSAek0NBeI4sWj9R6O57r8ojXwlgSZK1gCSNzofgM0mj3H/ezxkz/y6yHf0BuxvKrt8u1ky384WtoZ+FJfZxABjJNkqBFyntlcZNA90o0RvMbPbXznBVDVZ+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(86362001)(70586007)(81166007)(82310400004)(70206006)(4326008)(356005)(8676002)(40460700003)(6916009)(8936002)(316002)(5660300002)(6666004)(7696005)(36860700001)(2616005)(83380400001)(508600001)(36756003)(47076005)(2906002)(426003)(1076003)(16526019)(186003)(336012)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 17:09:27.1460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 014ea28c-8fc3-46a2-114b-08da06a68fbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1817
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's not used outside of amdgpu_display.c.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 13 +++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h    |  4 ----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 70be09dd2a93..cb78ba396672 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -41,6 +41,11 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_vblank.h>
 
+static int amdgpu_display_framebuffer_init(struct drm_device *dev,
+					   struct amdgpu_framebuffer *rfb,
+					   const struct drm_mode_fb_cmd2 *mode_cmd,
+					   struct drm_gem_object *obj);
+
 static void amdgpu_display_flip_callback(struct dma_fence *f,
 					 struct dma_fence_cb *cb)
 {
@@ -1097,10 +1102,10 @@ int amdgpu_display_gem_fb_verify_and_init(
 	return ret;
 }
 
-int amdgpu_display_framebuffer_init(struct drm_device *dev,
-				    struct amdgpu_framebuffer *rfb,
-				    const struct drm_mode_fb_cmd2 *mode_cmd,
-				    struct drm_gem_object *obj)
+static int amdgpu_display_framebuffer_init(struct drm_device *dev,
+					   struct amdgpu_framebuffer *rfb,
+					   const struct drm_mode_fb_cmd2 *mode_cmd,
+					   struct drm_gem_object *obj)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	int ret, i;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index 28848f1348a8..69ce2eeb782e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -600,10 +600,6 @@ int amdgpu_display_gem_fb_verify_and_init(
 	struct drm_device *dev, struct amdgpu_framebuffer *rfb,
 	struct drm_file *file_priv, const struct drm_mode_fb_cmd2 *mode_cmd,
 	struct drm_gem_object *obj);
-int amdgpu_display_framebuffer_init(struct drm_device *dev,
-				    struct amdgpu_framebuffer *rfb,
-				    const struct drm_mode_fb_cmd2 *mode_cmd,
-				    struct drm_gem_object *obj);
 
 int amdgpufb_remove(struct drm_device *dev, struct drm_framebuffer *fb);
 
-- 
2.35.1

