Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E818CC77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C9B910EDC8;
	Fri, 14 Apr 2023 15:54:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6583810EDD0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnNN9SiKTYJbsclXh5zcD35MYTnmlC5yo1bEIzFV5+/tm39GAYcIQ5HKpQ1B7GPvSFf1nQ/6aQj8OpffDvSaw2BvFcMkKo0NQ3KMlcqrDK54fcqH07F6lmrYztK48DvxbBsk3+e2zWDXx5189wugzQXxNCEQW+gYndFQ5Lyelcu/KOewK+uGU0i9ToJxiGzF3e3ZPAXVZcoJKu4IvGMsWdei9mRAyHXGwEPT82GMhSjsKAOWrNjfSD1gVfTT+d3oEfrykM9CY/RPlMaRvAcbPRiGpzeBKW3jbCND/po2jW92DfBWJxGWgJ2v9a58p/z85xIKArjeTbLEsG8D7tUXHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erQ0N0WotxF0jbMH5xWOCPzz1wIJzD23RuPkBc3axr0=;
 b=BfF0aj8SAPW8whDJiGwrwQZXmS1fVq5eY80CWhbVswuVy6GYFTgkDoinIEGrW29jTjk2CRgLnVVJ0iMGlaAe58AWhdRNz61WqHFeMiLh5HuN0X25NJmwNRxgtiYjJH42PH5vPXzkIeBB/sWA/ErexmpoKrpcR9TNcbtOfSz8+dJUOekBOQKauHCiBJZPUtM3sf9Xwh4anorIzK2DQPRiwdZARhuCsaIUgdOfEnriApLOs0CmsWeM4co53OdXo8c64iyi+vA9awhrqCXFtSnLbqvk7esOXV6Z6ufMQKLbRvnoJRoE+NnQJer8wqV9jQ6TWo1cPu8EgNcZ5krIgdvgCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erQ0N0WotxF0jbMH5xWOCPzz1wIJzD23RuPkBc3axr0=;
 b=ueyX28f8DTNn1AvUUkIKDM+ItL5z7VKgH/11P1xLNBS82JQLmJhTX+MW9TIFWaIaO9YV16ggULBpnFRTAPoW+X7aH27V+OIVzLuN55Wa246QQ28qcEOiRAxkFw+ocDVp8zreMJijBbE9LE4yq3A71eZNh1GfYvT3+NG6SEI4gaI=
Received: from BN9PR03CA0559.namprd03.prod.outlook.com (2603:10b6:408:138::24)
 by BY1PR12MB8446.namprd12.prod.outlook.com (2603:10b6:a03:52d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:54:21 +0000
Received: from BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::77) by BN9PR03CA0559.outlook.office365.com
 (2603:10b6:408:138::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT093.mail.protection.outlook.com (10.13.177.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.33 via Frontend Transport; Fri, 14 Apr 2023 15:54:21 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:19 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/66] drm/amd/display: fix access hdcp_workqueue assert
Date: Fri, 14 Apr 2023 11:52:47 -0400
Message-ID: <20230414155330.5215-24-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT093:EE_|BY1PR12MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a234513-c810-4cd2-7c11-08db3d008354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mRTpFS4bI+CkUwqfENAviTme6B5iZ68Xe8fny7T3fx8W2WfsTCLu+3stjzv+jo//F+ZcSWl8jppUy2DbAMoaEfdl+Rv9sxNXmYGTaudnlckr+bi9zfZLrnzNEshq0tJO8T9LPyddaCyPgn/URUJWaoYRmp0UNVPu82MiRmwv6SP7SbUq/6qdMNxj/U/tmJBWJP2oS5I4SsTk93m7u/LUGmhzEBgpwNOb9zQoftkGLexXTuJLltjaah1VFecmrsC+pNUZHLxqUVY+T45TCSUq1CgQ4oB7e0JIttwVjsYeiBBFpXxSv3nhTuXYVb4PxzeinSMWL03YKx1e84FVpDJoaAK9kobp5dULVk13PMrSok0l332Ba9TVcbX1WQUWdwymYlFVQCvgzrjmhNaqLLvFzt6HxV0g4PPyDAklgY9g7ZFxURo83uqW/NdyQhiNfYFkLJnzgJbuDbIoD4uUeN69iSAu70ZRwirrS5Sm5KTooZ566QkSEmTrVNu0AGNzSO8ydePTOaF53hUdrTUgDh2JQTl/Gf7ZUCYPWwlGAtHiMjoVZ1w8XMMXG3t7igpL6GEoF0Z4oZDTqa8is1Re3hC47aRBZ04RAUmP7SmGI8k2zQ5V9Ct9Ha7kB9ray7Y6EKc7hZJV4dqbn79M6CJdts7EN9tdrnLHXLgXWzMnP1bf41PEsKsgeyff5Lv0Zh0TccIiOhl5SI2yP37CbdpiYTYeijuYzVlidTMVu+ibeILUvEY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(336012)(47076005)(83380400001)(426003)(54906003)(2616005)(1076003)(16526019)(6666004)(316002)(26005)(478600001)(186003)(5660300002)(82740400003)(40460700003)(41300700001)(36756003)(8936002)(6916009)(4326008)(70586007)(81166007)(70206006)(356005)(82310400005)(2906002)(8676002)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:21.5234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a234513-c810-4cd2-7c11-08db3d008354
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8446
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hersen Wu <hersenxs.wu@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hersen Wu <hersenxs.wu@amd.com>

[Why] hdcp are enabled for asics from raven. for old asics
which hdcp are not enabled, hdcp_workqueue are null. some
access to hdcp work queue are not guarded with pointer check.

[How] add hdcp_workqueue pointer check before access workqueue.

Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  6 ++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c  | 16 ++++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ffa2743e92e2..71e3bc9e7f8f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8558,6 +8558,9 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(dm_new_con_state->base.crtc);
 		struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 
+		if (!adev->dm.hdcp_workqueue)
+			continue;
+
 		pr_debug("[HDCP_DM] -------------- i : %x ----------\n", i);
 
 		if (!connector)
@@ -8606,6 +8609,9 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(dm_new_con_state->base.crtc);
 		struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 
+		if (!adev->dm.hdcp_workqueue)
+			continue;
+
 		new_crtc_state = NULL;
 		old_crtc_state = NULL;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 994ba426ca66..5dc79b753d5f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -379,13 +379,17 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 		if (aconnector->dc_sink && connector->state) {
 			struct drm_device *dev = connector->dev;
 			struct amdgpu_device *adev = drm_to_adev(dev);
-			struct hdcp_workqueue *hdcp_work = adev->dm.hdcp_workqueue;
-			struct hdcp_workqueue *hdcp_w = &hdcp_work[aconnector->dc_link->link_index];
 
-			connector->state->hdcp_content_type =
-			hdcp_w->hdcp_content_type[connector->index];
-			connector->state->content_protection =
-			hdcp_w->content_protection[connector->index];
+			if (adev->dm.hdcp_workqueue) {
+				struct hdcp_workqueue *hdcp_work = adev->dm.hdcp_workqueue;
+				struct hdcp_workqueue *hdcp_w =
+					&hdcp_work[aconnector->dc_link->link_index];
+
+				connector->state->hdcp_content_type =
+				hdcp_w->hdcp_content_type[connector->index];
+				connector->state->content_protection =
+				hdcp_w->content_protection[connector->index];
+			}
 		}
 
 		if (aconnector->dc_sink) {
-- 
2.34.1

