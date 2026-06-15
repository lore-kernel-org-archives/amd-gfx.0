Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C89CD98DE
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61AE210E77F;
	Mon, 15 Jun 2026 23:57:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xfda7Z7L";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010026.outbound.protection.outlook.com
 [40.93.198.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5118910E706
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eICejTphINZ1VXuMRVdiVisf0N4gTG3IlqCO0mZJXzblWK53H1uNSLt4724aN2Xk8BoNuKN4bR/zvcvU81OGhUxYVrBPsUu9VQ/zjsy7lCmbhFwTzU3MVtTuHguuBBlDGuKGjqFrF7Qa6CU2Vo8B+r0l3oGKSFtmZqGtXfunqMkW1AmOzLoo3eGGVd5BvJ4D1LGbTlv3mtcpxYd4HRyzz908GuleoIz7ppQPU6H5lN+TeS3dbTe9/sD1g6C/mQlxmCteCEiuGNsggPBzMMXzYUE6nOizrjw2EUUev33yg/4ZpICwW1FcXBaKTeUOeOO/BSwCGER2SKT4dY0MgR6hOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TULkMwuXU1gkTcj8M40z0OUPk1BDAfzR47f9o4Ki79I=;
 b=wjTg/ZTL2SKesYCltJnt0icgareiRMEhrSf+haKJy9nAcBQOsaZTcuTa+FONrBS/H1sJnqgcJsgLff/FSjOlqrHptQZBhQT+XD1gPYAhqGtHAV7NegGjLlhq9/Br4sM3N1/YzWicvTG9mL/V5rE1SGf6imqwuLYIteqZ65/pAp/KEOehp649JyR4p/Bb3tWXoadN71ummniAGPgxK3RCMxsClSp/7nWP77HvubYWSrTd9AO3xBe4z9jYC/v09x516wsZQQQrgwUjyrmyCsaitSbrbO/pJP3DtyPcdW2AQ3ATb9YH8vxXN0MM4WWO9IZBpnNvspUozzC4KHURIL47Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TULkMwuXU1gkTcj8M40z0OUPk1BDAfzR47f9o4Ki79I=;
 b=xfda7Z7LDv2gbeOIYOcP3NfLkzLdv5vsjnQSDtHL56U36G8THAA8/vr7YhLFUebsz8R1ioWXSadXxJC6pz9Ctg5v2vnenkNcb+sq1kBwfJe/36UEz9p1WM0m0vulZqSFWc45G7CrVJHAV1rX8bFXLaD655OOSmFwnp1ZcYfYywo=
Received: from SA0PR13CA0020.namprd13.prod.outlook.com (2603:10b6:806:130::25)
 by SA3PR12MB9091.namprd12.prod.outlook.com (2603:10b6:806:395::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:57:05 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::22) by SA0PR13CA0020.outlook.office365.com
 (2603:10b6:806:130::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Mon,
 15 Jun 2026 23:57:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:57:05 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:04 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 16:57:03 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:57:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 22/43] drm/amdgpu/sdma2.4: replace BUG() with an error
Date: Mon, 15 Jun 2026 19:56:24 -0400
Message-ID: <20260615235645.737189-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|SA3PR12MB9091:EE_
X-MS-Office365-Filtering-Correlation-Id: d404ff60-2047-4f70-2aa1-08decb39cdaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: TEw6l7PXPodsJbgZfi5IxWqorCFhst9J7wAB2AdoUK7KILNmkexMU5NZpuOUloOKEB5WZxU2vXuSgMBrvDbS9b6ncz3B00KaVtA03XXXkGbIa3RxglVfq10ZjHXnQLI3PZTG721kq28m9+NsmFlJBkOSe68TWW+mSnwelDuwG2ncSRqZMonkBDF0gDeiwROUau4smByRKFYPmSLgA3d38P86fs5SWh4Y+ns+ElDirBL9M1wvyNgPvlbzohgB2zZZD7ZSgRju3+Qa55AUSzkPM4gzwZXeEsEqi6ddQIT7yfzsBO6pQExnlRn5eROutvAkC64jNgzgx8hD4MSBanpckKdDtuQJURkcRam6w+R7woHt9Jp/X98qKXJ0HNALtUHpVIJbRKId1IgVdvYyuDRrOQB7ncAxXXILURiG92CeNMKvxZyDdxO/gGnzyk7GErvYxt0o69cLssMsc0i2Xr3PLzjd56lsQ4OVFpeGXGMvW+1B1brnRMUF2+toVsemsDk10CNf20z2Mo4OFVEdCHHg/WW/0Z4C057EAtUmonI6NFdYfnaZG2hpweVqwVNABDcinkGeenTFATiM/U1nW0oE2Mpvssy94ZHeTLcdS6q/KramqLhlfKVsvkS/o5QniTfMKt6LB9w3Tz8JvC5dc/yX6X+jAE0lE2IrC1qX4RX71VRpONTIA//wxGjeC6QkM3QJIgETOvDxYVmKbAWMX2omX31HVsCZEeLYSAyGnFxICGU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H0i6nLIwMO1/TwD4G47YyphBP94jkczJ2Vgsv3mnl+pJh1/jB1Tpx5TJJsmm+TEdchxcHYs4HOhhWrrggbFG4QODoNkIpjU5A5JXKIe8+IB/6PEWlmKWV9ROs6XYsaRlwQs6Rj7UoHZn6mXw8Pk0IAmOkzeVtjcahX75RVf9CKDGYac09BFPCLhBEVg10pHwb8gLms9j7pTcZ+l50BWnWoDzgLuhlatNGdOWQNFUVdWV9gafgZ+tftg7AD4CtrcsKoeahjEKBSMeBz/dJ0v615E1Au2+QBY8uEarYBnAySik0CAOq/ZeFLwyKOmz0/0uoOqv47tD1Uu3XRUmN1i8btwEPHa1jGv3k0t3xhvdX9T0LBYDvONNpxrijIdog5lZl1rO3bXTuwKzE6lsjEWBDhuPKxJrvre5Qk7YRyCEhGBrUFPJo5hMSeuEuzg+U0GN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:57:05.6619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d404ff60-2047-4f70-2aa1-08decb39cdaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9091
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

There's no need to crash the kernel for this case.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 93ec52c1f3678..7b57d9c6741a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -138,7 +138,7 @@ static int sdma_v2_4_init_microcode(struct amdgpu_device *adev)
 		chip_name = "topaz";
 		break;
 	default:
-		BUG();
+		return -EINVAL;
 	}
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
-- 
2.54.0

