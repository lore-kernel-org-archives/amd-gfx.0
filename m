Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCCBC71135
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 08:22:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B54F10E2DD;
	Mon, 16 Jun 2025 08:22:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AYoWp0EJ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FC7610E2DD
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 08:22:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POtRh2cGLZybDCxIZ/y/qp96KqPOQUqWY5OMflReERNLsuNNcBdkbEa5CQAI0iKOcZG5BdO3J481XCKsiiCNtHtvZNawxHE+TVkEoWxuQVmNQxNQtTa7efishz1E6Q8h+fFAubBmAUT+StmtLBBss0F6IlZ0rfCDnzK+N1vdtX5B4/dLjjjsWvSYM2j4XgdroOwu7eV27We1xMs3T/vCXaXq6sGFNS6tMfCNYzillHmwf8WP6qApBsG7jTdar3ajE3EFa2iuSEsazr3bfDOpImghBAWfMS+UqESgtEfdpic4evpKJG+3gW0U09YZvdPDStx/jegnO0dGoC9Ej8mENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nLxrxVBVgb43HfmX0jVjui+BTOJe8FcC3hdx34H99g=;
 b=awLI7YzHAfy2wASJe+AXzBNi1rVxZsiOmTgek93emjzRg+E1cr+mCeCGeG7oUEdSvjKXGSwU3+2kV+7FOV5qPgozT6k9PBdYJw0yVk/V8ndk00uifsJx5XMkKNe3EaMQKROVDiKB4EX5dxtoGhB72mVglJoUfkwYtqY3JxKh6nnLA8t1R57e5DDl/MN0CxhdYRqkQdHPSg7KWYffReny+jSCMn2KlPSykOTmobB3qWm6oN/OTbqcVBFpMtmV+I79/YucHJMNHB6k474SLU1g/bQTr8DUAjXJKS2MkgHT7/lJe9Ws63Bqy+ikBpAZNc3B9Ygii7Jo/MPk9bMfx2J6qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nLxrxVBVgb43HfmX0jVjui+BTOJe8FcC3hdx34H99g=;
 b=AYoWp0EJC4QWI2cXXTAcoZtovlAaaWH+4N8AVIsAiyGfsACHZtiz8NNJQmYWcHXotVvDwc+YEAS9RPcZ1+rJ5bHVYqzLDdvjt6zMMJwkDodBJRAgzXAw9NoewDF78tNgDsViFWQwOs1SS49MqndR6PWZNwOLjd4MPpiGFFfAxr8=
Received: from BN7PR02CA0020.namprd02.prod.outlook.com (2603:10b6:408:20::33)
 by CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 08:22:14 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:20:cafe::d0) by BN7PR02CA0020.outlook.office365.com
 (2603:10b6:408:20::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Mon,
 16 Jun 2025 08:22:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 08:22:13 +0000
Received: from lang-cezanne.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 03:22:05 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, 
 Christian Koenig <christian.koenig@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Lang Yu <lang.yu@amd.com>
Subject: [PATCH] drm/amdgpu: Mask out clear/wipe operation if buffer function
 is unavailable
Date: Mon, 16 Jun 2025 16:21:51 +0800
Message-ID: <20250616082151.28943-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|CY5PR12MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d2ca07-669a-4e32-ee6e-08ddacaee58a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JkGoIrcSqfPQXePlU28Wdii4OUs8WDdYLncfiD3VCYqYFK274fXAmznBmhvi?=
 =?us-ascii?Q?CVhNxYl8UCGArMn+njpyw34u/C9/gm5WIGcLA2IGRJqwD8FWmEKJZd0Mpnjv?=
 =?us-ascii?Q?XLMEOIh0pbF81n+LKjD1LM3ykh01G11Uys6EKYdYQO8cam/KGuziBL/Xjz+Q?=
 =?us-ascii?Q?bJFkiHWY62Jh8ERCbDInSBGWGlXIKZBHcRnfY/NY4c1nXGelO/fkrAdBp4FM?=
 =?us-ascii?Q?kB1WusxJk2CLGooLzaQjqBQ2Wz/n5LBtIlb78jFB5X0MVke0zSkjoJQT2nAc?=
 =?us-ascii?Q?ZURRpwVgXRo09d9YmHaghl8FfhDn/Q+P90C01oNhZEu4qjYCSSHAv6bgLP6e?=
 =?us-ascii?Q?8OuuCtxJquXtCoA5IOH3TDjyPcl15wwGf5v7LFxp2cD+wtnLeo+ARfXqSxda?=
 =?us-ascii?Q?irHPys+UqBkVSNICHn1P+vjgy/L/7u7kE8oLjjDWWu7ueXXTyAoilCa6Had5?=
 =?us-ascii?Q?7P5di/kff4DO+DGw5f754FabLhK04/zcUp3rbu5HassXVKvzIwtGmkBaET/s?=
 =?us-ascii?Q?H8ShNAXtsAACgqVLltPWFYhXmdtkPEEaXJNMiPCgliFdsuxiYaAdQtuH0h6I?=
 =?us-ascii?Q?5T1XS82cRV0n3DFjDDHUBUoVIl1Q4Qk6q/vacvxz4vXNO8M0cWGQytrMSd9M?=
 =?us-ascii?Q?DUwRY7lA6Hb+ewKawR2fX3ET/IE3cTIe2FI1AGzVGXiNEpLaxXd4K/sAo+Wc?=
 =?us-ascii?Q?vDTRpedCwMV5Sb9VtWzvQ+8etuiURc5qR2o+CXaA4cxsdwB7qZIgS+yp+VT7?=
 =?us-ascii?Q?zYUojJdvUeNM0bAUy02aiFvsjPF7D4K5J/6gnRBD8ScnJDLAE/0f8kU1VCbs?=
 =?us-ascii?Q?K2n+GBeCz3JVzgzGAqb3iTrihrzOrkkozSNNEq3gDglydB6Kezk+TgtD79fp?=
 =?us-ascii?Q?TrAVBkzmk5m+BDzcWeI8pNVPVlq2Eu+T7WVLTjxl8scDr1TyxnMkauhucr70?=
 =?us-ascii?Q?UxLq88gbiw8ovK0xdtfnGWRBwDxB+4gT/ictQ/G6GotapiW6ateqRQOmkkID?=
 =?us-ascii?Q?CxCCPlk+OOUe8Yvz51ZwNyGMXiPP3t8gTTkFzOru8UF9kuLbtkrhkN9x+vZk?=
 =?us-ascii?Q?PspzWtHhSuezyC/uNsiL586hMsZN3k1c674rditmva2jFWLtQyrW1qGZsVJe?=
 =?us-ascii?Q?g1/1ttyjF+UqnQVMSNMfoIBCb6BPnXP3DONY2XDEZrZyRc/3JXer82VTcoFy?=
 =?us-ascii?Q?PKxZMDVi/F1UJ4ED6yZoXN75IFJoR7wkUgT75fEJaYtAMZwSdsZkhlQJY4ul?=
 =?us-ascii?Q?Ve91zldVAHU9QIHHgKVUxZwBgZrGr88FNCwgJF3KPvKnFlY3LyrP8veX6qlN?=
 =?us-ascii?Q?OHQBDJXrUtq/+WzPAgYW4DviSo97zAA0bOUxizQwnm5ZBk+gpbyH4+DHeXAb?=
 =?us-ascii?Q?jkePMXmnL2xOQeAqnYvlX4yr17xqg4kT+BA1X7hm9DcerdR873QzSO7eOfcd?=
 =?us-ascii?Q?rok+bs07YiI3QRhWVHlKuAfykoZLdacTIzbacEKnmzWZKgfoyikuGnikJsSz?=
 =?us-ascii?Q?eENnTv1KboseyBGEHTB7HZCSsaWncAtK4Dzy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 08:22:13.1442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d2ca07-669a-4e32-ee6e-08ddacaee58a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6345
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

It makes no sense to use clear/wipe operation if buffer function is
unavailable. It's useful in bring up phase when SDMA is not ready
and/or disabled intentionally by amdgpu_ip_block_mask. This avoids
manually masking out clear/wipe operation repeatedly.

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 3ac52d9b9d30..467c8a1911bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -689,6 +689,10 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	if (!amdgpu_bo_support_uswc(bo->flags))
 		bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
 
+	if (!adev->mman.buffer_funcs_enabled)
+		bo->flags &= ~(AMDGPU_GEM_CREATE_VRAM_CLEARED |
+			       AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE);
+
 	bo->tbo.bdev = &adev->mman.bdev;
 	if (bp->domain & (AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA |
 			  AMDGPU_GEM_DOMAIN_GDS))
-- 
2.34.1

