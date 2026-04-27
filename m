Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B26FF885E
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 08:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 834BA10E62A;
	Mon, 27 Apr 2026 08:36:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F01lMofr";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012065.outbound.protection.outlook.com
 [40.107.200.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1565410E62A
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 08:36:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zv+oXGj9yRGRUPwZZguQqeGYaBvsDuF3pDrAYTooo2ix3pc9yBEyVsNR5MxgN4e1kM95ndb2Bz1Khb3U7+YSDvemGozE+/TTFSGhcLfxuFsfVwkw3B7nqq9CqYa28rzRE8ub3LdfqBAIwC2qV+C7vHtnuCkz4q8qK814bKveSTeGf2697bk8LIrsUisOIzLC+sW3x2oOtscJgrlpgIW9lVIgZrXaopprWHYHmfSI6YmtZTHiZP3oMR/x3w1CTbnXEmDIzmWdFxQ2qUvPbR8r+hCDqGMv4mcROgmgCrLlvfBZcaHBH7zUaGmewOn6RK4t+tyTUu6ZfOYcIRW2c5kkCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SS1HUQ3qp9VzlcEo46lyY/6H0VZEWyavgS3xVnth6VM=;
 b=qdXIdMwUtVKgiumDkCZqVCww08MBSR8i+IiRKT2Jbou2yFHWXSE5MA4I+1XE6aeGi0g1VsyVHwNrPQAybu9UT0t842cg7bcoO5f3x2ySvDDMhJJdYPnjOhy/jdOseabtSk0S69AaHN9GHPOeIa7O84nvM08ij3cwzg8j34ZkeJbp8nC0lihscHs6i2aIKGkgMU/tgB8WZYevNekrHF1ma5e225eIu9gNZvPib553leFmp4iU3qV1UXaQnaRYemNb6nkQE6cOaoh48Fs/gldNf8E7JqTKYpAxuEFUo8mYtlxC1vUUh+jED0l8K19caSBd/2te/5ITiE5eE//Nw0pseA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SS1HUQ3qp9VzlcEo46lyY/6H0VZEWyavgS3xVnth6VM=;
 b=F01lMofroQk3WLfqoEI/exqS2cK8MonaMNqx+NB00TUj3UqBKHrHGVP7wOv53/m1W6d6CMtFEJ5PoDI+W/lT1MqBX3so9LakHyn2dWGV4YWeGu0yuj6jpKWvu+enIJtILa7PZzkG5nyRyUR+ta61xM5asGuEFnltEwSZRoE70V4=
Received: from BYAPR07CA0068.namprd07.prod.outlook.com (2603:10b6:a03:60::45)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 08:36:43 +0000
Received: from CO1PEPF00012E66.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::8b) by BYAPR07CA0068.outlook.office365.com
 (2603:10b6:a03:60::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 08:36:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E66.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 08:36:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 03:36:41 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 01:36:41 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 27 Apr 2026 03:36:35 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 10/11] drm/amdgpu/mes_userqueue: mark SDMA UMQs as
 user-mode submission
Date: Mon, 27 Apr 2026 16:34:36 +0800
Message-ID: <20260427083543.1328533-10-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260427083543.1328533-1-Jesse.Zhang@amd.com>
References: <20260427083543.1328533-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="Y"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E66:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: a977226c-d263-4066-b019-08dea4381bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: c+mnsQIpqsfRnEwKkHaHjc3xYuE3OdWZNpNvxD0xh/jveA6AHeqWRiNAFt1dwaoGMJZvlDTB1uBAhdkSgm3yDpi/vSbP4DSrUDCH+PBrvF1z00mi72cRqO/A/inia9qUrw3k0qm8D5K8xIiFZoN2julzcRgTJPJDdUMDO7mp069LsYPXQ0394Qp9CoMJF+8bHO9uer+vaPfY1uJBqucfDC5Zy+D6hsjKd/CVGrW+cuDiFf4etBYW6tk0iTz9jzaU1GCcpCEQtbIJO/wSaIV8ScMK4y6LcaG2xZbSpExVACWyIznZ9kbcRUMz+HQEdZEpQv5oy+3EPPjTf4hu45IuBPNTFkSCfkyzEOyt/325A9Ou+KciifAJOnZQYG9rQSCnBWP2BQTIQ7Zm+SHX8EhzyfrPszu/3v6kJjNvqZdSNqrtLjP3L0x7EVUAnLYSbl/hh4Yav0URJQwSgdm+PgoAXNEYyt8RAGKs7W+3NFZhf6ptGPO+E5b/AVSA89dhAttc0/4xFVwKgI79yBciQ7gx3IyUDsaKhWnQK2ZHpv/xhC5QTeiK77r1bVKmWaoU8pJetJLhA1KrqDzrHPpB04oZBdAGCa6XVTyxXFpXs8Q7tAjxsggXqTgkPjTcvcvN6Z26BhHoQZe1yugXYOMRFDkS24KU7PKONJ+bBM5NhFH9TAQv+90z4qaJ1spjo2laRmtwspRb3DzCimLhsEcjw0goyUCtS+Kst58rbKfGZXV7gDQF+adITpVc5ULrdgmYtis5/062MSZKfAlzIE817nPm0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 51eean3G/QBVar2XB2eYvKGiwwu8kdEyqAuiT0nE3zag5NaUYzM/y44/XgC7gceD9wxtQVE7yCTV3kOk+pAfQ2XOA59RTCfUGUEJc/EskOD1suiNGnoBcSp1hf4RqHxcYVRfGyQmthE9VjNLaw6ylEHxQoSAV8TsYun86LyZktZIfkVgBsJxlckJgkJObXtqaM0VdaBJSoWtttoQF60OAKGeh57+aK1UF1mjkbaeg2IVJkMHNXlx8k2MKV3pn8kWPcjVBhLn7cX6zPKoiUSxmzM1KbDzkzWw/wAXNEsOpPo5HkCS1J4DQC2uBspG7qpnjCLyCnDcOBs6pRnJRJYlPP1wQvskzQfHZ+Kvi6Hjx/UJ6Q6R9iAy+KZJPHlqfcJuWX7tCcSSHoiSIXRUFftbrNgFe3cOMR6bG+5yV9X+NlYha1MRgqN3YD72ukZklnEA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 08:36:42.6109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a977226c-d263-4066-b019-08dea4381bf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E66.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628
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

