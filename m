Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394BBC5B549
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCBEE10E9D9;
	Thu,  5 Jun 2025 01:46:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jLvPWkWB";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BCBD10E9D4
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fgxqmuYw67JEczJaVK10PPvanc0zF30FVDBJfWCATjRwGkknJ2e3PfWXItAG4++5eevhnNGkoBlHHnzstdnHXE+QmcbrE7ayg4lbCHxCn19GTaR1wZbdsspAheIHLc9YmQFzdiGAphW2hzjdyqhHmJcgodk5FGER9359iyOyi1JWm2YsVp+Vy8m67K0oJXtSrlHQhDeWdMYNeQDCLAczBSN0KYS3U4qvZMnc71w1B/cvXoM5GGrJDmztXKTpgCPbm8wbRkLu25Uz6VaH2ycHpnpvk7MytxYdCzTtdgn7CdQW3xod6t4Hd9gl6ujvmzIvRWswr7esta7clc5S5zyppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVffteqiTuaRT2haD9Hm/o4MkqNZowXl4nHe0YLMIH4=;
 b=ZSyy7FajHbTCUPCq0/Qd/fy8pZCRZJKX3ObRrR/N5q4HBZNJIIXddB5//pJXkWSTuQgtoMWqbgGIyN3Cm++jP0BCVsrCwifJxfRx2zQx0kir0g7qXyuod6s3sdp3Y2SW3y35YYVg37NZxoK8R4cp+vGucMphuM8scJnX/qbQ6Jw5qU4Ysfv5r9eVVVmtlIvEcJjuhhMdHSXLGscnyZ62GiJM52NdWYTEI2HIeH5cxWr2Z1LbtOwrpILE3lHmDjY/zW/esQYQWUr6fymF2xbQYHXUUR0J0OzQtGeEfN3TrEZ4AEybnY0eW60jtPw17rl1VLEJPYjxkJ1tOhbxJ9h6EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVffteqiTuaRT2haD9Hm/o4MkqNZowXl4nHe0YLMIH4=;
 b=jLvPWkWBxRtqxvmETKZ7PQnzLm1leKQkneE5Zk6yW9GY5xxKuxv5q4DNzaUXu9YQcWJZD3dTBuMj7ndsbJPZXyQkkQJwKKVE/LJNgcDz/qeHB+FvGCupc2A0OMTLmM1uZ13Z/mLMDw5SdgQrFIERVS/R9XmlWlJJo/OpugRX6yQ=
Received: from SJ0PR03CA0272.namprd03.prod.outlook.com (2603:10b6:a03:39e::7)
 by CH3PR12MB8878.namprd12.prod.outlook.com (2603:10b6:610:17e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 01:46:33 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::e) by SJ0PR03CA0272.outlook.office365.com
 (2603:10b6:a03:39e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.34 via Frontend Transport; Thu,
 5 Jun 2025 01:46:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 21/31] drm/amdgpu/jpeg2.5: re-emit unprocessed state on ring
 reset
Date: Wed, 4 Jun 2025 21:45:51 -0400
Message-ID: <20250605014602.5915-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605014602.5915-1-alexander.deucher@amd.com>
References: <20250605014602.5915-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|CH3PR12MB8878:EE_
X-MS-Office365-Filtering-Correlation-Id: d115ecf4-ab28-4758-add4-08dda3d2ccd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5uoiX7f/UHUmoX33GsMFXMkC+lKY2Cg05zy5lae7rmoGhbpTacVVyIu8taaO?=
 =?us-ascii?Q?1GrmdBQ5NR4SCAVb0kcHv0shIqenrOtz7zsJFS0gePOUltvrwxiorpedM8F+?=
 =?us-ascii?Q?s3/1qcTZpf1lff8tSuKVtyS96ABlxCUvDDQbbKBksLRFC+uc1Ize6vW+Egyt?=
 =?us-ascii?Q?M/A1KvDjqRFOppOifAE4TsXbYKVWzRlnuDnRy/iOU5wUWvbr36s8LcXOvb7m?=
 =?us-ascii?Q?O8lEF0Szk9h+KHfxuQ/M2wsUhLI14QLfMJOFkQvKtggCxp9ltlrr1sYbh4lC?=
 =?us-ascii?Q?7wr+hyS/V74/nHCnC+pZiRosoNHhb0Sf/05L5wERxxHphLrO8tSVxUQYK/jW?=
 =?us-ascii?Q?P7tuAMmXq+wwuCDIL7VrP51m48i0VQXQyrFPTlQT6zKPPDuvHI0AiEScZVMu?=
 =?us-ascii?Q?GkjFGl+BpZGxCL2h1kfZiaun8z+Hrs3ARY/s3QYIvYxLJy8iYbRJ9Uxv5TOL?=
 =?us-ascii?Q?SZ0xF0OAERj+W0XeyPPSrK8RYC41O/TeGutXRtIJafro5k6wgnr/Xfjm372S?=
 =?us-ascii?Q?u4wS/86DnTHrAJawvT76uN/BSUj6FrjZPAafSDKIbcmNeefnu/WwCSy+D5qZ?=
 =?us-ascii?Q?uX5n84Y4AiaKByc8n9oj/EnH8Qkc9fo5OugfpRG2i36cjHCGl18i9njd1R2n?=
 =?us-ascii?Q?qS0pPKYjdqsi7KnpcT7O1+bmGXauCBvLd2vAs3DfKlAWEMv08/XKyz1Qt+eF?=
 =?us-ascii?Q?KEjWHcHngjlXn/lV1hUG/GY6xoXx/epU0YnU+nzJv43noxWgn5FeS6WlrFcm?=
 =?us-ascii?Q?LZXbCopFNQNrv1jd/SEAV5FNJtBCDePnsBG/nL07+pK/mLDgT5hhkBp+fZQH?=
 =?us-ascii?Q?Df/AsW/6uQU8HeN5T7Cl1F5E4Z5xZDWZKka4P6Dre9kz7JI7bV2oFnQdGv+1?=
 =?us-ascii?Q?4d1M7yIgDK+rMF9MZT/+JfYrCKqQLdVez1yoNwNZ92thSfn+7tC0rv5gSn49?=
 =?us-ascii?Q?yA10OKGuLNnkhN4SmWwOpp3LJVbq2gjtPL9BUHtDgCm1kZnlffaMVexh+Eqc?=
 =?us-ascii?Q?qV9aX7y+JYuyjdfopVmQe3tNLhH5wCHd9GbwDjvxTEY7uIn3sgfTFw5P+hK5?=
 =?us-ascii?Q?d6UbwUrPg+hjSXTHVMTWlEfFIS9QHr7gwPiAcFbEI1YEGCphN6HMDg/8sCEn?=
 =?us-ascii?Q?S+r/9/h8XsxZuSdNtnEG/Jsc9o+ImP45DU1mz0uOXTIVb2YhLeFNyb4xNOc6?=
 =?us-ascii?Q?gZbQvkn7l2oDsi3zTYgMTGQdFOuEx8DE3TOoGCx49twSqWoZTfRvuUvQk+9D?=
 =?us-ascii?Q?4Eklbj6HCU7IMDY2BGY5Qpq72Do7MOZgvWMQ2T33dpuhwXL4EtAsBBVKtWhB?=
 =?us-ascii?Q?xmHm6mAVBY/Kb8CKgtqFNEP0/EuIqgmuFgJaAEXc0Xs0bH5gfh2AHoih3K1V?=
 =?us-ascii?Q?rphs+ULBQHTIN1stpgjyoK3M7Jh8dZpZqxEGl3oqO3t573waBhNpBuTmBu8/?=
 =?us-ascii?Q?VQ9Prlda8yp0Hu30aO6XuOo/FYuakkUxnTvOfXepYaruIVYC65zvwcP/TX/W?=
 =?us-ascii?Q?jSX3sxIMHjsgv8B9vlXLhFo/Sf+H9RAdGDGc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:33.0877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d115ecf4-ab28-4758-add4-08dda3d2ccd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8878
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 72d739e38a8ae..7105c5b995275 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -647,8 +647,8 @@ static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	jpeg_v2_5_stop_inst(ring->adev, ring->me);
 	jpeg_v2_5_start_inst(ring->adev, ring->me);
-	amdgpu_fence_driver_force_completion(ring);
-	return amdgpu_ring_test_helper(ring);
+
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static const struct amd_ip_funcs jpeg_v2_5_ip_funcs = {
-- 
2.49.0

