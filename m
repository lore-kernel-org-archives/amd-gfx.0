Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109D7C5B549
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 17:28:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96D3810E6B1;
	Wed, 28 May 2025 17:28:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OfYpoZap";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB4CE10E65E
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 17:28:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WL2E+3UaDKvEZzXgUNbmuw8z6NTPwYGCxz4DT9NuT6mVBtGBzuZj4d6/+TUZYH0pVDtxLBiLqziFJfEBJZfhmbyX0lOHcrVGdgTXRacch1fsQZNAbF7kXm23VYIs9RC0ciOGlfgtYSQ1sOu88LQgtwnWyznMRrmV36ZlmRPKpgdQGDR/KQtUL2qU9Yy9/HRuPfIv+BlcBn1BjHCzR8OZr0HbgMsNFceA09D2TfqGZgxPZ7aTeSAIznoFsvPUd9G3VHpVZzr+NTRVSFwqPfjfjKQneXSNCuOXGzzfPrP2gwvsdDbY6IwCwO4RHOtL26H/5nJPwaDaMmpc5sUn+CCwCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RA9qZHg/sc89MWRxNdkxtY9APrsyxY6/uiwWFCQtJ+U=;
 b=v8nNx/bCG7/Xb2k/Fa1RbseF4ioWzGzKuZ89FLED8r4SEtExsd7DQB8KkhiGtpLMYqEGdvpfAmdcaDIWPiZcBjK/OqSnVKlOmXNaEh4I4Yjes+XG/ToyhLGkUGUlA6UjYxSoAZEUOS+nKH1nnax0C3868VkV4/uvGMq/66SrMYQRhqnldrALBSXesskqW42nfKx6Bvv/4XFoQPpnB273NUhkaZmBSEUhCu5q8GvXYX85y/Ak4mcRj/TdAK5VRWUFrxZ++DsslmX8ScHWrtRxthIqiHJ1BzB37m1XUXSzl8ulYDvf0t4v8XjfCGSksbLwSDCsL2AUBCWKdg0oEztFHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RA9qZHg/sc89MWRxNdkxtY9APrsyxY6/uiwWFCQtJ+U=;
 b=OfYpoZapEjWGWwwashgVZODqbwVov4eqtHuYrcIPGwA5opb2NcbzbpSYrZCYcWzZTCaslfiak4pqIBqO+DFixNrTVwN+2wZjF4BDUE0aEFresQpJNtq3+T2MTC9qST74bHKibnLX53ALreCcd6NyGgzORm1vNhwGWNFHBzbke7E=
Received: from MN2PR18CA0014.namprd18.prod.outlook.com (2603:10b6:208:23c::19)
 by LV3PR12MB9331.namprd12.prod.outlook.com (2603:10b6:408:219::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 17:28:25 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:23c:cafe::23) by MN2PR18CA0014.outlook.office365.com
 (2603:10b6:208:23c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Wed,
 28 May 2025 17:28:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 17:28:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 May
 2025 12:28:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/16] drm/amdgpu/gfx9: re-emit unprocessed state on kcq reset
Date: Wed, 28 May 2025 13:27:57 -0400
Message-ID: <20250528172801.34424-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528172801.34424-1-alexander.deucher@amd.com>
References: <20250528172801.34424-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|LV3PR12MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: fb158220-802d-4135-d2fe-08dd9e0d0d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VmOdDiUBavMwWsIUcXLuXDH1lHs1ubqzzJHLahvdLmBonlEtcGcSp3sOe4oH?=
 =?us-ascii?Q?V00obuiLv4PgSlfOm0LJMQy8bTVr5njDrpkb7u1lnuqooO6AIZFgrBmzVgP4?=
 =?us-ascii?Q?GR8iWA8hlODA/BwD3Lm2AII6bEGIVNmbe24s2NPsNidDfhFYW7Ea7w9U+4MM?=
 =?us-ascii?Q?pnp9myn98ofjXrHuH4tzPjSOPcThyX4nEdcoKwJjdgX4Z3n8+KRYgWXZlx9v?=
 =?us-ascii?Q?Z0aNClwNWBPEBgsAIBdMPxtgLHWYQtRhzq+vmogF5HmegjYPsrdxmdpef4lv?=
 =?us-ascii?Q?V+qGD8IpwuKqz6PPt6HD/n6URYAi+ngMxIWC84uK7VjR6+NnlgEYz1MZWp6l?=
 =?us-ascii?Q?kGVC9A73+SN41RJeqhJDROwhfzKpoC3hJmqgXi1urbnco8mFtFiEd5u8jQnC?=
 =?us-ascii?Q?c5xmAIB2ng2wlhIdv8gQKzbzJzPEmV6yemXk8QmPGN+5Q/S6ZAb78ZSG45XA?=
 =?us-ascii?Q?bmIkvpD4TDG21AOfw14dGESuY9DXC5fgHhNh+xv8aMJVx5VpCzDaU9DBj6q4?=
 =?us-ascii?Q?E+OSpHD7eJlpwJHZb9YBP/2wE1l1D8QQu2UfNrnF/f5m8eE8SHkPeXmB7XHZ?=
 =?us-ascii?Q?9CxR/WRmht4f8IciiFLcQKSf0x3OiidjeYQdI5Apa1ac8tdfiZcUTkjn6ivF?=
 =?us-ascii?Q?noWboBcHRxFX5H3v+0fBCb5wNlK1XTyiE4ez2ik3/wCmINwxL6HlVX5RxOX3?=
 =?us-ascii?Q?2SWJ8F8PiUSyQ3rJ9osZLq2lEBK/bcs4KHSBPD/BIZweQNwNI8+c+BJOmSKm?=
 =?us-ascii?Q?DS9nfzFxg9LU/QaBZcH5twdtFm0oOa7DWLxm9/vmF3ZSSiX54XIQg0h/ry6m?=
 =?us-ascii?Q?+5Ty6hx7YHoJJz6+Nj76Emss/oPdr1j//uI5AwM8pcgLlJmfMCCC+MkFjIfv?=
 =?us-ascii?Q?ANWU0+WYiKsuTuXjXXowBtyNfgESwRRz2ZgvXhivb+BH/Lmu37d+mMAwN3yP?=
 =?us-ascii?Q?d5hCTExmBo8GpvaceuyssipKZoxGPkBzyVSXavRDaev0DFbYg5m3dVgm0H80?=
 =?us-ascii?Q?QCTq1ER8P4p18eEfmwDlEcAhCzfjJlqBi/WDENxecAcZT5x/WeesC7nhWjTD?=
 =?us-ascii?Q?NIjteQPSLYxAQp8n0PQWJX3QtLuc9T/2o0ZoiLXEp15qOb5KYq94F7L0fjyX?=
 =?us-ascii?Q?9lta4nGB6G8K78kKDJ7quOn+xUWii6uVUl6w/dKVqyPHW2olm7VgPir6yg5U?=
 =?us-ascii?Q?wt4fMOfA42qKJaxFR2e4Z5Duo7UBs3YoYwfvoDPzu2z5FaU7GCMr4WetymUv?=
 =?us-ascii?Q?wD2LkghQbW7M9Inek9Bx4lLA+n1GhANYhV+aGSmWSkzKyXF0A/gYK+II4sNM?=
 =?us-ascii?Q?JO+i9VtlBIW8oYzp6U3f9dvlLzMenugCZs0jKtD5FZ1m/YK1nV4qGEPKvJuM?=
 =?us-ascii?Q?WZcasioVCv3ktaG0XTCQ+bBK3QMdko8hp8LdDqD44vfp/En9klau4WHMQ5Cp?=
 =?us-ascii?Q?LNEdBLRMnXs2m0BUxLllKvZvNGjsOLDi+Q/ZtDe8LQto4jd9EvoJnfCbzEXK?=
 =?us-ascii?Q?jGab0QJm6QPifUVZlI+wWtyYJSFlysT1z27F?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:28:25.1631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb158220-802d-4135-d2fe-08dd9e0d0d5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9331
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d50e125fd3e0d..eb0fc48cd7677 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7216,13 +7216,28 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r) {
 		DRM_ERROR("fail to remap queue\n");
 		return r;
 	}
-	return amdgpu_ring_test_ring(ring);
+
+	if (amdgpu_ring_alloc(ring, 8))
+		return -ENOMEM;
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       ring->ring_backup_seq, 0);
+	amdgpu_ring_commit(ring);
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+	if (amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy))
+		return -ENOMEM;
+	for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
+		amdgpu_ring_write(ring, ring->ring_backup[i]);
+	amdgpu_ring_commit(ring);
+
+	return r;
 }
 
 static void gfx_v9_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
-- 
2.49.0

