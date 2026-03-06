Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59846FCB619
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 15:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E96FB10ED68;
	Fri,  6 Mar 2026 15:40:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uBqBB7Ad";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012008.outbound.protection.outlook.com [52.101.53.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50F2E10ED68
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 15:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYe+xGZ4j1Qfe/uuM2XKYyDhXw0rpmI4LetKLWN4FXf+e+EdEySUC7zIdu+2fAvyn/4cTavlV5KRftB3m6K6exrXSWdfIFFUuw1iuLl2/MjpRUeZ+IUhnfOS05J82U6hjL/fDeW6F6GkUneeRFcM9ydxH8/PXlpZpmsPmmLU2U6l9xwk3UmGYUCDfTB1gpzmNOmOs+3uCX4Dk93+zAy8K0HCkemY2o8rzOcIZHMgS0fD4P+ED1EeKZ5RSt1uBwKnSLr1OMmX+spaL1i9Ur+5dbZm/XYEWpynrPqsTco4Lmxd7ZkKjCwA5iScwRjd/gdfdFIwOkMH5zh5Un4GRqs3Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26tycTXpNhCrCXTAUglcdmciHktaPKFjX0qXN2gHjMU=;
 b=axGMKS2VednfOo+LkmL8M7FzgcIrup2BtPmmQuBOYqOk47fFTAELUAUff0PRl+GbFFboH9cCuWuhEOTzKGrqfRHaQUYRezd83sffgIATxojhJx2wfRT1on8QpT6vdAcJnstGCkxG1m8gNdJAJA+8GTBVqCCms/+9NDVwV1RuF7Km3h1ckjzFlTf1B4FjOVSHu10nLnoSKA8SV88p6D7KCO928Xma8VbKJJW2oocihVobYvdM2oBJkdiZY5Jk2zJxRSSbYEhsQlitvStlCOa3ZWBOT0AyiKDq10BKqgTsXYd/aPQQJoD35dciuwdLNRCPf25iF1y8/wWXQ2jgRBC2Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26tycTXpNhCrCXTAUglcdmciHktaPKFjX0qXN2gHjMU=;
 b=uBqBB7AdExiZQkuo6XLd7ZTxv3Cd2VkJtdNDfRU+eN/6WNMR1ZCN0Q049BKAnLnfWmbvj/Lec4ivHzHlTtN/rFVT7QtLq6nA/MXzOIDcoGp7Q16xnpyeBJXekpjX9TtBZzpLv8AjESRPVguaHIEJdwCT2Zl3z7pIJhYv1vhXb+0=
Received: from BY3PR10CA0012.namprd10.prod.outlook.com (2603:10b6:a03:255::17)
 by DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 15:40:33 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:255:cafe::6e) by BY3PR10CA0012.outlook.office365.com
 (2603:10b6:a03:255::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 15:40:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 15:40:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 09:40:28 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 07:40:27 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 09:40:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix array out of bounds accesses for mes sw_fini
Date: Fri, 6 Mar 2026 10:40:12 -0500
Message-ID: <20260306154012.22525-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306154012.22525-1-alexander.deucher@amd.com>
References: <20260306154012.22525-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|DM4PR12MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba5e0ba-e7c4-4cee-46cf-08de7b96b2f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024; 
X-Microsoft-Antispam-Message-Info: v4puNSqD2eQYfCPKhUWGB1ddwQ8CBh5Uk3zWB4vqr2E/24/NaMcNKWoBCOjgSHhtTms4jMIO50YXUvXWnAWjOgHmgqIjcE8NHIt+/XzanCMXhLstbwQh8lypYqcCfSTwWrY8XkdTyFkFaUhQF9fPnlTdKl6LBL/0pkHIe7yZyhAePPz/DFpXW0G+bQ0XXN3WMsPBOu8FkFGtbA3QCrLEyvAHG7N1lsikekfISvPE4qdSDHGQgPpZiw88PyWz7OeSnJsAZBg93X2x4beoZKELgcRpDOSgxyHUEeC9ykWndGSbzwU41cE/8p1EibWWut8C0zceXbXxppNkNOGhd124329sSnVKCwP4+HVVDsC2CQpLDk059L3ffB125SKdG65DPU1uucgmVwCowH3+QoR+dCGL+QXIh6/S4pGinhACeiTNKkQl14slmQuhfgecReua+v5RxwDgmFk9rjrKWGteubyGt79xcNnyAT4pfFO5ZOn+kfXNDexNLzL9yb+8oLVxbhRzsrdM7/J+4o+GwKbdPm2L8pnJWG7zqfnywNELtIQXczfjc7jJ0DDDtTc/cjSYlLn7M1bsCZV9Xas4bSxzzZ+zwyrvjrTywgnCZZXf009K+nHMv5jl1fwB7/F1lij4ytkNQCRM0plHFuqZjQi58lzr6ljeo8rlq17Y/eUlfDUrqg3m5qnJvtMWzGHtt/bqEgLl2lVio22R37wOB6ucRoMl5HKynLwcxg0Wjh+wxIHeFbpFg9MtXJrqTTwkDVAtUGdkbOWoTtWU7VrtSpEKWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rLPmCVsS8o6VFRyPfG2dgy1KkuMoOANyZKEov2c5zG+hB+PTKsTixg9xCnnLZe8eYANeWPuE7LMGgxwQR7/SDRok1v54TRQow1OMbpA1jYNM3QAOWoFUUUORuobkWmfQfp9DQijYIZbF5XYkdkyHazigORuT4/FuripeBEu+M8qSmxLl1qX6QyoUgDu8Qlco6GMjMsgPN1wjzBeW4aUjAdN5uytwXBHKg4Yny9POdnDyvAHZIcOuCl6fdzfcY0DQ4DCZZBUl9USLTbWspOjK41c1Nm4KUanHYi/ASt+suYKCqjM65y87v0oZvZuXunJ839ETqPBVCArC9IaNZo1v+u8zN7yEYdmGYc+8DStNP9kNVeO+2cdKMKQ0fF6FCXIHq3td4ex8sMRCZZT7euNPonUvJT+uz7oopF7dqzjK979t0aTTg21ew7EqzQhawRLj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:40:31.0007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba5e0ba-e7c4-4cee-46cf-08de7b96b2f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6158
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

From: Le Ma <le.ma@amd.com>

The mes.fw[] is per-pipe resource shared accross xcc inst.
And enlarge hung_queue array to max inst_pipes.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 6 +++---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c  | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index bcf2a067dc410..f80e3aca9c78e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -159,9 +159,9 @@ struct amdgpu_mes {
 
 	int				hung_queue_db_array_size;
 	int				hung_queue_hqd_info_offset;
-	struct amdgpu_bo		*hung_queue_db_array_gpu_obj[AMDGPU_MAX_MES_PIPES];
-	uint64_t			hung_queue_db_array_gpu_addr[AMDGPU_MAX_MES_PIPES];
-	void				*hung_queue_db_array_cpu_addr[AMDGPU_MAX_MES_PIPES];
+	struct amdgpu_bo		*hung_queue_db_array_gpu_obj[AMDGPU_MAX_MES_INST_PIPES];
+	uint64_t			hung_queue_db_array_gpu_addr[AMDGPU_MAX_MES_INST_PIPES];
+	void				*hung_queue_db_array_cpu_addr[AMDGPU_MAX_MES_INST_PIPES];
 
 	/* cooperative dispatch */
 	bool                enable_coop_mode;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 7b8c670d0a9ed..d8e4b52bdfd50 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -1611,7 +1611,6 @@ static int mes_v12_1_sw_fini(struct amdgpu_ip_block *ip_block)
 			amdgpu_bo_free_kernel(&adev->mes.eop_gpu_obj[inst],
 					      &adev->mes.eop_gpu_addr[inst],
 					      NULL);
-			amdgpu_ucode_release(&adev->mes.fw[inst]);
 
 			if (adev->enable_uni_mes || pipe == AMDGPU_MES_SCHED_PIPE) {
 				amdgpu_bo_free_kernel(&adev->mes.ring[inst].mqd_obj,
@@ -1622,6 +1621,9 @@ static int mes_v12_1_sw_fini(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
+	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++)
+		amdgpu_ucode_release(&adev->mes.fw[pipe]);
+
 	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
 		if (!adev->enable_uni_mes) {
 			amdgpu_bo_free_kernel(&adev->gfx.kiq[xcc_id].ring.mqd_obj,
-- 
2.53.0

