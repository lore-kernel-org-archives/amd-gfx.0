Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2FBC02192
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 12:55:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C94910EAA4;
	Fri, 31 Jan 2025 12:55:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hSbaL91u";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3EF710EAA2
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 12:55:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=br9brEoLNrQOrb9Nd1OqWXP007S+d99aLnr46un+WoP+YchU21U4wLAry2AnLg00SRQX/Sau/Yzg/KsMRHzDOH7ky9XX/FZrsydg8REpUg2WLhjYjGcEmJiKsaYA3QyOH1NyTB/e58lH4H8CPwiwk0JePGYb69oG4MMD9qR0atgJc7h6Z/ZHHxD1lNGTWynOqXaOCqa3RTgZWLLKhU84X51PriwuEJMSwvxLvY4Ue7AzN/r461KsAkB25+cI8SllTtZgOt2uN4QVZ1CJoCGxTlCAMP7wDa0vgMKddjmUyKJmyoOMQ8Xi05Cibv8ImgZ6xlx1WuMezHL99hHZgfzHtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+JiJurkGtTDwOJRM57IBcobIRfP3qXUtGrxaKaon94=;
 b=PFmnX+redMNrXHiH82UDXPKviAiXKEDXjd5Jmam70zdp5joIafkMMfR3vyVSlsMFbtKfbhf4H+/MA25o4AG9MwwZ3xJuYz5kjmWTeRqvMRqsaAdzq+IbcYPEsdb9EfP6/h2SXYbgxjChqPP/sTt16hT3wGM7Y4ypN9cZlI2xXztsJQojr2YuwLgpW60zPIPas36UYaH7PflRk1wNaxn8T9DJNY4M37vDEzaq1V6nIRnbR59I+LTLflLrPBid1tCviNIZ2xLF0SOAHc2EAvVTbhUv4tn4SplrUwOT5cakhlsj1nr5Z2KcUGgXUh7I+c/HvTu9hculflUxY/0qEXbzQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+JiJurkGtTDwOJRM57IBcobIRfP3qXUtGrxaKaon94=;
 b=hSbaL91u79T0getdTjvbEJWFjF+PpzXZujNuUAryOI9D5U+UEos7xdLNOd4x2V6w07Fqu2ujydoWhwo4ptZEsvc5eIs6CAzKJqcbImGVtK8se4Srz5vMnDVnvHm3PkFGvQCFTrTr1uetL2/EXFBjgASxpGeA4aIgC8cYssNYuvw=
Received: from PH0PR07CA0009.namprd07.prod.outlook.com (2603:10b6:510:5::14)
 by PH8PR12MB6889.namprd12.prod.outlook.com (2603:10b6:510:1c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Fri, 31 Jan
 2025 12:55:37 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::b8) by PH0PR07CA0009.outlook.office365.com
 (2603:10b6:510:5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Fri,
 31 Jan 2025 12:55:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 12:55:36 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 06:55:34 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Limit to 8 jpeg rings per instance
Date: Fri, 31 Jan 2025 18:25:18 +0530
Message-ID: <20250131125518.1792987-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|PH8PR12MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a552b24-c315-4db4-576d-08dd41f68ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?phtIBVFA2l4StrqbfLRfb//K9KtJYwa7OiE9J+pKyOoolonnRVa8aqo/B4Mf?=
 =?us-ascii?Q?prdPL1Rpo5I1Bd4hNSZ/qDnf9a074nhwFW9Ir72Lis3L01aJkA6a8G3+ZjvZ?=
 =?us-ascii?Q?CCNLtDQxDiRciVmpYa7U+HMorUVfbxq79bzTrgaDUK4rwmihUIGv1ZsTD6nE?=
 =?us-ascii?Q?l5A37tf8C+eViqXugvbX8A+/F4yxzh0iqPo0msbVim24Gc0RS5vcvykKV0xN?=
 =?us-ascii?Q?qYnXrNekTFBZcdqM4LCpCIEeOXNeAUzBj4cCvUpdBg9mgsbx1Z0z53G35ucb?=
 =?us-ascii?Q?g3iZO1R8dK0jBT2Mk2JGimeroGtsUbDowM/Mav0Q9rOQVBCBtaYw/HIKoxMx?=
 =?us-ascii?Q?//csVSCdeTJGwAbrZwoJYsc3LQS6LYtWz//w6DWrAm7D1c3i1bMMVzdqTvKb?=
 =?us-ascii?Q?gV5osksuGeSPdjGppzu7aGO+yLPLn/pU9aJb8xsnHi5vo66Bem4o0WXt2FGR?=
 =?us-ascii?Q?kQbPgnKp4C5SuDUo4Hrx7AiHkxtJVqXqqaSz2DoNGL1hD2Q+c2wjOEPuANwC?=
 =?us-ascii?Q?Z4FQTzLmVOgNcClg4Hj+Bhe4j6iTLuviirqoUqXpSdrAECkSD8pn11kmNME9?=
 =?us-ascii?Q?kwiijYAXaBUQTCdl6yr+YtyF68SpuQD5inpzF/Yiuj1U9zHI+537n1CdiG7p?=
 =?us-ascii?Q?A77dHueUArcIUrMjfWnlrY19XkFzV6cvZyFeLkXAPGvDo1HoN5rloOrfvvHX?=
 =?us-ascii?Q?Wo/Q8FjsYu1aDiibNo7tYtD9W6fr730UUVP1P97V36PzU2ylO8kXyvmMdmek?=
 =?us-ascii?Q?WGHUY2e/HZAhe9LmTcFUmKJwV9WkrjY/k19KMC09xYbasfDMWSwEtteC6YxJ?=
 =?us-ascii?Q?GTwphCQsDshdrRJv/dBxa7uOgt2KHvvRONqx/NfGc+C2KcOx5Ip6NnJZpO35?=
 =?us-ascii?Q?GzFDyoZOiOi8CIc7VJ0RFON5V14jr0GpdoCjmU4E2AcBBMLixlO34JftjH4K?=
 =?us-ascii?Q?8jkTIy5PLJW9Gai6VhT3sc6T2lMIVejzett5nLe0/0+pY6cehQaIBJ2CI9yV?=
 =?us-ascii?Q?N9NV9szxqnZH7/V/koSPtnRmqCTEUU3LwWWDvMwjEi55DimcMZz7lbWWUEbH?=
 =?us-ascii?Q?rC27WOs9BsSI+v1FMsvjgX8n/E7JoxmZU1VUki8VGF9axYTTWCQhU0McrztM?=
 =?us-ascii?Q?O199V2tcOiECGaNkja6OBANFUAucGNkmbN8H98nmqCOvNCr73CmiI2huJDEF?=
 =?us-ascii?Q?wwIiKXJJBng/e/aGDklfjQUGJxGTYFIyNTSPe0+E9VC/CRZOTyhNW4lXyMsg?=
 =?us-ascii?Q?kg12PrxMbOw6n6NTx4HQkVdB/zxURr0GpIkwK/e/evl70vd9L3RtnfywLg4F?=
 =?us-ascii?Q?ycJPSgvHyZ/bv68GM0vpSsTwnzOXkGZpnuCKHeFFjyQLRECELLR/OM9OuMKk?=
 =?us-ascii?Q?Yd20UfUlGEEk1GGEzVqfd2qir0N36Z4wwu+eJLILq7M6bnpSK+YIKZJmPArt?=
 =?us-ascii?Q?i9zwfvET8e0JvKycEwZIVfP+6IDOIvZbbDv+WiOurr+RI6VDyoDAuOAmxnAq?=
 =?us-ascii?Q?J1h5hgsWMry/amQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 12:55:36.7293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a552b24-c315-4db4-576d-08dd41f68ebd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6889
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

JPEG 5.0.1 supports upto 10 rings, however PMFW support for SMU v13.0.6
variants is now limited to 8 per instance. Limit to 8 temporarily to
avoid out of bounds access.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 7f0b4cc1141b..11591c01be0e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2513,6 +2513,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	MetricsTableV2_t *metrics_v2;
 	struct amdgpu_xcp *xcp;
 	u16 link_width_level;
+	u8 num_jpeg_rings;
 	u32 inst_mask;
 	bool per_inst;
 
@@ -2649,6 +2650,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 
 	per_inst = smu_v13_0_6_cap_supported(smu, SMU_CAP(PER_INST_METRICS));
 
+	num_jpeg_rings = max_t(u8, adev->jpeg.num_jpeg_rings, 8);
 	for_each_xcp(adev->xcp_mgr, xcp, i) {
 		amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
 		idx = 0;
@@ -2656,11 +2658,11 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 			/* Both JPEG and VCN has same instances */
 			inst = GET_INST(VCN, k);
 
-			for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+			for (j = 0; j < num_jpeg_rings; ++j) {
 				gpu_metrics->xcp_stats[i].jpeg_busy
-					[(idx * adev->jpeg.num_jpeg_rings) + j] =
+					[(idx * num_jpeg_rings) + j] =
 					SMUQ10_ROUND(GET_METRIC_FIELD(JpegBusy, version)
-							[(inst * adev->jpeg.num_jpeg_rings) + j]);
+							[(inst * num_jpeg_rings) + j]);
 			}
 			gpu_metrics->xcp_stats[i].vcn_busy[idx] =
 			       SMUQ10_ROUND(GET_METRIC_FIELD(VcnBusy, version)[inst]);
-- 
2.25.1

