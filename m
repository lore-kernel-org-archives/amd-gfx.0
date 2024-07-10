Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4976CC3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 18:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAFA410E864;
	Wed, 10 Jul 2024 18:02:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r83LM/Yn";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3F9B10E863
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 18:02:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEsAkUbuj8xZQfBOO56M6jzSzVIhiY06kKPBYYntBJ1FB+KGtw76fCT9jDv/bvsW0nsd3o9o8pPzGSLqs2sUljYgn/AT3t3C5uQ92TTLAIFn5MLuZZP3oV/mRnTWpxtM1z2fG7YIc9AHbYQAVCrfm7HUbJWAIkTf+ULA7BrXpYUWYA+rgNXgtO2on0u9Y8WsVvXFSWEM6fUWDVwKlQgjvm8F6m1WRWJuCZzNSeveAny3+PpQslWZQcNGcYf9lt0pM4CXQ8UvOlZeOT1/SFEOOgSD4SVsN7ZKf4cb4+4jKaGO9t+ZbC382rPcL+3P5bPQXOyWL2Xv0Ri5W9Bib3eI7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jji4K2PjjBK6klk5C1EezVNwBemGQoQz9cW9nYAUga8=;
 b=oGO6rezUKdt7o+XPDiioFV2usrBW4092318sZuvs9i8bn2dcWh8vBwz+l/hy0MG/BW8NA4GIiduXbWWEP4eMr3c1Xi4rHVuBZAEJ05stt3mZ2aZr141ICnCPueivr0E+gireEDC3vY2lkCNSl1/0zumn+iDatBsPOmLF8uGa4K2HAl+5xUpXthlvkWwJvNqcXlXxO9YVnmI43lOYdAgVhpTP4GLaInaTa6qqd/XWwate5IyFtX10L3dRiOKsIMIW5uvGMtd/Re5eMmHthxUA9NIPYxh0n29GbDlrPuhHgzdyv2jsUZiDrO9JDENGg46QGHEbUk2Gc2a0yQ/a5ULtkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jji4K2PjjBK6klk5C1EezVNwBemGQoQz9cW9nYAUga8=;
 b=r83LM/Ynq+oLPh9/7qQ2yULBqdhnWK1Q6NRAXpllppgatMZ4eiqwGaRAp/1h03esvqDTQDH0nU1CaDaT0ngIamWza2pEChXlVGaLasBXJVVo7M4Be20Sg4JVNkHNZeSso7Yky9fX3HGzzPAt7zrew+6ADjor33jbwHyNpfCTtDg=
Received: from BN9PR03CA0258.namprd03.prod.outlook.com (2603:10b6:408:ff::23)
 by CH3PR12MB9429.namprd12.prod.outlook.com (2603:10b6:610:1c9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 18:01:55 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:ff:cafe::92) by BN9PR03CA0258.outlook.office365.com
 (2603:10b6:408:ff::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 18:01:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 18:01:54 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 13:01:53 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/vcn: not pause dpg for unified queue
Date: Wed, 10 Jul 2024 14:01:40 -0400
Message-ID: <20240710180140.182275-2-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710180140.182275-1-boyuan.zhang@amd.com>
References: <20240710180140.182275-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|CH3PR12MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: 8196d2c9-3692-4da6-da3e-08dca10a623e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sl09OOZnBM1VspiXbMX8MtaHTv2w8w8kagG3sDfDNknVc0cpyVF5txZCype7?=
 =?us-ascii?Q?pZ8Wu9GGIFYFKAhugpj+ZambKa+sNDSj+W0WNZ/+XPXyISSBx/73KsDpt8BP?=
 =?us-ascii?Q?mRV76NTzgO7GLxFWn8x3B9BqfwjnLs5fPhZR2L8JvEE23hZzN3plUrh1WIQZ?=
 =?us-ascii?Q?g6PgFxay01sE+gAQLPfGMImwlkrO5dJ/e6sdxNZgbkSM17LCtOeOjiIyimB/?=
 =?us-ascii?Q?YiKScWHMBlsL5wUSfs4XWTwObUbHogRzQKpcWl4B6tHjv2vkc37RcEzF25ZB?=
 =?us-ascii?Q?hXcomvxiL6KdACyIjDSXjj32U8xVfrOylh0S7/MI8585ImsxiByLx77fO3HH?=
 =?us-ascii?Q?2XTkfj4oyIYb0scuyVAoix1mmj9O3ukLPKTi4FUaL1Tp8mDZMpk+pTcB/pt/?=
 =?us-ascii?Q?eWP0Yg2aS8Ub4guE6Ep7JE6OH821wET5jLwIFNYVhDpeKL7+KjSvd6L3Evrh?=
 =?us-ascii?Q?+dr+OFQR23H0No9nJ5/rOxybJMtipXPsG40EsgztYxopaZDcbyqyXTqhM6pF?=
 =?us-ascii?Q?HXWl/bJs/W2ch2dhxdlVywKg431QOazt84D7tuEdAbHpuWz8zVHaBYcj2pug?=
 =?us-ascii?Q?y/ijgZ3cvSt54LCgiKH/lYR+EHKKQ3trsV8d2PKCmIfT8KAzIPeQStrDcia8?=
 =?us-ascii?Q?bsodJv942FAIAqzDH4nObhNwV4JiV9yyOC53SyXzl+upZrY2EA4t16RdUf/D?=
 =?us-ascii?Q?aC6aiUepDwAxjliXjyW3QCiFQLGMHGH73p/YMYiJa02cPefGMMZ9/AYY8yfJ?=
 =?us-ascii?Q?IfuDPZNfdLsHegsYUyFP90nEJYWa8uEzXqeU+46ildb3+fFKtnvz7BResuwq?=
 =?us-ascii?Q?ZjGhd5XlIrF2siUNqAFf6s0vk4yDLo9pYxtLIOwwcKRP67A0UPBivyiIQh1g?=
 =?us-ascii?Q?qJDmHHOA8DNpuU03xY4N8DxLb745L1Gd02Sue/tz5jwPEi2s8JzYViIud2Q0?=
 =?us-ascii?Q?V8WchdjgM9QwWQsN1CsHu52JN8an4cGfrc0wDUuG52LYM9+v81oDlL2L58d0?=
 =?us-ascii?Q?WCGXtZUQRTwrgrmheUSbwjP7TthBZQ4rQGP3uHSLVweM+szALwocbTPTu7SL?=
 =?us-ascii?Q?hdOYcAdlYc8JOz+bGE3d4vDA8k9V31mGbWDyZ/ppJulFgYMtAO0E2k/g6zdd?=
 =?us-ascii?Q?E40ZWlhoynff0KO0XHyjDDu9wymOno3JesgcDwd4K9jHspzH0AovOZcy5X6m?=
 =?us-ascii?Q?NryxPfRweqmXwXNimPyZUEK1RagMKe8DWz65RCktH/GXyXSO1/inU0kU/U47?=
 =?us-ascii?Q?hlSIps+CBCPB3vnJCPR6c/mYVBJmeNbeUcrMgCX2y0nP49eMdJHUSp+eCZdj?=
 =?us-ascii?Q?kUjYzCcvSizNAyNgcht0/+zqx7fjp4Zg5mIMmBcPAqgmCt4Ru4ThGf7oIlPn?=
 =?us-ascii?Q?2KLRMrnBEVsCwowJjWVu4Jl4aJow+BHFUdTGbkDnFxx+r8Lkp2z9u38aAlJZ?=
 =?us-ascii?Q?UQaDtCscXXs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 18:01:54.7923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8196d2c9-3692-4da6-da3e-08dca10a623e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9429
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

For unified queue, DPG pause for encoding is done inside VCN firmware,
so there is no need to pause dpg based on ring type in kernel.

For previous generations, pausing DPG for encoding in kernel is still needed.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 43bed7730bd1..13fbe4120959 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -412,7 +412,8 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 		for (i = 0; i < adev->vcn.num_enc_rings; ++i)
 			fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_enc[i]);
 
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
+		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
+		    !adev->vcn.using_unified_queue) {
 			struct dpg_pause_state new_state;
 
 			if (fence[j] ||
@@ -458,7 +459,8 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 	       AMD_PG_STATE_UNGATE);
 
-	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
+	    !adev->vcn.using_unified_queue) {
 		struct dpg_pause_state new_state;
 
 		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC) {
@@ -484,8 +486,11 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
 {
+	struct amdgpu_device *adev = ring->adev;
+
 	if (ring->adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
-		ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC)
+	    ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC &&
+	    !adev->vcn.using_unified_queue)
 		atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
 
 	atomic_dec(&ring->adev->vcn.total_submission_cnt);
-- 
2.34.1

