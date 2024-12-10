Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A52E7718C
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F09A910E9F7;
	Tue, 10 Dec 2024 22:54:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ocAX2LV0";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 976A910E9ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9CBv7urQus9P4Q2oHTlFtXuFguFM5Bb8zay5jAgzIYT/P5pXFxN4sSOQQ9NJpwkexdRkT7vYjaEaT0qENJySHEeO3vzvsxy81Eeuri73w4zen89rtaSz6HZJrb3lkzYpJL0suKbKTP9RkSg5hakjF7wRPlrOu0lugSYqEex+1iqsV7jeAC7xNJESFYnH+98AE8OfovAVuWpv+tBtLtlmieYpQwDoIAIbCwcF0+2FOLPH9FRP7+zeAVjPOq/l3MnyDmEPBoc7hct9XUdj6cCEs6tv62gJ2wSPn68RbuUem48ydgu7DG2SqJzFwX6sw0KW3ubitZnLs5VcD5xWGjHWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9DsXoy19wqldvKoj/GKkSmHx04lIa9oJSurLmMQ0ww=;
 b=IuorIgcToJvyslgVFni/q2re1UmuYpeUCiQzJHb+h833HmT+/OM/qijo9lqseZ/5OgurFcTZMfHYtAB+0HeI1o+b4HJO66tsfPlH1ewemj+wy+7kP66D6jpdsXkfhtDN3Whtfh55WQnOLkYR3tMNk2h6KMMhPNueVzofwpftOjLnlmg6JGljjP6Yc8ypSGTgVtUB4AHuRlRHmdV8yV0tteQbyDvW/61hQFJQgg9N45hAF1ZHwkZVFldAbsAebzwi7XTsUvcMLPou+4G6/SFgf0rtaSxYj9t5alMqdOuAEZUJ3xdjZzc0EHcmfj+3F95FHFWuMV+L9ZTPybvVfpggfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9DsXoy19wqldvKoj/GKkSmHx04lIa9oJSurLmMQ0ww=;
 b=ocAX2LV0WU5ickrNsnFWshUw/WFxuyjM5JyWn1CNyu5dkJ98YC/TavqOuAhhUBCVu8tflcCoRjhfAZ9EU/yvNq6Dk6k62ciHNQJ8YIEJHD6jd0rpcQZdPduZaWlUpX0cqDqqLwdMZwz/9y9h2N+XPrGFSEM877Bp1ObnYhZ3J7Y=
Received: from MN2PR05CA0030.namprd05.prod.outlook.com (2603:10b6:208:c0::43)
 by CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 10 Dec
 2024 22:54:16 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:208:c0:cafe::67) by MN2PR05CA0030.outlook.office365.com
 (2603:10b6:208:c0::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Tue,
 10 Dec 2024 22:54:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:11 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 37/48] drm/amdgpu/vcn3.0: use generic set_power_gating_state
 helper
Date: Tue, 10 Dec 2024 17:53:26 -0500
Message-ID: <20241210225337.75394-38-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210225337.75394-1-alexander.deucher@amd.com>
References: <20241210225337.75394-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|CY5PR12MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: 45710ba4-5e73-4998-0c44-08dd196d92e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5YkZsSDpmJNwIbOUmGWJ4BWUz63Mxe1sBRVemL7r7x+w5hDqCPSIYFWR2Pmu?=
 =?us-ascii?Q?IAuhN6C0BuQPXoGfu4s2MJAN1oCG8ZJgRCc4K8NH4KfwK0oIB74gAgW6Y/Qc?=
 =?us-ascii?Q?0QqeT7Shgl/Bnq6kAB52EhCI/e2zDIeNpuqQfpXcS9/7rC/s+lA0D1yLAmgk?=
 =?us-ascii?Q?dWDocWKlXh7icARJm7hcAjmNalbe4T5EsAF9ctT32A7FlHAWV5nfsxruRx++?=
 =?us-ascii?Q?p0re9hbnRqEdR9wn+uDJfNw1AeygxKhzMVUbQ7nquD3t+BVmqgEMTSmyJZgm?=
 =?us-ascii?Q?s+38ybb18/VhrKfL8KbF/1Wzvby9VfSDC+nkbFMiQN8DyGCYNkEm8EUv6sEb?=
 =?us-ascii?Q?pRtUimsOJxb1IImhu/AkF316Qg7HdgoVNTMSLUVnGGnKyPAif1zPBfZkneYb?=
 =?us-ascii?Q?DWNOpqu6W2T2FX/7849seLjCtYTEokhYz2gYNwhGfTofRflaZYKRCFixXWag?=
 =?us-ascii?Q?VBcRhNdlYCjSBCEWY1SOeTmsUOO7n02tdgDKXDx9nfX5NRD13xUBV0c8CC6T?=
 =?us-ascii?Q?K/9+3Z9jeIyzWJPCnN4lC6ou8GLojIkDdqsLHEiK9P/GkQ2toxd+KzevCCRO?=
 =?us-ascii?Q?hvXx1ZkYkB14f5GPpA3GX+BhI5abcRuJpGIxupXSDsJ1CFkSRbGtM9F352p9?=
 =?us-ascii?Q?OPoojfHqBr8nHQof7EN0Ash+b1FAkSAiXSRitcn59yO+YjQPEuZw6J/rmNdO?=
 =?us-ascii?Q?CJLDz9I1V+taioHWdFFl4aFDRPHsKTH9KeVpKA5NMXptozxPDVS/Y8uzqbRK?=
 =?us-ascii?Q?gnILXcMWBU7jb1t9Q9iecNTJnRrC4r/plQQSrpDfJ4vpdgIimWdN3u04Ae6c?=
 =?us-ascii?Q?sYLWUoHc1Km70P3PDQUwUzshlyjAFVqqn+cd6BSG1URiS0dGpkxd0vM3XiTc?=
 =?us-ascii?Q?54Tlj4WkWg+ZIgianZIHVBSmr9qYKC9kiExh0/74CrAJT69G8ButVuCrluB7?=
 =?us-ascii?Q?NS7h5NV7dKFEMDCZMZAkI3O6ctoaOLeAuzkK1x2E8E9/lcsjcqBqXVXVkPth?=
 =?us-ascii?Q?rrnddIodF0hQAJFdiDYMbN3wk56+IjrQr0HBRN1k5rth8OzJUtwyEReTDFo2?=
 =?us-ascii?Q?D0sE5xB4YcvrAgVM7O1rqbGDIUd+tLZVxAIMpXepCilpKWG5zObTqaeaoApI?=
 =?us-ascii?Q?ZXMvaCcfruU8LcmwRVWj68ASQNtBsKD9Bt8trt3ML0M2CvLBg/chDH3gUfWk?=
 =?us-ascii?Q?sduJlgBVA2VmfHKx1oQB+O3yNPrKBWbfkW+Qr/B1q5xSolJr1EMYvxlR3VZr?=
 =?us-ascii?Q?gdV7AC+7G6T6Wdcn1oT1PNAhuF+RlVfGuhb37JgjCHaGgGHUmhUGE9n8Njf9?=
 =?us-ascii?Q?sEtB2EiG4ttCp7HnRz8IEto4YCJHKm38VRwLGT5334wXtiC3Q1nQUbCNLboJ?=
 =?us-ascii?Q?9rIJ2DlszpWrAvF/oYnRvImQNG5hablCW5uKcULuL/WsJ8g6Rg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:16.2270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45710ba4-5e73-4998-0c44-08dd196d92e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6455
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

No need for an IP specific version.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 353aab5565702..2fb3eb3b007d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -107,8 +107,6 @@ static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v3_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 				 enum amd_powergating_state state);
-static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state);
 static int vcn_v3_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				   struct dpg_pause_state *new_state);
 
@@ -2230,21 +2228,6 @@ static int vcn_v3_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 	return ret;
 }
 
-static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int ret = 0, i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
-
-		ret |= vinst->set_pg_state(vinst, state);
-	}
-
-	return ret;
-}
-
 static int vcn_v3_0_set_interrupt_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned type,
@@ -2383,7 +2366,7 @@ static const struct amd_ip_funcs vcn_v3_0_ip_funcs = {
 	.is_idle = vcn_v3_0_is_idle,
 	.wait_for_idle = vcn_v3_0_wait_for_idle,
 	.set_clockgating_state = vcn_v3_0_set_clockgating_state,
-	.set_powergating_state = vcn_v3_0_set_powergating_state,
+	.set_powergating_state = vcn_set_powergating_state,
 	.dump_ip_state = vcn_v3_0_dump_ip_state,
 	.print_ip_state = vcn_v3_0_print_ip_state,
 };
-- 
2.47.1

