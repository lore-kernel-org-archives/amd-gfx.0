Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7414F606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 23:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CjlBs49M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 187F610F8B1;
	Tue, 27 Oct 2026 23:25:41 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5DCC10F8B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 23:25:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSIuGbwsRHzF/EVF/jDWqx7Ru+rlyuHP8EWkngVDB321hLlBqmcsaPas16PfppjKe6C8cEcwTZLvc1fDH2uwCNMeKXO7G1qi86B9X8AQnmkm7Ema8k5EkXNZEQ5jMQDgS9z9jxbBdkT17E3LGeY1+e9pxFOmbmJRNpTE2OxyLvXl92+zti58gFji+Itf0VY1nFSWb+L75fxkuhGNyzPXEGxomAzABAWtHPi/W0DJlNEIMd3ik0nKAQgPhUGVGP77w8Y+z4OpuYFUT/4D5WoHP/vXFuFoxcXJ2gvfKpW501uNMbw8lfaem6OjJ7SV6lIffP02Abth8HAHsx+V65i1sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngoImklxCFAWciy3BrkMn1RVwIPF3SYQfM6OZtS3omw=;
 b=wm3HvlD9Y6mZ1roTGE1B5pyZzzHh0HbN1jyBJXJ8Pp6OYWUO8T/sNMBNztt60ou48mKNC6v4Glm80Uf64WgTuExfwl4GFyBhqtLhJ9PXZMCVEWMNiP7IQwEq13Ixn/xEd1ZJAxiBgq7k4gPlUjsfJuFio0jr2BDKMmFaX5/6Pn3DoKT7xsda3XmJ7ynjF0euYPtEzG5ln9oxUgT1YAUuld3xbNpne5D8dWfom+K6C3CNx9+W+988/h/z3xITpI3L6TZ4Dj7pGdgak7du2/VL/IYnjQRFNge5nuh3FDy+vPG0Ke7whtHctuBaA/nkpvCm3mPE5HSeiedeM4H1bTjfEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngoImklxCFAWciy3BrkMn1RVwIPF3SYQfM6OZtS3omw=;
 b=CjlBs49MmJnR3b5CjQciC1YvB/+Tazk5N2qH98my2Sh+qoQIbhqMSeq6oOTXDqXXyLOB6Kso6YBiMwn4pm6s39U+M4cPM7oQxKJ7y6EXRJeoht0CRSzrKlDOQRx0fG4mLaEpqqk3K+whJiZJFYwiB7gt54kgZKvRg+Nw15guVPs=
Received: from CH3P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::32)
 by DS0PR12MB8575.namprd12.prod.outlook.com (2603:10b6:8:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 23:25:32 +0000
Received: from CH01EPF000BE946.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::97) by CH3P221CA0006.outlook.office365.com
 (2603:10b6:610:1e7::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 27 Oct 2026 23:25:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE946.mail.protection.outlook.com (10.167.244.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:25:31 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:25:29 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 23/28] drm/amd/display: Add more color KUnit tests
Date: Tue, 27 Oct 2026 17:17:19 -0600
Message-ID: <20261027232005.2879750-24-alex.hung@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027232005.2879750-1-alex.hung@amd.com>
References: <20261027232005.2879750-1-alex.hung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE946:EE_|DS0PR12MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c08e618-f935-4330-6d4e-08df34819840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|22082099003|18002099003|10067099003|3023799007|56012099006|11063799006|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: WBisWLc3oMkY2lbXsKWoiqY29iWR2whTp7ba9f5sgTQPuAvNihb9PI+GCG9DFK7SCrP8VzO728iXMQCmEmWReNRfIs8oIX5N8D/LZbaD4PBFIDKDr5e9M2DU8c6P9SDiZ/ojPTBm6Dk5YOzXXhJkxK8vRJIXNfZ5EMKn2vw3fG+VrxhLy9koY4JmfWF8fyuBcxtQwdNOa1kzZhp5YAiCo171MTrUu/LKked8gQC0Dd2bgKTWGcjcNnJLYhL3A7mv2r4lRcXJ8scUR7VKWfSPd8d0xN8d58rk45pk6svr2aYdT6M/H7cF5DorPcsNQJ9TZAqFX11HbR1exdTFN28dPdjdlnQsv/gLyNzv31dVydbVi0UnCxtIxh+xNIjm2kr8l8Je5uuiF9aneDgj/9IWcb+bXpnfQorvlslx/2XaHz9mtLcXdnA5BDXbqG1UW9em6TqJ90NKnDf3Fxfe8b37wUziiRMB92xPOrEYjEjPTBKgOeA0MWhWJYoKNbXArklrlhQ0G2iWOJubshMbPNxa0nb/LdlEKfg51jjDlz6XewaG8FomFGxJm+jgikKc/YmiAlkIH3COQZ8LhczdkEu6e/M+rNj7tO+GMdafl7NcCt8dCKmLJFsVYfDpuuwOBI8rSsqS35qm8EGlnvuixA9GIe94MTa1t09ZUk+7AnT+Mg9hnXb7whOwHSspVDqjHSbTJ5MZthPusfsIeDi0qbDYsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(3023799007)(56012099006)(11063799006)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MBOhmYNwJNKF/kjb0ZPeVhMWAg9Qs0B8s5H1uAOuwbpBPzf3NtPN61H8wCcHsbic7gcUgq7vTeVjj6jaiqPzf3ipgeGaD1gjV9cIOXjJ3RzprD7tP3L3PuCgMvzWVFDw9aIZJLf4VMrv0f0dp+GZjEe1HlV/NHV7xZkfc2lYm62QI8yW0Hbj/3rPZDoYNZaUS8SUZ/PzNinbCOKykIqKl+ruLrvVWTqt7E0t6Ur9Ga9f9G4UCZ9bG95WyduBhGn7L8LVNKFo5y1vU3l4IOWZRlhw5uhIZSt/CFUX50ByT/E+nSfSONTp0c8KS0XUC4yBRqrQ56clMtpgi6pbzNhBEE9PUfMKNe9e9ViOO5kwlJ8xlUP1KMoBz/fQMegtg7BniwA92QBjzDRulXxpAvEM96Bm7oB+QyP3HcQKmmx1vTvyNbgZmFYwrmatd0H6R4RE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:25:31.9119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c08e618-f935-4330-6d4e-08df34819840
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE946.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8575
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

[WHAT]
Add KUnit tests for amdgpu_dm_color.c:
- __set_output_tf(): a user LUT with a non-linear (sRGB) transfer
  function, which takes the regamma path.
- amdgpu_dm_update_plane_color_mgmt(): a CRTC degamma LUT without the
  legacy sRGB regamma, which maps to a linear plane input TF.
- amdgpu_dm_update_plane_color_mgmt(): a wrongly sized plane degamma
  LUT, which is rejected by __set_dm_plane_degamma() and leaves the
  degamma block in bypass.

[HOW]
Extend dm_test_set_transfer_funcs_with_luts with an sRGB call to
__set_output_tf(). Re-run the CRTC degamma LUT test with
cm_is_degamma_srgb cleared and expect TRANSFER_FUNCTION_LINEAR. Call
the plane degamma LUT test once with a 128-entry LUT before the valid
one and expect TF_TYPE_BYPASS.

Cc: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c     | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
index c07661ef56c1..7ad8c56cbcf3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
@@ -1493,6 +1493,11 @@ static void dm_test_set_transfer_funcs_with_luts(struct kunit *test)
 			__set_output_tf(tf, lut, MAX_COLOR_LUT_ENTRIES, false),
 			0);
 
+	memset(tf, 0, sizeof(*tf));
+	tf->type = TF_TYPE_DISTRIBUTED_POINTS;
+	tf->tf = TRANSFER_FUNCTION_SRGB;
+	KUNIT_EXPECT_EQ(test, __set_output_tf(tf, lut, MAX_COLOR_LUT_ENTRIES, false), 0);
+
 	memset(tf, 0, sizeof(*tf));
 	tf->type = TF_TYPE_DISTRIBUTED_POINTS;
 	tf->tf = TRANSFER_FUNCTION_LINEAR;
@@ -2266,6 +2271,13 @@ static void dm_test_update_plane_color_mgmt_maps_crtc_degamma_lut(struct kunit *
 			(int)TF_TYPE_DISTRIBUTED_POINTS);
 	KUNIT_EXPECT_EQ(test, (int)f.dc_plane_state->in_transfer_func.tf,
 			(int)TRANSFER_FUNCTION_SRGB);
+
+	/* Without legacy sRGB regamma the CRTC LUT applies on a linear base. */
+	f.crtc_state->cm_is_degamma_srgb = false;
+	ret = amdgpu_dm_update_plane_color_mgmt(f.crtc_state, plane_state, f.dc_plane_state);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, (int)f.dc_plane_state->in_transfer_func.tf,
+			(int)TRANSFER_FUNCTION_LINEAR);
 }
 
 /**
@@ -2299,6 +2311,12 @@ static void dm_test_update_plane_color_mgmt_plane_degamma_lut(struct kunit *test
 	struct drm_color_lut *lut;
 	int ret;
 
+	/* A wrongly sized plane LUT is ignored and the DGM stays bypassed. */
+	f.dm_plane_state->degamma_lut = dm_test_make_lut_blob(test, 128);
+	ret = amdgpu_dm_update_plane_color_mgmt(f.crtc_state, plane_state, f.dc_plane_state);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, (int)f.dc_plane_state->in_transfer_func.type, (int)TF_TYPE_BYPASS);
+
 	f.dm_plane_state->degamma_lut =
 		dm_test_make_lut_blob(test, MAX_COLOR_LUT_ENTRIES);
 	lut = f.dm_plane_state->degamma_lut->data;
-- 
2.53.0

