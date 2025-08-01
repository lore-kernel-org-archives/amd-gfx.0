Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985D2C87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 06:26:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1472A10E0E7;
	Fri,  1 Aug 2025 06:26:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BV3Pongz";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6919D10E154
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 06:26:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDRqzXlPvStDqpj3BI50dp9mV7vyrRhezffS3/y6OEAEheFTV8eZDMiwC7Ui9FfwpbPbJ0x3HSMWOItiTW6xegLCIsCm6OvS4aS7zElF29mj9CC67NhCi/XcH/QhWaXHPiU5RR97A+bFGC9Yw6xLBDVgmcUY43iQEf4cgHMngILAMNfOpvr8VHGTMyojp/IevP/C+B7sv/Y68aQaNaqokvMCc5QP/7SAH+xC7DedvZJR84yrvx8kUeigZiRR/yXoL0tzWto2z9iUBs/YMvZPu6bdM/IEmscqq5XVjzbl6Yjwshy4syfNT4Pi+Fx62r7v64JFdG7ly9fvVGZ1jI503w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gD+bLSxAEQkFIlpNJOL4yl8n2YnPpAufugwO4cbeZ4M=;
 b=gUzzRENDzYuEWD1h+sQDCfkGX13onguk0+XyRCF8iuWuJ7FLVjM1m5tvRcEnqOlgb6VhY1QE2E4Wx+WYXCzMlK3iLwUIj6v71zykHRARhgP8YDS698IZl0Ys/FYv2iDKew3/oYnwmQayXk5i/g5ypQkEAhcbbIKPnVIzXCh6nM1dmKiPvnWf6jfDCVPNhrWtAIgqSyS9VGPnDttrZeKhRhq0rVblAFgQ5nKlQSZxoS2YQlEXBpoXtNFPZPCvybEpVLMSs9lE++gggf7nGKcYrarPRSNQTQcfD5/ZEdR90rUBanjlXW/fbZ6VeMNMOz/PkTGRRGHpVcHcYNS/9rT3UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gD+bLSxAEQkFIlpNJOL4yl8n2YnPpAufugwO4cbeZ4M=;
 b=BV3Pongz8b5a0jetkCMwqh6MDIR9YuJUvAknYZgz1f3vfM77njgyCcm6MeHTXywy1u1ZtuOMF3sHnmAD9d3qOZYZ80oa0vsWQwRU0pLuOrnBCU33r3Vwzll20Hp5WAAGjCGUXK4gdz7WDoPjozdUzKD2L4UHWQNKAAv5Zyp3MWM=
Received: from BN7PR02CA0022.namprd02.prod.outlook.com (2603:10b6:408:20::35)
 by IA0PPF8FC6E1236.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bda) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Fri, 1 Aug
 2025 06:25:55 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:20:cafe::8f) by BN7PR02CA0022.outlook.office365.com
 (2603:10b6:408:20::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.14 via Frontend Transport; Fri,
 1 Aug 2025 06:25:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 06:25:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 01:25:54 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 1 Aug 2025 01:25:48 -0500
From: <Alexander.Deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v6 01/12] drm/amdgpu/mes: add front end for detect and reset hung
 queue
Date: Fri, 1 Aug 2025 14:20:59 +0800
Message-ID: <20250801062547.4085580-1-Alexander.Deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Alexander.Deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|IA0PPF8FC6E1236:EE_
X-MS-Office365-Filtering-Correlation-Id: 1591104d-919c-429c-653f-08ddd0c44536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CEn2mEeuk0z/7uDB7O4O2qKGMzF+Ri8Wa4cCpWu4NiZ160JJPAuajG6zkxBZ?=
 =?us-ascii?Q?2zFDX/Cy6cHnWkxJ97loKxPDxJF4HdSaAcDtqFzI9pb6zEMBBe/UsSf72ie2?=
 =?us-ascii?Q?0GfJtPv/OShePrKM7CGuW1TsuIWrslN9XJJOXPTXM7R6X3B8KBiXYc6/UCBk?=
 =?us-ascii?Q?HwJ7Vabvne7u4UXUPWJ/+iGdQT2IN9EFuGQWvp17dYWz9Elbd78Xt3U50puA?=
 =?us-ascii?Q?84sg/rmk6euzuYfWAc07tUmSgd9cG5qsF1o2igviGgOwEba3GH6oZCfsxBh4?=
 =?us-ascii?Q?UeNPPWqOFTvHx569Q1s02rEnqVUFJ6yJyl/lOLCXPays3suW8SOZd7XdaWwJ?=
 =?us-ascii?Q?G0oOTOlVCkLvyWr5G8pWFHS2vLkitlgP8uNvtScaR8qu7D3cBacNiHm/BsmT?=
 =?us-ascii?Q?pHXkF24P1Rcat6utDhqG063Aqr/toKD9eoHNjnRI+BziTIOySWHLwvE1QdYV?=
 =?us-ascii?Q?c1TLw/HRDBFZG92C/sNpR8tfkwrZeug8UsHxQQjG4lDTk8buNj4Uq+sk8IG/?=
 =?us-ascii?Q?KSBmFL/8da8N2CBD6fERxnLeKhmSWOFRDmqaWG6agbl96TQkhBHIVcHs+FP3?=
 =?us-ascii?Q?I6wNinkIzaizAYVQsl9IPw3UYfQrPEkP42M4ZX2gpuiaY1AKEiaHlqUxUjFI?=
 =?us-ascii?Q?PqwzR4UG1hZ5Ue4My7TrY7B2U6A6bHC9paFw7+TptqPHjwKHNIulYAdZCnBE?=
 =?us-ascii?Q?VJx8w4Q4xfTonUaBRvoR4kDAJwirpiLEBY+B1OyKUBw0R0Z02uDK9FgbTCgH?=
 =?us-ascii?Q?+PIH+O6GaU63B9kKbEt+sqe22/gn5X8VWc57zvvVr0K5n7JT/EReYGCPvWgA?=
 =?us-ascii?Q?JB9ehJT2y0+9uD7SGqIQQLHo2u4RlYnbnS9eacBBcDAuZ3uzjVSZ5Jx85cQm?=
 =?us-ascii?Q?fwBSwEMoZ6phK/jdSJSzip336c3e8K1zUKk12vZ04j9g8ze+24q76A7fTsGB?=
 =?us-ascii?Q?cCKnfP7+RksjD/ipu4gyDiQUOTD50e0mprEKHFKa5u/AkaR6k6AZZQ/q6Smt?=
 =?us-ascii?Q?qNUUJsI0DvkzAzLucx/KZu8xtOZLQbR8H5SIZEJChWJ0E8MsbqnfSNaFR0Ns?=
 =?us-ascii?Q?pEK5Urr6cCX2S5h1ld72MXoXmWAElrAYwgBSQ6+4bkdyuqRQsKJBXVTbKDI5?=
 =?us-ascii?Q?nBGG7W42WDQGiYuOEZI+IIv7H1CdkY6IdY9VudBiLMy7bdw+XjiDwW42xh1A?=
 =?us-ascii?Q?9BHbmlLMQnVTerANIy8EougwIcPMHLQC7e11iXonYv722qmy9rkFPtMNNmlI?=
 =?us-ascii?Q?GiEuYnv9E3f8SiNi8wmg9FvW9s9HDSgZOsu3kY0ETlC3584NdKVTN/2lQ5BL?=
 =?us-ascii?Q?Fq1CjKwK8jqK0t6BLvlahShiIFALO2WLU5ZFB0znLzzudn32P7gFpO/EjsN3?=
 =?us-ascii?Q?w0lhlXMpmNmZinjGmBfesBo7ezWVekVM3lNc2V0Sh8YpnAIwJyNa+0tofPUZ?=
 =?us-ascii?Q?bAiSZQndL9DWve1I+i3jESnSQEKv0BJErOcY9JvnjB0AtUYU75Nc/xy/ZyIy?=
 =?us-ascii?Q?PyYLWC6xjdIfRuADQB9knBeUL8g1Yss7ndag?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 06:25:54.9421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1591104d-919c-429c-653f-08ddd0c44536
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF8FC6E1236
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

