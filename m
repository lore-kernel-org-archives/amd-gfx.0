Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC1BECE58A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 20:07:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57EC210E68B;
	Mon,  9 Sep 2024 20:07:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yvnKfqAj";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 727F410E68A
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 20:07:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W18vBuOqtnzAccbaxnsUiiq5Re+KXNeHpbWVxFJXblmZm6QUK64QyoSOAtNO2CE9NP0xxT2dylEOfHyAtFWXyOx89t1ayFOm8ub/VUFbzLo+YBTsLZksq/vzSsVAB8I2NW0cYSM66nMiked3HNbkYLqAIQA652rCvCdgUvpwHHxj0hUrGmOI379sKQOkch46z2QvKXKVQnkjDgpcBefCv6y0qqFDzValjIWFWVJL8RSQ3poSdAFCpSx3WEZkLvg1M4A4KAHwvUjBZcYZd0QuZytrOj97ib3owgbtkBM9A3sScokRrluGbYFd/9GazkrgQ9UlN4d+2fGK8fjxdY7XtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzmKfEiHWzwRXbcocrk8HxNr3HGoVu95Q5f+hUqq9Ag=;
 b=jSOV5KBYZ8hElOQJLGwqF2rHRP8Uu7aRw/VDFxWWmGd6Hs6W1cadHth3Qi2b89azFkIfswVP4uOPBE0xLNv6I5/urtiAQHcWoWicniQAYziQKlR/OhhCmiamuPM8kVcykVFjXCz89FUBoVNnR/CQc6wvCAbjRUvdRn6loN7eXaZ8CvHDHXb7y52cZBm36BIB4qV/27PMo79/XGX9ZEpKLZbtEr+MXNLvJtG12P5XQWxTY0mhkrEnNpfHwRmlbU1KB0O+1yNIDcZZQZxi1h7xv3buLJ03MFSFl7cXvuvf/OSGRTsqwToUsutoiThVhu+R3WWgHSe8lmyJCYUJPAlSuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzmKfEiHWzwRXbcocrk8HxNr3HGoVu95Q5f+hUqq9Ag=;
 b=yvnKfqAjAlfjv07GJfBe9GXEj10JZ+4l0+9OiuHQQm3MuQUd77Ock1CnPhTFJpGRu8Ar/Ro8O/wa5YEGlEB15L57SQtslEcjYBGqxcLd7XnPttlJvNtfkN3FF5P8t4drcLR3eq8pT3S0RLaSp2lEaosVJrA1YNeOSQSsn28U8t4=
Received: from PH7P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::30)
 by MN2PR12MB4392.namprd12.prod.outlook.com (2603:10b6:208:264::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Mon, 9 Sep
 2024 20:07:16 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::3) by PH7P223CA0029.outlook.office365.com
 (2603:10b6:510:338::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 9 Sep 2024 20:07:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 20:07:15 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:07:12 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
Subject: [PATCH v11 13/28] drm/amdgpu: enable compute/gfx usermode queue
Date: Mon, 9 Sep 2024 22:06:04 +0200
Message-ID: <20240909200614.481-14-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240909200614.481-1-shashank.sharma@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|MN2PR12MB4392:EE_
X-MS-Office365-Filtering-Correlation-Id: abe4723d-6e7f-42b6-c0fa-08dcd10b0037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkIyRnUvUDUwY0h4anlvTitjREZHcEVlc3pvOGFpbE1UKzRoVGtoYWxJRGNl?=
 =?utf-8?B?K1JFVWhmaThrOUlhaStPL1BYRWxWRy9WTmx3emdZTGRzZ1VkSENpVFJVc255?=
 =?utf-8?B?WDVmK2tqb0hINEZnUFU1dVc5NDRadjgzZnM3dHlvZ08yMzZnLzhvNHNiSEJx?=
 =?utf-8?B?NjFJcDEwbVpmNmtuRjB6NnBEUnJ1V0xJMHQzeStIR3NMbVlaakFCNEFvbzBt?=
 =?utf-8?B?eXNFRkhLWnowUjA1SjU5MmNlWnl1d3J4T1cybVk5L3ZDQ2lhdjBDa0dlajIz?=
 =?utf-8?B?N215dTI2RWttZ01MY0dXK1dnOU1QK0NsSGxwYnRQQ3hxR0hnSlZYWHlteTRy?=
 =?utf-8?B?MUJ4ZitNNzhtbDBxSVF5STZSTTFKZWZxUmdXWkltM3NkbkxYVDdnL1l5dE1s?=
 =?utf-8?B?NDN0dDcwQUxHMWlFbzNiMk5GbncwRkFPQ3NyRXFCSm53SWZoTjlVMGJWbURh?=
 =?utf-8?B?akh4Vk1iVHRCaGkzVitNNHQ1STFLOE90NzlGM1dIVnE4Q3Iyc2pNQlh3UWlH?=
 =?utf-8?B?dEUvdklsdnp1YzBnUnlXUzlNazFybjk5dENhZWtnK2dsdG44MysvOERTQUYw?=
 =?utf-8?B?dGErZm9aU2NEdDBYL3dRUERvZUY5dm82TW1WTTFsNjJ5SmY1cTVrcG03TlVU?=
 =?utf-8?B?T2FDOFdFTHNMSFk2T0Y3YkxNS3JsOThwbk4zSyswckNVQk43UFpvZXdCbkhP?=
 =?utf-8?B?MWo4amw3WExhODR6NzV3QVRva1dqWXliMTdsZWFxUG5kWGRNWStxR3hCdmk4?=
 =?utf-8?B?WCtieWlSMXRtUmZxRnlJMVA5VVErelN1V0tzblJXamJNU1B1OHhZVnNIZ3Bv?=
 =?utf-8?B?Z2NNTkxuWExvcDVnTjNnaUhoTks3bk04aG5UVWtuNE5aZFFpOUtvYkJWaUhQ?=
 =?utf-8?B?OHk5NEluL0t3THBoZjFjQzVLZllsamxhYWd0QnA0R3dJVmlwWUJqUkxHWTdz?=
 =?utf-8?B?RHFBeS9TWXRoRXhOQVVOaE90dksvS1p3TUorbW9Fa3k4L2hoTkdIMG1xQWRq?=
 =?utf-8?B?blJjZW93WTFuOHlPTUUxMWRnRWNsODdyaDM5dmI4NnpGak9BYTlMdjFWcnQ0?=
 =?utf-8?B?Yjg2anJvL0dWRGROTU1qMi9aQ1dkWXZmK2JvQ2Z1R1hTOWljMDluOWR5SjY2?=
 =?utf-8?B?WlZNMG5RVzBxa1ViNmVKUlhTRytrS0IwRkkycUVvcTc2NW9tQzl1aUx4aFJr?=
 =?utf-8?B?cGw5Z0Y4NE1pSTBNam01S3BYcVg4VUkvR3BJZ1lyNzJyS1BhckJDQnBTeTlR?=
 =?utf-8?B?SlYxR2tvc0lNci9ETm1PeHJzenNZeWF4SXY2UjBpaFpwZUo1a1QyOWlXQmRQ?=
 =?utf-8?B?SW9rYWxBZnNNSXlNNmJJbXY1N2Z1NExMRWdSYTdrd3dSa1l4RlVoeXgraWxz?=
 =?utf-8?B?U2hGY0E0TkJHTXBrSjRSNlR1bTBnUmwvcFVBWkRQTGpkZHYwbnJwU3dWT0NC?=
 =?utf-8?B?YldvZ3lJNWEvV3QrblYzRE5EbW9qa2dNNllUdEs4aWFINnI2TlhuL2dJQnRV?=
 =?utf-8?B?amhBUENVQWFpQzgyRksxRFpTOXdCajM3M1VkeklxQmkrUFdyK3o1VWdYUmk5?=
 =?utf-8?B?Z25FZlZ1STJGVlM4TExoa1EyTEpld3UrVlpWVG5SeGlvRzBzUUtJcFdVdVdw?=
 =?utf-8?B?eTkxSzIvL09JSDc3TVhUYUVBUVhIZXFJODRMSGhSamd6YmdMd2ZYUnR3QUhV?=
 =?utf-8?B?L0dyNk5iL1FIUkFISmZiMHRDTTdsZ1JsNlJKbWo4WEpqRlNTNTUyNWs2K3Ju?=
 =?utf-8?B?OWtOWnRyMzJzRlF5OVNKVEJlZHBBQUlkVnJuTDIvWEJGcVFNcWc2NFFaU2VD?=
 =?utf-8?B?YkF3R01SYlI1ZmF2czFKNFc4bGpYOUY3SWp0a1kxRDV5OEIrKzZzaGY2V0ZM?=
 =?utf-8?B?ZkExbGdmakQzcU14L3gvK2owanViL0F1c01DbnN6eldqQkxYNkdWUUltVHk0?=
 =?utf-8?Q?F+tOyAsCLkGKVFODCzm5eavjczCQNmqo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:07:15.7485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abe4723d-6e7f-42b6-c0fa-08dcd10b0037
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4392
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
V11: Rename drm_amdgpu_userq_mqd_compute_gfx_v11 to
     drm_amdgpu_userq_mqd_compute_gfx11 (Marek)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  4 +++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  2 ++
 .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 23 +++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h                 | 10 ++++++++
 4 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 2c5747cc492e..5173718c3848 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -189,7 +189,9 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	int qid, r = 0;
 
 	/* Usermode queues are only supported for GFX IP as of now */
-	if (args->in.ip_type != AMDGPU_HW_IP_GFX && args->in.ip_type != AMDGPU_HW_IP_DMA) {
+	if (args->in.ip_type != AMDGPU_HW_IP_GFX &&
+	    args->in.ip_type != AMDGPU_HW_IP_DMA &&
+	    args->in.ip_type != AMDGPU_HW_IP_COMPUTE) {
 		DRM_ERROR("Usermode queue doesn't support IP type %u\n", args->in.ip_type);
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index e68874fd0ff9..82a8df56240e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1554,6 +1554,7 @@ static int gfx_v11_0_sw_init(void *handle)
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
 		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
+		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_v11_0_funcs;
 		break;
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 4):
@@ -1567,6 +1568,7 @@ static int gfx_v11_0_sw_init(void *handle)
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
 		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
+		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_v11_0_funcs;
 		break;
 	default:
 		adev->gfx.me.num_me = 1;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
index dc5359742774..e70b8e429e9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
@@ -268,6 +268,29 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	userq_props->use_doorbell = true;
 	userq_props->doorbell_index = queue->doorbell_index;
 
+	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
+		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
+
+		if (mqd_user->mqd_size != sizeof(*compute_mqd)) {
+			DRM_ERROR("Invalid compute IP MQD size\n");
+			r = -EINVAL;
+			goto free_mqd;
+		}
+
+		compute_mqd = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
+		if (IS_ERR(compute_mqd)) {
+			DRM_ERROR("Failed to read user MQD\n");
+			r = -ENOMEM;
+			goto free_mqd;
+		}
+
+		userq_props->eop_gpu_addr = compute_mqd->eop_va;
+		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
+		userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
+		userq_props->hqd_active = false;
+		kfree(compute_mqd);
+	}
+
 	queue->userq_prop = userq_props;
 
 	r = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 3ea067242b19..6eac46e0f3fd 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -438,6 +438,16 @@ struct drm_amdgpu_userq_mqd_sdma_gfx11 {
 	__u64   csa_va;
 };
 
+/* GFX V11 Compute IP specific MQD parameters */
+struct drm_amdgpu_userq_mqd_compute_gfx11 {
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
2.45.1

