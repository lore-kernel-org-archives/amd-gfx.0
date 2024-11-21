Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C9ED6ED30
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 13:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84B9310E954;
	Thu, 21 Nov 2024 13:33:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LnEyO5Wn";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A181210E953
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 13:33:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFOodM0hL2sznSpCJ0qu8AvBfGgcD4MXvlMcl5HLSJrxvLJCmPQHAI0D3zxCBA1GDiuY/j+rf+HglJ1cV7zeCQzOm8i6YbHObp6PsyCuCrL7AfHurtyFJGx4NMPn5l61L4wxrfbkl1zRPNnlkMalOnYbqyll4Hw+f2Pf0XOv4eK0RYO2ty1HN+/b84elMlM4mO/EqUf2rwtrAA88XuQlTNvGnFoa7Fl0xKv6eeY50j6tiC4NmG6dhvG5uFMSA135YDyKnxrGf8COtRjYz0tKhuU7fMlepFp9SliSZW4FFB2N371wwN/rceYzB9/3kklySfLxZ+WwBf35wzs6pVFpDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3Y619e2AJKQD8S9f9kjYGMuLeR2mwuvaTZfgW2yLR4=;
 b=KHD8QPIczw1eEUdUJB4gZK15bVkJpkeZkJpenMu07I0uPCeMoGewxtpxlzykIP4Q3iTcmm0yem/++xklMx1rIuIlaE1pL1XRrQFYBEFPRFW74iIY7Td4FKAodphUkplykigjVjCiV+q4/Op1rPjVcmFU9OWl/DmlIEJ24b1DnJP5dNeMsg99djTmYP6aN3lC3noFVQVpDI8HPVuZKQU3yGNl5nJlhCgfJqI7p8hSfK2ccuN9XFsUrpEy1PFuOhzpZcL/5ECggq2/84dzx3KBFGBFTAp73ZUjfaz2bef/1wezCBiBSN6Ekk2WKf9YDEZclBP/Cz+3kcXUVHz1/+eMJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3Y619e2AJKQD8S9f9kjYGMuLeR2mwuvaTZfgW2yLR4=;
 b=LnEyO5WnFsbLb5DCUL0WkudWq8sjMI9ueVl8BufV3hTOJCv8YUiEs7I2rtPnk7+An3VhFF/dC1v12B+zbA0iRSG03KBr3MwDmIQSo9BCJLxwmzMI+nZ/TcUylNQLJSRQtLiNqJ+CGGeaIxLmHkXdPnb/pcD+anXNUckDtGTKBBk=
Received: from MN2PR20CA0019.namprd20.prod.outlook.com (2603:10b6:208:e8::32)
 by SJ0PR12MB6927.namprd12.prod.outlook.com (2603:10b6:a03:483::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Thu, 21 Nov
 2024 13:33:45 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:e8:cafe::f1) by MN2PR20CA0019.outlook.office365.com
 (2603:10b6:208:e8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20 via Frontend
 Transport; Thu, 21 Nov 2024 13:33:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Thu, 21 Nov 2024 13:33:44 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Nov
 2024 07:33:42 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Somalapuram Amaranath
 <Amaranath.Somalapuram@amd.com>, Arvind Yadav <arvind.yadav@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Subject: [PATCH 8/9] drm/amdgpu: enable userqueue support for GFX12
Date: Thu, 21 Nov 2024 14:33:06 +0100
Message-ID: <20241121133307.594-9-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20241121133307.594-1-shashank.sharma@amd.com>
References: <20241121133307.594-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|SJ0PR12MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: 27043d8e-a775-487a-0691-08dd0a311ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6KlGMbv8ZfnsUNKYt3aD20cSFOeqfzE/PULW1v6AF86bpFSzlVzjcuN8DBkv?=
 =?us-ascii?Q?9zxaIF4ugTmFSL2zPeVpujZ/r7ZoyaBPabAURBO7TOoSbLBjgEhDNENb3m25?=
 =?us-ascii?Q?yFIlZBxCk4gxZ/ofB2Y6pmV+yR0w2UTn6yTCoDW+doudiRiZ9TAFFFljWat/?=
 =?us-ascii?Q?9SI/ggtOD2shtE6h0DU1b6e+S8M0fMrZe1fQSElZNENW8w+te3Pw5BPoqx0q?=
 =?us-ascii?Q?7MnHb9zlEzIMu/HKl6bUybuWUzrDd/evAbnyoWD8CiOR72f0wxAS8v/ENc/7?=
 =?us-ascii?Q?7sPYqqPFVOnUYP5DBEg1WMw+ImJ6qIA9nrpS6ZzXxiTrTKtR33TZnDmIPVkB?=
 =?us-ascii?Q?kgeHp9SHaLvBlQEeCYCDrEhbQvZCT/xQeGNWYSPEAo878RJPAeNfWcbD/aOf?=
 =?us-ascii?Q?0r7VOeZMWM7kNmLhabhkG/Zl2+6hH/h6XaN5OTmzZg6yUfmdVCNyYuxSawd9?=
 =?us-ascii?Q?FnQqB8jMxQsRAPXx+ue3WRDoKmLqXkNts9W8daebh7ABskfsfaQWu5cYdgdq?=
 =?us-ascii?Q?XNOoS07FBFJgTx6s+yFcsQVvber++8Um1E3aAZBVrYYJkeQXRSOu07VknSDv?=
 =?us-ascii?Q?CqLqVLbSZilbQUZuIMaaUs3nFXpH9Lx1xZFwwezr3hE+s0gqq408T/kZnGAm?=
 =?us-ascii?Q?Pj/yLOTrSSBN8lDbVvuXx3LZZB6sBklittIpZismdjeyVZijRd8bTWTBmR/l?=
 =?us-ascii?Q?3kGuop4+wZwucm6EHbGCyYqGPNja/kmIPhpyfxhM+eSNvIDw+ri8Ykek9Uzw?=
 =?us-ascii?Q?RZo4Mlwb24oin9AmzfgIEpWx6Od7Mu5543q46hqoConNMbsEU2togRWY7bfB?=
 =?us-ascii?Q?eCn7GtnwF/PrOpmoCW7L89apTCEIsoA9T/GpSDTA03AJS+BpaXAYexT3kPjj?=
 =?us-ascii?Q?ddrrv9UG0ZtPFAHvREUMaACuu48dwHEMpfbQ9FZP/t5ZpIKVuhdKWroj26ve?=
 =?us-ascii?Q?0BZSPIDTYIx2GuogNkLtg6kcabl6ETaupuSllG2wG8goFrVDyvx+d8WCMkER?=
 =?us-ascii?Q?bA8Ed0dli0o9STZrfCr4QoM6PwokcvNvGmM3cFGE4pcCPRHwyKjzYqkegw8T?=
 =?us-ascii?Q?AEgGkiCuACIKujQuc/uy7wx1jNlQVg/qrQLCcMKkuBv9P2n/NUOnaz9nBx9E?=
 =?us-ascii?Q?0cdX2M4DXDyq8Kwxe91i76K4bqA2o/6ric/pdcfR4kxSlBUGpJaPaI3Fu+wD?=
 =?us-ascii?Q?V/FWoSTQlgh+wQ4oXk7Pbs18X/NFx+j0XMmwLD+QFZR+aAtF4hOkiVHQNBIn?=
 =?us-ascii?Q?SDZYhvfqSLkgrtkYgyUh7yoZK33t4lT0hLovXxIbnSwGqwJrWSG29sYZH22N?=
 =?us-ascii?Q?KXTAEa0392rewFxG9sk3sq9ooM0edhlHw08dWjVnHj98sDxkyWTTA/s1ZFg7?=
 =?us-ascii?Q?rhcHvnRHGJiJ7mrZPPGSkbZWA+ej84+5DLDAX92KPfVObGykGA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 13:33:44.1757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27043d8e-a775-487a-0691-08dd0a311ec5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6927
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

From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>

This patch enables Usermode queue support across GFX, Compute
and SDMA IPs on GFX12/SDMA7. It typically reuses Navi3X userqueue
IP functions to create and destroy MQDs.

v2: rebase on proposed changes (Alex)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Arvind Yadav <arvind.yadav@amd.com>
Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 3a7532db9b8a..b151a75cf88c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -46,6 +46,7 @@
 #include "gfx_v12_0.h"
 #include "nbif_v6_3_1.h"
 #include "mes_v12_0.h"
+#include "mes_userqueue.h"
 
 #define GFX12_NUM_GFX_RINGS	1
 #define GFX12_MEC_HPD_SIZE	2048
@@ -1364,6 +1365,10 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 2;
 		adev->gfx.mec.num_queue_per_pipe = 4;
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
+		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
+#endif
 		break;
 	default:
 		adev->gfx.me.num_me = 1;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index fc9cb989aa6b..e243223c480f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -42,6 +42,7 @@
 #include "sdma_common.h"
 #include "sdma_v7_0.h"
 #include "v12_structs.h"
+#include "mes_userqueue.h"
 
 MODULE_FIRMWARE("amdgpu/sdma_7_0_0.bin");
 MODULE_FIRMWARE("amdgpu/sdma_7_0_1.bin");
@@ -1326,6 +1327,11 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+	adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
+#endif
+
+
 	return r;
 }
 
-- 
2.46.2

