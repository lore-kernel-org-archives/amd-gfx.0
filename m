Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5ADCC677C4
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64FDF10E9F4;
	Fri,  6 Jun 2025 06:44:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gj6oOPmD";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98EB710E95F
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFyuJtDmW/pUvqj3YbSW/SdqnjAxu/0dBFqKG6YQksZEg0dtkyMMAGa4rruuhu5qLLZPhVZvKfI5XC/gdTzvxH01kMHN/TjGKTxEjJq4R+q7up9+iyqIZDnJ9siemDppu3M7DAbq749UbcCWMzaPEkueGDKbO/Ikjot0afICCILzykbGE97VCupJK20VxM6nfphhmZ9pgMZneJ2bLuQqiEcDvzwsmIKECCTb2snX6VfsndDUFOMj4Euc3gzEa5GWTmmUm8kLCG8gY4XKH7Rat4OPFM8Wh01lDvL5lv5bRHh4gbkEeo4YcxBgZDnj0OKBYKI/Hwe4pzePPrsBEOHGNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCKKMikiKReSFrU9kca95Z3K9rT7J2WNOuCSzowZ/UI=;
 b=P/mfnSVFpbRhWMm/UCsyA8qmf71C1MHOigBNeXB9civ1Gksgu3PsYWEWT2bZxBT5WFU5X4ZIdQMkMtBRpmsVvmiZ5idmp4lstqx8oDxLvOvsUjYD8/a5oaKLcOb+cs5CB1FXohbLY4v25fGvmfl1ts0JuKu93CvM+5lYhGs/bU21LtTMcEpk2iFOiKiKv10BHy3gj8HrxNoWJAf7sdsKieSLad3a+2NKytni38VjUAjIUya4LtE+HXwTdi0tPG9BIzQ12TRSLjebDEGjW/LZLmYx9t4NEKsh8x+MJkElPonmv3rofJzfQBLcS8/whodlOHJ5ymwkEvCPlXR2vsw5Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCKKMikiKReSFrU9kca95Z3K9rT7J2WNOuCSzowZ/UI=;
 b=Gj6oOPmD+29J4SxQv8H8I/Gw0zGByhkukjgtmRqPAYWm8cwk4lUZ5vL4jrILFI8vgtf4xLt2kwKYzfivUQ1e3S3XoGwU3fK4dZQ7KVCKGalhVbKSqih/KVC/JlClYqp85TgofnlU7tTJOPbgJ3/Tv1Tp10pB7a/kuLkR9FwdIF8=
Received: from SJ0PR05CA0127.namprd05.prod.outlook.com (2603:10b6:a03:33d::12)
 by BN7PPFD3499E3E3.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Fri, 6 Jun
 2025 06:44:23 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::48) by SJ0PR05CA0127.outlook.office365.com
 (2603:10b6:a03:33d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.9 via Frontend Transport; Fri, 6
 Jun 2025 06:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 20/29] drm/amdgpu/jpeg3: re-emit unprocessed state on ring
 reset
Date: Fri, 6 Jun 2025 02:43:45 -0400
Message-ID: <20250606064354.5858-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606064354.5858-1-alexander.deucher@amd.com>
References: <20250606064354.5858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|BN7PPFD3499E3E3:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b43ffe-dd55-4c0d-eb75-08dda4c592ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?noqgs774TCay9qrywikug4FIPV7RVrgQn43pfrnHYM8hdWi9mF7aq+hxRo0l?=
 =?us-ascii?Q?7zDqGCcQWCN4c47dzi/PPj7XI/qgUrWR/OQh1k7KGOpcoog9Vtl7AqbljOAo?=
 =?us-ascii?Q?DZHJaYq2HWNxd+WeW41Jzifr5lBiFaqolpLUNUytDoxpm0Ot1/beMIBzh21L?=
 =?us-ascii?Q?SvAv3FIqm+evWqAz4DKDGvmyGG+ki3aGvZ7kHVX6bY+M9x87mjiR7vwbufF3?=
 =?us-ascii?Q?aUwn3ovVEIBzELmyYArUnYiNpEkygihSQBhhzTrNV8iZo7VPSfFaVcWQGvun?=
 =?us-ascii?Q?HI03V9cPh11KpRna3Nl9WrYtr79rfKWhA/amR9voK45TnGaAPvYQrpN95xhk?=
 =?us-ascii?Q?blKH+zns03tBO5qB10scVz6ppr1jXgQ5GNqOmjnwiEar3EMb+Fj4Hid/x0KH?=
 =?us-ascii?Q?RDEhF3+vJe0Lq7ebSQW72HFQ6ZK2ZE+2XPZjbgCpC5BljiD/+V7sk36iP8r/?=
 =?us-ascii?Q?+7As88eFNy0DdKfhswrfLG1mGpC7j197hdR8nf3Ysmvcf+K7pU0x8IJPL4sA?=
 =?us-ascii?Q?YbNzrfVoPlfzIDJ+TqVwEqPCB6JFWpxMg7NKvXGdpnP19uhVHbI5v6CgjdKM?=
 =?us-ascii?Q?LK4PdNh9YhgTBY83GGguhxTqbFTbNzhwc1ZLcwLPgmXxnqzdiAONp+4uXRFh?=
 =?us-ascii?Q?kGiZ4ki/HlBQJ1JcOS/Ey7F9XZzvpt1Z3YbHyhSNsYtjQ6KVCFk+Bfol0JKI?=
 =?us-ascii?Q?ejEEdwhXJ291bLhQhZ3e/qthFKfSTKV69u+qxuBtJoefjn9Gp7sIp8pT2VxR?=
 =?us-ascii?Q?AIP7CkK91LflNXKo+v0p3OYkVlvq7cp09BGwcUk9gUQFudUdv+GCfTu7uXcG?=
 =?us-ascii?Q?9eJlzYsvAY7LgDyqH8acNdJcGXVZvKPO3bwHxz9fFruwB+9QDJ/27nkeXzOK?=
 =?us-ascii?Q?tXKXLW9xx4h60gI9ycsMhVhekDQl/K+8AUNlYNcpiVoek5pqk6nmMGY03M5Y?=
 =?us-ascii?Q?5h0/VpfwF0v3FmdT7wcPx44JbUh8KmkU8uAGUI2aa/4Q9OG3bxxRY40zJdTK?=
 =?us-ascii?Q?81iSsppYs6WPLz/GWCo188ZnVJAUbm/pPJAFjoB0HwVdiM59SZB+1+DYtl+I?=
 =?us-ascii?Q?l0NJPz+Ec/5u6OlEWOrytRKwP0WCIRVIqp/BYPY/jcS1uGWCKSKzs2g/ykFx?=
 =?us-ascii?Q?UK7+3HYIdoqPRFtUrzuPNMJ0XhxNCgraWDBycf2+GgOekj2SuDNWWqcSXvJe?=
 =?us-ascii?Q?zsmU4sYKRqTK+nNpfutT805hf0jNp/rFeb1MaW2Xc4A/ReJPgDQVoKIx42Uk?=
 =?us-ascii?Q?f8oZeBxIfA3HY/3xtZcRGoPFdoSAUrsrxSC3xTOvC0rdksyjQTPNkHF0wLdn?=
 =?us-ascii?Q?jtlzzq93LKqs3x4t1LG5qZFiJm+BB6jDLQRn8THBrb5TXcFyPe9ca/kNblvR?=
 =?us-ascii?Q?ikiTRqLSwqLz/SMe+K6enBpPKAAZf0c9wnlLvfqE1WjbB2Qi8pUALiaVArY2?=
 =?us-ascii?Q?puV1sa9LSUW4VsQyK2a/F+k8LrzG9/pcqBVrz78ZvwT3K7Qbj1RNClPjUjQJ?=
 =?us-ascii?Q?+kvDmSnptylwvF6CzmQUPEu8lk/3ieI77tyN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:23.1473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b43ffe-dd55-4c0d-eb75-08dda4c592ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFD3499E3E3
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index ff826611b600e..ff50e46ec8c25 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -560,14 +560,22 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, &job->hw_fence.base, true);
 	jpeg_v3_0_stop(ring->adev);
 	jpeg_v3_0_start(ring->adev);
-	r = amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
+
 	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
-	amdgpu_fence_driver_force_completion(ring);
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(&job->hw_fence.base);
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
-- 
2.49.0

