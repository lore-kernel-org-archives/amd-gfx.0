Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB52C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34E6A10F38F;
	Fri, 21 Aug 2026 16:16:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TFnSTrth";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011022.outbound.protection.outlook.com [52.101.52.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4435910F38B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:16:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwAPBw/mOVKkFTVHViyD0eHGeYElf/LivrrOr8hZcxDi2TXKzr/wT012ei5sPN9xc06Lt6E4Zn2XVwKe73Q8SQCERZlB/UxVRA62Oa2xan0tTLOUymavcOpxHchO2qI8chjbvDioZNzaJ5lEl57ykUIYE68zRq8kEW/PkNmz6n+zf6c+NUFbh4B2USeNB7qdryYPetcCzfjFu6ncy1shLYs1cD4RJ1WluqAbFxgY1W3/8pCZM4E1cbzexQE5v3yPTBlmRlyDhGl369q8s6HhTeFWfFlOw/BGo9XsxBULP/C/2CiAldBHK284CaIOeptQ2D+d1DYxgOaZBrsCFF2Wug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xP+Xx/5qmcp2QjJ6HGupJVyI50+KzRIoAs0YM7IB6pk=;
 b=kTFHtep8IMSMxJy/pM71jZZO+Q6BFCqMq4SISfFka6W+fOTsJJ4EQZEbupP9sgFkZ9qeaAzJBvhOHWEYhNR9WQazxwdoUqBSzgcfzjCPQURN75g7uYrlv2vrvDv13nWAtj6tx23m81vO69KUY3LmDgEaRMn1kriVdf5w84qjtj4jQG1AzaQB9TRwzTu4CNQp9vmpOdNMpqb7DDLtSLSlKbbVQn9vuBnNwUxDX9OWEvFPqPe/4OVDGZiQui7DKIsbeCNzymZQXpgmfsSZqanLowcFqEaYQE7KsUgusLxtp+U/yZiUX8SdxIJqJz8zdGTLChSSaUtnOubzROCujFhhxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xP+Xx/5qmcp2QjJ6HGupJVyI50+KzRIoAs0YM7IB6pk=;
 b=TFnSTrthCHxlw3X3j7swZ5HxmbBd25J5eEreUdfwciEfWLisojVQP62Y3/dVXqJOtyo7buv+xHYGqnEN7z5A6edjZXg5ray76DkilwKbCI5FGkzmmyDBRpqVBHDFyJAziRqWflPLE5PVCNac30iYDHHx5Q7WkFOpWhc1vRx10z4=
Received: from MN0PR03CA0022.namprd03.prod.outlook.com (2603:10b6:208:52f::21)
 by DS2PR12MB9776.namprd12.prod.outlook.com (2603:10b6:8:2bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:16:03 +0000
Received: from BN5PEPF0004698E.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::6e) by MN0PR03CA0022.outlook.office365.com
 (2603:10b6:208:52f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:16:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN5PEPF0004698E.mail.protection.outlook.com (10.167.245.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:16:01 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:15:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:15:56 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:15:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7/7] drm/amdgpu: Skip showing available NPS modes
Date: Fri, 21 Aug 2026 12:15:46 -0400
Message-ID: <20260821161546.754333-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821161546.754333-1-alexander.deucher@amd.com>
References: <20260821161546.754333-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698E:EE_|DS2PR12MB9776:EE_
X-MS-Office365-Filtering-Correlation-Id: bf85de98-414a-481a-520e-08deff9f7ec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4UmPNO+/1WBfuwgY+mi3GAmIwelAdQc/KXpdaTHk2ytn2CLzJ32YTiR87QOYsC9/LCIo6VD/997mFcXyWRE6hMO50Sb6hkbiTF/cPYbmYizayWJ8vjFsk0PZ6lS9qSWlMUXEyVK2H5rk48yfi2bPkOrF1ZBHQFzanJ4muElLWNparBOX4EHRBCzEob0KbQazK16gwtorBOFBqBEUqMRBazABN01KX7Ikhk8b8LMX4dnvY2Znhv9p7NOKTGCx7FmtqAgCXkmhJmuzg7VU2ZZqvDoAzfzXFovNXKSKOZZ1eGjWxfkRIlCiLX9T8M7VJ6KvkqanhI3cqb10CP1+goE0PrSZbEP954dWuge+FXVF3iAh4I1tyDdvxVueQeQQ2UA+5pO8yiCK1h/813aozTRtoNPczGzJDwYqH5pZ1CdHcMPWkGeOhhhOUdk/6Nzdj1qiei/7acLR+5vNfmMzfFtMf1CnwO/vyv3J818vHYait443BFTIKPOIT6tLe4hA0bFBmW3Cku2JuYNzc/tMA8BdAJsniZVFusZzmlkRyyaHz//b+KMRFLPCpV6mCRmDDh0qJlyaLoh7v3L8K+f16HvV3afL/5ZPIJycx1TVgFt5lLHSeX/lwhhInQ1wT5/sdXaJF/wsHLDUqzs9x8lt5mxSSCSmj1hoZ+vrcFwNEUUMsLl6I6D+9CPz37CU2aG2ywGG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RkKGsamwqEDrBe0r6wjz/R/KQ5c4dYIrfaJu55UCtEY9Cg55gGgC4i5A9EGSU07TWQSFVvhfX7NyKQYgah+YlskZRlza+eb7UxV9lTcqGaJPjkg/TKGyl+fSkxEqrM+m/q9W7hXX9z3u+b5Ugmjm5IOkuuMlgi6SHBFM6YV5DBa62dqA15NQMj61CVmiet516nLgxzgAJ3A/KIGgZjMD1Z9GW2z+TleGiYdcEPgWc+pxCpszojEwvLGXV+3iula1PFwcQqZL9aOQjsnFHaagcP0icSBPrXCvhmOdp/hwr4TdAub+62HVsg/Q058Ly94IhoQSpjwNlWaVXLH9oXj+9oxyr+l/1rkOwP6S6T0JYSwjrWRKG6tcEzPRfppDHvzRaqUiyyGss58A1Qc312fUCiHscxmTiFrwD0F5z1SWKZLIGw6kV/xxnZt8Kwju9F2D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:16:01.9457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf85de98-414a-481a-520e-08deff9f7ec3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF0004698E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9776
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

From: Lijo Lazar <lijo.lazar@amd.com>

Dynamic memory partition switch is not supported on CPU-GPU xgmi
connected configurations.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index ea0228129d5a1..7c05545063346 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1364,7 +1364,8 @@ int amdgpu_gmc_sysfs_init(struct amdgpu_device *adev)
 	if (!adev->gmc.gmc_funcs->query_mem_partition_mode)
 		return 0;
 
-	nps_switch_support = (hweight32(adev->gmc.supported_nps_modes &
+	nps_switch_support = !adev->gmc.xgmi.connected_to_cpu &&
+			     (hweight32(adev->gmc.supported_nps_modes &
 					AMDGPU_ALL_NPS_MASK) > 1);
 	if (!nps_switch_support)
 		dev_attr_current_memory_partition.attr.mode &=
-- 
2.55.0

