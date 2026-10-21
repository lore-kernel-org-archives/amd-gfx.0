Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70B4606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Mo8Y51+M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BD7410E31B;
	Wed, 21 Oct 2026 13:16:12 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013050.outbound.protection.outlook.com
 [40.93.196.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 697B610E2F5
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 13:16:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUnFwvwBwn8jG2IdM0R5+I/Nm2aG05xcQlHPS906OWExkm0qer1NiTKcdRshPjbAjw3fCClhY8kIgGBlkNBgVRoyLIB3UrLZDejtmTP//q7bafjgtTiaLP5KJjr2EMglf2Z5FirIjMmiBc1xFCmLAxACn+9dmq0nD3ThnPIFz6Iga1HgZ9KtqKezWFdo7OH5Eo35y3ZluS6MwBFntWkPf/rUTfL7Os4Qrawc9W3LBPcSVGm80f4yKvl9rJ+VCs/1hcDk/TROTi+37JQeaH/37aDMuYg/VL5Bas5F/TlUcSr1Mnv//MDBn+6EGsYy4LUTKUCE4Fyvao+YSKWrbIlMTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waa5IcuGkJhdTy+UBAakGvzj6Sti3HsrcazBLhlJBNo=;
 b=Fy4/XM2dafm+t/dVXDNOwc5zzUyq/eBcDGclqUq0XoE9WaaaQ3fAKm48AzA1lhM2CrEoNwzKY2V+Z+NdPmDQB6NyfjJtbdlfXAjjtoxbqn7mKeXwZ09T0w3MwoNRHMnys4z1xPYpCr0hv0+co6GQ5KT0ZabMyCMw30F/AK/mf1YVpqwGziEbcqpD58J4Zza5q/trRJ4b3x9oveIbZE627k22p7Zk8VD4pkw/olvhGVmWS7jgcsTtlKDfc94L6tBUkUBzza4pEqOd1eYGJPUvOQfSZl5X60fP0RCGRiL1erAmSexz4qKUeHXV9DKvHOeM/kNIAwPcchexrfwIoDdaJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waa5IcuGkJhdTy+UBAakGvzj6Sti3HsrcazBLhlJBNo=;
 b=Mo8Y51+M2Oo4/EASlbbgpYitFey8XL+b8NKJ1NngezXbnR4ASplVqEYQBKFAhNLzQUHEKDpR/oY6aLNqGxPrQseZzBrNO378NzJwFiat9qBsmC/sINNTbkSF16REnHj6GabbnA9mGhjgtG+U3JQf+mSa3S5ipsN6bzwBez0mvYE=
Received: from BN9PR03CA0503.namprd03.prod.outlook.com (2603:10b6:408:130::28)
 by BN7PPF9E4583E15.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6dc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 13:15:58 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:130:cafe::49) by BN9PR03CA0503.outlook.office365.com
 (2603:10b6:408:130::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 21
 Oct 2026 13:15:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 13:15:57 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 08:15:57 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 08:15:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/8] drm/amdgpu/gfx8: rework kernel queue priority handling
Date: Wed, 21 Oct 2026 09:15:38 -0400
Message-ID: <20261021131545.1962601-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|BN7PPF9E4583E15:EE_
X-MS-Office365-Filtering-Correlation-Id: 18034004-8e1d-45e3-f90e-08df2f7571cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|10067099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 1uC5p5QPmrdlhq7C6HsrcZnSIXAZrR6IutZarrkornQDQ73KTaoUoa+5aTvoC1MkM4eyjatZUa7nm6QpiMpf4VoQMu1BimGs2K51LCiTgb7G7GRC2f164K2ABkruuWkIVB8aybB2+UCvwHBqVwPEQ75sr1TVGEiJ+lM5GGBTZWhkc1DKPnkapPVoeUr6hAf8hSc6vJZc03cStOVGzwcoy229Vsr/q8bftnZkHhZq0wp9zwWno2IX/Jkc8zBuGG0DSbniApAIcZxNRCeSjZWdK0zliE8gg2IcDVarqD3ci8HruA3ELOUbdz7XQqt0iY6cCEv2oUclJOFcbH3Bes4PYyhUDwG8r6HjpettpjtugVo5vQ6B81Zn8cqsckxwszit0RLk815lm4pJX5xwCbpNXjYdcjYeKVM3c0Ywsu0oD9NdYhcZsa8DdZzQ91muDZohf4MXpr3fgVAubCXnXrrZ+MB10/IgXC0wwT2mdaXSMO6vhiYO6GGiPLg1lXr4Rpg5a4sXahQimUO0D0AHkpGaNx9IcPNpJ+bPC4DRX9WoeEXgNH7hB9XwEi56cHlkWxasQOd9yc6C67c/7BZf5H0kw9Ibtou03RUFptugdwXPhYvtdekIPeW0Kn9aS8+2OeGux6kzYPgVuNZfnP5E25Nf2QudDs375d4eDG9B6LbQyv2J1uXJbSgk0Bb6L31ao4+a5NdNYR5ShJQDn5drCVqk6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(10067099003)(18002099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f6WnoZssCyXsyzJrKZArOe3h1qellURXJ+jGO0tLiK1c5OlOH/NahzNJv9T3KgqqqEtRHFgdri4TQL/J1f0Wzd+tf+xCpUpU7DHvuAFR5nVyJEGr3fHxei45iX5OUUWiOLJMy8a5VwAsVrSLd4lR33VKzF+z1dhbhPW2at1nKIY3uxEWzGYQSdXMl6EhLcblOB0ccD8aH2cP10PJBCNZlIvVPx0iVigUdIwcE3RGyjSvXbu2TYBHcFQ46bE4A09HN3VLRtk+VEvXWBuKNg4YeEK72wb2/UQiwl/ibuYTsF8vNohoRQvlf0/h5MIPDc9FU0Fs8cQ6bE0HLsxy6YAIbDj+IYwvxnSRAEy38M3vWh9gYAePBtNxjzZZi36NEC4HbBuazrac16Cm+T6vW+OR7Ntm7bXLufhSvRHQeQ5oB22u0ioqPyT+PxaVrcJ4rwTO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 13:15:57.6592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18034004-8e1d-45e3-f90e-08df2f7571cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9E4583E15
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Rather than setting a higher queue priority which could
starve a lower priority queue, enable longer quantums
for high priority kernel queues. This will avoid
starvation, but provide longer runtime for high priority
queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 7e2f9c13dec39..80f3172f038c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4542,7 +4542,10 @@ static int gfx_v8_0_mqd_init(struct amdgpu_ring *ring)
 	if (ring != &adev->gfx.kiq[0].ring) {
 		tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_EN, 1);
 		tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
-		tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 10);
+		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring))
+			tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 20);
+		else
+			tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 10);
 	}
 	mqd->cp_hqd_quantum = tmp;
 
-- 
2.56.0

