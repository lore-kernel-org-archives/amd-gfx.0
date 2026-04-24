Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A48FB44C4
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2026 08:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD87110F42B;
	Fri, 24 Apr 2026 08:21:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cyfjSd7d";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012007.outbound.protection.outlook.com
 [40.93.195.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A392510F42B
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 08:21:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=so/Yu6DKM4XSErfzGPXJ9/ov6y8qvky2gDcLty08Is/xeFtr7F/kwjt3TOx9JdD/iZdHoBcHVyn2ihvjvMWwoykR0lgzhRBz/rtbmhrg6XJzzxXKpQ0jSi+bW70Q+VV1S6EZZOQ/+DP+ABZmkDtkGWyWWJESw9tX/aYXEjUxrNj6TfG8g2avJlnk9AYdwUpcOPt7S8f4JzvS9ZZ3k6AXOZcMnRglC/StjUhW/ez2OLoYhjrVEmygBTSRjx32jJboxUJ3LnohDoTUhqNJYZzhboDuhZiv4rWyx6+judVPnWOMZxx2HT+ucopXeu2mdUa/8FLLjdd0mSy9PdCYdEDdbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SS1HUQ3qp9VzlcEo46lyY/6H0VZEWyavgS3xVnth6VM=;
 b=C9dSSNt5e+BeICq++cJgPXouWMTkH4eAOAJyrfQKjECojrpFh1IgH4x6ecEvAJceoPdC+pp3tONQoiYz0/H66hdaS+ndOv1am3i9y6jBw7tHFkEbL6F4l2LlfsqjyNe3fEuubjjkrgaAiMaAEfLKcwYoJ59Wq4eQWbTB3FMXpuduqBQ+q6O5r8s8EdHfovoZwjvfP9YnqulzvUznN+St+e9G8NIm1RTCRQSvmxqkNShumdmjxB3wQhOdUtTCHA1TU5xJfYP+P5tsZn5IKlsh6qBhn74K8kQD9Mao1DyIou+Hg9uDfCKWjRAihOtZ8oyn+10wX+IW/N7jTZLIaSm1Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SS1HUQ3qp9VzlcEo46lyY/6H0VZEWyavgS3xVnth6VM=;
 b=cyfjSd7dQ/FdbBdoTDxiOeiCIOj+CEQAII9WpLCJaR1I5pTy6FusVjdXuHpFbq9pUj1OEJrx6pEsz6DhoKVqqhneV7S6i3q9fq8E0H9fJ3yr8HwcHxcbhS2AidyNAB7A8NZkFvS9bdqjpBbcLhQu5XihNMcrCNStNIl3ESBxZU0=
Received: from BY3PR10CA0013.namprd10.prod.outlook.com (2603:10b6:a03:255::18)
 by IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 08:20:58 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::43) by BY3PR10CA0013.outlook.office365.com
 (2603:10b6:a03:255::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 08:20:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 08:20:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 03:20:57 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 03:20:56 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 24 Apr 2026 03:20:50 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 09/10] drm/amdgpu/mes_userqueue: mark SDMA UMQs as user-mode
 submission
Date: Fri, 24 Apr 2026 16:18:54 +0800
Message-ID: <20260424081955.873090-9-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260424081955.873090-1-Jesse.Zhang@amd.com>
References: <20260424081955.873090-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="Y"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|IA1PR12MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: c8026443-1d3a-4eab-6837-08dea1da697b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: fqCjlThPeA7wzg/M1Gfu1+Yqi4pE5WKbj+LpT2jC9HWdTPEHATMJv+zfWoqkoFkBJ2HDOnJWHJ7HH2lEhvMXrLt+FMQ22tpxeiq+Af6x+PXQYOvqZcfylHz4QpJlldo1USRJFjS61TC5azGtWNiCB99s30tt5wkBbVEDsGs1lOWKhEydcDbEI8pEVQpIZB6BJy0SdjOSZwWs+p8xslYM173Xy8X7Ob/j2IRODo9Iq5p8ByCLlNhhQgRTONGBdro1g41OxV9n9mmwlI2XVcwEAPA2j5YAUG1i3TXMVpTHoxzW9tPHrT4GPxZYxG2Tx7LI5AA2hQKqn+mjgIQOhVRgTliYK+LFFF0qP1gw+UGwAKxgzZx16vo0anly+7ZCF440RdwC4T1s+QSDXyL2vkx2mYgXrNPABaHrZIbBFZho/yEaWojSsDW3/O9/vVy1ui8MIcOTGTpgpdlAg6VwNzNhP2vedJGI0DOKcQ1Q8j7YqoMs7omc97hJC0Jklc9t34zvOUws5JASY+q0XqAhgjBI822v2HUVn3H1WJ9uvPCu65AJhLEvPQLH5neU2Yg1hflIISD63J/tFv1NnEy+PfoYVp10P7IheHzrLhoPnTidlKvMT5O8zgcBklurMfUVkgTnm2/ExkwBTExrqFGRAYCei3u3bQYhqAF3InGbI/K/krFcbW8/3AwHY8J3W+sIcmxOqpP2Gn5govFQEwf7ZQKp6RmpvJW2nb15Zqh9G68W1cQ7PY0sCgAo+k8Il8Abfy1PKNQK8N/4GRq+9NeUBS1SuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ycv0xpRp0hWBCaGgtluaAahJBRLbr5z9M8s6MiLms80e6D9B+OY8ukB5s/kD9YLphr8wBwEy2AKmmhvUCjlBDn83OzqhiLLy5UHt8umkbYcEJbOpzT/6ZjhSPbssWKOGVcRdC7MZKy9MSCC8V9Wba+WrjHmR3WjuVO1uQrgPlz+40LtmfAHRSsNYCuehYrTUs/TDBt1J0DiPZ8tXJwtb9SZwbossklVOsT6mkdbftcDW7Wyk/hBjlzEeig6+KsNE8mQgGV2M7R8Hy8b4UD31li4hvxFIU4OILFDNpLxluhCsj+rOeAhKU+TiUrBpldtmQXIdI2EO5BhO/jTWfpAnW1rO91eGG/c4oAr+MIcKcsraZYvzsiMQjkmi53tvFReRb4NoPIoZBZRZMnOhM/sHzH3n1c+3zJUtLnG/2p6ILEchThYd3808uphxYNAmB509
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 08:20:57.6482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8026443-1d3a-4eab-6837-08dea1da697b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284
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

