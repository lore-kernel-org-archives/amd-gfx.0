Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CFBC982DE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 07:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88BA310E035;
	Mon, 21 Sep 2026 07:53:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CZf7Za2B";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFAE310E035
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 07:53:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OcQITPjmwZv03r/w26taT/QiR4np2gNf7GplGTSvHXxZAlMza/Y6SBISzYzI2JGfyG9hWmhJFl1ztlV3DUqTl3IAdozNqzLKqJCKxa3j0QLMflYNSyZ+UW3U1g9F/W9wXzzjwn0glsOKv+TYxSAQG4tDEXs+4+JYPwAX/iRNw1b7MXIPiYkcv4e/TacVLlTqWDBZb2QpeePNSwAH0RiBgNQDz8oWTlRKx0vd5xKtdMInJxC1uQ4+v8vvWKszkK0aK9VnMK775u/0ETt/OX1lyFy4OzaFuFcbELrgDLLIPaJ0QNZ78ILT7iMMArJRYlOBqHWqjXdtCcwFnj2ZlzlukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8beiQ59cPOraadxtNBT/uS/vd5CWB7Je46ponR8GaQ8=;
 b=ph4vY7mvJnCfjkXC8ZaeNA8TkFTRfwyoX1wNkj4QrSM/eoTAJwnGTqYU2WnsSCp3HgWu9ojyJqc9Dht7hW41kgMbWvcbe2u9Jvi7ilQHr0kSka1bghhK5ZPpEHSmt63uu1bmfRJDU7EGNVAJH/G2eprbHWUpDeheoXszc5zf2uWIM86rrKHPx5HtgGdM5pOhIVKd8xyX3n741dg79SxAHn+Jc4ZbDe1tkm+lIyPpM9+fmuHpU2O33nnxZrnjpSRv94h2/MdfSzrCS9UqwBgcf5L2EFNpEm+fZA8gIfCAvftCPHjAOxoByT9vyQrgxLsY4vSEOidXMhB7zikSSCNdzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8beiQ59cPOraadxtNBT/uS/vd5CWB7Je46ponR8GaQ8=;
 b=CZf7Za2BbhPhTPk2HdA/RMn6qu3MECh39JnY/IzyCLvcIvZlV7zqy9vPxPIww94W4GpFkBklMwyw3tVjmSCGx1sKDlTXfaz6SrcqHjkOky0sNxmxqXbLE143WIBprDyn4EJv2p0luSa2gW7Uk5ON4Jnxq6elZnZdAx9UYbT2yuk=
Received: from SJ0P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::6)
 by LV3PR12MB9117.namprd12.prod.outlook.com (2603:10b6:408:195::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Mon, 21 Sep
 2026 07:53:31 +0000
Received: from BY1PEPF0002695B.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::3f) by SJ0P220CA0030.outlook.office365.com
 (2603:10b6:a03:41b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 07:53:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0002695B.mail.protection.outlook.com (10.167.244.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 07:53:30 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 02:53:28 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 02:53:26 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <Prike.Liang@amd.com>, <mnovales@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 01/21] drm/amdgpu/gfx: add a detect_hung_queue callback
Date: Mon, 21 Sep 2026 15:51:08 +0800
Message-ID: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695B:EE_|LV3PR12MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: de35ac45-c4c3-42e3-d25b-08df17b56dc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: a7ZLkcN3EPZOCB3afWH58SNrLmGa6x2XdNtAIQHtU17jz7AivCsW32iyre9GCDnxtuHFKqCtVZqyCe+DhaglZM3V+Gqsaz8RgZlKrgRqoh1MwJrUQFmO7ySsN2HVhZdKNVasaHDRsZe6/onyXzdx9I6lX6VeYimXsOX/zBCXnieXPPpxf1wN9TMVty6WmTcA/HRIO7vow9GLiKTyCGy+S9+wLiJBhxsnYZM1VoYyQFKxPZs5TZ175yE40SUHa4bMaRQGhCGCSC7H79ZW4RakHlnMKEa7hm3O2kvGfOFTV9rp3vukqvSsVtZOS+8U2khzwV6eMs1ZwRM+FsHsMtgnsn2vXjzgXJyM2e/uLY5LtJ4h/wOiUkpual5aK5ih8s3cRMBNr/gpi79A/8Y9u/kAHz7Tv7pEjKFDjxYHCEwE5bVB3i8/UONyZAtM7GtMzjGi+XfKhsF2XBP5H6pxa4JRyiGrbwhW8N9nir9m8KvT0Eo4I8SkXeHDHSWIwtE1HHByAJAAyRb05vA/lKqmz4ptrwtBtaWd+uDOtf8K3jfNhlF0O41q6tPblrhpUYvGX2gdZCGkPKHR13S1sG0YwIvnTe3qmm8Suv/6P+X/P2U3qi4ReuBed+2EUb+d6Is4j8V9De7Hwkxhvk9DD/AMLLFyMSZrfZOaLb7zalUl5TY8owo/bi3m8ouEJ2JyGSG3iXUZeSrWK4l9+rO8Ipeg1y4A5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x3Y+bWL4Qkxm9nFwvTFwUM4oUru61KTEQcO1vQyDKgVYn4oI80H/e3jCOxMU0wpwo0DIZ7p6S/xJsSLemoUWHrU+kpNtTN+nkNyQ9oawQOjHS9maKrknvlynXLw3steFPh+8Jw10QMcAJeIWdvsI7bRbPKJcQZBVDEdZODfu6FMgdxmhXZLBHI2WEjrn1Xpzs/2RqJnAxCic6wPyapZNp569KsUzox+Db+og9+tSO0kZ2iLSWJeI0PVFC136kQxQF1A7aHEKbo7+rvQruPbV8zeORN86B/qfbXbXQRiHvDsWH2j41ldmP8B9txRSYPDlcATadc/zD4gVSukoO2y9apMC1aiotkQVEwMRbPSBfmh4BDWP19UMAbanUY283tfhYpJs9t8r1EhSKuQ5uD/xyLPhhcpXt/mK2NBnhuZEA6HzgXeM9Rxc3zFRe+I6pQAX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:53:30.7018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de35ac45-c4c3-42e3-d25b-08df17b56dc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0002695B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9117
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

Allow GFX recovery to resolve a doorbell to an HQD (ME, pipe, queue)
without querying a stalled MES scheduler.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index f5fb2e585e8a..a158b7f71b2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -373,6 +373,9 @@ struct amdgpu_gfx_funcs {
 	int (*get_xccs_per_xcp)(struct amdgpu_device *adev);
 	void (*get_hdp_flush_mask)(struct amdgpu_ring *ring,
 				uint32_t *ref_and_mask, uint32_t *reg_mem_engine);
+	/* find the gfx HQD slot (me/pipe/queue) for a doorbell */
+	bool (*detect_hung_queue)(struct amdgpu_device *adev, u32 doorbell_index,
+				  u32 *me, u32 *pipe, u32 *queue);
 };
 
 struct sq_work {
-- 
2.49.0

