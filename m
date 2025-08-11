Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B9CC87FD2
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 10:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEF3910E40A;
	Mon, 11 Aug 2025 10:00:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AoIXdcQ0";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27E3D10E40A
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 10:00:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnL/LbhaRC9oMMf/wNwMPqfuAtElyCJ6mHiTeexQ50C4wqCVJvS/d1maxVaT9i0fWpxL4ioMXY8DsHSLYP+21jqGaXzOLdhlo+7/u3GR8/T/TifMcKOs/JYrhwpwUf5ZeKrr9IBC9VzlCsMnccuniDB3kgL5Z4oeSuWVKe2q1Ecka58gmpSzX6D+T+7B/QUBE7yAfjRd7eNCp2VVx9M74mrDnQjMSOZqcuvIviyVEr9ZhjY9aR4wBptNevC+6fZfszYgtO6iDY9XDrbVFwTKb9TtFpkMJIYUrNG+w1+DLcMptXHY1LKttQilwiwgHT75hVWX1yMWLCOFHn2OAw11Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tOT3Lj8+ZVsOax1f5Ac8mYogXc9wosKXCPRQFGo/u0=;
 b=ZYl5H3zeSolXll+KDm2Tp5ZHhF2Epra6d1v/kYOIUZtgoehVrG/FIAeyDQuDkDYcqOYk1lqwkVJb8xez9bH2bszUZESgAZdt/mwPmHI7qiPWZWC3H0AVIIJI5N6ObTYULuj4R3FP9kM4xMKlugI0FlzhcxFLgb98G98A4Mbffm15Uh729TDcNI9Bi3R0AhIlSUHSzlOfKbg8/71CbVAd8ggGq24+w3rx74l4AKR3QNasXPRMlnPHYbILFppo//C/kwKKBbMd8VqPDjt1q0TvUm8wrLek6Kl0OzLThpwv/UsQMmnb/5jBevfllxu0uyGp6qsuf3OmpKB9K9EbfxD+eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tOT3Lj8+ZVsOax1f5Ac8mYogXc9wosKXCPRQFGo/u0=;
 b=AoIXdcQ00B++8EozTuStmNHc/HZjGbMbm31Hri5hwvZ2y02qP4+wLouiYxrshPjyrYm1CWRRYBM7j2OLnc4EAP7nqkkD+jr7i7L7pHuKSvh5Jy2IFLEt1UPtRlE3K9n5h/GardqeBWMDxEytMC4t8N17RBWpAZ0v3Mu2GSu9Xfw=
Received: from MW4PR03CA0223.namprd03.prod.outlook.com (2603:10b6:303:b9::18)
 by PH8PR12MB6987.namprd12.prod.outlook.com (2603:10b6:510:1be::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 10:00:20 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:303:b9:cafe::d0) by MW4PR03CA0223.outlook.office365.com
 (2603:10b6:303:b9::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Mon,
 11 Aug 2025 10:00:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 10:00:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 05:00:05 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 11 Aug 2025 04:59:58 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v8 04/11] drm/amdgpu/mes: add front end for detect and reset hung
 queue
Date: Mon, 11 Aug 2025 17:56:51 +0800
Message-ID: <20250811095937.1978747-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811095937.1978747-1-Jesse.Zhang@amd.com>
References: <20250811095937.1978747-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|PH8PR12MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c90a411-9ff2-4d87-93d8-08ddd8bde10a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+5WEfl3WFDk4ycAyDP49rs2SBLGfJ+RU1NVnT5aC6J/W7BUFvRyWswc/frSn?=
 =?us-ascii?Q?Q60VcWzwNdhH+VW602LsCJpGhW0J40FvU0Tl5tyFmGBwcQuEyjmGzMhvfcoh?=
 =?us-ascii?Q?CMvbw1hw4jybvU8UvJAwl7AkCalbjZj0okJp4Ji9g2/Vs+VkH0HErPUua8Tr?=
 =?us-ascii?Q?DolFAALpIKdBmR8OXrxU+I+OgbonzaWAim0Xcmcb3hpEg907jrIoeepgyLdK?=
 =?us-ascii?Q?lWIPUWsEmDpZTf4yWOjlyLOX+hmdR+hX1h9bFiEgyFnQ2e2Tj7vgxHmadO+V?=
 =?us-ascii?Q?YFv+hGCSrQRvn0SOtLmRtomREQvWqElx4KUe8DcDkG+0oaFztXq/msbm3hrU?=
 =?us-ascii?Q?nGdi52hf6RRtA0jsJysilEGzxTAILw7gLO9/oWYWvJW6lt1IPn1gV8FyKQp1?=
 =?us-ascii?Q?jVj9xPKIlaYC7KCKBvt+bmoRyixOa/FDhDQGXsqbPwIanrpTrdqH04cE/gGt?=
 =?us-ascii?Q?7somjjB75kQV2I7ipv8YtGiX5ab791XZgA9XFk8zgY4JYCjRqT2kBReFJWda?=
 =?us-ascii?Q?Leln9r1ASFW3Z7aHhhco1Xm2idSgtLTNIqMbwsIb11Oy+AR9H1t0U2sVkzzE?=
 =?us-ascii?Q?SHQARl3a+8ewVxyzvVmkzG+MJA4mzX4kUap715beMynjxvJNbYvzIOxzrcg7?=
 =?us-ascii?Q?qtwAh8TxuQmWBNfCtvmJ+nLfgLuHsildAdNCnChbehzFjUjrMKKKlkFWZxGu?=
 =?us-ascii?Q?kKyRjkGFv2W82W/pzM7cU6TYkqSjlmv9ahrG5R8HWLwNmQJJDCgaCFyhK3FX?=
 =?us-ascii?Q?2a9OEqjtDWiJJc4MdNoSEWqbfIcaf5kSmbvZroDydDA6j7g9ZOsHFeM3t/jz?=
 =?us-ascii?Q?PtiBU72uOTGZRoRjb5WTMqIQYsjK8MvnU7vm/VEzNMlPZUQurpvKohX7sysD?=
 =?us-ascii?Q?co8jJuB5nE5oCMnNzAhMSO+zfUgeQPcsBPnr5rBDWyxporSM+wKbQkka03uw?=
 =?us-ascii?Q?HpyfHXOogduBfyq4Pfsai0nNRUDdn3IXM6o5UeFt19dMdbaGWvQYltr6dlYW?=
 =?us-ascii?Q?YTdJv2LKNWCKpfTlVS0aDf4rfvuXjTWf7axV5DtTXPz+x5yvDB7TS+z7EhMP?=
 =?us-ascii?Q?f+uRCfE+C6jbXtLTmKTE5fFFpUpDtKt4U1/FChYi+2zNBrco7cJN1dKOqWfk?=
 =?us-ascii?Q?nVgl2fCfO2fCyS1/WmPs1gHNKP16L2FP/Px4ZPtxBwa9+5BJk2muIdKGZ+Ng?=
 =?us-ascii?Q?/bBo3Bpe5RqZEVybF0o90cjiAXo7ZhSjDcRbCIAaFqdbefa4GsJhGYD7pwCt?=
 =?us-ascii?Q?oUwKHh/0RkiIPGq16bD3urdF4y7TO/Qf9cza9zUJpuVs8WJKyOgwejjgWORv?=
 =?us-ascii?Q?2qsSbbzR3vZKruUWmuEvf2xkirAzztX251ztHU9RC+t4GT1GwgEm7+SJaiTe?=
 =?us-ascii?Q?n/Biq5Nm8GKwhvSvh3qqSw2d34z1iH0Es8FFxwLsIIKzvyfLkMblGrvQ7kiM?=
 =?us-ascii?Q?bXVL8T5sg/ZOetD12y4nKDdawOEoL+ldcdIzadl3KxIqvLpqX2iazn3f39LI?=
 =?us-ascii?Q?SxTd+FodJHJwLsMNPNrNkTTm4v/aHyTrFOs/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 10:00:19.1123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c90a411-9ff2-4d87-93d8-08ddd8bde10a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6987
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

