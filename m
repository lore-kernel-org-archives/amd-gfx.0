Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64394EB64DC
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 04:42:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3A2D10E079;
	Thu, 29 Jun 2023 04:42:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B08B10E079
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 04:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmRnuddXhXY2PfFkISeywmx5h2bdl9DNM3Bum5+9ATLw5zKqGUZmnwpn6mLsJlTRL+fbdVNyw0RUk5DiIAmOr2vEGC1vr2cznkLUwXaNz+EWgTiIVH4iFi5Q2c4bMZMPGjeQWBoJSTRCmUIn9j4pS1MiQDJZEd3w0iMOuW2+DUlG3ITXZs3r2ltojQ799K2VH7lo+HIzllOYSUpN8HsVhyq+orbIcCtTO1EvSFKlEOxMShNB7DSY2Ta1J1vaEu64ZL9/ApDgKM7XyHVQZLxnivSxrOpguPfFHOWnSmSBS0NpbgVmsmFwi/gTxLK47YsODGX2K1KXVrSWz36eW+zAtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7lErXXSLebLyiY72TF8yauhbRsVpbc2nfhS7gIhrdk=;
 b=a7bvUnCDFGCl0XRdeNiUDMRxkojduy++DB09TkDzIho8ZIoCjvmhNX/qO9ZoAMCsi1jNMJUeOszDJ0oJms9EnUisv1TKNqdqAeTI69DANcIT6janlbUY3PpHWwqRaJecWwtP1P4kOwXouzghPVL/MOguigVruRQdVllSJX7+UWSFuHSw3ze2P+WY+mCL5P1MDFjzEC4swtAZhYTLovU1HglxtxvLV+eAQlsFtC7+ld6gP4Ch6jCIFvtjcZ/kCyA9fnPSCok0olmNfcG6giPJ560meZc721JRngFGop3unzx0OzAWiCBbkmAbGpTYX/qbvN4bxEvwK4OwI1QC/wQ9cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7lErXXSLebLyiY72TF8yauhbRsVpbc2nfhS7gIhrdk=;
 b=ETX3XcADZ27uKcyC9tL6EgceVE2YcD+USmijGqQH5RICd/WCtQvV9C+Teus+OCN1K8UQK6dsmy+6Ei3f29+6VhqmAgrnFyfs4kJLirTHXki2Y4nd/da0yaoWQoF1OYXZtUOnGLJU8DOXy1cPXS+i0bgyuUl6VuPKEEYga9Z/eCc=
Received: from BN9P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::16)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 04:42:41 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::79) by BN9P222CA0011.outlook.office365.com
 (2603:10b6:408:10c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.20 via Frontend
 Transport; Thu, 29 Jun 2023 04:42:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Thu, 29 Jun 2023 04:42:40 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 23:42:38 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 5/6] drm/amd/display: Clean up warnings in amdgpu_dm
 _mst_types, _plane, _psr.c
Date: Thu, 29 Jun 2023 10:12:07 +0530
Message-ID: <20230629044208.2266584-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230629044208.2266584-1-srinivasan.shanmugam@amd.com>
References: <20230629044208.2266584-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT040:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d27c79-e6e0-4811-ae5e-08db785b45b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RQPxKrv5C+vMPHpd4SRVtpEwYzlAMABsN0qMKPiqvQxedozoRbOX+HAMit1PsegRQdQ0a578UxaA/Nt2+5+AFrHFHE4JR2NlwWNFRZGxeLIkoOS4GESroUKeH48OqTxyFANMTsCjJj7yvjv8BdAy+Kbd0OPX1rPonsdmwXDraLMKVZRmGkYyOU1DGHiZJgdXEB565egmasI1gkdpB6tOHLE8+3Xh3egJ0cSjRAsySLCOlunKijZbA/lCW+qx+oKL6sSYOuZHGM/gDIrgLuZVb0h2zlFYE/ZKRe54cohqNFZmFKqI5SjpJA2vmBRaIa6wUlewyj0Uo7vbkMGFCBj+0/UUwik37+h1XTARuQsT0h+6ZT8vs4p9T13pD/Og1IC6lBe8wscZpdH0ci+T419ITE5Cn2eclz5UGColWisFufhRchO3nF+7XRCsQv7rVEjo+BkUcZc815xgWDmFDXqqAyfJzLackDTa7r2NI7+JhymOnQRzan6/+FESRK80saV0i+HvTDcGxuf/8VhZpt/yHbuIze+9dGLDp8IJTUyhoF8/7M91Vrbsjh82pgV/MXc1ji1A7s01mEXH7Gke/A/aMuvdhK7fY47yvOu6N9Lv13zBt0gKot/J+0I3gM5/M+L3/jJlAXqELeq4K8IFK0UsO1mxwtE2qpTvbw+gwS0KjDybNIe9nAelx8ks9udSYhOAxn1KjtMo8IBrSh4eA8GFpvc7rgISQiqDroElC7mTfQO1gJiAOVINuSQbKYsbwPeeEUrRzgDbzxIQ7nSil7Y4DQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(316002)(70586007)(6636002)(5660300002)(4326008)(70206006)(478600001)(36756003)(8676002)(8936002)(44832011)(47076005)(1076003)(40460700003)(36860700001)(86362001)(40480700001)(54906003)(41300700001)(110136005)(2906002)(82310400005)(7696005)(426003)(6666004)(336012)(186003)(16526019)(83380400001)(356005)(82740400003)(81166007)(26005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 04:42:40.9389 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d27c79-e6e0-4811-ae5e-08db785b45b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following warnings reported by checkpatch:

WARNING: Missing a blank line after declarations
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c     | 4 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c       | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 46d0a8f57e55..95eefa6b4f2f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -296,6 +296,7 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 
 	if (!aconnector->edid) {
 		struct edid *edid;
+
 		edid = drm_dp_mst_get_edid(connector, &aconnector->mst_root->mst_mgr, aconnector->mst_output_port);
 
 		if (!edid) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 322668973747..de1c7026ffcd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -164,7 +164,7 @@ static bool modifier_has_dcc(uint64_t modifier)
 	return IS_AMD_FMT_MOD(modifier) && AMD_FMT_MOD_GET(DCC, modifier);
 }
 
-static unsigned modifier_gfx9_swizzle_mode(uint64_t modifier)
+static unsigned int modifier_gfx9_swizzle_mode(uint64_t modifier)
 {
 	if (modifier == DRM_FORMAT_MOD_LINEAR)
 		return 0;
@@ -581,7 +581,7 @@ static void add_gfx11_modifiers(struct amdgpu_device *adev,
 	int pkrs = 0;
 	u32 gb_addr_config;
 	u8 i = 0;
-	unsigned swizzle_r_x;
+	unsigned int swizzle_r_x;
 	uint64_t modifier_r_x;
 	uint64_t modifier_dcc_best;
 	uint64_t modifier_dcc_4k;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 4f61d4f257cd..08ce3bb8f640 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -166,6 +166,7 @@ bool amdgpu_dm_psr_enable(struct dc_stream_state *stream)
 	 */
 	if (vsync_rate_hz != 0) {
 		unsigned int frame_time_microsec = 1000000 / vsync_rate_hz;
+
 		num_frames_static = (30000 / frame_time_microsec) + 1;
 	}
 
-- 
2.25.1

