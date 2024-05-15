Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A2DC25B79
	for <amd-gfx@archiver.kernel.org>; Wed, 15 May 2024 00:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E45910E0F3;
	Wed, 15 May 2024 00:28:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qTNtRMiG";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CB6E10E0F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 May 2024 00:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9E5MGmPnuqfOP4sq8MyBUtltsr04NulInY+8otpp8tE9tnetgysJb5wx7PpoJr9j2aFGDx77zkzlAhS9cjIPMby4deETCB7eyOs3RhGNaao4K39i7SnJ1z3IH0h5wvQI3K5t/G3yuZ60Vu1iPhubgHL16G+JsySxSzLbPESF4R/n6hv7ZRsl3w0zv6tqBTfMPHlBZaSLCuWlhedWFlarFes8WCTfnbI+Y+q2p4iHIxjF3HgaxuYvib4oSrdcIYa3sGUGVuLFz2Cyy000OdHqxi7ji4d1UiFIlmJSLSMLcGo5Ws1zxWhmBHtmkg2hAcgg48c39+57iMab8ra02tnKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eT9avFKSaOVahpsJQxVvz4ddsGzRBFEKUGjmPg5NR6Q=;
 b=Kt8nNSFwvB2wEatxH1WTR2tifqAM/Ii9m3gKT+ZIWB1YVur8M58AJRf99j/ZEzY1vcsyLAOzwSGglzPv4g9xa2igMzoH6iTY+xMYLyR8IQnFDDB7DEw2OsEIxfmuB5qoB3fQ4+HxMCKNLRiU0Kl92vDXMRIZHG4TtPAANvQuS6QMOd5+M8C8s7bheoV5zvnZ1ci8erXPZRu5wAdnVeUrhXMsPVUqyy7uMxxyqdGRTeO6i4kQ1x1xJ92VhKWGPcto2JeZY29jx+RJDe2xpRvJXRxRTPOGS0d3Zm6snE4ArPjgD2ZpgYwE3R+A8rGr7bW/vKs1CVteIpaBz6TjVQ3z/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eT9avFKSaOVahpsJQxVvz4ddsGzRBFEKUGjmPg5NR6Q=;
 b=qTNtRMiGymg5PE5MNcioxoQyhk6Gu2ZxlD1jlOkah678BUcGLG2HeOO+yWbTba83Nl+z+K8OSemTVMXf0XCU2MAiy/UGVPt1Zfn2IuqHRusPCB/RwIT6m0OTZsJ1nZ2q6Q2/zEexoD9mlrCm2QZqTQEys17F03VtdK4X8Zzx50E=
Received: from DM6PR17CA0010.namprd17.prod.outlook.com (2603:10b6:5:1b3::23)
 by SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 00:28:18 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:1b3:cafe::e1) by DM6PR17CA0010.outlook.office365.com
 (2603:10b6:5:1b3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26 via Frontend
 Transport; Wed, 15 May 2024 00:28:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Wed, 15 May 2024 00:28:17 +0000
Received: from ssomasek-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 19:28:16 -0500
From: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, Sreekant Somasekharan
 <sreekant.somasekharan@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Kent Russell <kent.russell@amd.com>
Subject: [PATCH v2] drm/amdkfd: Remove bo NULL check in gmc_v12_0_get_vm_pte()
 function
Date: Tue, 14 May 2024 20:27:45 -0400
Message-ID: <20240515002745.634231-1-sreekant.somasekharan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SJ1PR12MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: d6904f68-78b3-46f5-f8f8-08dc7475eab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ze5rpahaQ3frL1xkY5LYSdwr4Qbz3fib1QaYn4GlO0ZQ4LvXL2bqMxZyQ55+?=
 =?us-ascii?Q?IV37mYTpjBhUL4CqqwSIWLE7CavNH3mtumu8LoSx/Me+u/RklFuiAHJwvaB+?=
 =?us-ascii?Q?w+zA1BC4HYm1ch5NoKGo1kBduqeZ37c+FOeUNXBYZ/hwOX8comtDyeniH47D?=
 =?us-ascii?Q?5s0Z6PeN2PXwUbEPKZUiGyaT0wGG+mcQHslpuX2PgM8NcBZv2D4F7tT/5hID?=
 =?us-ascii?Q?j+clClC1kUdNecBfi1oNxXsTPU2ltwAyQcYB1OtoUpWMmeQIisL16O5hUU61?=
 =?us-ascii?Q?2PnE24vUQuwweUy1yK3I+FE6Li9+xunbCgOe6ecZHJ9cOvk6uC5ZnFVCPMcR?=
 =?us-ascii?Q?JIKiM7PZ6mIyiBH83gPIWT/XgTv3hrXkt2hrfgcJpJRbHh+E+udztJcVW2GJ?=
 =?us-ascii?Q?4bJIIORXuu70fT8L+EwAcVbZODP+NFR9lYoUXwJeuE0b511miQ0g61IM1xv6?=
 =?us-ascii?Q?2VRF/H9vJMPRaVKWDv+87h1cL5P33Esz+lv4AZ5pOnfMiJnpoexGw0Ojbp0V?=
 =?us-ascii?Q?Rx7sIp+IpGJjrrryMxBHKSh0nI9zJC6IJigG7WXGOn9lAaZdrB7HPpLY8b3M?=
 =?us-ascii?Q?wRBg6uO+9/Hy+y9UmjXRrtZpbYQjzeIIbK3x2PXhfzCXXgjTCzZtpvBV0K5p?=
 =?us-ascii?Q?XONRVV0hmlpJEAQ5/5Ud/f0cGEMpUNRCB9wqZoIaRnmBtwrdsS0UUzncrtPC?=
 =?us-ascii?Q?88vREX9Uq5uznZ5P1qPoejwffdb8d8KySuyNO3kJ1d3osNFzy8Tk1qLpCsWI?=
 =?us-ascii?Q?7MUFJhUWOVrwogQASaI6YX4m1JXIxLDyip/OQOSMmIZvVPK9QcpzRPT62aSw?=
 =?us-ascii?Q?Dd+BU9TlWNtjCoxJWDaNjI0dLoT6s6ACaVdto8PfcH+pXeW065byylpCEne/?=
 =?us-ascii?Q?+Z4O76LXGIhTF+7zUkWLYx5wy9Vztz+qPF2AnCht/VmGKy4l25iChknJyn9z?=
 =?us-ascii?Q?sj5DxjIMIp6bT31KqIJPm2YARyOPwgOqNxsxFTQ8UigLeHDgI5WdYbYXVvWu?=
 =?us-ascii?Q?nVBnBbaEI3n2HfABg3uZP2uR1nAboFyoO8mZfah6/sGo7svqC3QCQc71wJZ1?=
 =?us-ascii?Q?lnbjyA7ia7yc4CnRvLJ0j87DGPNwBw0Hb+zUrAvM9HX+B46EGJ/Q/LK1NUc3?=
 =?us-ascii?Q?rm5cFbbca6ZLSbuqAh+ou8y/h08AwKorfBs1lBzWf1GFi9wvx/oGQoSuJhVl?=
 =?us-ascii?Q?R11/dWZpou2HtCtpUwP34KwE2y7dLNVWR8YI2ManG87iqCyiNdNFRnspTgBz?=
 =?us-ascii?Q?cwVEnCnYFTbstgzZcV4k3AajvNy54SnoEDJscUojEPmQRlINcllm7U7mf8H9?=
 =?us-ascii?Q?AZeoQ+WihG74BzESPbheNXCSRvZnD1LOUB6ubuWjlzFF6O3MJ/99yw2mmg+W?=
 =?us-ascii?Q?VmRFWtw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 00:28:17.6711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6904f68-78b3-46f5-f8f8-08dc7475eab9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289
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
Reviewed-by: Kent Russell <kent.russell@amd.com>
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

