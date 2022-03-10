Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D39C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 22:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F82E10E3BE;
	Thu, 10 Mar 2022 22:21:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 964D510E3BE
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 22:21:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjJWBWC5v4BLCqkr+1TUy7Tm1/8tx3McskcplgbnFDHc0OmPWy83bTXk3a1oWcQso4NBfjxmauflkrvfdt5XdmJZ6DkxmOkVKBu34kqGxO6JjM5RcK19Kf99YgTQc/R/fkZeyT3t9O5fmGptpM8jFrN6DjO/exK/vY5YB5n0QG4Z7w/1/UsvIh+hLASb4z0jwGOsll6nXdjt541FklsbWFEEYpfX3HzyHywcBq0rH7qM1zd9P2eaHGjOYqZJc+KQXgA+79ll7e5qxNSVQusnKEZfJerhC30irxraxdluWr6TDdH/aTITYyUDtHR8QtwV7dF650YeQZqy+0LUYLuByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yZpG0i59uRFohT+tZbEVVk6Csnm/qkOUXVx0kNrrks=;
 b=ZRPyAjSPFL8LWQOMWHu348fQgXuDRSxPYHa7yxfsF0tLHgcctkBI8IUlBzqHXB7WhHkWCs+yT5V7hk/eWrLOpjq/ELv6wDY89bxCIY9jnltI7iWDudJwyFdnzvRXeGoeihySnzR/v2bHHkyeuFYMQ2lYJ81RYg8TQF1li0ZkmgyHMqiHPG02njYIecSxt7FlzXb0ZaLau/k4XR3SjEIwI4w3djypR/CeEhXTvOytMnbdVS28eoXjmpDu7uR0Ml9Ap7UCWsKa3R7XVgcuVpeYUx8z6TbDpTF8FiVi+dfG7MfnvRxHKVrPSEb/4GbhUG7z6t8mdfdrpCa0G8pOC4KyOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yZpG0i59uRFohT+tZbEVVk6Csnm/qkOUXVx0kNrrks=;
 b=mziNzqexmlruy+WdMUlIS+QloX2PqKfntrNMa+X8IM2eLGyR58XlbuwQKBduNy2cB/BlEHu2SLQEC4pGRIqNQiYzgfCXvG3ZLIlCZLWbvYALVp7v63MXbFNgXBmrnpDZPmiHjT0Ydz8vtPXOvTXJ9q87IIUrh/VV3etVqmFfm30=
Received: from BN9PR03CA0358.namprd03.prod.outlook.com (2603:10b6:408:f6::33)
 by MN0PR12MB5955.namprd12.prod.outlook.com (2603:10b6:208:37e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 22:21:26 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::34) by BN9PR03CA0358.outlook.office365.com
 (2603:10b6:408:f6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.27 via Frontend
 Transport; Thu, 10 Mar 2022 22:21:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 22:21:25 +0000
Received: from Linux-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 16:21:22 -0600
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/12] drm/amd/display: Fix a few parts in debugfs entry
Date: Thu, 10 Mar 2022 17:20:36 -0500
Message-ID: <20220310222045.664867-4-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310222045.664867-1-agustin.gutierrez@amd.com>
References: <20220310222045.664867-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a7ef10c-d08d-4966-412f-08da02e450f0
X-MS-TrafficTypeDiagnostic: MN0PR12MB5955:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5955C3A868CD8BA8D391E979F50B9@MN0PR12MB5955.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6P9mpI3WWkLwBvetHEJOE1msLH6Hf488tx26FfRVvO1aj/+S/frZr718gvKC6VE61ygRoOQBtS8ah1h4bEJaEoXWdwuuxl91B849hxinCorBCuDzHBrKLO687dYtZR/Uu1mqoZDOkOyk0WT3My5nePG9etPQ4lLVilJ8gCvcCqT6l9HD5ErRumA+TVtDAfzRBOC8RwGyo50gSi+VtwnSHHgcQ1fKJoN/DDFh/LB+Cw0yPtJfZ8OkP4/JfA3nnVLJ5wy2bVwVhromdP9ubdv1leEk0haZV0dwiLtbkZ1iz1lw9Ft8VLHHA2ZDAU060rcyz7lhGPJ8HiKqM04A+Cy0HdfhvPvA/gNklKptMSpeeFRpE080kAedI1yrS2sUbouBz2KAaCi/mk+lgiX4AoUZoW42yIsEDwlr/k1WBM4nemjyutA64feDjYKF83feJYd1UbiGAyAJr87dAV1kHzecmg7snKh2qBTncZqc94GKhJV3zq0TDFR3ELTP6wVtWzK22T9mz4w/jdHN4qq0qA4jpnRAHcKzmHfudUGap2jRd9PQdSplSe/3G0s52+rbS9+Mmy7c7UQz+b5LTLZAIwZOhYI6lvLp8qyMqPGNvMjVrhFaBSmFAA51FBoCYx3ipKNVoLBSUAMg6sz9wRdf4ZeoNI6d6IK9WIsMst+R7Lu7s96CYSXVnM325TNObevIcIeJ/TgsYRHCEzUv1ziX+s1G5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(8936002)(6916009)(83380400001)(44832011)(54906003)(186003)(426003)(40460700003)(86362001)(336012)(82310400004)(47076005)(36756003)(16526019)(26005)(1076003)(316002)(6666004)(2616005)(81166007)(356005)(508600001)(5660300002)(70586007)(8676002)(2906002)(4326008)(7696005)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 22:21:25.7880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7ef10c-d08d-4966-412f-08da02e450f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5955
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why & How]
1. To leverage and simplify the igt tool. Change the value of
retrain when calling preferred training settings.
Now, writing value to link settings triggers link training immediately.

2. Add dc lock when triggering link training in edp_ilr_write()

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 77f9d94743a1..d881e695d97c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -247,6 +247,7 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
 {
 	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
 	struct dc_link *link = connector->dc_link;
+	struct amdgpu_device *adev = drm_to_adev(connector->base.dev);
 	struct dc *dc = (struct dc *)link->dc;
 	struct dc_link_settings prefer_link_settings;
 	char *wr_buf = NULL;
@@ -306,6 +307,9 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
 	if (!valid_input) {
 		kfree(wr_buf);
 		DRM_DEBUG_DRIVER("Invalid Input value No HW will be programmed\n");
+		mutex_lock(&adev->dm.dc_lock);
+		dc_link_set_preferred_training_settings(dc, NULL, NULL, link, false);
+		mutex_unlock(&adev->dm.dc_lock);
 		return size;
 	}
 
@@ -317,7 +321,9 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
 	prefer_link_settings.lane_count = param[0];
 	prefer_link_settings.link_rate = param[1];
 
-	dc_link_set_preferred_training_settings(dc, &prefer_link_settings, NULL, link, true);
+	mutex_lock(&adev->dm.dc_lock);
+	dc_link_set_preferred_training_settings(dc, &prefer_link_settings, NULL, link, false);
+	mutex_unlock(&adev->dm.dc_lock);
 
 	kfree(wr_buf);
 	return size;
@@ -2887,7 +2893,9 @@ static ssize_t edp_ilr_write(struct file *f, const char __user *buf,
 		kfree(wr_buf);
 		DRM_DEBUG_DRIVER("Invalid Input value. No HW will be programmed\n");
 		prefer_link_settings.use_link_rate_set = false;
+		mutex_lock(&adev->dm.dc_lock);
 		dc_link_set_preferred_training_settings(dc, NULL, NULL, link, false);
+		mutex_unlock(&adev->dm.dc_lock);
 		return size;
 	}
 
-- 
2.35.1

