Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF3AC04FFE
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 16:32:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B695112592;
	Thu,  2 May 2024 16:32:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hw1yktLB";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E396C11258A
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 16:32:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQxnmjzgoSAummOSrq/J/TBFyoFZtUiz0/X2jDMVOinBsdvjhIIJLgVNH1Q+ocMMEr3M+wX6ReE5Ox72+isuK+YY0gkRh3BHEAnDCxFPHOiWE9gPjnPr66/XEjVd9QDK5JUy1yzh9XlLaApF3a1A7qEkBFv7fYcB2855zcrVgcwyojoXkkkegC2a/rVh1lgEkluiq5YRIglzKaclanhGmkTEGn5/8JYMw67r1gzz13H+m4Tb9EE6miRjMmtOdsb9PE4wN9vMLn9eF0rVXL6/aHt8qPQrlw/il6vN6uj7STLpLGDemuSEt4JbxP4A2QwUFm81EBlebXcgABbUUVzrTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACDwLfXT7aSgB3Wa4CZgzRRw6k50W8SjHix31yhuuX4=;
 b=F37dOLR2z+eh7i92adqByGCESfu24od4fcsol+6hsRZVUv6ORwXnpeG7L/vr3vuHjC3dUZFhvPgekBfApFRFMhsFGgbkxD/kpkGgziixJEuLWYEGdNp6u4Day69luuB4PaoItZTfmWThoFJ7LUc2ffPk9HKhuirHLnf2NUdcfxz+HZLL8vTurynMwU+7xEl4b6JCqB31LSCVTgsP4y7AYefRsdfx5TFMs/bXEmtJDf8j/7KdKzzt9ElAlx92VmPKjeEo5kXrOZRbaSznjBCgjsBN3zi+5g6eWyyemUlOKIMhPXyrqFLypNtzZAbxGpgoC3YxHwlJ0b1xejobQQlhzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACDwLfXT7aSgB3Wa4CZgzRRw6k50W8SjHix31yhuuX4=;
 b=hw1yktLBPK25XoMxfjquIwgdJ3QVolgSTp5OgoeTcHF9qiZQDOEYa2sjISWx+ru9wHnn6GVzvrdD5p0Jr73LJ3PiNfxOHoNZBZbsYLhUHRXK2Mb/9UXRo7vQr/pF0cOVE0a0vQ1o6iL2ugfw/PMkyYt+DD3M1v2YVYCKSWpASTQ=
Received: from CH0PR07CA0005.namprd07.prod.outlook.com (2603:10b6:610:32::10)
 by DS0PR12MB8815.namprd12.prod.outlook.com (2603:10b6:8:14f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Thu, 2 May
 2024 16:32:44 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:610:32:cafe::e5) by CH0PR07CA0005.outlook.office365.com
 (2603:10b6:610:32::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Thu, 2 May 2024 16:32:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 16:32:44 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 11:32:40 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v10 13/14] drm/amdgpu: enable compute/gfx usermode queue
Date: Thu, 2 May 2024 18:31:50 +0200
Message-ID: <20240502163152.1382-14-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240502163152.1382-1-shashank.sharma@amd.com>
References: <20240502163152.1382-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|DS0PR12MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd52aa7-7693-40ab-296f-08dc6ac57ea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SOEihcET8/m8s95ZYEmkxd0au6DrxjTBuLrD495jIq4JhXSXcPWZnjkQc1xG?=
 =?us-ascii?Q?1SPISzrB/8GXrDM9SF6lF2He9gsHkPafWceVRXQBed792FS8OY5yL4X0pwFx?=
 =?us-ascii?Q?gag0aHQdKKtN8NLkOucrY9fh0WisINawAadPhfOaRp8fIK9d2vXyikVdbAui?=
 =?us-ascii?Q?1oFTTXbq9N6whlXhlaJ362JfmB2SF3vD2L2WAkE8bNu/shvniaK7FfZ9yLxM?=
 =?us-ascii?Q?c5v4/aRNVUu4z8qAfYA7iH52/HrBB/sHuj780OzgrHjyGBEAZuyF2aiTpocw?=
 =?us-ascii?Q?6wjce35npS0D2nvkT2kddCKEMNrKlsmg4w6EpkcWg3hYo1Y4ZyRNOzkVV8Z+?=
 =?us-ascii?Q?hxVzajWpH+tRpuNp07XlRhBqnSrCWFyVsn3iFrfTJrf3NvrGmBwHXOg4cqvZ?=
 =?us-ascii?Q?Bo+WXvzgmTQo7xkvhb4rl5C18OzZ3CRLv/YxVs3yd8Asw2nepHWLwMpw+bHb?=
 =?us-ascii?Q?NJFg/tgb1PBGHe8zRli7Yz0NfjbgmqR59adk1NyxP+yUar1ekj9nKk+qSNeC?=
 =?us-ascii?Q?BR1eaOkIl08oR5GZrk/egNMR3kDOctN3hIP6JxyPKnluK2u5839c1lR+91IS?=
 =?us-ascii?Q?99OiGujxGC4uupT9FR5tQlYzehRwmIRHwfbAZXOiA7aYS7LgK3+yKz9SsvUx?=
 =?us-ascii?Q?HRBTENJXd6mctxAkfh3GimX4VxFy5lIKUKBARaTOgnGwsgRoy3OXZBNPMAMj?=
 =?us-ascii?Q?4Mg1QlfJQe6/U6+uGNCimjrQ9xoxCwl5xaWzSCpiLJfHmWLNaxIeGOt12gp1?=
 =?us-ascii?Q?uaCPnaAlxooHqGi9E5X5UWrBk9GibQzinSd/ymRM87Z8fK6BpPjLDO6kBkEl?=
 =?us-ascii?Q?R6uWO+0vIEcvAENSSN8lfVLrVaeuveCKVSMCgWfI3Wa/vyrHgScbwP8c1LVi?=
 =?us-ascii?Q?RoMUHcjOrKLxgAq3YDLWFZL29+K929lcrq6oYKDYULXkyhY2H72D8NyVrDci?=
 =?us-ascii?Q?8zLBL6BgsG8St9uoVDT5UdCsBRe/gGuNCaq1/ZcUrPIW8YtfAZGs+DNSIV9U?=
 =?us-ascii?Q?M+aaHg95X8ohnoMmcKf7duOa6m/f8OUvlXspBGctyuVMusdFiwEfIdzYKcnD?=
 =?us-ascii?Q?0FIR4VG+hdaVZl4fMgliLXfJ3420A9KJyBCg9CE4nY8stNu3Zkh6KtyITMxe?=
 =?us-ascii?Q?ZKgJj3tspEaLgV2AaZg4nAHTbTl6ETw51WO+/0AvyvfRheMNp5KRQtiiRc7I?=
 =?us-ascii?Q?mAwEPIbKt4yCHF8i1gKtfEt4/uKkSMWLHbAFMjSRGWi66hGghtiepF4Htg8O?=
 =?us-ascii?Q?Vt74JsNgDIrWPq8OyL8pWoWpHhHJcWDEPiY/+V8++r3EzCzBezWT1JVL925u?=
 =?us-ascii?Q?ErKcMRvYSNbn7+vlzTgDD157UX7h80WC8sN+25Wm0h/2kXXuJnlyBFa9dX9Y?=
 =?us-ascii?Q?YBkj0vg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 16:32:44.3969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd52aa7-7693-40ab-296f-08dc6ac57ea6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8815
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

This patch does the necessary changes required to
enable compute workload support using the existing
usermode queues infrastructure.

V9:  Patch introduced
V10: Add custom IP specific mqd strcuture for compute (Alex)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c    |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c           |  2 ++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c | 15 +++++++++++++++
 include/uapi/drm/amdgpu_drm.h                    | 10 ++++++++++
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index f7ece0b31ff9..84bce9434102 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -189,7 +189,8 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	int qid, r = 0;
 
 	/* Usermode queues are only supported for GFX/SDMA engines as of now */
-	if (args->in.ip_type != AMDGPU_HW_IP_GFX && args->in.ip_type != AMDGPU_HW_IP_DMA) {
+	if (args->in.ip_type != AMDGPU_HW_IP_GFX && args->in.ip_type != AMDGPU_HW_IP_DMA
+			&& args->in.ip_type != AMDGPU_HW_IP_COMPUTE) {
 		DRM_ERROR("Usermode queue doesn't support IP type %u\n", args->in.ip_type);
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 888edc2b4769..46304d09c4bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1349,6 +1349,7 @@ static int gfx_v11_0_sw_init(void *handle)
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
 		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
+		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_v11_0_funcs;
 		break;
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 4):
@@ -1361,6 +1362,7 @@ static int gfx_v11_0_sw_init(void *handle)
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
 		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
+		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_v11_0_funcs;
 		break;
 	default:
 		adev->gfx.me.num_me = 1;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
index 80375894c4f3..2ae6f720dc66 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
@@ -260,6 +260,21 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	userq_props->use_doorbell = true;
 	userq_props->doorbell_index = queue->doorbell_index;
 
+	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
+		struct drm_amdgpu_userq_mqd_compute_gfx_v11 *compute_mqd;
+
+		if (mqd_user->mqd_size != sizeof(*compute_mqd)) {
+			DRM_ERROR("Invalid compute IP MQD size\n");
+			goto free_mqd_user;
+		}
+		compute_mqd = (struct drm_amdgpu_userq_mqd_compute_gfx_v11 *)mqd_user->mqd;
+
+		userq_props->eop_gpu_addr = compute_mqd->eop_va;
+		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
+		userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
+		userq_props->hqd_active = false;
+	}
+
 	queue->userq_prop = userq_props;
 
 	r = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 6798139036a1..7ffa9ee885e6 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -429,6 +429,16 @@ struct drm_amdgpu_userq_mqd_gfx_v11 {
 	__u64   csa_va;
 };
 
+/* GFX V11 Compute IP specific MQD parameters */
+struct drm_amdgpu_userq_mqd_compute_gfx_v11 {
+	/**
+	 * @eop_va: Virtual address of the GPU memory to hold the EOP buffer.
+	 * This must be a from a separate GPU object, and must be at least 1 page
+	 * sized.
+	 */
+	__u64   eop_va;
+};
+
 /* vm ioctl */
 #define AMDGPU_VM_OP_RESERVE_VMID	1
 #define AMDGPU_VM_OP_UNRESERVE_VMID	2
-- 
2.43.2

