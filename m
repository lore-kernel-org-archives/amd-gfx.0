Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCCCC4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:20:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61F9D1130D3;
	Wed,  1 May 2024 07:20:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="npVv9VCG";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 311E81130D3
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:20:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OT94wgAH/TlLbxByUxsmbjZq/TLiOYa+GQ6xorAOi8gtuQDP8hz6DhbHUlHgGcsLGAXQmd8aoVlIY5iOhckwMblSo9aflcGaLZEA446mF2blCQG+uznJTtBWgUIR6dOLJlC+Fiqi4q5AerASKGaSp6kSngxfJE/gdQQcg2BHEPM1SfuOGM/TecF/FZXJ5j4d3vqWQ+Njt9JrmiXVy8Cy17A97wpJhbAD7l5j9nzaqTffOyWla6/Ve61q6PvQMrcCvq+Blq/3cH9K+2gVAaY9bdl74WeLTan40IIxIQZmQaB7TO5zf7eC2yuOvSl0CJOU3/Eh0Jl7sRNQr5PuVfQzIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJT1+ce4NCu2sa7o3T0nbMXo1t+2gTij0wDOUEdYIrg=;
 b=Cx0TCxliaxQ+8H6po4+n3JtnGK4H6lHf9FoO2Wf8eFhEi5gaBtexpp8BOMrBYUiYXlJojDcgLAfb/3qgcGvkMwUXULquRaKl8WGExEBm+027CBfXKRjU2t8eYvNldlsezrkY98ybcwiBA45yt55+EjWSCPLSjAW5YatKhVxO26n9503Us7VUeA6DiajVNzn6uzxcj9xFaCDHusb51zCSiDR+XWE2wZDghcB+41sckFE5yHkr3UwUNsOeGqsmeruowEp4scGBsITF5AcyoZ7dL04bTRbVBCXAhQyEqXNoKEMHy/1FyMSCno3fFxeyyaUwKqgYW9ArW4v1qUFRA9bmcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJT1+ce4NCu2sa7o3T0nbMXo1t+2gTij0wDOUEdYIrg=;
 b=npVv9VCGNdHkcyGfXYCWYT+XIU8TcYk0Uxoi191ydizOT4kl7AXhkNOKYOhCUcO/N+CGQ4srSUJJEro5kCRw8ZPcbNKnx3uhS+27GMFywRCT0gKCQL2fQYl1/+/RYhmNm6YvnRVvT21P47FomL/pwguuYxD+X0Nn2Y/8pGMIfac=
Received: from PH0PR07CA0033.namprd07.prod.outlook.com (2603:10b6:510:e::8) by
 DM4PR12MB7694.namprd12.prod.outlook.com (2603:10b6:8:102::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.34; Wed, 1 May 2024 07:20:38 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::bf) by PH0PR07CA0033.outlook.office365.com
 (2603:10b6:510:e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.25 via Frontend
 Transport; Wed, 1 May 2024 07:20:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 07:20:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:20:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:20:36 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:20:29 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH 36/45] drm/amd/display: Fix wrong array size dummy_boolean of
 dml2_core_calcs_mode_support_locals
Date: Wed, 1 May 2024 15:16:42 +0800
Message-ID: <20240501071651.3541919-37-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|DM4PR12MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d3b7e75-17f5-495d-f64f-08dc69af331a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400014|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KuGSy2x2WOTFj9FEKsGYak08KXkF2zT393uI14PwRg89/wFGkYbh4K0WnDx+?=
 =?us-ascii?Q?JWsfPgRtn0S7bElXTouhaG1/Kg4TChUe2RwVl3bar35heMh6sw5G+DYizzXk?=
 =?us-ascii?Q?93KozvGKNJD98lbyQyDl4WaxgiJmhr72PIJtjIFRZr686ibGqgfhYbfjrHkT?=
 =?us-ascii?Q?Fv5azAHk36C+yyj4i67VoJttXlkFCBCNDhOy7FjzTOC9o5HVDh41IK+4VwqR?=
 =?us-ascii?Q?t0iai9qkzoBuOg8VkVaXc+4jsUEO7s+jIkNSSaWUh0yTpKeLJ4Z3n2QcFDS9?=
 =?us-ascii?Q?P4ApYAPumQfCrMfANFGygFGNKi6kMzp8GIWek1T2R5KDAXIqGwSEjAqbN/gu?=
 =?us-ascii?Q?TtvM2hEvL1Wjgz6fH5a+wZTbhUM37QFnq9yk4KHeVy71EK+OTm1Ov2mFMSuW?=
 =?us-ascii?Q?pAa2hR+51FpW/YWLvxV1SnTRbKyyhGQnAspxjBebFH/pT796V5sjbIXQR0QO?=
 =?us-ascii?Q?mGHfjJt0bFM2MN+EV/B/t2pIye+4gSHyBHMXBHyZpFjayhZ6W73cpuFvk7fH?=
 =?us-ascii?Q?L+MOJoxuip6TraoFvmygiC4DYDLlerFhZeGxAnxhKLqveLDuoUChskdlFatK?=
 =?us-ascii?Q?9fT0vhQaFLC230HvxQ+z4RJDUgf4K0VQ+IxPAThM+ZsFJaqdv+u+k+Widnxe?=
 =?us-ascii?Q?0GKbujyINRGj1+nmHRNgdX44RvBkO/P3cmwuCxCz/TW+Bap9jDdB2z8+1EJC?=
 =?us-ascii?Q?85QAK48cuZetYPcNsbtlV7tby3DdSM2vRHi8Jg5Z0A8QtW6HosrcGrkefQHO?=
 =?us-ascii?Q?nq8nhf2NYWLR896UWFTNZp1irZlLwuf2oSTg4tkjOmMyM8Ua67YU84CIqiy5?=
 =?us-ascii?Q?ooaH8xsK2R7maaS5V6vqcxoe6V/RWkMLBH9SEsdR3IEAKUGcBSvI/PVZlaJj?=
 =?us-ascii?Q?FmPOXbCksS5xUuiYaiJhtYZ6zaEXi9zBktmJyQmFiujBv0cmO0x6+nA4TDPo?=
 =?us-ascii?Q?CULrtr7Ve0l1DgmQCf7TJUYyzdzrULIw8W94sFOAPNJ9bW8fjqA0jhcDtisV?=
 =?us-ascii?Q?aP8XfffRaSLW0zyS5MD3Jq6ZIpx7wYBhcBQsket2iezMnXlTeJfc07onllO9?=
 =?us-ascii?Q?2mhteY37fxqENouOp/faIHF03dPyf4rPVyYNLTL8pMA7zF6NgaZLS0Cdb/bD?=
 =?us-ascii?Q?s5aZ9Hrp+N0Dcug68ldXyk2ExKssvdlI2VVc0+bCAYasbzGQnZ6fNx6E+EKF?=
 =?us-ascii?Q?PHhxq0J0xEaFSnRrO/YkYxAZe/07nPiSJp8euCmqfeTq9gBh4EBSiPeZomYp?=
 =?us-ascii?Q?+UloFXtenRrWJ7sFy6Q4ulHaT7nwIPbWUK1HANAEUVTgRBkKHIhNhyTcakEa?=
 =?us-ascii?Q?t4F9nuV8Wa8J3051wbCUjw5dSCWfq2Z6sPpS05cznWDcxFfMqIAhKM2EgSGO?=
 =?us-ascii?Q?WeCTuFhVDfhcEIl9gqFBGiIrNzr7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:20:37.6741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3b7e75-17f5-495d-f64f-08dc69af331a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7694
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

From: Hersen Wu <hersenxs.wu@amd.com>

[Why]
Coverity reports OVERRUN warning for
CalculateSwathAndDETConfiguration_params->hw_debug5
= &s->dummy_boolean[2].
bool dummy_boolean[2] is defined within
struct dml2_core_calcs_mode_support_locals.

[How]
Change array size from 2 to 3.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 .../dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
index baded2315254..240835159531 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -854,7 +854,7 @@ struct dml2_core_calcs_mode_support_locals {
 	unsigned int meta_row_height_luma[DML2_MAX_PLANES];
 	unsigned int meta_row_height_chroma[DML2_MAX_PLANES];
 
-	bool dummy_boolean[2];
+	bool dummy_boolean[3];
 	unsigned int dummy_integer[3];
 	unsigned int dummy_integer_array[36][DML2_MAX_PLANES];
 	enum dml2_odm_mode dummy_odm_mode[DML2_MAX_PLANES];
-- 
2.34.1

