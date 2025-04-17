Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5EFC369B2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 14:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26A3E10EB47;
	Thu, 17 Apr 2025 14:52:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2FFZlQV8";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE39E10EB39
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 14:52:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKQAzo8wQ66LxIfR+CrmgI6lYIl/1xmMMTmI427Y5KkiPGrCePBwJD8pWs/maovtCqKDV6+XgceX6lerJ9WrQMQvkuXLN6nItp8+jKMMxKZPXZCBObPXyZDr0G81WGN1ZKIquvaGYsDhl7KmOx//WhbbO5aE6oW+VwSMsE9u4EkIKSauuxpc4PWDZ8twWO2KQHSqMConN1nZFIxQyCe7BgSlNTH0AjG1PfZg701c5/VmN04pRsj269XMYeaFz9+xuWXMqrHCljJ7+rHQQQG0Rg0Mks4hRod3SEIbhc58jd9gBhFz3uaic+oKiNihwTfAu3e+yRMbcZXDd31915kuiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8poXWroIoAbzQnLTffM2jfM6EPlhzcspAtxwMRBmZdU=;
 b=WBqT7wDUYQblFDqZpq0JG1tMe3rlYEIVHsqUqVSHbbGJL5D8F32Pduw+wIEDVLp6/zstdKcWBBjbDLG6aEtALJKjZAs0cxVMZUNittLTmTkpqmq56yR9RD+uP7czHlGHuVxUaiRU8Bpk0e/IHZFx7KshzKd8YA7AOYdPWtz1ig9Na5Fnr010W8kGbTpl2QX+2uxCfOnS1Zji+CdKsfiuS7Le6ufAH8u3KZE0wSfc7/twgzCEJzRF0gUI7SMsLCP/AEvLJ4EYAjVZQcD4SBzMdlslResBuM1jcqsTPxfK87QxC5n52J0bzBdgTIYUgAyoNdPu+3l3+fm2/KAmKLxWuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8poXWroIoAbzQnLTffM2jfM6EPlhzcspAtxwMRBmZdU=;
 b=2FFZlQV8f0r9rlZ1hmLzcqKPgpHVNfF+TvSnDiFq4pqxMyKsRkQVkxr/Wnqd0CnqDW0kG+bRTt3HY4bsLQbNQdCEXQOFRsNxpMWPCqN9kVdIV/53tbPcTo15t4T1Nre6PykrfjCp4vNZz4ElXR5h6/jZhcDhhsU8KdKZoEBQ8M4=
Received: from SJ0PR03CA0374.namprd03.prod.outlook.com (2603:10b6:a03:3a1::19)
 by PH7PR12MB7308.namprd12.prod.outlook.com (2603:10b6:510:20c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 14:52:18 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::ef) by SJ0PR03CA0374.outlook.office365.com
 (2603:10b6:a03:3a1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Thu,
 17 Apr 2025 14:52:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 14:52:17 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 09:52:15 -0500
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <yang.su2@amd.com>, <hao.zhou@amd.com>,
 <asher.song@amd.com>, <pak.lui@amd.com>
Subject: [PATCH v3 1/4] drm/amdgpu: Use allowed_domains for pinning dmabufs
Date: Thu, 17 Apr 2025 10:51:48 -0400
Message-ID: <20250417145151.1275415-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|PH7PR12MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c73fae6-9177-458e-707a-08dd7dbf72ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDBadm5GUm8zSDkvZ0VxNS9DTGt5QlFYUnNZU3FxdkUzVFp4L0hNdkNudHF4?=
 =?utf-8?B?OHdxMm1GTzIyRXpuY0FRb2E5ZWxEbzdhMFgxRWJ1S0UzRFlJNzhaWXJhSWNH?=
 =?utf-8?B?eGVqQWF4aFNYTVhmRVg3cVEzUFhLajlrQzdYeG1idGtQTXlZeXBqS1dROTkv?=
 =?utf-8?B?ZzJTRG5rMGllSGtpMWRFbk85SEhtZDRCc2hhYURKTXpoSmE2aHl5R0U5UTdy?=
 =?utf-8?B?UkV5NHZlWHZveFkvMHhYMXVPWnpkK2Jjd2ZNbU9WQ3pLcDJPOFhtK1JlVGti?=
 =?utf-8?B?alJCSmdnbUZxWnkvMTNPQmdaQmpBMTJva2xXNkJzSThZTmpaVGd6b2VWaktH?=
 =?utf-8?B?ZzNBL2RMTWFsanBVaXlRc2hnSElRU0E1bTcydXhnSVV5b1JFRGxYT3p3Ym5G?=
 =?utf-8?B?Qi9lRHZlaTZuQ0FNM3VETDJ6Y0RiMmV1YUpyaHVtekdIN2NROHhZNmpIa0JZ?=
 =?utf-8?B?b24yRXdERjRnaEUwQjEzR2ZjVGVyRTVIRXVweFdHM3FLOGRpKzlRRGZWVUxG?=
 =?utf-8?B?cFRUdytrTS91ZVVtTjRpUlcvOVJ4bGRQSVJOMENVMFpVdDNNdENrRXc2b2ZW?=
 =?utf-8?B?L2VlcnFnQWZubVV3bThoRWtIekE1dlU0bUFwWGNSNzhLUnAyRUxFTFJWdkVK?=
 =?utf-8?B?SWF3V2I5UlBoYmJ1VUtRMmplUDVKZmVqSHJraldNRFN1cUJHTHZIeDhQKytD?=
 =?utf-8?B?c3puSVVFdjMxZ29zbVRBNWpwMjRjTlV0L1QwVWdodS9YQWJBR1ltQ0hOQ2pJ?=
 =?utf-8?B?aDNIUCs2TWdoTHV5bUcwSEliRW1nS0lobCtwcmNwY3hJT3Fwd0NNT3hRMTk4?=
 =?utf-8?B?ZGhUWGFCbnI4ZEJZR2l1TjhxUHoyMmR3dEc3NmRobjZkcHU3Z2hRZHRUanlB?=
 =?utf-8?B?TFBOUDc3TzAzakhBT0dBUU9PNFNtK0hkSGVhQkR0S0lYOXdHVk9naTExU0Rx?=
 =?utf-8?B?RWxxZk82dGlKVkgzYjZneGR6ZE1PeVVrTys0cXRRUHJjYkdSQmtwY0JZY2dR?=
 =?utf-8?B?Y0dkWCsxSGVKYmNpc3hmd2QwbXRXQjZ1V1BLRHNza3hGclJ3Q0FrRW1udUJE?=
 =?utf-8?B?bE5wWTJGRFFiTldabGdwRkVyd3kwT0dXeUJaL09kMXViWTBtWnJlNndaSWdo?=
 =?utf-8?B?UnJEUVJ6ZE12RU5VaTJobHZucHdTTVdGMThETUVQYU52Z0k3U0dTam5IRHFj?=
 =?utf-8?B?TEFqUlkwdUUzSHgxL1pmMEpQSXdyVmVjQVJzN3RZdnkwb1hFQUtwWVpNd0VY?=
 =?utf-8?B?TWp3SWNKZUVEQ0lMZWVQTU5TNm9aR3huWHRPV01UZlkyRFF1dU5ldllrYUdT?=
 =?utf-8?B?NHBJR3QzcGIxTzdjVHc2cTNST3RFLzNIenBiMSt5UXcwVDE5NTVhaGtxQ3hl?=
 =?utf-8?B?ZCtsMG9CdFM1ZjZSdjJVanR5ZDBreDBhUmtFZmwwZW5ROUlxNFYvWHQxZUNt?=
 =?utf-8?B?YjhoejBUM1pyMjFSaVpORUw3RFVNTWgwTGpUNW9sdzBnZHlZSEFRMkkzdExG?=
 =?utf-8?B?czlOeDlITHBQZW1SbUxMd29TWER4TWd3R09lMTR6dlBZYW5pbjROZGJWWHo1?=
 =?utf-8?B?UHVvcmNWdFlNRGtDSEFCbUdFWnk1NzZDWHRUREUvRFVnRkNmM1dsUTZJeHVl?=
 =?utf-8?B?NXd3TGFrSlZSejhZYncvbHZ2ZHAxSTZCT3VRcFI1ZUJ3OHd5dkpXclF4QnRm?=
 =?utf-8?B?dGYrbWJMR05aK0NTaEZGS1hmWDV0Q0ZqNG16R08xa3RxTW1pYkJ0OEhJb0Fh?=
 =?utf-8?B?UjQzM01MeHRwSVdXTGRzd0Q5OEpQZCszTDY3bFVwVGRsUDE4aFB1VHN5bWRU?=
 =?utf-8?B?R056dGxLWUFsNVRzV05naUhpcHc1b0pYYUc5ZU43RkFXK3I4QmtkUGJOZDZX?=
 =?utf-8?B?c3VBUm04dFhCemFSZzFXNzFPUklzZHdzcGdtWjNHMlYzQjJPZjc4emU4aGJR?=
 =?utf-8?B?MjBMWXdFUHlPRXV4cTNjU3dCWllmVmNtWGhyTE54TnNmcVZSSVBISzJDbUZX?=
 =?utf-8?B?K0RGZmRnSFlPK01kTG1sMDBGV0E3TXhYQlBNS095SUt1K01VVDhqai9KWTRC?=
 =?utf-8?Q?Qp/Fxr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 14:52:17.5264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c73fae6-9177-458e-707a-08dd7dbf72ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7308
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

When determining the domains for pinning DMABufs, filter allowed_domains
and fail with a warning if VRAM is forbidden and GTT is not an allowed
domain.

Fixes: b0dd8c4879ef ("drm/amdgpu: allow pinning DMA-bufs into VRAM if all importers can do P2P")
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 667080cc9ae1..0446586bd5a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -77,7 +77,7 @@ static int amdgpu_dma_buf_pin(struct dma_buf_attachment *attach)
 {
 	struct dma_buf *dmabuf = attach->dmabuf;
 	struct amdgpu_bo *bo = gem_to_amdgpu_bo(dmabuf->priv);
-	u32 domains = bo->preferred_domains;
+	u32 domains = bo->allowed_domains;
 
 	dma_resv_assert_held(dmabuf->resv);
 
@@ -93,6 +93,9 @@ static int amdgpu_dma_buf_pin(struct dma_buf_attachment *attach)
 	if (domains & AMDGPU_GEM_DOMAIN_VRAM)
 		bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 
+	if (WARN_ON(!domains))
+		return -EINVAL;
+
 	return amdgpu_bo_pin(bo, domains);
 }
 
-- 
2.34.1

