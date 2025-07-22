Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59408C83F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 03:06:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACE0510E0E7;
	Tue, 22 Jul 2025 03:06:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0KFq9Jx3";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B19D10E0E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 03:06:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ji1UChhsaRpV1XqKjjz/ujF7W4Em7oMj3hk80OmUR3JJU2YRJJoFUy3hfTJ8kA6a5yyHTTmzouSCGzOG5H5EcMpAkXIremMASOig9DZEByPrbxtwEXZoEl3fynt1Dkvx4F23n8eUNHnrmhoWie3zA7AbCILwmKsHIpCszkKzC4OrNY9GYRoilPYAc2isdedLpyPRZg4hODv2TtZ7toKXu+v2gfkX0qj1xy+CvUY4GdzR86mJFoLunCcOpSOaBujZe2Y3RbOvUPozb8NgM4YMe9PuqH+RTg6iY0MjwPt6QEwLqlPmgjRmQFz9v0DUQUKR+NC+I352Z6s/LOF3TdM1Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gD+bLSxAEQkFIlpNJOL4yl8n2YnPpAufugwO4cbeZ4M=;
 b=ngexUwR84h3WU6Cw3jhrDNSFuX1LrhY8L8ROBhQdW3aD1TJuWloy71kwGE50yCTeogHiFq4elWF/6smxNdVZYIVY3WLQqxSlUwUqGp3GvhIfy1IHj4220+CYwe69JAgNWq3TqMRudVHwBRLtX/QRKifiSeKh8t2wqHtcX+8071ZFItAkWweK7xsFTMQh/OTODSD/WEtIZOJWRDSlQ0r6sFrobzey17nBPxETf1iE0azZ32bvzboR4dlXp4AXeUpPduiWV/nytHLnhfr2i6ZT2/k2W9NZ8/iUjGUyoqWi72Phcm5Mv3BmwsTxvUg4WJY1i7i2u6bWJzL8UEaPA4E0SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gD+bLSxAEQkFIlpNJOL4yl8n2YnPpAufugwO4cbeZ4M=;
 b=0KFq9Jx35Fox/ouU4l0wrEEwU2turqe6f6+p0GjXz7YayU4gybfLkR7wCQP47D2fZMThIVyq1z8TQEeXaQEd8jyVToD+lj9xJ3wKgohttH/YV0SwGLkPkkVYhuPYH9/js8fYhncp1H3OuRcyGtR2WQCsYp1TsSE+YWVQTfj9Eps=
Received: from DS2PEPF00004561.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::505) by DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Tue, 22 Jul
 2025 03:06:14 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:2c:400:0:1001:0:a) by DS2PEPF00004561.outlook.office365.com
 (2603:10b6:f:fc00::505) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.7 via Frontend Transport; Tue,
 22 Jul 2025 03:06:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 03:06:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Jul
 2025 22:06:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Jul
 2025 22:06:12 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 21 Jul 2025 22:06:06 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v5 1/9] drm/amdgpu/mes: add front end for detect and reset hung queue
Date: Tue, 22 Jul 2025 11:03:37 +0800
Message-ID: <20250722030605.2741435-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|DS7PR12MB9473:EE_
X-MS-Office365-Filtering-Correlation-Id: 474402a4-0002-4f31-7196-08ddc8ccb77d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TNBYJxxLsWhQ008jtENAQ+m9fMBmY3kG3BUgcp2xjq4iZ0h0gm8KCqh+IfTA?=
 =?us-ascii?Q?JxZnC3Uc+iITLXJQyl9Dnb++29LuV8mOruJdCU/4+7SkkyYSpAF8NAvDirns?=
 =?us-ascii?Q?B34ZAvdZFk/9ceFuHju/BGZh6Nq56DlrKKdv6HnOMsHmQMuCzQLnX/ieYf8J?=
 =?us-ascii?Q?ah581eqV81LtJFy3zi9AbLctlChrPWINXjWhRpyZyOrZtH4Cg4KxBkhObobU?=
 =?us-ascii?Q?+YlvfzhiDiPglDVFgiMF5BQqF0WYTRvbsbmNQrL0Ul0tJHPMSwVhpgVhK3Tg?=
 =?us-ascii?Q?CuCQOWBF44T72D0Ru/iNSE3TA86nCjAb2W/HA6kAeVwxJqSEr0nUByC0adud?=
 =?us-ascii?Q?Py7fz6oMupyZbFnuc/aU9dFh42pX2+QxPUUawpvtk8ArylipEoTV8NeKCwTZ?=
 =?us-ascii?Q?MVduGt8d5t6n13YMpr+DSW5SWqbh2+y0PxGRHFC4DzxWpyWYlKDNRSwMmKQQ?=
 =?us-ascii?Q?qSS6zg8pzbbMZI7LIedEZfqVitRlz5mSK0+SPgHQNTLaIcRdSbSlBOVV+mQN?=
 =?us-ascii?Q?cGvCy7OJcZYvOlCXkMzv+3tG8SNiNOArq+GyOt3IePl4Xm7GqCqtFZU4nURP?=
 =?us-ascii?Q?GUu+094E1Xww3v4tj55QSwmjD2x0AqOyQ3klyPnTuQVj8Mec2VTxb2qjKrXw?=
 =?us-ascii?Q?bCX2PXUAfnDixqbAElVsvOLCOdMhW/cPKbxXrex06qugWiATHV6tD7kKSI0Q?=
 =?us-ascii?Q?4Gr88Nf8AhxOtlTQuXrjULXLqixUum8dtnO4aLjqBIYXYZ/+8ZcGDGp3SKgZ?=
 =?us-ascii?Q?pW2i97SarTA55DdEiTjIEavnU6crg70HjllTKXQwbdfQjbtvLYmPhR7iZ1Dp?=
 =?us-ascii?Q?EsNM8GGI4EwIgj2aeCKd9tIT+E3ge8nsNr30EApCdrKz984t0vidhsADvt4e?=
 =?us-ascii?Q?hxgaxe5tQrE4NZvXqQclMvuJvEI848uzhudpx/LakkH506io0lmDzirroeNo?=
 =?us-ascii?Q?FHE6YplkgvzGF+3PclE1EOimCfACcM+ocdXXWIzDHVR3nl8Ln6fnRamhZOCn?=
 =?us-ascii?Q?6b1l7ss13rq2EcnLJy0xQD0PV7t+DOg9eMoIY80NOPdbq2+01QuLRuYxxXYe?=
 =?us-ascii?Q?D55XK/9r39eHN4diSKfNBAhw5Lamuh1oUYNjVAZrBaCFSDNByaL0LPMC8Hlk?=
 =?us-ascii?Q?jzZdKo85Or/jBUdz7bdIsx+O161mE+w/kfjzY8egk7+gRopnStXg6uX0E5Tg?=
 =?us-ascii?Q?En3KPxlSVyN2FHKBKxIjLj7u2ieM8ux0Pl0DbjVyTCw9h5EOV5Hg+vbT4zbN?=
 =?us-ascii?Q?U+20JXiSw37N99RfB3Wf978Wj8PoBLjx5oqp3G0OYLUMMtn+J1MxM0O/uk/t?=
 =?us-ascii?Q?hhIza8dYxGHSMXX2A+r4YCdYHq6Y4+Zhe5JA7ffjyHdilUbOoCj+YHmrv7v+?=
 =?us-ascii?Q?4oWFtUe6g1aH1XxGXk4CCpXUeKwGHyZON5yf8sKE6KgVZvNezy85yUm2l4jT?=
 =?us-ascii?Q?Ou68ECFl250j6IICDt4GGhTJR/zghypLXSJdL7Tz0UhG5rW2tEoee6So1QZJ?=
 =?us-ascii?Q?DNFWD5Y7jMt3cV8nekrXovOP6/9iHHCG4ukv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 03:06:13.2994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 474402a4-0002-4f31-7196-08ddc8ccb77d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9473
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 62 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 19 ++++++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 135598502c8d..64c5cac9ad5b 100644
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
@@ -366,6 +384,50 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
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

