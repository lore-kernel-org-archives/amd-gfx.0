Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8754DFF885E
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 08:36:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2450210E60A;
	Mon, 27 Apr 2026 08:36:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2C0guoTR";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010060.outbound.protection.outlook.com [52.101.61.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A20DA10E604
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 08:35:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+XEDaHjx4UTpZhBOebOWviImACBscNN9HmqryJym1m9Xf/+8xO/1oYaoIyzhgre+HneaP0Ly5QFjEE445QFx2R7dCquqHpNgt/EpcS/q7n+piPjARlas5iAq4Y0EkMoL5UDp61VKADeFQst4fSj0GKK4EGdKees/XKPXUMyw9KK6N9KwN6U4n5mTekesTCRqZUAJdTSKbYa0imF4j9Zwx6jZDhjL9FaZ+8jCqr942GB5c66Xu/ouH1PAcMwgkpRICqdl8pDAWbDyxfZjeKQFGnDylQcd4RC62ZmBdNOIWSVcwbtknMKmMraavTf3mHatVRhYDqmhjDNl1uFeG414w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7hK3awj3I0SWJGfZinuGUa3e7XfA2TTKMrAHHwY7tY=;
 b=pfeMhEVjlxmNroRkFwFNWV4V58YxHMWDrhofMDV5xcU88GwvV6zqI+YJgOwFHWw9Np13/+nerPB2WUOAWVJi6H8bRf4ID2wuhjDJ+ntJM60ixx4erV+Cel8FME+IXBUX6gVjoz36kJQMyctsuAmea8LAuCO18trZxSYdaIeUPIcfNBkb/krj1bc5of6KK3L7yBgQUI2rHWvcydechDwbj7VlMTWhe1QyM4g/Kixmbt85VSUB8JRVUsDbs2X7oNP1yT8+7B37pKQyZbFEGMuAga+JygJPhHQQNpG9aangzbe0+N3usMPQO3un2YmszSDupoD1mlIQ894uypod/sJFkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7hK3awj3I0SWJGfZinuGUa3e7XfA2TTKMrAHHwY7tY=;
 b=2C0guoTRN47DdwT4cJ23nuHHYvZdbQqQ7xWotGDcFzSqsTf41RCXRSg/mYv54QCEZ3bXJ8IEXgJho3t5efJk3SulUAx++xHa0dAseNhljccnz1jGJABxMpj1U5SarviI/Y6yQ4A5CPFZBVHli0DJKB2U1SwP/9nnxgUv6ahWvSU=
Received: from CH5PR05CA0022.namprd05.prod.outlook.com (2603:10b6:610:1f0::14)
 by DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 08:35:54 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::89) by CH5PR05CA0022.outlook.office365.com
 (2603:10b6:610:1f0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 08:35:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 08:35:54 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 03:35:53 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 27 Apr 2026 03:35:52 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>
Subject: [PATCH v2 03/11] drm/amdgpu/gem: only enforce amdgpu_bo access checks
 on amdgpu_bo objects
Date: Mon, 27 Apr 2026 16:34:29 +0800
Message-ID: <20260427083543.1328533-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260427083543.1328533-1-Jesse.Zhang@amd.com>
References: <20260427083543.1328533-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|DS7PR12MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 381ad16e-0062-4e4b-9443-08dea437ff39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: UVb3Q4amZz2B4llqqf9i+6HfBFwXpoOfbC7JcmkbOUKJYXLqxXvAEQaUMhYvlFPOoA5jBcRpxWZGyD8nNezSCtECRwkM2UOAd1ypVnCChEDXM27aH+p2VR88jQ0bxHTWsFQmB1Xmm8y17+HaWY3RVLivhl8y4pJAXkvHl/Gv5XOGFqkCjVn6g+DNSR7J141JGC1yLtOynbhEvQpNgEtnDnLU77PgLXxeRT558nZaSQlbRLIk97KvDzxlp/d9edrE+uI0L5B4IYhhyZ4eCmt1QYygDsNjIWq/Xhl1Bsrl+LclJQKeIND4JwNsX6N7vgkwy0eILVk9FIjgf7pHf4uVKtwJaf3uUjHqkZL4mU0nd+EJLITv8WucHZDfY5Wg2BSi1JqM5Qu8XJROWRRuUvDq5WgpmEOnDKJVwI8Mql4x86Kq7SYMXe25FiGP4FBm6lIR87HFZ6cEhOhnt3Ze2vNZIYX7WK1mEjUpFRBxcoXBZHZi2jtXIo8eiLYASQanuV44Df7T9EwbeZX5KWf/qpGGw4WMvEy6wR1OihFJ3sQekHXNLkYPHo0etU0dBnC4mqV1oJJ7pykshzYkMJb5x32PRTg0bESoTspFJXXGZSYHAw5woXnwoby/CzwXzwS9BsR6OU0mljdlr0C7AEliQw1SqidFGyQqATAmZwaX2X9Qk3Xge7NsbHMG655IkGhKFkb8OTgrw7UKmjZsz0y6EQo4YlaXVHb8n3itUtz87MdLXzMGJuopw3tykQtVebQP3WmdX9vd1oGj+R5sufznCIxiAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SOhfst95hdKzxVVwJCCpMbKt3m4+O0t21x0qojtDuyOyEWVjtK64piy8uMBmnhqud26Pn12UOWASyFtgnriY4lcCFOWybGetk2GXX8wNU/YtwExf1JHLqNRjQnRyjFxdS9mGzujfTmJD6RZpLK64095Ob6v9/TDxS+bxziXPtXklGkzX7R/ErtbR4Bh+HGtyRE44/rgPpb/lWPR1vB7eyPcf18K+JhzPTs1fFb5gFpo0wmoiHUyihaZbEeLY7uT8+YPR7VU/OeHCJEjC2GbgvwBrsDsR6CSY3ssSkp3Hq1XWpQFwtSu6l9/e1Ir9pWRwxduUdLA7OgVualAxfsLsVw1eTkAm1ds0cZstYX/5RRUEEVVM6vf40s3pciRiCmN6vMnccwk0IAz0FjEEaaKJkukYCkJT5vEJXk5a3J1sE03LIS07WnpvCkq54i+1lCuU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 08:35:54.4773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 381ad16e-0062-4e4b-9443-08dea437ff39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8201
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

From: "Jesse.zhang" <Jesse.zhang@amd.com>

amdgpu_mode_dumb_mmap() unconditionally cast every looked-up
drm_gem_object to amdgpu_bo via gem_to_amdgpu_bo() and then read
robj->tbo.ttm and robj->flags.  For a bare drm_gem_object created via
drm_gem_private_object_init() with its own drm_gem_object_funcs (e.g.
the SDMA UMQ doorbell pool BO), the cast yields a pointer to unrelated
memory.  Whether that memory happens to look like a usermm or carry
AMDGPU_GEM_CREATE_NO_CPU_ACCESS set is a function of allocator state,
producing intermittent -EPERM returns from DRM_IOCTL_AMDGPU_GEM_MMAP.

Gate the amdgpu_bo-specific check on gobj->funcs matching
amdgpu_gem_object_funcs, and resolve the mmap offset via the GEM
vma_node directly so the path works for any drm_gem_object backed by
this ioctl.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 0071d6957828..ccb92088172c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -587,13 +587,22 @@ int amdgpu_mode_dumb_mmap(struct drm_file *filp,
 	if (!gobj)
 		return -ENOENT;
 
-	robj = gem_to_amdgpu_bo(gobj);
-	if (amdgpu_ttm_tt_get_usermm(robj->tbo.ttm) ||
-	    (robj->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS)) {
-		drm_gem_object_put(gobj);
-		return -EPERM;
+	/*
+	 * The amdgpu_bo-specific access checks below assume gobj is wrapped
+	 * in an amdgpu_bo. Bare drm_gem_object instances (e.g., the SDMA UMQ
+	 * doorbell pool BO created via drm_gem_private_object_init with its
+	 * own funcs) are not amdgpu_bo, so gem_to_amdgpu_bo would dereference
+	 * unrelated memory and intermittently return -EPERM.
+	 */
+	if (gobj->funcs == &amdgpu_gem_object_funcs) {
+		robj = gem_to_amdgpu_bo(gobj);
+		if (amdgpu_ttm_tt_get_usermm(robj->tbo.ttm) ||
+		    (robj->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS)) {
+			drm_gem_object_put(gobj);
+			return -EPERM;
+		}
 	}
-	*offset_p = amdgpu_bo_mmap_offset(robj);
+	*offset_p = drm_vma_node_offset_addr(&gobj->vma_node);
 	drm_gem_object_put(gobj);
 	return 0;
 }
-- 
2.49.0

