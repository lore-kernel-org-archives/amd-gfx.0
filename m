Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7570F1075274
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 08:22:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16C1110E8E3;
	Thu, 19 Mar 2026 08:22:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F6gz2bQ9";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010061.outbound.protection.outlook.com [52.101.56.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC7BB10E8E3
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 08:22:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3y2pWqJRnw7+ndym5G9R3uEZj+Cj5So+mejv8o2PHcK3hAQIaSTYsCSEg49Iw4P2v6jEeiYEfAaBa7gsKCbmqrBcJe6ZiEZu+WIq9H5IaXyz82kjsUy88XB9ROy0+bLm7nf0FTiCU3V29I6uuQj80p1awZ6albzpkLzjFodDDcmpPs+CJLtm8zCCPzkVnoFjooIjPzvkK7r9Xx0T4yhjBvM4+3z1y8uPJVyUHB7ko4kttXkKAPGIns+xUIygxlIoHIw02/kxgxpXZhn5pcH9AIWkG0CIirSM8LvGpyStvKd9M84nsdqoShzuwYUYR9ILyUL0plDXvjyR/T2vRbE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIeVcfIQQxl9hsK7WHt+nYFtBJFu193Q99xU1k4nOH4=;
 b=DBe2nqNKfuHv2CcVHNKnq1igPXsgibaXt1lf+5DVL8yAbhA+xmYfERl6r4Dx77LVuxavYW7TM2RZKxuxZogj/a7YIrCNTwkIHMb1JJudhgOqgXghMcyilsGXqcHrMDNmXfiNVhVAe0WRMkIG0aSD2k0OjNOtX7qvkZXpwebVtPuAhaQ5vVMY6kbaISd98FfJ3Si/WwbhZY67lO0cpqOyuLgnImkEKjk4aL+oBlcAiD+LRUM6196tV1xQCURTCq5CHXZAsc0/7qDx9ZzhByxaN3VDDB0YrZEDPqu0g2urPlaLvAyTKaJJ16iTu90yM/4xVdMqj5TPQMuPy1HkYpFVbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIeVcfIQQxl9hsK7WHt+nYFtBJFu193Q99xU1k4nOH4=;
 b=F6gz2bQ9fKdfWTTRGv54idJwhLjGmdkY+Xj+Bf5x4nfpvTEg+2kj3E21cCN6Rf1UvleYvXM0QdyAHQCOvmGzJiogFRcobavPfFSLJUIKTGj7rbmyxjs+YSkKhJCk0yFht3t6GoWqqA6oYgBtD0zeD2DkxETNRF23qCpYR/IYy7w=
Received: from BY5PR17CA0025.namprd17.prod.outlook.com (2603:10b6:a03:1b8::38)
 by DM4PR12MB5962.namprd12.prod.outlook.com (2603:10b6:8:69::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.9; Thu, 19 Mar 2026 08:22:07 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::3a) by BY5PR17CA0025.outlook.office365.com
 (2603:10b6:a03:1b8::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Thu,
 19 Mar 2026 08:22:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 08:22:07 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Mar
 2026 03:22:01 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: fix syncobj leak for amdgpu_gem_va_ioctl()
Date: Thu, 19 Mar 2026 16:21:49 +0800
Message-ID: <20260319082150.3324177-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319082150.3324177-1-Prike.Liang@amd.com>
References: <20260319082150.3324177-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|DM4PR12MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: 0be9f0fb-a639-4967-4bf7-08de85909bfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: MNHnQp/q4GHzIUpC9dQJB0upQZf0Zh8sMIQMm1FKjEB6IpVaCQwe29PAK1wWLBxiqZE2mTXyl51YATEodC/3qyoDlFRqRh789o96ZSfOejZu1YLib0hkylc1ngKxPT2SxZCvlfoI9IzzOFp7eYHzWF9KLWMU2mAUtD3vm/nyWdypDV+0t/w0ccbOwNAp64l/1DmRbOh4xfXcoVUxwp/8me3BGtoqJu18xlUzHHs17b7YBjsLdkD+Bs4upjB5qbIxYz4niyMCL9/uUv98UIini+XASESFPGRxOLdvQjsv2ZfSWW//zwkPJWlRI+Ef4JBios5OH6uFahzG+GLqGFeQY3zOyoDtxhNwN/xxQwc6YsRWfWZnWgfL4ZfUSGXy2wjL0IfwLN6hschD8pkZ8KHkuD+fQa+uiDiob9nTJ6Ci/6IrB2l8n1ucoNSk01KqVXHNaC8FLBAJZLHIl9pgVXPjfZErbNpogszC4mHGBaVg+LkQoGa1ky51a8C3c78/hqpPucKzfAlenPBOYUWK/a5sELhTlfKb6t+uukkTO40RKUYVAqvn+DuVOEDwj9pq1GgSpkS5kdqCaNh9QZLvJ/vUqnSQsTBEfi87mUDPFtl9hmxm3/N2UiVbN4lHScYCE2NpVlk7VsEEn5FXQ8h0eiJwfVD0WQcbf1F9toFEs3wsMsR2rkwTQbu6VKXe1mMG796GtuzvLNQJNnPTefYxniFlrvuHLVFXh66VvzDyR6b3rspnynthPKT2oSChEXIk4liqglqzvNIIYEoBl+ltKrN3hw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E1EboCS14wVulm8qxex/CnLPl9G8plc/ZwildTTUIgaMwIVDl1KPqC/20OjCZuX5nx4EuFXVitmY9mY0ZAZNhM+5mCrw23WEvUq5QMuPKPWCN3R1lRAHcfzJUW7KtoUcjHYLeeAMRsZr2UwMjo8jcyxcedjowpaFALiLpZqOaEuvRAn6IhwKRj1wUZVcuHyGT0hvwwQeoNH2ggwG2W+0FxuPO+09kZtsPT+rc+apjcokOmqCQTfpTjXuFQShKjEmmLdXFqvLzGUsQrwi9GZWRfssQKONifMqOZ+iUiE69jQRU2kbf3iLLbmjG8RXYzf2QQX7xWtN80qyCRZjlPFWftsX/kj91R9RLqoBf9d8GATGiahkVaagJVcjo6kSRi/GxLMCEflm85+f3j0muzOBMz51FsOvvew0HGesNejeVKCKkBNrYjoRSPq7pjRPYj3x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 08:22:07.0671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be9f0fb-a639-4967-4bf7-08de85909bfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5962
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

It requires freeing the syncobj and chain
alloction resource.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 98276b55ad3c..f54e0fb5cb2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -980,6 +980,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 						      timeline_chain,
 						      fence,
 						      args->vm_timeline_point);
+				timeline_chain = NULL;
 			}
 		}
 		dma_fence_put(fence);
@@ -987,6 +988,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	}
 
 error:
+	dma_fence_chain_free(timeline_chain);
+	drm_syncobj_put(timeline_syncobj);
 	drm_exec_fini(&exec);
 error_put_gobj:
 	drm_gem_object_put(gobj);
-- 
2.34.1

