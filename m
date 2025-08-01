Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D78C87FD2
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 06:26:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D6C910E3B6;
	Fri,  1 Aug 2025 06:26:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BxMyepal";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77EFC10E3B7
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 06:26:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNwl/QTcABgAxj9yzGgtWvMrFOTmQ66XzlUU5tizE3h6IqUGbZB9Uv9oeKqS1buXCvwaZVURRiMpzPKcMDrT2wjsXi1JY5+ItOy6rG/9x/QMe3iipLJM6NkxLqd4bDB5Yy8Um/ZfqP3doKll7fhf719VVrOA52kHLepIb3HkDgr3xjLLdL0quKgK7gaNlZ5NFDtp2T0BTzIVgx7KR4lx7J8vNHfzjmBDZg2WeGW0j+dQrqeZhfV/nAjAqixbCrsgfZuQ2AXNuT9sqm9Nh4pncXUZDQPZNnsyNsLML+6jAth+NhSd/eTXMDtyYBv+kt/hJ08io3MxaTGV0tOMbF4X0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJOMU3aKoRb6Oj+3K40XWgeS9FX3AX0yXfAlfvBLL98=;
 b=HdBZYDumIANfzAmu5+mgrN8NvJWGCjQPqQNG0Nm0vLbUhbdTMjWJP2205tn0asWBQeHY0iVVWbMGPikJttLFgounMLESEcsMYbUKyOA7NlPb805S02usCGFxOc71fTCCKhvo/uHY0R5AI2JDysGHMGOgx2kMjKxo6lvFPFFUS3o6U3eb1HRIjG3W/QX2uVRymN4HG90YkpSb8yDZTWL/NvHtgO3mHyOYVBKdxUJ7aaOr1T0TNw1YqN1XZX8U6QkhDv54CIC4N8qLgecFoCjoCet/lo3SCl1OS6Tjc0qNGWpIDhe/QTIPG/8eq2dXWoxsSpRZE22DZdp8k0lDooIkzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJOMU3aKoRb6Oj+3K40XWgeS9FX3AX0yXfAlfvBLL98=;
 b=BxMyepalZo3HktiTQUo84SpbwGhJZRmEOTw4Lp/ubPgGZ+IMzEyj58YITuv1yjL3azdbnMpuiuZgdUP/MOxdUNW1amQOUf7h5eiKVZK5wWtoC7jM8VxFoIFVyu5BXEWTXoUrv6DKhT8TLcbrrc1j4fNGrXc+SCvjSSgktzUXuvc=
Received: from BYAPR11CA0074.namprd11.prod.outlook.com (2603:10b6:a03:f4::15)
 by CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Fri, 1 Aug
 2025 06:26:33 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:f4:cafe::16) by BYAPR11CA0074.outlook.office365.com
 (2603:10b6:a03:f4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Fri,
 1 Aug 2025 06:26:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 06:26:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 01:26:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 01:26:31 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 1 Aug 2025 01:26:25 -0500
From: <Alexander.Deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v6 08/12] drm/amdgpu: adjust MES API used for suspend and resume
Date: Fri, 1 Aug 2025 14:21:06 +0800
Message-ID: <20250801062547.4085580-8-Alexander.Deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250801062547.4085580-1-Alexander.Deucher@amd.com>
References: <20250801062547.4085580-1-Alexander.Deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Alexander.Deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: d72b423c-0ad9-431b-288c-08ddd0c45b9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?arHuOTPnATBUbdFkuFGtRE8ZnwLUk4GTvhgkaJRHzW2bMPI7xJYbIaeHVevN?=
 =?us-ascii?Q?WIAuCEOeL7krbYLv+lb3vVk9cXuDHIrwVUXyyS0q855FJAWK/NiykxkxC1F6?=
 =?us-ascii?Q?MCF4ZO+Wa6MYDB2wd+OSWoK3rQqyKEKIwuwqlXqcMUEJ4/qRIB58ER+YVppH?=
 =?us-ascii?Q?iuCsRxLEVBRi8QXmMndLfkgOuMSGZvAkIu0mrVDS3ZrmGjs9RhkijM9gh+k3?=
 =?us-ascii?Q?8jBAZ42K+edSJIFSCExfTsnrY/kz9zUhqQtWvVA0lBxIQyUfpH8IqsHppWS2?=
 =?us-ascii?Q?8MUyQgJGqEV/ZJn0fNSDy3XRhILzg49DS+MNU2OcXwVbWDehg7VOY9O9/e8c?=
 =?us-ascii?Q?DR9IPaBdeUsJ8YvSGNZvaiVIbpDmEaJN5PYdLuVxhK7gO78m8MhY8CTuUkhP?=
 =?us-ascii?Q?JXabPSNrflh76sVFJRDXj9pCgXFFhh0FOvGqT8BJF823UXRkwvxU7tiOa6At?=
 =?us-ascii?Q?3vaQWa+bCQzW0x9chHkQuzzX+tdU5ncJHvtzH55FwYnyz87IF8OGEawSPl+v?=
 =?us-ascii?Q?P14ZPr6ldWH5mC/Q6ex9BI41+TLKCNSWJn4c6xpbpuN4AczZg8VWaT4XE7fV?=
 =?us-ascii?Q?xjThHwv24inCphEys8FuQX/NOwo9s/9pcGjcUG6Np+ewUnF1/sw7L8+w+62V?=
 =?us-ascii?Q?gWGbe9Agv86Yvwb63XFlxiSBBIAi6nqLeB4LtlZtC5yDtQb5Go4HWLX2wPlb?=
 =?us-ascii?Q?ce3SXoIXj9uHv/FXtg3vHu7G3jMwt9Z5EPVz/gybVX+QYpQ2ITLa15Z7EngS?=
 =?us-ascii?Q?lFIGB0qHk7sy6okoFvaWM3ebni0TUYOChb2XXBCKsxBJYqlgtx77rQ/VMNwT?=
 =?us-ascii?Q?XG9i2CqFnIfvqbjpcnQaot8i1fR/ymeTMIN7f91lWEDcleOvei+tWlHEQbpJ?=
 =?us-ascii?Q?Tt7fuTOMG/jEVZOII4hfLxD7jzaP5rjK0/AtEW107vKYf4T+72dw4ACpywgO?=
 =?us-ascii?Q?d1T4y6HTzBkxAOa2Z3nzw6TUH4hhxwCBwXs08HxAk0mDCTA5j9hVdYUusaMj?=
 =?us-ascii?Q?xAsNXzhovAd+5J8y50O9txAv675cf37stxr4YJo0mZGU4Xd4LaS6vqf6chrA?=
 =?us-ascii?Q?X17PZYOJBpX8fswTpHOj9u+3QkaA04Fx1Y/pmU0Aw7wnsGXCuQvZ2aFL+9/h?=
 =?us-ascii?Q?3Dwm9RDaSgjd82j59XtoCaCz5MSSwRLf5ZSRhP9wMRN2YGqwzm3N6YCKSC+k?=
 =?us-ascii?Q?/3bk54Af/TFJhYQNdMmRn0t3pseB1ry9cflas1CCmenINKpj4Mv2qWoC7l5a?=
 =?us-ascii?Q?6bnCymlrLA7bSjJN6+qH2xwoeYtX7GmaY8CmlfbEudXm74MEegoLzKf04r4b?=
 =?us-ascii?Q?KhHFoHUp/y2ZFvdaESlSvLmoDMzznpw/kWIey0rLxuANEc3HLd20RUxA+ZQ6?=
 =?us-ascii?Q?3Pq4fU2AvImv8dpohaTPxl4hSSEeSBbblCnL2uijuv0LnyM8xEKTCqCY4k7O?=
 =?us-ascii?Q?qovJYUL5EPZzVg/eKrUoiLvm7nmVBd7xD51HabVUH3JJSEoJ6NlWuIAeOGcP?=
 =?us-ascii?Q?zBWXH5yBwHMTzHTEUNFfNxEKLzmw9W6FGpCK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 06:26:32.4184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d72b423c-0ad9-431b-288c-08ddd0c45b9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315
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

V2: remove queue_active

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index a871bac71e1e..edd4b1757b31 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -395,10 +395,52 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
 }
 
+static int mes_userq_preempt(struct amdgpu_userq_mgr *uq_mgr,
+			     struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct mes_suspend_gang_input queue_input;
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	int r;
+
+
+	memset(&queue_input, 0x0, sizeof(struct mes_suspend_gang_input));
+	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
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
+			    struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct mes_resume_gang_input queue_input;
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	int r;
+
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
 	.detect_and_reset = mes_userq_detect_and_reset,
 };
-- 
2.49.0

