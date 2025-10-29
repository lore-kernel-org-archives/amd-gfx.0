Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E17BCCF9F1
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:50:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E369B10E214;
	Wed, 29 Oct 2025 17:50:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qi1khfPB";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013043.outbound.protection.outlook.com
 [40.107.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E98D10E201
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:50:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyeJ+aTCfogKfFJucCgWDKIAHXA1h8wmZiZSQMFdoavgDTL0c3juQJZOZYmL6ZPFKYScie05boU6LZOOtXW1rnxCCyZVFpCjVrwRClJR/Vjn6K3qvQLHbv5pXUBMOCORucvgkbU0I39n8wJL0tJ8SXcy+jZUPJwS09ynpg9VONawdYGSV3mxCXM3ohaoTwevJRuzfjzkaoqgQB2R3kE3S0DxtN8LWYMX/UR00C/ypQ4hAXv0ButlUAfjzQwpyZ3zIi892zWuWkor0c0p7/7U6ZhvNgFo6mBS60flbvKk/JeF+wZzEEe8hnMQG78FifEO1JLYR+TcxVdPjg4r08y6Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLqIz88XDYNvBTbb+RimAbirBw8XZVa0ZVXE1fv3xpQ=;
 b=bZTysSE4jJZsXzEWVYF+ayursrlctJezclNSoQqDZWyFbIHGG0b+aqln5T+FzZBfGX0O46zGBYmRpzs4brmsiDkpjBoV9UtOt+T+Y97AfiTycukwNu4nqp2Tz6JTVaUWfSFz+4EdpSivSDVFNQs3HPnnQypbRPlLVf3gBa/vI00wi09yLm6eZh8zVB9WgB0lndn/a1mrVggI7+9f3yhCHo2JklNA5Kry6xTYxv+qW9VyOwtL8E4iQz6in4YFl5vER/qaT319S8bPNeMvCRw52DNizfIigHIm0VdOsNDjZ9r007pLOj8y+HPi+PWeStCrrpDTQfBbCr7BJeg5xRMeHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLqIz88XDYNvBTbb+RimAbirBw8XZVa0ZVXE1fv3xpQ=;
 b=Qi1khfPBBqoHiWTxhUdutxz9zprpUVxO94RPIMSNZt9mhwHdo8ejwi4bc0LYFIr/Guspoak9MG9VKopc1CbC9nbiPu7mIQp6XuV7pB5k1X/AUjQm/FMw4Ar/T/eugdkYsPUB9pX23Rlx+jGAjGiH/f7PbflWF1v08MxleiYOg5I=
Received: from MN0P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::35)
 by SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 17:49:56 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::98) by MN0P220CA0012.outlook.office365.com
 (2603:10b6:208:52e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 17:49:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:49:55 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:49:54 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: fix DF NULL pointer issue for soc24
Date: Wed, 29 Oct 2025 13:49:38 -0400
Message-ID: <20251029174939.2861192-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029174939.2861192-1-alexander.deucher@amd.com>
References: <20251029174939.2861192-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|SA1PR12MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: 90829f46-93a1-44c9-2462-08de17139237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iP6hW/PhVqMBj0ek6udinhG85dyhq7xJYMO29XoMh8eVGr7CRzUh7skmd92a?=
 =?us-ascii?Q?IOYG4CR4v/1uxTV8+Ud3GbHr4ByC0tJlukCDV1RBCQ/2Tb2Ipja/nfvGpvPD?=
 =?us-ascii?Q?GFGPAahw5CRNpI08eWMU+ABIuxI84HhwFpa6fhii2FBAuFufdcfuRRwCIFmw?=
 =?us-ascii?Q?4GWQjUtNeOqNws/gbyJUYkBEVxsxNCr2CkcgIfMLiw8vAJU6AxlBG2qpx1kB?=
 =?us-ascii?Q?5iALaxFfDmQcx7G4I8ifTxzwkNuMI3MT/Y9VzwEFBpLEaIomCZYYAojZUKXS?=
 =?us-ascii?Q?1eR6LzeTR2OHFD95PzhNpkrIHsILkJ/YaJIbVgqfOmsVysAiD9My2JG5afJT?=
 =?us-ascii?Q?gZyeLoLSbYQl/Zt82E42ZaZ7ADHuyWqDYusHJZ8ZK5X2+QJaCgOlMXH7dm7S?=
 =?us-ascii?Q?ZsghReHr6Gn2blRrDTvWVEnNXCkIFVgzIxd/qWBd05P3AMC6s7y7FueAnD1e?=
 =?us-ascii?Q?t1OazikEcXTAC9sVTiYLaXPwwT76Gv8QqFLQxUX/24HW+1Gj8VI4iKfPpt0V?=
 =?us-ascii?Q?iDFmlgmY+Y9GlFyVkeucvrncCfhiAxYY0Nf84voY0AlZvksZiZ42rNF95YZa?=
 =?us-ascii?Q?mGpg5KK9lWcn+ftfTISVobeVkbTrVPUd/4FJLD2UuHEEXjySKx5aP5lvs8+l?=
 =?us-ascii?Q?VsWLvCXjuIX7vQL6TVXU7rM28pb4son9ycKTq3dR0H/T8g2PJz9jSvU+/tVl?=
 =?us-ascii?Q?38zTjiMBwP9D1jY4wqNjdTd+T/ZBIk67ifeVqM91RHXFAsIDsDcsBcbOwcsw?=
 =?us-ascii?Q?tQ+2M5pCP8eUzHw/XCAPaM6lPBdXS4desbX2r8iq3uryOtl1iGJcDE/FTh3H?=
 =?us-ascii?Q?cVOmZRdgrxD4cjKoIGdS4MDeDtPug64pFja0pwLFAhHWEkKILYHxRB5rpbip?=
 =?us-ascii?Q?T0oQ5tZGfQKQ4o90zlam//Z7zGyKPjqx/cKTKcrhfqviaBVBKQYP2lRnfFKd?=
 =?us-ascii?Q?FqkstbEYWALxwUOmPu1m2afMO6BIgi4sLiViMDS+N0/gXLnOU+3kmLWMZ5+o?=
 =?us-ascii?Q?Yns+32Vc9z3ZHPZi5i+S34BdsZe8WC9lLuwW+vsF5xRfYuOv/7oPWEr3iL+1?=
 =?us-ascii?Q?jE6H/MK/Lf8zPRajcfDOO/Ix6TvlH/MPZi0RFtVJkCkjEe0OGgshFYzAZ8PF?=
 =?us-ascii?Q?vIyAcqZLyNRyfuI6CCXw7MTvIQKKIN2YNe1HO+wKMwqhiVCMDDAMjLoo8rGY?=
 =?us-ascii?Q?+6X83k2oQ4QFnnVuYRtVA18MMvZSfVGoVsZavmEjbytJDB1jE1GDQEuWKtnt?=
 =?us-ascii?Q?23xNZorew8pvDyrMdhjrGuWSJsVtdxNsMDzxwV2324WmPSSu9FrS5PbUTy2A?=
 =?us-ascii?Q?nVJ8PuY+silyWKuRWlNhPOOkIzM5xtr6Twl663daKsODXu+AtwFU24HV+WIH?=
 =?us-ascii?Q?azTFaiUVZL69ci4YL2OCFy5KkfmkMKeOkPF2RHe9dO9mfHUh8jmow/MXqaQX?=
 =?us-ascii?Q?B0Xs3vqHvTtKaBBgwILCsvqUU97TJ+/mgZA2wUeJVQbAWsVCoBumkjgSr4Ny?=
 =?us-ascii?Q?0RE39llHrCbGWaB3vuvcgOJDf6/UXXmhARkM4CfJZLmxHZloXMWR7KMg+xwP?=
 =?us-ascii?Q?jHenzjJfcJ98JA+QBng=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:49:55.7669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90829f46-93a1-44c9-2462-08de17139237
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971
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

From: Likun Gao <Likun.Gao@amd.com>

If DF function not initialized, NULL pointer issue
will happen on soc24.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc24.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 972b449ab89fa..cc6684f265384 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -489,7 +489,7 @@ static int soc24_common_hw_init(struct amdgpu_ip_block *ip_block)
 	if (adev->nbio.funcs->remap_hdp_registers)
 		adev->nbio.funcs->remap_hdp_registers(adev);
 
-	if (adev->df.funcs->hw_init)
+	if (adev->df.funcs && adev->df.funcs->hw_init)
 		adev->df.funcs->hw_init(adev);
 
 	/* enable the doorbell aperture */
-- 
2.51.0

