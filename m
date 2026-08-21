Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19750C5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EE7C10F369;
	Fri, 21 Aug 2026 16:10:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cK9k4KxZ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43B4C10F367
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:10:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHVFb2LEJ2DHXfg2cMmka7WJAuJRRe5KTWR0KShTEotfPEMf+3G2JT84PSuPf8cuhyZqJ88dpVEj9zDogKITBqyDEata9QKq+7pzFr5gKbVOSevMQkeAJLctwJfQy0HxY7PlmIXgEJyZIdn/80MvHtMSuU2zCdDQhkPo2IoEimEnB56XWkadhd+/zqv+dzFVkBV4rw0OkYIFk2DtDikuehWQn3OqjiW2+5Rf09Yvwu8A3rds3S8Kd/pLTb4C6Wnxn1YDbvzh2hIqCSuouOj6xi8OjNpMX8E5qyN7JEXsrywuMcHG4KT21xrq1gvcSptcn3pCx6KHN8q6jiEEXDqC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1j4TObqVrJe7TJZK634psLnOmAxgrYfjXNhXpeCeNI=;
 b=aderBOhaupYGV7YN/9h64eK5yUHGDm/L9woIiEvM7zgLevj/soyGRjARUqlgveiJ6qyUV9IHkyDXR8Msj2YFc0KIIKN4hKctHOjuu0NuS91GmzT6RFBXuo53gu8yiaO5DzYqDXlQLjWpEeOxO1x8DaGIJ1W4Tzz9X4LDLfYprGpjtMejj5SYj9Z0R05R8w2X2Ra5BiFdUE3o94bYb7xkW0VrOwnHq88VUyr1Md/ru1zqMgm6UBceDm4q+m3rtbbr3wvISiioyu0+DuXcMYCSlPwtSdHNP92XPN3z1XE9BRTMMMBjEFHK3aQz6Lj8AVP1EGVZT4gMX2yoZQZ+6A/ICA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1j4TObqVrJe7TJZK634psLnOmAxgrYfjXNhXpeCeNI=;
 b=cK9k4KxZ094ccXI9jUGo9tci/CYvzUdcCdmLQcw9zIAgv1wVVs3y31w9ETZs6XH7G/qqJSD2rGQEsOH94tcovb+1lLgRb1ghQO8+HyzIMR/Cwuou8DBbMsI0FrTpeVaJ4u+4ReNpzItrM6aXFShcfMa6booFfwHlabO9uScaRoQ=
Received: from SA1P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::18)
 by PH0PR12MB8176.namprd12.prod.outlook.com (2603:10b6:510:290::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Fri, 21 Aug
 2026 16:10:16 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:22c:cafe::65) by SA1P222CA0018.outlook.office365.com
 (2603:10b6:806:22c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:10:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:10:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:10:14 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:10:14 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:10:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/13] drm/amdgpu: clean up vm flush func for gc v12_1
Date: Fri, 21 Aug 2026 12:09:53 -0400
Message-ID: <20260821160958.753063-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160958.753063-1-alexander.deucher@amd.com>
References: <20260821160958.753063-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|PH0PR12MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 4502ae02-31fa-4fc0-0813-08deff9eb019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: X7ITMYr/sRbYKfOFiPpsdKakNahPAJubdo2oPk8LL0m6hoGBVyeWEdzc+OeI17+nvEqtwQtY3wGZF1XANzlJV5SESb3BxBp2OSOpUs2t/IX/VwYO3nz3t819H8/GyH9Q+CupWRU0Wf1gZSOiOv8hsxcM7QQJxCcF4VZh6LBbeImtaoIXJBYTf9xOwofEcG+D7Y+Umek3ULoXR9PHJS+XEqNo8IAGihq7gHtG/AviHtJwN4j+hZfUXe7FBQL+nRDn3OnHIfouXpemZTFfHUdAtnxNJWV6lehpf8B72kmFj5eWgdqxEpZh4WryYL0joePfQ/l0lIHgTELur3aStE9rBY1rbBpd+s5/F5P8r1v7QksBbINtK1ZWwpmyiW9st3ShScpsadNP+aoogBmTHlhNaH4Re0Y+uDVPHrHd/v9IvAZnGpMw4WA/lPjp1dWHQa8Y47NNbykC76/CBPlEOFybrBi8A/X0OvifZ3ljWk+puUpkjruPABNnVXNlVka/0LkU9DzA0AuUAejWTvnxbtszciE5a+m2zwt1nM6zbs7HxGXXrs2SMXXdbdcfKAFHUOcpZk2BuhZVDGHpLtC5oD1wvsUOEnGuZVTpinLV5na6UM00brVOrk2qmjiGAkhnGF6DJJAuQ1TMlwMfBwNlsu+Qb+2Q2GnIBySKVe3VQd100etKc3GkYaI3xF7+d9OQ+AZDIC+9bEsDV3JHEOG9oi8I4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0TGIXkPnYwMtyvSoJbqRT/IOveZtlaBxt7XrzmBWUfwmeVc8eFfkEQm9digzhP4rDeBvWIK6jcRZvXGIy+0hoWwxRMsbGEmEIQG9OvZf2AIbw2ihJ5y7CJuo69EE12068ngQJp6kG/pe6Za35P6YuMorD8YRVZ8Ik/95AzuzvIjNOCHKPCnSugRWiXejcz8xwjnGx49MZmuDOonJ39XGJxfyTm5siL2lJKWxw4GagDlDUu2J0JEAQGVO4mgCtuUOQHu79D4J7HZy5F/DE3S820BMYt+/3oo7XDXY7Ty/ngDjtRDEf/irw5kNP5SgIbiSt1OLVi1d2boLCrDn9ZUoORsZXGnMx1NU83L59d+DGLU9VlPQXWsCC5+t4UXsOw6t/NC3c7pO3Ric65+vOFZnUOhZs5U55SApNJS5cKvgD/WRua7nhAjvJtF9ncow7f/U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:10:15.2066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4502ae02-31fa-4fc0-0813-08deff9eb019
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8176
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

Clean up gfx_v12_1_ring_emit_vm_flush function, since
PFP_SYNC_ME cmd not support on gc v12_1, and it does
not have gfx ring.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 55e21359a8129..4f34a963acf34 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -3699,11 +3699,6 @@ static void gfx_v12_1_ring_emit_vm_flush(struct amdgpu_ring *ring,
 	amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
 
 	/* compute doesn't have PFP */
-	if (ring->funcs->type == AMDGPU_RING_TYPE_GFX) {
-		/* sync PFP to ME, otherwise we might get invalid PFP reads */
-		amdgpu_ring_write(ring, PACKET3(PACKET3_PFP_SYNC_ME, 0));
-		amdgpu_ring_write(ring, 0x0);
-	}
 }
 
 static void gfx_v12_1_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
-- 
2.55.0

