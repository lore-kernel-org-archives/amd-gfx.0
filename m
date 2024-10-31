Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9181E68947
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2024 01:56:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C9E610E05A;
	Thu, 31 Oct 2024 01:56:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xw2VZ7kn";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07DD010E05A
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2024 01:56:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jv3wCKVujkAGBavZv/QfnjoEfX3LBwIDAfFEgfPEtWIagHjnAWdsS3Yzlc0zLbME9myj3/5pPT8Qxys7VWN5aNcfNhUYg0UFhJFN9uichvR8K2J+3PJfVWfHZMw+GKs3CJlJMQvqGwtBNxqKKAVlSHHxtg3YPe5Mb2fQdhwR1Uhjgpx5ZZRKqi269509Xpg+0v683QiHtLGFO8QHDlwOiM00/cCsv4eLzkErnJe4nSiyoc27m4baAdMLbAMeLt7YlG5TYOjIMlx19nsjrXnxElbq1Ta6BHOLw3Yi96XrZVkkFvARU2RQ9ilY8ADgpIszcT2LZewiseyO3PJ96e2mGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NezzsfVDckkX3fsbBpfGBJHsP+8uma4mQ5I54sP03xA=;
 b=pC1BZyv1rnIyAupa+zrGIfVVpo8KYEPvhPMU1eC5eKXVNtc7Ja3ECAdfDdQ5HEBiQjoSI5HrTUUZWELe5HNDynZrI4ZdUmNRKvcq72/lz/JWh5V/536ZjNCj5htW9SgN+zognR2krEWMSjX1rBXsFcl5odC9skL7K0WGjGo8+kmOHpK9qfm/tSo63g43CHjHiqL0t20cQWykKIsErR8urX+mu5XkJpOd5VRFn77+syTERx9PulEDvVhJmjimlkrvrYTARVHR5o5fwdoK7IxFfvz2w6EBvuV4BqCE3LgAK46SKjNGStKsnPOeNr/sPSjviXwK27diqlDsxSyA20ZFbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NezzsfVDckkX3fsbBpfGBJHsP+8uma4mQ5I54sP03xA=;
 b=xw2VZ7kn61xs9CRRSrz6bZMJR7wB3e4pjEqVZ44oUoBBE3/O/8MIaps2rJi/YHse9UpAUjQx7CjFzviO0E1vHg0qwAl2MOnuZUfE6stL61XAcOJtn1xh3gQK2SEPrboZm7ghmg5W/6CmpEBj6LSTfB+9C2jLY681OtRxOX2uy0I=
Received: from SJ0PR03CA0299.namprd03.prod.outlook.com (2603:10b6:a03:39e::34)
 by MW6PR12MB8997.namprd12.prod.outlook.com (2603:10b6:303:23e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Thu, 31 Oct
 2024 01:56:03 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::a3) by SJ0PR03CA0299.outlook.office365.com
 (2603:10b6:a03:39e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Thu, 31 Oct 2024 01:56:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 01:56:02 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 20:54:29 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Fix dummy_read_page overlapping mappings
Date: Thu, 31 Oct 2024 09:54:06 +0800
Message-ID: <20241031015406.117115-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|MW6PR12MB8997:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bb60db1-a8f1-40ad-3912-08dcf94f2cb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzdYd1BOWHFFcGZNbERoLzIzeTlmVXp3c2xhcFVhTmJHc2JUS0svOVkzRlkr?=
 =?utf-8?B?MkUrUlVrVE83d1dDRUZ3Qmx5MGJ3Wi82V1NrTXpCTGZwcllZWk53V2d5L3Mr?=
 =?utf-8?B?NEFBcmpFR3dUMklsZ3hIQnQrRVg2cElicDBEQVVaTlVtdnhub1ZSSEdSNlFx?=
 =?utf-8?B?WXVVeFE3L3M0MGY2b3d0SnpwZGVTeWsrSEJKUDE2d0srU3RUZWVCY00zV2hu?=
 =?utf-8?B?cmZwNFVpRmM3QUFvT2I2UFZJYVpGSks0T2VEbEV2Y013TDFhOGpYMG1MM0s4?=
 =?utf-8?B?WXFzUTZ6ZkJlOUQxWW5hV095U01DdzQ0anNxT3lTclVrYTNUNFcvYXZKVkZa?=
 =?utf-8?B?T2JQOXRaMlNZSWlKbHJYMjF5NVdVeTlsblJORjRvRFJkb1FwUHkwaml3ZURB?=
 =?utf-8?B?MFF6bDJjQkYwZmJGZmJKazA3YkdTeitTUVFDUURvMGVjREliamlwdWR3V0lv?=
 =?utf-8?B?VXI0d0djVFFDM294MERNV0FTS0loYjBqS29nOFJXSW5qMVUrZnJWRDBJVXZ3?=
 =?utf-8?B?Mlp3M0FtQ2Mwc3ZWL3RqblBWS3QzM1QxbHBHaUNNbUV0enFGSDNWRjR3dSs5?=
 =?utf-8?B?NEdFTm85TXBXSVNvemFYUFQvd2ttaHdmZnRaa25tVFk0bGtEbDZCZFgzczJI?=
 =?utf-8?B?cCtKcVlkWDlFVmVlcXYwTDQzdkY1NnpYTTFvVXM2Wm56L0V4VUlQeWJSUGps?=
 =?utf-8?B?SUkwZjZ2Z3ZKNm1yYVo3cjR2a29waUhKMkZ2dkl3ckJlN05uN3IybHBSZFBz?=
 =?utf-8?B?NGhqbXZzRzRta1A2c0ZjZG1ROUxIMzZQZ1A4Y2R3c1hyTjFUaE4zY1ZTR0RZ?=
 =?utf-8?B?M3FidUNIQjNKOHZUZEtKeFdwbHVBVnVoMU5xWHNNZDZaZE1Hcm01R3JHc0ty?=
 =?utf-8?B?bkNQQnlEaDZzWUlwMXNRZ24zQk1Vb0hNU2U0TUNlZlVYWkUyQ0QybWN0c3dS?=
 =?utf-8?B?WFkvYTNEM3FFMW03NVZjVGlDWmNzVVNJVnNyKzBhSE5mY0pVck51ZjVkUGJp?=
 =?utf-8?B?dGwrNFFQeW5yUzBlR3ZsMDZyRzYyNFI3S2toa29KVEtTQ3BVcWc0bXhkWlB0?=
 =?utf-8?B?U0ptREJlRXcrQUdaN3ZBY1RGbVltNm1oNnpHeXZiM3NSU2VMZEg4L1BqS3Jj?=
 =?utf-8?B?UWRBWWx1dGJKeHYrc05QOGNtVG5tb3ZLVkhLcjZJd043M0JTbmtwUDBLcjhE?=
 =?utf-8?B?UEF4VktMclV6bjQzT21SM1FTTDdETjQ3MXVnbjYrWnJTeXQ3OWkxYlcwN3Nm?=
 =?utf-8?B?aHd6MmZHd01mZ3BzeW1aRnk2cWdMaEk0L2FPN1JoK3RCSnA0dWFsZlpKN2JF?=
 =?utf-8?B?aFVSNWhHYW10d2UxMzBEUUM0Q3VwQ1dERWVjbnhvd0ZEYXBwTjJ0ZW5heW5p?=
 =?utf-8?B?MHpLdXFpd25ZVnM5L0k3WHRTTGVHR3VIQjJ2dVhrQ2ViSFRybU5rdTJzNDJ4?=
 =?utf-8?B?WDRZMFRRc0RPby9lTjJCYmpUR0kxbERaTkZQSGZPQklLbUQ3dGM5NUdHaHdH?=
 =?utf-8?B?VGc4ZEkzaVo2b0Y4UGN5V1dmenVTSjR2ZGQveDVhQTZ6TWlmZVNFZXpBTy9Z?=
 =?utf-8?B?M25VSlY0Mk1ndVYrM01ZWXhsRFRFQ0JxNmVvKzFiV2RrUE5kR011T0dpNXBh?=
 =?utf-8?B?YVExcjdlRDZnYkp6d3laQkFTNVM5bWEwd1NUVDVNQU9JY1JoQ0U0aS9lSVla?=
 =?utf-8?B?U2NxYVJMQjU4NW1hQWVBTTVDVjVnL0JMdzJpOWIvS2JnQ2MvYjBOMjloY2NK?=
 =?utf-8?B?empGMGNpYmpnYUdaaVMvSCtBb0htVG1Wb1drWUl6UjJ4S0dKeWhSeDd0Z2d4?=
 =?utf-8?B?R1lLaWpCUllMYmJlSlpYTXQ2UU9helhqbUp5M1EzeFdKWDNpbEhRTStlU1VW?=
 =?utf-8?B?UVJ5ZC9rc1RYb2dLRUVPUGZWS293emo2SUJKSk1wazJpZ3c9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 01:56:02.5502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb60db1-a8f1-40ad-3912-08dcf94f2cb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8997
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

Use the dma_map_page_attrs() with DMA_ATTR_SKIP_CPU_SYNC
attribute setting to handle the dummy page overlapping
mappings.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 256b95232de5..b2033f8352f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -78,8 +78,9 @@ static int amdgpu_gart_dummy_page_init(struct amdgpu_device *adev)
 
 	if (adev->dummy_page_addr)
 		return 0;
-	adev->dummy_page_addr = dma_map_page(&adev->pdev->dev, dummy_page, 0,
-					     PAGE_SIZE, DMA_BIDIRECTIONAL);
+	adev->dummy_page_addr = dma_map_page_attrs(&adev->pdev->dev, dummy_page, 0,
+							PAGE_SIZE, DMA_BIDIRECTIONAL,
+							DMA_ATTR_SKIP_CPU_SYNC);
 	if (dma_mapping_error(&adev->pdev->dev, adev->dummy_page_addr)) {
 		dev_err(&adev->pdev->dev, "Failed to DMA MAP the dummy page\n");
 		adev->dummy_page_addr = 0;
@@ -99,8 +100,9 @@ void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev)
 {
 	if (!adev->dummy_page_addr)
 		return;
-	dma_unmap_page(&adev->pdev->dev, adev->dummy_page_addr, PAGE_SIZE,
-		       DMA_BIDIRECTIONAL);
+	dma_unmap_page_attrs(&adev->pdev->dev, adev->dummy_page_addr, PAGE_SIZE,
+				DMA_BIDIRECTIONAL,
+				DMA_ATTR_SKIP_CPU_SYNC);
 	adev->dummy_page_addr = 0;
 }
 
-- 
2.34.1

