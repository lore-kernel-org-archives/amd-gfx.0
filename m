Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030BEC02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 07:28:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 827AB10E48A;
	Fri, 14 Feb 2025 07:28:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mLyarpsq";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B4F410E48A
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 07:28:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXyaP/Sw1SewIsH5SvD72l7HeIYiRZQgt5mFI5wqb7cRmGP51V5tPuBoDWGwFwHBHQ4XsjxhSvPtHdSpt5QvvJJRBAQuUcWnr8tcxHBzyUIx4+LFydpFCgs/fkSUVwKBbTTLfJR0ktzWXKv9bM/l9wpawIe/GdEs1bsaOIFw+59tbr5TxmDN+sZenJIIUGhoIA6fRxdOU7Fj9XhGgI1PJCRz3hCoYh17iLcIZ/DjOBy3Snd7fvisZjr4LYIOvwdc7WHg+y+Tcg0Md+LRKbRXXuri2oSzi42ibFwxo3Nq7aygC7p59bG24iDGsLfh45GqGj/38y5FYch+eBbJLBg84A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyD8TUyc5ZYdWSgJXUSToXgR3oS0HMP0JVrers+ym/0=;
 b=h9dqteHfRYHCsH1zeqQqE+6SEc2UoirZx51kqbj/D19owy3gfm5huwHkN4XpNKFMdmZQTOCddGzQnP/yaseWJKlThvXzlHAxCgaEdHYMQ/dyXGTwU6n8LcKbk0N9cUYFX3sPfYo2OrGbLtvivKeETx0SAXplb5OrhgXANGRfj6TLtYnzb0ObPMO1kaZhNvEcHrXndEUIhjHTP/rQKPwSHTVNL5C55HF6kpy3mit66p+27+p5DbTDPBoEdvWy/VcyLwbla3YPa7yktb8rwkFlNvY7b47B7T8IiwhMlUTt3BEXq7MZkQkl7KGKXEaoaH1siYNXEcMveGTao2VLRC1HEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyD8TUyc5ZYdWSgJXUSToXgR3oS0HMP0JVrers+ym/0=;
 b=mLyarpsq69GtCgqPs5uFuHxSaI1wK/xgBFbEqNW+5ACShztcRHpp2oQoodiFwZdkzbIJWGmUi7zZ8hRpY2ijLB0qvO03orMBgaTP+8MW184lT9MoNG0nMWRO2QemJVYdXLUpwsQFi8GPKg9yHNNqAf+Wj/SYZcHZ3FBUX9yfbZA=
Received: from PH7PR02CA0003.namprd02.prod.outlook.com (2603:10b6:510:33d::31)
 by SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 07:28:33 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:510:33d:cafe::84) by PH7PR02CA0003.outlook.office365.com
 (2603:10b6:510:33d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Fri,
 14 Feb 2025 07:28:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 07:28:32 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 01:28:29 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/pm: Limit jpeg rings as per max for jpeg_v_4_0_3
Date: Fri, 14 Feb 2025 15:28:16 +0800
Message-ID: <20250214072816.332991-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|SN7PR12MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: d3326824-0a96-4cc9-51db-08dd4cc92fb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1P54Zq8TE5KNOt1hrBuxZlCwVjXqD3VGsSrbGYlxgk4uyAcSsVn3MWa/hzGY?=
 =?us-ascii?Q?/NrWpGcivDxI3I831k6d9Eq8+YyBqsf/LARz4859wWt1jpgMY6odsyYk/WWG?=
 =?us-ascii?Q?wqhF7IPmncwyGFopLfpMLIQtBGE7ANeLb5mzEWKzO70/itHDyLp32v0KZc1G?=
 =?us-ascii?Q?9L/VaGvTy78AL2S9OS1v9epZfmw1WXwmzW1LQ71Oe6DUKlzFfoY5Th5+wtpK?=
 =?us-ascii?Q?M4yh7smhoA6F8RCiY/pnQM5jFMYJNkIUrYVNsr3i0anMm8ixj+2c0k22NuyD?=
 =?us-ascii?Q?g5pah5iLJnyJ2rHdB7mIFSBH7tsUs2dgLpxjKHf1ML3g30qvZ7liOzrpxm4D?=
 =?us-ascii?Q?rv2bow5p33YpjbZMEdGt6DFAH8ZtmMyBNv2MmHS7SBNnbuPkAUpwGXd+ENcX?=
 =?us-ascii?Q?P1ZRcDrXykA4xdv3ZhNhCgA/QYdLIexCRq2sdxp/qEc9g3BbIlk9DxjWLJzg?=
 =?us-ascii?Q?3bBLGvvC7inNo7ypLQoiBtp5XWmQofU/IB2cME8LGVLXMS4XInG9aNGiTM+4?=
 =?us-ascii?Q?ZNHkYyRYhYoDUQSYooZtGXBXQm7VrjOfMpgT29ylz5HmFicg0qUK0NvqYflS?=
 =?us-ascii?Q?1luOdBwDsWb+qFcI4HlSeVvSbzcuS/MfSmJqA9L0js+SaRNwRKWjOF4yLtyj?=
 =?us-ascii?Q?YMJz3KqCKDgXvr3n78A+SmO+QckgMYSsAfwPRs7pH0GzJmLcUx16cztY+v1y?=
 =?us-ascii?Q?V8fkvvgoYFJ6vJ4qvaWosVlHiimVwIMabR312cj9MCcCh+cvBOaxGJWzITvz?=
 =?us-ascii?Q?rxXQxZuy0nuyQKqN8rNxDr3FPHlbvvwjUVa8R+4vuAxViLMNGHR3vt3S4/LS?=
 =?us-ascii?Q?RDr/0DyGlBdGkWS4eOOmozdnSqC4+iFs70gGTDYLMznA8MQBjvoK5EemZEP0?=
 =?us-ascii?Q?6uXeBp5lih2+XTHj4XJ8z6ar5s+ZblLJMPHCKpIfUHnm73A6k8tRTxGb8d5p?=
 =?us-ascii?Q?csjqTK8WMAy9P0tdP1PIzCK8RK05lnq2atODybPDONRsMKOG5XP0Q6gMxxNc?=
 =?us-ascii?Q?aPlBtZFzdXRVRNCfGOXvl7eGs2PKxiQKedZLT/IVF/XZXiaLFl6XjOs3bF82?=
 =?us-ascii?Q?ft0TI3XyGKiMpC5TyYMq04nuuPzIx543G3t5yR+2SM4sutsZd1OdnUPvlBCV?=
 =?us-ascii?Q?qi9ZSb8SCtKME5O5+kBwd0ZpFptVAv3g+uzHLrNAtrdXj5qlax+vRyXQhtNT?=
 =?us-ascii?Q?xHPqEC/wsb6W2AOiBGsXr+FPnlONVn3s91Q8QAmAgfaf9hFSeA1hRtpwNIpg?=
 =?us-ascii?Q?aIPw7rNN5rBUy6xPAS6LHvUFBd5acA4AH2P1L1d8iscOsdf/P9LIghvRmQZv?=
 =?us-ascii?Q?Cb7CYTT63QM4i2wJdDEEnpHA5Rxbt85L3Y8JB6Inb75vovpiqdf01+nXuoY6?=
 =?us-ascii?Q?+W5mfaMziA1T/fEsZyf+EBSKPN4NACZQwAEEqV/YBPHfwf7YK99hlREL5YWh?=
 =?us-ascii?Q?5VpIAlxvHxTjkgFDw3+j8arTNDn2Wu5Y01HqML5QlgzVxTmrT/F3mg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 07:28:32.7268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3326824-0a96-4cc9-51db-08dd4cc92fb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6839
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

Since pmfw supports for smuv13_0_6 is limited to 8 jpeg rings per instance,
which is the max for jpeg_v_4_0_3. Limit it to same to avoid out
of bound access.

Fixes: c80feef27112 ("drm/amd/pm: Limit to 8 jpeg rings per instance")

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 3fa671f4981c..9f2de69f53b2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2644,7 +2644,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 
 	per_inst = smu_v13_0_6_cap_supported(smu, SMU_CAP(PER_INST_METRICS));
 
-	num_jpeg_rings = max_t(u8, adev->jpeg.num_jpeg_rings, 8);
+	num_jpeg_rings = AMDGPU_MAX_JPEG_RINGS_4_0_3;
 	for_each_xcp(adev->xcp_mgr, xcp, i) {
 		amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
 		idx = 0;
-- 
2.46.0

