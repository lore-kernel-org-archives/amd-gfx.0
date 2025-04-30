Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E43C3ABAA
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 02:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C54D10E692;
	Wed, 30 Apr 2025 02:41:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wgSgvo9L";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E249D10E268
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 02:41:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOuigLlxC0/e4YMG6CtSgBtZrliIF7CBIX56qa1DnBEf0qVKaB5xcAqoWsO+NBko8fn6JI+CupXwI9/lH1A/+6qrNadeyb1DWexezZzjRpyLHrXQKephGqNA4JAuprZd/LX8CbkwvZfvPYmg0RIKagxPQmhutNgVUNgOc6+xTw6eYdIvqNMrJrcJXipLfBHOOQRIdY9jbOdODewhuustRkflwlq2qELZQPswJ9OUZ9b0kLwrRrCGQKhWMwqGodErwnQZvc3t0P7UnF1CEg1NKxAmbDIMgvY7KgKNV7mZvFcIP4fX0j1lzxl6kl7djq+6EQmLUNf/OsU4a0sZe706MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67FSSY/jC+9zNnqxrP7cfJIkv3bTUSceHRYhCAmJkRY=;
 b=LVzzAwEajH+7NFvZj641Yth3INqTvlgYkJwOzvrTFt4qc6K/K9e9kF4dzDRCgBq9Q6MDY0NJvwugv0GwzY2rHS2liJRxGgbABgxIVVABZPMYVL6BBUcYceo7gMoME8Pf8y0cnqqQLhblH/+KjOGqUtP9fle5Zf0ww7VxPOsoOqDHPRLGmGvI/YFzDdysVxlgVnij1sN2Dy7gSmeFaPliWfIrD9EyHSztUvSA/tes9pdSnsHc2XE/3/1SRGsIOyUZAjG+XlpHHjM3MjfNRHzvAhDePZN0CJrpOVLoMglaDze+EhYxqxjT4ny9oQ58Ke4lLvIkSN3ESnU81DTjCKT71g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67FSSY/jC+9zNnqxrP7cfJIkv3bTUSceHRYhCAmJkRY=;
 b=wgSgvo9LszCJtr4yJBCS8ZnOoCgP03wXAuM5RNCkCbpNfAh/alDG0qiWz3sHPN8f3gt1Jh4Ffx2CWC/zXJdn1RqA5vHFLs9F0UVt46pIda6wgR73V69aEbv0gLnGlzuPlgCO97gvOCwOFVKCfueCv4IxLCbHLTugHrIL7Tp3YLE=
Received: from BN0PR04CA0059.namprd04.prod.outlook.com (2603:10b6:408:e8::34)
 by IA1PR12MB7614.namprd12.prod.outlook.com (2603:10b6:208:429::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Wed, 30 Apr
 2025 02:41:11 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::88) by BN0PR04CA0059.outlook.office365.com
 (2603:10b6:408:e8::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Wed,
 30 Apr 2025 02:41:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 02:41:10 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Apr
 2025 21:41:07 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH v3 3/5] drm/amdgpu: fix the eviction fence dereference
Date: Wed, 30 Apr 2025 10:40:52 +0800
Message-ID: <20250430024054.4093239-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430024054.4093239-1-Prike.Liang@amd.com>
References: <20250430024054.4093239-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|IA1PR12MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc15367-582f-4abf-8077-08dd87907731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkxxSGlKZEZONC9pc2EvR1dUc0hNUkNUZnNndkc0RTQ3cVEwdjFndlFRK001?=
 =?utf-8?B?T1BEK20zS1FjeElINHIwYXJDeXVHYldvRDFreWZaaXJTcGJrTWQwaHZ6bGJR?=
 =?utf-8?B?bmhCSDQ4OXlzeFdNZWppYVVqL3luUjVrZUZtWU1KRkYvRHk4TFJhQ3BaazNk?=
 =?utf-8?B?eHZpMGtzZHVra3NJUXk0SkFtZGhGSmVGSDlMbkRSZUpVaEtjTlNseDh4QnJz?=
 =?utf-8?B?Z2gzWjZHUkc2cjdTQ2lTVkZhUDhyRmw0VUVhY1JDZ3BUdFNBOGw5d3lUMThv?=
 =?utf-8?B?eC9FeFdsVkdRV0pIYXFhV2ZiM0VGcUdoVms4dUI0dzd1aFlTcC94ZFVteUZn?=
 =?utf-8?B?SEFrR2psOG9US3BIcDNQWTUwUml6MEhhS3orVGxCa05yc1BUQUZGRWNkd2tH?=
 =?utf-8?B?cUNMYmVKbktCV3E1K294c2dVbEtOMXJRVnBteGFSZXpobDVrbnUzVm9OTUFt?=
 =?utf-8?B?cW1ybUVPalUvNWs3a0phY2FKbys2U3dNcmF5ajBqeVp1bm82ZWtobm1FUFJr?=
 =?utf-8?B?aUNGU0IzcEdhbnYxUjUra0dKeXNibVRYdVh3S2M2SUdOZ3JkSzI0VEo0UnJV?=
 =?utf-8?B?am9NNCtsZUlhbC9zck93R0hzZW91K243aytDR2NoeVZFK3o4dVpOWGZCNC9Z?=
 =?utf-8?B?MGJiOXBkUE91Q3hzMHJjOEZYVUlLV2ZocE5wWk9EK1I2bzlLRXY3R2JYYUt4?=
 =?utf-8?B?YnZ5M3p4YkEvYldKelJvd0VzakhWZWgrZmZmMWpSenpIYTFleHpVUmI4cDY1?=
 =?utf-8?B?cHBJTzVNWEMzYXJ6WXpZanJISWxVTHJGSjZnUUYxekZCR2tNa0FXVXIrb3Jq?=
 =?utf-8?B?OEh0R2Z3OTRPZmJWUzIwbGlEMjVaTGxuOVEwaWt4Mk5Ra0FSanE4MyswOHRO?=
 =?utf-8?B?WVlPWXdwV2ZtQ1pMYXZpcWV2UVljbEJRQ2VSblhCMWg1QW9VZjhqdjBPbWlU?=
 =?utf-8?B?ZHh1ZGVqeDNVb29oOWNIYWtWOFZTUE1McENCWTZOamp6SmNtd0lZelZnVncr?=
 =?utf-8?B?TWpWOUUrQVBJazZ0WVhMSlNZQjk2WEJUR2RRY3hDWGhYMmhBWFMyZWRWTUFx?=
 =?utf-8?B?NGg2czA1dmNzWXpDUW5VRXRLZTl6VkhQaWNZSTFHMTFUVGdCTWNrVituR2ZM?=
 =?utf-8?B?RWUzeDZ3bjMzUDRFMFJzMXA1MlliTDhjWlBTcDRiZVcxOExGU2gxMDJHSGlE?=
 =?utf-8?B?SHN1K3VneEZORVJtb3liTEp5b2xueFBmakxSbngxWTVFa2habDEzZ0p1bjUw?=
 =?utf-8?B?MHNuN2NTQmoxRkdaRkovYTl0bjIvVXVlclMwOFBGV1pWNnVpc3YvT1FFNXFq?=
 =?utf-8?B?Q0xuMmQ2TnYrTFhYRmZUazA2clpmR3NzWldhYUhSSXZDSzJPMFhmWFMrQ2Ew?=
 =?utf-8?B?QWRJVTlCRzN3UnVhZ0FpUjVXaFF4R1RtTUxPTFpKSHN4ZGs5b2NpVUhrSDlK?=
 =?utf-8?B?clBnUjM4YTlVZTVEeXIvcUFIbGNUM0J5MFFldkorSis1NUFpT1RrYlB3aXNC?=
 =?utf-8?B?S3lnNHd3bW9xWDBhdVBiaEZNZXhGNFErQ0ExS1RUdDQvOXl4eHZ5bkVwNEU2?=
 =?utf-8?B?cG85dFZqakFwam9DNGRoUXNwUFVNK2lTd0l3VmxnZTYrM3htOFJFYlJKTHZh?=
 =?utf-8?B?WUVyM0xlaHJ1elpMNmhwNUhQR3QrcjJzMHJzdmFseU1aZmhzMDQzL1lub1BJ?=
 =?utf-8?B?VkZxNktha1oxQndZUVFZenNLTjNoUW9UK0RGSnJvMGpZYW5KN3RkTk16dXpH?=
 =?utf-8?B?N21OWEFEMkZvNko5K3c1LzlWVzc3N3pFc3lJRG5iM1NoM0NPQkRpNTBmUmVj?=
 =?utf-8?B?SnQ3T1Azd1N0eVpLUkoyVG1taGQvaURVM1BYUi85SlNaSmZzcWg1S1JidWdo?=
 =?utf-8?B?SnNTQ3BCMEsxMVAyYmpCMk1KN0VhTkdiby9kK3JjY3lLbjQ5QW9iV3Z5dEVl?=
 =?utf-8?B?S2xZbVlGbFc0akpSbm9MbWFoMkZvMzFSb3RDaktvVWNzS0NCQmxpY3Rubkla?=
 =?utf-8?B?ellRa2h6dWp3WlJrc0ZuNGs1STVZU3k5U05vMkNsaGNVZllyWjlVSTFHcjlX?=
 =?utf-8?Q?ZzqNjJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 02:41:10.0820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc15367-582f-4abf-8077-08dd87907731
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7614
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

The dma_resv_add_fence() already refers to the added fence.
So when attaching the evciton fence to the gem bo, it needn't
refer to it anymore.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 6c9b2b43a929..7a5f02ef45a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -189,7 +189,6 @@ void amdgpu_eviction_fence_destroy(struct amdgpu_eviction_fence_mgr *evf_mgr)
 int amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
 				 struct amdgpu_bo *bo)
 {
-	struct dma_fence *ef;
 	struct amdgpu_eviction_fence *ev_fence;
 	struct dma_resv *resv = bo->tbo.base.resv;
 	int ret;
@@ -205,10 +204,8 @@ int amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
 
 	spin_lock(&evf_mgr->ev_fence_lock);
 	ev_fence = evf_mgr->ev_fence;
-	if (ev_fence) {
-		ef = dma_fence_get(&ev_fence->base);
-		dma_resv_add_fence(resv, ef, DMA_RESV_USAGE_BOOKKEEP);
-	}
+	if (ev_fence)
+		dma_resv_add_fence(resv, &ev_fence->base, DMA_RESV_USAGE_BOOKKEEP);
 	spin_unlock(&evf_mgr->ev_fence_lock);
 
 	return 0;
-- 
2.34.1

