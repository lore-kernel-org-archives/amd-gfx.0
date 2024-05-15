Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6426AC04FFE
	for <amd-gfx@archiver.kernel.org>; Wed, 15 May 2024 00:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9190B10E1B1;
	Wed, 15 May 2024 00:32:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nFu/x4LN";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1809510E1B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 May 2024 00:32:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwYE/nySxnNW4rATrJPNezuIkG0mu4RmLmJ5WbdTXk2LRJCy3Uxz8/7lGeCnIfqeiCWgmRzTWWsMI+qAmOHTF16cf4C4FzAFfobrg4tGYeHIz6hstBp4mGuwvoM71/c9rdPh5/261WIPXip2cFVjKocWTT0c0AaW8XOII2wfxrrb1VnIgNdF0pYIi96LQ+JdxuvldsyD8tGh69khF6Q1TGZjVIk3ZkOhoZ8xXdVNx1v5C7O4g9ZHQh2L+xPOIDMwGUKAxwSzYn2b2VhjJOiHxiSNTTp87+3rdfdAWoBdlVgaMiXL27mioY7zLgSQYEoahNykF/JgcuON8ov58InOmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5wxlUClpV+frKcCoRM9pgRG7QFcjqGVZtGc4xjbZr0=;
 b=cAwKd9lOvKu1y9gA/Dpbu7pmaXJRmpKi8B1FLKNedIm5FXFWcJ3cKuBbFGqgfZzvWh+COUdBu7dLsZGIrockmErE7U9HiDc/aAenPPiJiJtH4NUlplHB/aQ4+fXHZD6jE5KkHbnM80rqld0840GPZJ898aHj7N9sLS23ompt2j2V9heotZwXBPHA7YhpvOU+A6srfHETevcrsiEoAig8qPKTY9m6Y72XKFENS+9UCon31b/zOvXkGsFkKq/N7zjWW00GjA7iPJ26PNLKxPWYq8WAI8m1DRWMpiR/uhm4SXUuhoz8P2XFutaCd4iM/Edtc1kIORv6L2f1e9ckwctUOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5wxlUClpV+frKcCoRM9pgRG7QFcjqGVZtGc4xjbZr0=;
 b=nFu/x4LNL/rgRp20zmbWG7i4EChtagxtjtI9ouSN7UkQTK6w4E5rAo06R8S9G/+uOevRvCuhYklLSU25rihq/pJDrhCOlCL01uGGegS0Hd09WRt68NSt0ouiSqjksg75m4aT8O+KUuWFcjjF/Bi4QjqPlZDuL8aZtxjORggaSYo=
Received: from PH0PR07CA0052.namprd07.prod.outlook.com (2603:10b6:510:e::27)
 by MW6PR12MB8836.namprd12.prod.outlook.com (2603:10b6:303:241::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 00:32:09 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::55) by PH0PR07CA0052.outlook.office365.com
 (2603:10b6:510:e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26 via Frontend
 Transport; Wed, 15 May 2024 00:32:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Wed, 15 May 2024 00:32:08 +0000
Received: from ssomasek-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 19:32:04 -0500
From: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, Sreekant Somasekharan
 <sreekant.somasekharan@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v3] drm/amdkfd: Remove bo NULL check in gmc_v12_0_get_vm_pte()
 function
Date: Tue, 14 May 2024 20:31:03 -0400
Message-ID: <20240515003103.634408-1-sreekant.somasekharan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|MW6PR12MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: bb31304a-8cc7-4900-e4ce-08dc74767464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dRFpeHuhXbbs0zBRABUpC2WP9e1vSV5s1zp+4FhmmD8Fa5q6MtaXQlbQJWdg?=
 =?us-ascii?Q?xVQqlxjGCkyQ8v+kaKvN2nuIP5JjtE6LfcEzM1uP5znYyRg3320mxbVK913/?=
 =?us-ascii?Q?vzoTHtRwfYXRostaYglpHWLPkegD3gHZ1kPRbPczE6558PQ1Z9P51B0NIjfw?=
 =?us-ascii?Q?mKM+eMcp3dqXUb7M1hzLgB4PwerYbw0YAOXvl7EhFSqrbC14L2FKZW4oiKEO?=
 =?us-ascii?Q?GJxAlBMy2R8i3rEWGYmJ3bKgsrUiYOFwB9bmlsRbru3mFs0XLPaxCas/QDVX?=
 =?us-ascii?Q?p6wSIrXv4ik0fdR+oTqHQ2fwsXxpJMVxop6B2oMxR85c+K+iLceNJDiN25R2?=
 =?us-ascii?Q?HMK6lLnPnNpPLTje3QzL/fTBBG9/5NRhY9+Y6wYQfNBaz1Mi9B+rnCUqgRAM?=
 =?us-ascii?Q?jSi6d8legDstSPR99G9lC77Z5wZ4ik2axRbURzGSEeHzWeasVb+UXw943sqD?=
 =?us-ascii?Q?BapWREG7rsYpZwLh6g2ErDU+kEgDlJLu+a8j0hlF/eN1d8Qc6MkqbsZoA6Me?=
 =?us-ascii?Q?6lpvwtTAsaKv5yG0lQn/r68swBD/AWc3fOsxsIXBtCMTvFsgQZhA5YdhRrbE?=
 =?us-ascii?Q?IdWJp1fLBwqN4h2enQaFr/gUgidJpaP8WpW7gA4l5jkzUGT+ec2V5we4QYgA?=
 =?us-ascii?Q?CSnO0nV84cKkaDV9pXADu0WAzFboro7zXIoQlxl698zdXbwvk0uuS1H7EYTp?=
 =?us-ascii?Q?J1f4vr0DkEMj1x94gnwdti3b3e0krLuOwjYXkq6qxh0NUokIWsdnLtfJTpOE?=
 =?us-ascii?Q?v5BuixLoVpvQQhXF0IJ2cyy3H4IEqnMwinNzwjXnCWQ9n2a5T8lYn4jrlJJw?=
 =?us-ascii?Q?wCfCJdiiLPX6AkT7htA87uhhR1ukuajmCbNwKh4YF2s1f7X7QC3yLGeTtVOn?=
 =?us-ascii?Q?bXRLMnOp1UAszIEgJy2/lQjzyGhSyRuh93QEUsK6rd3FHtcIFRtrAfsbLlNq?=
 =?us-ascii?Q?jbwekREEuhTsiHKXQZunw1WW4/1OezcB3ju3O+4V4cgjAp8tVLCwspeK7Xn0?=
 =?us-ascii?Q?oo7BNS28XUE2NjV7PVzEBAtz2sbdIdBmfAnLY2M3RNxVS1Rq9IZ7yD18kRpZ?=
 =?us-ascii?Q?Ru7ukS3bFMUPBbF5HRxai+6qZNjWVRQQuVub11Fg4/6BHLmFEdHPZb8vcUC8?=
 =?us-ascii?Q?ZcixPkMDbkgpHOymXSrd5s4wWQYvuToF9DgnYRRdNP41nGQ0Zk8fcjbStAFa?=
 =?us-ascii?Q?56Sn42ENqGZBdE/rbUudGeijaIYtJVNec8fN2/rL/DMGi94eg5kaXD853mLh?=
 =?us-ascii?Q?P3VWsIH5mDOST6RJKIWcWWTf7OtflF6xztZ9TPRF6VzB9uQd3cNyRZU9ZT3W?=
 =?us-ascii?Q?ltvBOhBC+5tnvCOb8nlh6ocQs7JrOZgFkDMlzyfkhpQ2XdFwfJqnyETOQsjF?=
 =?us-ascii?Q?inDl3jE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 00:32:08.6490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb31304a-8cc7-4900-e4ce-08dc74767464
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8836
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

Remove bo NULL check in amdgpu/gmc_v12_0.c:gmc_v12_0_get_vm_pte() function
to fix smatch warning:

'drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c:518 gmc_v12_0_get_vm_pte()
warn: variable dereferenced before check 'bo' (see line 500)'

Signed-off-by: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 2b7b67916c1d..0fadebec9019 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -515,13 +515,13 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
 		*flags &= ~AMDGPU_PTE_VALID;
 	}
 
-	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
+	if (bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
 			       AMDGPU_GEM_CREATE_UNCACHED))
 		*flags = (*flags & ~AMDGPU_PTE_MTYPE_GFX12_MASK) |
 			 AMDGPU_PTE_MTYPE_GFX12(MTYPE_UC);
 
 	/* WA for HW bug */
-	if ((bo && is_system) || ((bo_adev != adev) && coherent))
+	if (is_system || ((bo_adev != adev) && coherent))
 		*flags |= AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
 
 }
-- 
2.34.1

