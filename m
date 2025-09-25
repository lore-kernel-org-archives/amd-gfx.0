Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35E5CAC5A5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 01:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 174D188697;
	Thu, 25 Sep 2025 01:44:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yCFfVK44";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20FBF10E6E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 01:44:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rhsv2N2M8o0uYb0YaYhsTN5ejFISycS/Tg4fUhlOTyuI3k091tg2oNkOPyJKdQyKDtGEXcXm869Dn9f9gEJNngwAMLfHxmiK/Ya0MK3alOm9pFYTGx4rE4O8bpaFGC7Z0BbgRg3cKWVuYTDNKWnMg+D7nsAvzLPyQlveKaZsFj7YKXKTj/UeES5tRjaSjLaZkSWdnvFHLkpWr93kR1FyHVGdyKo9j7Ca5W6Llr/AOPayunCo2PFZLOO5ruOIrMLyR9FNo1LskVzAXpew/rH7Klu1jOb5PmRYhFj5PC+o7oK6BpVMNy/TZmrQp9aTz+riu9by91nqlZ/72J/L/SQ16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFaPqHDXVylQ4n9pJVd4TQieXLBCD3drGbsb80GuE44=;
 b=pVU8YaGDamROVfVn+fXQXsCuQZ5/lZYxyicBV6SWC3KGnjdHOUz6sWQsnXc+YPSBH2Ru5n32eeybdnpjo4g4axXnjXezEykons3YHCPNwVjgNfDtUmVFKBuYRjQoYlDSV2Sxdx9n8CoXRlMi02SIcFzdkGlBOkK4RQ8enAq6HLeBAo2cr96H1ci9MKjzEFwWQVhIm7K0ixJbxwEwXrBiip2Ftp27KQdSaGvZ0JBwqgzZEIPUNYwCmoXY8/bP4hIc0Tx/tyZ0iU4WRAZzCqLs8mS5g2YshljlxK1D/XoN0SHECpNfjsthejFBOVO6+cQE0h6W0WyXgapz7fLgFHoXBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFaPqHDXVylQ4n9pJVd4TQieXLBCD3drGbsb80GuE44=;
 b=yCFfVK44YFSbR6OTofBf6mTxWlOn0qQ6lYTtYc8h8F3Oguz35OL83fQWSRf0dHV8y2eIhatikZHNGZgaGFwn6QwS/GFMCMD+tn36KLrTQ1C99/pDj9pMthjugcm94/rhmyvKnglJwr+lSGzMTwbTdef7OuGuK939YDSneu8hhWg=
Received: from BL6PEPF00013E0A.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:12) by LV8PR12MB9263.namprd12.prod.outlook.com
 (2603:10b6:408:1e6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 01:44:22 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2a01:111:f403:f90a::1) by BL6PEPF00013E0A.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 25 Sep 2025 01:44:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 01:44:21 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 24 Sep
 2025 18:44:20 -0700
From: Shaoyun Liu <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix the mes version that support inv_tlbs
Date: Wed, 24 Sep 2025 21:43:52 -0400
Message-ID: <20250925014352.338578-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|LV8PR12MB9263:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4db0e3-2c77-4913-d322-08ddfbd50c97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013|3613699012; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wss6A6/EGP5lG/wyChe3Rnzo1e6ykIhyPYre3VJfnpx/Ca2GNbEFymnLd+J6?=
 =?us-ascii?Q?MG9ZkqLJhl2NMvSJwEbmA7j7BcbCVMuhYHIHmQnxJzDQi+0sA4DzRP7zzP6l?=
 =?us-ascii?Q?WI+iMvT402KQODt1M4PplabYwwbJaE63Ntw8hJvsFI10/D2vjs2Y1EhD1U05?=
 =?us-ascii?Q?AMSlb+d+WsBDHHC+nGXc4ozd2juNNKAOpq4oUMDG3GRVvbB4z8WW8zdQwOXm?=
 =?us-ascii?Q?/Q/pjUmnJSMq5T4Z1VXRpzX0V89PEbemJtaZaEn0NwGaV9fw58yW54rfi0R4?=
 =?us-ascii?Q?KohxheOSH1obIvaccVtnU0aFSJePx2VXT3Mh9D1WPI8eEpGihwaLUs+qrC0d?=
 =?us-ascii?Q?TBHXSLHnLbe1EjsccHyxiA//RlcdHncqDCAWo98Jt1p04hzFaST9wOckujs5?=
 =?us-ascii?Q?E86Z8PvMrQjS94YJIBjAuLWlJuWnzssA+x21JdTubd5xTsM2grGf00RpRlfk?=
 =?us-ascii?Q?jVuui8jNA/0v6rrGtZLikdBRw7IC4PLqUQcf/5OhW7/BEIlhxJjYU4sHtOID?=
 =?us-ascii?Q?2f4sNt+nX+FoVRBKeDKyqnepIDLUvjH9sseMHPKIFqgoLUMHQ1HKvbUkT9kd?=
 =?us-ascii?Q?pW557etRgMxzFdTfhA5ouk2e2Ujeeczi8XmsI5DyWq7rvepBoY+EIETUzR92?=
 =?us-ascii?Q?tI3RAb3Fu0YsyoJFK4+mlAoSKX0IZqI3yvjQssyidjDijjcXzCzn9/Tyd4MC?=
 =?us-ascii?Q?q6vPZPT+RP7/rYx2hOTaPjO0Au5zvHyHv1bnzkXy5bKq8GQbKjqMsd87Vb9o?=
 =?us-ascii?Q?mf87hUP1od1DwVWIIatuVnB0qc1cKJKWy4EqNxW3jSpR0okhGCtmH94X5A97?=
 =?us-ascii?Q?U9K1AUVWQmYQE/7AFEJATn13eHqDP6l+4/tKHkNC74fWz+QD4/1Iap/2FYlr?=
 =?us-ascii?Q?r4iW5FycIsgRlCvZPyShDbaMhw2qMDXXMfOSx+HkqVz5bTt1wEQhDMCvhBYF?=
 =?us-ascii?Q?cE0JITvtOKrXAefdDsVpgou+U1fwL33NpHZZWjHe4p8X7Nw3jp9OsChATLKF?=
 =?us-ascii?Q?Pd8OEf6zGbX5mX0k/DayNRb1//zIQ0grkYEvjMT0iS9eN2+9Pf5lvCs0i1u5?=
 =?us-ascii?Q?SZ5ATxsbN9O6wmfB0Htfb/IV0TZTbKN9UIpymeJFOAtbpmR4qSM9PfA/+V2c?=
 =?us-ascii?Q?PaLTzQ+2WXh0ZiZCp5qYWP1OUrQZJPKeP8B44qks6iLjXe1EbBhjeA+w0yHD?=
 =?us-ascii?Q?m3VpeNKNRhsEGNy7xJLr2JW909y/zFgotDmv1rJh16PmYY31s8aVyjjKsVh8?=
 =?us-ascii?Q?W3CPbNTmB/sRL1Gxl2l2Si/slP19C2yNcs8+LY++CDHtAtU4w4njJMuhmyzd?=
 =?us-ascii?Q?GTSaBVtQIEG1N3MwMFOyhTGn7rBJQRl4rZq04xp52TaAsjCRuSx1nglaeNbW?=
 =?us-ascii?Q?IrxC128M2XBh4qV4iihkzZV+w9oBpHsJpW0LeepcBrTnf2d/XJmuTcTT6DRY?=
 =?us-ascii?Q?xcCE7EqfFOk8eKaZEbNph0QtAxnij6jVa+xeXm7q3ccEOPLbaFAo7qk0Czku?=
 =?us-ascii?Q?kiN8nM+7UFmGvsIIESJwaqBVSLQHEq5Mzhh4wFg1bFEKfeWFzHr7vWkYO2J0?=
 =?us-ascii?Q?n4ocr7bUdiadPz/PDOe4bXOcgywCr8Ph98JdbMM2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(3613699012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 01:44:21.3930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4db0e3-2c77-4913-d322-08ddfbd50c97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9263
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

MES version 0x83 is not stable to use the inv_tlbs API. Defer it to 0x84 vertsion.

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 404cc8c2ff2c..f4a19357ccbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -337,7 +337,7 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	int vmid, i;
 
 	if (adev->enable_uni_mes && adev->mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready &&
-	    (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x83) {
+	    (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x84) {
 		struct mes_inv_tlbs_pasid_input input = {0};
 		input.pasid = pasid;
 		input.flush_type = flush_type;
-- 
2.34.1

