Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB59FF885E
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 08:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D8AD10E292;
	Mon, 27 Apr 2026 08:36:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3qhxvjKW";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE98410E292
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 08:36:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wA7pv8zv/Z0yKY6cN9c4tw2kwnd/WW9r7KKTEVmhUpyWHvO4UwmDG2/YUjBGSlKJHjLRqVr6ReUHeSQOkcZMP14V9vJuWKjEuhgfj3ps+Oaou2wRGNj6A3mK/+xgKGjP4JBMuKvlSwzczwsr67s+Bn0Et5ar8XCxoFngPIxVFoJy3qVuOYfHDglPuN2K8ByEnAZ0jzWZc5MpLGsclGfIYK98nM90im3zrzIuf+agLf4WMmE2Y8e0B+O0emGa9JFxoe9jXGjJAno/my5LPhwR5LPPZJQUrR0SE10qWsaBUhq3iqfke2sGx+M1xToGEh2z6MZfGBpovfmzwTedkYE1Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksYT+MHcg70M3U6aQfU0tlWbA5RL0pCMUciaQymWCF8=;
 b=dPmDz1rgsqDJSrEbDS3EgnguPjIyS5FODIf99/9p6NqRncbXT8cYcRwBCKSFXh3MW029y6NrHYTa0urYiYZ9w/XMz7CgjNqbiIlMw/QG9FaXFZ/NplhVZ/MQyrUfQSfkLtOXcdMgndfWLtOb9cx/d0rebwAD54bRPqucLKrd79m8LCDmGdvjQiydPtbYnNABHENzBVip5VjOrCZ67V//FC8MSA9PRYCkLw6Qj2uuJ8UmomXNfNrhOKYUwhKG6Z7a1HTppGqI2GpuZyIT4cShWx0Oh/Wm2Edntscusud92OC1p2jho7wqIka9xirbH25pZpePhkb49H2JAmgRApMRRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksYT+MHcg70M3U6aQfU0tlWbA5RL0pCMUciaQymWCF8=;
 b=3qhxvjKWUyg9V0jmS97aztSVj4E5c9hCcejm7ASZ9ScdVc4QtDuX6kBMxPrU5bwIrAzQ19SkiWITIqCEZDfrUjIsx3ldp9FmFEs5JHJJotZPffhO4IZ+PVDqVIodboJhUYNS+WMnMeFPKgLjfPiqm7fIom+M22vwqMlwBYLx5zg=
Received: from MW4P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::14)
 by IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 08:36:20 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::78) by MW4P222CA0009.outlook.office365.com
 (2603:10b6:303:114::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 08:36:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 08:36:20 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 03:36:19 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 27 Apr 2026 03:36:07 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, "David (Ming Qiang) Wu"
 <David.Wu3@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v2 06/11] drm/amdgpu: add AMDGPU_INFO_USERQ_DOORBELL ioctl
Date: Mon, 27 Apr 2026 16:34:32 +0800
Message-ID: <20260427083543.1328533-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260427083543.1328533-1-Jesse.Zhang@amd.com>
References: <20260427083543.1328533-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b20af4-0b80-4a35-fe8e-08dea4380e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QmP7vnJeWPI6li/QivAeP7qJp03l89U8e+KeT3J/R9asG/melELFWV2Lc3j48ad65I7IzWNIYZrkzfr1O8plcRht8pte73mj4vwdFn8qHkqsz2WiYgE3jSEZuJp3C/JXJ7ZBBpBTaVeAJI2oBcGeCp4eTUU/LDLBRWNaUaIngnOtNN0JYC1lsieoVh+VTcmDP/P0FoXG3pasb1ilI2W/NqShCfG3zAbEVwXUGYyIEaMitEyrGoPFmF85w+FgKlHmfv7E0xSKpAKmG+6j3MUt6IraKeFJh+o+egyUi3sq0eqzHU4ivl+ilBNlwsAYEmEqPxfz0jWL1y9H5o2G/GLhusj2/0aMvdeMr8MQgZnl5lmeSwVv8X9RCzvyzWyMN/nUkQEuc8qHBfN6yXEwLnPs2U63T0qtBOp6kjqWxe+yWxXSjTPPG4eQ/6wSbLZPJSPMoLLcx/cmm4P7a15NUJkg/WIippZbsuh8jmZgv0RV6jJjFNDbIn4golJpVYUH3OYoP62StKmw31l83uHvDZy1VHrr9FZFwYXxvMFokMsT94Ta/GQY0fTv/83d6/oSAliERh6FTWVuz4442XnDfAuhe37dJFovsiQ0/0HK6Xi8++07Crk6q2VdKXW0/wzNPz/iBUigs/xV1VJUqYHmvuMSnEsD+KE7k11tfHGpRkURHKM1Lfr/tIkadGo3++HeBI2T29gswWKj0Ka6ro5aCosjyrtUpBwYJREkj/Edipv+gDSfsOia58XYrp6wekChk3bCEdMj7Osyj9Jk+dnHiTGZXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6km4wXwSTjOVtsIPe2bbxHBbLgNGalHZ8YKwYRXASd7NdXJeMmuSILbZLOrRjyFPKMa33cQJuYZhQdScUXeXpltCHcwk+oY/6Oklc8VMIV3NLLarLCqcou8390AaaO5X1o47QNoGkMtzG2ilMT07Hr+3UvFpU5nlwNmkvNiiKs42v17ntMZX/GHEcV4p4PT62Bsyg3zxvkKuUCEL43L4u9YE/RHe8G6/L9z6YQ8/yodyRxXnzDF0AkVYFeaM89F9t0q/JpVyI+Cfi8g4sPTnLe9Y7bKR4yhKfbVbsygrJ/w6mwGPIK+r66cKzDKFVUKNaqstsH9xKuOwzTBb+FB1cnTISoXcM/735UAkmqZg4b++SPgCMaeVw9gGMNlPv+XfBztarQXU3+7onF9hNs6IzoJ8Ex1OUUH/28f7tqlp1uzrKypYhCORN4xhCw5NhqqR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 08:36:20.0744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b20af4-0b80-4a35-fe8e-08dea4380e83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7519
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

Per-IP doorbell layout query.  Input: info->query_hw_ip.type selects
the IP (AMDGPU_HW_IP_GFX / COMPUTE / DMA / VCN_ENC).  Output: the
doorbell-BAR dword range usable by usermode queues for that IP, the
aggregated doorbell offset (when MES owns one), and — for
AMDGPU_HW_IP_DMA only — a per-fpriv GEM handle plus byte size for the
kernel-owned BO that backs the routable SDMA doorbell window.

For SDMA usermode queues the kernel hands out doorbell slots from the
per-device pool (the only BAR range whose writes are routed to the
SDMA back-end) instead of accepting user-allocated doorbell BOs.
Userspace mmap()s the returned handle through the standard
AMDGPU_GEM_OP_MMAP / mmap() flow to obtain a CPU pointer to the
window; each created SDMA UMQ's qword-slot offset inside that mapping
is reported in drm_amdgpu_userq_out.sdma_doorbell_offset_bytes.

V2: Picks up David Wu's [PATCH 11/14] AMDGPU_INFO_DOORBELL design (struct
    shape + per-IP dispatch) and extends it with the SDMA-only routable-BO
    handle/size fields.

Cc: David (Ming Qiang) Wu <David.Wu3@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   | 35 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 13 ++++----
 include/uapi/drm/amdgpu_drm.h             | 40 +++++++++++++++++++++--
 3 files changed, 78 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index d88e4994c8c1..32adcb32a507 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1425,6 +1425,41 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			return -EINVAL;
 		}
 	}
+	case AMDGPU_INFO_USERQ_DOORBELL: {
+		struct drm_amdgpu_info_userq_doorbell db_info = {};
+		u32 agdb = adev->enable_mes ?
+			adev->mes.aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_NORMAL] : 0;
+		int r;
+
+		switch (info->query_hw_ip.type) {
+		case AMDGPU_HW_IP_DMA:
+			if (!adev->sdma.userq_db_obj)
+				return -ENODEV;
+			db_info.index_start =
+				adev->doorbell_index.sdma_engine[0] << 1;
+			db_info.index_end = db_info.index_start +
+				adev->doorbell_index.sdma_doorbell_range *
+				adev->sdma.num_instances - 1;
+			if (agdb) {
+				db_info.agdb_enable = 1;
+				db_info.agdb_offset = agdb;
+			}
+			r = amdgpu_sdma_userq_doorbell_create_handle(adev, filp,
+					&db_info.doorbell_bo_handle,
+					&db_info.doorbell_bo_size_bytes);
+			if (r)
+				return r;
+			break;
+		case AMDGPU_HW_IP_VCN_ENC:
+		case AMDGPU_HW_IP_GFX:
+		case AMDGPU_HW_IP_COMPUTE:
+		default:
+			return -EINVAL;
+		}
+		return copy_to_user(out, &db_info,
+				    min((size_t)size, sizeof(db_info)))
+			? -EFAULT : 0;
+	}
 	default:
 		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index cea0f9cb59d0..a0c90cc0cba5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -804,10 +804,10 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	 * doorbell index with one allocated from the per-device
 	 * sdma.userq_db_obj BO that sits inside the routable window.
 	 * Userspace fetches a GEM handle for that BO via
-	 * AMDGPU_INFO_SDMA_USERQ_DOORBELL and mmap()s it through the
-	 * standard GEM_MMAP path; sdma_doorbell_offset_bytes (returned in
-	 * args->out) tells userspace where inside that mapping its slot
-	 * lives.
+	 * AMDGPU_INFO_USERQ_DOORBELL with AMDGPU_HW_IP_DMA and mmap()s it
+	 * through the standard GEM_MMAP path; sdma_doorbell_offset_bytes
+	 * (returned in args->out) tells userspace where inside that
+	 * mapping its slot lives.
 	 */
 	if (queue->queue_type == AMDGPU_HW_IP_DMA &&
 	    adev->sdma.userq_db_obj) {
@@ -891,9 +891,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	if (queue->sdma_userq_db_slot >= 0) {
 		/*
 		 * Tell userspace where inside its mmap of the SDMA UMQ
-		 * doorbell BO (handle returned by
-		 * AMDGPU_INFO_SDMA_USERQ_DOORBELL) the assigned qword slot
-		 * lives.
+		 * doorbell BO (handle returned by AMDGPU_INFO_USERQ_DOORBELL with
+		 * AMDGPU_HW_IP_DMA) the assigned qword slot lives.
 		 */
 		args->out.sdma_doorbell_offset_bytes =
 			(u64)queue->sdma_userq_db_slot * sizeof(u64);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 79e8bbda046b..945fa3e95b3b 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -423,9 +423,10 @@ struct drm_amdgpu_userq_out {
 	__u32 _pad;
 	/**
 	 * For SDMA usermode queues whose doorbell was assigned by the
-	 * kernel from the per-device pool (see AMDGPU_INFO_SDMA_USERQ_DOORBELL),
-	 * this field carries the byte offset of the assigned slot inside
-	 * the routable doorbell window so userspace can write there.
+	 * kernel from the per-device pool (see AMDGPU_INFO_USERQ_DOORBELL with
+	 * AMDGPU_HW_IP_DMA), this field carries the byte offset of the
+	 * assigned slot inside the routable doorbell window so userspace
+	 * can write there.
 	 * 0 means the kernel did not override the user's doorbell.
 	 */
 	__u64	sdma_doorbell_offset_bytes;
@@ -1280,6 +1281,39 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 #define AMDGPU_INFO_GPUVM_FAULT			0x23
 /* query FW object size and alignment */
 #define AMDGPU_INFO_UQ_FW_AREAS			0x24
+/*
+ * Per-IP doorbell layout query.  Input: info->query_hw_ip.type selects
+ * the IP (AMDGPU_HW_IP_GFX / COMPUTE / DMA / VCN_ENC).  Output:
+ * doorbell-BAR dword range usable by usermode queues for that IP, the
+ * aggregated doorbell offset (when MES/UMSCH owns one for the IP), and
+ * — for AMDGPU_HW_IP_DMA only — a per-fpriv GEM handle for a
+ * kernel-owned BO that backs the routable SDMA doorbell window so
+ * userspace can mmap() its assigned slot.
+ */
+#define AMDGPU_INFO_USERQ_DOORBELL			0x25
+
+struct drm_amdgpu_info_userq_doorbell {
+	/* BAR dword index of the start of the per-IP doorbell range. */
+	__u32 index_start;
+	/* BAR dword index of the last doorbell in the range (inclusive). */
+	__u32 index_end;
+	/* 1 if an aggregated doorbell exists for this IP. */
+	__u32 agdb_enable;
+	/* If agdb_enable, BAR dword index of the aggregated doorbell. */
+	__u32 agdb_offset;
+	/*
+	 * AMDGPU_HW_IP_DMA only: per-fpriv GEM handle for the kernel-owned
+	 * BO backing the routable SDMA doorbell window.  Userspace mmap()s
+	 * it through the standard AMDGPU_GEM_OP_MMAP / mmap() flow to get
+	 * a CPU pointer; each created SDMA usermode queue's qword-slot
+	 * offset inside that mapping is reported in
+	 * drm_amdgpu_userq_out.sdma_doorbell_offset_bytes.  0 for IPs that
+	 * do not need a kernel-managed doorbell BO.
+	 */
+	__u32 doorbell_bo_handle;
+	/* Byte size of the BO; 0 when doorbell_bo_handle is 0. */
+	__u32 doorbell_bo_size_bytes;
+};
 
 #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
 #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
-- 
2.49.0

