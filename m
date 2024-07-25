Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3EBC3DA64
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B743310E855;
	Thu, 25 Jul 2024 15:01:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ybTA81MI";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24E7910E84A
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+Z9BcM2LSKllsB1wXYUprqhvJQ4bIk94tFV3zxI/af6g0mMrqRQ1Jbd+FgHkZy011YoGPv45549GMsRrnrgVFbrgQtIM8IemF7Z9WKo85RVDK+PN0ezwkKwf7V8hjq4MgOErMOi7D6XcpNAELfYOzKWOZju5Vang4DHRkK8t8BDWM7MsRtmsAGS9cka2AbeTEU6SIY6egnrOJMLY+EptSXsBtBFthUsg/JjkpXqkcVZmwWanV0hia8Deh0VvKIUbQc9ZcLN27kipeibvMl2xlz9WRWDUxyufzH7E64Fx+LHBwPJLu1gx3/rrtptCQgEEGk2+rsMKY3EP2Il02qfZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H94xutViIoKYWPRe0grXNdTUd0Zew16lgiSinfM6Chc=;
 b=JmNrpdA97SMWX6QI2lHKFVyjUMA4/QYlLGJ+fVJzjSYOv0ehsCZb6sZsGgt2f1yweuspNj0xUTKfDzj5vcxFNNZPS+pBigatV3TBf5ueoMfktGocVCuzf4v8PFhTh5oc689lwXH9ZEt8+kWAfWWJjFGrD4vdnEaqnoMXmMm3E3d0+oWanEOoqjzGYdtEwIfE83y/2lOr3p8Owp/3mdNoq8jbD+y6mLGbjSfFoI/HVBq3g7hhEO1JoD1u3ioWzoD01Gyse2m9nrlLafMBE5Rp+pjimH+LJbpsje+OHrbJhgUN2epKxKX/VzAKPpnbEONHh9DYDlQaBB9bTnVtkQBqOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H94xutViIoKYWPRe0grXNdTUd0Zew16lgiSinfM6Chc=;
 b=ybTA81MIOHKb6H3IDSx7p3kLVEtP+vBWSYcMcsh+iK/+r6Ldezd2xIb77oyw/Vql68EsXM71qzLWiVkO+NTLF+ldwbzCThHq1D2UlDmDNLJs4hhv5ltnN7Gogbtu4qPsTpBWCYm5qbkemqz0LlDltpGUOq8Wb3r5uv5SptfM914=
Received: from CYZPR10CA0021.namprd10.prod.outlook.com (2603:10b6:930:8a::14)
 by PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Thu, 25 Jul
 2024 15:01:38 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::a4) by CYZPR10CA0021.outlook.office365.com
 (2603:10b6:930:8a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 51/53] drm/amdgpu/gfx10: use rlc safe mode for soft recovery
Date: Thu, 25 Jul 2024 11:00:53 -0400
Message-ID: <20240725150055.1991893-52-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|PH7PR12MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: 11afbd97-5fa7-4df7-ab9c-08dcacbaaf1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PsM1mTHG97763FRdzVI8A3iyakIHSEjz5n3VNgJeakyAb6BbzgIpb2xq8I/r?=
 =?us-ascii?Q?bM9nBZMTYbb4ZIQoTd+bmV8JEf7RPnkByPuYxo3AZZzKn1Ti/4s4eJPKfDnn?=
 =?us-ascii?Q?IXkgew6EsW5ak/rfd3E4xbbeDlJHJrm6oEUJgaykwGcink38Z4X1buWf4Ddg?=
 =?us-ascii?Q?M0BNxq0keDCMoxzOmWCrwBSl2KiZXB3m0buIvwoHLMsFJ9hMgf51hR3BOBjm?=
 =?us-ascii?Q?w+IBJg9wTiiY4JMr5LluZ39uqvhcFN/nPuos+oqDoz+6qXNzu74CdXQEaFCc?=
 =?us-ascii?Q?iDNJWjY+o6DRvxFKRv5spi97TSBWzlCVWhkzYmzyQdUrNzK/Bl1yQE+iOKfn?=
 =?us-ascii?Q?0q/vHO8aKA06JHD4VGKxflDoeRHuQdxFKdR957B6qWIWezwj/banxgfwCF47?=
 =?us-ascii?Q?6Ib6i0MpYaMXQvcta7npk2bO5iWJBNCiKRjuGLLiVCGmo7NHUPA5paxghbGt?=
 =?us-ascii?Q?SEqEeLHvTAObyEHcx9UycFyEW9X0FzwvqLLZWFopTWze1BB97xcCTvKfbuaQ?=
 =?us-ascii?Q?bgW30/rc8bcRadDO9y6/GRwbS/lEZoCpUng+ZfIGdRJppULPg+HX7qT99jMd?=
 =?us-ascii?Q?z+sCz31liZeBGO8HJSqZqbwxGTu4R4htBXyskcwAiIhMk4vQ83XsVAKAXEr4?=
 =?us-ascii?Q?ajU9YZ2o6Lq0oNiKoYRDxENR5zn2uz1lI83Hd2xL+JAIkjqq4DpE/JwZYNqw?=
 =?us-ascii?Q?WpmrmbEJKF+vyN45/Y+48pDZUs0B5V8Y3H6FpHKkG/GQLW/QVdSnuJ/UzV5t?=
 =?us-ascii?Q?Q30WLYW657x/2ufVWpeBxEeyB2e6UKQwlKeZ1QoKIMhM4BvqCkF80XYvz7E2?=
 =?us-ascii?Q?i4OQAxR81J6N7mVTvGaT/fsSOtQ1jn1CRjcOmIkYXiFmS6xTAvbTLHQFGYQJ?=
 =?us-ascii?Q?sotW98PGIqdIb2s+ZTYVrbxrU/kH199gtndye9u6wMwJYZI7m8dxhCq3nfVs?=
 =?us-ascii?Q?s8VOWj+gn9mT7zmuapOGxNY12TqHL5toMFcKrEImImOVPJ3C40VdsDWDclDn?=
 =?us-ascii?Q?lQigz7sc1oTlO6IHSA2QKt47ehB3s3EcNexwO8TEPRAyH/vl/qcl5gZTGCu2?=
 =?us-ascii?Q?ImedjUSpL0qFBST1QOZJ+ZF/CeL8rjunoyxhsQTrbpawYhrcKF6PDg9fiYL4?=
 =?us-ascii?Q?NPSl5rZ87SMAC2mDcursqx5va+g1g7xJB8d06F6cfJQeE6MJXeHbpIL5o4+8?=
 =?us-ascii?Q?ENaf8nAMRalbfYIeUy/qVxjmTxxFUbcAIhVOzA8hCrE4e4vH670vn/SBH0Q6?=
 =?us-ascii?Q?cLRRQmQ4RGhcm8XmaQEP7CsSo4DLWOsCaw49lYbpuOCOnwtSX7uDmNfcnR2R?=
 =?us-ascii?Q?LpOM1eZfPfJX4D9wO4QgMOQ6vrJ6dpc86nmTbk+oiwDnCBKaYUJ4Os5Rc4CF?=
 =?us-ascii?Q?cTfg/TCNodDPYdWQqFgoAv8g+m+KF1sWAH4daXT6rK21KV9E9oBEbPzKwr20?=
 =?us-ascii?Q?udekVfVbR4WRp+6n6n9zHKqe8t3+Kr6G?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:38.0435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11afbd97-5fa7-4df7-ab9c-08dcacbaaf1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5712
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

Protect the MMIO access with safe mode.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index da0d3c8e00b8..2bf595f88970 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9005,7 +9005,9 @@ static void gfx_v10_0_ring_soft_recovery(struct amdgpu_ring *ring,
 	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
 	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
 	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	WREG32_SOC15(GC, 0, mmSQ_CMD, value);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
 static void
-- 
2.45.2

