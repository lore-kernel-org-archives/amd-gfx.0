Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E0ACD4F3D
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 23:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6544F10E43C;
	Wed, 20 May 2026 23:36:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y5SNJcXJ";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010034.outbound.protection.outlook.com
 [52.101.193.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDF0510E434
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 23:36:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+IdKITdimuX01Qy/5X3Ts1lZGLAcE/T5iQ7cI0vwxOuULi1hAVtI0BnIewVnZ+uifxaDFIujOGS4VUShZt34u+ChZeEoen58R1eGAp6p/tP/ZM4j8jdtOihQmrOwp1QNbn6hOy5e3EXp/8sydkFfVUf4QXCh6YjTHYiyCW/gcyTLpZMj6ZzASFclUOQs6pdc8DiCehoUSiFzkDhmAvcsvg9/vSnMytxAF8Y+tAHIXKxDmq51JCG0UDU+52maRgDCcREi0j5rl+2Jsr1NpmEuzNQT24VnHgYWb3dWX56DwpBE3adBr3n0KZu5CRFUu1pulZFChPy74Na8uieWDt5qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WXqB51uQaU7excM5EsBzupwLczaJYU8Gfvp7ju+H/E=;
 b=TQDEZI99daBjk1CdNUr3bCagTbfdkNsL1cdm2mQf6u5GSULlYnX/OTScpvyL4MboBHo6LEXSGr/zfeNaM1tNw1CkrYavu20bByqt67YF3QqzsTNbXJtz97Y6CgjYS/cQCuY+u1fDsbotW4v+yYGbN8eTWteSveNUPC5mDOnAfXLSwobL7GIvxdr0h9FQDYw1XUw1Z8AfUxpAePii1gvc6npouEFSalNThxYm41NY6YQgb9Mi+bFWTt/CIja0rloRNjABjyzAFan4kH5Im3QGo9ZwPMrqyCrcs2IAMpSdSx/NKRjQfVYaEGyhcG8iCG7klq0dCavR3hbInkPC4tInwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WXqB51uQaU7excM5EsBzupwLczaJYU8Gfvp7ju+H/E=;
 b=y5SNJcXJGXhvnbLTyMRK1VYjrJRISBH/zzI4uGH74tATFpaM97C94mItyYDDm5O/m471KT3MWNmJdJ0CSsw9QTb++irICTx2+hJH6TKznkhyjwuGQ95iPWYKIk5UzIKKB1uLIE/lRVmveKQ0BZkFJ7G/Ii4u3SlMiILfzqF48Kc=
Received: from BN9PR03CA0150.namprd03.prod.outlook.com (2603:10b6:408:fe::35)
 by PH7PR12MB6634.namprd12.prod.outlook.com (2603:10b6:510:211::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 20 May
 2026 23:36:03 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::eb) by BN9PR03CA0150.outlook.office365.com
 (2603:10b6:408:fe::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 23:36:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 23:36:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 20 May
 2026 18:36:02 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 May
 2026 18:36:01 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 20 May 2026 18:36:01 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: "David (Ming Qiang) Wu" <David.Wu3@amd.com>, Ruijing Dong
 <ruijing.dong@amd.com>, Leo Liu <leo.liu@amd.com>, Benjamin Cheng
 <benjamin.cheng@amd.com>
Subject: [PATCH] drm/amdgpu/vce: Add overflow checks for size
Date: Wed, 20 May 2026 19:35:43 -0400
Message-ID: <20260520233543.2118183-1-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: benjamin.cheng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|PH7PR12MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: de02248a-9160-46f2-724d-08deb6c88e17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|11063799006|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: HD0SNztMuWWbfWMmPEwcqvzS/huqxLTc8/5Zpl+r86auQaZGQ8EUd53WzHkqB27/lzsKAWPzFhhMf4ROnjVQfWEeLhA2h4sp3Opoi+Puxt0z97jE3b9a47k0jTrJMg7vFyOESzbQ15Bo+pyTtwXBMoZ48OyxlMiJzG23BQkkuug6PFaRAK7Pn8+pc9KoejOqVC4edGw+yI9CQhCWredT3h9DLVL1F0K6OLbrroYAuK1hf5ilQ2Ir2gfqvlNNKzxo/6jaBSU+L2vRjajgXCOBdiFAYUOyeNdVBpYNXBYSc7MwXNog41xX2nsXUixTK5NGRfl6Ds6ljn1VfNqZX5R0PimqCG1ze077RrQfkhpxelEE6OXVTTGcvlFuaXf7uuvnpgAd9zlAOgoku3GORkqjisWrgaF3nF27WwuFj/Y69pl7IJL6KCJUS4Oh4kGD7iPXL16dZFydv8JwKRvI1LG/Oz11nESJ7vtxNl81HRBvsY/g4a1bok8Eu5DoVA0qkHSvr9aq4ZIszOGBuBL+4OM6CVdXBe1lDsL3FkZvEVMZnOoAlI3jfOzw2EXaPCiFA6b3rfWfuAVxAFS//7v53zx9O+ct/97NvSImq/hppv394oE678LYhoJ8SZq17n5lknUQgNTrs0ZB5g5ud6VO/yZwHg3tnYGRr7RtnnpFy6DqkNQqoqjRpsx3YMeg/yes/TTZlJ1LFor6QphbswaT9xQfMQ2T1nfezvWleTQq9t2nbdw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(11063799006)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XwSaGJ4YesJvgEu2oOeXJ8eyb1CKT1y8LXDnywrILHE7eNMCRS0kHaQfk8bUGvWleF+tUVKcnVwn23ZdGRJ8iNLj36oz/yp5StiWa5m3N+27Hd5ktuwCL7QcrZtJv+9gUimDIx7CaYNlXDQacb85/wjt9MN1miTVLlB/lqSz/8Pgrz+S2BddVaP8UGIKjeBpyRk6wjCRu8BGMpp+RZahg1Hrj0Ot8g/XVfpUdJPPmGfKubS8obtvkx8Jj7yzyXQDq855unfaONHG6CzYQaySc+qE7pFjfezjvgkuhDDhNMTyfm85/RSOAbhRMxGdsd1GLIqU6RKBHf9uhZ81dwF19tTlVWcMQwavM0Bg8eM/BH+tfmjqpni4Nx+6aMEhcn9uQDhZ+6cy2n5dXAj7aVxjhUmamI+2dQUGPqdPi74Ni16a7TXtSZyAvFbIdnNEeM8l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 23:36:02.6388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de02248a-9160-46f2-724d-08deb6c88e17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6634
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

Although VCE has HW limits much smaller than this and should fail
without causing damage, prevent the overflow just in case.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index efdebd9c0a1f..d73be4d7eff2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -877,9 +877,15 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
 				goto out;
 			}
 
-			*size = amdgpu_ib_get_value(ib, idx + 8) *
-				amdgpu_ib_get_value(ib, idx + 10) *
-				8 * 3 / 2;
+			if (check_mul_overflow(amdgpu_ib_get_value(ib, idx + 8),
+					       amdgpu_ib_get_value(ib, idx + 10),
+					       &tmp) ||
+			    check_mul_overflow(tmp, 8 * 3 / 2, size)) {
+				DRM_ERROR("enc size overflow!\n");
+				r = -EINVAL;
+				goto out;
+			}
+
 			break;
 
 		case 0x04000001: /* config extension */
-- 
2.54.0

