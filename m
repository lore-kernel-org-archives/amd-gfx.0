Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B79CACA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 08:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A63C10EAAE;
	Fri, 22 Aug 2025 08:55:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ih8ckPMs";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F41810EA9C
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 08:55:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoT24hAJjsvuBNoE/OrTMP18X5ZijGzRDOhfzPtR6VVZ50+L8lNYxD7fZ9bSNfUUBNzW8Tdz7KsAbg3cdcFEbcQ7eudCOBLvCyJlwdZYTxvCldiBmRMoxnVEmRe2rI7hnWpnY25WDrnf+IkITi62xJQn8Q3uoDrvgw35qj8memBBfoMgMVLjaHrdz1LMQgzrnlTUIaPzBnz1tMXOEsVjHs6RV6RvcLFgIlyE94Dl2grQOFrkyL1kP2eJR2O+1H2lFkhA3oPCz6ONbSZqHF9REGWKiSXMQMsdeWJxUiYxGWCLk4513hBd4Rc4tH3CsEV3OaLwRQdOsjDshFB24MiBxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tOT3Lj8+ZVsOax1f5Ac8mYogXc9wosKXCPRQFGo/u0=;
 b=m/sAxiIs5lRSgQbpbbM45L+uEEqTcK8CrynewwbPyCsR2VU48VEXFGpgt7BTCFRxTcBJ0+AG76fFFxa3rEnJ8Wi1pKzSKhzbksOiBfz2XdiVTyRYRnb1dbcTOjuyfKH+peCUp1KzAKI7OCcz9VO8WHg4nnA0LBWVhzLMw6UoMZWWBKDitonpbBpcohJUoiTBWZmOeokqhcJJyyKU3J50CN0bBysZfeseEGSKuOMW6qVuvt5gQS1U+gI7EVcGTDhx0vPHhJc73Algi1fWgAvIc96TOwuCutE7zYXz2ru14287KFW8u924JgAvCGV7Uh1vJVJxV0+TI+KSf8GhqVSvmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tOT3Lj8+ZVsOax1f5Ac8mYogXc9wosKXCPRQFGo/u0=;
 b=ih8ckPMseAt1W+mTGl7q6+3lOegVbYfk9dyOm+a3M3jfUef5qT1qC9IqQpX7ZziBIU1ePfxnO6lhXIZMdvfQ3+nuzt7pZeHWJFIz1pt0lLA+BfLyaOMoIIjSkUmvEmakNfkxtqs09jJdynvMGBtUk/QU9vOSzcssKJyRlBEG0ac=
Received: from BYAPR08CA0018.namprd08.prod.outlook.com (2603:10b6:a03:100::31)
 by MW3PR12MB4410.namprd12.prod.outlook.com (2603:10b6:303:5b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 08:55:07 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:100:cafe::83) by BYAPR08CA0018.outlook.office365.com
 (2603:10b6:a03:100::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.17 via Frontend Transport; Fri,
 22 Aug 2025 08:55:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 08:55:06 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 03:55:02 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 22 Aug
 2025 01:55:01 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 03:54:55 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v10 04/11] drm/amdgpu/mes: add front end for detect and reset hung
 queue
Date: Fri, 22 Aug 2025 16:51:07 +0800
Message-ID: <20250822085434.970798-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250822085434.970798-1-Jesse.Zhang@amd.com>
References: <20250822085434.970798-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|MW3PR12MB4410:EE_
X-MS-Office365-Filtering-Correlation-Id: a17aa990-097d-4368-a624-08dde1599772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?twWd+mrxLCOqn8xtpm+3U/omykCcgyNAZt0vRmEZzWlflpALwRpraCOSwn2j?=
 =?us-ascii?Q?4yBN/Bnw2s1by6PelQPewhFjTCIpZQ/BCOmi0Lm6BJO0W/m6rGKllg9rAoV2?=
 =?us-ascii?Q?ZTysSHP16QNsFmMTR/8HNnS4dUVCusdZdrcFka/bDUlqGpgaFZU+lRVdU45P?=
 =?us-ascii?Q?zQ+yD+X6W5bDFTp9AJ5p7UqPMflTpUjdF7VJt0OotuOUv6jJG2meW48vp5VJ?=
 =?us-ascii?Q?zF8AQ940a5GwChS2HJkKOfKm2lTLrNdJnmfTiDXdvoEviOExABeQe4AfKfDy?=
 =?us-ascii?Q?G/l7UyyBQ1GyZvCLp3hf5o+RqglMyA1jCfWcdLNI4iwdC1zRyiobPgEXwdOh?=
 =?us-ascii?Q?YoCpekLhhH2r0J+GL/ovQsS2NYIxxQpz5PKWbDEaB95z5I62IPiToi0FDpQG?=
 =?us-ascii?Q?X/kurY/YLv8ltMyn/1zMWRDo18yR/OUuepj/Sa6ai33Eb7a+lMVwue3ZwPjM?=
 =?us-ascii?Q?m4sKE6yv5b5gPlox9IPudstsRbllZlWD3iUUIzy+DlpknOf8IMGL9K0C3ZD5?=
 =?us-ascii?Q?JAxPzs5xSshRtFYOCOKsXBLrTLmAZqMPEkcazVDE0IyeUD+GMs+FwwdBmWC4?=
 =?us-ascii?Q?DdFbK0m+jFlHm6ptrGGD0zqGMidRhgLcP79aU8TWGbL3dG83R/gjwdePSPj3?=
 =?us-ascii?Q?/HxtVrmmRKVuugQREH0/kBeorPts3YwwkKzxmmTMEX8NsRGct2rmm/mUdU2x?=
 =?us-ascii?Q?AqmMsYnGPExu+AqIiR5uaNihc8bWad0lPzh+LgzVWYYMb20wDSwE0/43FsFt?=
 =?us-ascii?Q?FuHJ9VFaAoVdzp1WaeiGFRTL5ZduM6u/IY8d0csLJXurTq4HEKkiYGUqIh1J?=
 =?us-ascii?Q?K5j/ZT+uf5wiMGd/FDJYLT6A1OKGR7knJx8EL6Mq0df4JTC3n6ryX4zIlIZm?=
 =?us-ascii?Q?n+LC/d5WwkoxWt46o4+Cmeu5Hs8xUoLZWxq0PqHAhm1F6ZjUH5diU9mZ009t?=
 =?us-ascii?Q?n0TMct18z4y7JFdYuAQiSTe0ZKFnd0+DLa+RNN09SVUk/JL4o4HxHfoIMmew?=
 =?us-ascii?Q?c77A5yaiNEHsUGgUFnPrHA/R/itSqwExs6hM8GPV19A9u5mCHQGjugP32DFH?=
 =?us-ascii?Q?T4aEOh2VUuzPNfZWAesDq3fK95ngQNFUUAJIIUae+eUsyJJSkGb4vl3O57bd?=
 =?us-ascii?Q?3zBy5GL/ZJzH2aTldKnAWGWCY7LTu+5wJ22OqpSzNySUBXnmgOuyz2zsxkQh?=
 =?us-ascii?Q?acXzsgURJ9OEou9ovVlu7GN8m54HrlIkK/OwGnmv1utTPyo3Bs37h2U+1uue?=
 =?us-ascii?Q?AwQ9v/Rk/9JFYwFqDpyYugBnx3nab4KpH4ql8MeNNj9oOwtUW3Kjxi92OYdE?=
 =?us-ascii?Q?pIdJKmAOJYWnQKaSBPkq8ctTWGTKWUpsrtPxsKbHc0PtHjFOMPS2J70ZFBtK?=
 =?us-ascii?Q?eLUvmFLhh2xq95TICkpFd0/e4ZTnUezP5F3b5b5u4wc6DhsVxkJlUDx5Nb63?=
 =?us-ascii?Q?WMtIFdBrCJ0Nxijc+pV64qm6upGlpAmM8J65irWH4HStEHQIkSkhmvy5QcOQ?=
 =?us-ascii?Q?w51bUf68AWYxjknLemDZw7qrOGqzVKS/0iic?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 08:55:06.4347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a17aa990-097d-4368-a624-08dde1599772
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410
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

