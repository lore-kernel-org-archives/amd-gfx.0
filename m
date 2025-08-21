Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A4ECA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 01:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4364D10E2BD;
	Thu, 21 Aug 2025 01:41:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iEU+tfpb";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98B3510E2BD
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 01:41:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1yH4qwM62HYopOm3qNZPUl0R9M9XbDM6UVzRDrxkhc4WXrkO1RdgjnWYFbz6RqUu7UYyYK6Luu4glVk3ncOzt36go+f0MWuQefMBBvdBb0osNbRcebQbdhtb+YmUc7DarcpRiPq3qQABPsLto9DUFwKa4LM/PoneXIUOoSNacnCLhVSa9fjat3lpyizzxRtuXm6poA2La1Sg7MqPnIfXRygNTrlzm2/5aEXA+bfzKusMQF5rarj1gU7Fqi92xzy5gAYbcyZpdUnrZyzONynAeaCeXA2QqWgPmy+eT7/nQCuAtUp8HSnF4aLvXaeN/wgZHnuDEvBeWsNQjPhFtF9Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tOT3Lj8+ZVsOax1f5Ac8mYogXc9wosKXCPRQFGo/u0=;
 b=AsSzKDqR37SKDloH0aMDGoIBAYl7k8+fq3bNr35sSe6Py91gcyZRup/lOo2Q7Lh5wPeYHrMHFBDhWOMUILkUnVBEIFglpLWDRX7drtwDiHhCriovYcoJT1AR0icaxh+ls4sXsRouqRn3/to86db2Z8Yh2V1GoKBhQcv6RioDRlQaN4BH48wulK2tFLsRSaeszC39LtFbm96XYuAHqUJbJKpO+HcWiJtg408jQer2U19oJLKppAc/np6O9Rb0lT1HEsR+DMQEVsngzMQRR+O589F3/7fEUOHZ5IIt5MCO3FZ+Rnk+lFFYHJYYUEWCYumEfmqTmBCQDKRzO7xEvY2Yug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tOT3Lj8+ZVsOax1f5Ac8mYogXc9wosKXCPRQFGo/u0=;
 b=iEU+tfpbo1W9LB+2eDEs7Y8aTgAi60topJV4YcAWnUwNKmptznyJlOHVzqvEbz84VD+bzewZaUjGBFVHj9EsMMlxrqXMpwo0bW/CqCGM14M6pVFipuWz0mOH6DsN1AxqX3/IGrNo1aY52GgCi33qSAM3zTlMP36K/geKmgI31ME=
Received: from BN9PR03CA0232.namprd03.prod.outlook.com (2603:10b6:408:f8::27)
 by DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.25; Thu, 21 Aug 2025 01:41:50 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:f8:cafe::9c) by BN9PR03CA0232.outlook.office365.com
 (2603:10b6:408:f8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Thu,
 21 Aug 2025 01:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 01:41:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 20:41:47 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 20:41:41 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v9 04/11] drm/amdgpu/mes: add front end for detect and reset hung
 queue
Date: Thu, 21 Aug 2025 09:36:06 +0800
Message-ID: <20250821014115.566598-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250821014115.566598-1-Jesse.Zhang@amd.com>
References: <20250821014115.566598-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|DM4PR12MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: 7da5b16a-5e3d-425f-9275-08dde053e609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KdbmNzXWxFwiji+DclPqFYnrthGNc5XKMbsFsOE2npXcpdTQVKS7BAujBhAZ?=
 =?us-ascii?Q?LLYvyQCajRtUOiyxT/JbPdZAn/fhgxGdNhMBnzruDSbfjm7YQ5XdWRd2QigP?=
 =?us-ascii?Q?ymuJfY9v5oS1Lq3BTV2liLeIlSoKjACn39qKs5qdEDLI3qwhlqMGDU45GZjE?=
 =?us-ascii?Q?7EPX9SAiqoeGmRtpMfzjvTIhbXXpp7FDfGHO6TiF3qsGOIZ3tN5rHtt2AXCE?=
 =?us-ascii?Q?MGpGKtB9S9ZpQpLE0aLK1Fl7J8dO/dT/3jSZEJewwrSvD4epxGSaPLuwCVls?=
 =?us-ascii?Q?IB2x1c629ruNPUPGL+V6x3C9Lee6tLOoosgEZSG3fEO6AjiwUd0LAZhXxQOE?=
 =?us-ascii?Q?2lWomI3SYpWKo35GLZA1nBINN5WxY+dWsGKpiNxdRk9sRgNiBpbP0PyDNilo?=
 =?us-ascii?Q?/EbSx5pBPWggpuptuBebaFUnbvnA/oGTSLhd1Zq9cHZ8EMAu/sB1eMuTZXQG?=
 =?us-ascii?Q?RGkE9NvPKQxZpGcFyODVHL1R2+BqSv4zJhhN4rJ8BS9LytMFEDeW2mTypQTh?=
 =?us-ascii?Q?rzDxf5kELB/XpPD3mYVB1UiwzZAWSl6WR5fguwU/Fde9lQP83Ae+aityP3Nf?=
 =?us-ascii?Q?icEPD8Bd3dPptw30rmIcw5sDlHIW61Ayr81qVInqVkewETBwOS1bV7AI5KjJ?=
 =?us-ascii?Q?h/Y8OO++GH1J/04IhGG7YVhhijG7ho4JlAVE7yS77kptsWJ7yI4+4Gy6wd5+?=
 =?us-ascii?Q?yA5dTBd4ASnA0jHrwnHlBzODsbCTqNhFfiMdM7oTNLzeWqUKG8pSUWuCc5Og?=
 =?us-ascii?Q?Y7UTglPUdm968ePDVmKsvrFaCXbgRwwOgPhU8iYMcmqmVhhUVhXwPyVnGF4h?=
 =?us-ascii?Q?ZCX+xyhqgK2xOt56SESPBp8+SJVrqQWfJTF8MGSqcl9gGzZRLzBsJ7Nit76E?=
 =?us-ascii?Q?hLDpej3fpBUpK33o0/f7NJESTO46oYENX07IT3HNqchnCB9A/TvNT505ccX6?=
 =?us-ascii?Q?Inopd6RYRDNKoVSbrhl+3LY+I3KFwGSIpTjvs8M6GtdpIokqULK0+0xY7F+V?=
 =?us-ascii?Q?tiJeGovx2PY7wY/77clNkg70f1GhZub/ceN798lNQznggyOlB2x900F34Fm1?=
 =?us-ascii?Q?bujf8FCL7LKqmgXsXg0fBowCdKklAKdBSHjZ9q2oe3mi7ZLNow9fb7gd67jc?=
 =?us-ascii?Q?V70Ep5YgwPAyslX3kBh3aW/uFdLL7BGZsQNQNHN7ZqgzWOUgJK8CR9nE52Zy?=
 =?us-ascii?Q?EToLnyABYNAhDgzQqxD36Uf3kD4rkJhQBAkqs2/7WPDD1lR+uM4To454qQHF?=
 =?us-ascii?Q?EG5MPDtn2J12mwlpgk4vRoFTVgUSQ2XJ+I19HqGh/9xVWUDgzCWo3mtVL4WI?=
 =?us-ascii?Q?cun0ReM5jEuBZ/vBlZSOI+J9ZErF0/TpmUuGJsydhgzZcx4pxe3ipBdszhJJ?=
 =?us-ascii?Q?ahhBVrP1/KKr9kStpU30ZmGi/WAWMhgEiaVh+LGwVG6Vpc9tEigPG/Rrs0ek?=
 =?us-ascii?Q?Dn6nBW2gV9PFYezdnQGe0lD5yIQsBo4ShuunuyqUmWy8wLkh1DR0H7j+5RZM?=
 =?us-ascii?Q?H0scdP6L98x9bas00XJgoTaEGZQv4+SCuS9K?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 01:41:50.2354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da5b16a-5e3d-425f-9275-08dde053e609
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723
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

