Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529E8C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Dec 2021 22:06:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E19F10E34E;
	Wed, 22 Dec 2021 22:05:57 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2081.outbound.protection.outlook.com [40.107.100.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 177C910E33B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Dec 2021 22:05:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPOA+aZIwvBTz3w16/UZKqy455+HuWXvTyCjDLCKJh9FtZCPENaIcefXVhu3D9hgYEH78KeLc9e5woLiMkkTUWUOd6NkpL+74GZrBxMYuKfOe4ik2JSjDkQFDu5ISlmbl26RhgGH3iAg9KvhfBOJdV6cl8jv7iypY0xQM3hgbBQjvL3bw3L2JaftIexXPR3AAJ1DYgq/OFsKIqRXjGuGF5/ntIUKMz7oo9uumdDLvdBPDjmFzOYF4lPEHsjZEy7kxnYCDq7Vfqx/zVx9EZEohNWlayg70UymsvENhdywQfBAiA8mozPv7C1BGQyMH7qhMdre+8q4kHH0Er/PAQgOGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rm/n66udQnE79K9t7sE5TJC9/LMmhNDKpNQJgbJ/900=;
 b=Xzc7gM68zyKlD6fLsqhVi0RmgWimxzEMctc8KEYOLUUUFzrDkYtyBzPnuecbr/OgE9IKgHEZVOTRMoZzT0v1Xvwqj7CjX1eOmV1x7KIZOx0YV+GQd/yfnIXws1XJoDSG531lBvxmLpjItrbR8BEGDrojxZmkcReXSHiuog8Tr7kNs53UIJjEllhbfdcdGd9aq4gCN6ZpG8P1kh73WVC0+SVxAYqAd9Td9WsTHDMuhJPBwbf76CluHoyTqCuwj4o9CVTJw3iwv9Dk+NHizPY6nlIhNg6tR67cyh6L67j4dDC42L14t9IhJPA1zPkf36PocVcOD8+UaQ4MIc1WIMfGuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rm/n66udQnE79K9t7sE5TJC9/LMmhNDKpNQJgbJ/900=;
 b=NgBX3agdOeU7Wvd5Xzn7pSCE7QzpnGOe2v+ZtjJYfbBTA50fWK+I27j01p71NtLH+pC+uUQNafoFxjVHfRmgvRRiWGMjYsaHU5X7NUg8N70F639ybt3bCIou3DyeCJQYDUQxeKCRAdTMCoK56ng2VUK9O5db5LJF2kC1WNO6WfE=
Received: from MWHPR13CA0010.namprd13.prod.outlook.com (2603:10b6:300:16::20)
 by DM6PR12MB3243.namprd12.prod.outlook.com (2603:10b6:5:185::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.19; Wed, 22 Dec
 2021 22:05:49 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:16:cafe::38) by MWHPR13CA0010.outlook.office365.com
 (2603:10b6:300:16::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.6 via Frontend
 Transport; Wed, 22 Dec 2021 22:05:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Wed, 22 Dec 2021 22:05:49 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 22 Dec
 2021 16:05:47 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/6] drm/amd/display: introduce mpo detection flags
Date: Wed, 22 Dec 2021 17:05:18 -0500
Message-ID: <20211222220519.1682537-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211222220519.1682537-1-Rodrigo.Siqueira@amd.com>
References: <20211222220519.1682537-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40629c19-8436-46b7-e8d4-08d9c597368e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3243:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3243B3C6FF5C5C8BF8F28C67987D9@DM6PR12MB3243.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V2Uy/37VCGOD9lLcQWZ2jyjZdi6r+VybrmWt5bMAruRNbt7IIVxEDsIPlu1atIeoofgDqDUAKTqRWlHT9k2E3PFzJ/P1UoFr0LIudjmZZ5qes1iLzaoMZszvi3QovBekmrKRhHatngaxdnk+mi0IW9shOXAkzBY2NqS4jDaO9TXzpLxrFj7ImJEllzRqrowbRfQgJSd4UFmc52FQillP35wm+kleqIGtLO5ibsgL2KMujBqkhS6t8uyKyynrdqoEQtlUCov1bRx5tlaFgaZxKHCx7hIRR3oUvTOhOO5lBbYDEhzMVHrKxHN5jNx66q3QiSIEnqybJ2CcOY0CKkkltZZiUdAjZqWshsQN8pLstitQBZxyPuT1L9oJbhtpE6skKWPXwcgVC7B0hQ4gpvQP7PI+Sy4Hg2W+6lW/W2GOxsiEkyFJdD1VHemAMVvNH7+cs/JWEvHM07LyL6X51tULLbl2MxrHcxeIOnoI5e4WDzofOMLflMU8pC1nQU0/XD+eyQsVsunzZBtJq9V6CyxnFBMEGePCFkVPkNQUg+8H9AAOxhqyBa2e4at9NtArU3M5hOiSxpfkJH4oJjsG9CVkTXhvRGRP/a/KGf9Vvcoq7Xn/BuK3iAeaiEnQKIyQKI3qcvkRj6RY9eVjC1tasjcZW5MPO9HYymTAxrR7ZszIE9AzBpgKrc+HS23mgn74q7unUCYNZH7Fe/h6zUsyu2zYOgUcWLk/pjF+2Z8/wTGbFYAIaJI2irPuXjvVIhUcbsYj5ZEPTmoA7YXayiYAr+QtE3lT6lsDCFNzHHG84UmUD30=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(54906003)(82310400004)(8676002)(40460700001)(70586007)(86362001)(6666004)(16526019)(26005)(36860700001)(6916009)(47076005)(81166007)(4326008)(336012)(70206006)(2616005)(1076003)(36756003)(426003)(2906002)(186003)(508600001)(356005)(8936002)(83380400001)(316002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 22:05:49.4142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40629c19-8436-46b7-e8d4-08d9c597368e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3243
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mikita Lipski <mikita.lipski@amd.com>

[why]
We want to know if new crtc state is enabling MPO configuration before
enabling it.
[how]
Detect if both primary and overlay planes are enabled on the same CRTC.

Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++++++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 ++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2432b0c0be69..c77207b02e68 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10761,6 +10761,8 @@ static int dm_update_plane_state(struct dc *dc,
 
 		dm_new_plane_state->dc_state = dc_new_plane_state;
 
+		dm_new_crtc_state->mpo_requested |= (plane->type == DRM_PLANE_TYPE_OVERLAY);
+
 		/* Tell DC to do a full surface update every time there
 		 * is a plane change. Inefficient, but works for now.
 		 */
@@ -10913,7 +10915,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	enum dc_status status;
 	int ret, i;
 	bool lock_and_validation_needed = false;
-	struct dm_crtc_state *dm_old_crtc_state;
+	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	struct dsc_mst_fairness_vars vars[MAX_PIPES];
 	struct drm_dp_mst_topology_state *mst_state;
@@ -11095,6 +11097,12 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		goto fail;
 	}
 
+	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
+		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
+		if (dm_new_crtc_state->mpo_requested)
+			DRM_DEBUG_DRIVER("MPO enablement requested on crtc:[%p]\n", crtc);
+	}
+
 	/* Check cursor planes scaling */
 	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
 		ret = dm_check_crtc_cursor(state, crtc, new_crtc_state);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index c98e402eab0c..b9a69b0cef23 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -626,6 +626,8 @@ struct dm_crtc_state {
 	bool cm_has_degamma;
 	bool cm_is_degamma_srgb;
 
+	bool mpo_requested;
+
 	int update_type;
 	int active_planes;
 
-- 
2.25.1

