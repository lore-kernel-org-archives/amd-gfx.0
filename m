Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E502CA1013
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 01:48:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C649B10E00F;
	Fri, 19 Sep 2025 01:48:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Chjn84fW";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011026.outbound.protection.outlook.com
 [40.93.194.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1E3710E00F
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 01:47:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+DfjYiLnUJpGpmxcthmswZqtIgbQqlX2L6sTJq9TKMK8wr8A8eTuco7suntU8uGfCvAjJ+ZSt4PitMSuohF2ckCPOWiJ5/wRkBIhhXLuZLskbylsAlWxZ4aXBaQmt7vS7R/tLlr+/ZJrPcw7UMXaHiaoiPJJrCAgUzNO0j+jeF2DW8B+/B1qb9d2SD+7KxcB9s+S0hO80PRF1VUS6HHFPdF0iaV0fVvZ3rtVOSaxP6CeMl2w1UWA+/geWKpiqpW8/Wptopmfejmsg0gx/2KGwWFFjQwQbjRabgGftyvlv1ZpnenxNPrmD/tWS3Ry5riWcMWJgzIIbDEGrGzndL3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVCzKgTLpi/qrzfRgkwMvR7afKfMBVUQRo2Lt9NkfaA=;
 b=T/clxFkPDCrHA+Je3ZpBHHyl1vj5HkDLCDfFDZj62debMz+mQiCgsJLdSHMyeYdTnWpUYzUppkXhKT1fpvH6h6tEjtfjuINeZ+eWEaMAY/fNcrIqioFryGYUBMYlRCMPYVeCpc9ng5re5C1yXOVQUbBMwkJRhsLl0dyMEer6kptOfyeY495QM/z0oGdUhQgk5sZS/4Q4sBlUCwtByAg0anh5pVNiiIqntncbYf5GTzVFSMQWZr2wdN/HhRjQTZLN0T2cACXqJLXZkyxvbyQkPYZWgI1gyKOJPUP8huXjaflYhyHTwh3EbcZF2hQwTEyKbJHgTMm4XN+IQglp+bL+DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVCzKgTLpi/qrzfRgkwMvR7afKfMBVUQRo2Lt9NkfaA=;
 b=Chjn84fWgTcIXiwiPwwiiavaDjuUeLIvg+g4zwsqSUC0HcFiC+26YNFbJhPXPgBLiIx8Fm4zvKYA6KU+O8m0AW7l9h2+7t/GrVG9qN+pRnuBPjGofj+WyTDU6cONwrOn867mZjm4jTjuQE/GcKyapGQqug7Ece5tQpSDDK7Oh78=
Received: from CH0PR03CA0030.namprd03.prod.outlook.com (2603:10b6:610:b0::35)
 by DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 01:47:55 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::c4) by CH0PR03CA0030.outlook.office365.com
 (2603:10b6:610:b0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Fri,
 19 Sep 2025 01:47:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 01:47:55 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 18:47:54 -0700
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: place the smu 13.0.0 pptable header into the
 correct folder
Date: Fri, 19 Sep 2025 09:46:57 +0800
Message-ID: <20250919014657.2699900-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|DS0PR12MB8502:EE_
X-MS-Office365-Filtering-Correlation-Id: effc993e-f744-4115-8c7c-08ddf71e8db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6UWKX7aBD+M8tKFIHULuU/e8ewZpPnS9bc9MaXIdxfA5dTAKd/auVqaQRaiU?=
 =?us-ascii?Q?M67rX/dde0SUJ93jOoT6roQw4BN9EtbPHZMjwT01NTlra/2qzCR76QFmXq5Y?=
 =?us-ascii?Q?d5qxEqYLcXpw3NxzAGbhc9pU7r2ZhkRhfN3HJL5uWjLLk3pgoH0nyUoum+5p?=
 =?us-ascii?Q?fgOBKA0QgHnU++ugeQK131z05rp4hyojqtGyNJjhWa8T/vsv/KCLIJH1xc+5?=
 =?us-ascii?Q?S3FuPp1Bv94+mgDCF42Nnrw8l+KXMESGN9ro8ExEJSJNGVV9SoBYAY4IhJSz?=
 =?us-ascii?Q?MnVkHnlulBe5DZrtNSaYYx8x8v0ciMkKPBZG8vnwIs6OjY8n4fUwdFr5XgPQ?=
 =?us-ascii?Q?G9WRirZNhqeOCaP+nkEOmD//U8szL1PeHfxRqNTaZjSVZjIFE3w0ZKglrZ2E?=
 =?us-ascii?Q?zVU/b82pOwB5CJyM906JKwPjGBioSfvGNCST8OHn9pPztgjB9Aqry5vFlfRB?=
 =?us-ascii?Q?g+p3pu5IXWCRXyLMjA+RWdBbRLrkZsNBqYMpy+6J0+Kr3ylPlbp/pDiyH9rS?=
 =?us-ascii?Q?HAOb8pIzLAM92nANgc6cf6dxf6iS75DedaNHj+jXdSMBEmmXLnztnc0O76JM?=
 =?us-ascii?Q?EkAeOm4lKZAAOWrTwUkMz7S1APYxBBpJDPujSFdsGySgxDdhHe9VhEVNMYGV?=
 =?us-ascii?Q?m9cAsApfZ1V7JCEJtp37kG24v8yfsp6ByTUTUorj5t5r5pIcuFcK+yMxp0p/?=
 =?us-ascii?Q?L4CJDS8PemWJZYXF6OP9IG1LO9NwBrck5OfSbGZye8spHAn+YMu13MrbpvET?=
 =?us-ascii?Q?XwNRIJ7Q2y/4Ct4HMh60WJ55UD1J2PAyY12WLG6pxYocSt+hT8aB2Ghj0Nha?=
 =?us-ascii?Q?qexjZMeroSUDpHjAqMWkPVYBNogubrYWEz1Z0LewcHxgVE+s9eRCxmp55vtW?=
 =?us-ascii?Q?X+dvW4iOYftlpC9m0oZGJBZul91jO754HuBdD1+PD6L4ujrLtNE6OjJ35S42?=
 =?us-ascii?Q?tVDu1WT2MXIDyfVY1rHKcP8RwEWrFaCLSSM/A9RFl0vSqbHXtb4xfGX+iI4g?=
 =?us-ascii?Q?Sz3k6riJHGQrgK/JlF+9fIQvB8fbdZIO61EYV5nkCtxc4wQMfx3bjVcmOFP2?=
 =?us-ascii?Q?8HfPyPISrJkvJC+REIr9SfPiTPXqdYSgFyTT1YOB36ggHzJSMRlB5kkKs6Ch?=
 =?us-ascii?Q?eVBdWRIEy1wDS0CvXm/yUf5NbWqjwDwDW0AwnPqwv9NP3DgPAvr9DVQdgs7E?=
 =?us-ascii?Q?MJsjCunyYOxdV3r4IOWIcZLQrsg1H2HdhRg88L4QzZCJrq72svvatEsGRFC3?=
 =?us-ascii?Q?qSASWnzS+syPHh5wjSLgniNXFcTLUog4rMvtJz0ldULMHtfF2azfbatjqRa1?=
 =?us-ascii?Q?dxTNw8V6xxFb7CmHwPpXtInkZ/ce3/nMeInXKXrSVKA2GtcXWgzucn+YPfvH?=
 =?us-ascii?Q?v7eHqEu/AWdm9iD2e5fBhrDgq5KRocHUz8Ddlp7HCZh+dWCvWFFC17bcqGv3?=
 =?us-ascii?Q?4xKk8/lq8J0xtCKk5Nm/DFY5seKXQ0d9gPQnfURynMcNOMk5tKHYuGz10fef?=
 =?us-ascii?Q?ddrMT8PEYk6EwMIRAIl8wMtEek770kgV61US?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 01:47:55.3562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: effc993e-f744-4115-8c7c-08ddf71e8db2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8502
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

Place the smu 13.0.0 pptable header in the correct folder

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0_0_pptable.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0_0_pptable.h (100%)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_0_pptable.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_0_pptable.h
-- 
2.34.1

