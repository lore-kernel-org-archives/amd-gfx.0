Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3667EC5DF87
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 05:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AED2910EEEF;
	Thu, 20 Aug 2026 05:06:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A0U8oiue";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012009.outbound.protection.outlook.com [52.101.43.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FC3410EEE5
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 05:06:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbdKmgi1cdqz4CD38ijn/YkaHY4qsX2enTxjsd0Q/MjVMY9meelRbW5pj/e9xAI3UfMyiwHJ20Hv5hHvtSIBZAGZrYB2CejAXMU5JdLAF70/14WIDiNOqS7hAEXDqJtl3ID++HowJ96971QjqT6dmuw+BD3gR0vBSsOZ6w2/MijdmsSmMECcaKPZ1I1VTlPeam6lDUnNx9Fyzh8qv4UA5t1AEc9qoLVQctHk7cwD/lnF2t1BCPmcsfWV/kgfTkFJ0TWu8U7aZgA5MpREWww9MZapB/6xKpUQaBse4+rpQgCaekMOacvYZXytfJosVqmRsUgOfNKfDxaif7yORxEMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6HBgHmS+M0bCR9f0yQTLzSbkTL5rpb1KbAgV07dbjc=;
 b=eLYZcOi3yI+U/xhokRqywwdXPf5SaAkQrX2JQX0+T13OfLS+GAxoC2FRtDugV3d82FAlQa4idxlne3ZZjkIokgNMvnvwA3S7V4iV5Ck5Mn2OGhqwHg5ZVw5ZybaP3PBGO7Nk32MS3P7i/e4Kgt3qlnV3cMTNcMINVR6tqTOQH93VHojdCb60PBPZzqdV/+zdrJocFgM2Uot3QH97gJc+Wet2umAAM9B7r/2C2zMjS5AAFrL2pksvZluDvJoDVn7jA4n3Ravh8WdF4jk+BiCTFNPF/iaGpVIVqK7z13Lo2Ktro3XwQ498r2x7+NUwVuZzZFcks+Q/ENMWp1mek07rtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6HBgHmS+M0bCR9f0yQTLzSbkTL5rpb1KbAgV07dbjc=;
 b=A0U8oiueFog/O2PNAyBnYv4BGcKYEcUY3T8WcYp+FkPoMciFfiVcv7mGTOX6vhJmeRTTZ4NUVthyUz+0n9MbV4DwNRRnEVJpqS8VOdob0/w6akSOw3B6SAFUZNL8z713jkGq096hJ4vrVE/t5XTRsWgEohqaGftmnWC+JNJipME=
Received: from SJ0PR03CA0095.namprd03.prod.outlook.com (2603:10b6:a03:333::10)
 by PH0PR12MB8098.namprd12.prod.outlook.com (2603:10b6:510:29a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Thu, 20 Aug
 2026 05:06:07 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:333:cafe::4a) by SJ0PR03CA0095.outlook.office365.com
 (2603:10b6:a03:333::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Thu, 20
 Aug 2026 05:06:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 05:06:05 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 00:06:05 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 20 Aug 2026 00:06:03 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v3 3/3] drm/amdgpu/mes_userqueue: add MODIFY support for GFX
 user queues
Date: Thu, 20 Aug 2026 13:05:37 +0800
Message-ID: <20260820050600.1249902-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260820050600.1249902-1-Jesse.Zhang@amd.com>
References: <20260820050600.1249902-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|PH0PR12MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: d1c1cdc3-4157-4910-e125-08defe78bd71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: bvNdUq9y+PaQ9uSQiBH4K1rBpYLRcXLntltQFOga/Dgeyrp0uEwJ09yjDm2I4G+LSy5Tal0iXY8fz/SLuj16ELsFNi8LotGfi23LeocxGXGWAYFl566G/fkHvk1sMT0zyCaLDYk/LUcddc4GJ4iIClZW1AmZ6gccRsfbIONOg0n2f9XBzBl8KqBATN1iWeNld/XvrVC7MP2ascqwFUZ26aTn1fpTd1vZBeguSkw41d5xLWk/SyeKzZUpoGKSbIBLXDwRvmM9TfNKizW7HX24PXjSo7mB7J8awOZVMemUWfXTcI2+jbjikCGk4peqKqd+KVCyV40yyhq096B0WWkUkxeOwA2+jkcIPavN5fFta6QiiLpRY/F75/xlSL1EB7/5q2LqGwsSl/KkKxUQr3LWfFKxMzEIyFllckxRLS1nWLeaSEXl0fvw/8PMbD9/nYRZkDfRJMawi0X9q6ZgSSZ5Gw+eDs0jXGupgl6PWWM/F9MmjCCxLCggf4HPFKm73eAdHdOzuJJ5lLwcR7R7AAseiJH829RUK7pEc5Rv4av8gm7YKLnZdePChRHKb2i6FuBdxSKmk3LhkAhslD79yvABNxlDrNh329Ry7yfYN2b9IjGZHHcbTu+XKW7aTM1jRum0fUGAprLtXFEDxVunoJ9j94hV82Ntf/7Ndh2yogeXkt4DnlOBLM4ttn4fqGkh+sxmS5RdKNkrBenPx9znXrqlWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d9oiZ+qzg2AO1HRWHd2CDXEZbSZji9ksKCZZ5etl1TxThnx+TdXSTd8KnIcAqUmMzB48LLbj6aGmUBRHseAxAmNprhvOUIMzG3Gu2SRBKQygIo9mdYwbfNwSXj7yjnvCXDjmbO443hOlW3LmC00Su2uh021JkGQtoE2L2BpeUzTHQFndwlpDew9i43PoTal7mxfvMVrDqpuFrc4oZHnVcMZMMdUtxt/YZjgoou5CFRM4vm74IDcaF78tHyqB+PKEJOfQIRqncAvCkmUTeNYYxSEdAup4kH/P1LTwG8SOU8dC0c0SXnWtirrwj4u9HLWHKnjEoC+yE+HA0bKwoMcCQftSlrD2IG+0PJNC3MFv+XWlbGQRsk4He/3/xDMYnW1cue7YzHARqjc7ebUDA5WFE4t76JM0a9zudOgnA2AMg7jW58rDvxduDgvPM11DXYJV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 05:06:05.9739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c1cdc3-4157-4910-e125-08defe78bd71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8098
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

Add the GFX case to the mqd_update dispatcher so a GFX user queue can be
updated at runtime; until now it was rejected with -EINVAL.

mes_userq_gfx_mqd_update() reads a drm_amdgpu_userq_mqd_gfx11 from user
space, refreshes the queue props (shadow address, csa address, queue
size and ring base) and re-inits the MQD, mirroring the compute and SDMA
paths.

Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 4f6d92031838..6b5095efdfc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -711,6 +711,37 @@ static int mes_userq_sdma_mqd_update(struct amdgpu_usermode_queue *queue,
 	return retval;
 }
 
+static int mes_userq_gfx_mqd_update(struct amdgpu_usermode_queue *queue,
+				    struct drm_amdgpu_userq_in *args_in)
+{
+	int retval = 0;
+	struct amdgpu_device *adev = queue->userq_mgr->adev;
+	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
+	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
+	struct drm_amdgpu_userq_mqd_gfx11 *gfx_mqd_v11;
+
+	if (args_in->mqd_size != sizeof(*gfx_mqd_v11)) {
+		DRM_ERROR("Invalid GFX IP MQD size\n");
+		return -EINVAL;
+	}
+
+	gfx_mqd_v11 = memdup_user(u64_to_user_ptr(args_in->mqd), args_in->mqd_size);
+	if (IS_ERR(gfx_mqd_v11)) {
+		DRM_ERROR("Failed to read user MQD\n");
+		return -ENOMEM;
+	}
+
+	userq_props->shadow_addr = gfx_mqd_v11->shadow_va;
+	userq_props->csa_addr = gfx_mqd_v11->csa_va;
+	userq_props->queue_size = args_in->queue_size;
+	userq_props->hqd_base_gpu_addr = args_in->queue_va;
+
+	retval = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
+
+	kfree(gfx_mqd_v11);
+	return retval;
+}
+
 static int mes_userq_compute_mqd_update(struct amdgpu_usermode_queue *queue,
 					struct drm_amdgpu_userq_in *args_in)
 {
@@ -753,6 +784,8 @@ static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, struct drm_
 	switch (queue->queue_type) {
 	case AMDGPU_HW_IP_COMPUTE:
 		return mes_userq_compute_mqd_update(queue, args_in);
+	case AMDGPU_HW_IP_GFX:
+		return mes_userq_gfx_mqd_update(queue, args_in);
 	case AMDGPU_HW_IP_DMA:
 		return mes_userq_sdma_mqd_update(queue, args_in);
 	default:
-- 
2.49.0

