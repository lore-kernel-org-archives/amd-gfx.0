Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CB1F53D85
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 18:17:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA7BE10E321;
	Mon, 16 Mar 2026 18:17:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H3J+wXvp";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010050.outbound.protection.outlook.com [52.101.56.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E83910E364
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 18:17:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lycCvccgCRXdPstF0cmOORfEaGzlyO2h6InI5U2bLuUWW1XGPjDLmnNBd7Ucm6gR6aG42hlT/0SYxkh7T5K0j1TAnRQSCIryzZgPJOTusNtPStfxYSEpZna2yiFsoK5U0T8ceOFxcUHuxwh+IqpT83nyuRo+w0GjjRuZAuPjusJcdFZ0C7YX8H12hV5dJ8+1rupIZRvbWf32K0dJtFoely+y56d5sE8Zfw6lENYGVhUKqzn8kw1BBaoQpo/oLdqSuC/zW3iF9OuBeiL9QQJkUtxeLPmCPY8CMyYno+TpJuKLbR2q2vPwLqbuPME3M9Gv7o2D/BZDF9x4uFw2zVCApw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMtFcUNFhiGl04A0hFyj8V0ybOBFlkyFT5AZXuRv4SI=;
 b=eanco3C6AsUsCMe3dAayDod6r6P4iGK9i0lOFUF8CnEZjMPG46oBT48WD/95791GLnhx2WAuUg8HM75WqUBsVN/aLkyz9cReKv2JieKVLNc8P419ogpKQH0zB8dNJfusGAth7anKaWCzc05Zt6+kxe94adBKtEyAsJ6+iFiGxrsdj1VTPmSBFQU0Z+vSTkjpqSIGsjG/UkcVPP2gkOXtmqjLM9SEJKzH6ZeJ/ZxX+Fli8vgP8nOl2Gcj/mglgvFO/oeeVd5l0M8PLim50k/er7PFAVwKOKZbZ/WSsA4SLbmGSDAQBi1FF6oTLG9p7MZ7dJgSxxOMQHXjnTNBQ1BueA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMtFcUNFhiGl04A0hFyj8V0ybOBFlkyFT5AZXuRv4SI=;
 b=H3J+wXvpFknhbJRoztboEWxZQ6cRQDFsQ/dj2mEG+nAQmxDh++5AXsJwb/6w4w5jhsOil4YM0ooIccZkCbKxL4Is0DEOAryZvR1x8PCAmAlMK5ODn5uO5Ip9u+Ld6+oS7sb7p7XSl487l5Oc5pSPJQRFPSXdcvF/z2N+nu0YKD0=
Received: from CYXPR02CA0044.namprd02.prod.outlook.com (2603:10b6:930:cc::12)
 by DS4PR12MB9658.namprd12.prod.outlook.com (2603:10b6:8:280::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 18:17:03 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:cc:cafe::8d) by CYXPR02CA0044.outlook.office365.com
 (2603:10b6:930:cc::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Mon,
 16 Mar 2026 18:17:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 18:17:02 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 13:16:58 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 11:16:58 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Mar 2026 13:16:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 6/7] drm/amdgpu/cs: return -ETIME for guilty contexts
Date: Mon, 16 Mar 2026 14:16:47 -0400
Message-ID: <20260316181648.2005897-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316181648.2005897-1-alexander.deucher@amd.com>
References: <20260316181648.2005897-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|DS4PR12MB9658:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bed33d4-aad1-4bf1-707d-08de83883903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: CqREIjZMIDGNj52H/RwvGCQjRbuPn8hsLLfZyD0TEimZjl4+em2XKg//YjU0nuQu/g9oOws0za140ThgU6uUZneDmzU024z8X8KrRb0s9nl3vd9lwx8IFrHTeYBwE7dy775vl8/l9ZEDgQKDK7mxqH3OD5wxaWqbcuGOO7oEeBMc76p1g3DDUyPkmY8ojPDONFnxEm3e44/VcquFG+gYwMULPqOxfsAVNe++5RHHmJ2xPpefsWohSceXFP49Jknn6TsDEMTmm4/C6Zx3UL0dTZeOswr2USar8sttFsgSyC7qIILEHNdcrzg7BcsN2Yn/kt94W6M9LZMgkJTZ5nzVtflAlrO6Mx3vX4RgijjW2GOxE2U7eg/dzztE3x9S4OGfd4zgad+HsijsnpcRDWPnDeu3Wpx1k8LIl1v06EWImL1/PV9m0sLaCf0HHvQN/mfpneWic3y91GVbfOZaG4uQ8qCHf16WDlmtH2CmaiLrgdyyfwHyWcMZ5fO/kpYTi7N+8CpD4H12ZTZW3CvjlG26I/Y0aEcQjVeyk6u/NDhAgC9DpmVUprnX5uRc0Lt8lIy6fzwN0j9mxcfG9RhyFxfZFFoIavbgWtCGOciud3lfgiWgeMJclivUbPaaK52xyD2oICFkorzFhkc1xCRNUubn6SD0kgkehyoVR586YMvBcH4RjlfCbe8fBrGwCZIZmGFpAOJCg6h1+jjO6dBIJgzr9yFys/YfxaZUiFfgjjSORBFAekRBTTFXg05d35kUjXy4zTOgsRZr7J/cp/DYsbIwMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mjLWErS6KiEkUj+66fmKRsZD+E0qyvVvt6nz+UoKX8lxXxNLHBEaGyWPWgHb4WAYr9Mujzb+QHmb0n1bK4TvsadH8Kq6yb/2u97MqAE0aXj1/yAVBId8QZzhT3d3c+S1Xn4ihGjkgzydVc9oKpDJ6VoODlAdg4ANFNNsWwmukN4gnfAWQDND7B7SgpVUOX02z06qcQFY6eoq+BK0jgtG3IqLk1kS4Rl6PwdLTHUhFvyPCFZ+OjLLbgs3obEYfWRNCWQfV3H5f6kDuYxxIKr8kXgx4o2jdl0PTSVSNyls+AUbgTwoAyNmHno1cjwbNRFS18lZiNFfK8MW3bJyQYo2Nzsi9JnHjbZDKpCsRPXImwKGIaziIduGFKR5wfz7FMshz3c+gozkl3q9W8SYwghPdm6h+9nbL0qk90j+/f5f2/+5bbJOJ1Vqkxo5D+qHgqsc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 18:17:02.7643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bed33d4-aad1-4bf1-707d-08de83883903
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9658
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

Return -ETIME rather than -ECANCELED for guilty contexts.
Userspace only considers contexts to be guilty if they
return -ETIME.  Returning -ECANCELED means the context was
innocent.

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 53e2eec734b1a..06dfe01492616 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -62,7 +62,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
 
 	if (atomic_read(&p->ctx->guilty)) {
 		amdgpu_ctx_put(p->ctx);
-		return -ECANCELED;
+		return -ETIME;
 	}
 
 	amdgpu_sync_create(&p->sync);
-- 
2.53.0

