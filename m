Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3045ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E238410E548;
	Wed, 14 Sep 2022 05:12:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD96110E548
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:12:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3FYRvdmwweUd3Tj3856S11vyr7O3nMCiql5DR+r4HlGh3CbTBUG6Spz/fqqgOFzjZ/dqx699BdxKz92lJgmJGvphwjm9ORVtOmwYX6UBVfnp6ISiN31uNEhSvqyJrVzGP1LCdrfe3uH4XuFWLXZGIl22po1RN5cBq89rkNkYkPjrIajFp4/43KrDiWoBZi3GC368agYeGhOdNNwKgDTOeytcZIkr9uFtG52WI/nS0Qr3jeRUroylpzQ2iJcEJ+PfPUK8b9HlaMVGaYvO1lLMpMZNsLYy5TmSy/xtk3sS7W5O/w/0OLZ4UEkUAJdedekEId4kVq5v/c0OOhqQlArMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lveCSPitdth3cZ21KJ8WE0CDc2C7v9EaddY3VAYHQPE=;
 b=SgSTYqwuRTf1v+NKajC3W/AOkFBd1srcZlFfeoHnRdPV+O2aB3NJgRj1xH9NsKAewl1uFVOGR58OM4MYpOnkWKEf+cSXfMxn7xtl9/hoj2d5nLqJz7ioPuTIwa0Cvok0yisW1EjLfdLnARE8mWf9GDmZJY8LByppyMyBX9sPBifOPRxHyTMgilvAuTGLf8SnLqJjgTXMwOqyGyCQScdlv1KmWb3zNvi3MkcRnVeumJtzoEF7f6TFDu2IOPzflUTtIimPtfcHBl/+prnOjVBwvY6gxvMtQuj4xVvJRPGkf1cUtQqcAzK+WL7wKVQjpTHDuEMV2GM35ev0QfZKvqTKpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lveCSPitdth3cZ21KJ8WE0CDc2C7v9EaddY3VAYHQPE=;
 b=x9VSk9wHOALxxgPenVpkkLcnma6suG9txda4gy6pACPJPvU35m184fuYKd/qt3b1Pwabvj+jvtN+ZaWZsTrTDZ6ggX1/JqghY4SfImohxCg7ilUhosq29WCOfEUjU3oYsVwqwn2q5KASm7lXsUaxDroVDS5+Qj/HwtqHwZv63lc=
Received: from DS7PR03CA0308.namprd03.prod.outlook.com (2603:10b6:8:2b::31) by
 BL1PR12MB5380.namprd12.prod.outlook.com (2603:10b6:208:314::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.23; Wed, 14 Sep 2022 05:12:49 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::df) by DS7PR03CA0308.outlook.office365.com
 (2603:10b6:8:2b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 05:12:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:12:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:12:47 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:12:36 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 07/47] drm/amd/display: Fix double cursor on non-video RGB
 MPO
Date: Wed, 14 Sep 2022 13:10:06 +0800
Message-ID: <20220914051046.1131186-8-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT031:EE_|BL1PR12MB5380:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d6f66df-c8ae-4aa6-a4dc-08da960fc45e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N2qpCr72s0ZrMe9U1VGGDZRbLfyzmMI260H62pxbuzJQL9TgGb71sZ5bAT1nZfYEGwCSSgwcHpBTfdJD7yXgy+ElTYBkY5UbmoF1OoeTnj0UyymK/5gLw0v58RNE128bprEZQDPr1v+Y/nki/b2SJGIt8egWoz2WQoh95CzeE+hdAgtl2yOfbuAhcGPB13eEbJt+ZUD2avRW3KYWIIy1iKHoM5K10hofyoECyGTUtupEYGy5HU1bDcKpw67TxQLWdOFKqljuzKBx9GuhmlHvxCOjsOSO9eouDPPkUjvG4NbdmRsWh+iPgrOSbpMZgBJe1m1zHfu0DAw3P1x/UsCEe5KMqu6R0wKtUrhnk67NoVFAfzqaR6tIenQwCrJmBtKOiuf2wuNEnWO5WtfcnF2LIYg0cdpHeKaUqayPbnNFsCtBuxFBkQnKDGxWf4pzARYaGb5wKGQ6vrjEWqDbbAKdLy7XIkrjh+BechOQKo0ik+ET0Igotjff5ysE7BOG+7QpG3KxRbogK+r6EZLmTNCf+Dq6jgL+GTpsiP5ssqiGq6YmJsWWgepsJeJE5Co2SYysPibDL/9vFkFUA317yeeTIFmfarP1AlrLQDR4MjwyjuKEEfG68ejApPR9MU57h2yYcBePOxE3Cx1/D+TeF5dmbGUCZh86Ax5W8Few6HVeZrPFUeE3yrovk49/K155ZMih9kczficMdcHYsm/GNbObPN7c9WiMvkWQQqfh6au/OZFGAwCByZTC99G5VXXeaYVLyaaNep4nNLPrn3Y9twH5vRarMpV41nXH7uN7owLDEaNcHslORH4m6eHSEJBeA+Qb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199015)(46966006)(40470700004)(36840700001)(5660300002)(8936002)(70586007)(6666004)(86362001)(41300700001)(40480700001)(70206006)(7696005)(8676002)(4326008)(336012)(1076003)(36756003)(186003)(2616005)(83380400001)(47076005)(426003)(40460700003)(81166007)(36860700001)(26005)(356005)(2906002)(82310400005)(478600001)(82740400003)(316002)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:12:48.8621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6f66df-c8ae-4aa6-a4dc-08da960fc45e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5380
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
Cc: stylon.wang@amd.com, Leo Li <sunpeng.li@amd.com>, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Li <sunpeng.li@amd.com>

[Why]

DC makes use of layer_index (zpos) when picking the HW plane to enable
HW cursor on. However, some compositors will not attach zpos information
to each DRM plane. Consequently, in amdgpu, we default layer_index to 0
and do not update it.

This causes said DC logic to enable HW cursor on all planes of the same
layer_index, which manifests as a double cursor issue if one of the
planes is scaled (and hence scaling the cursor as well).

[How]

Use DRM core helpers to calculate a normalized_zpos value for each
drm_plane_state under each crtc, within the atomic state.

This helper will first consider existing zpos values, and if
identical/unset, fallback to plane ID ordering.

The normalized_zpos is then passed to dc_plane_info during atomic check
for later use by the cursor logic.

Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7a9f7c7da7d6..85172e1e3351 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4756,7 +4756,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 	plane_info->visible = true;
 	plane_info->stereo_format = PLANE_STEREO_FORMAT_NONE;
 
-	plane_info->layer_index = 0;
+	plane_info->layer_index = plane_state->normalized_zpos;
 
 	ret = fill_plane_color_attributes(plane_state, plane_info->format,
 					  &plane_info->color_space);
@@ -4824,7 +4824,7 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 	dc_plane_state->global_alpha = plane_info.global_alpha;
 	dc_plane_state->global_alpha_value = plane_info.global_alpha_value;
 	dc_plane_state->dcc = plane_info.dcc;
-	dc_plane_state->layer_index = plane_info.layer_index; // Always returns 0
+	dc_plane_state->layer_index = plane_info.layer_index;
 	dc_plane_state->flip_int_enabled = true;
 
 	/*
@@ -9481,6 +9481,14 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		}
 	}
 
+	/*
+	 * DC consults the zpos (layer_index in DC terminology) to determine the
+	 * hw plane on which to enable the hw cursor (see
+	 * `dcn10_can_pipe_disable_cursor`). By now, all modified planes are in
+	 * atomic state, so call drm helper to normalize zpos.
+	 */
+	drm_atomic_normalize_zpos(dev, state);
+
 	/* Remove exiting planes if they are modified */
 	for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, new_plane_state, i) {
 		ret = dm_update_plane_state(dc, state, plane,
-- 
2.37.3

