Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEFEC61DB2
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8516A10E9E2;
	Thu,  5 Jun 2025 01:46:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n4PtN1e6";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9825F10E9C3
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxrUURp2c5hpzu+hLpjWkX7GrXqZAUBea8CRKSnnQK/1b+eI345g4Pyp2yJYe3EJ+sGNT6gp/d8rPBd9eQw0FeNKVujhNZr1tSjD4gPsShWbVcXuKcb/EmKuSDirOzJSr1J9M0Rf2U2YCLKDm0YiUk478+nzXC3tmSZjAjpwDwSCBzgEr0SlPDTnmFNtnAco4Ou5N7TG2gyZnQehAuAQsMdGoHyoSo647QXYz3wcWKcO09Hr1K9DOYcLzNRsYUM0AChWTdgWLdd1HGqHW9gJO/jcN5wAAQH/D9lk4Yw/E47FO41tM6cvfiN+uNBbWwUXyNpg0zBGRrhy+AQ8CbyNSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGdhYf7eCMSbNA8fMTB/ck3ptbj0AmhDfrM14R3QUI8=;
 b=g1NtZRPQS6oHMa/djusA6cwgyHis4MbG5YLMU1LMO+VABkYUC7hCTfRqZQRcs8K8ARuehcbL/pEcKfg3jAUt79P6IpH/j9yIZyjU/hgGdKCDuykApfTa5TH8kS0UKuiaQUrnoZhuHqs7lDb0WgCyMq5O9wACLernveugDDfYQqo54WPGdmVCj7YkBuZHpCCaukmygAGH4oo6LLsHirKEa+ROtQaLP4nw8L/Drj7VgPwqE1qDOhQXTcShj66qOETLRQF0767bwAlnfrDzNV8vwle+155uUzhtDJ95Z+KM0NVXSchgZcY7szziRhIIv0oURU6EbuXohg4AR12csl0x6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGdhYf7eCMSbNA8fMTB/ck3ptbj0AmhDfrM14R3QUI8=;
 b=n4PtN1e690O46RLlofuwOTeLUFDmDuyneUFL0IzC/0BO+CRelk50aPDyEvWkt/AQAEghA2h1TGPvy4QD6YBrPcJhdoOoArHjUHP+ME8Gkw9f3PhPXburb1kiFdv3oYf29T50YoEfhKXO03WrzDjlLFT8fPmHEjGZ4R+xJPVN+48=
Received: from SJ0PR03CA0288.namprd03.prod.outlook.com (2603:10b6:a03:39e::23)
 by DM4PR12MB5988.namprd12.prod.outlook.com (2603:10b6:8:6b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 01:46:34 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::c3) by SJ0PR03CA0288.outlook.office365.com
 (2603:10b6:a03:39e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 5 Jun 2025 01:46:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 23/31] drm/amdgpu/jpeg4: re-emit unprocessed state on ring
 reset
Date: Wed, 4 Jun 2025 21:45:53 -0400
Message-ID: <20250605014602.5915-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605014602.5915-1-alexander.deucher@amd.com>
References: <20250605014602.5915-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|DM4PR12MB5988:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f0ba89c-f691-48ea-e954-08dda3d2cd89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?njxfcUi05u/065n7980tbeTpbhuKuKPPw3kmdOGDHyhjDjw42vYaO0KfleF9?=
 =?us-ascii?Q?TUVeyhConjQA84n2wyxm0rUkPsAVRed7euFtMMsiK9akZyZC8TzdM7Hz12jC?=
 =?us-ascii?Q?OlMfuYcpU8LhyWbBlMK2PKglo3rM6l+M4C9aM82kI/eO01HYjlp1RGB0tg4b?=
 =?us-ascii?Q?+DsiC0bNzAEeTZYWyXE9mT+9VlB9IH+2kLDodqTMgikcPMAYgBwyigIob3D4?=
 =?us-ascii?Q?8Y3ILLkyTJhpqt89C3qk8c1nY1RnVRZJ3WGPEakE8qSPEPJBDBld279232Bx?=
 =?us-ascii?Q?AtucDIwxOXy+m9/c4BhoBF6lwPyKNVpZ6god1ncgqo7YaXuiDkCBqFp9oPK2?=
 =?us-ascii?Q?hQxT85Gac5b4DYCk7EoqQbTF2c85vcuDAz10diS5ShVvk5qy9HIEHu1p0lnE?=
 =?us-ascii?Q?lV6nOhv1HjCWMsSC0ZvdcMJAodLhWwVO9GDdCcqllPlwpixa2V1CfD6yQNHr?=
 =?us-ascii?Q?XyBJmDC9boeSZBEboT7bNfN5I4HaXAKC49rAcGdIE96x28xXTM2B/YKTQ6h7?=
 =?us-ascii?Q?KKeFfYOWYYhMJQ+wkJ4OB8AT+ZmmT7tFdZkOCq7CbMvrPQKDOPAmG4ixWEqy?=
 =?us-ascii?Q?5fpCm0TSYFz0ugg341FZ2je5mUd8oTVw9j3xeqGQTQL0XBteR6RLIrkjKSwX?=
 =?us-ascii?Q?68nvr10/PWgHbUk7Ddv8yRY4H3Z6cuExpfy9dj0Pv1qkfwOHRVnaEna8A4hE?=
 =?us-ascii?Q?xV955O6Beg8EEroWMSCUaeloScUVDa9pIGCsR/F8PlGtqBboYYg8mjubc+CC?=
 =?us-ascii?Q?Jp2UJnnBLUdWXHr9mxal1/sDwgREi2+2cTeC1K+asxHqbFHxPcEJv1hbJE9x?=
 =?us-ascii?Q?jYPYdxZILrI//O2rDrpwNb8R9jmXk4gwKgy5hs6ndsbM2pqCKdJ3UrhaSZIj?=
 =?us-ascii?Q?fDKkX5SA7dFmuuC3NKshvUyYF9hGxETYa7gDyWDEZQch/sj4GpEAbyMFikum?=
 =?us-ascii?Q?Wna8o/Ofago8aid2Plp0gneyhtt9sn87PZL/HM4aIKsyRU5jfgWzDugSibT1?=
 =?us-ascii?Q?JjO6khXxNQcEKUHyR8jJ33HIsZIvU0/8+eJhZ0w/9vPy80xWFJu3nvvgumRD?=
 =?us-ascii?Q?cCD9wEJMabr4PanfGe7J6p2Z9mDrcw0d094NJyj5L+Q7eO9FgvdYzfZgaTdp?=
 =?us-ascii?Q?xyF9E4hOd/9hBYyLIGf8nBexs9p3H3nFoLNEpXFakpdRCT8bjCKMWJlF60f3?=
 =?us-ascii?Q?pvthmGkeocU+lzbdOp03w99txQ/C3IgXtlEnD3hwxDQCxwtMe6sm3KQLwErz?=
 =?us-ascii?Q?dSdfjsmRwPNl4KlrdhaDBweMz6h/t0RlfQu+jrtkW0euokONVZjAUOVGOma3?=
 =?us-ascii?Q?seomuwHW1YhdU4NIx+qh106C0VxPL/kdJf3SYW+K0UYmKvVTZgAfPzZP1DHm?=
 =?us-ascii?Q?DbQx3FHtredJLzkjwDqJqWe5FarGdCuE99MwZ4v6WDr9DhphmROrAwWAPmVL?=
 =?us-ascii?Q?9OnshcyaFYi+lsLbkkXb/nZEumRD3wvs4zV75aKmeOwbxuEbzW0pVbz0Elsf?=
 =?us-ascii?Q?Fp/+B7WiEWiwI72YL3wj9T2hmH3tUVYCPBO6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:34.2527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0ba89c-f691-48ea-e954-08dda3d2cd89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5988
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 9301d0ff2593b..4e644b645bd25 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -727,8 +727,8 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 
 	jpeg_v4_0_stop(ring->adev);
 	jpeg_v4_0_start(ring->adev);
-	amdgpu_fence_driver_force_completion(ring);
-	return amdgpu_ring_test_helper(ring);
+
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static const struct amd_ip_funcs jpeg_v4_0_ip_funcs = {
-- 
2.49.0

