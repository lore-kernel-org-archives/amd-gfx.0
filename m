Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB58CA1002
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 00:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E30F10E54F;
	Tue,  2 Sep 2025 00:47:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h795kOVP";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30A3010E54F
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 00:47:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcUjCq+yrHD0XPwh+qyFdWgXB7ckdJysAud2DtpmSXhWGNRfKYjRPIdikL+genZ2ih+V4r54ZOPwBFwSfq3aPjZccNBVZ4kH1VgAzbW9pfhe8iPqEf9OUn1HQts9/hisbvfTPmoZP9KR8woROGsPlKVHYjmWYSl1SY9nMbL2RPBGh9j20HGUa7XPYdqv0BD3H/zL3IwoXIhWMYpvnoLca50CGzjdvGTXq/vwNiN4Y/TqeBjjBf9qXzCPNXyOJ2XzlcfUgr2AKhbMnWG+2HHn31gyO6OUOAcR9gLszW73pW24Yov6vzxtA0pvGXqd4qOt5tQo/sQozlDKLxGgT/95rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fskpZfUEIITWNqxHXCP06DiZs+eDK9B4MgtkJO45vd4=;
 b=bpHR7k5k1xkjRP8s3Vk+xj4K9T721DEvG58rOSJmqI2UDK4HvIIz5CY2r+c9e7RTFpnKiEGZb1DPttUctjSZzOrEWngdVFl9/CLsgdSHRcyX/kI0rGcsTcPVZ6SZPdz9gkljXwJ6EnvXVRCmjDlaHo9J56S6C0GcphCgTRjsA3e02vKsLbXPZkGFkG7SprQ9u5mrnrmpFuUMQqwH4ZCaAuhc0Vc4aV2y7gshwXT3y4SFGyOcoz3zjp6PCQFdCuFGLHkhe6NZGjt+CCkczvOnEyZcC9KD3R7QbRxL3i9a55I666FxcRHsLtye0rPKdhCoAoxPB9BqZyrODPGqo5Vu8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fskpZfUEIITWNqxHXCP06DiZs+eDK9B4MgtkJO45vd4=;
 b=h795kOVPOrCgt4WlU/uGvv+0IpHz6FTjA4anczSg0ERzQ2FYQlYTOYVFg8gdrJnGbgMjnZAEA4wxexhLTUhkn7U3yrmszDyinXYY795sm77+206CdyHvACza5Hghv1XjNMFeOx/4ymdkxY/0suBMnaLZ5drTA+WJvFwcFLyJE/k=
Received: from CH0PR03CA0385.namprd03.prod.outlook.com (2603:10b6:610:119::20)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.24; Tue, 2 Sep
 2025 00:47:09 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::62) by CH0PR03CA0385.outlook.office365.com
 (2603:10b6:610:119::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 00:47:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 00:47:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 19:47:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 1 Sep
 2025 17:47:03 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 1 Sep 2025 19:46:52 -0500
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH 09/11] drm/amd/display: Fix pbn_div Calculation Error
Date: Tue, 2 Sep 2025 08:42:54 +0800
Message-ID: <20250902004532.1833436-10-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902004532.1833436-1-Wayne.Lin@amd.com>
References: <20250902004532.1833436-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fcab71d-361d-4fbd-7085-08dde9ba3eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a1EG1HKgUirXeuCajAUVrfOpVIhWbZXop9kFVFUtvMt/jXKZCTQCYhToP+qF?=
 =?us-ascii?Q?3EKVr+wfc237qYTnejDCQ+KxDy27x1aRTuX9IqBIU1WbMfVMUyA7+zKTd3Wu?=
 =?us-ascii?Q?Bvn2qZc+rbBqrXBThkfjwVsgelaSqIZSEYsJ1yFZctR1xIDOlUHdvKVIyiqY?=
 =?us-ascii?Q?CidJ+jtDgC/RqiUXiOsyuQW5U5jch+wZtimRCjivp9oyidFqnlV/KMtsfK0A?=
 =?us-ascii?Q?sB8hB65FFAW7+W2DSCdlPIYBVe45981nS7ibe/HjEtgANu1Y6e9sOJfz74EW?=
 =?us-ascii?Q?QIafc0GPHiGRMjtRGygVTho4BRAcUma4gwLX/7o+GCd752+NLQIzfvpfXiD9?=
 =?us-ascii?Q?luiKILuOHrU81efBdbfFbUDUpWhSz3tc0mcKiBz80CuizY+A0Map76dFbd6R?=
 =?us-ascii?Q?MCdWvWt7w/5TfkbiPnuX532WbF/oIx/2kYeTONf5ReNMlh/KkczTnWiNPlT+?=
 =?us-ascii?Q?oJKwTTvC+UPF0x3bXAIub0Vs2vJnKh7wFtZss71KFQW1Mwh0SW/6lT9vLAyz?=
 =?us-ascii?Q?x9S+GYZJegNDafPDTo0qUu3I+IKbAiY8jXO67Gxvw7r/c2t0lN2KE4KqQCp8?=
 =?us-ascii?Q?/uQxGsaVFxsw3bNRHFXEXuXvue+7yu8Hg//Nv0WBkZIz8QvMh2G5bokUKouH?=
 =?us-ascii?Q?e7FbyBdWKfn1dnDoGQrq8LRBdNmCGsj6YrmuKeXKb9TYp65mWiTlyPu5I1MA?=
 =?us-ascii?Q?r3aNn6L/arREi4zqVkyJr+BHPL77kDeHgS4oRQ/eRDgDEGxcfVJtCwHJJFiQ?=
 =?us-ascii?Q?H90G1jRIGsNzHdv/dCsMSs92Fl1PhajajoiU1ZwPWp4FXmsGo8H6VJnFX+u3?=
 =?us-ascii?Q?bDBgirnE+YMAjP97eUdBuYrRQhtzmpACm8Pydxp+r6hf0bRgslFqdjB1fTEp?=
 =?us-ascii?Q?4x0hGbygv/XYMe43mN7Cbht5HF/McGhH3DjQR5Hf6/8/FfDGGp5PGwDvp8Is?=
 =?us-ascii?Q?K1VO/mB0HrMMufsAxwpPa6G9GieYu3vHeMcw+NiFsNGmzp2bnYP4j1oVZXpx?=
 =?us-ascii?Q?0hxGkb9v6naCbX/qp9cwUNW6FUD5AHlp9kUteulqbKQKwK+iK/2mpQ2F+7qj?=
 =?us-ascii?Q?kjvmjtlS2KXa9zHy6/mFooKTFWyej5Hc2lT/iSqC9+Ad0P28kb08+H+C1sL3?=
 =?us-ascii?Q?AKBzhc++odEcx5gBmGIVqW0HaV2OURM4Z8cg9Xb0aZeDz+LHOua1iQ9jUEd4?=
 =?us-ascii?Q?YzK1IAvb1nHpa2zjXr8gvyqwJohEUEEFmKcziZVqtJ4GzR4AmLWdarXO2j75?=
 =?us-ascii?Q?HUhvT8vzKmpBXpmdTKg5HdaS/kHiJqiE5q3zd2YpAm2q2lk+ewFFfZ37ZcDC?=
 =?us-ascii?Q?xuZ1dPpWLcRr8+MLf+MnUpYLsSfqMOBa2bYucPHgW0LMkONKZ2jEVdkntF87?=
 =?us-ascii?Q?pGDXD78MokQYRYrRHHL4fT4WhrKQF2bNPMZUzs/az0j/05WGK/NpqYoO6xAr?=
 =?us-ascii?Q?zRzZJBQN+TXvKsiXp4KC8jEvrErgDwHZPnDKddcMzUFOcSbQK8plF/iTDthR?=
 =?us-ascii?Q?Gb0jGosWJVhFMztPcCXkwTGk9q9r9zYHqDcQKmELZu8h+4YyJcRt0JeeEg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 00:47:08.4540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fcab71d-361d-4fbd-7085-08dde9ba3eec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

[Why]
dm_mst_get_pbn_divider() returns value integer coming from
the cast from fixed point, but the casted integer will then be used
in dfixed_const to be multiplied by 4096. The cast from fixed point to integer
causes the calculation error becomes bigger when multiplied by 4096.

That makes the calculated pbn_div value becomes smaller than
it should be, which leads to the req_slot number becomes bigger.

Such error is getting reflected in 8k30 timing,
where the correct and incorrect calculated req_slot 62.9 Vs 63.1.
That makes the wrong calculation failed to light up 8k30
after a dock under HBR3 x 4.

[How]
Restore the accuracy by keeping the fraction part
calculated for the left shift operation.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |  2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 13 ++++++++++---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h |  2 +-
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9273bc3849f1..6a9d4545e8e7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8004,7 +8004,7 @@ static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
 	if (IS_ERR(mst_state))
 		return PTR_ERR(mst_state);
 
-	mst_state->pbn_div.full = dfixed_const(dm_mst_get_pbn_divider(aconnector->mst_root->dc_link));
+	mst_state->pbn_div.full = dm_mst_get_pbn_divider(aconnector->mst_root->dc_link);
 
 	if (!state->duplicated) {
 		int max_bpc = conn_state->max_requested_bpc;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 6a817508c826..2cf8f80f3764 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -853,13 +853,20 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
 	drm_connector_attach_dp_subconnector_property(&aconnector->base);
 }
 
-int dm_mst_get_pbn_divider(struct dc_link *link)
+uint32_t dm_mst_get_pbn_divider(struct dc_link *link)
 {
+	uint32_t pbn_div_x100;
+	uint64_t dividend, divisor;
+
 	if (!link)
 		return 0;
 
-	return dc_link_bandwidth_kbps(link,
-			dc_link_get_link_cap(link)) / (8 * 1000 * 54);
+	dividend = (uint64_t)dc_link_bandwidth_kbps(link, dc_link_get_link_cap(link)) * 100;
+	divisor = 8 * 1000 * 54;
+
+	pbn_div_x100 = div64_u64(dividend, divisor);
+
+	return dfixed_const(pbn_div_x100) / 100;
 }
 
 struct dsc_mst_fairness_params {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index 65f76a7d00db..6f7ea684b555 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -60,7 +60,7 @@ enum mst_msg_ready_type {
 struct amdgpu_display_manager;
 struct amdgpu_dm_connector;
 
-int dm_mst_get_pbn_divider(struct dc_link *link);
+uint32_t dm_mst_get_pbn_divider(struct dc_link *link);
 
 void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
 				       struct amdgpu_dm_connector *aconnector,
-- 
2.43.0

