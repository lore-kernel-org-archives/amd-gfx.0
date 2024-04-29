Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7BBC25B73
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F237112CB6;
	Mon, 29 Apr 2024 14:34:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2ssCrZFK";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23A9D112C90
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JG80fX2SYf9HPc1NbxX1elPcdISJKDfhrNoLMoSekEpyLjg90Hz3E33JJDFWTF7LPD5MX8BXsv0R1BNwKadnBXgtxXXH8GiMCAqMe89Rk7T3m3tofck+H4AlWA51i1Fk0l9Mwp+56fnFkJ3m/nX05sUVRiSo0aKgkSW/RJ2AIvVD7eX5Xw8/9H93gjFAsdhtFvuTupy1RoiLPIPL8I0g7Bqxyl/Hf/fUM2UpyKflXnIPTLucFCXKn2Df6qCBEYimS8XRSQMFHSGrikNk0ou4J8U7zaDzc8G7aC3NS0n2nYSFQ5tshgiyWFzq67hJuLcq4itWktgllYI7UuEAdr9x+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kEalPNBy9m5OobxLlrUrXEL0KmZTP2eUfEkay8jGIw=;
 b=BpuIt4UUNfuIbjqS3bBEDnyVjyqa7KCtAijD9pGBt3c7HBChEwDkrFeRGuagv3lCbO33PwI0i0BPbBRxCEfuGIyrKRN36afHpp/vlP7WMeKrXfXXKzDiEbuMIZ7478xv7gtkc9OcgGOXeAlz5aLDW+p6GS86yTkStOTA3SMxV+JpRRyO0JaybaNIVW204RAnNAO3BCkjjWs94VyEHrpn9aykht9AxvuIM3+4gpaPyS076SQ6/O6Fdjqva/oA/82RI4LcAASdTAR6nwtV95YrEQvFpNYb9I4DGotueUVwE87I6i3a3YU1JVZCRmbxXvmPmuxl70eFzBbur/5v9NMUPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kEalPNBy9m5OobxLlrUrXEL0KmZTP2eUfEkay8jGIw=;
 b=2ssCrZFKD25wCwJniVhE6G58ehIDkykIbXzDKfen3DF6njyIGhRZgLQ0o0sITc0hH5gX6zSRRHGY9YuNzi2I619L9gly215eed2yFsD7SDmMAHPi7yKY2dsXQhTMyarK4l9bvpCfAenForu+vQVVlUA2yyDDiwZ52B96Zzz9ae8=
Received: from BY5PR20CA0008.namprd20.prod.outlook.com (2603:10b6:a03:1f4::21)
 by IA1PR12MB6482.namprd12.prod.outlook.com (2603:10b6:208:3a9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:34:24 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::18) by BY5PR20CA0008.outlook.office365.com
 (2603:10b6:a03:1f4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:34:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 26/31] drm/amdgpu: fix active rb and cu number for gfx12
Date: Mon, 29 Apr 2024 10:33:34 -0400
Message-ID: <20240429143339.3450256-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143339.3450256-1-alexander.deucher@amd.com>
References: <20240429143339.3450256-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|IA1PR12MB6482:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2e73bf-4fcd-4a4b-7da9-08dc6859774d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400014|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TRKjLxjGeMAO8VzUt7IK/0+C0lY/Q4C1am4BmZ/YVAcQcz+4nU1VpMi2FRVH?=
 =?us-ascii?Q?/lKXF8GiYhIQ1rf8ndqWPNLbpMJWHIQfpgyOtQl4cMDOvRUUu/YpVrwC9ngu?=
 =?us-ascii?Q?u0h73W+rmZmze70p2Xa/TqSwl/bd8YLbOHuVCcd7zP2v5vEbxYcNBt69r3cp?=
 =?us-ascii?Q?uFLdpNqk04E4NNLFsh6+yRYsUX5dzVN3mTw8ukOGbh4j9utCbaJNA/Mg/xsV?=
 =?us-ascii?Q?1gYHoy6z0a60InGFdzy396q7KKksksGkfIkmdZTWzpFJwgMzxCvceDg8X2Yn?=
 =?us-ascii?Q?O11fQ4G3MclCHNi53tZCfYqupcPg9nO0hFlZQnI/aaMOwKdZWzjVAJ+acV4q?=
 =?us-ascii?Q?wqQggon9SLzViyw3PUSW7IOKJM87iXAZLVIdjkYm3FLFGAi0fwVpC8tuSGM4?=
 =?us-ascii?Q?tn3MyKuTE1bIjKwuCUkf08oeTWlZ2ig1D6oem+qr7hlxujfq2rT3cqjf5dwD?=
 =?us-ascii?Q?lbQsyO8tN9nkZI2kJlZU6YR6xuC7NBLz33UOga5jgzj2X0x9q5DVODFTMBZz?=
 =?us-ascii?Q?ERnvvo+kI0H8zj/RHKS9y8I8hXmpCGdyVts9saphOUxc6ePg6VUF6DoPRsdX?=
 =?us-ascii?Q?AKQ/X17bEIhj9ulPdSSoBCTMLxRB+Pt57V99IE0SuknjIl55JUnwXCJJ6XHJ?=
 =?us-ascii?Q?gYuSD1Rkmi0IygHvcoO+c4crseYqAZxJixiqm+3ea69EZQOkm2gruRM5i2tn?=
 =?us-ascii?Q?s2Q/Gd5DKDVY2b1rapo9piNL+Yr0gMS+BEXn7Twps9rBlYtanhYZ/0OCkkjn?=
 =?us-ascii?Q?7srwidYjufotT+HVRB/MzfSK/D04Yy0M2abCIX+8IQ6lJV/giTlch66saG0w?=
 =?us-ascii?Q?i4KLqrIzUfY2nH9VEk9m0K/mVB2proLczbd9CMWFirxTlB1um28cFThrQ57G?=
 =?us-ascii?Q?EtOGcJVwbStZxHMaw1FYIq2IjcrXpiHvzJ065BYGE9n31QiyDGG5VpO36AiL?=
 =?us-ascii?Q?Ju02bDJXZdCjh3e63g00pj8hj+rRoGxTEqybhMe3RdxeHDcUS3wYVgYOIhIj?=
 =?us-ascii?Q?k4ac+hlPnhXNLT2rEG30p8aK5g1f4npZR0j3W3Tykf4BQuBz9THO6b8P0aDj?=
 =?us-ascii?Q?cWpMeZc/4KAp1uMQI9oILE0doOo6wqMECi1G4VepNcKnBAj47298rpbHrL3s?=
 =?us-ascii?Q?yj29IRWUfcoRiBJDMX9JBt5VfXlQEKfjMf4+t2R1ot18agEIOzhtDcFgp6mp?=
 =?us-ascii?Q?UoKDiz5ahL5dfKVAV2axBRsCQ4Gwrf7EB/C3yrzUb7RT7XTZr7sA4CP5bM0n?=
 =?us-ascii?Q?v81+hxXy3/pcZidxCHdfY6eEil//VyMsXPhxpBS4D0bkQDX8GKSP5L7W+iO3?=
 =?us-ascii?Q?GGJLfVN84relrayvdbUWNla2JssCtPw/iRKeTcaW3zpRjqCW4xPmHfNlfEDS?=
 =?us-ascii?Q?xyxR3AVaD+DoRW/vecgWzMWoWNxA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:24.1462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2e73bf-4fcd-4a4b-7da9-08dc6859774d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6482
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

From: Likun Gao <Likun.Gao@amd.com>

Correct the algorithm of active CU and RB to bypass
the disabled SA for gfx12.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 81 +++++++++++++++++---------
 1 file changed, 55 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 882e00234e33a..6a2af12b5e29d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1354,44 +1354,70 @@ static void gfx_v12_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
 	WREG32_SOC15(GC, 0, regGRBM_GFX_INDEX, data);
 }
 
-static u32 gfx_v12_0_get_rb_active_bitmap(struct amdgpu_device *adev)
+static u32 gfx_v12_0_get_sa_active_bitmap(struct amdgpu_device *adev)
 {
-	u32 data, mask;
+	u32 gc_disabled_sa_mask, gc_user_disabled_sa_mask, sa_mask;
 
-	data = RREG32_SOC15(GC, 0, regCC_RB_BACKEND_DISABLE);
-	data |= RREG32_SOC15(GC, 0, regGC_USER_RB_BACKEND_DISABLE);
+	gc_disabled_sa_mask = RREG32_SOC15(GC, 0, regGRBM_CC_GC_SA_UNIT_DISABLE);
+	gc_disabled_sa_mask = REG_GET_FIELD(gc_disabled_sa_mask,
+					    GRBM_CC_GC_SA_UNIT_DISABLE,
+					    SA_DISABLE);
+	gc_user_disabled_sa_mask = RREG32_SOC15(GC, 0, regGRBM_GC_USER_SA_UNIT_DISABLE);
+	gc_user_disabled_sa_mask = REG_GET_FIELD(gc_user_disabled_sa_mask,
+						 GRBM_GC_USER_SA_UNIT_DISABLE,
+						 SA_DISABLE);
+	sa_mask = amdgpu_gfx_create_bitmask(adev->gfx.config.max_sh_per_se *
+					    adev->gfx.config.max_shader_engines);
 
-	data &= CC_RB_BACKEND_DISABLE__BACKEND_DISABLE_MASK;
-	data >>= GC_USER_RB_BACKEND_DISABLE__BACKEND_DISABLE__SHIFT;
+	return sa_mask & (~(gc_disabled_sa_mask | gc_user_disabled_sa_mask));
+}
 
-	mask = amdgpu_gfx_create_bitmask(adev->gfx.config.max_backends_per_se /
-					 adev->gfx.config.max_sh_per_se);
+static u32 gfx_v12_0_get_rb_active_bitmap(struct amdgpu_device *adev)
+{
+	u32 gc_disabled_rb_mask, gc_user_disabled_rb_mask;
+	u32 rb_mask;
 
-	return (~data) & mask;
+	gc_disabled_rb_mask = RREG32_SOC15(GC, 0, regCC_RB_BACKEND_DISABLE);
+	gc_disabled_rb_mask = REG_GET_FIELD(gc_disabled_rb_mask,
+					    CC_RB_BACKEND_DISABLE,
+					    BACKEND_DISABLE);
+	gc_user_disabled_rb_mask = RREG32_SOC15(GC, 0, regGC_USER_RB_BACKEND_DISABLE);
+	gc_user_disabled_rb_mask = REG_GET_FIELD(gc_user_disabled_rb_mask,
+						 GC_USER_RB_BACKEND_DISABLE,
+						 BACKEND_DISABLE);
+	rb_mask = amdgpu_gfx_create_bitmask(adev->gfx.config.max_backends_per_se *
+					    adev->gfx.config.max_shader_engines);
+
+	return rb_mask & (~(gc_disabled_rb_mask | gc_user_disabled_rb_mask));
 }
 
 static void gfx_v12_0_setup_rb(struct amdgpu_device *adev)
 {
-	int i, j;
-	u32 data;
-	u32 active_rbs = 0;
-	u32 rb_bitmap_width_per_sh = adev->gfx.config.max_backends_per_se /
-				     adev->gfx.config.max_sh_per_se;
+	u32 rb_bitmap_width_per_sa;
+	u32 max_sa;
+	u32 active_sa_bitmap;
+	u32 global_active_rb_bitmap;
+	u32 active_rb_bitmap = 0;
+	u32 i;
 
-	mutex_lock(&adev->grbm_idx_mutex);
-	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
-		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
-			gfx_v12_0_select_se_sh(adev, i, j, 0xffffffff, 0);
-			data = gfx_v12_0_get_rb_active_bitmap(adev);
-			active_rbs |= data << ((i * adev->gfx.config.max_sh_per_se + j) *
-					       rb_bitmap_width_per_sh);
-		}
+	/* query sa bitmap from SA_UNIT_DISABLE registers */
+	active_sa_bitmap = gfx_v12_0_get_sa_active_bitmap(adev);
+	/* query rb bitmap from RB_BACKEND_DISABLE registers */
+	global_active_rb_bitmap = gfx_v12_0_get_rb_active_bitmap(adev);
+
+	/* generate active rb bitmap according to active sa bitmap */
+	max_sa = adev->gfx.config.max_shader_engines *
+		 adev->gfx.config.max_sh_per_se;
+	rb_bitmap_width_per_sa = adev->gfx.config.max_backends_per_se /
+				 adev->gfx.config.max_sh_per_se;
+	for (i = 0; i < max_sa; i++) {
+		if (active_sa_bitmap & (1 << i))
+			active_rb_bitmap |= (0x3 << (i * rb_bitmap_width_per_sa));
 	}
-	gfx_v12_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
-	mutex_unlock(&adev->grbm_idx_mutex);
 
-	adev->gfx.config.backend_enable_mask = active_rbs;
-	adev->gfx.config.num_rbs = hweight32(active_rbs);
+	active_rb_bitmap |= global_active_rb_bitmap;
+	adev->gfx.config.backend_enable_mask = active_rb_bitmap;
+	adev->gfx.config.num_rbs = hweight32(active_rb_bitmap);
 }
 
 #define LDS_APP_BASE           0x1
@@ -4832,6 +4858,9 @@ static int gfx_v12_0_get_cu_info(struct amdgpu_device *adev,
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
+			bitmap = i * adev->gfx.config.max_sh_per_se + j;
+			if (!((gfx_v12_0_get_sa_active_bitmap(adev) >> bitmap) & 1))
+				continue;
 			mask = 1;
 			counter = 0;
 			gfx_v12_0_select_se_sh(adev, i, j, 0xffffffff, 0);
-- 
2.44.0

