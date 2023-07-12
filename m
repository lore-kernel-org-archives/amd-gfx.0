Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C217EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8CCB10E5B0;
	Wed, 12 Jul 2023 17:14:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1319210E5B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCXEaICHPJ2ZVkvDs2QtqpGwgWiOslKbbvnuc8cPj7V+MgYRBS2S3PPvD88IUd1MeneUP9gBM33RlB2CK8lxmCGPWC5jMhChXMw2eRkZqsNdsnFK8EkOwiD/xbH1Hm1UHWlTnKft5WH6c5wgoNTvbpFPCxHeZmUf1P4oZZKEfhpb8f/9c+nzqcQeWBXRLGK/NOeJW/FDyQlrAHGa4jEQiaNlNAe72OYFy8QTKYTsi0mr+oTx1eyNsQxTK1Vq4szXWYjQi32T9kmfGCYlEVIBzbF3fs2HXh6GUJxcaIcbmHy3Zam+BMDdMS4QxhycJsFvsC3mRxikeCLRR8ti3Ead/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6SBkAhcBnDULP2ZDuYNWF10PLoS0jAsiKZ8vyVLrRk=;
 b=itWbfDmUJRjyrDznaPgkNGwwnNLIUgFV4F375DpKs5l7mYD7d5LIjL+7j4mt3HBEk54DvIucqowzruHXCm9Gk1Nz3IPd0JH4DxbyXSOFIb8b0Zt4QJuG8s2Lk26tBXVkLqfgaosv0fXqIqihayKTWmqn//8VZLQoWw2Y7pJ7rl19HqFxuyUVwn4kPXEdmi3Dj4yfZzsK1pDv7Xld7Jiv+QL+enaUpG0pgU2I3QLVkbJCaNDr6E7orcP/NL6bUEwAcFfPwxmB9+yHFTZWc+w2mn2wOOGt451sHXM7Gx2FHLTUMrAb4b2H4vyXKs4yPz9bB8bPgodRRWBEZIBSiKfBYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6SBkAhcBnDULP2ZDuYNWF10PLoS0jAsiKZ8vyVLrRk=;
 b=5F1s9XcyNPifp9vGwgkGCnZV0qVxpHPk8P1I46z5X2faQ0cwnk8F3OcyzlDQUFMczsInJvP3FVk2yegoqkH1tMsQHcz5VUlKQ4OHN5GV9tGZKABgP8ei3dVxA9jeN08YKg5nzOGTRX/+IWzSkI7DbHt1JvHQnBu2bIsV94WGWm4=
Received: from BN0PR08CA0027.namprd08.prod.outlook.com (2603:10b6:408:142::25)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 17:13:06 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::c5) by BN0PR08CA0027.outlook.office365.com
 (2603:10b6:408:142::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 17:13:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:13:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:13:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:13:04 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:12:51 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/33] drm/amd/display: Reduce stack size
Date: Thu, 13 Jul 2023 01:11:13 +0800
Message-ID: <20230712171137.3398344-10-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT028:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f7503a8-1b72-4b1f-345a-08db82fb41b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 83M70CW3YLGJpll5i59zdwigu3Begnk3N3sZrzPpkpGQLJuqOOcTdJEgf3ANjiTGBh1l0vPjooL/JOOXMSf2F4DC22KbfrYUXDbMsUX1oTO0lRYv0WSG7P1peFE1P17aPZstEM6cEsS+iJ6vX4xCchQOPcA0AJFI/Ix4A5zDUy2e+ZERJNUEtn61TtVU3Bkg1ZKvf5l2nqPFunosepKY8V6nfVVwdNb8KaRziaREGfSXNyA0FCQY//XYD1Xbw41+jdjHcbzsnlan3LC2VD20U1lmLHxOgaoNTIKyeNpCMWJa+bJsitxhbV7SrmVEl8rx/NRNL/J21ORb4EEYrzk9+JQb71n2uYjY4dwlIx1GTsGJZrMscYRQTgCZ1WwDb7uGt89iJkJsuCn21BpMVYExZUy6FUXGTcsE+g/6o15wR1aywD6BjCurrr8UIsTO20UiQ4G0HM9NGnJO3rDTyE/4Aw4EdAZinhiV3goIjOX0CvMvKawbwE5rUSJ9QB3Grs+nZzyzknjjx04phQa76dRxBVRKQIzCYeYk7XbNUBxuFWkY4vDNlBZF7jPEJPM/bMbYjCUrYwJw/fL5g1Vf/ygMLRcCUp95CNJ4HxTSQYvhKUHqbVW0BMtIPUzbCXcVIWJUNIcBVAuaPKMuEwyzhzGoQvG6YZncEJoAKh5p7awqqhMFxMRtmWgcKbPIfTQQKLlvPSUT2hXN33pAYZ2+Y66AfPpGHUs/OwOIkyG3EptKvpDN/magZ0TXf5qALvEvFYI5at5H35rN67W5CaxJy8pyXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(2906002)(41300700001)(316002)(5660300002)(40460700003)(8936002)(8676002)(82310400005)(36756003)(40480700001)(86362001)(478600001)(6666004)(7696005)(47076005)(83380400001)(36860700001)(1076003)(26005)(186003)(336012)(426003)(2616005)(54906003)(6916009)(70586007)(70206006)(356005)(81166007)(82740400003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:13:05.3516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7503a8-1b72-4b1f-345a-08db82fb41b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566
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
Cc: stylon.wang@amd.com, Alan Liu <haoping.liu@amd.com>, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <rodrigo.siqueira@amd.com>

Reduce stack size pointed by clang:

amdgpu_dm/amdgpu_dm.c:8655:13: error: stack frame size (1048) exceeds limit (1024) in 'amdgpu_dm_atomic_commit_tail' [-Werror,-Wframe-larger-than]

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 42fa632523a2..6372347edd3f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8714,13 +8714,12 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
 		struct dm_connector_state *dm_old_con_state = to_dm_connector_state(old_con_state);
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(dm_new_con_state->base.crtc);
-		struct dc_surface_update dummy_updates[MAX_SURFACES];
+		struct dc_surface_update *dummy_updates;
 		struct dc_stream_update stream_update;
 		struct dc_info_packet hdr_packet;
 		struct dc_stream_status *status = NULL;
 		bool abm_changed, hdr_changed, scaling_changed;
 
-		memset(&dummy_updates, 0, sizeof(dummy_updates));
 		memset(&stream_update, 0, sizeof(stream_update));
 
 		if (acrtc) {
@@ -8779,6 +8778,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		 * Here we create an empty update on each plane.
 		 * To fix this, DC should permit updating only stream properties.
 		 */
+		dummy_updates = kzalloc(sizeof(struct dc_surface_update) * MAX_SURFACES, GFP_ATOMIC);
 		for (j = 0; j < status->plane_count; j++)
 			dummy_updates[j].surface = status->plane_states[0];
 
@@ -8790,6 +8790,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 					    dm_new_crtc_state->stream,
 					    &stream_update);
 		mutex_unlock(&dm->dc_lock);
+		kfree(dummy_updates);
 	}
 
 	/**
-- 
2.34.1

