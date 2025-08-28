Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520CDC8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:17:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F110910E94D;
	Thu, 28 Aug 2025 09:17:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o4x7XJJ+";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5F8510E954
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:17:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzTG/EtGdB+F0Ita2ob/leL+ynapccSAaZNLVk3D20jL/waykrVq2wvZtRPoreaFAbokYoBJOU70iAO/V3AE4IYO9XnFRO8KFsFFsJSxBinq5QyAgoiSDrXHpu17GOXX+kRfDpt96vitnVoxCp8Nh6MH4AAFxDj180OTI9kaJcElfjRhNml2+Jwb2dlvYCIFdes5g1b8dCo3tnde4pV5C9QL3KCtTD+LHanHx0Tc7LUQCB5Mz9osFhi71Q1rIXZ1xBXh8hDnO6mxw8dr/3Wgqc4YsSo+td5At+Mt2ZkZOahQgyirNTkRlNHXM8PXaLlR+C/wkl2A80TZNUhkPWzbvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tOT3Lj8+ZVsOax1f5Ac8mYogXc9wosKXCPRQFGo/u0=;
 b=B1Pn75ThFwfRS6/p1Dn2T+7nsCW69e3WshI4vbsj70zYVHkxRxGSo6cqLqtPnmy/XoSN6qFQH4FrQnLnXJcIpDSZHMjamPqG5j30Th3hOa+LVq82RGe9MA3xsOnOTvz940AFJJYSy1fcHRyydaBD+17FiY/qdbO/vVe2tRMIELL/8NSlVuKKfjtJGfZt95tCpLy77rxN1JoYmqmMxGFKsiezSTkqA/aK8LhwVQ7ApSF6Xkh23qWZDXIaGKk4eLln41pE6fRnmwavd/1Qd8ciq7aZHCxcyk1a/zg+nnfrwnDY1V48kvHl9DLdPveMN2MKmEhjRCGd7ofshnBR0UpV2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tOT3Lj8+ZVsOax1f5Ac8mYogXc9wosKXCPRQFGo/u0=;
 b=o4x7XJJ+blpORBHALjFgpu1icF699FA3d2A4p0YYVTTgijmrxC/m8CzAgwlaB7LsyJWrArM8ch1GOlOuC1ALVgWbjgthI37TgQi5wVR3+IdgCZlRjCIJwybHLs5CyKB9CnzjE3744hGVeOGVMXaB1+DsDFicz5rQZckVOJuafKE=
Received: from CH5PR04CA0016.namprd04.prod.outlook.com (2603:10b6:610:1f4::24)
 by CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 09:17:35 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::73) by CH5PR04CA0016.outlook.office365.com
 (2603:10b6:610:1f4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Thu,
 28 Aug 2025 09:17:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 28 Aug 2025 09:17:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 03:45:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 03:45:24 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 28 Aug 2025 03:45:18 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v12 04/11] drm/amdgpu/mes: add front end for detect and reset hung
 queue
Date: Thu, 28 Aug 2025 16:42:10 +0800
Message-ID: <20250828084457.1999535-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828084457.1999535-1-Jesse.Zhang@amd.com>
References: <20250828084457.1999535-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|CH3PR12MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: 33123527-6e6b-4b77-4647-08dde613b9fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aZLzfmZPrnC4iQUG9MVzrsknV4NBB0yg1hNjRUVXDXbVbLz0EeX/Y6oge3u1?=
 =?us-ascii?Q?z30LhigVre9Cre9MQ4r8oIQTgWFybYkzEziX7MgZ4U8TEJa2CK3pdHx34x+B?=
 =?us-ascii?Q?KBeA1IxmNRTIf768UVYVcJwP9l5hOLWOnCI3oh0I8Qyzj/0/4qZBDVz1qnA5?=
 =?us-ascii?Q?/a/m9Y0GEurHvuP6uQfk6C4mMwQMJ6wmW5AABe/Jp5FpZNyNISDhw4RccJEA?=
 =?us-ascii?Q?nL0sA4aauFGjMGWpsDv3MpyDsbdtMZegCm8mEucz3IuPc2XwpTT1P1CqHd46?=
 =?us-ascii?Q?bnWTxL2dFkyDEHbVRpiI3xvNIEC6IWuUj3TBj0+meVTV7fmDhQqlZ/RJzOgO?=
 =?us-ascii?Q?gKo1Cz576EyLPL4kG937bWp91Vsxg7jnEfIBApnEOgVhJg3N52uWNRVPTvt0?=
 =?us-ascii?Q?o4v24rU7fmCg7F5vfRjxXjh7SRKNpgVPKL5icGCuqcH3uuDdGkht1TH4UC7+?=
 =?us-ascii?Q?Kn3dGQyokhngYkrpzYQfWiDTSNYotpgRMG1SJXHofEVEjm/V0WBRUDWZ3rVG?=
 =?us-ascii?Q?QNaF5scNXAwLwZlU37rczV/hCXsMb6OQNVhRbdz0Clh9sbXnD8FbK7qJHE7D?=
 =?us-ascii?Q?lb22/N5ZV2Z/FMhBB8RSLbH8Q88qNVXfl/dqJUlefIrdY3Wi9Kckjg656Wxm?=
 =?us-ascii?Q?B2RcE79lmi1aK3kpXsPwqCr7Dl9R+TsFpYfcV283zJ7SuMJFcF5HHsykCWca?=
 =?us-ascii?Q?gzhqRhqURcJJAHcAJPVzI/svqglGvALrfMg7wkvJePkQmCeY5gzTp5VLmjh+?=
 =?us-ascii?Q?f1KmmT7UY06wABaLuey4zH56jtUkHGIbGPV0EqV/7iNRteQWUzx+psx8irsR?=
 =?us-ascii?Q?6SXfqrqnBvg+/A/RWSqF2Yd3AyF0OFaNXi+FyzzoAT25p5i/JHA8fYTgN53E?=
 =?us-ascii?Q?bH5bfS5S1AtDVrlt/E5eyd82xicN8hxolTfLZxxOS5oJ8uQutpp68gJkEzWj?=
 =?us-ascii?Q?2zOLGIs/MWiObdglw2rrDFKiVLGAsSRBRDAN4pgqXKYMRPCgi+jbAySL8ftM?=
 =?us-ascii?Q?5hNvLbw6DDLFuWhoPAFNNrWot1s4j35k58ZJYpvphXhEOZivaQXvOcw9LtIO?=
 =?us-ascii?Q?B+5bwl2l03WiVTVTE3uV6r4JsFS49b5iicp0Cy9woPLO9gkBvzsWjX/Lnce5?=
 =?us-ascii?Q?aUoYGNMj6GB3kyB0uydivFNMnlpVhd87fhaR4Wp4SxQHiG9Liktzc29CmAjt?=
 =?us-ascii?Q?IwBm1k1Cc0uJRJh1iEp8K036zRudJYb/6iZzq1tgxrSeETzgBO4FuZEhpqMz?=
 =?us-ascii?Q?2TeAUunGrhewOk3J0AwylGF5LnI84Y9Tn0jxHgKXb5Z4Hg4T2a9MCNIvw8sJ?=
 =?us-ascii?Q?hkm6Qz+cEY6iOiVn4GXPVCfZ/d+orJdEb+OoPYeXEdYpk76z9BvWMh4Pyn4U?=
 =?us-ascii?Q?o9ZKgHN+sFELqj9wX4bvRfiFc+zdF8yFOKM0qnQXdoiQ/IbNrM0nDwbkkIGn?=
 =?us-ascii?Q?prFO4n8BeZgd/ByPRV79ZMzlzTccCe7UwsT3OFXxvI+KPKjd91JtdrnG/pHH?=
 =?us-ascii?Q?9JHgCh3r0TucjzYvegM2f/T/4hxf15Sh32gl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:17:35.4960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33123527-6e6b-4b77-4647-08dde613b9fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9079
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

Helper function to detect and reset hung queues.  MES will
return an array of doorbell indices of which queues are hung
and were optionally reset.

v2:  Clear the doorbell array before detection

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 65 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 19 ++++++++
 2 files changed, 84 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 135598502c8d..5bf9be073cdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -191,6 +191,20 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	if (r)
 		goto error_doorbell;
 
+	if (adev->mes.hung_queue_db_array_size) {
+		r = amdgpu_bo_create_kernel(adev,
+					    adev->mes.hung_queue_db_array_size * sizeof(u32),
+					    PAGE_SIZE,
+					    AMDGPU_GEM_DOMAIN_GTT,
+					    &adev->mes.hung_queue_db_array_gpu_obj,
+					    &adev->mes.hung_queue_db_array_gpu_addr,
+					    &adev->mes.hung_queue_db_array_cpu_addr);
+		if (r) {
+			dev_warn(adev->dev, "failed to create MES hung db array buffer (%d)", r);
+			goto error_doorbell;
+		}
+	}
+
 	return 0;
 
 error_doorbell:
@@ -216,6 +230,10 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
 {
 	int i;
 
+	amdgpu_bo_free_kernel(&adev->mes.hung_queue_db_array_gpu_obj,
+			      &adev->mes.hung_queue_db_array_gpu_addr,
+			      &adev->mes.hung_queue_db_array_cpu_addr);
+
 	amdgpu_bo_free_kernel(&adev->mes.event_log_gpu_obj,
 			      &adev->mes.event_log_gpu_addr,
 			      &adev->mes.event_log_cpu_addr);
@@ -366,6 +384,53 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 	return r;
 }
 
+int amdgpu_mes_get_hung_queue_db_array_size(struct amdgpu_device *adev)
+{
+	return adev->mes.hung_queue_db_array_size;
+}
+
+int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
+					    int queue_type,
+					    bool detect_only,
+					    unsigned int *hung_db_num,
+					    u32 *hung_db_array)
+
+{
+	struct mes_detect_and_reset_queue_input input;
+	u32 *db_array = adev->mes.hung_queue_db_array_cpu_addr;
+	int r, i;
+
+	if (!hung_db_num || !hung_db_array)
+		return -EINVAL;
+
+	if ((queue_type != AMDGPU_RING_TYPE_GFX) &&
+	    (queue_type != AMDGPU_RING_TYPE_COMPUTE) &&
+	    (queue_type != AMDGPU_RING_TYPE_SDMA))
+		return -EINVAL;
+
+	/* Clear the doorbell array before detection */
+	memset(adev->mes.hung_queue_db_array_cpu_addr, 0,
+		adev->mes.hung_queue_db_array_size * sizeof(u32));
+	input.queue_type = queue_type;
+	input.detect_only = detect_only;
+
+	r = adev->mes.funcs->detect_and_reset_hung_queues(&adev->mes,
+							  &input);
+	if (r) {
+		dev_err(adev->dev, "failed to detect and reset\n");
+	} else {
+		*hung_db_num = 0;
+		for (i = 0; i < adev->mes.hung_queue_db_array_size; i++) {
+			if (db_array[i] != AMDGPU_MES_INVALID_DB_OFFSET) {
+				hung_db_array[i] = db_array[i];
+				*hung_db_num += 1;
+			}
+		}
+	}
+
+	return r;
+}
+
 uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
 {
 	struct mes_misc_op_input op_input;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index c0d2c195fe2e..2c4568951edb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -41,6 +41,7 @@
 #define AMDGPU_MES_API_VERSION_MASK	0x00fff000
 #define AMDGPU_MES_FEAT_VERSION_MASK	0xff000000
 #define AMDGPU_MES_MSCRATCH_SIZE	0x40000
+#define AMDGPU_MES_INVALID_DB_OFFSET	0xffffffff
 
 enum amdgpu_mes_priority_level {
 	AMDGPU_MES_PRIORITY_LEVEL_LOW       = 0,
@@ -147,6 +148,10 @@ struct amdgpu_mes {
 	uint64_t            resource_1_gpu_addr[AMDGPU_MAX_MES_PIPES];
 	void                *resource_1_addr[AMDGPU_MAX_MES_PIPES];
 
+	int				hung_queue_db_array_size;
+	struct amdgpu_bo		*hung_queue_db_array_gpu_obj;
+	uint64_t			hung_queue_db_array_gpu_addr;
+	void				*hung_queue_db_array_cpu_addr;
 };
 
 struct amdgpu_mes_gang {
@@ -280,6 +285,11 @@ struct mes_reset_queue_input {
 	bool                               is_kq;
 };
 
+struct mes_detect_and_reset_queue_input {
+	uint32_t                           queue_type;
+	bool                               detect_only;
+};
+
 enum mes_misc_opcode {
 	MES_MISC_OP_WRITE_REG,
 	MES_MISC_OP_READ_REG,
@@ -367,6 +377,8 @@ struct amdgpu_mes_funcs {
 
 	int (*reset_hw_queue)(struct amdgpu_mes *mes,
 			      struct mes_reset_queue_input *input);
+	int (*detect_and_reset_hung_queues)(struct amdgpu_mes *mes,
+					    struct mes_detect_and_reset_queue_input *input);
 };
 
 #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
@@ -390,6 +402,13 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 				  unsigned int vmid,
 				  bool use_mmio);
 
+int amdgpu_mes_get_hung_queue_db_array_size(struct amdgpu_device *adev);
+int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
+					    int queue_type,
+					    bool detect_only,
+					    unsigned int *hung_db_num,
+					    u32 *hung_db_array);
+
 uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg);
 int amdgpu_mes_wreg(struct amdgpu_device *adev,
 		    uint32_t reg, uint32_t val);
-- 
2.49.0

