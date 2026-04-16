Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31929F8D762
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 16:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C7E910E266;
	Thu, 16 Apr 2026 16:51:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m1tu6NwI";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011068.outbound.protection.outlook.com [52.101.52.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D2F110E266
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 16:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1LtArw3OHjMO2wH55TOyXy4ULdeYHn4RnPfO559zzGpON8JGC2Siww90IJphZs0BVLrmoE615tdB+DppilQdQi7ptqwX6e/P48XC/bGR2Q47WIbflMLjKAAWowBlKZLCDKY47v0vuMwQFTroK5BexnYvPOqy1cRascMOb8fV6y+0uX5UjzHIaLB2PXWXU7yBu33VlG+fYd6o5qm4HKEyCvfGuVeVCz+ZofbVBNZ3JOuyIe5a2KauhmAY1OXfsDIMeb1vlCItT0fJvOS/z/LuawhoaYcCbg8wsGRcarUUUwBOPEYjPSmPKfpSx8sm/BYGgduUVxeNR1C2jRsEfmazA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cxicPSsuHYAd6bvNgqZlek9eG5XgrfgqZAtOyieXSc=;
 b=MEYCGw53Sla/OU0XMqpDu+v4Tqr9HTqT1fXyPlYyVtK4mtQIloAZjZJjP6bNeTn7rH8959XxQvFQC/MK5jh2wfq+9M5dnHYjqa2csaiacd4XRWYHvqQTvMeyHxx2I/ZAFO3XLkGO3J5VujT49vPDUL5/glB3mCF/rVxZbQgktSBSQEsAvw/GZTsTJBjWbI25MzsOPPZ+RV4GRbSr8h1SNZ3U8dSTrX6MRaK8T5BJiyUz5bh5Z4QMo8WAPdcWN3aXAF5Ky1LYZjHStXRKjwejNnx4ucxodf+rmUmom/RnUs33UBB9y3kjmw7CYcyYt3UQaiybGA6kL0ujAje7B6NPJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cxicPSsuHYAd6bvNgqZlek9eG5XgrfgqZAtOyieXSc=;
 b=m1tu6NwINeoF79wo4DId/4Bk8Iv1Sq2ux7NpGRdfVpahAtiTM5bIalwJruYhIlwQlLZjZ1V3dTlj27RhuTySvOK6uYjzjLWVJmp4EHbYq/2gjyAUtrvxp1rbivYR62pv+Rha83mTcDl/IHw0VrAX4sovn31smgrt+zX3s1ex8oc=
Received: from BN9PR03CA0938.namprd03.prod.outlook.com (2603:10b6:408:108::13)
 by DS0PR12MB7849.namprd12.prod.outlook.com (2603:10b6:8:141::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 16:51:13 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:108:cafe::ad) by BN9PR03CA0938.outlook.office365.com
 (2603:10b6:408:108::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Thu,
 16 Apr 2026 16:51:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.0 via Frontend Transport; Thu, 16 Apr 2026 16:51:12 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Apr
 2026 11:51:11 -0500
From: Shaoyun Liu <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amd/amdgpu/include : update mes api header v11/v12
Date: Thu, 16 Apr 2026 12:50:56 -0400
Message-ID: <20260416165056.15459-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|DS0PR12MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: ddd8e44d-8a1c-4458-0a5f-08de9bd85dd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: N7mXzVkvrZg+1AGQqrmtT2UBdfe9qZwYGKPk1a/8tQaxdBkvuvtiZA6KPdtQa4Qhdkxy7U6Gxk+3wCmwYKldXkLewAfrioRlu3kf0YMtO1Lv4/MqRBMaVQCgvYMvOkx72+3yPZtit/l5qsnAO6XxPOp0wiVnZKQzAv99AE/5t002zW9ee3D4OAtbfK4v5ht/4qjrzRnhgUC968ehApSeXVpBqnNFAdQk1QnNu4xZxreOmfKT8G/go5V/AWiWps/HDi6COzmrdFO4ynKcQ/snSi/3VDROlzmUV2y+hL8rIUtn+ehS8YJZ4sXu40QAfbM5uNr4MibQzvxZY6j7IB6Ujp4F/Ac6FlqCWr2dQzYKa+HxP1wW2QySyVNvo4ED/tu/kMdtmmPRqA2tjFHDjio/ORB7VxZYstXO2HDiIbtemtS62MXBKqpNpiM/CsGo+Z1izVsWtMnO8hnTfNSycf+7tEudL3g6TobK4CENstohB9XeNkrQFPhRQQLP/Ycs7lwiCo6aVkKUfxR2PJCTib73yqUFdiPZnlvUOMxTkj49IKa/Asm3q+GkyxhdQGiKj1wRzi1bOCMtGmHA3EGU9NQg+GzhPjpOCbfoaaiRVulSdXvL2WNLjwRnkVQxi0AeCqf6gVHOAWp4VCfiy79Ro9Yl4YXuf7YnnSMqbiC6ODjV7H4NVrTofljqWS+cNzNoWV9eQAKtvl1M/EHxjvkQR13U5j06MwBjiGeFRN7JYyKMBW6+dmSuoNeDZyWHfpPK1U5Nracb76ZlAjfygSETr3xbzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YZcU1tRrwN2+2I2INLhzs3tuCZLNepr4wGDdn8QcFs+5Btht/wP95cY0WNA9aoRt6gsrhCdhsbBM76gIdSXDgKCnPCZ6q+VZWJ2QWt5Y9y03vol3RTPq5xrZYcDpl3IqS1oBt+4MGa1//kryR0so0+hk+xHa1Us/7uc91c6NQWhpgFzEayc1fQbbXvgMx+Pmawmz2y7hMOV/nwx/K1PujnTtw+7qcPAQm6KxnJiKDJKWXNc2fyR5r3uRKu7iRiO6oXeKALj3mC3jPpSYYLttrmZlmRQCl3KZHaNMkEY6pESJywJOfevwE1SMtK3TdKp5dBQ/wEvmPx2oRzyOFmjdPKKQ2xs312WHbJVK2ApS2Aw/4+0pXiACkPqlTlxEytUpcH5Rnns/dotbwYrF1Fd2jpSgY2n7aBq4rGzh+kQAiVvuLXsHsNj1DmwXNd24YuH0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 16:51:12.2374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd8e44d-8a1c-4458-0a5f-08de9bd85dd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7849
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

Update the parameter in SET_HW_RESOURCES API
1. Align with the setting of enable_lr_compute_wa
2. Add enable_compute_pipe_reset to enable pipe reset when compute queue reset failes

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 5 +++--
 drivers/gpu/drm/amd/include/mes_v12_api_def.h | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index f9629d42ada2..6644fabeb0b7 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -238,8 +238,9 @@ union MESAPI_SET_HW_RESOURCES {
 				uint32_t enable_mes_sch_stb_log : 1;
 				uint32_t limit_single_process : 1;
 				uint32_t is_strix_tmz_wa_enabled  :1;
-				uint32_t enable_lr_compute_wa : 1;
-				uint32_t reserved : 12;
+				uint32_t enable_lr_compute_wa : 2;
+				uint32_t enable_compute_pipe_reset : 1;
+				uint32_t reserved : 10;
 			};
 			uint32_t	uint32_t_all;
 		};
diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index e541a43714a1..08466d59695c 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -294,8 +294,9 @@ union MESAPI_SET_HW_RESOURCES {
 				uint32_t limit_single_process : 1;
 				uint32_t unmapped_doorbell_handling: 2;
 				uint32_t enable_mes_fence_int: 1;
-				uint32_t enable_lr_compute_wa : 1;
-				uint32_t reserved : 9;
+				uint32_t enable_lr_compute_wa : 2;
+				uint32_t enable_compute_pipe_reset : 1;
+				uint32_t reserved : 8;
 			};
 			uint32_t uint32_all;
 		};
-- 
2.34.1

