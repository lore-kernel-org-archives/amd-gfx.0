Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D853BC44514
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2026 10:27:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7196A10F4E7;
	Fri, 17 Jul 2026 10:27:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yCO/ZgtH";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010021.outbound.protection.outlook.com
 [40.93.198.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EB7A10F4E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 10:27:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNftCN8fbg7gBXZb/VdZ2FSkaGUd0400BSNPVERvh2v83tFsEm3EiSlATAyjl5nlY8gH5H2Q6CK+LPqz8qGlliZbBqYA5dbZOMH9Gjg6R5PH/SUoYYghRp8XRwJoXGnkOaSd/DyzZl/+nF3oR5FSUm/KyB5HMyuuxJ1YieEzKCOnBA3DG+us7HAfYr74POKGNbl3+wF2/HsA7JeaVForgmCGadGaQFR6q500nYd0EG/uaX6Txopb6uPnksHcbVvp5reJ7QVIPFzHU70I4N90ZzGstkcdaLpe2foPTBBvpEYPfKNibBTzwKQvU19qfAu+chriGTFglKPDhBXbW3yZGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOhkMSIvW+TzauEAdnp87GcDaGpdR7B4OGiqD7GQa9E=;
 b=lBEoaDNKVtVAB5MTKSTQNHLeOP7pXGcZD7j+YcnMdmVhSgCEwHFY9uUWyyx5VmZGrQC58R0cNF6JMMJWAsGWxAABwpuEf5nTK4yDOm8BlZ/bXapQ42JDaYogGkYTCNlEOx9cfSzRIQhyOz1B192hnqThvviGVTKpWUPdITxgaOOWqln+RVB2mQmn4dBDwgvLAcs0MUa/+jPxXyz8sVzHWWcLPNuiziIqkE8H0pF7SBK/UccYuX5CZ+1IffAoP/muj4fFoeBvRX8NUOztmEVJ/uEqj+4SmO35RhIg6i6QI+PRQFxm/3x3VXnnSxCB1bO56erV4+JC+QiKd96rB/jmDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOhkMSIvW+TzauEAdnp87GcDaGpdR7B4OGiqD7GQa9E=;
 b=yCO/ZgtH8MiTIOpv2uvlmVIwfGsWoQcprO53vA+Nftq75d6wDiHiTKGN8bNabAxMk9doqLrQHU7xSIg9a/3DqJwtXLRuS8i4KT/Z+oq7MzhrpTyki4Reh0TQN6c4vdoV834J/hW5gRqRGPlDzx3EPmx1HFhhz8cGYPo/B17aW38=
Received: from CH0PR03CA0290.namprd03.prod.outlook.com (2603:10b6:610:e6::25)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 10:27:04 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::a4) by CH0PR03CA0290.outlook.office365.com
 (2603:10b6:610:e6::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 10:27:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 10:27:03 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 05:27:03 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 05:27:03 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 17 Jul 2026 05:27:02 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/mes: pass connected queue index to hung queue
 detection
Date: Fri, 17 Jul 2026 18:26:03 +0800
Message-ID: <20260717102658.3665597-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260717102658.3665597-1-Jesse.Zhang@amd.com>
References: <20260717102658.3665597-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: 731b3de9-1857-4063-a8fb-08dee3edf201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: zchF+AdRiwJ/2YqvqVsbGk4ta3zmiFal4wS3eT0s7dnQecCnE1ejXF0PlKUl+3W+MmNmkQGg8Ze4I6RF3hNpi+4jo9pPbNK95Bxrb4HvXW6DDQ2eXUoG9dLhhWBdgKuZCa1Q92jFL3KKl9z7O9yFZf+bA4J8xwJgYCfjJJ+UDj/m/LGvi8VI97NtokdZlcBKShQIcNVYjko5nNHM5kpWArO+umUNNwQZM7SF+QNEX6J4N7BD73Zx8vxOwTb6hUZxG1Tg2akZ/UPOUsCvKL2p9SZIg/xvypJLv/W0un0lpX1XHfIt8ufwTXCDbdcLec6GitWSXKLzC1tn2uO2Hbt6WpAcvM1SeGqgBvAsRo8vfh/B9KRsSKK+AavjGe72icplZkcnmx6UxgBDNaV0U8BSnrggCGSzDPJwL55ilb12hS0kxzKfOU1XrJugcv7VmPMFVkbqicw02YseHiXnZvY8tGDb8f6x9TMsv//9+prXQ3ZiVAO/LBwt+VB2Q+64fr3eOxgTTZlKMrf89+fRk1n6Etd4VNVw746qr/vzjFi7DZQnuBy60Zco4iuPrpHbFPQuJXCjNTM2nfWtpZFw6ccYvC+gSEkEhbvfUo7ROLtWG7+xSiNLnqgtN62fm/EN+I4r7PLne+g3E+DgWj7G6bGlMtTNbVBgaclWV34EchjYYOaFAxe3T5X25b5zbiLNnwlOZM0OMr/ram5bT6rNtSfRUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qUzYhdf/KntJ/v+qUGhUiU3idAwu3CM+4GMwoQma+CwiPILngq1WdcvHyEH5wSvt3DQ8SvcwSjPJYZzCM2PzbC/iDTpKOAu01BsD6o96Cff3VWcNHE0RM9ALmkywrkBIl+XZLgWuKQJjS9NOVeg6bx40UMR0nqfW3kP/BHHH4CDtdGYlb063WTVmdPiBoWwegMr1csLpRVU3McEXxpQicbK1k22eBPoPSoPncGrmhc5GiQSuk9dvCr05MJKMkWobLr4n1stlwehgJ4KZKgL74bvgPvasgLNB+7fI+3G4VYO0lwtmCcsXE7vYAPBV+u4YekM3qvKb5uSGmv2JZzX4/PF7kBJFRTUmSIagI5qoNoUnUIFj4k4sD9G/GIGOsPGfOBgC8x653ycUhcqILcrtCbtEoX1HJBPiZtKl+SnZOGeWp0AuluQ8Gf/5+7UJp8lO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 10:27:03.9832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 731b3de9-1857-4063-a8fb-08dee3edf201
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732
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

The MES query_status hang detection needs a live CP and so cannot find a
CP-frozen gfx user queue. The MES firmware has a CP_CNTX_STAT fallback
(find_hung_queue_by_cp_ctx_stat) that locates a hung gfx queue from its
pipe/hqd slot without query_status, but the driver never fed it the slot.

Extend mes_detect_and_reset_queue_input and
amdgpu_mes_detect_and_reset_hung_queues() with a connected pipe/queue
hint (pipe 0 -> connected_queue_index, pipe 1 -> _p1); callers that do
not know the slot pass -1 to keep the existing behaviour.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 19 +++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  9 ++++++++-
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 9d3b40c385c9..f5ae16f7b4ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2299,7 +2299,8 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 		 */
 		goto fence_reset;
 	r = amdgpu_mes_detect_and_reset_hung_queues(adev, AMDGPU_RING_TYPE_COMPUTE,
-						    true, &num_hung, adev->gfx.mec.mes_hung_db_array, 0);
+						    true, &num_hung, adev->gfx.mec.mes_hung_db_array, 0,
+						    -1, 0);
 	if (r)
 		goto out;
 	if (hung_queue_count)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 1e3a23c81552..40e966a0d676 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -513,9 +513,11 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 					    bool detect_only,
 					    unsigned int *hung_db_num,
 					    u32 *hung_db_array,
-					    uint32_t xcc_id)
+					    uint32_t xcc_id,
+					    int connected_pipe,
+					    int connected_queue_index)
 {
-	struct mes_detect_and_reset_queue_input input;
+	struct mes_detect_and_reset_queue_input input = {0};
 	u32 *db_array = adev->mes.hung_queue_db_array_cpu_addr[xcc_id];
 	int hqd_info_offset = adev->mes.hung_queue_hqd_info_offset, r, i;
 
@@ -534,6 +536,19 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 	input.detect_only = detect_only;
 	input.xcc_id = xcc_id;
 
+	/*
+	 * For a CP-frozen gfx queue the MES query_status hang detection can't
+	 * see it; hand the MES the exact pipe/queue slot so its CP_CNTX_STAT
+	 * fallback can find and reset it.
+	 */
+	if (connected_pipe == 0) {
+		input.use_connected_queue_index = true;
+		input.connected_queue_index = connected_queue_index;
+	} else if (connected_pipe == 1) {
+		input.use_connected_queue_index_p1 = true;
+		input.connected_queue_index_p1 = connected_queue_index;
+	}
+
 	r = adev->mes.funcs->detect_and_reset_hung_queues(&adev->mes,
 							  &input);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index c67db2d6e122..a5d0e649d113 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -350,6 +350,11 @@ struct mes_detect_and_reset_queue_input {
 	u32	queue_type;
 	bool		detect_only;
 	u32	xcc_id;
+	/* gfx-only: locate a CP-frozen queue the MES query_status path can't see */
+	bool		use_connected_queue_index;
+	bool		use_connected_queue_index_p1;
+	u32	connected_queue_index;
+	u32	connected_queue_index_p1;
 };
 
 struct mes_inv_tlbs_pasid_input {
@@ -544,7 +549,9 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 					    bool detect_only,
 					    unsigned int *hung_db_num,
 					    u32 *hung_db_array,
-					    uint32_t xcc_id);
+					    uint32_t xcc_id,
+					    int connected_pipe,
+					    int connected_queue_index);
 
 uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg,
 			 uint32_t xcc_id);
-- 
2.49.0

