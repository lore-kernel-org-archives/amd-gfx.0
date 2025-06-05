Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56ECDC67861
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB60110E9BF;
	Thu,  5 Jun 2025 01:46:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XhznpFU4";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A95C10E9A9
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvIpBCBmpKuFyrjgw0J3jh6KeyIs0v2b2pt17rEv1pcmEOGtt0c5JhwA4haZaag7ED2ALXUHzQHWjvGjWVvJ0WHRxSUHiFGsKe5eL+MQFTUgqsU6WvpNW1W4fcK1V3VWSILDlXETYBwFxyDsbngq/eH9MA8m+30SZnfecB3SrLoDiXdNxLu1yEG5++1SfesFduqhO5yNY2uaj2IZp2z6H1rsPLvpNRCZj65HmoJRErPvnERGiCuZea5o3mMLQkU4az3H9RecUmM+tVvC8h2AofN5bOyRQFraadsgEHEZ+PDDEOZqM/e+c1Wq/4xqboWM1nFQaFgdEgg9cS81lsfaDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQNy27gMQjUDdSVabTjDuSbAIVxToUwvDXXQD/nKhOw=;
 b=LgMJBqK3DVWglqZfp21xnFYy+7BzXBll2yfS3YAzGAPxeAvAcA3cl6yfGp6gtpwVSxO4j+gQqx0H0fswPt9hjp4RWd8Of4qMaSGHlG4JhP3BohUhJsb6OM4otxal1ahM7tj9ImTH/xSc+YIr04w07alydJwjAD2rgtV8mmuhMq1hJe3lzKVQh5yBe7wCpAPrARzaFWM3KN5ysdODzLDa0MuOz0vAH6mJkBbHgeeeByUAzCO6dmhDMFBPCvv/meHFpmyH+t5oc0KsmNuWlnvX5NSRP1pdspMcncajZscUWZP8Gk6rxDkSTaIcz4u32XtctCeUFxxVgvJD4uGjLbHyxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQNy27gMQjUDdSVabTjDuSbAIVxToUwvDXXQD/nKhOw=;
 b=XhznpFU47bl+YromPKnh6eOFBKcyQD21KzQeJFmb6nfUNEmb50GpZBVIWGeS1H35o8M+LFhG6de9UQCHE1SJxDd7UDlE2ZrhzooQtE6WyJBvn96g9Cg4sFwpDlrlSpriNxxSB90q/Sg1/ZHejzjzHAHXxlqumNgqTg7NAfH/VYI=
Received: from SJ0PR03CA0138.namprd03.prod.outlook.com (2603:10b6:a03:33c::23)
 by LV8PR12MB9644.namprd12.prod.outlook.com (2603:10b6:408:296::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Thu, 5 Jun
 2025 01:46:32 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::93) by SJ0PR03CA0138.outlook.office365.com
 (2603:10b6:a03:33c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 5 Jun 2025 01:46:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 19/31] drm/amdgpu/sdma7: re-emit unprocessed state on ring
 reset
Date: Wed, 4 Jun 2025 21:45:49 -0400
Message-ID: <20250605014602.5915-20-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|LV8PR12MB9644:EE_
X-MS-Office365-Filtering-Correlation-Id: afafccc2-33bf-4e30-6d6e-08dda3d2cbfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V/1hp82BbulzcLDkTWEximNBPlMUeAQc1mKgcz/9pjyR16xcP0lnNTX1+3DW?=
 =?us-ascii?Q?k6ALytLRuhoMQr9xxMLSglcDvHKSvVlUPtefo+h+pRlJEPa4853bR7s8EZ8x?=
 =?us-ascii?Q?r+W/yzmbviW3F18bewEnYogv15BlT/TDAdcyZ1/82oG+l0PxIHAg3kWYuYz8?=
 =?us-ascii?Q?IcHSe1f2EpjVeB0fjl12m53l8C6QC2GYcs+XkbPZDHawxb77x/Yny1eLhewt?=
 =?us-ascii?Q?3LItAscdtHX5NqRuSdWl5Mae2c5ZCzz27iF3ICxC7iSUlmsCgh4HMjndnnSQ?=
 =?us-ascii?Q?n6FwXn7Pntycf30ClzNwBDc/MMQaAZefWzuoqpfXC0LnjqmIgxbEBnrBdul0?=
 =?us-ascii?Q?21cj/clnS9dfpB5aUh7QcbGFjOCaK1PtLpquTVf3GK/XPj37IYFjZchWnv4l?=
 =?us-ascii?Q?4R5Xo4gbg48eSsM3YemGzDu+ko0dUyZNKm1nopB4KhbijOKWUBVApwNnJ0v9?=
 =?us-ascii?Q?29is0pgeZaASFAjFFJYDukrMjjQqlKqWNJHSZIFtQ/ViEu7xQQ9UCbstSOY/?=
 =?us-ascii?Q?L5LJ1BcTygzmqucaWAzZxc2kzwRfWdcFyqg2CsDHsIz5afAFN8mqDOmk0UsC?=
 =?us-ascii?Q?OzK7Du+JYbqgG1TwZw02IuZ1FYubpHeqdeZ9UjChqNv3GghrRbrLg3SWERMe?=
 =?us-ascii?Q?GD5zTxmoDNibMMKFkD8H6mhOivCljC1qZIqC028HVRfw0/WjYGkF31zFGyxW?=
 =?us-ascii?Q?G4XUJ40Tquc3MYR5WIeGR7p+Dk39VLkDh8AgMXXLl2M3J8hVK/ZMhJKUOtuk?=
 =?us-ascii?Q?5ooE6h/s/DW+1k9cEanjL2BCQyLjoX1LPOJTOdbf/I8/F/qO+Cuy7Gxi37Ox?=
 =?us-ascii?Q?oBVDxMHN4aiRxCUHsHb0O69T6GwBqLbUbOpFq7HbkmddjcSNASSkSekpK3wl?=
 =?us-ascii?Q?rM2tn9cAzHSCQP0o0e2v8W+Tdrwk3rnCuywVpKpVlkKhj5WSmUHcz2fGHMvS?=
 =?us-ascii?Q?NaYIhEcE6HOOBsPizMfx1KM0XI2vKahcKH5l8JF/MmSoJnP/a3LYIynQHQ8d?=
 =?us-ascii?Q?uLTc6IcIodcdxhktHkUECB5+UTxyp9JH4BVZvHJmXhsN0Np0crPj72ROU2bl?=
 =?us-ascii?Q?IgcOYdk8J0OmcHRSfm6ytPZG0riFBLCv1xWl5nYGBI/jiBRrkj6Uq2t6F7Kd?=
 =?us-ascii?Q?5xkMKuPH96uRdvF8zFoyzA1YO1wWikTKoU5SXo6GefTdVkiqWZllWB1QaDtX?=
 =?us-ascii?Q?ZYAp0Vu6rur1iGjAHZhi225D2Nc5oJXxtFw6gQ66zyr/dClmMRX0sLHmxtAS?=
 =?us-ascii?Q?n9AQpUmpf1exnzItAqKk6usZxKlKDXj5Tqt3BnPM6I+giiBVWZtuFoRa+hf/?=
 =?us-ascii?Q?5WiZj/M/Ga6vE2F/UbgnDpMS4Tq8MiMzpKi7MNqNGxwvnNjE6HsxruLbrd2Y?=
 =?us-ascii?Q?Nk1Hl6c03+3Y13CVCHKtsZLO8AoCEtSoIreqHOFK9dWr1tVXYqUKiFFdCRbU?=
 =?us-ascii?Q?jl9IE4Xs4/LMfqzSYCqwo4P8OTlbr5FXT5Z7a1xcDQqygNOTFBq/hCaf/YK7?=
 =?us-ascii?Q?soY0SOE7d2kpTUxu78XCpk7JMR2fK5WJCpnd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:31.6583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afafccc2-33bf-4e30-6d6e-08dda3d2cbfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9644
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
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 25cec4de13131..3af2dbd96a2e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -824,8 +824,11 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	if (r)
 		return r;
 
-	amdgpu_fence_driver_force_completion(ring);
-	return sdma_v7_0_gfx_resume_instance(adev, i, true);
+	r = sdma_v7_0_gfx_resume_instance(adev, i, true);
+	if (r)
+		return r;
+
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 /**
-- 
2.49.0

