Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C302C5B549
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 09:04:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCEBE10E831;
	Fri, 30 May 2025 09:04:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M06rR+WK";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5B8110E831
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 09:04:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAfNnsVhvqo7aifCqo6v2GyRwIofFnG8Tp0HKUJ1fO4ErX6vepQ4nm2mvb+/YPmTvXI4tryI8L0jd52EPsFeYGevnLWRKADuUv2mQZwTyNNE4yP4E6BUkpc5e6+d124ZdVzoWeAFlshkxcUse6ArC8KNTSICzhOzxqvtYjsA3lpk5UHs6GH6huvsCSxbGGGz+wigcLzmoUlVmcvfd2dH3DuLZQVGzcHH5Aj90Ygxun5z/Bp+a9agMFA/ObaXIyXEQuT8H33vQhks3sZ8H+WC8PEfehBSo7L6hgEB3UnMJdr2vRGaDKv+K9fXJ5mxqUzmqH5xCw/NYCYMluLzCTpB8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbcGgSqLuckMYr1FkaIjh93K95Vu3fwdNeo2yy7PTcY=;
 b=RAnSkIn9bQLtTGhE/HN+gpCw3e6RHUtSgZt5YxtNTO9+Y5FiwFvmy0ctkjGWcoBrmXMY2sHS91bjJ2Sv4s/6tZyNQy2+Sg3FQoE3YWz9h73BQM+EP86E5i5TKgfsYstfDQCMP0fGGC4RU6UM05QzJjsZXGfAQpG+FtbdsG5Ed2XIydfAWFd9ns4XoobV6e3IgCx942qVU+XaBGNfvDRtp8HFkfhqtR81NapU7rzHowKMFzRG/0GQxtGKsyzPkiu0rqJ9iSxXL9/bsSDvVTfj9+esAlsEIl7p+YGZiA9xaQrfsOFKXOZ5pQRj6LQCvRade6iCTTnEf3XXF5jRhHXJhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbcGgSqLuckMYr1FkaIjh93K95Vu3fwdNeo2yy7PTcY=;
 b=M06rR+WKkhvZh3UVYVbvj3AZLx6Mk31B/tHc+mKA30gbMiPqacWpQiqXzfVb5Jz0RrWIT/4chU/dXvesLtUDeZZAacRYpWq6qb5ngENoyfkCpiIQ/lE01SSPEW0fmTe6a/gWS9Prkrr3OQxlJ4pOrkqDOktpLFIryYQEfQCu+lg=
Received: from BLAPR03CA0149.namprd03.prod.outlook.com (2603:10b6:208:32e::34)
 by PH8PR12MB7232.namprd12.prod.outlook.com (2603:10b6:510:224::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 30 May
 2025 09:04:31 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::f9) by BLAPR03CA0149.outlook.office365.com
 (2603:10b6:208:32e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Fri,
 30 May 2025 09:04:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 09:04:31 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 04:04:30 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 30 May 2025 04:04:29 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 13/14] drm/amd/amdgpu: Implement usermode queue hang detection
Date: Fri, 30 May 2025 17:00:14 +0800
Message-ID: <20250530090322.3589364-13-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
References: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|PH8PR12MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 98359a00-6cf8-4506-1a66-08dd9f58fd41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xlbztd76zNrmk57q69pNqCFcig4raKMBR3YRX0BfFH2UaieeKtlndNnML2Wn?=
 =?us-ascii?Q?hsck+ZMJ9oKSwaViLShZpK+ATg3ADU1iG1ENnSfx/e9x382zKqjzib9JgVD5?=
 =?us-ascii?Q?spaXI3Bd8H9/ybDc4G5OljoI4wWSIJZEPmxXKw8uRNzXainPgvnddmn6QV3Y?=
 =?us-ascii?Q?hSqHLie3QqBRMXeFUzFMqLKgsPGUV0tEtGLAYtTmBu4u/oDraiXZH8toQzDb?=
 =?us-ascii?Q?MLKHdq7xymnMYY9DPuMnxMtONKU1GBl4mAZeqgoGcChEvP05Ux4B07fWj2lx?=
 =?us-ascii?Q?8AoPWX0+OubhO+z0lt55s3Op2UD+o+qsll8E+QfDRSdRF2rXQxC5HJVze8bJ?=
 =?us-ascii?Q?ReKymU5TuN9CtRy1qQpeFHisaSkvefecqG4BVUspwPCxribZ6Z1uit5FdQ+k?=
 =?us-ascii?Q?5HIuuy1ApkbVx3cZA+mH6AewrDUbbzvg2trW3Zxwai432Vr2c+u2XGmPKhly?=
 =?us-ascii?Q?rdiZa2mghRqFug34YWLuN6uL3xnjIEwuW31p/b8ZqxjQmY3LHKum5xF+Ce3Y?=
 =?us-ascii?Q?8Lz4lpsYOx+7bFjj0UI+Fdqh2EBRzsU1Eh0kI7nWqVaQ5RLVW/G3E+JyG/kn?=
 =?us-ascii?Q?526o8huved/R7naewLX+5EZH6SFfc83jDi9XCk69ZwDpI+ksao7HPo5Aag3k?=
 =?us-ascii?Q?riub5LhMEWnZwlWUAxkk/88uhA+0eoSn3iLrU418V3hEWoRsKXYvXc+27Py5?=
 =?us-ascii?Q?MpwLvM6CklmVL9XBRibyr5szKjIyiiRK8aNUEfYlrhRQamEPaLcyKxUdvIih?=
 =?us-ascii?Q?+Eoskh27pzeBau9qXeocV1pd/l7uiPAL6vyfTXHiIPM4ESVDdG2QTtaQ0WXw?=
 =?us-ascii?Q?VhyukvLjgVI5QnktT7/JptBEEDH9ai40nc//8gCa+24Gfo0fivIT59IPPR7V?=
 =?us-ascii?Q?Zst32Hu7LyRj71Nz32dvpYBMXi215ixrs9bKs44BDtYX2fyXBuol8jQXz632?=
 =?us-ascii?Q?YX82G/nSCovWZ0a0YBH6PwlHKYXe6n8jOAIeScp4r1CIZF3mn40Lp7e2pZKD?=
 =?us-ascii?Q?klA0YlCkcAHWNrXeYB7SnOvG+xKDnPeWw8/Jc91uKiiYFEYswAxEXA51kUOO?=
 =?us-ascii?Q?WeqFrFbVrAKYrye/uN8KcWG+X9wck33WyufY1OQmupq45c6QkMWjmOIqYLmN?=
 =?us-ascii?Q?ELii5BiB3u9DVa5aiOqJaC51tgNRRca0nvn0I4gpj5VPmWuC1YtTFkijimJi?=
 =?us-ascii?Q?6jv4oLbK2iq5co3krXYSauf9ptI5DD/Y7eQkJMjFX64nN7R8lVRj0AKq02Nw?=
 =?us-ascii?Q?eOzvFx+nESbfeqQlzplAsASD7lZHK/sxgH5CU1I4StIcLqcwb3pLz2rc7ndV?=
 =?us-ascii?Q?M+NgWgu3I2oQ3lllF7jb200Lgw0j/z8v2MNUQjmtIiwKJnPd1Nycz7R/4N26?=
 =?us-ascii?Q?+1A/OzkkBvGUk2u6Q6NUUQNyJSIaXlyDelK0Ejht8rfuzNO50z8Q1td0icrS?=
 =?us-ascii?Q?ifzpYA3oRbqemv8Ztgbkw9enJtCEesgxWpnPnlZYyov0k/psBLFwlJVaxYK5?=
 =?us-ascii?Q?dIDxjJuO3Qo6hISu6FuSnt3GQC1cGCWILj28?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 09:04:31.0896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98359a00-6cf8-4506-1a66-08dd9f58fd41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7232
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 12 ++++
 2 files changed, 91 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index b7b1c26067f5..028989e1538c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -55,6 +55,85 @@ static void amdgpu_userq_gpu_reset(struct amdgpu_device *adev)
 					     &adev->userq_reset_work);
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
+						hang_info->mec = mec;
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
 static bool
 amdgpu_userq_queue_reset_helper(struct amdgpu_userq_mgr *uq_mgr,
 				struct amdgpu_usermode_queue *queue)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index cdc3dcc62dce..0b33df8f0793 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -47,6 +47,16 @@ struct amdgpu_userq_obj {
 	struct amdgpu_bo *obj;
 };
 
+struct userq_hang_info {
+	int me;
+	int mec;
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
@@ -66,6 +76,8 @@ struct amdgpu_usermode_queue {
 	u32			xcp_id;
 	int			priority;
 	uint64_t		generation;
+	/* for per-queue reset support */
+	struct userq_hang_info hang_info;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.49.0

