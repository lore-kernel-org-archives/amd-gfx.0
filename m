Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F80C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 09:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34D1E10F2C6;
	Fri, 21 Aug 2026 09:54:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PIkURGWg";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3678C10F2C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 09:54:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FeW3+5BDBXXUICYUbnzOgCO2df2W3AaqtGMQvLLG79msXZnUqne53alZM0xbbFUg9XB5akZnbik9vgyCgDc5M7aNUSLlFEgD16f7y/7LfpnTGJXCvTWisyg87otPzoaSJN5dRkJoHFnIwsmaNn22ikCBosC65/BT30PKbiQxhkx+ssRY5T91PbolCTXdft5QKINuwfDPgKafYega0Zi97cd20pOU6sq/5z0meOdErYt6PvsMNE5PiiGFlAGFkZLkh/uNupwgji4k3JMiDTGA2KDvkfxiOy+YYsNeQqJv/NovsgZQ9w2fy6sBoBMU8RuWItycdbcE0XoBVrP2moa55w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LMajnlnoL8Ea9rvmWzMfQaKoFbmI0O2cDGaCUfFafk=;
 b=MJeXN8n9DLd9613VwgvjzWEeuKfr6+tAuZNKt+CqLEUmqxKsL5PyTh3sjZ9JezJofMEQUNoPNe61dYOksazZzo8zSxPN0ly8MsHguiE3waFGTPnCkcKlKzucRiuttFD/mdbqR/go07gNMmeNJ3jGs6iurRa+yUqjqF8/PHagk98PRSGHUY9cBd0iLTz4UAFfw6cu0nvqIkqDpias17dHRMJ/YEf0i1A86DPMwP6eHw9WZalbKoxTDzF6H9sg6bE1U98VlmJiKq1jZbDfvUOkt8IgLyB++D/VUFTQzww8C0b/BuzlBpooEvmmorgchr7TdYetMO3uvXo5BPDkv/Gs+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LMajnlnoL8Ea9rvmWzMfQaKoFbmI0O2cDGaCUfFafk=;
 b=PIkURGWgCtThxSrezgs+iIVLMR5etXVOOflL82oezUjfSzc/lUbb+VGXxTXzYoVx+vSuHq5gLcOdW0f7xLcj/gN3WS2OAKjJl83S50tP7dZ0cs8RuBlP4e16gxrRZRy4HN1/+etR7UbCRSNEjnKGXzTGyGgm84zzUynmmhKJTmg=
Received: from CH5PR04CA0002.namprd04.prod.outlook.com (2603:10b6:610:1f4::20)
 by SA1PR12MB7271.namprd12.prod.outlook.com (2603:10b6:806:2b8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 09:54:36 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::66) by CH5PR04CA0002.outlook.office365.com
 (2603:10b6:610:1f4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 09:54:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 09:54:35 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 04:54:35 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 04:54:34 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 05/10] drm/amdgpu/sdma6: implement update_mqd
Date: Fri, 21 Aug 2026 17:52:14 +0800
Message-ID: <20260821095427.2361126-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260821095427.2361126-1-Jesse.Zhang@amd.com>
References: <20260821095427.2361126-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|SA1PR12MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 144a4a71-f9ad-4265-72c1-08deff6a3558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /8PpGmfWxEy6JiK9Vf7B/wamsik5jpfHDlAARGC1Zlg8jxHJGtcvCjSZMmxDbcohWR2rgR8XjbGUNtF1AV/4cQfAB79DMPmpAJumUH+mCcTRtA19TxvUsGnbwRf3e90MFBAVQel72KmXWMCNYx2mXBLhH2G3k5DRVSJoV/pAAULrRlicTHYHKALpRz638PtDUyzdz81l8Mf5IG3CVGUkWp/SruWMkWgoHYOcheNF8yO8iysC+Pw+logXpCC8sMAEe2DG+0dkE17fpVOl1Z3BNVoANfkueVh0v5gcrPg4Xi0aj3wNUCLSbZGmQAo2dBWqAdKEZNZ6Ay2h++L7/oVnuuKstTLCRKwQUw7t2BBDBy7a/ZEtzkWFHHRWlEIMi6+lKSr+dvNey4v/iGzIsVGojkW7M+Effi8KPuYi1NAYJc6khS1YW0nzSqof7jKcoc8GT+LeD+FdsIZCS5lQYxfw+SEK4N1JXRRHoQrL9j0XgtLPgVlWjddz/IbbMwu4TojdR7eUUxXfedegWGqQnz1dv764DYRo/+0pX9nnbKkEjrYf6cjwA8c8oqX4k5eaCsCUPKTA+mTpXW3DM/0kEuiRkAm2WZL4ChrEzs8GznfR5iISatxayq/SBf+EvG99qGZDcoUInjMPDokTSPmm7vsoUhlVli+O0U/842AX6BtvfhAf5VFOpTOkTwzExW82rMOEFrgeHhMZubkqEITiG0TRIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7EQg+4vjQ74pySr4949McM63erA8aDXoa/xu3eCzW8B8uN/5xmyCKWTHiQJTQUjKErxyOSpQhVjWUnjlJ12SaHzcLJtOhRKq2UkEogbqpoxcXs9qAw9VUhEyTFqz4XJAZRXEQAvKaZ/E5kz+vZACXHDytUHpPOdm9Ty7giCm7R70DHdNag0TZ4eH/bhUDqj7duvRzuurEAeMZMAJ38RursN322fTRwmbs/VOE9Kh6/xcj2DnjfkfYyRCafQ7M+yTS6SMmwVQyflmBDyCUH3tX5sQu30SJS0IE/1iyCyZWbLqlzLM2Vf5cuSdcSrDsi0WLB54+ogGuCde8axm92IDD0p4SpIBtZWZYTdEnAs16xEFxI+VOIohQiZ4SmCEWCMTRWgzgFgHTgoCHKFhTEcXa1I7dBiHGqumP91QJQ+8QLnFfDaGI42xuHm/JMwEHL1K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 09:54:35.9257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 144a4a71-f9ad-4265-72c1-08deff6a3558
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7271
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

Implement the update_mqd callback for sdma_v6_0 user queues. SDMA init_mqd
leaves the ring rptr/wptr untouched, so re-run it to rebuild the HQD, then
restore the saved read pointer and forward the user write pointer.

init_mqd also seeds ib_cntl from the live IB_CNTL register, which reads
back IB_ENABLE=0 on a stopped/unmapped queue. Left as-is, the re-mapped
engine drains the ring (rptr advances) but never executes the indirect
buffers, silently dropping the packet queued while disabled. Force
IB_ENABLE on.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 3fd3e530c76b..cc923f8531be 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -884,10 +884,39 @@ static int sdma_v6_0_mqd_init(struct amdgpu_device *adev, void *mqd,
 	return 0;
 }
 
+/*
+ * SDMA update_mqd: init_mqd leaves the ring rptr/wptr alone, so re-run it to
+ * rebuild the HQD, then restore the saved rptr and forward the user wptr.
+ */
+static int sdma_v6_0_mqd_update(struct amdgpu_device *adev, void *mqd,
+				struct amdgpu_mqd_prop *prop, u64 user_wptr)
+{
+	struct v11_sdma_mqd *m = mqd;
+	u32 saved_rptr = m->sdmax_rlcx_rb_rptr;
+	u32 saved_rptr_hi = m->sdmax_rlcx_rb_rptr_hi;
+
+	sdma_v6_0_mqd_init(adev, mqd, prop);
+
+	m->sdmax_rlcx_rb_rptr = saved_rptr;
+	m->sdmax_rlcx_rb_rptr_hi = saved_rptr_hi;
+	m->sdmax_rlcx_rb_wptr = lower_32_bits(user_wptr);
+	m->sdmax_rlcx_rb_wptr_hi = upper_32_bits(user_wptr);
+
+	/*
+	 * init_mqd seeds ib_cntl from the live IB_CNTL register, which reads
+	 * back IB_ENABLE=0 on a stopped queue; the re-mapped engine would then
+	 * drain the ring without executing the IBs. Force IB_ENABLE on.
+	 */
+	m->sdmax_rlcx_ib_cntl |= SDMA0_QUEUE0_IB_CNTL__IB_ENABLE_MASK;
+
+	return 0;
+}
+
 static void sdma_v6_0_set_mqd_funcs(struct amdgpu_device *adev)
 {
 	adev->mqds[AMDGPU_HW_IP_DMA].mqd_size = sizeof(struct v11_sdma_mqd);
 	adev->mqds[AMDGPU_HW_IP_DMA].init_mqd = sdma_v6_0_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_DMA].update_mqd = sdma_v6_0_mqd_update;
 }
 
 /**
-- 
2.49.0

