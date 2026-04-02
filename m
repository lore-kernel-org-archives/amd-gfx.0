Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE09D6AAF8
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2026 18:34:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3F7710F282;
	Thu,  2 Apr 2026 18:34:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gXRGpQuD";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AA0F10F2FE
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2026 18:34:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFdEg9SQwyI7YkmIVpM6NC0QtGfw58YnblEdD0YAr43GBwSdhEAy5VU8MRuXKMQXW8cyl919oia0TfzL1WtgdVdBGT2baX36vMgoVcjmjYYiHPSj4H9xxT9WYwAJNN9oz3TZJXxpkaU87UpHB6YFgpn4BM2pYZFhps083KHLmG1fzVoKnXlhf1EsTP3AM16/acuzHVbqc+xTv7vyJZfvMQILUolt2aAUpi6deq1c/6clRCyBQUbJ7m3N+fohTAUMntScouin08dlQzIdBB3uqUGDGHr6SIg1a5fuaZ9mfCeoZh4Luoke/OJ2jKUI4HD8R2HRIYXCJIrEJHTf9DMbCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVItx3wJhseW++9TaM30DSvHfx993oGF06l9KjICJRE=;
 b=B00O0F0ZfHy9bL1asHqX2LNs4AAeJ51Bmk6kNK9BGyyWZa52pjcxTTyOC0grk4+BtwedclF2PXYqJ/ktPR2o4EXgNbBOo1JHV2ELHP2Pvh2/dWF1TJU6Jb3fIRzV77Fkg5TL7CtwbdMFQ+0CBz8i2UL3hnblPfLbxGGZkbi00ghkx81DR74lMeC8ER6tt+kpvazr/AFRfE7aef1UGIiLlmfiSqdzvpnDcI+VHvsDkAekjK8U/bretJ8/TI1nCCb9REMhW7ZPUwlxFRKLPh1BaJQJYTq6qbKJzkAQlCXSfrqZ/iztmNHV3QBijDhQtVaSu6pqcKpsSa9BMP1xg6W+1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVItx3wJhseW++9TaM30DSvHfx993oGF06l9KjICJRE=;
 b=gXRGpQuDRQXgiPq1zbByIdbrBTtNQudphKfu75f150pOr9zm0DcHF2EeJIVBaPOYOv5TYPYgQFaAWTybUPIKuMZ4RbT3djTO67VGvECj/iIq6g+6H9dj1x/CD80TB5CckZ4fWnKBwG1Wb0VBcVASiG3GKqsJeYDvOuAbmViyPWs=
Received: from PH8P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::21)
 by DS0PR12MB999081.namprd12.prod.outlook.com (2603:10b6:8:2ff::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 18:34:18 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::a0) by PH8P223CA0028.outlook.office365.com
 (2603:10b6:510:2db::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 18:34:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 18:34:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 2 Apr
 2026 13:34:09 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Apr
 2026 13:34:08 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 13:34:07 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 12/22] drm/amd/display: Correct MALL parameters for DCN42 soc
 bb
Date: Thu, 2 Apr 2026 14:33:04 -0400
Message-ID: <20260402183314.1388755-13-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402183314.1388755-1-Roman.Li@amd.com>
References: <20260402183314.1388755-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|DS0PR12MB999081:EE_
X-MS-Office365-Filtering-Correlation-Id: 496bf3ff-d044-43e3-abd0-08de90e6728d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|30052699003|36860700016|376014|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VgrfXgwBU+w3TEjJdXwxyj863oVM0N1k/xjkuA1BdfeXy2Bu4iKGVl67Mxypk+BvNo2fuI0b5j1suUS0Z2k3IAZRf85klgqEYSEoFJz893pgHTbOmjDqKiUpFSJzCDcEgIu1pI3QQDQTGLK+wAvEothrqAy3z4g18xosQiUrbSOZNflJs/3uzgjVES6x6q16yonq3E2Nhk1pQXPXgYDhHyscgGNk3fK3buB3K0kGhlpBYB77P/J49Lv1Q0ERrTRUETX8OHjv71U3dE/d9BTPymbwr+vm/6rzOXMEcXxL+7TQow8zAegFQn/GBJGZswRpvqA2CM/us9YbNFRjoNMS/2jUIYvn26xdVEx4BJrIXHLJ5+D47+wsvJQ1TXGFZMGvntRERY845pjV3JTVWlsl9Zf+PuK0Ej3E1QEEt1rx/d5Ml1hIMlu6Y99SsgejHinNTXSh9rNuvj7gcWoz6DBltaHdRjG3f9dirMor0DQifdloODuZIom+HVSXOxoaDhyAvkpwvpE6+nQIapPWZ1snVTiS9IBrq18F3w8+ormzXo2xxYW/oxDhHku1rafnfV3YCD1MkNeVEvkwAxeDSeJUx3juBW2uDy/Xps/C0BpPotGY0HyjYAtyxE08DcZbnenCqOBio6+jJXhI/6d80aUc9GvjWN1K4h2ju5JEzKCKFqV1a0u/lN41Fn0WNSGZQnnx+/f4K98DQhbm0r+qf8f7rCLMDVzTpUf6QcA/PulKgJlGmjrdECOFUPrK0GlcN+xJrbFyELN9B+iZUV7RkLDgMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(30052699003)(36860700016)(376014)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o+nwmS+c3uQHif7j6lgyVliZq/ZZxwu+5cvcxQa3EvwBqhTP/8QSsPebDiz0EwmpX9FX/S67pGTtF4kzOb+iMNF2+5i+DUH67FZOb/DMP1ZGhFs2U+Bs8VEjKQqgUiVDwDQ4+v6u/s9wQEAPZW9HzRAlxuFWt9FP+W13ZXb7eoylVo/tqQTJmkNZ5ZJ9mJEgZrlft93iM2XOy/VCoaOoMJfz7whiNy2FT6YxgCp8V3Vqd5IsfVGfqyQRG95n35LXskwXa7tJF8+vPR0hSgmvgmLRU7mwIFxxHgVS7Rv3BBUkD4/X2QdtN7gI5VjIVOZbX2vmmZV2mXygL85YAaJdgq+3I7uWhmV8fn0pvZ4187QG21RoGr4e3OyXb5+NaRv2/MkeHiMcJhs1gSlx+Ce5P4gBB4ELIbg1zTIwBADNjZ/SjuW9tiVSmZRj/OTj22A3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:34:17.0228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 496bf3ff-d044-43e3-abd0-08de90e6728d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999081
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why & How]
The MALL and DCC parameters were copied and pasted from a previous ASIC
but the correct value per HW specification should all be 0.

If not correct this can impact urgent bandwidth calculation and PMO.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
index deea5608c08e..ccdd9fd1e1bd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
@@ -203,7 +203,7 @@ static const struct dml2_soc_bb dml2_socbb_dcn42 = {
 	.xtalclk_mhz = 24,
 	.pcie_refclk_mhz = 100,
 	.dchub_refclk_mhz = 50,
-	.mall_allocated_for_dcn_mbytes = 64,
+	.mall_allocated_for_dcn_mbytes = 0,
 	.max_outstanding_reqs = 256,
 	.fabric_datapath_to_dcn_data_return_bytes = 32,
 	.return_bus_width_bytes = 64,
-- 
2.34.1

