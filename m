Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D829C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBEB110F381;
	Fri, 21 Aug 2026 16:14:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n/zUe34A";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EC5310F381
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndjwMNHT8QmRLuRxqOZZ/GnyAx2vhW36O9i4eFUbpoFbihgITTP2BCR4ivFOuDFqPYwekZ4mdIt1Ny+FNxU5X9yd2NVWeX1f1qcP6SKfsAaE0AUT0ozsAfb8UyskkO75xpRyX5z+KGYHyjQrrc8D/YP9hvyQm7kifRUcTApRXypXPd3ktN/UpNk2sx4aNXqJaJL0GO+rf7DDAem6FXrcuG0L/OBJ6/WzSLPbPIDhJvDuLnPcJPn76lP8epJwwxvjvBWkOphJirHBx0E2v+yKGVREtTaFiepo47TItVhPi5BJiE+dsFa5P4aF8iHh5xuiNKuJw+L/DLys4A4ZF4hy3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p02Lzl1G6RApQictdQ8C+8BDUa2wbblE5By9m8SGUEQ=;
 b=ejQe72d3tSfx/4rR4j4uexWhADHwpke0pNfOu6bzwCFXy2KYsNwTOAwoBGkTX8NZcD0NnUtjqJ/lDsf/MCRnrtdNiaCAq3MuaO2OAC6ynFUPQscO5+lT1FUSpjVgDrWtyppXQeHbo5LbMgUWp1RdYao3XO91yEQAynwzU++njZihwXZ7cxs4IIfEqw5vzkcUEdN5TqUeZ5GETIcaXl2y8yaupXhCvqKfjpL07M/vrH4gJbtD+pjtjQdS+jc9hIkcR7oQ61xtKJEoTIkCMob8zsPs5DYqbN2ZsTf48hd9nh+umDpCeI0m46o9AJoYfIkDm57oWl8Eh/oy4Ob0PpDxPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p02Lzl1G6RApQictdQ8C+8BDUa2wbblE5By9m8SGUEQ=;
 b=n/zUe34AN1Z+pOm59us+r43qdu1ao1T2kDM+Wc7Lv3eup2CryhJAFuEqN7RvCqm43K5d+UNQ0cFqQDIqXaI6+VXCZpDpqDWcma//Mu7NtZtHDKvpA8BwR2jhzov9TtTE4v86ZYOOEPGX/g9E+DF8MYk1ALSVnMgFK0Fia7YEzHY=
Received: from BN9PR03CA0290.namprd03.prod.outlook.com (2603:10b6:408:f5::25)
 by PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:14:27 +0000
Received: from BN5PEPF0004698B.namprd02.prod.outlook.com
 (2603:10b6:408:f5:cafe::97) by BN9PR03CA0290.outlook.office365.com
 (2603:10b6:408:f5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 16:14:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN5PEPF0004698B.mail.protection.outlook.com (10.167.245.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:14:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:14:11 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:14:11 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:14:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Feifei Xu <Feifei.Xu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/14] drm/amdgpu: set reserve_tmr in
 amdgpu_discovery_get_tmr_info
Date: Fri, 21 Aug 2026 12:13:54 -0400
Message-ID: <20260821161401.754042-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821161401.754042-1-alexander.deucher@amd.com>
References: <20260821161401.754042-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698B:EE_|PH8PR12MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: 95bcbb6f-8ca0-4102-1854-08deff9f45cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jUk9JghHSxeFrIHHWlZJyY5/hrzEra23smU9GFPX3wNBns59QRPerDmFgJx1U5DvoPFwhmyrrRiwqFpFMFFVx+B1wQKTqPz895zzxFEHvZUafehLXSZxm2KI5aB1L+Sxei4/1r3YQ7xVIh11B4OBdSiqhbHiwFq081wsWDvDjAaHY3/lqLZhBx+LJTqwuEbvTO0P1nFwIJPDPA+fLiB2ewS61SsxVc9t0FvcdZnCgVGmOQffmbK0UjEzDu9Xwxs12n6ofGZrKuzMY044xKWaFrVKUjhw3UncFy6GyPQ4PljX+Sr8jbS/VRazpieI1wtSzpLwaS1FvEYaBngSvaZla7JS+VAdLlxlDh4KlsYvsscue0k4K4RRZeExWc9uamBFFgSN9eCXyYfCQdJh/GM3nax58RGi0tL/ECAvdCQAM9+hxlPQ4PJGeTeGPqFPaI3xR6GBN8KJ2HNA1GQ9T4LcHDOsexr77+VDkqun6d6LhIbRwHILA35bFbQ+vueb02WDa7UNElf5agt4xe9j0o7ds0scKKRHpJnh400wC/zMDg9HrQAhZjwkACKbBosNkv8rK2qp1jBIVT7ffWYcBxfyRb6fuinPXl1zj52tIjOhWz4W48e/8PF84Z6xeX4zr61CbwF9f4Uv7Q4G/Wmxu4sTzuYoFreNR6Cnsk7/jzHOdcOyXCuHWaY1eyDPOxl/piJKWPnU7Bypu8gOEhnoKwObDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iP86puTGVInsF7Vswwt4Ht7UY1Gs9OKUl95XdqGqUgJwnKPFvo/DapoBUqlc8RphxbrKpqkA8zh/qKjs3K4pixD3v2mRFGRRX8fA46wbUYFdKeMqkElikUcLmFrtO07k11pp6MfPKmu3fOgJY1eqN+8VesyQ2upy8co7X/FvLm70Vzzk5WG4xBtUtSx8u7e0VgUC0d8qiuysjv7rot75pV3pPLK21kJ8xTB8px/mjd+kg5/gn5OesKc6tyjwP+tF8qXp85AJLD9Cyt8wNF/O4hXjlrvySQLS9bqst/Avrrj0wLC3Oe1g45aBMuMuNe3n3Ynwpko7NmRS3LJCJobzU98qHqRi+R0j4jM0xyQkqzhCtxUgIydZ818xEaHOFhkEv1X4PTGUEWhawMXZP2N2NxtpSpNIIIBhKbK0ghAaNAUid/Y6anS8Rd9AJzV9npqr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:14:26.3845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bcbb6f-8ca0-4102-1854-08deff9f45cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF0004698B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7301
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

From: Feifei Xu <Feifei.Xu@amd.com>

If reading mmDRIVER_SCRATCH_2 returns non-zero, discovery.reserve_tmr
is set to true and driver need reserve tmr for firmware.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 5d94453e85c6e..6cc390da10f95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -357,6 +357,7 @@ static int amdgpu_discovery_get_tmr_info(struct amdgpu_device *adev,
 			tmr_offset_hi = RREG32(mmDRIVER_SCRATCH_1);
 			adev->discovery.offset = ((u64)le32_to_cpu(tmr_offset_hi) << 32 |
 						  le32_to_cpu(tmr_offset_lo));
+			adev->discovery.reserve_tmr = true;
 		} else if (!vram_size) {
 			/* fall back to apci approach to query tmr offset if vram_size is 0 */
 			ret = amdgpu_acpi_get_tmr_info(adev, &tmr_offset, &tmr_size);
-- 
2.55.0

