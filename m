Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22E0C28B2E
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 18:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77FB510E7C6;
	Wed, 12 Mar 2025 18:58:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KLspdQp4";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75F7910E6B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 18:57:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8W9iqBPhV56JuAGddXa7qRWc0LLsaakPJLJzi2kGZdh71Bvkns9Gpv6ndoHLgb+kvA0AU+JVQ5YCsiP0EMHKVkhXdKX9jYvYl8u5ZQctiWrfYWULtjyDsRe5h+GN+jE56Vu+As30doDhm9fSKV/4WKQsTVkBxj7iYxM7q8ygrFdshw4glIPSb0iLDWWJCg4wHUvjI2qte/U+38EieMShPRvuF04gpnkurFBMJJjzKPoFyyo68RbMEl4+LDSiMzq7M7isgon1mvGqBvYH+NVh22iB77rR/sSu+fBXwUg3bqoKQNjsv9y4cdJg+zetiJG3iWx5NxF/wZzUsYjWa64fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvr37PfbO4ml4tLBDtFb3mZZtAg2FY2VfuI3iZ9K+Ns=;
 b=qoSFoje0rgFni1sz3vRzaw+p9bImuZ5NjMGWWP3IjsXImifa9E+Z0kQaKm3berdOkpPWHLNmpJa80SxJj3vpCIJ0mSMKz75z5uGjMQ+idXWzyyoE+6GrO6v2eG4Qg0t9ooAbgLAXw7+YPrxz48h3995pP7vfUv/PUXn0WcG6kifh+y73A/yalTS1d2an25/Qx4iihxjgWJQERvjsGA4qtRZxu+iwHqBIr9hAGvakQ0q6h5QyhP2/8321s3rfxHrUvKbU2H5GPINe8It+lI1F6C5ZkATRU7eNZCM+MyDiaa7YlYJqaaHEvj+P5pueHmaEi5Xv2E487lWyEwWoNGb/3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvr37PfbO4ml4tLBDtFb3mZZtAg2FY2VfuI3iZ9K+Ns=;
 b=KLspdQp48zv3ocLcnVPHDLJOknLlLFrTcG8YdAkZWNv5NgrTpCWzvsfbcXI3ZlmRLxqMFO1YocgwcMak/RAI8Q3/a0y6bAkJv0aKaVG/tJMAmGjEzDLn8nZTDVHiEhwKq2SbwPQlkCZuuzi+dNAD5yluOT6CqpvoffhwToodSEw=
Received: from DS7PR03CA0236.namprd03.prod.outlook.com (2603:10b6:5:3ba::31)
 by CY5PR12MB6479.namprd12.prod.outlook.com (2603:10b6:930:34::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 18:57:53 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:5:3ba:cafe::f7) by DS7PR03CA0236.outlook.office365.com
 (2603:10b6:5:3ba::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Wed,
 12 Mar 2025 18:57:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Wed, 12 Mar 2025 18:57:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 13:57:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 09/11] drm/amdgpu/sdma: add flag for tracking disable_kq
Date: Wed, 12 Mar 2025 14:57:29 -0400
Message-ID: <20250312185731.211350-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312185731.211350-1-alexander.deucher@amd.com>
References: <20250312185731.211350-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|CY5PR12MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: 228c7ded-1bf8-438d-a8aa-08dd6197caf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?leuTAopWLGY8MF0eF/d1HhNOOFe+t6957topB1qsBWb+uyerNHZ5zp+Wu9lA?=
 =?us-ascii?Q?o9pzv17t1bz0R1DJ+B43udBtRidDOgES8nBP5ubmdF1taS2noDT7wcwdcIxV?=
 =?us-ascii?Q?ZucT3OG1u6HBG8lxYK2458dGJr8P73rqpTYMEetWLVfJLNmpZBphh6U5iUnZ?=
 =?us-ascii?Q?ObiF4wmcFnE/hzl503cjc8j4P3W1ozOpcq/fF2ID/+vBy37JgIA5+Pf7fA7l?=
 =?us-ascii?Q?hzTZ9bK68AelEMjfGvKGbOU8MBmWzHw3bYqtGMS26LBtWBrH5W0Q0CVDB84p?=
 =?us-ascii?Q?wOVZzQzETSqb94KVdVTyDSGHFi8LPWMuj1pm8kNJqG+gAwSWB47XkgxnX1Id?=
 =?us-ascii?Q?Yyxb3901oss9msvBhmqXyI3S92ev31zZGUHbxk+WAfpDLyv9tLW5atSD+W+F?=
 =?us-ascii?Q?RwwrfX4vsUeleUeeSTRQNlIdV3e6DYqnENkJfcmY/3aSfKmeg6Y5VKNAMQ+S?=
 =?us-ascii?Q?WjwqSe1h/UAe5g5zshdj4rKi/yYb6Q/fUlg+sZCBCny1qM8ggf5NDgStsbtq?=
 =?us-ascii?Q?EOAI504IlaDMcKMjo7f1gQjO4NW6pc8B17xYE/fp9JyiJGLyGGGvJzeeXRdC?=
 =?us-ascii?Q?Eb+ZmC1Om3Js4GvIivePce5sARmkqwnGVER7YiQeq976BOtjBeF/sm+OEgVt?=
 =?us-ascii?Q?DCFL4spd0ToxTA4KWHlFVJH2keScywjnAWNLCVq74ep0ydmedNPP1QbPJHwr?=
 =?us-ascii?Q?zRo1HxFbcZUlqpdsAyYIZzL5FST6vWqeevHGDoMpdY+cHkyDOJZur6KAwyoy?=
 =?us-ascii?Q?1Vj7lpNNNemxsgqWZBld/Cx288iJ6Y+g8ZXDGTLzbqwaXC/wHXHMU+gBM1QF?=
 =?us-ascii?Q?vwcwLR5/3UuQEZjhZjGTvyU6dqGP7xvGlI+Dxtd1Vy2PCfhZlsBmsJyXZmew?=
 =?us-ascii?Q?Yb0j/7ob+pXb5/+bMAvdVvwUjoXr5qvg4AXp5IdzoeV/ViOqK3jMrqJCSDZN?=
 =?us-ascii?Q?p7gMCryDj9yEoCUpfBWMexJjINTy9KRorKNNN10ZoBPiQ3ptvkwmm9WIiArE?=
 =?us-ascii?Q?J1OgM0OxEhZl0zcoe1Ocr1FT/1SEClcrxWbixj72NW6ypwXuvL96VRdl9fqk?=
 =?us-ascii?Q?7DJy9nAQr5YySZPyzPkAr7mgNYHQbVIEKM9K72taNxxTRbn54GQrrIoVwAfO?=
 =?us-ascii?Q?wNBSdig6UQE3uG62cElTiOZh31OvxlNCQLJ9mFz2W7VihIbePnYC6vtXXEaF?=
 =?us-ascii?Q?fog+xOYb0KHlQpMOSj64G9n3O6WXOTcEEaARCz5OuB2SIq+HLGl3EXysl4Ql?=
 =?us-ascii?Q?AatSBcIHNEwsto91MTeP7bwSzsbTxlfxz23v0cxxF20WA7wx6STNi5vu257R?=
 =?us-ascii?Q?kxLSQlnX6XzZpJLPNKdzCXaBZXugm2uMwgYe6LV/KImF9ZO8g00vYjXKOrpq?=
 =?us-ascii?Q?OobrcvMNP81aP6Nn2JOShLjHk0nCQt48TW6bp7VGkhHZLVgU47GF/Cg6va0M?=
 =?us-ascii?Q?N6qhgLN6r+xXQcAX4P0AFBqIR+IElB+hC8xPBMan0p8KYAxngWKome1Qj2Uf?=
 =?us-ascii?Q?gU+/l632g7Uhxfs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 18:57:52.9168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 228c7ded-1bf8-438d-a8aa-08dd6197caf9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6479
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

For SDMA, we still need kernel queues for paging so
they need to be initialized, but we no not want to
accept submissions from userspace when disable_kq
is set.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 9651693200655..edc856e10337a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -129,6 +129,7 @@ struct amdgpu_sdma {
 	/* track guilty state of GFX and PAGE queues */
 	bool gfx_guilty;
 	bool page_guilty;
+	bool			no_user_submission;
 };
 
 /*
-- 
2.48.1

