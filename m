Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4A6C83F1B
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 11:00:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7DB610E794;
	Wed, 16 Jul 2025 11:00:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xp6D3WuS";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5734410E794
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 11:00:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJotDnkKyZ/7xQN4hMcdv9jcZRVTE2omni4myacYpbqjljVk6Bdbd2Pi1JVKtBqr5xECrQzEWgDe9+XThKWbu9m2NPSpZnuPymxlOM6TKHTtwXc4t9mJxMItHvn6r9FVJj/MctXkYfrBXttD/wyw3PzIVbY5LWqhasdifoPKZUjA8rJ+DWgxuIi9Wbf/YZYZhl8NVhHZZWtIPfCjP/vVEkRabykzdZNRpexkebHKjjbH2aKXfqMfDDo6GCK8RhvHgyJAKl9oKSL2l+ZF+Ry+a5kY7RkEE3cQZhaWPonBG9m2W5XQ7t5IHa+vUOtho9oIrK1Ufalso+LAgWZnoX48Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOeHtd/46IAkN3apg8j8wOeb6XHjtmVsxzgSUtorbW0=;
 b=XS4NYWb6dbTmdpcQ8FTs93wOrpJ4VcWOcXQUDbfGpMeXKr/qu7mzNNAPHIKYGDFu30wLRa/s7jPFMa2NkRzvrJcUA+kDo5mD6o1rESlDgyHRv2CF9BX9qhgw+MKcLvh8aJBOdcDOgiP1v6XEyjlyp2enns8W1INhmIJJhFgyUbN2zzt/izKwgqz5oblQI27SF0LijF9SGemJiME40BNStRUdKqqqcYi1nqTcKOWIPpYf1ZCaomuMH3xzp4aRCb5qxx48HrcmVYZRwPGFgQ6EKRMeelxeZHbBndTMUW9NJ2w4sK8UZZgn+MK7LGTwLBOC/B3MxdfQChNxa2CM82uNmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOeHtd/46IAkN3apg8j8wOeb6XHjtmVsxzgSUtorbW0=;
 b=Xp6D3WuSW+ilSg9y/9AZu0QDXJcqBH5RWzyk1yaaEGxmyQFPU/SKMcL9WwwK8m4oSUcrQkVI+NMrF8RtGiOpn8YqCrtDdKca+XbqALMWWKrLqgDhxWC1xEkGJgFYy3xwnE8YFbVgMqvoZpCVZ+7+G3cWObkkC4DtJEG3RRJFbYk=
Received: from BY5PR17CA0026.namprd17.prod.outlook.com (2603:10b6:a03:1b8::39)
 by DM6PR12MB4282.namprd12.prod.outlook.com (2603:10b6:5:223::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 11:00:23 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::b8) by BY5PR17CA0026.outlook.office365.com
 (2603:10b6:a03:1b8::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Wed,
 16 Jul 2025 11:00:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 11:00:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 06:00:21 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 06:00:20 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [v4 03/11] drm/amd/amdgpu: Implement usermode queue hang detection
Date: Wed, 16 Jul 2025 18:59:23 +0800
Message-ID: <20250716110011.1670654-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250716110011.1670654-1-Jesse.Zhang@amd.com>
References: <20250716110011.1670654-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|DM6PR12MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: d6d3b794-91ba-4d5e-879b-08ddc457f5ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bbQynQyq7aBMYOU4nRzhNGEPt2Z8bZUhxq7mbTjwn9+eqoNU4ha1TV2eklJ0?=
 =?us-ascii?Q?ic7Fcy9ImRqRufU5EK/M688jvsqERhrSPSrOzDSGXjMhZ0l7bnVJfT3UGbUk?=
 =?us-ascii?Q?00qsG7dD1wvK+aIhqb+k1NIe6UL0gwLlnXKhlWGY9nrUHlhkf+IKUls09wvY?=
 =?us-ascii?Q?Lcvy9Z7+R2FVdz4UV0bKF/uQhNv8GkI6n8NhtdW1S2N952aymtA8yd18kKvO?=
 =?us-ascii?Q?qvZES5+VNssXzEeKoGICIlgqYjEqX+/M6cTiX6n0/wpxpAZTxhzACvEX9ApR?=
 =?us-ascii?Q?A6rFLz01JG6zVr/KMWLPXgZfND8tx7NCFVF3wfRxZUtrzzhJGdQ4MOXbZSSv?=
 =?us-ascii?Q?xvR3wTFoHrdgxKjIPKaN8qmncXy1YSO1RsVL0jN0QL4ya1joUpu2BB97ttTm?=
 =?us-ascii?Q?azah6hq13G0VoiO7Ck0tIzQPs61aNSmWTu9oOBbAHLXMI4/aXGhiaILWq9bk?=
 =?us-ascii?Q?FhGiC78AL3XoJTmvYKN3peoFjjd/ZrrK7Stmtw5yihlU9ooSa6okjwgxj3Oy?=
 =?us-ascii?Q?ytaWjQ5gkK5L2IO1gJGuzzE321rDy5pxMY1fh+ho1JB49konwpL97JDR0V/p?=
 =?us-ascii?Q?JbbIyzQBq9zOl88lZXketTW2QYJ50XUOABCFW2/ME9D3Y57n+4Ke0ZZ5B3kG?=
 =?us-ascii?Q?dJ6WWUPP6Mn970+ageuAkEwSrh7nSrm6nVt91plFuCOYwDQw1XQsYgnGcqog?=
 =?us-ascii?Q?yV56YquJ0OvE/fclmi2q9AOorwIplG6agNdmvdQWzLs9Hwb6JwTCyT8mmTk3?=
 =?us-ascii?Q?ArHANypSnse3cegurim/YrGbujIu+6iVMGqDsdyoA5rKzS3Xh9qAEpHRiY2a?=
 =?us-ascii?Q?pjPacBZILb+FpNI+wELMkXk8D6WwnFh8uSDQ97x4jBFm1Bnj78TfTdU6Er+2?=
 =?us-ascii?Q?x3dIo8ang7pVm8WroLHqDKyRhHwZ9vHT4pvLOsktdxwMAccqSlLOyocTRQwh?=
 =?us-ascii?Q?59dfn4ObG201V/vKLv2gDRW5Ymi77UNDDK5P7yip4cHpAI5t6MTnzrbFvjzP?=
 =?us-ascii?Q?I30MYNBTE0AlWvHrJrKwDny6tJJR1w0k+F08rwPWO72jhxbByncXPk095hn1?=
 =?us-ascii?Q?RTK33cko9kur3uf5n0/hH9VVEeyQIF+DcR6pk5u9YSVaHR6WV7LqDq51N+ew?=
 =?us-ascii?Q?MDBr4Icr+9+UV2sSF82KehFNvOtbc1NvUkjbXqkvYHvUfZSkSc+M62jEaE2V?=
 =?us-ascii?Q?rPcpO57TlTy9AIiMF+yMYwsU6ELbgwRMFRcCFKSMIwLk+/fz+M7ke99aXBJI?=
 =?us-ascii?Q?bZigBecA29SRnwW0xkOywN2bud1ay1SfVgXJo4rXTPCumHdsSthnwEKe7xrf?=
 =?us-ascii?Q?T3HM/tMEXlzInHDpVZj+w7KvMHmhgC7oLVKT9t/23ChcwuXSuJZt0odZIiJN?=
 =?us-ascii?Q?UpVuplGVpBVecEWx43gwZK6FgQwpdirbK/PK5hRcoNDVFmdhf6cBp2ALbU2/?=
 =?us-ascii?Q?xvAKTy7IJjH9pojhMWtWSzAZr6nj0r/y8abmcty9sboCCFfo8V21/rNGAyrY?=
 =?us-ascii?Q?wj9PErblXb+qcddxA5sObQ+tSXk+HQl3lrCi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 11:00:22.3081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d3b794-91ba-4d5e-879b-08ddc457f5ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4282
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

This commit introduces hang detection infrastructure for usermode queues by:

1. Adding userq_hang_info structure to track:
   - Queue identification (ME/MEC, pipe, queue)
   - VMID and XCC ID
   - Queue GPU address

2. Implementing amdgpu_userqueue_detect_hang() which:
   - Scans active hardware queues to find matching HQD addresses
   - Supports both GFX and Compute queue types
   - Properly handles queue identification hierarchy
   - Stores found queue information in hang_info structure

3. Integrating hang detection with existing queue structures:
   - Added hang_info to amdgpu_usermode_queue
   - Maintained compatibility with existing reset mechanisms

The implementation:
- Matches hardware queue organization (ME->pipe->queue)
- Uses existing MQD functions for HQD address lookup
- Provides all necessary information for targeted resets

 Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 79 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 11 ++++
 2 files changed, 90 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index aac0de86f3e8..82fef5e3ddea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -44,6 +44,85 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 	return userq_ip_mask;
 }
 
+/**
+ * Detect if a given usermode queue is hung by comparing its GPU address
+ * to existing HQD addresses in the hardware.
+ *
+ * @uqm   - User queue manager containing context and tracking structures
+ * @queue - The usermode queue to check for hang
+ *
+ * @return - bool, hang detection info is stored in hang_info if match found.
+ */
+static bool amdgpu_userqueue_detect_hang(struct amdgpu_userq_mgr *uqm, struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uqm->adev;
+	struct userq_hang_info *hang_info = &queue->hang_info;
+	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
+
+	int queue_type = queue->queue_type;
+	uint64_t hdq_pq_base = queue->userq_prop->hqd_base_gpu_addr;
+
+	uint64_t hqd_addr = 0;
+	uint32_t mec, me, pipe, q, vmid;
+
+	switch (queue_type) {
+	case AMDGPU_HW_IP_GFX:
+		for (me = 0; me < adev->gfx.me.num_me; me++) {
+			for (q = 0; q < adev->gfx.me.num_queue_per_pipe; q++) {
+				for (pipe = 0; pipe < adev->gfx.me.num_pipe_per_me; pipe++) {
+
+					hqd_addr = mqd_hw_default->hqd_get_pq_addr(adev, queue_type,
+						me, pipe, q, 0, &vmid);
+					if (!hqd_addr)
+						continue;
+					/* Check if this HQD matches the target queue */
+					if (hqd_addr == hdq_pq_base) {
+						hang_info->me = me;
+						hang_info->pipe = pipe;
+						hang_info->queue = q;
+						hang_info->queue_address = hqd_addr;
+						hang_info->vmid = vmid;
+						return true;
+					}
+				}
+			}
+		}
+	break;
+	case AMDGPU_HW_IP_COMPUTE:
+		for (mec = 0; mec < adev->gfx.mec.num_mec; ++mec) {
+			/* mec0 is me1 */
+			mec +=1;
+			for (q = 0; q < adev->gfx.mec.num_queue_per_pipe; q++) {
+				for (pipe = 0; pipe < adev->gfx.mec.num_pipe_per_mec; pipe++) {
+					hqd_addr = mqd_hw_default->hqd_get_pq_addr(adev, queue_type,
+									mec, pipe, q, 0, &vmid);
+					if (!hqd_addr)
+					    continue;
+
+					/* Check for address match to determine hang */
+					if (hqd_addr == hdq_pq_base) {
+						hang_info->me = mec;
+						hang_info->pipe = pipe;
+						hang_info->queue = q;
+						hang_info->queue_address = hqd_addr;
+						hang_info->vmid = vmid;
+						return true;
+					}
+				}
+			}
+		}
+	break;
+	case AMDGPU_HW_IP_DMA:
+	case AMDGPU_HW_IP_VCN_ENC:
+	case AMDGPU_HW_IP_VPE:
+	default:
+	/* These queue types are not yet supported in hang detection */
+	break;
+	}
+
+	return false;
+}
+
 static int
 amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index ec040c2fd6c9..0d44d7a3b7bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -47,6 +47,15 @@ struct amdgpu_userq_obj {
 	struct amdgpu_bo *obj;
 };
 
+struct userq_hang_info {
+	int me;
+	int pipe;
+	int queue;
+	int xcc_id;
+	int vmid;
+	uint64_t queue_address;
+};
+
 struct amdgpu_usermode_queue {
 	int			queue_type;
 	enum amdgpu_userq_state state;
@@ -65,6 +74,8 @@ struct amdgpu_usermode_queue {
 	struct dma_fence	*last_fence;
 	u32			xcp_id;
 	int			priority;
+	/* for per-queue reset support */
+	struct userq_hang_info hang_info;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.49.0

