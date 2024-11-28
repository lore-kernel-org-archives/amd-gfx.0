Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5858DD70DE4
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 16:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1122410E250;
	Thu, 28 Nov 2024 16:17:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k7qcDSpg";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0046410E250
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 16:17:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ex7Jgno1zWyxsdngL2b8Z6Y2gU2pNh7ZfgQ+bSguN2doedXMK++yPODKL4Vyubf1dZMROFDpdfvkuWoG2NSIQZ8vZyKgg5bWsgTTHEc4zIjjhxn+PPYRF5O6GjchToIBKuhCHxgXkJogTU6WXGvVW7D+lSeU8cjLS2QXThTgVtgpL9gRAx5F7M27VxPWKmRTUx/wBvgVv5n5EqL4pc87BUnRdlMVEOEzdY4ukb4ZCn9QX5zYaXlT3ezzJ+3gQ/qGBKHL2B45f5VTq83IOtRQ/oRxHYjjze12sI8RL7fJ22a4bbccZEB2UXevN4e4spFjXBDs598wTMwckRiAR2OcoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SkA6ziA+8uBWRAaTg3g0mMhbW/M0q+Bv3iffYHA1X4=;
 b=A0UABaUSOMUf1owfNn6eP5S3cnEe6UvxxS7xnZEwv9CkvS8vi3MPw/SPOaQlKDyWlx/W7pJijqxoDG4jnnxqhu5tKHWZ5fMKzYyvuwNIof1LEAqYfVvogLlbbRudXtfafCiVkrpQlBbKlP7YBEPGHr1ZKKU9NQhpAqM3ZR+60zqwj/Thlj/MvokhCnDRRXg08CnmDyw/iC9S041FYnyHku5MoGbYPvaeVi71xrX/MMPpHtn//FVaT/cb7KoUXVg9uBxZhhxy8rsPncNyli5UoshlXOdiq+ut5aI4bKOKe5ZpkERlG7A17d65qgRLvgX1GLIl+qPk/fyPJJmbpYcDMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SkA6ziA+8uBWRAaTg3g0mMhbW/M0q+Bv3iffYHA1X4=;
 b=k7qcDSpgCfd+qvXl15jVXBrVwYEBjH9iHSlIZEl0Sey8pDwn7/c8Fq1EOJ5Buc/+KK6+UHIE1s3b4F8JyeJY4YLLVjX19NdMXfuyO3y1XtrOIpoz/v0iZ34XrzEBeQlaCEIXBu0NpsffIN8B6tnGys1V4wVGCk+fSDEkFPmPXAQ=
Received: from SN7PR04CA0159.namprd04.prod.outlook.com (2603:10b6:806:125::14)
 by SA0PR12MB4463.namprd12.prod.outlook.com (2603:10b6:806:92::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 16:17:36 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:125:cafe::5e) by SN7PR04CA0159.outlook.office365.com
 (2603:10b6:806:125::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Thu,
 28 Nov 2024 16:17:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Thu, 28 Nov 2024 16:17:36 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 28 Nov 2024 10:17:35 -0600
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: hard-code MALL Cacheline size for gfx11, gfx12
Date: Thu, 28 Nov 2024 11:17:12 -0500
Message-ID: <20241128161712.168408-2-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128161712.168408-1-Harish.Kasiviswanathan@amd.com>
References: <20241128161712.168408-1-Harish.Kasiviswanathan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|SA0PR12MB4463:EE_
X-MS-Office365-Filtering-Correlation-Id: 98dc253b-3951-4da9-a823-08dd0fc82bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7H6GPhcqnhrTrvJIU96tCCD2fFiXkHA/SJ+AK1/oJqt7Sd59VNl9QOlskyEU?=
 =?us-ascii?Q?/GUFz7lhKnqtIJLNEC7blbHHGqoPE7zL8a69uDyHP9GruvOgejB5diF/JgD0?=
 =?us-ascii?Q?ouFXrKk7zgnwBJnNgkegvTnx5toMK7WsCPlPwtN1pEViBdGDW84Ts6HphxhB?=
 =?us-ascii?Q?9b3Q4gIa4qdIk7hOii3ObiWoMf2ciDpyzNFSSGk0dxirn7TUB92i477Kuqn0?=
 =?us-ascii?Q?mMWICKAunTlKvpMhI8ogtZEwAn0RvV7sTEEWOP7ZRIbHqSwaannSuik6iUij?=
 =?us-ascii?Q?KkzddUoO0SpIqTKkty1Ng+GEp6Np7I48fHk1lg4+DC1LHr3uFIqtYdsoebdj?=
 =?us-ascii?Q?/6p7EewI3FXn1dnUZ0/ZIQ0ZVZCvqunzk8ih5hPU1g2rE6nDOdHOAAEicmL2?=
 =?us-ascii?Q?aOPgfsnCww0pWCYF3WasBdv8/AGjladARdE3hP5tGKuL/hqX7W7ZNrzd5v2B?=
 =?us-ascii?Q?IwYbmFfO1pRqTCEarqGtup6hdfCdep4m7dvgbLUsY2kfAqHagSn8rySC4Wf1?=
 =?us-ascii?Q?w1k8sMFysVrtfyxmKqtvpiccCYX3VjzFIevW3wk96AwUjM/w5XTnvgFQiaUK?=
 =?us-ascii?Q?McSTV53PVEBkvVRoeBWVApkd5vG25MCrGkPZ413L9XItr+hAqe+/U3cwSKVH?=
 =?us-ascii?Q?DEqRcSb6e9uSO7pE8gfwbglNWBvKxbdDu+UiRTejgfJmRmkMuyuDN4JN1fsV?=
 =?us-ascii?Q?mHLXKxL4jCE/BysOtx6tJUx2pLkQd5195wRe6wh/ZlwS/zxbuDWNYDc/W+2R?=
 =?us-ascii?Q?mpWTzqgzlskBHlQ3OdTuN0nnyAiuQiREI15ebyN25ABTmM2qnrWY2V6UbxQv?=
 =?us-ascii?Q?I8+vH6lU5pRB+sP9TxbtEEiO2LW8GpGZxom6kIe88YVbdVr2E44pQj0JLSfx?=
 =?us-ascii?Q?O92egOC00ayTm2Z6hBa/SfZHFICTi4v51OeCE9aWgXXiZqWTaS7t6Q67RGV4?=
 =?us-ascii?Q?mfw1xCR3OwOprGlSxcogf6IUi18LauBF4SohLGC0JH299zAfpP7Jc2Y/UcSp?=
 =?us-ascii?Q?8uDbIlAVjXsQvdbqi/p+euaXCaYXECNRAzA1L+jzVen8LFZ63DGeWsXsGpyF?=
 =?us-ascii?Q?rllRt3+qlalf7k6FDGTLTA0YW8IVy8b5jq9Aa9zmQ42jwZG0xKe8QHI9mCU4?=
 =?us-ascii?Q?qcnIJneHC1jrhF2xBbl4etaTNNhHr7vapJrDvHwfaipm6/ugsW0Pyru5JzLn?=
 =?us-ascii?Q?26jli3ktRfwcDPDGfCDwc0ITr2huoBIJ7NUWTGp4fanXL47C4FWCHGHM1w4H?=
 =?us-ascii?Q?fvZeUl2vpblOoNp0M0POxyriMq+IN+j/fU/bH3ScCwBAZ6WOORU+3tBVOLQI?=
 =?us-ascii?Q?eB57rLWybLff1KQGcSqnx0ouMsr1DlB4yjNXZxmU39wEo44ewRV8HRlwWTjM?=
 =?us-ascii?Q?vS+CojJMxAhtkkfc3xkzJ9ptI4uLl95Q09QgGoV6milTNXg9HklZPR975eHp?=
 =?us-ascii?Q?C3svYlqhwyfde5/VlTgmdZBaCagmE/1v?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 16:17:36.0568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98dc253b-3951-4da9-a823-08dd0fc82bed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4463
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

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 3ca95f54601e..e0faec4682f3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1504,7 +1504,7 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
 					CRAT_CACHE_FLAGS_DATA_CACHE |
 					CRAT_CACHE_FLAGS_SIMD_CACHE);
 		pcache_info[i].num_cu_shared = adev->gfx.config.max_cu_per_sh;
-		pcache_info[i].cache_line_size = 0;
+		pcache_info[i].cache_line_size = 64;
 		i++;
 	}
 	return i;
-- 
2.34.1

