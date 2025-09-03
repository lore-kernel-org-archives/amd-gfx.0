Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82DDCA1009
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 08:39:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7735410E505;
	Wed,  3 Sep 2025 08:39:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xflSRI3y";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0ECB10E50A
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 08:39:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KN6bIL7EOjV5F/nicKS/Tz6e7PfntjyTLPaOzHa4sFSpru+rNme7YDr4VEdAGfE8QZJwoLw0IN38rKPzLsCAoqBDmiImdZwo8ewoWoP5N7uo4C3ieg/AyGWPjpl1nOvBQoRNHElrNP611DGDLfmSYrPr16Py5IwlO1nj9ayJFYJ3Tz6r1eT4a6iwIYoVXYtxe9R/p87J74kSBnwRABtEK8bRwwc/9OFt9RbI3kBikc/XhJLjDRZcCvSUHyEq54emrW1TdFrx1xS0S7gWk4FhAX9PDe9JiLfqkjo0KMZgmB9yVm/CkIDt2WktBJG1/rFeNIQ0SnAAmmieXOu8ivOaYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tOT3Lj8+ZVsOax1f5Ac8mYogXc9wosKXCPRQFGo/u0=;
 b=wH24CJ1Ir24qSyOGBU0UsYHXUzMqeXxcfCFioTkOAqx9jm9aSLpMgoqhgm8GNcGYAtzixTYU3Eyp1DI0Ozxzc4jf62zJ1SY5XnJGwkcXh2iV9Y1AkQPBKT6BJ99leNApMuT/uAn0/rKsNUcchLj+ZXmgpSbNOytCVxShWTFpvQzMh+gDBvTe8NZjmiIuoZn3QSs0vYq++OkXM9kfBK5MJ7PII0MLJtRCf8sDjXFE7DKC2j3DjQrJNINi5oZHstfPJsbfPcZ6oj3Bg7pewycO2nk1K3QFmYPxYrukB4glrxkUNdnaw7yImravyw1VdMZ0h2ZrWMgutovpsEd4ITbnEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tOT3Lj8+ZVsOax1f5Ac8mYogXc9wosKXCPRQFGo/u0=;
 b=xflSRI3yAGIHBeYEofKgwSqJWZeppmOkPbu5FNuRye3KWLrpViTJQuRDTrBKJ7J5wTnC3Vg9tIY7/3RjdZcoecidVcZNkegJts/RWRrYLl7svw9oEm2xcQefXM7uci1YEsNe7Rq3Lk+LVxh+8bOZ5ypkOeUUxovUwaabQ//7kSM=
Received: from MN2PR20CA0046.namprd20.prod.outlook.com (2603:10b6:208:235::15)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 08:39:44 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::58) by MN2PR20CA0046.outlook.office365.com
 (2603:10b6:208:235::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.28 via Frontend Transport; Wed,
 3 Sep 2025 08:39:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 08:39:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 03:39:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 01:39:41 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 3 Sep 2025 03:39:35 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v14 04/11] drm/amdgpu/mes: add front end for detect and reset hung
 queue
Date: Wed, 3 Sep 2025 16:34:22 +0800
Message-ID: <20250903083914.2604482-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903083914.2604482-1-Jesse.Zhang@amd.com>
References: <20250903083914.2604482-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: eafbd4cd-c123-4bcc-d451-08ddeac56e24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YUdPlpG7APLXp/Pab15aWG8XdkjomUV7elusHqIHXyCwI0TlcIygdUqdY5BA?=
 =?us-ascii?Q?qLtgCDkhvDmJZ44wZ1d0hC0IsY0ct4/v/Ih+okeKcwmh+MGiPmkDQGL8EQKA?=
 =?us-ascii?Q?m49DyK9hn2HiOJMyGKjWxsxNATcdV2WgWws8V1/0FcL16e6lYYDlWmp6iYAK?=
 =?us-ascii?Q?ZvhgMPUs9GHGzubV/jDfLM6j/KHFtEkKJB7158tu2IIBHD6JAsizIlqick7t?=
 =?us-ascii?Q?QKHvU///iut+eM/HMd4UXRyuPkCmPVd4OU9wjKwS/qitm056/NJcsgyj4h/U?=
 =?us-ascii?Q?LNxnGNGk0Kaoqeyv1kXw+lQo7pLuCwJfjzzfw2vsDWBnarIOKa211MpgjuFW?=
 =?us-ascii?Q?IYaqUC2BTZ67THPWEMkwTu1xrCZcZB6EgHRX4vpqpKkhmC/fliniIWfWDRpL?=
 =?us-ascii?Q?92rd6rzdMyRuWz/VKYb9IEStziPnzZPCY0Wl0T4oCgpjTl+1q/SvA+FSiHP8?=
 =?us-ascii?Q?8AhstICWkHwMkX7tkMkoqdYEXR80YbHUXSCtWGtpzWQy/fIql7FMHcPXBZTN?=
 =?us-ascii?Q?VBz2wTs9z5WmdM+ELLtzntMFUPylTA0NPt0VoVgcwAF8YMHS9e204NUPK+kH?=
 =?us-ascii?Q?Kf9Un+M/4/8muBTwq3btZpbsGNsTFEczrEDKoL9DikIMEbkW+HLznvQwPQ1B?=
 =?us-ascii?Q?HjbD4WvUlLqTd7HgxeWh78N73H3JTbz83CkWEqGiIZGj6/LGcybi4ac1ow0C?=
 =?us-ascii?Q?pSYB+k66ispVDoQZOe2rvL9XPZ6e4wmAsfmu2s37586Q0Xvk6yoAB9k8/Wuv?=
 =?us-ascii?Q?aQio0jpb/dbCH96PyPDuWcuraQoiPjt7NWLFBcAtTwc/9DpvvmcscJKpH8Nx?=
 =?us-ascii?Q?z5lARS7wRUE+feuajTgZKjxg3jOVSswB56fTHTN3MrVYzoxTrTKAQFxXTrQ6?=
 =?us-ascii?Q?eXBGpd4N+eMgYkQR0FQ03HFdkW6aW8qHndpRQPCBbd/PEWHTAk90353EBN3t?=
 =?us-ascii?Q?nbQrjKonGWsrGdTNKA4oVYcvsXSn8Dc++DiGYtJcPKldnHP3wKrChFz8GaFt?=
 =?us-ascii?Q?epF5zyKRNtUAF05PufU1nYsoEKLp6rCZ7/Xt0cEMZUJF3e6jMe/2CpvGWjk9?=
 =?us-ascii?Q?o46/RHIhZrujrOjXM45M6E0cY+vfge6N9uUYQhyD1EDREo0tFs0huHkK6OEA?=
 =?us-ascii?Q?E/6hojyMce15DrTP2TO4dhAbZh30/oQ8vIu5amM9wiHk0ve0hTMlyW3Jj8wc?=
 =?us-ascii?Q?73BONXLS0SSwEj5WvKRdjfDqjCTBtG1CO81/TpTNt+7XSPmFq6wrPu8ePFKv?=
 =?us-ascii?Q?CMcN/DWLMTFLZFkHq4kgcmDJTLnDD1d4u9iPezZ+7KuQbyjyx8p/v2nrbrWT?=
 =?us-ascii?Q?gX6QNWbAX8byL1EZ1PwSTGKzjK6fdVzd2Pb4LJKToyHnW157RHZegh1Pqcua?=
 =?us-ascii?Q?APIHvAtbdxA+5BxIiwGCFzCeT1fjV8v/6wllb/BtDc0K9v8iGEZOaAOQEC2W?=
 =?us-ascii?Q?ELRdmFiTNPj4Qhe6b3Wq78Uku3OiFwAFgsbEis0pBuG+Z9FCpU1TpMdWB9z9?=
 =?us-ascii?Q?G7DxmAGYEY2pp3wpU7VQDYPyjFr3OLYQEEzI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 08:39:43.3398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eafbd4cd-c123-4bcc-d451-08ddeac56e24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
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

