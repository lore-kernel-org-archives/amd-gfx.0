Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31E2CDB479
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 03:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CF3D10E013;
	Wed, 24 Jun 2026 03:26:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BVbhLwXs";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1105210E013
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 03:26:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFaqft9MR0GkROPz7qa1K7i9j04E9g04KIyjENVZln6jYEcw7AW0aPc/pbkmIFwHOwCrzMSqvZfAuLf0bz94rlFIR2cXamhlWRU3HezAn2rz/gYfJ50a99q55/v7wgMKvs5fOAf+8DVf6/bmETSdKaJig2DCLp3Mo4TMdwcCF4sHURdrz2Vpdy0ehfm9CmbU7amfcmfTyVzOWcyyzI2KlcEiFYL1ikhNpDNbHA+r3UkiSyXKhkioYZX2lqZcPoCy6RTQAHC4+wmD/0GFXEwalTIMEPwAXr835OR7eTtb/gvbOuDij2og3ykB/+j+3KsmSYl0z45FDNiq0/bFSbX2Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOZDA3hsWciZf6CMQZzZJ0Ezy9nSKcmBfNtvmGmZcXE=;
 b=f7SJq3f0b0pAuN3/Spx4S4VevWPQkl+bR9gB7sxZqlyyvr9ZEipC9yCZvLBmY7Y28OG8ojo/anklFAj0H1g3qzkqKuqwIhWaHoqtw6Pa4sE4DsAqzvndNEBoUsGOg+aRQCZdE/SxNyncCXNB5LWhRlCnYIgecrCCm8bTo/uYDSpTj5puWYn6LdXjkqxLtFgppXOtkiDE5hzSla5d0iUYW32FbiMV58u1wOeHsOoRIUWe8qIL5TIJDhRo+LQsbnGUIrEsRhefUjwfTi/X28Yf/CXnATin5Qnb6BH0U32fJiieFGfWr1M1qTwzdOP8kc7NntG1EzjV3VNMoUHI3yVgiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOZDA3hsWciZf6CMQZzZJ0Ezy9nSKcmBfNtvmGmZcXE=;
 b=BVbhLwXs3u/B0hG/+y4pc9he7KeDIsarMv0b9eZu3EXKvoVGCsqlczt37SEVMhz1/yZa88KINxHF4QwpEbzcR9bpBQWnpIfdQaSF/ZVdE5g15o9F45eVnYLlXMuSSD5yVNelUdsk3XSz4SDXvyhnsVjCk033xbGBkR1ZW0BYYYg=
Received: from DS7PR03CA0102.namprd03.prod.outlook.com (2603:10b6:5:3b7::17)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Wed, 24 Jun
 2026 03:26:24 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::55) by DS7PR03CA0102.outlook.office365.com
 (2603:10b6:5:3b7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Wed,
 24 Jun 2026 03:26:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 03:26:24 +0000
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 22:26:21 -0500
From: Geoffrey McRae <geoffrey.mcrae@amd.com>
To: <alexander.deucher@amd.com>
CC: <christian.koenig@amd.com>, <amd-gfx@lists.freedesktop.org>, "Geoffrey
 McRae" <geoffrey.mcrae@amd.com>
Subject: [PATCH 1/2] drm/amdgpu,amdkfd: correct setting MES queue type
Date: Wed, 24 Jun 2026 13:26:07 +1000
Message-ID: <20260624032608.1135223-2-geoffrey.mcrae@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624032608.1135223-1-geoffrey.mcrae@amd.com>
References: <20260624032608.1135223-1-geoffrey.mcrae@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|DM6PR12MB4217:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a7fac2-dfbb-4a75-310b-08ded1a05e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: E31P4uxX42ggWbjo+bEPXszvAl04CJ9mXXp5Wok8IrURUrvtyJr0F6kUrD5kk8q5NZyedjqep8WWs6FwzpW0JomxTIU8o75lSNjgITd3mlIap6ZqO6HOyY+u6CdS6g1pI5tGO0PztnYS1+MPhBdH08JzsbA320NIhs0/MpO3I+TiQXkh4dwTmzvbSeUF2RMXTL+CVlfe5qCfbEa6Dh+YDMmXwZkt+TQaXeWLvKapCJ4ADVuKWSBoZpv9mKqsbc0I53b4KEmfqSVeWQVbLfwKbdQo3A8eI75NxbBPm+cFzH33CrtN7ZtFuXuhs7gB09a0K+VYnu2OWCPBpkHnY3rmFadUZKZPy0n00mb7iDBRDj/nm98zvx+Pp+vi7gbPi7ykTjI55WH/hfU7pLMp6XJlxDr8jxpvvGEHkAlqxzUoD2F6fzl4f+U+GLwDN46O3HBjTZDooBQ3zozcvaaPOxgvXdwqxQSZNsM+FXZxhL8wBEXBGt/XUSbXawuvbWLBVEHxlsbPp3PZmCgnGZmKOnLbqBh2OKIRohejQsua3B+J2AK8dIvNh79TRnHfBXgxWnL31pAMYHEvGHxs0LrrcvsM6B/PJ1Z1hv0arVu57vZrkx2IsuLHWGt0f1D7gm2vFagHRP3dBDzGaY4h/04m/w0HT48fbBE1SKNCCiQm5SWb7/yIomRyA0jQVJz18NhWCb4QZXlJiBQd89nuqLORUtKyYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 77Jse10g+Tf+6z4EewvFzsr6401i2bGe+1HaOiqpP8ZrAo6Dk3GnSHUc+2IhbT6BvsZHbKAbfjTWOBW5aPuin44/ygV7+wWdrroiWvu3ztC97Omc2AGHBwUzyjz9zhBFrTZbv5Yy2m1PEzsIGuwHykFDisLelCXYjokzHv8DYtOLjjgKFeZ26e1cJeWQXDmAsFvK3ysxJbp4mgrTXIKDHCFvlJxDbhuoMW+M6naJcYeeXJMSAvdBUAQRRmCW3Kzq66oa07K21o4P8knlBSDL6yrjvsuJmDi9YNjTKkf+8QZAjMVltnhuRrveFe2zAmmRo0xeyZ/QV2milCQQ0b6xC38UV0YW5o8VTf2BdYCICaBmXiILJ2XNbzPIhxM9Lo0eBi2rD31xqqHsEcApsk56cbBH5YT8gecT+FtGIBdLVm4ZMehUm1ke3Xba1V0e9Ukl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 03:26:24.3457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a7fac2-dfbb-4a75-310b-08ded1a05e89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
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

MES ADD_QUEUE programs the firmware with the queue type from the driver
input, but MES REMOVE_QUEUE leaves queue_type at the zero-initialized
value.  Zero decodes as GFX in the MES REMOVE_QUEUE packet.

That means removing a KFD compute queue can be submitted to MES as a GFX
queue.  In a debug-trap suspend/remove sequence this can leave MES
looking for the doorbell in the wrong queue class and the REMOVE_QUEUE
command may never complete.  The observed failing packet removed
doorbell 0x1002 with queue_type=GFX even though the corresponding
ADD_QUEUE for the same doorbell was queue_type=COMPUTE.

Populate REMOVE_QUEUE.queue_type the same way ADD_QUEUE does.

Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h               | 1 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c            | 1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                | 2 ++
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c                | 2 ++
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c                | 3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 ++
 6 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 5255360353f4..dbedb1e47c3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -274,6 +274,7 @@ struct mes_remove_queue_input {
 	uint32_t        xcc_id;
 	uint32_t	doorbell_offset;
 	uint64_t	gang_context_addr;
+	uint32_t	queue_type;
 	bool		remove_queue_after_reset;
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 5ad8dd18dc67..f0f12c81dd5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -170,6 +170,7 @@ static int mes_userq_unmap(struct amdgpu_usermode_queue *queue)
 	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
 	queue_input.doorbell_offset = queue->doorbell_index;
 	queue_input.gang_context_addr = ctx->gpu_addr;
+	queue_input.queue_type = queue->queue_type;
 
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 9e27d01cbfa3..76e6769cf7ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -383,6 +383,8 @@ static int mes_v11_0_remove_hw_queue(struct amdgpu_mes *mes,
 
 	mes_remove_queue_pkt.doorbell_offset = input->doorbell_offset;
 	mes_remove_queue_pkt.gang_context_addr = input->gang_context_addr;
+	mes_remove_queue_pkt.queue_type =
+		convert_to_mes_queue_type(input->queue_type);
 
 	if (mes_rev >= 0x60)
 		mes_remove_queue_pkt.remove_queue_after_reset = input->remove_queue_after_reset;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 20f4fd57b1da..1b0c649d97a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -371,6 +371,8 @@ static int mes_v12_0_remove_hw_queue(struct amdgpu_mes *mes,
 
 	mes_remove_queue_pkt.doorbell_offset = input->doorbell_offset;
 	mes_remove_queue_pkt.gang_context_addr = input->gang_context_addr;
+	mes_remove_queue_pkt.queue_type =
+		convert_to_mes_queue_type(input->queue_type);
 
 	if (mes_rev >= 0x5a)
 		mes_remove_queue_pkt.remove_queue_after_reset = input->remove_queue_after_reset;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 8007a6e69305..c449efa70b60 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -362,6 +362,8 @@ static int mes_v12_1_remove_hw_queue(struct amdgpu_mes *mes,
 
 	mes_remove_queue_pkt.doorbell_offset = input->doorbell_offset;
 	mes_remove_queue_pkt.gang_context_addr = input->gang_context_addr;
+	mes_remove_queue_pkt.queue_type =
+		convert_to_mes_queue_type(input->queue_type);
 
 	return mes_v12_1_submit_pkt_and_poll_completion(mes,
 			xcc_id, AMDGPU_MES_SCHED_PIPE,
@@ -2270,6 +2272,7 @@ static int mes_v12_1_test_queue(struct amdgpu_device *adev, int xcc_id,
 	remove_queue.xcc_id = xcc_id;
 	remove_queue.doorbell_offset = doorbell_idx;
 	remove_queue.gang_context_addr = add_queue.gang_context_addr;
+	remove_queue.queue_type = queue_type;
 	r = mes_v12_1_remove_hw_queue(&adev->mes, &remove_queue);
 
 error:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 9f28974f25b4..74cdaa8636c9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -299,6 +299,7 @@ static int remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, st
 	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
 	queue_input.doorbell_offset = q->properties.doorbell_off;
 	queue_input.gang_context_addr = q->gang_ctx_gpu_addr;
+	queue_input.queue_type = convert_to_mes_queue_type(q->properties.type);
 	queue_input.remove_queue_after_reset = flush_mes_queue;
 	queue_input.xcc_id = ffs(dqm->dev->xcc_mask) - 1;
 
@@ -467,6 +468,7 @@ static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q)
 	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
 	queue_input.doorbell_offset = q->properties.doorbell_off;
 	queue_input.gang_context_addr = q->gang_ctx_gpu_addr;
+	queue_input.queue_type = convert_to_mes_queue_type(q->properties.type);
 	queue_input.remove_queue_after_reset = false;
 	queue_input.xcc_id = ffs(dqm->dev->xcc_mask) - 1;
 	/* pass the known bad queue info to the reset function */
-- 
2.43.0

