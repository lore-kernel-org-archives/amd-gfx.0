Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17427C3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 11:30:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB82B10E962;
	Thu, 10 Apr 2025 11:30:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ballAFBr";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EC1610E97E
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 11:30:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIx6hG/5MhWynYa3EjsRM5Q4iQvm0cuUBoB/+mw6EQIBcZH1kZwPzU4+hrZEJWgcPmisdBXc5fnr8vQSw0DE5j+HrxcZBc8NfOF0W7YA4ahbxzZYhXmY+xicNkjbIa5XMxe8Vdt86DtfFKdnMwktGYEOKVR9CvHzJBduzqqlrTp8db83XgQjuuh+tqm6FqzFNVK6L0AjNLTLOiBaJAIk/sir5siTko8sA9w8cjvkaGwT6MNWH2C7TIu3rGUmkMTyHq3HZEItZw0s352YZ9vPhEeEgoHGataMThvkaExS6mpn+LzlnkfpAxX59kfb1lOi6gRyGe8RjnZMuIPV/lMW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7YFKKJuv0toP218kCUfZ3ujyAMjv9rY7OVdcKFroA0=;
 b=gzsRnUum6cLrWNRjexbOXhj2m59ue4JZfwbtLR7a1bFhXBMt622PxxVAWUFT6bzqf/VRBZ6E+qv7QFkXsKy6zxcvh+0GL1iaGABCAm5XBVJEjL8M+ptoQ1A4ltT+Qt1uyxnDGWXOJJehoQABXw9TiZhfUTkl5Ug5NS2Aege7htDdTrp2oXmpa9ynx/Hvd6PUcR1XoCJZzDW6I4NdRXf9XwSkNxOFwsT6Ln3Xmsr7wQ8vvtxXxNZqSDY7wkYlE/MriStI+ooSQ433FMGjx2dQYvqmMaZk9iSVlzC9E1b7XqHL3YQ07UveRr7l9hdMnmJAYXK1USfrEWGwr0L3jcsouA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7YFKKJuv0toP218kCUfZ3ujyAMjv9rY7OVdcKFroA0=;
 b=ballAFBrloDsDqWZiYimX2d+MVF/JoQQlgQ+CRs784kvxAIJBqmxLjjAPrCHL0DSHJ7HYHXAjXPHwnnGWEAzXODoKJ0NE9ge5LnEM6il5W8Wt02lMXTG72grpmpPBODtKghNxSh5eTo3o09TjqaF+GazcdvYPpZylB7uPi2oXAc=
Received: from BYAPR05CA0038.namprd05.prod.outlook.com (2603:10b6:a03:74::15)
 by DS0PR12MB7874.namprd12.prod.outlook.com (2603:10b6:8:141::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Thu, 10 Apr
 2025 11:30:06 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:74:cafe::1d) by BYAPR05CA0038.outlook.office365.com
 (2603:10b6:a03:74::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.19 via Frontend Transport; Thu,
 10 Apr 2025 11:30:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 11:30:05 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Apr 2025 06:30:02 -0500
From: Arvind Yadav <Arvind.Yadav@amd.com>
To: <Christian.Koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>, <shashank.sharma@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Arvind Yadav <Arvind.Yadav@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add fw minimum version check for usermode
 queue
Date: Thu, 10 Apr 2025 16:59:16 +0530
Message-ID: <20250410112917.13725-1-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DS0PR12MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f189fc2-73ef-40fa-ef32-08dd78230ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VHkCsJNyoeinS97eF8BDcLi93QUKy1gm9wftUZ0fh3lEoETjD3tk1j8RWnxp?=
 =?us-ascii?Q?OQESP4rn5ihw1z1tKB/Ld7cq2mUBIrbQFAr8rR2F3BSRSaD7ouzFtcbdqfrm?=
 =?us-ascii?Q?rKc0JeuoWwqx1mxWE4xLdvTW9ZEByp0qpBPVAABSohYL3S6JUZlUa+Yhf9Dd?=
 =?us-ascii?Q?YntjKJdNp/KTy8Btj2xoDzKlWoArkb2sb2a4jYPKE2m+KisaCI9omXGzc1La?=
 =?us-ascii?Q?8/rwVOfuiiXqykm7Yv47Q80vbf/gxkPpGHxJHkQrI+9KUt0Sdwamv3RHK4yR?=
 =?us-ascii?Q?QtQRsImucH7i4V4U0Z7RmnGMdtXB6MHqKHLnHhXUNw8KVGIFj7uOFHvnE9dM?=
 =?us-ascii?Q?xWUkcjDQTG4I+gJoyRkVzpfOAtWuZnrPb5G23ECK4EXNS2FwU0hNjrHMzVaY?=
 =?us-ascii?Q?nQrPdXfKKrZHvkanhAax9SB9Yyr4Qq/9vFHgo7slXPL2/f4tOYLC/seK3qqX?=
 =?us-ascii?Q?SZwy+4xVMVZyocA0iLzMgKD4Atg2QUwAgCETtqCkZr8lfh4PvMHtRFrJOUD5?=
 =?us-ascii?Q?y3cVvHp1b6TL5HjLjsUoqACuGhH6RtjPrDZK6G17Qr79Q3ZZN/8SwumEnH7F?=
 =?us-ascii?Q?rUgaiIdmeokZYHUba0Ee4PU+nsz9XH6G81e4rEFgaqRpPRp5I7s/mQ1p6nF/?=
 =?us-ascii?Q?atF+bPnt7erC7HJ8f/NEO2EtVmuiA2uXxCvJL5rJjdCGZ84446EjyGb4Ke5j?=
 =?us-ascii?Q?OqyJ9TuNlpiuaLPKxHoepYBaSKIlAIDy8Ql4jQ2yAK8nCfxVu1XoauKgs1jt?=
 =?us-ascii?Q?7U+y9pOE5GPYaygOUJ8IUsujeffD6NhQLnhF7qaTLuk9/0WH8++4nFZTH//L?=
 =?us-ascii?Q?C4IyATcdMYPz2yJEfyqKfwa27QxHGkz7u9ME+ksqM54TZroVvocqBoDPgNmn?=
 =?us-ascii?Q?BjPGVh0bjtSS+0IQgzE8ny3CwUiHbDsJBl3C3L4QnUiq545ng9xhOLiUQKa1?=
 =?us-ascii?Q?0m/WdO9oHbUntStRpGJwuQcZURY+2ltG/Md8+EwSwrTtYQ4t8OW2HX4kKBff?=
 =?us-ascii?Q?zKmorzg0+NzFjGHmIxBRUOmvJFl/MrFatOTgBB5m337LlE+chWoWm9FSwrOC?=
 =?us-ascii?Q?yPqxhlwZ2AJGOhUmj9XAr/UOluo5N7kjP59V2KJBOZA+IgSiaR3P9Oz+AbsR?=
 =?us-ascii?Q?VAtYdZr1G72/moiRTA7nX/gWJvETB9lBZhPyKDSpAULLkW9yG38jciHFNsiB?=
 =?us-ascii?Q?Lvm2b+r4mSSWAH1+pRdgzFd2YEoEHgNLRu+5MeEfCU9mgEFqwFvCYMRRa9ol?=
 =?us-ascii?Q?wKPokjxE3wZcdslsci9o7wpeK1bu6pFFZD+2aLCh+nJaHicKYecRMr1PhWD+?=
 =?us-ascii?Q?GMkoojS6ZfLw63JgRWUzy9NykRzUS4Lxr5RNmYhNDq29qtIoY+9FWjRIQbFF?=
 =?us-ascii?Q?KmimPawiNGR4vbJcr8XlnsK20SAaRnaAHFsniig57PX/eUJB/2zFFT+lIaYD?=
 =?us-ascii?Q?8PxjjTjmAcxzolqf5QtxReeJ6ol8g0MGlgby9G+dqaxC5BLxMM4U4m2kMZf1?=
 =?us-ascii?Q?ZM1ht1M3aBFM3FU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 11:30:05.6743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f189fc2-73ef-40fa-ef32-08dd78230ad6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7874
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

This patch is load usermode queue based on FW support for gfx11.
CP Ucode FW version: [PFP = 2530, ME = 2390, MEC = 2600, MES = 120]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Shashank Sharma <shashank.sharma@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 91d29f482c3c..d7a401ff79db 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -81,6 +81,11 @@
 #define regCP_HQD_PERSISTENT_STATE_DEFAULT                                        0x0be05501
 #define regCP_HQD_IB_CONTROL_DEFAULT                                              0x00300000
 
+#define GFX11_ME_FW_MIN_VERSION							0x00000956
+#define GFX11_PFP_FW_MIN_VERSION						0x000009e2
+#define GFX11_MEC_FW_MIN_VERSION						0x00000a28
+#define GFX11_MES_FW_MIN_VERSION						0x00000078
+
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_mec.bin");
@@ -1590,6 +1595,14 @@ static void gfx_v11_0_alloc_ip_dump(struct amdgpu_device *adev)
 	}
 }
 
+static bool gfx_v11_0_is_userq_supported(struct amdgpu_device *adev)
+{
+	return (adev->gfx.me_fw_version >= GFX11_ME_FW_MIN_VERSION &&
+		adev->gfx.pfp_fw_version >= GFX11_PFP_FW_MIN_VERSION &&
+		adev->gfx.mec_fw_version >= GFX11_MEC_FW_MIN_VERSION &&
+		adev->mes.fw_version[0] >= GFX11_MES_FW_MIN_VERSION);
+}
+
 static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int i, j, k, r, ring_id;
@@ -1632,7 +1645,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 0, 3):
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 		/* add firmware version checks here */
-		if (0) {
+		if (gfx_v11_0_is_userq_supported(adev)) {
 			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
 			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
 		}
@@ -1646,7 +1659,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 5, 3):
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 		/* add firmware version checks here */
-		if (0) {
+		if (gfx_v11_0_is_userq_supported(adev)) {
 			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
 			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
 		}
-- 
2.34.1

