Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62640C25B10
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 16:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4131112575;
	Thu,  2 May 2024 16:32:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rmhkn1Tb";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 136CE11258F
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 16:32:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCCK/f+k3i+43/TbaGfWqYKmesQm3TfUSiH2mZoQBnwx7aoWJOP/c84nD+6E7d8c+3jd+hNBFSqlHZRvG5Stz9TLKcijL3Jl3gPrcdte6AaqhDw1+pMmjRd5poK4xgO38EUF0IrZ6pBZY2KpLZDLclCNEkRe6noL67NKpqCU922+37gw+aL4r/bDKFEv2jNNLh3WzZkLk2CfcrLvufkxmRTVzKV4D9el97QcET2rdZSv0bIBTOj0P0KhnE7TwWIxGzW+PdpNjreLDArVGKMVfBV3R6Gg2iKe2V6nQz9cC9cViLDr4Nf/aAvgDCMdeF1V/gmE8i7bHra76QPs1XHjaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GVUBhCMSEDYoaftfE9kylh3qEtHOhDuxeqtP9Qi/uU=;
 b=YVnydnSSucFjtinRcTp+QWadijt8JBGF16uXFymEP6qSYSoZMxiIyxeLQIOzNGRKI2Y7LybgT/Q+H4tY7p3G+0jq5mQ9MJ0Mr5Y6zRUTJhwXGFWPCJMjCSuTvG/e99teeGBj9TulTHRFIVACREsweUCTad01jSYOZA5MrBL0wH9B6/XedETMccNL8ZlNKIbumVA5jxL/BJIESSOtmdVPfPr8455v8fuEiMqbsx5WvEEuh2csT3P9772KS5QaHdfjmqenLsPwwAYVumZhIrn0JsBGkJ1EZ7vl1vygo/cRyURHCM2sjY09fZDEExn4lzGrTyDzxGvjzRkfEadgUlX4NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GVUBhCMSEDYoaftfE9kylh3qEtHOhDuxeqtP9Qi/uU=;
 b=Rmhkn1TbXvFmQBW0i7KZoKDa63n60Z+MsE4MOZX6r3X+pXB2fC44oXEQd4skyAP0VzT0MX71ecumeTHWZ5a1IcKGBI2cimV1jXrJA3q01xk/WBZaOHniJqDRZxQWfpe9cCIBPqmoKW6fVG2IRn3oUDmkd6ddDws3pwS4lGipBak=
Received: from BN8PR15CA0034.namprd15.prod.outlook.com (2603:10b6:408:c0::47)
 by SJ0PR12MB8137.namprd12.prod.outlook.com (2603:10b6:a03:4e5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Thu, 2 May
 2024 16:32:43 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:c0:cafe::f5) by BN8PR15CA0034.outlook.office365.com
 (2603:10b6:408:c0::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Thu, 2 May 2024 16:32:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Thu, 2 May 2024 16:32:43 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 11:32:36 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v10 11/14] drm/amdgpu: enable GFX-V11 userqueue support
Date: Thu, 2 May 2024 18:31:48 +0200
Message-ID: <20240502163152.1382-12-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240502163152.1382-1-shashank.sharma@amd.com>
References: <20240502163152.1382-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|SJ0PR12MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: ef9bb969-157b-4d9d-85a6-08dc6ac57e02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YzNadFunChWD4GoaY/suCvZb6skB7bT6IknCiKR4XeKVa7FeI9Kw/r+LHxh+?=
 =?us-ascii?Q?A3bI4giSi/60gTp0rGaI6ffrdfsvh4NoxIwPB92L/vDLZDe9FlX97iunyXPk?=
 =?us-ascii?Q?MiPD1Ab0B9ArfsldvyCwqvv4r3rKxhEFyzt9EKxoG8291+t43WofJqZa+nme?=
 =?us-ascii?Q?AKgT8+2paL9LmFejuZCARaRNoT8bYLfRB2IF12PSFXyT7NjiGVDS8E7sWDxQ?=
 =?us-ascii?Q?r+nGZWGuW/nfJTFEvvtqMlPKm8XPaU0bFzFIORU0NVJEqOjsUvpIHZTtBvU3?=
 =?us-ascii?Q?1H/DBAjneRJEsPNSeYkaB0TYW3yM5eDpr9491BT90Eu7Qfq7lCt1pF5+lPar?=
 =?us-ascii?Q?1Yglj4dLD72d9yHmOyz6pv9EoCw+5dEKvpO2Y3KwCpxjshhuaUpkYjbJCgAi?=
 =?us-ascii?Q?n6/a/7rEzDxTJjhXK4Htys5aGN9EE1vX2n/8L2kqEUiPvSx5of7/xI+22Y/D?=
 =?us-ascii?Q?3xQWuxRH5IlUEADp22+GdrZnPcFUek3QNB2WpZ+47afupbS44wVqQkpymn5I?=
 =?us-ascii?Q?BpGJcq822E3vt6RL+a9BPhL5jLxxOAB90CXycdKjP04Xo/8NyX25NNENKa+/?=
 =?us-ascii?Q?pFy++5rIlCY/SfXxFrB1w4PiWz25rPlz5F5MxHdxkcihmBHyVdMB6VJoCBs7?=
 =?us-ascii?Q?uMY5xxTSgK0RbnQXQ5ySZIFhpZyyC9EQXwfxwTREdV8V8XSuoQp8CYFzew0i?=
 =?us-ascii?Q?SX7c9Hsiyvx56umzssnFI7Sb8UCEgzoJvR58sDXWqrsFFHzPxN1lzI2xQXyE?=
 =?us-ascii?Q?d4Z7gyFzPM+wvLWcCmT45/v9fR5RT8Xvr3jIwEPL+7Z1rlFrBfYjhY76hhpp?=
 =?us-ascii?Q?DZP/8daVHl9DEfxWlbAHjcDi9DOr4mA3jiatqmqhU4zm98fHsXJ5FLA5k5mI?=
 =?us-ascii?Q?A/CkxvlyLnjd3UnYcLYEH0ta5LQO+pD5cUZy1Vuhe+ecV+X8wa5q8zIGOqzM?=
 =?us-ascii?Q?A16OXTZ0TYpvSt1GtqSL/vlJiVt7ti4LHcQN9UF46q2XoALsrncjqZFjklbl?=
 =?us-ascii?Q?zdwVZ8BjFNl9micPrQxZi5vZ+cDGyF6oGqaE8IUYdEdWyoda17VDpKZ8/DDt?=
 =?us-ascii?Q?U7FPn6EyksD0+UcwOqN1CF0kPVJqFrzGobBH42/pDHb9o6KcdK4dlumUDTi7?=
 =?us-ascii?Q?1vJPn7DQcqcdxvyZiLzIuSAy/g76zR1cRPFwfOCsfgWBjKRHWXVZ/vSuDxwg?=
 =?us-ascii?Q?1C9d2dMyjhYVP5+LmiGosbTHUoPuRmTPw5Rjz3Ron5BeS3jVKBdBaENaAN4O?=
 =?us-ascii?Q?f0FEdPjMMrzkodSUSvWV/C10rkMxqPJDQeCPzEH1dwEvshQKOdnFkE33JTCy?=
 =?us-ascii?Q?KmDveOigLfY2XcSiYAa2j3D9iqVKz8Pji8B3R43pRLeAWRo6lSy3w6kBbYmn?=
 =?us-ascii?Q?YJVM94bF3/klLFkqCtHTmRIh1MbA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 16:32:43.3713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9bb969-157b-4d9d-85a6-08dc6ac57e02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8137
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

This patch enables GFX-v11 IP support in the usermode queue base
code. It typically:
- adds a GFX_v11 specific MQD structure
- sets IP functions to create and destroy MQDs
- sets MQD objects coming from userspace

V10: introduced this spearate patch for GFX V11 enabling (Alex).

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  3 +++
 .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 22 +++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h                 | 22 +++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ad6431013c73..888edc2b4769 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -49,6 +49,7 @@
 #include "gfx_v11_0_3.h"
 #include "nbio_v4_3.h"
 #include "mes_v11_0.h"
+#include "mes_v11_0_userqueue.h"
 
 #define GFX11_NUM_GFX_RINGS		1
 #define GFX11_MEC_HPD_SIZE	2048
@@ -1347,6 +1348,7 @@ static int gfx_v11_0_sw_init(void *handle)
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
+		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
 		break;
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 4):
@@ -1358,6 +1360,7 @@ static int gfx_v11_0_sw_init(void *handle)
 		adev->gfx.mec.num_mec = 1;
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
+		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
 		break;
 	default:
 		adev->gfx.me.num_me = 1;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
index d084c5754273..80375894c4f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
@@ -180,6 +180,28 @@ static int mes_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 		return r;
 	}
 
+	/* Shadow, GDS and CSA objects come directly from userspace */
+	if (mqd_user->ip_type == AMDGPU_HW_IP_GFX) {
+		struct v11_gfx_mqd *mqd = queue->mqd.cpu_ptr;
+		struct drm_amdgpu_userq_mqd_gfx_v11 *mqd_gfx_v11;
+
+		if (mqd_user->mqd_size != sizeof(*mqd_gfx_v11) || !mqd_user->mqd) {
+			DRM_ERROR("Invalid GFX MQD\n");
+			return -EINVAL;
+		}
+
+		mqd_gfx_v11 = (struct drm_amdgpu_userq_mqd_gfx_v11 *)mqd_user->mqd;
+
+		mqd->shadow_base_lo = mqd_gfx_v11->shadow_va & 0xFFFFFFFC;
+		mqd->shadow_base_hi = upper_32_bits(mqd_gfx_v11->shadow_va);
+
+		mqd->gds_bkup_base_lo = mqd_gfx_v11->gds_va & 0xFFFFFFFC;
+		mqd->gds_bkup_base_hi = upper_32_bits(mqd_gfx_v11->gds_va);
+
+		mqd->fw_work_area_base_lo = mqd_gfx_v11->csa_va & 0xFFFFFFFC;
+		mqd->fw_work_area_base_hi = upper_32_bits(mqd_gfx_v11->csa_va);
+	}
+
 	return 0;
 }
 
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index f7313e576f06..6798139036a1 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -407,6 +407,28 @@ union drm_amdgpu_userq {
 	struct drm_amdgpu_userq_out out;
 };
 
+/* GFX V11 IP specific MQD parameters */
+struct drm_amdgpu_userq_mqd_gfx_v11 {
+	/**
+	 * @shadow_va: Virtual address of the GPU memory to hold the shadow buffer.
+	 * This must be a from a separate GPU object, and must be at least 4-page
+	 * sized.
+	 */
+	__u64   shadow_va;
+	/**
+	 * @gds_va: Virtual address of the GPU memory to hold the GDS buffer.
+	 * This must be a from a separate GPU object, and must be at least 1-page
+	 * sized.
+	 */
+	__u64   gds_va;
+	/**
+	 * @csa_va: Virtual address of the GPU memory to hold the CSA buffer.
+	 * This must be a from a separate GPU object, and must be at least 1-page
+	 * sized.
+	 */
+	__u64   csa_va;
+};
+
 /* vm ioctl */
 #define AMDGPU_VM_OP_RESERVE_VMID	1
 #define AMDGPU_VM_OP_UNRESERVE_VMID	2
-- 
2.43.2

