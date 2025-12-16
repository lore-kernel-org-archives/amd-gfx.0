Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCD6D637B7
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:04:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4462B10E896;
	Tue, 16 Dec 2025 21:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YXL723ZA";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E411110E883
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:04:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unM0NuMVoxknvlIDiGQnxQWXIBY/sjCrbsN/CAvXkdfqnMsf35VSjNyp0jPaPHXMuwE1sQtL1XGYopGcSeDzJKkQybyY3z5f4iH+FK7UzXHaGlDtuyUrCwDuccPRjKyQdCoXJyUnxcMsw+cgcNNHGWS663QKvLd6kLHFiYExUFQnK5FFfIDIfNo655AlNJf5MVjTJK1w6CslZlM2bWpNKP5Zmt9FuHX44tXxC0BEfVLAY72w1+M8fjB3fKIJ1N1okKOrM5Q9TYYtieKb5TfCpy0g60gbhdZzXWFeFr/BrZw5EnWvGZxrVIu+4qTjEH8kCJ5nk1V2k4/FSrch0IdtdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeiHkbrwpT/a5rw2iMnBdB8p8g1ye2D3Vgl02Ky80bc=;
 b=NE6BAnPqUvFsr1geIwY65juGoT17HvUveDW7kJEejsW66LflIynbSLfAJcgE8EAhTvBAy3koeVepBPjubGlFZTZMYknflZT9H8HlR1fkkCzYas4JQDoN1uZ1AYXeTTG64QcJmxcMBoHtwm52WJhAqNWe2aOsYrmjstMKS+i6w5hXich3dKpAfcMzeL/EY1FtcfhRKByH5udkyBFFFwbQJXes5bSPhldnZjejwsk4P+BgWBFYU0V30q/Cc8BcPzkUiW5UEQFKuYbcOaVCXQmTcmjE7VC8pBzsmdyOlYb6Kcf2EaVKMV4pu1vCW1GeeuTGs29gfrovbpHaHOZg77flzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeiHkbrwpT/a5rw2iMnBdB8p8g1ye2D3Vgl02Ky80bc=;
 b=YXL723ZAnfKF+SSR5v2D+FbhHzOJC2CpPFmJLonmDLaXeiOuiJiwL/3kWtchOGqmgbWUYL/r/qwlomIREDfWspbDFaItRa+qRZ5uAwUXdnkNbu60BnRXYB996deKSMg7l3ITvGRUdYCPIa6x5a2Xk70FW7hNzJA+QKuA8tSDEtI=
Received: from BL1P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::30)
 by LV5PR12MB9777.namprd12.prod.outlook.com (2603:10b6:408:2b7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 21:04:13 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::7a) by BL1P223CA0025.outlook.office365.com
 (2603:10b6:208:2c4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 21:04:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 21:04:13 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 15:04:09 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Yat Sin <David.YatSin@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Add metadata ring buffer for compute
Date: Tue, 16 Dec 2025 16:03:41 -0500
Message-ID: <20251216210349.1963466-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216210349.1963466-1-alexander.deucher@amd.com>
References: <20251216210349.1963466-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|LV5PR12MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: 62d75011-a731-4bab-2ec0-08de3ce6aa54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mbqRGcl/jWDkTn9pPd9EYfIZ9EDJgHdx9GjXM4qqI+QKwx2v58Z2B5X98qbo?=
 =?us-ascii?Q?HYHlPHpHeqM71iW0ZFjwOB3JO1QiKaogSfst55vElfgjeBgqMYRqbAZIXmUf?=
 =?us-ascii?Q?dgFCX7tu6xFulkyEm1OLxng+IlRC+229JtPSIuoijDflS4q8JriPoNTJ4Sb1?=
 =?us-ascii?Q?MbbkY0exCEqQcIuX2jaebE5ffgOm4EhaGc+rjYLx8ibQx3vfgEG2q4ZchGGv?=
 =?us-ascii?Q?KHPhk3sTene5OKe1v7KaW1WRd22AmSZ9hH9zelw6x2fIlGPwC5BF/5U/UzC5?=
 =?us-ascii?Q?uGqyqkI57cxWakpUQNO4UAIFAbVp4ZT18oa/IdYKOfUQHkQxh4K+OChMsAOe?=
 =?us-ascii?Q?gMgYuR2/+BIrVp7h32kdAupsWlJOGxEwspuk3Jk3bfI35NbNThkXAI+y0syb?=
 =?us-ascii?Q?oUrTGib1WlXim9RT2QIYL+d+U8w76BsK3FjjNFKE9LsGe15EudLgbmEbO4cW?=
 =?us-ascii?Q?knXsE2HPV+ttj3zwu9b8CAZCYyk8HaT0NiU6RDzxPFEd5cpXjy3PVZSloF7h?=
 =?us-ascii?Q?5A6L4WFuK91aRkN5t8uoodJjZ3YEiGJ0gsxb+HK+3BJZOvlOtHPNhBNat+g9?=
 =?us-ascii?Q?yQzWQJokHojoiUnywYsbAvzfGkwwS9lizLKKiUVhHTxsZrbcVvLeMKYEuvcT?=
 =?us-ascii?Q?UYYhun0lxUc+N2JXfEZ2OusFx+OgdrHD2uZU/qiwbxMG2/DPOc+iyoJbwBZX?=
 =?us-ascii?Q?gbFCtuPREJikVL8OfWjJWwE7jZk+6B3KtWNAbU1ZL1WdWd2rqyi0WYDXodDJ?=
 =?us-ascii?Q?tQW8kxU0cCBkeThXDduHJORi87d51BPBGnbzCmOveDZk7zEexbjpJZ6dfykz?=
 =?us-ascii?Q?+q0b3SPep13JePbRgCOqbmB+sKs5hFXXI/K+96IGrIWHfKfJmLfPNCK6DFvh?=
 =?us-ascii?Q?J2I/irTb/CLpKERxXqkDNYglXMFfAgfllfRpcfWvPzPbfcXKJhwUVZEY9L1U?=
 =?us-ascii?Q?UlFDDt3NyYrhfhTAqN6QVVVO7zBiw16K7wp85U8MLUvF9NDwe0oG9FAzbgO/?=
 =?us-ascii?Q?RCE0ocu5ceP170I9En2uzFoUACqNIv0SVG6C01uz6S5rhinLEDb2TMWL93/c?=
 =?us-ascii?Q?f6SYfYeVsstFRCnQjm0Ujq4zXQUvAeWMNNMpLhAGBruBFFAYz4pojUzysSCp?=
 =?us-ascii?Q?xPG4Rl2omjvbLyeTg7RVHIhNBHtxi1XF64005MnKd/LzdRTdqZ0gUPbX9zd3?=
 =?us-ascii?Q?/re1z7tRReKuf0EmrFw8qIrZLY6Qk90188WmqCZD1sTrt3+/4nA06QQea+XN?=
 =?us-ascii?Q?yRconLemMvKpERJYDfoAtRcIX/S4T/5OcNoGUzm+wWZ+eu1VBBexJixlzJ+G?=
 =?us-ascii?Q?ygB4sKOHzAuNdAtmdxPUB/3+Tla00jFzcHwkgGiMipmXZYE35gHXZnhaHfg3?=
 =?us-ascii?Q?T/oR820ewhqtyWQO2p+wBk5olmUCbThub1LFCedX7yzYz7CnnKZsAMTDaisS?=
 =?us-ascii?Q?JBZJOhMKu7XnIayghcvo6OWOTX3JGPUZKtFgXhJTzFqp5mW8BZ9tkAHVN0fi?=
 =?us-ascii?Q?mK7qhYxxHvYqOfj1KSv7pdj9ycRJ0PtAwiWhLMuaSRKxgXkf+3vVZIr4ebWN?=
 =?us-ascii?Q?WgDnxOl4WUuRCVBo4Mk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:04:13.0553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d75011-a731-4bab-2ec0-08de3ce6aa54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9777
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

From: David Yat Sin <David.YatSin@amd.com>

Add support for separate ring-buffer for metadata packets when using
compute queues. Userspace application allocate the metadata ring-buffer
and the queue ring-buffer with a single allocation. The metadata
ring-buffer starts after the queue ring-buffer.

Signed-off-by: David Yat Sin <David.YatSin@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  8 +++++++
 .../drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    | 21 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |  7 +++++--
 include/uapi/linux/kfd_ioctl.h                |  5 +++--
 5 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 041237861107f..88621cb7d4098 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -221,6 +221,11 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
 		pr_debug("Size lower. clamped to KFD_MIN_QUEUE_RING_SIZE");
 	}
 
+	if ((args->metadata_ring_size != 0) && !is_power_of_2(args->metadata_ring_size)) {
+		pr_err("Metadata ring size must be a power of 2 or 0\n");
+		return -EINVAL;
+	}
+
 	if (!access_ok((const void __user *) args->read_pointer_address,
 			sizeof(uint32_t))) {
 		pr_err("Can't access read pointer\n");
@@ -255,6 +260,9 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
 	q_properties->priority = args->queue_priority;
 	q_properties->queue_address = args->ring_base_address;
 	q_properties->queue_size = args->ring_size;
+	if (args->queue_type == KFD_IOC_QUEUE_TYPE_COMPUTE_AQL)
+		q_properties->metadata_queue_size = args->metadata_ring_size;
+
 	q_properties->read_ptr = (void __user *)args->read_pointer_address;
 	q_properties->write_ptr = (void __user *)args->write_pointer_address;
 	q_properties->eop_ring_buffer_address = args->eop_buffer_address;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index f1c2c9e8cf6bb..a06b4e89af8a2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -266,6 +266,27 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	m->cp_hqd_pq_base_lo = lower_32_bits((uint64_t)q->queue_address >> 8);
 	m->cp_hqd_pq_base_hi = upper_32_bits((uint64_t)q->queue_address >> 8);
 
+	if (q->metadata_queue_size) {
+		/* On GC 12.1 is 64 DWs which is 4 times size of AQL packet */
+		if (q->metadata_queue_size == q->queue_size * 4) {
+			/*
+			 * User application allocates main queue ring and metadata queue ring
+			 * with a single allocation. metadata queue ring starts after main
+			 * queue ring.
+			 */
+			m->cp_hqd_kd_base =
+				lower_32_bits((q->queue_address + q->queue_size) >> 8);
+			m->cp_hqd_kd_base_hi =
+				upper_32_bits((q->queue_address + q->queue_size) >> 8);
+
+			m->cp_hqd_kd_cntl |= CP_HQD_KD_CNTL__KD_FETCHER_ENABLE_MASK;
+			/* KD_SIZE = 2 for metadata packet = 64 DWs */
+			m->cp_hqd_kd_cntl |= 2 << CP_HQD_KD_CNTL__KD_SIZE__SHIFT;
+		} else {
+			pr_warn("Invalid metadata ring size, metadata queue will be ignored\n");
+		}
+	}
+
 	m->cp_hqd_pq_rptr_report_addr_lo = lower_32_bits((uint64_t)q->read_ptr);
 	m->cp_hqd_pq_rptr_report_addr_hi = upper_32_bits((uint64_t)q->read_ptr);
 	m->cp_hqd_pq_wptr_poll_addr_lo = lower_32_bits((uint64_t)q->write_ptr);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index ebc637c38c04a..d798baa7e52e4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -506,7 +506,8 @@ struct queue_properties {
 	enum kfd_queue_format format;
 	unsigned int queue_id;
 	uint64_t queue_address;
-	uint64_t  queue_size;
+	uint64_t queue_size;
+	uint64_t metadata_queue_size;
 	uint32_t priority;
 	uint32_t queue_percent;
 	void __user *read_ptr;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 56c97189e7f12..1b465fdb2c645 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -247,9 +247,12 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 	    properties->format == KFD_QUEUE_FORMAT_AQL &&
 	    topo_dev->node_props.gfx_target_version >= 70000 &&
 	    topo_dev->node_props.gfx_target_version < 90000)
-		expected_queue_size = properties->queue_size / 2;
+		/* metadata_queue_size not supported on GFX7/GFX8 */
+		expected_queue_size =
+			properties->queue_size / 2;
 	else
-		expected_queue_size = properties->queue_size;
+		expected_queue_size =
+			properties->queue_size + properties->metadata_queue_size;
 
 	vm = drm_priv_to_vm(pdd->drm_priv);
 	err = amdgpu_bo_reserve(vm->root.bo, false);
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 6e91875c10baa..047bcb1cc0789 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -47,9 +47,10 @@
  * - 1.19 - Add a new ioctl to craete secondary kfd processes
  * - 1.20 - Trap handler support for expert scheduling mode available
  * - 1.21 - Debugger support to subscribe to LDS out-of-address exceptions
+ * - 1.22 - Add queue creation with metadata ring base address
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 21
+#define KFD_IOCTL_MINOR_VERSION 22
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
@@ -87,7 +88,7 @@ struct kfd_ioctl_create_queue_args {
 	__u32 ctx_save_restore_size;	/* to KFD */
 	__u32 ctl_stack_size;		/* to KFD */
 	__u32 sdma_engine_id;		/* to KFD */
-	__u32 pad;
+	__u32 metadata_ring_size;	/* to KFD */
 };
 
 struct kfd_ioctl_destroy_queue_args {
-- 
2.52.0

