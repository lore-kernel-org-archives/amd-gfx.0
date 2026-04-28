Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA29FF8868
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 10:03:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E4F510EAF9;
	Tue, 28 Apr 2026 10:03:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EmFVFmNf";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B9AB10EAF9
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 10:03:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgvWkYlEi2ZZYQb19Zv0nG0/URuV7s7A4rqLgjsebZC+qPguIk4sX0ndlIsADhxsUqoggoxicbq8wL+6pabi69NOI2AtQViCAoE3q3L8wkK+Q4YQeZNOGPIj17qmVRRM0BJ5CGYiuWSjUCtNI60KJvUbzO1EdfN1L0KyopK3J1222ztdnqK7GovTB2tjy9LDwON8n9epv8aVLelNNxP1sscwAbb1OvtETP2Yrch86CE48WHbZtFeprsBPARQa8MUffJWO9lxe2uU8ze4vJJu1lH5qbH1m/eMz69RCkXX4wM+xVQSlL/dHmFAbiYvQ7WqrPzoSC0QBqRifivObXPrKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SS1HUQ3qp9VzlcEo46lyY/6H0VZEWyavgS3xVnth6VM=;
 b=c8HYUOT0RUBYJWcPxcYlJwVBNekmGV/v98mvrr/f7kWUNWFqeX5yfW3RNVlVC2ad6nfUtOT1XG+MOAVh/pMikN0LUfCNQsG7r128Gcv0PvTmIU16xfxZ7oByPL+zCp4EbSk0ZwqOuIQuAQ2un0SsSnYdjLzu9Mzy3VpBykVH0V0k4LO7/uS/lcaB44tu6p65iCXes/Z/mHpu/kaUAFnbxLHMHH928VbkhW976UTWo+BZ/Cv6oKZhVb0Ncs5FTkA4P7IhHegm1qSJqStu0nQwGEfgZVwb9uKpojF6T4JjbhYRUPzYMtK/vVSigj0ic3qc+3EPm4MywbeXlR3J7gFLew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SS1HUQ3qp9VzlcEo46lyY/6H0VZEWyavgS3xVnth6VM=;
 b=EmFVFmNfdJsncayVhTy67R8U/uLt8CLLo3G96KWXpXkOoPOfSa2ZK1BUEMgdvMX3U0LlU0xnjREXzpj9xoQgvuNEELhSqbrxExZZjSNteZpoKpNaoWmzBiIvhaWHjyPV6B4sKp/B2DrP/BSG2Zh5g1s8wfufyQxSISZuQ6FJDGc=
Received: from CH0PR13CA0047.namprd13.prod.outlook.com (2603:10b6:610:b2::22)
 by DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 10:03:37 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::d) by CH0PR13CA0047.outlook.office365.com
 (2603:10b6:610:b2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 10:03:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 10:03:36 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 05:03:36 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Apr 2026 05:03:29 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v3 09/11] drm/amdgpu/mes_userqueue: mark SDMA UMQs as
 user-mode submission
Date: Tue, 28 Apr 2026 17:58:50 +0800
Message-ID: <20260428100239.1609179-9-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260428100239.1609179-1-Jesse.Zhang@amd.com>
References: <20260428100239.1609179-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="Y"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|DM4PR12MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b9cb2ab-7119-43f5-5d41-08dea50d6a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vh216dsJ0zukHTPS/4h0TlqvHtgZgW5sJkfiQNF6tvxz4B9+pQtgxfRIrGz8yYGJ6Z7xpswqcep18hGI9/hDsOKvPpvOoGML1rZK1Qh/CTc1hkBLnYQ9uGPNKsZzhNKxTtw3BeCcAvVujix7IWfZym3wduzTMvPjJKrO65Kcc1iZcIru+4aVfa5f4v1q3gKB8mqgU+qmCPHpqWGQPj7PvYP0k8hJSf16bRddg2roWvfambXzz6XNCnLmL90NKsg89Bjp+2Uk+YTVRZfYTT1gxnGTlzztnh3Rn5WgHPDquW92yamRJADyRQTmFV2+kqOF5tU2I/KODyq7piX73VohGH85GkXAghiVCbUvkf6XXvlW1fzemzEbv/ncFvVOX1EnKBPWeYqXsig6i9fsUCm592k8CM4NfCRHqyjpHwxqTcBady5VeE+DG8v7XuzfOiOquKN0oKJAqNyU0TKySUE32Uh9FVVRnIXhsRINSvtZ4FFxXLua9WvzRnZ1NDh7bcQ9URuWw3PoyHgFdZLKOiPXrj8VBLDdW/g6KxMrUTw7KQ+TJCGBpnMVU3nqA0+zOa4g2n7t2VNZpTywrZiUSVf0xR5SERkhhwqGlDYGbkQgyrLUIMgWxQHYUIWUVdLjA7dzCDgqwIGNFDWW9xBaKtJrKSPmmoC5/ImfOgrN8yLmIDYT1Yg6zSyl2tQFpJ7QsyU6zWfjbuR09U5JWN6gT1Bc5EhIp77r18ZUjY9JhrgaXbgUaN0ZdkojrF/qy1jBynNZt0uMJgNnGsZoNu79uGnexQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +NUQ7OGAgYC5iF3Bat02hCB9piVyZkSyRN2wwBOy8GV1zUk+WPLjeUVvbXAydPJGL8+IzTEpVA612uNxgVIiOZE2Ot4aC9S4TIKJGNPUO9Dky4dVsCbm6opqVWm3mt7RtU2H4zTtATr8E6BfjdVvkF5v9WSXstWkgrQZ6RH1DQqy0kaLtK9dr+ETOm9bPDSKa4gS4XH7JPNU7nOI3YB6kfv8bRdVLHiipC1kQ/yVLf2VF+JeoHvec5OrDzuMno3bI6IHOkoJG42xv0xTjfgKQ6lErA0EGdj0WPky1R9CFT4u5TCkCS0VkAdSSOvKePIPf1thK+GZt9ukUQluFxcqCRQJWZtU+yAo9ektTRiGD134rm099bstTxkPptK+w0+Wm5cSlBRRv+US3LjboASBkSVU+J4OEA2XlFLn1qaCnjTy2Z1P7ytpZ7QwzCUiOZf4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 10:03:36.8470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9cb2ab-7119-43f5-5d41-08dea50d6a41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325
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

From: "Jesse.zhang" <Jesse.zhang@amd.com>

For AMDGPU_HW_IP_DMA queues, set mes_add_queue_input.is_user_mode_submission
and a stable unmap_flag_addr (a kernel-owned dword in the MQD
object's tail padding).  This tells MES to use the new wptr_mc /
unmap_flag scheme so the PROTECTED_FENCE at the tail of every SDMA
IB no longer terminates the queue.  Combined with the
NOTIFY_WORK_ON_UNMAPPED_QUEUE wakeup added in a follow-up patch, this
lets multi-IB submissions on a single SDMA UMQ work end-to-end.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index d12cd1b7790b..3dbcddb46b24 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -165,6 +165,28 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 	queue_input.doorbell_offset = userq_props->doorbell_index;
 	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
 	queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
+	/*
+	 * SDMA UMQs need is_user_mode_submission so MES treats them as user
+	 * queues (using the new wptr_mc_addr / unmap_flag_addr scheme).
+	 * Without this MES uses end-of-MQD for unmap_flag, sees PROTECTED_FENCE
+	 * as a "queue done" signal, and gangs the queue out forever.  Combined
+	 * with NOTIFY_WORK_ON_UNMAPPED_QUEUE poke from amdgpu_userq_signal_ioctl
+	 * this lets multi-IB submissions work.  Use queue->mqd.gpu_addr +
+	 * mqd_size as a stable kernel-owned location for unmap_flag — userspace
+	 * never reads it; the kernel just needs SOMETHING valid to give MES.
+	 */
+	if (queue->queue_type == AMDGPU_HW_IP_DMA) {
+		queue_input.is_user_mode_submission = 1;
+		/*
+		 * Same offset MES would derive in legacy mode
+		 * (get_unmap_flag_addr_from_end_of_mqd in MES src 12).  Lives
+		 * inside the allocated MQD object's tail padding so it's a
+		 * valid MC address; the kernel never reads it back — its only
+		 * purpose is to keep MES happy.
+		 */
+		queue_input.unmap_flag_addr = queue->mqd.gpu_addr +
+			adev->mqds[queue->queue_type].mqd_size + sizeof(u32);
+	}
 
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
-- 
2.49.0

