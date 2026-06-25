Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CC2CDE00B
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 20:59:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2E8610F37E;
	Thu, 25 Jun 2026 20:59:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rnoz1muM";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013070.outbound.protection.outlook.com
 [40.93.201.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC2A510F37E
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 20:59:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5z0ZwNJKTDodtP9afSzqTHWUv7Rqk+6GbAagiqkz0w/jwmjuC7oyPZkvqTJH6fC6Yx6laMifLkMMsRu/OkO5+30gcqeweNdHVeI2fKPyHFQAYC01YicqRDgsglRGaYykeVn97ymRl/c0aM+60n2/MrF433xnWc1dzP7g/LyaU48Lnvk9xd7C7c6htaUHYk3F63NI4DUPaFI1fdxDNQPA7Y7Mqt5Q9pVsAQYwWLfNk4pouGa4p2L484du72zwwbjROOWRmei1kaV95ZHqrTeIZ8nqySAysoF8xJfnBBS7/kiofmjz5Ao3ZRneSaYu2si7tMSsJDgut+Mafn62vAXQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MC0/6IZ4Pa51KKj7j+2WZYkaSJ6nKHfEAwY/bM6adXI=;
 b=wIf43BrW8dscM74OMo6dfB6mrapXqkhf+iBU3icwSjfPqTcyHPD7qumMmxDZFaz5w0ITqEjzUwmF+qvfJAvT5hf19EDIP9IQDFbmk/PHBzIJoo3Ve7AU5jqybrMBSxd9esK3UGAE7tNZZt7n1uL+5606ZR1PEjKVqkcQpKH0mgnJb+9bpH2vOdDj/YeK3e0rbr9aEGOLcE/Doy1OKQRQTTaf0qTdpHFDk+XX2u7hIM30U+I5Ffb/UI2V9T3iSyWFoQ0WoYD5AGcXw5YiSz8g14/dEJfmtvWP52bgbbFRrS/ItoZ9T4QKC9NvJ9c78XvXMQjQ8jc0bTeZYyJUWFY4Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MC0/6IZ4Pa51KKj7j+2WZYkaSJ6nKHfEAwY/bM6adXI=;
 b=rnoz1muMYCvDxI5iD0DLwcCwSJn/CWQLXrMtXPvYgAwSgE5wTVoRz4rukOh8D6dend565Tvr4bgRJ4E08JT0nsvBBEUlLQcOM7B310Qu2QO/S5rFg1jMSyyPQVwePr0/K43mCBquRW7baQwVP1J+l2PQ2EIcIFPIC1ARr/W4t/g=
Received: from MN2PR07CA0007.namprd07.prod.outlook.com (2603:10b6:208:1a0::17)
 by SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 20:59:30 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::ab) by MN2PR07CA0007.outlook.office365.com
 (2603:10b6:208:1a0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Thu,
 25 Jun 2026 20:59:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 20:59:29 +0000
Received: from bokun-linux (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 15:59:29 -0500
From: Bokun Zhang <Bokun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Bokun Zhang <Bokun.Zhang@amd.com>
Subject: [PATCH 4/4] drm/amd/amdgpu: prevent CPER rsp batch index out of bound
Date: Thu, 25 Jun 2026 20:58:36 +0000
Message-ID: <20260625205836.125081-1-Bokun.Zhang@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 1184a971-1f06-4251-1209-08ded2fca674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: niJ7aqLSLrVA5HE0UEdaCeXyvwE9395Se+gnJ77t7/EKZjU5fqbLQQB9sTu7EITqwkDNwvyxHATGsy1Z3BUhVMsOnmVLktA51m8sUyPv4IFEXRxe5m3NQNADNWhix6PCU/ljaODqQvliLzpDapkquNh25HfpMCf7za57RwW7WCfNJz6+pfsSX8+mlpzHYe1ecrQa8/trVIDaKiTLcGjUKVl3mMTYihXkk3gqJz46ejzpdKsT3nAJQTTJnGeceuKai7DDYThxIo5rUy6rti1pfxlmtonUpn0UnADB2Qy8qlSRFAvicNgNRN7bupDWW0dfkLCZMbvOaFp0rBVmFQgexNzAJeRs4KZzFALWqpCcwAzA+4Kb4rHRhk3ondoFTACwRTKQunJbfR0JoYIrFFZveN7JZBUtEhqCz4U39EkH2Wy1MsoCTJ8sIRWnIpNCzF7DuxLDzfz1aX5GNnz/r3H7XSEW3hWyvmSfVqCoeY4b2WTSYcyddc8pJkRcXiMSYLmzYPXkVp/aull4/dMwbjw68T7U2+byWboqo5BEJB5BFoZMb6fbjIU35jD6KwUXNyoNE9YnrLxFy2KzqRbCG0CTZet1SqPiwzXJtpAsoUqKf9S7GRtvd9gJariRzANOKjlAswY2g4eQL1xFGQlc2UGrQatyQtYOS5r/VK1+N8ICXb1s9MhyHIrn7oxhG7noELb4KLyuFssGfvorFurDTLP/wg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(18002099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TJFvkHel2auJeN85eqCmTIGnRfyc181TIzTaNKMwXbrMD42F462Y9F0002lXA0nyOVwG+ZijgBZBxfAYGe8bybIX1yrYoe+q1PkYJYN1mFlMB5aw24G8AoN49mYQLEK/Vw5zpXDf2JZBeC76fF68j25gP48SyjkHJ/pNO1zqLcuhTNnUk96V/qezDMBaMZWIN49ne2rFevFfXxa+QgnMg2wIeRFhQxagoLRENPP4tAxqiRninVE8x998m/FAZsZpJ48R3UfPWurQjeVAEgu8JBG+w1qlNElXFbnx5fqLaACKH1JAmR1/KJ+OsZU+IQD6quL19wdXEQISY1b6QURVgEYhK/42qwwM/XAG5kXPFCddnbDqR5glL87nKNQ3GfmmxRZVafZhn2lb62gQuCJSEo7+1CBt4pKWUW+ipt1qbwpG792EsOIDZk8kklYghVO3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 20:59:29.8959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1184a971-1f06-4251-1209-08ded2fca674
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991
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

- There is a bug that the host CPER response struct may
  contain bad data so that it will lead to guest side
  memory access out of bound

- Must move the variable to a dedicated variable
  and compare the boundary

Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index c6e7aa6ecb8f..6049b3392a9d 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -204,6 +204,7 @@ static int amdgpu_virt_ras_get_batch_records(struct ras_core_context *ras_core,
 		.batch_num = RAS_CMD_MAX_BATCH_NUM,
 	};
 	struct ras_cmd_batch_trace_record_rsp *rsp = rsp_cache;
+	uint32_t rsp_start_batch_id;
 	struct batch_ras_trace_info *batch;
 	uint32_t trace_num;
 	uint32_t offset;
@@ -220,7 +221,11 @@ static int amdgpu_virt_ras_get_batch_records(struct ras_core_context *ras_core,
 			return -EPIPE;
 	}
 
-	batch = &rsp->batchs[batch_id - rsp->start_batch_id];
+	rsp_start_batch_id = rsp->start_batch_id;
+	if ((batch_id < rsp_start_batch_id) || ((batch_id - rsp_start_batch_id) >= RAS_CMD_MAX_BATCH_NUM))
+		return -ENODATA;
+
+	batch = &rsp->batchs[batch_id - rsp_start_batch_id];
 	if (batch_id != batch->batch_id)
 		return -ENODATA;
 
-- 
2.51.0

