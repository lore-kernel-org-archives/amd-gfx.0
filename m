Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E35C87FD3
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 06:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE3B510E4BF;
	Fri,  8 Aug 2025 06:29:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xM05/5E/";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DCB010E4BE
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 06:29:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7HHpnqV3G8a7qnS3BRgGFnQDJyD44KocP9gKjcSBLnaGLbzLc2kdMU9P0mxYZF2vnl+1lupXV5iqRwvC13aCDYHS+iXK17F3i1CW+RTOF3YM/lcYPyaCyghHE+9J1+oL7cQJBAkZLr9674G3vdh0UGi8926Y7pClRigJnEr6UGDRbhoqu/wkNTPooTJM3BRS5RwHP7dfuKaRpdcpqwescM7ADrWW3ceAD+KZKUK+lkZjWThILU0djRrhYnTj6EV2Kl8uYh6aSEpyQBdyHXRq9wAGY4ZzEbqJ2APz4QEH8ny3PjVN+U9VCMHI7WPWfRybRJGLBeahdQAEuTbXe3qEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSQ0a4aaCk2NnsvLTWBBiYeJ4AXZFSRj/haAyPo/oxA=;
 b=Eog/8rImxPbm82aeqEVakXieKDBd+mnh6P4yzJHbuQutLolOsIQU0FGC5CbSrxQPvyFpcLFhsyWGr7dwIcsJybAlwoe1xRM9mj13ahCswLCwCGA6kQHRJLaTDRIS4uX1QGhztYzv5uXliUAycI1haGu1Cw3h8jdct4JgbLiyXnhG3Lcc26ACruc9jBXpWm5ZozRK+nb0hstksJbtE0Aiy8L36cXhU2JkQLq1RBJdPh5oBVaEj/Yp9e5WGekGeqDYI/akeDQgXLSnMppfvTYIlyyQN4UHcQ0tQzXspXCxeALohSgp7RoHWWnMA4Hmabyiw4SBEVfntW7cefHyrFijAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSQ0a4aaCk2NnsvLTWBBiYeJ4AXZFSRj/haAyPo/oxA=;
 b=xM05/5E/kU8xbvs7cEeGOJ0UQmHiOmiNPcJiQfqv+5mCGoGUqLkZwO4zn864w066EvcbQIXJdIZNSH6n2roFvA6wsFL1VYS7qnJ8BtrPiCBulzfbygfbadbNWZ+VRkYiG5Cuh5h07TfQFz/d9h55jBj2MukbVdI/WrhXAvzLIdk=
Received: from SJ0PR03CA0359.namprd03.prod.outlook.com (2603:10b6:a03:39c::34)
 by DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 06:29:37 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::b3) by SJ0PR03CA0359.outlook.office365.com
 (2603:10b6:a03:39c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.15 via Frontend Transport; Fri,
 8 Aug 2025 06:29:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 06:29:36 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 01:29:32 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v8 04/14] drm/amdgpu/userq: implement support for query status
Date: Fri, 8 Aug 2025 14:29:00 +0800
Message-ID: <20250808062910.1613453-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808062910.1613453-1-Prike.Liang@amd.com>
References: <20250808062910.1613453-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|DS7PR12MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b81710-e840-414d-ecc1-08ddd644f273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tqIdsFjP+kGNxPEf10BkELvMNrm+E2ECCkoyTweGDALDTHJcnWE8aGRtSltO?=
 =?us-ascii?Q?66K665EHbuAlV9cEZVutI8c6UXyg9k7uBclm3eL5Iiz9IMyRBxUG5aPJw5Uc?=
 =?us-ascii?Q?XA6603m6y2/YSNYS1n9YtkVbjwav8jFw3OHwIW2KpeSXbR+b9Y7aUQfs2NhD?=
 =?us-ascii?Q?vXrs18CVjCqhSPpYguiS2fHCs+8hyK+Vbd0Qdo361ZisWb8DEHwIr6/oLouc?=
 =?us-ascii?Q?cYVvJOWK2d3ogbqeS3YXphH5w/kQs1SR/nWPMg3NicGzJBPOUdX1FPWY4w0x?=
 =?us-ascii?Q?A1gl2YirR1sWs+l+4gIXBjZesL6zEJMooUxXjWekr50ks+ezEmajp3SO8ZRu?=
 =?us-ascii?Q?+ym2pePV1av81O4ktEGAVbRLzi6cGG/Im7NMeU8Fjx/OCBYBpuUtZh1QcIuV?=
 =?us-ascii?Q?CHHUXhVVYxtV5z5DnReTYa7hZkLg7VoSQKJkZdzIP+6otuJ9fijh7KTkt/XF?=
 =?us-ascii?Q?TcC0ykWom6Wdi19UiKyMlZbxflijKXFK8Bfgp4989dCcVXivoXuZO1Z3oTNz?=
 =?us-ascii?Q?TwW8h1fwDel0taRRRbzyUQQQ821PXt9eEt7khRB85roOsLdqeBcjWck1Xf73?=
 =?us-ascii?Q?FlY1oKS9x3vc5gUK0CneZTgMEI5dCA9YhVo0aS51gBg0zd9N2XuAlz4kyNku?=
 =?us-ascii?Q?e9RN1Y1zLT7YUZqKVMaM4eQWOLzLDN+6VnUMn8v5j+J5Gczm9DRpZVkXm4cj?=
 =?us-ascii?Q?Rmfq9oxuaXfZvI9BlCjr6ehByIFHiDevq2i5bkXmKY6OQpP6hF73tQ7bgXTR?=
 =?us-ascii?Q?DCxTrdDV0k6XcegYsGZ4kRM4IPEo+z45CgQxpyVFsVrZ3hMgHWRzyLpmpCA+?=
 =?us-ascii?Q?uP8KW25sUkEpjq/qMy0k6w0EiZ8wjk60JwrSY6d21m/kkjLvcXE6iyfewO3f?=
 =?us-ascii?Q?A1CE0ElGN094x6uYBP+0/Zk0wBYZCNVK9CFWh8+tK6vtSRCcKeBefoIpaC7H?=
 =?us-ascii?Q?6zHUEXZ5O3tq6KM9RLPthDP9/wSihxekEzb7fdB/C4v2gFsqo/1KaE34tfpM?=
 =?us-ascii?Q?SPzRXJhKVg/FFVc8QEWw+ok/lZOAZXVV+0x/+sFGbrt2MjzJbgu41ATbnDWK?=
 =?us-ascii?Q?q9vPEtisMVOTyy87039dyx9OiI2TxSShxlvTJ/Yz3vc8C+k/SVbJ7MV7DX/w?=
 =?us-ascii?Q?c9BkW+XFrPSN0MiqLaY6fdpGgtzyqkrYtlK5nEQ27oclzY77N8bc3jBRkhpX?=
 =?us-ascii?Q?8nuMh/MangXlYUygms958fqjiOVNTQuR5SOJGLnq0O0TGp8Ij7E7qR56HDPK?=
 =?us-ascii?Q?zPY1OKK8UVfx30DFv/vajmY2l4vWhE3vqqnR9e0MWCV9n30gt3EJr8HIt8k+?=
 =?us-ascii?Q?4JMVnywcaVvui9R+203QhXbs0OejsCuk5Vc5BTTphMhyqm3LZfe0NJ0dRKNv?=
 =?us-ascii?Q?n6rZJiuHkjAQZ0r4jQKIPCuy/HkQ9rEF8fVYjumj0YDr0sDPCUUoLlVC/3lD?=
 =?us-ascii?Q?LkO8sIAdKj5/zCAiw/3Nwa6rmVVNoGNkSWOa3TcBKavAlZ42vIDbmGE5jEYS?=
 =?us-ascii?Q?Xz6wdAvS5GXWo279mNhSVpLYSjEvXGECPcKl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 06:29:36.8931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b81710-e840-414d-ecc1-08ddd644f273
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864
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

Query the status of the user queue, currently whether
the queue is hung and whether or not VRAM is lost.

v2: Misc cleanups

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 35 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  1 +
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 2b35198608a7..75b7e39ee576 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -403,6 +403,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
+	queue->generation = amdgpu_vm_generation(adev, &fpriv->vm);
 
 	db_info.queue_type = queue->queue_type;
 	db_info.doorbell_handle = queue->doorbell_handle;
@@ -473,6 +474,34 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	return r;
 }
 
+static int
+amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_usermode_queue *queue;
+	int queue_id = args->in.queue_id;
+
+	mutex_lock(&uq_mgr->userq_mutex);
+
+	queue = amdgpu_userq_find(uq_mgr, queue_id);
+	if (!queue) {
+		dev_dbg(adev->dev, "Invalid queue id to query\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+	args->out_qs.flags = 0;
+	if (queue->state == AMDGPU_USERQ_STATE_HUNG)
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
+	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
+
+	mutex_unlock(&uq_mgr->userq_mutex);
+
+	return 0;
+}
+
 static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 					union drm_amdgpu_userq *args,
 					struct drm_file *filp)
@@ -554,7 +583,11 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		if (r)
 			drm_file_err(filp, "Failed to destroy usermode queue\n");
 		break;
-
+	case AMDGPU_USERQ_OP_QUERY_STATUS:
+		r = amdgpu_userq_query_status(filp, args);
+		if (r)
+			drm_file_err(filp, "Failed to query usermode queue status\n");
+		break;
 	default:
 		drm_dbg_driver(dev, "Invalid user queue op specified: %d\n", args->in.op);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index ec040c2fd6c9..48722936ff70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -65,6 +65,7 @@ struct amdgpu_usermode_queue {
 	struct dma_fence	*last_fence;
 	u32			xcp_id;
 	int			priority;
+	uint64_t		generation;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.34.1

