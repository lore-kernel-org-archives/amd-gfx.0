Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E8F606A328
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 00:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QUuSF9WL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06C4610FFCA;
	Thu,  5 Nov 2026 00:06:36 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012025.outbound.protection.outlook.com [40.107.209.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9500110FFCA
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 00:06:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwKSVAF9U9TiDyLFbYl55CDIQLgKhRNabTEulRvwskVgFaSkkp1Lo8VTzXgATTqFrFyUU+rJTrL9bPhRi0bymQgNfUNGqKl8weR556Yov6DhATWxgttyj3m/MUsR59K8Z9MNNObf8ea2w/3JSLLpGCfbA7u2pb5me6s+yPa/fL7/tC4Bk1D1H7Zcavl3nMfhqdPfWa0M6GhCl1TLwNAusGsgyfqTP8NNwKjT1CuaMo+4OmMJYGb7vfwKB9tqdhaaD68OI7aeQP7qyywxjDcuLoi+5c7va819k1DnJk7Hs/0DRh1DyGg/quD3EJtSoDY7ROVVTVVZUI9XnXGpIyaTnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9YSkprATWQKPU23cA1U2hBno46CvfPV48ADdxz9OtQ=;
 b=QSeEQJjnifsmFCK91dRlBies7sm2WCTYDZoz24QssdpGs1KktGPr/qQ2VlZkO+Fo6JJSZHnKN1SppwX+wyIEXvAKA5Xmt2cwg/6gMpGzs+x6GhrPgKOE7CT1AKF3qYpVQfzkDyojycAsiuY0wzbE00tS0xsCDYvCj5vzOFhnkJaNawXy834gzpnDPzExStHQSC/4s2suk/lFWxy3UBobIbz3KFKL+SSJIyGP0WMGTE4pokCDMqxSm5ATpUrStxAc2cF66vdWRNciEL7T6iPbjjZts5869Xo+xeTWkFtIISgcY5ptquL3RP7sBHAekwPZur9ItkZJ3qt50lhQtsANWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9YSkprATWQKPU23cA1U2hBno46CvfPV48ADdxz9OtQ=;
 b=QUuSF9WLmWPAClQeZ0r0BLGxPek/F8gXEF0x4s8VOyxtjRya2o/2BD0yyLIaHiNsPcab1IO9BLPxkX1Pz6xxTAaWW2WS1T+dZBr87AOVd3AP/U+SmbH0ASNkj4S4LY7LevZN6H79PDh7gBEz8NXJMOoNmtdVsl3xJrlKNCQrmxk=
Received: from PH8P220CA0065.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:2d9::28)
 by SA3PR12MB368938.namprd12.prod.outlook.com (2603:10b6:806:531::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 00:06:26 +0000
Received: from CY4PEPF000392DD.namprd03.prod.outlook.com
 (2603:10b6:510:2d9:cafe::d) by PH8P220CA0065.outlook.office365.com
 (2603:10b6:510:2d9::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Thu, 5
 Nov 2026 00:06:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF000392DD.mail.protection.outlook.com (10.167.247.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 00:06:25 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 18:06:25 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 4 Nov 2026 18:06:20 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <frank.min@amd.com>,
 <Hawking.Zhang@amd.com>
CC: Frank Min <Frank.Min@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add helper function to get hdp base addr
Date: Wed, 4 Nov 2026 19:06:13 -0500
Message-ID: <20261105000613.3850438-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DD:EE_|SA3PR12MB368938:EE_
X-MS-Office365-Filtering-Correlation-Id: eb035da7-eb78-434b-fc9e-08df3ad0a240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|11063799006|56012099006|261021121427099003|261009223027099003|261009221227099003|261009221727099003|261009220027099003|261009223327099003|261102123227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: K1+KPz0d9ox0UZ/iv2CbijuoL3eMmLmsTYC//LiGhawdG64bM4HRAcVfVfp8peqIk/wZNpoDFr1RxYacQxUJSCY/Vd6v0xttXvyQkm98GrVUWbSVL1q3KAiW+ZVON7qaDhSmkEWuBhJ1p8AtocKV8Ro+bC6BS/RwJRFEw6ZTX54a90afKm1qHQNpnt1SPX5T8pOTEd1tDSqlkJy8B8/wu08xYrSsKYZwW0lRn7S6LXxLpiRAzngCQzBIdRH729Bw1M0+EK5KChI5bi6yAjlGVBTZY2s642riSSOsxKYGQzBPp8qnINS620vtLzFgPNyZCvn2s9JGznVWJ+lTYxW0tkm4i3Z+su37z4ushszP1aUSKBCBYRYh4QGS1TaYZmmoPg+W1h6Abuut/mj+tuNrYGirI6K/IHMBep/XDzTQLZTvl6QTvmzje9xwRscYR2004SECJYB1+NoeozAFMwQBahuEt4xvzGMN7ia2bacOq499V5p9iksPg9HXvLeVY8EXjfp8KMtks6WJAypVByPZBUqSD9GbLf6vyFutwR0qry0jvFkF0xMIs0lluxd9aGUDUNFBUdWlqvYgLm0MMW918At9jJdL3/VNBFWiqGBtfHZtfo4bwXcVOhXmkci4VHnGXTXmD5rO2iw+NRnlqXMtCSwkukSBlUFY7NtuAI7qlHxx6K+O82zIgkm+al/Am1U4QE1Qx/LfH7WZbyjSY/5Zqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261009221227099003)(261009221727099003)(261009220027099003)(261009223327099003)(261102123227099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AqcQvYTQzunyH9oAFIIJPxoz6nGPyluG07GHKE6PVver94nKGqpwPMt1NEPoD9bqgsuRqOhEg9hy7kFd/3xZ72DQXVdy7VsRdjlLEA7fCSYMYXxOzHxX0Kr0X+xywm/bCXhdGNteh77vBrwlFp721OFYPKQzZ/u0UloROfows7sBBs9y+Jm46OAdUnQ6a2EDz7+Eqfp+yuhaatD++FABL7xvNLudUzvJWVgnsOIRw4uo7puofAV7AHKPiEDoNhc/UFcqO3DqJC+8jsY2BuXYL2enxyVAJFMmPHKarviHtrXieih8rthX/J7mXzZcjd2gJH9AM/lB+pBHMigXyRkrx6obMGaY/tfPqmpsd2VHNM7q941j2XKthLy/LjotUGd50R4VwrhcMUNW7T47zMbBfzV2jV6EfwR35dJhlD2b7na5erWibRpUycMJcgcMSAvw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 00:06:25.9024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb035da7-eb78-434b-fc9e-08df3ad0a240
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392DD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB368938
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Min <Frank.Min@amd.com>

Add helper function to get hdp base addr.

v2: drop debug message

Signed-off-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h |  1 +
 drivers/gpu/drm/amd/amdgpu/hdp_v8_0.c   | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
index d9f488fa76b94..efd6414bbe12e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -35,6 +35,7 @@ struct amdgpu_hdp_funcs {
 	void (*update_clock_gating)(struct amdgpu_device *adev, bool enable);
 	void (*get_clock_gating_state)(struct amdgpu_device *adev, u64 *flags);
 	void (*init_registers)(struct amdgpu_device *adev);
+	u64 (*get_hdp_base)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_hdp {
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v8_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v8_0.c
index 63afdb5de3d4f..36e2bfbe91395 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v8_0.c
@@ -125,8 +125,21 @@ static void hdp_v8_0_get_clockgating_state(struct amdgpu_device *adev,
 		*flags |= AMD_CG_SUPPORT_HDP_SD;
 }
 
+static u64 hdp_v8_0_get_hdp_base(struct amdgpu_device *adev)
+{
+	u32 hdp_base_hi, hdp_base_lo;
+	u64 hdp_base;
+
+	hdp_base_hi = RREG32_SOC15(HDP, 0, regHDP_NONSURFACE_BASE_HI);
+	hdp_base_lo = RREG32_SOC15(HDP, 0, regHDP_NONSURFACE_BASE);
+	hdp_base = ((u64)hdp_base_hi << 40) | ((u64)hdp_base_lo << 8);
+
+	return hdp_base;
+}
+
 const struct amdgpu_hdp_funcs hdp_v8_0_funcs = {
 	.flush_hdp = amdgpu_hdp_generic_flush,
 	.update_clock_gating = hdp_v8_0_update_clock_gating,
 	.get_clock_gating_state = hdp_v8_0_get_clockgating_state,
+	.get_hdp_base = hdp_v8_0_get_hdp_base,
 };
-- 
2.56.0

