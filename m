Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387D8C5DF94
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6FBF10F35B;
	Fri, 21 Aug 2026 16:07:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wJJPSaff";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011051.outbound.protection.outlook.com [52.101.52.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91E1A10F353
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:07:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O++teajHsthuY1Ooszq4LNuYDm3M30LW8s6IOGqEwksxDguHxAwp/i4SpiUWWjZjAtipaF9NQW67v8vZTM7GVJQVCPSM/WiCIiGFjYwhSEEItaeWtjHPISQaahqVlsqZINoHMqYYuC61b8RbpJfwJtGGCJyS1WTuwk/+10tF7eNtTBrhkp5BPZzhVZLujv2mBDYJFFKCAaXqgv0NwJR03ds+/upIZcKjE7C2rHvIxptxOqON0//TeEyXt7APDAN+YYm6TH4lzYzfpL2CDZb85ALXENCBd9PEd7A2PHiMFa2IznK3/DBMI92Nz8bU4+EhO51sfm9ZgxtOZzVnLKN8DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WECfagg8N8cd6PYASP0uE/fXQQyJo5Cl4K/S+QzKVPg=;
 b=Cgbshm6p/sByeF8stRHbjXNeX+5KRCQbqsG3ER6JMWuTmhY8kcAZC7+1J1Fm53ebLdccw8A9Tvd0VjkqoQQMkijktNbd/Frsy0M0ibCVk2IDbiMM1DWW5Lpw1qyR2o+XTpgfMz1XA45Zdd5ZPO5SThCvrcPE04I0FkHrxySpGOVzZq6aWEYcVQhbc7alKfowUGRq+3DNKqbyAVcAdys+eB8Fi+t/kglp+wKZhM6sPY4VDZMF9kVSwQgxHMIecHGbYsRmo2miGB2RyDdI7ryCj1n7ZemSGtGz/+r9Scu0k480wh/eMgeZPjtHSSqCZO1NK9LK4kbjgzYcyk89VcmTcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WECfagg8N8cd6PYASP0uE/fXQQyJo5Cl4K/S+QzKVPg=;
 b=wJJPSaffUSJrNolDHfarDfum3cepUbGiFz9FOfnLVhc8rfJ8Cdt8sKnslAHPo/k1jeTRM7gbRwgLnWQH4ctvGHT9SeRkikXnbqTW4zKpCNz4cP/beUciEyGqYX4oTqoELKICv7cZDHSNEcGVODDPgVTNlbre1cijVjnafpPvUcA=
Received: from SJ0PR13CA0074.namprd13.prod.outlook.com (2603:10b6:a03:2c4::19)
 by IA1PR12MB8224.namprd12.prod.outlook.com (2603:10b6:208:3f9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:07:32 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::44) by SJ0PR13CA0074.outlook.office365.com
 (2603:10b6:a03:2c4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.4 via Frontend Transport; Fri, 21
 Aug 2026 16:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:07:31 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:31 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:30 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:07:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Michael Chen <michael.chen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/15] drm/amdgpu: Unmap KIQ during driver unload on GFX 12.1
Date: Fri, 21 Aug 2026 12:07:09 -0400
Message-ID: <20260821160710.752459-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160710.752459-1-alexander.deucher@amd.com>
References: <20260821160710.752459-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|IA1PR12MB8224:EE_
X-MS-Office365-Filtering-Correlation-Id: b4fd1e0d-ffd6-49a7-4d4c-08deff9e4e2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: ZfeSfkk3iBf6Gg7Ifj8u/jpWm7kd5MHu26xkn7UulNgGR+t+kxfKCYwK9AXTUyyIeszTDsYAsUBZ4XIRau/by93xkqSDQaURi26ENxFrEt4paanmsgD9Q8I3tcqhXtteO35iNz3t6CNO2rCEd91y3aUrXN0grC/rBs4RK7oV3Vtort7vBsFmYrXAGaYnCqj8+BGaGMXWoDEEbsNY6k+H+F6FLMd0o77ud3zpQKb7/y3uaBKQCo2vEeHA5FncmZG0NGMVNuH/VU56rkXb7WgREOIxoQyPVzc6fpUbogEfK/N+KC0gKPMmPQbwH+3QYoakYhAxlbXhkKVXScz6XqsJGdVr/IBoL+eCmTIPWafSrcCyOemDVHV1DwpXN1W224B9VCOtGBlxTuqMSBlfbAIk54WvwhlcEIfB2MYvYQ7LJ1Js+pwi4hOmHs+ZHT0x/fzOJ+fdEQr/hpvWELEkm8hmb99DVTBuDanTo6BO241jSj5dkDORvL85d7kmHFFAZkyUaAyveuKcdAQ18UViB/1Hc4Jg4Lb9P2opjveq48WEHT/MXo7XebHYVPb/KcpNmCAWcvMOGe/Y2TVpurnesxyC1Vk9+rNBMNfiUwY4N2Fs8rT8Fn5lPq3s/FlYsYbAMTdTErrgVGddIh41iwYzwGN1g096sTTxH5g5/x05akBZL9gg3GCQSwWWmBI+5UudsnZp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QXBtZ9KSwJbv+UpoILDN1FHatNNjQcOkzO2YvMeXyh6TYhSsNiVXdNeSEvbUD6ZNGCcmKAhyYnfcQ6OklSCNm2hOJI4UZnjXXeve0RLQYfdyfliisSijqqbYoXOhKQJL+p4f3syRFYr2oatzpm/j4/D90SC5cjEL7P6H2FVMUKFmw7p7BBsS7Um7+n3GECo2su9q+Ma1u5rAXn7RkdSoLBFEJ+4E/AFPLHxd7ujh8EqfXvf9O9kTTjbtlJht9++masRZCg3e5vTG1UmPpQ99ysxtvmMEnk21tKdS4JF4Gppu5ZxqbxxVz/OwjnPLNAfPNcAa+JTK5rly+ErCsvmJkHxZK0wL5Xi8I7f6RmMUDjn3H7qTKLpusQieembhT4Sj45eUfwYR8kgZA+u9FWXoMr03ha9PSdLrc/H0K8y1IFZrvGjbDJphppAr5sTPY4+e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:07:31.4009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fd1e0d-ffd6-49a7-4d4c-08deff9e4e2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8224
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

From: Mukul Joshi <mukul.joshi@amd.com>

Unmap the KIQ pipe during driver unload so stale pointers do
not carry over to the next driver load.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Michael Chen <michael.chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 4df3f0204dbbe..19bbf70e89b78 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -1735,6 +1735,34 @@ static void mes_v12_1_kiq_dequeue_sched(struct amdgpu_device *adev,
 	adev->mes.ring[MES_PIPE_INST(xcc_id, 0)].sched.ready = false;
 }
 
+static void mes_v12_1_kiq_dequeue(struct amdgpu_device *adev, int xcc_id)
+{
+	int i;
+
+	mutex_lock(&adev->srbm_mutex);
+	soc_v1_0_grbm_select(adev, 3, AMDGPU_MES_KIQ_PIPE, 0, 0,
+			     GET_INST(GC, xcc_id));
+
+	/* disable the queue if it's active */
+	if (RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_ACTIVE) & 1) {
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_DEQUEUE_REQUEST, 1);
+		for (i = 0; i < adev->usec_timeout; i++) {
+			if (!(RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_ACTIVE) & 1))
+				break;
+			udelay(1);
+		}
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_DEQUEUE_REQUEST, 0);
+	}
+
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_DOORBELL_CONTROL, 0);
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_WPTR_LO, 0);
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_WPTR_HI, 0);
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_RPTR, 0);
+
+	soc_v1_0_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void mes_v12_1_kiq_setting(struct amdgpu_ring *ring, int xcc_id)
 {
 	uint32_t tmp;
@@ -1835,6 +1863,10 @@ static int mes_v12_1_kiq_hw_fini(struct amdgpu_device *adev, uint32_t xcc_id)
 		adev->mes.ring[inst].sched.ready = false;
 	}
 
+	/* dequeue KIQ HQD on unbind to clear stale rptr/wptr on rebind */
+	if (!amdgpu_in_reset(adev) && !adev->in_suspend)
+		mes_v12_1_kiq_dequeue(adev, xcc_id);
+
 	mes_v12_1_enable(adev, false, xcc_id);
 
 	return 0;
-- 
2.55.0

