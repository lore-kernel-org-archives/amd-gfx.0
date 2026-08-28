Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC44C61DBD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 04:15:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5601C10F232;
	Fri, 28 Aug 2026 04:15:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TfX5h/e/";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013049.outbound.protection.outlook.com
 [40.93.201.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F05D10E454
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 04:15:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9k+SYQ7v1I/kFkB0CFXKaokA3KLuG/0ayXeZ7JJ1uhJ6lOEfy6WZwCQ6nPeXZ/e4v/+M4gtQaEZwvcijSMq47FYRRLSshldJV9SIzMPwuZ831gqcCZyL/ZCrHeije5qo2EW/5/G1zpLqRhx0v2Ax47pBnBAWKo4S+txv4IXQXRgiMf9RuHRMAHvc4kuZdgOrGjEWD3fc8DXSA7jNOx85jyMc3Ds8OOHDZhoWL5FC0+94luXNCmyTYj5A4L4hmZu9ROc6Bc+Ctezw2wzFsYlfH8x6K1uQ1zGs5ef7aaQ8WRBrgaX/SIPSKU4madR2/2G8nmoyTtuANN2vV33ZstfBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBXbzQZbVVwobsjnBmaTn1aXhc5UjkfdQHUJUXU/jsk=;
 b=tc+FvDWox3g2VJRKROk1Lkqkh/gOSSknW6W0KuUA8tymBbVlL+qqC8cG2Tx3oYu+gCjmv/d/dcIL2hYlc9W2NXp6kPJ4Kxi/cHfFyKgExDHNjlkIg9r7Zj5+Jeij/W1gYLMPZyyy7F1sVswBfN5nGuZNdBuCkHVhq2RRHAjO1oA3W2SxnB6IH3Fkxt+xTZtqWHOUqiBqdKEOaHYE9+kdeps7Whs3uZP3IjpQ/urRO6xIzwJEny+nTMLGgQJloavXXfNpVCZkUIgjkROywRl34mIp3EF9v2nzebh//xex6HUC7F66COvu2caVprkHtDflOHKXczmtCcJU+vSrTPy7TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBXbzQZbVVwobsjnBmaTn1aXhc5UjkfdQHUJUXU/jsk=;
 b=TfX5h/e/rXHrLCaTCqaEGfVn5vEy1M+gjWatqXk6f+ok+RI5jDB0BjtCJsGbsnoL3ey/F7dteom1wqO3rxSe4IB/61ugwO33k8l06P/H2bc3D57JtX+uedmmduBA6xRwHcRl8Nqav9w3eYcv94c0WTExjDi/wIvVovXGwFaE1ds=
Received: from BN9PR03CA0380.namprd03.prod.outlook.com (2603:10b6:408:f7::25)
 by CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 04:15:51 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:408:f7:cafe::57) by BN9PR03CA0380.outlook.office365.com
 (2603:10b6:408:f7::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Fri,
 28 Aug 2026 04:15:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 28 Aug 2026 04:15:51 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 23:15:51 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 23:15:50 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 27 Aug 2026 23:15:49 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 05/10] drm/amdgpu/sdma6: implement update_mqd
Date: Fri, 28 Aug 2026 12:15:11 +0800
Message-ID: <20260828041537.3464782-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260828041537.3464782-1-Jesse.Zhang@amd.com>
References: <20260828041537.3464782-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|CH3PR12MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 0498fc4f-5c15-46db-9862-08df04bb0be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0Cc58YRyQe6+mxv5MdME7T5ar295t5KYZqYeoCZZtsAsODLGvF8LMDjtNlnkm0Xs9G6zNc8A6OlSLo3ZPO+k4edHWfkalCQ7ow2n+jpyz0qSkhLU7BHfuaXU8j9r/JIHC2tQx3wSzgHmdiV6FuQSt41TcGjazFxF9HO5476oKUARiE+vO/+gv6wwDAXkZWA1EdRaLx8iOUTMp3YVF7+2X9QvQW6A0wu9vc0zaFeDy1JIyxKMCKIceq4SWKsF+Z9PDWhSr6h0s5Fbi7DZDUeTWKn8w7TxM+OvG7PpSqhDDyTyZQGlpX0fQ7miS30nNUh1KYOOMUjb8h9N7hL9J/eDQHSFpwcAOS3EvEiEV3q889gTHYEpnE5W25Tjzn8nQ8EVB+giiEecighetXs+P8IGKjHNM3FnNyyC25kCCn4B6sW+CntWN3Jcc85vasIsPXR/2NA6/7W6oy4HRHK+6r2ahpI1fdvcXVFuYDiOd9w4rdepxh3dRThLub698esHmkF/KKjqPfkQjUjqgiJeOPrlJmj2hWhfG7hVygXPv8MXwMlK5vyT1+iFdwhjd2vofoy7vxmWlwEMC0CAOWciMSwgCZbj+vRSokdULdghNRXjla2T8Pi0g/FcmOMK92KmvKrc/hwDfFXHOptOa/BljJ/jn/oucK9ReSNuLr+cEP8IPtVtkQEXD+CiMzBVI6cgsRQcrjlxYRyO93scMeXawfv8gw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oYrnZY2zI+ukGmfwQbW3DkJISQHzG/AXXOwYF1M3jzlkw+jnRLgTTLZo+Q1Hce5rh4jOhvFPvXCv+awsn+uAcPcEMhekHq9wUGMyI9lFPmGKHeaxS/27avf1W1dIniW+tWaokqP8rNVX0bS6ObSDg8N8H+Bzp6VBSAced8SmRrClss1lTRRuXf0dOoSkFa9HEfVyU/g1VGT5bueUwXDei85B4e5o/bS2J8rM+NY8a6yKWxHrwHT0/hi2JZGk2S6FgUe55dzeRQW6hTQZ8RG7tvg20eTsZomzDLU1WH9QCzOgIU87sCjwgbUkIPNnHrsIIKTbsPSB9PkZZ0Sdm27biexLsPl+CSqEYaSC9Zg0bjaolJB+uD9vB/lXvrss1MRshLtoqSqTWDhdAPa7pmdwaat1FYV9jS6z8iAU6cqVmiPtsdnFEhkBpYW3rDa0Y/Lu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 04:15:51.4694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0498fc4f-5c15-46db-9862-08df04bb0be9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7763
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
Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
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

