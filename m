Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE4BD70DE3
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 16:17:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFE2210ED00;
	Thu, 28 Nov 2024 16:17:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rnAyRr+a";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F0AF10ED00
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 16:17:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhRKfqsGx0iI8FjHSOIZvgqhBsvDs9AzdCSysmJf/CpXbXPrV6a5vHFaYg656r5Y/4DXJ0cJ0r37h145C+BirUT1l/XzRmqhKGWh0dsmVluwgKrg4/WbNCb5dRr/CW7MMQGI0fuALVYAjK61DhDI4b+6W9jc/nfWlMjgrFoZCs5IZBJOWpnF8IHqsHbdWinLGl+jipDqwom3ACEqkeqjWD3HcIpbwHkV9IUe1hwKUCfdUxN2TtFnbyVoUNhDIQXOzAm5h+cRw5JPKCQ0w0LefCtwmKlY/be58M0IqxPsIqDTupMcHsRJfcsWomB6p935Xak6jZ9fCmiKu09BkOjyHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwQ7XTLUgxb9UPk+mwJp71TfCS6z3HrtE3xiYUazQzU=;
 b=aqnR1TnAkb9aUpVbhoQeLfG+OWTPOYtpYZr7L1b/P61SiPrsTaSVm6dBnWPxEdrBsQ5PDhgpV415fjkt5bOy3/FrOnlsmylcFrkazhHCwYysnJYxSNdLfckRhbxx9a3DK9ulSrF/5FXBovlKJjyW7vUTUSvNWJCBW8fSbzscTbhupU0JcC6baFd5r4Lo2mXrqqVPyhiz//3fY2QxadsySAv8bO0VtjP7KZyNYh2/eyjNqghVUyZw5xhQigVDesVALf6lnCC7gIc3aBqCEaCFXwHohCFs926P1bum+9fR1pdRHo16y4xbjIRmhO1DpNPGpfUDnsjejzLRZRTk5DQ4MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwQ7XTLUgxb9UPk+mwJp71TfCS6z3HrtE3xiYUazQzU=;
 b=rnAyRr+aVUpID8UgfhiJ6XRw7GFKbAy6rVXSZyCq5DoIT7lm/KW1F3Tno36zfI+z9gV5IVuSW23/ODxJGRsFuQJ3T+1tqiGpkkyvZxVwEiT1WKZ8qy2LyAIi9zvPl/tQfD8SgDrx+edMVYjTbo/aOCsD7RyOMyrQBVZZ1D2oTUw=
Received: from SN6PR2101CA0006.namprd21.prod.outlook.com
 (2603:10b6:805:106::16) by LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.23; Thu, 28 Nov
 2024 16:17:26 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::ff) by SN6PR2101CA0006.outlook.office365.com
 (2603:10b6:805:106::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.2 via Frontend Transport; Thu,
 28 Nov 2024 16:17:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Thu, 28 Nov 2024 16:17:26 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 28 Nov 2024 10:17:25 -0600
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: hard-code cahceline for gc11
Date: Thu, 28 Nov 2024 11:17:11 -0500
Message-ID: <20241128161712.168408-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|LV3PR12MB9356:EE_
X-MS-Office365-Filtering-Correlation-Id: deb7e5e4-3c42-4162-e810-08dd0fc8263a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7XYcDrnI5N0zhg7N3KGGFj70685hhXZCjSK85Z78fmeOUJ00CCQ/C/dTaSQN?=
 =?us-ascii?Q?dHi4njH2bqINfkvIevX3vUa+chDxFBGIWi1gnTEQs5T/mILIdno/40myEpLE?=
 =?us-ascii?Q?EaUAzkvxZXCOHyPwVolcYHPRWEwYUaHr9nDZjsjjqSljzNnAcKrKlz1Jn5yd?=
 =?us-ascii?Q?AckRf4kRJSqCtGBpOlXj9E4Z9MvfzRFy1w950RtSaPlpfGvCd58QO6n/iG/Y?=
 =?us-ascii?Q?t6c1IbdqX4jh6mj+/LjM6soDiq0Iw9bjqw3ZKV/0QpZIZ/U/KivtFSZPso1/?=
 =?us-ascii?Q?Z0meqDU+zlXCRj7AxZnW+ukFCrAFNjlrZB+DJ+geBes3H8yXsrDUM6LsXj2e?=
 =?us-ascii?Q?OGo5VdhBovSOvwFGeAblulqK3/vG18kN0mkVF8jhY2WeQkTSZdDv8/lLG98j?=
 =?us-ascii?Q?VaeZ2LcWkhH9Su2Gbpi90bLbc/Y+B7I0tuFaH1jb0WgkfgXn4w6NCV/Vgg6R?=
 =?us-ascii?Q?5bMopumdFRNhnDmExuOqgtHvgHXPcNpfY5l465E6t0KIGH7jCxmAyuIBz91B?=
 =?us-ascii?Q?HbVUePiD2Yi18BsR07a9DsO8xtNS1AnPxrKp1KWR0YWfnYSnmzMpmjlnqVym?=
 =?us-ascii?Q?mSOJArFidCgktdrbVyKStLsnxQA6DIiVMrHfP9UT7t7L4+vIlAzq6OAE29PS?=
 =?us-ascii?Q?gRjldQvqysmujJl28jlZ+9YLV4hcTI+h5TyNZkuWgy1pmY4pGCwMEDkcZRsj?=
 =?us-ascii?Q?sPqnHpFVsNoHwzSH71HaN/nXXObRdO5IuIPwwFlNYpzyf+F5RNyD+OEKFxvt?=
 =?us-ascii?Q?gF7W7NKGUv1QRtp61awnijCgWtg/NBB5+Q4Vp9wgxkzj3eU7NCT9UXa8ZkHg?=
 =?us-ascii?Q?fvWIqU6tzDn47nZ6ukqnSiA1oqa5B/UTD3OpazaP18QuIQSa2/C0ZJ1Ns08y?=
 =?us-ascii?Q?BU8lsghKryz9V/BeYCyhTz/R4M8u7wKaJ5rjMztrqPtANC4y+mjq5x2gqmsa?=
 =?us-ascii?Q?HQoxUFzT/Sr8q+ntvXDx264YxKreFivFGO2r41OP5iwe80tuqY+2TcUm4b0c?=
 =?us-ascii?Q?K678e8fBVu3W8KDGk7UPA374khN9t88684uoJ6W+f+HFRRf5bo86Rz3OXFye?=
 =?us-ascii?Q?9UQq4qGjC/Ogs/4j3rtYTiumotRtm3PzuwB1QpgW8I+vSZRByJ01RvWpqIyZ?=
 =?us-ascii?Q?ZAPXK4fFUvy+/koNwAcF7M9tNxceGfNTIU9I19kBiHQ02C2R+kSzMGcFc2xM?=
 =?us-ascii?Q?1xiPiV4pWQaLXohcyM3WlC+A5lal0CHHAVP1ccEctE01OHCf7/Y7s7gN8KOP?=
 =?us-ascii?Q?+4uyfNgl5MDDv23LsEZC1FZuLGzp/HsV/t5mWYc88782MWHALhnz6u/HcaSN?=
 =?us-ascii?Q?2MjoVJYezBPcl5CbnWKfN52L7FPIZpa3TQJLC76w7ZspbJqcLQN4SAhLDeyL?=
 =?us-ascii?Q?lZ/s4dKOqQJDh9LzGx63dMSlYMbyTvqOcoBfsz9MS3iGy1sk5UUHTBfovtJL?=
 =?us-ascii?Q?on4awlNgD+/CHveVou0kBvQnYbzg05xV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 16:17:26.4967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deb7e5e4-3c42-4162-e810-08dd0fc8263a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9356
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

This information is not available in ip discovery table.

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 723f1220e1cc..3ca95f54601e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1423,6 +1423,7 @@ int kfd_parse_crat_table(void *crat_image, struct list_head *device_list,
 
 
 static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
+						   bool cache_line_size_missing,
 						   struct kfd_gpu_cache_info *pcache_info)
 {
 	struct amdgpu_device *adev = kdev->adev;
@@ -1437,6 +1438,8 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
 					CRAT_CACHE_FLAGS_SIMD_CACHE);
 		pcache_info[i].num_cu_shared = adev->gfx.config.gc_num_tcp_per_wpg / 2;
 		pcache_info[i].cache_line_size = adev->gfx.config.gc_tcp_cache_line_size;
+		if (cache_line_size_missing && !pcache_info[i].cache_line_size)
+			pcache_info[i].cache_line_size = 128;
 		i++;
 	}
 	/* Scalar L1 Instruction Cache per SQC */
@@ -1449,6 +1452,8 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
 					CRAT_CACHE_FLAGS_SIMD_CACHE);
 		pcache_info[i].num_cu_shared = adev->gfx.config.gc_num_sqc_per_wgp * 2;
 		pcache_info[i].cache_line_size = adev->gfx.config.gc_instruction_cache_line_size;
+		if (cache_line_size_missing && !pcache_info[i].cache_line_size)
+			pcache_info[i].cache_line_size = 128;
 		i++;
 	}
 	/* Scalar L1 Data Cache per SQC */
@@ -1460,6 +1465,8 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
 					CRAT_CACHE_FLAGS_SIMD_CACHE);
 		pcache_info[i].num_cu_shared = adev->gfx.config.gc_num_sqc_per_wgp * 2;
 		pcache_info[i].cache_line_size = adev->gfx.config.gc_scalar_data_cache_line_size;
+		if (cache_line_size_missing && !pcache_info[i].cache_line_size)
+			pcache_info[i].cache_line_size = 64;
 		i++;
 	}
 	/* GL1 Data Cache per SA */
@@ -1472,7 +1479,8 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
 					CRAT_CACHE_FLAGS_DATA_CACHE |
 					CRAT_CACHE_FLAGS_SIMD_CACHE);
 		pcache_info[i].num_cu_shared = adev->gfx.config.max_cu_per_sh;
-		pcache_info[i].cache_line_size = 0;
+		if (cache_line_size_missing)
+			pcache_info[i].cache_line_size = 128;
 		i++;
 	}
 	/* L2 Data Cache per GPU (Total Tex Cache) */
@@ -1484,6 +1492,8 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
 					CRAT_CACHE_FLAGS_SIMD_CACHE);
 		pcache_info[i].num_cu_shared = adev->gfx.config.max_cu_per_sh;
 		pcache_info[i].cache_line_size = adev->gfx.config.gc_tcc_cache_line_size;
+		if (cache_line_size_missing && !pcache_info[i].cache_line_size)
+			pcache_info[i].cache_line_size = 128;
 		i++;
 	}
 	/* L3 Data Cache per GPU */
@@ -1563,6 +1573,7 @@ static int kfd_fill_gpu_cache_info_from_gfx_config_v2(struct kfd_dev *kdev,
 int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pcache_info)
 {
 	int num_of_cache_types = 0;
+	bool cache_line_size_missing = false;
 
 	switch (kdev->adev->asic_type) {
 	case CHIP_KAVERI:
@@ -1686,10 +1697,17 @@ int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pc
 		case IP_VERSION(11, 5, 0):
 		case IP_VERSION(11, 5, 1):
 		case IP_VERSION(11, 5, 2):
+			/* Cacheline size not available in IP discovery for gc11.
+			 * kfd_fill_gpu_cache_info_from_gfx_config to hard code it
+			 */
+			cache_line_size_missing = true;
+			fallthrough;
 		case IP_VERSION(12, 0, 0):
 		case IP_VERSION(12, 0, 1):
 			num_of_cache_types =
-				kfd_fill_gpu_cache_info_from_gfx_config(kdev->kfd, *pcache_info);
+				kfd_fill_gpu_cache_info_from_gfx_config(kdev->kfd,
+									cache_line_size_missing,
+									*pcache_info);
 			break;
 		default:
 			*pcache_info = dummy_cache_info;
-- 
2.34.1

