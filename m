Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0199C87FCB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 02:28:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E1C310E6FC;
	Wed,  6 Aug 2025 02:28:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OG9NMdBR";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B497110E6FC
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 02:28:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJs0jZqA7qy5BgaeFqAfavNnNgybCB3YDS2u5c2xb/MaXOndiGHB4vzmsFB+f8Fq9VTpqFVFx8w+8o6KkkadJk0peXWO0rHhWXBz9Iibd2rhDiUx6+z5F3qn69Ac+8WJxMs2fz30GU2t5SjSs8NyTcT4iNecygNNQtwZ/HCzK2vcRTBZ4OEIq1PztXfdlInxD3gmxhNXmFYGIXPWGKL11vJW0SCm8HtLtEXp3WZymwQ9wRDwo9wxyHsYInUWxEDJAPPtbjvvn4CADNcERrtGg3w5yu8QlUb4Q8YIG3bAhyzAs95QuD/Q/C7l9aIa5P1p3ebBI/v20hcRdrH3Wd670A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qT0XIc2LjAG5yylTVznWq0O0KQm1rdNlB4gsPsqFATw=;
 b=buDlJ1ce5XPN/VCkBjx59sNSKZGvvDNLu+CvctsRV7I3/ysHvvPHMUrpW4wvgWzLmeSZUMvzoLhuriixa/46BBYcp2HHQ+0vAE+uQwt0wtx3VZSUplOt4klRgElbG8J/jj2FC7xc7IlR3KPcCqpVNQGaFbxAnfcACX6w/jUZ97ez0vQmnNyjC9u4lz4PovS+Q47mEg5ndApfuovyzwo2ThnMfJ30UZ0o/WpW3N36LHulnlIb2937rG+zP1181lLOD5xRLp4Q0DmTBjjoUZUUkwRlqQnxYu9Mg0B660t2yYj9qFIRxnPENEbuQieGc33KvPi9qNkrhexhti1WcOvwEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qT0XIc2LjAG5yylTVznWq0O0KQm1rdNlB4gsPsqFATw=;
 b=OG9NMdBR10fo34G5h+PPIXimH9VJAdtYoKQfCSqHIhsBDYDarnuCUwY0ah0V5koJKytXGNVLI/DOjvhFX9GBrJqEscjFiJK3x/oSwbstdHBmvEwBPZEa7joDst7nDz0/lBvClOxfHc3/Sw7hdmpNFOjnx+uOvzNx859xJlU6vyU=
Received: from BL1P223CA0037.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::14)
 by SA5PPF6CDAEAF48.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8cf) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Wed, 6 Aug
 2025 02:28:31 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:5b6:cafe::dd) by BL1P223CA0037.outlook.office365.com
 (2603:10b6:208:5b6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Wed,
 6 Aug 2025 02:28:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 02:28:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 21:28:30 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 5 Aug 2025 21:28:24 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v7 02/11] drm/amdgpu: adjust MES API used for suspend and resume
Date: Wed, 6 Aug 2025 10:24:47 +0800
Message-ID: <20250806022816.1050823-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250806022816.1050823-1-Jesse.Zhang@amd.com>
References: <20250806022816.1050823-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|SA5PPF6CDAEAF48:EE_
X-MS-Office365-Filtering-Correlation-Id: 4475d099-c8c6-4cbe-22a2-08ddd490ef2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nm7YRpQHmspxy6xDP1kjBeiiMIibEtzZqHpNov/x0tHkyXXXkAopkWZBjpbE?=
 =?us-ascii?Q?N40+jN5mw0DhQmhdEK5oittzwn/zqJZgGopjzXBaT1C7A5Zguecu8BKda82j?=
 =?us-ascii?Q?c4aOSkPx4QfxrOTzUfOXIggX3Abudfxf9ZQWsbb/fjOLlqpxq8cmiSQbfPxx?=
 =?us-ascii?Q?7cQ/NY8hcWKGj8mkJtrFrODKAgjbCRPHgPCMaqTivmZHUqsaYsdqzsUo1nmZ?=
 =?us-ascii?Q?5ljccqiJlLbHLiuflw+SDrTVwTbdApCjoDHxA7VQ/rerkhT7DV5Pm0Tt3miE?=
 =?us-ascii?Q?QdKF+xZXZmaJ2mn8h6tQuC4IOF8NEqItkFU2Xz/M1vPw8sKEMRNIqDb02yvz?=
 =?us-ascii?Q?QaJX4yj1XjRtlawW4pzO1US5QJyUzai6pubKWCmQGgQ8M1LqTjeOlY2fTPyk?=
 =?us-ascii?Q?Hj8t5eL1pHmRfyrvjfpjybMZ6JV61Kmqwvj8C3qSTJTC4kSp4vQy8WI68R/L?=
 =?us-ascii?Q?5Jkpf2hoWMMJXENHvW2zjN9hyq1ezKeDiWTdsJ1xTSorHiTrjan/ZBRNuOfH?=
 =?us-ascii?Q?nOufMWA68u0j1lUyf0rvn7jLNkqIroYFDJT8tdwe+/lS33Q4S4RASJjit2hq?=
 =?us-ascii?Q?3TTG61VJvt2qbYmix0VEAU7LQHzBoMFrg/S4vpq3xIwd2IP0I3auP0LfcHlz?=
 =?us-ascii?Q?idhG/lOQPAynSX0aLJP00vhzrmjFtQVt9WQU3YNIOEeHjzpF8OnUZnvOIUsM?=
 =?us-ascii?Q?0nFBa7dwYR9kdGHqvFFC6hTMOg6u4HfyUMrvYhv7h9VYTxEIL+lT+xAK7I7Q?=
 =?us-ascii?Q?PvOCHtFy3YMuSY0ZQDyDwjelZv7ZYf7KK1k379hMsfqWR3koMdy9HcLfn/Cr?=
 =?us-ascii?Q?Uq+g4Og8YS8EygV6dMeZEoExDRljnEMQlBCpfpIdFasaQitUAFjVo8VXm2O1?=
 =?us-ascii?Q?Eh4VVziUl8Yp7JWOMvMQ/IBExZ8c1XIUH87vy+t2i7ojFvnPooMBimDwJnbF?=
 =?us-ascii?Q?KVn7SRuYMzKOiqpPi6WjrrzdUM5X2b5j/0xTWGgsqu1tN67I1cwk1Nl3uxzV?=
 =?us-ascii?Q?1UK4VFjMi0Zf6fU256Zuvhg4zFzFQaY769m3CwsUHNmWLGZYJz9jRtlvSbBI?=
 =?us-ascii?Q?qmW8AYs8q+/UeslPScZ56VEtqWU5Alp5ZL1Pv4emnN7Pb791igcDkFJWeUNm?=
 =?us-ascii?Q?7nYo0HoNULIj80TM9eUEro7Q9eCQLP463/w9lvQ1VQvKsmiIRsFk0/7IdUTK?=
 =?us-ascii?Q?5ve5Unu/T/Tpx1atEp3nqamfzCo2LhddTlPXvlvwAmlpWFbsd3R6c0IfQ3/7?=
 =?us-ascii?Q?h1KBbpJbPTs8HLq1BdlSbrImgldEncrHB5RD7ddLCp3MJMFnx1rXNo7dCqjB?=
 =?us-ascii?Q?pqqn4a+VDDa3vBZQ1nrSr536Rzm7qOKzDrfICqE9vPnQyLT8uonOsNfh/HEp?=
 =?us-ascii?Q?2CIwUuqbCjwi7oo0GmvELS6YmJ/vELxUSg+lS3Kp3mw8QCAfLmj6R3QMdxQa?=
 =?us-ascii?Q?n8UjbqKcS7caEQoExEuLf2Ak1KjEiDytwGwBfxgM8Gk7Hbcne2bwImtr2HtN?=
 =?us-ascii?Q?3pAYLKro567veP5Dz2K9lxP9DrWa52NjYa9F?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 02:28:30.8912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4475d099-c8c6-4cbe-22a2-08ddd490ef2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF6CDAEAF48
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

From: Alex Deucher <alexander.deucher@amd.com>

Use the suspend and resume API rather than remove queue
and add queue API.  The former just preempts the queue
while the latter remove it from the scheduler completely.
There is no need to do that, we only need preemption
in this case.

V2: replace queue_active with queue state
v3: set the suspend_fence_addr

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index d6f50b13e2ba..46b24035e14c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -347,9 +347,60 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
 }
 
+static int mes_userq_preempt(struct amdgpu_userq_mgr *uq_mgr,
+                            struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct mes_suspend_gang_input queue_input;
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	int r;
+
+	if (queue->state != AMDGPU_USERQ_STATE_MAPPED)
+		return 0;
+	if (queue->state == AMDGPU_USERQ_STATE_PREEMPTED)
+		return 0;
+
+	memset(&queue_input, 0x0, sizeof(struct mes_suspend_gang_input));
+	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+	queue_input.suspend_fence_addr = queue->fence_drv->gpu_addr;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->suspend_gang(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		dev_err(adev->dev, "Failed to suspend queue, err (%d)\n", r);
+	return r;
+}
+
+static int mes_userq_restore(struct amdgpu_userq_mgr *uq_mgr,
+                           struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct mes_resume_gang_input queue_input;
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	int r;
+
+	if (queue->state == AMDGPU_USERQ_STATE_HUNG)
+		return -EINVAL;
+	if (queue->state != AMDGPU_USERQ_STATE_PREEMPTED)
+		return 0;
+
+	memset(&queue_input, 0x0, sizeof(struct mes_resume_gang_input));
+	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->resume_gang(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		dev_err(adev->dev, "Failed to resume queue, err (%d)\n", r);
+	return r;
+ }
+
 const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.mqd_create = mes_userq_mqd_create,
 	.mqd_destroy = mes_userq_mqd_destroy,
 	.unmap = mes_userq_unmap,
 	.map = mes_userq_map,
+	.preempt = mes_userq_preempt,
+	.restore = mes_userq_restore,
 };
-- 
2.49.0

