Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E225C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 18:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E8E410F0B5;
	Tue, 26 Apr 2022 18:27:56 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2053.outbound.protection.outlook.com [40.107.101.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9860610F0B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 18:27:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5GIEHXokpE2VpQL50Q2WV08M3/atEa8psdvnCFbJoZhKDhaeZeXekid0N6Oo4jvJJf3aqh1SlqODH4AledCECB927ZC76pY3XBiFGK95TuzWSWaff3oyBtuRH715imJezH0BPFOHy6mmmDTjsL1YayP4gpCWzVa8m0TsVThB6GHIz/JxD4n+BCwhSohoSTUCD8Rw1x3Da78fIxNFdCeinAyZ1bX6zs65J7IT9iJZ0Oi9L4TuZmE/gR7pcXoERNlKMUgIsDrSHqS/jO05nL+80FoYc0k6vfKmTV36+WTabHFvqb72L1gJoffqgXa0viBoH1Qt/+YmmgvGzTDtB8Nsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyrF86JL6ripWiq78WrWCE++Wq+4D1jwLK/oucC2pGM=;
 b=U+AWP/nl3wp2StgkurVQpV4ic6LQnrt6NdMLIYSnZj6+csjs9Gpd2evbHS3XzArCtcVX3xlBvhxYf++A9b+NqPsutYPhO5r+qcyUVoUtI1m4+9+7FBYqrG/7VOAY4cQfALxBoX4cpxWgJ5WeYrxzPcaECTPjUDQH/SMxnZJA/ARFbfj9gdIX71kWrcZ+VuDeseqfv7Sg4LVT0V2JL6fAaZkFldf5KjntWwaAYoemJpaeOAa3ZxzMClgneZA3T6K3jCJt/JaVnRTuNnPJRwQi8Ngp8GMJoRYqx2TRNE/X04E2iIZrY+GdEC1WcNwxjjxM5YubU46DqSPJrfWUqTPLOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyrF86JL6ripWiq78WrWCE++Wq+4D1jwLK/oucC2pGM=;
 b=VDPZGdM6smedcRCIBfaYICxq7scmgkSLbLpC+S/WqGXpgEO7fz0HSuZUDRJxwrut5aMg8V68gyapP308ptJ2wwvF4owNUJlgwhrnZFuVCiAxQ/UIonhZohntZ3Yk3sYMbu4TOky33Do4c9V948skyLbhOZT/vfX5szkX+3kO6RY=
Received: from BN0PR07CA0019.namprd07.prod.outlook.com (2603:10b6:408:141::9)
 by DM6PR12MB4959.namprd12.prod.outlook.com (2603:10b6:5:208::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 18:27:51 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::81) by BN0PR07CA0019.outlook.office365.com
 (2603:10b6:408:141::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Tue, 26 Apr 2022 18:27:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 18:27:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 13:27:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/11] drm/amdkfd: add helper to generate cache info from gfx
 config
Date: Tue, 26 Apr 2022 14:27:28 -0400
Message-ID: <20220426182728.3006737-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426182728.3006737-1-alexander.deucher@amd.com>
References: <20220426182728.3006737-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e45a322-9025-4b9f-c17a-08da27b278b2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4959:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB495901392F30205B8BC590F6F7FB9@DM6PR12MB4959.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jZRl3xFqbC45pxElHHH1uwFe8yG+de4Vi6PJ8wbf/v0DylVhpTAUmvZjGWfa4uvNL1fSRAV6eBsmR6vtpvyUNjGB7A7D2hKyDAMtxPQDfGBQBpcbjQSja3zKSqwz9mQrF06foOafCGT01MeeNigPfd246urQTBdgAnOn6bpEE7OG7EqbGdJNYw84qe3y/WR/tzhbI9EC6T2JGILbXIqnfO+MKR9qU17DReJ2ofnD6gheNc1Z9JACBWd439mLFgTOmJCR4aKqiYuIPJniOnMFGhyfb2gzqVEteucA6X5AVICPkpi+WNBtzPO3Yb3QvdgEgRhW7a8pW/dHunVQ5kN2FzRKwBnHXWDJo8GjVUjfMgPVJXezfq8fjmgFSnuAhssVEAgCs0Jfe/RJl0VCth0l7SbQxaqPZ9RTMvQA9dfh2+EeBuHLBZ95JL6RvY/BrCpe2fD/hn0+Sv9ku3hFnVG2QIaD6d57ei7okI9dNEPGs4QTMjyqGYxnLVg6DhGTTy/P4b1XcUzAO/sVuLxaJVoa+oLiI+/Ds8FPwsv6FgMxtHuBHJKkf1OOkUElfhhu9zmRWH0+7Xanc5frdM9uVjFWQLGPQSSgIHuOO1i4cpjB/oi+lyVc4t/6WGcjwR16ESgepvXdRc0a/mMNzfcUxb2ZJFr0upLogEDnsEV4pL0K8hYqtSF2oZG4+ABkV8Na7kBNeN7YVOxj3iIj+nrr4CuTbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(26005)(82310400005)(86362001)(36860700001)(70206006)(70586007)(8936002)(6666004)(316002)(356005)(36756003)(40460700003)(81166007)(6916009)(508600001)(4326008)(8676002)(5660300002)(2906002)(7696005)(336012)(186003)(426003)(16526019)(47076005)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 18:27:50.8364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e45a322-9025-4b9f-c17a-08da27b278b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4959
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rather than using hardcoded tables, we can use the gfx and
gmc config pulled from the IP discovery table to generate the
cache configuration.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 72 +++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index afc8a7fcdad8..a3275139aaf4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1315,6 +1315,78 @@ static int fill_in_l2_l3_pcache(struct crat_subtype_cache *pcache,
 	return 1;
 }
 
+static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
+						   struct kfd_gpu_cache_info *pcache_info)
+{
+	struct amdgpu_device *adev = kdev->adev;
+	int i = 0;
+
+	/* TCP L1 Cache per CU */
+	if (adev->gfx.config.gc_tcp_l1_size) {
+		pcache_info[i].cache_size = adev->gfx.config.gc_tcp_l1_size;
+		pcache_info[i].cache_level = 1;
+		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
+					CRAT_CACHE_FLAGS_DATA_CACHE |
+					CRAT_CACHE_FLAGS_SIMD_CACHE);
+		pcache_info[0].num_cu_shared = adev->gfx.config.gc_num_tcp_per_wpg / 2;
+		i++;
+	}
+	/* Scalar L1 Instruction Cache per SQC */
+	if (adev->gfx.config.gc_l1_instruction_cache_size_per_sqc) {
+		pcache_info[i].cache_size =
+			adev->gfx.config.gc_l1_instruction_cache_size_per_sqc;
+		pcache_info[i].cache_level = 1;
+		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
+					CRAT_CACHE_FLAGS_INST_CACHE |
+					CRAT_CACHE_FLAGS_SIMD_CACHE);
+		pcache_info[i].num_cu_shared = adev->gfx.config.gc_num_sqc_per_wgp * 2;
+		i++;
+	}
+	/* Scalar L1 Data Cache per SQC */
+	if (adev->gfx.config.gc_l1_data_cache_size_per_sqc) {
+		pcache_info[i].cache_size = adev->gfx.config.gc_l1_data_cache_size_per_sqc;
+		pcache_info[i].cache_level = 1;
+		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
+					CRAT_CACHE_FLAGS_DATA_CACHE |
+					CRAT_CACHE_FLAGS_SIMD_CACHE);
+		pcache_info[i].num_cu_shared = adev->gfx.config.gc_num_sqc_per_wgp * 2;
+		i++;
+	}
+	/* GL1 Data Cache per SA */
+	if (adev->gfx.config.gc_gl1c_per_sa &&
+	    adev->gfx.config.gc_gl1c_size_per_instance) {
+		pcache_info[i].cache_size = adev->gfx.config.gc_gl1c_per_sa *
+			adev->gfx.config.gc_gl1c_size_per_instance;
+		pcache_info[i].cache_level = 1;
+		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
+					CRAT_CACHE_FLAGS_DATA_CACHE |
+					CRAT_CACHE_FLAGS_SIMD_CACHE);
+		pcache_info[i].num_cu_shared = adev->gfx.config.max_cu_per_sh;
+		i++;
+	}
+	/* L2 Data Cache per GPU (Total Tex Cache) */
+	if (adev->gfx.config.gc_gl2c_per_gpu) {
+		pcache_info[i].cache_size = adev->gfx.config.gc_gl2c_per_gpu;
+		pcache_info[i].cache_level = 2;
+		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
+					CRAT_CACHE_FLAGS_DATA_CACHE |
+					CRAT_CACHE_FLAGS_SIMD_CACHE);
+		pcache_info[i].num_cu_shared = adev->gfx.config.max_cu_per_sh;
+		i++;
+	}
+	/* L3 Data Cache per GPU */
+	if (adev->gmc.mall_size) {
+		pcache_info[i].cache_size = adev->gmc.mall_size / 1024;
+		pcache_info[i].cache_level = 3;
+		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
+					CRAT_CACHE_FLAGS_DATA_CACHE |
+					CRAT_CACHE_FLAGS_SIMD_CACHE);
+		pcache_info[i].num_cu_shared = adev->gfx.config.max_cu_per_sh;
+		i++;
+	}
+	return i;
+}
+
 /* kfd_fill_gpu_cache_info - Fill GPU cache info using kfd_gpu_cache_info
  * tables
  *
-- 
2.35.1

