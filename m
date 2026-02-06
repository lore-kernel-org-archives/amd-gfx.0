Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3722EE20A8
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 14:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F5D910E7AA;
	Fri,  6 Feb 2026 14:01:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="slJICr6T";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011013.outbound.protection.outlook.com [52.101.62.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 805AA10E7A8
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 14:01:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCvvEsI+i+YK4OWjDnvisLoK9hq96M3uWpnr7Jm9ghfvpevuUV2A/Xtvm1MYDBA20h/0RSih/j+gQUejwUZ83W+EQlBbH69GdvvVkyKb7CoJV0f6BQn8pknoHJJd3orthxzn2ftZJ+06+0uS7gMsntS1zSa+pJjyS8zm+5FHjbnpJud5L52tyycpw/dNNK1zAy8DB94fdBdp29AQWfmskYsf/WcYfpcpMC2k6BgA7UA4EBrR5O1IxUTrikqALSpVyiabjYi4umDIGs2VEQBsJsu0Bo8IbIS066RlhGp0CbJE9WYOUw2eP6j56zlppS1Oid3PrEN+/dAarXiK3POxBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PfWSG8le3RIkkElNpCEGy+Vap2ARjwAj524QTKEOF4=;
 b=e+Dfh8LGbWC61mF/cR3WqxXMnGRuvmXIwW5DE8uewgFCTl4LD13uTzHlux8zbjIr+9NV8aPiPdEiWHvMYYgQrvNHMXBt8TVYc4zZmx/YFkQZy0BrYf3BEls3g5HUGGXLveGrFtGvWD8ADszJ8eiEuV9ZsVfb6lQxZbj8z1NgTZ7YwUBSDxeV6Y3c0VaYLbHWr8mwqGVHavSEBbLi4ZQohb8lWMHHeY+dDe24l+75XPZpZj7d197un4R9vu7bfI62aKKaKaT9r5P08hgkFVnazwxSTKRzv5X9FEFIss3YB7DEW28AYthl564lzoMM2YR9EC0abL6h3wFhh4syUc2J0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PfWSG8le3RIkkElNpCEGy+Vap2ARjwAj524QTKEOF4=;
 b=slJICr6T0WsBykAxo5x4vamcTwgUyGSfEq8slfvNc5rsqurJnprpTGh67DBIiC1rGSeMBalpT97/fkr6Q+uOknzHvj1KOTQf0dgFZ+XO++uC/E+zHVpIvta7u/o7As1h+oYgXs2e9m9NH9KmglKRTUZ0+bLPSIjzGTYPXQPxHeQ=
Received: from BN9PR03CA0207.namprd03.prod.outlook.com (2603:10b6:408:f9::32)
 by DM3PR12MB9327.namprd12.prod.outlook.com (2603:10b6:0:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 14:01:34 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com (2603:10b6:408:f9::4)
 by BN9PR03CA0207.outlook.office365.com (2603:10b6:408:f9::32) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13
 via Frontend Transport; Fri, 6 Feb 2026 14:01:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:01:33 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 08:01:16 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v5 07/11] drm/amdgpu: Drop unsupported function
Date: Fri, 6 Feb 2026 14:00:44 +0000
Message-ID: <20260206140049.105294-7-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206140049.105294-1-Pratik.Vishwakarma@amd.com>
References: <20260206140049.105294-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|DM3PR12MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b2dba75-931e-4d77-263d-08de65883c61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+rYdB51RvmFOcG8BqBAZOYIbf3Dd7M5AoQf3KZNIUIu/FfOqbUaPi/u6Q/gD?=
 =?us-ascii?Q?9VfMcf5F3Yb1554A6aN4YTI95hzLZvMLU/HEWY19A50kSJqG0bG+w8zmzNlW?=
 =?us-ascii?Q?euXqEzYZUrffLH4R+mwoiRDvgxG7v0WJLJwPVuVyqgxVh5HGjbipQJcAR+Bg?=
 =?us-ascii?Q?8V+p7iYEmsl3x0yvV4u8H4xxcu9f94OSo0HVE2PKZDuRhqTgNC332ExjuXMl?=
 =?us-ascii?Q?Un8VKY36u8x9ziNeDWb0e+Lh5ZAaYr89+I/fgtO2hGsYtrOwIpRrphSirM5p?=
 =?us-ascii?Q?2IEP1+c8hsJTRPg3/X73ImlxdLeC1iXiSxQpc+nBvhR3rsMd5EV/sNjWiQB3?=
 =?us-ascii?Q?VYl5F8NNZHlxVAEbtcilBt+1IrAADqKZRwoXQMCPPTqh3MLo/4sRzndhHOmM?=
 =?us-ascii?Q?W93Tq6ZmKHVkfj/p4X2T0dEzIfcyzJx+IRbzN4e5CbNO6T/x2Jz3rllEI3Dh?=
 =?us-ascii?Q?XU8NDuziDdUxpg4iOG9SLDPuztl5ivtGVKff4xBEcO5DXUAXgNC0nedKe2qo?=
 =?us-ascii?Q?8/59W6IbEcfSGYkj2pTOV7B12racfxa6LIbQPAu59MFo6pAL3bZMr0cMeeIj?=
 =?us-ascii?Q?KySoLNau/+z2XUFgT1Dj4BMqIAr8n7Xp7N37uaLOagJBcu6yswVdY8ecbUA6?=
 =?us-ascii?Q?cvIMMyDXg8bh7ezt5+QFoQX5bfqOReNfClBopsle/TWcOtolwMY1Jenf1PqS?=
 =?us-ascii?Q?s3uwT8u9iiW+GEkLMIRXahkhQe7l1F0podHSGGzEPn0f8fwBFIBq5F5zfKTC?=
 =?us-ascii?Q?1qlry256GQlEfwGhU4lL3KbL7KjqViIC2zEz2dC9JzROyWVDh5ubzsR1hT1i?=
 =?us-ascii?Q?fCsngB4KxkKjASbkjDzi2I7Fb3KCCLdsJ8jZHSV4qKptaf+uwmwJ1/vuysa6?=
 =?us-ascii?Q?Pde9M1HKeiIqSO4Fd5EkhAtZO0LMs5k2376JnRPlAHzgGV2vag/GS9fMAQoi?=
 =?us-ascii?Q?MD6FxAxYsS6ZJ3Xcq3mx4yn/maqq376wKiDxA1EQ/iwnJTHK7hNdnlLFxamS?=
 =?us-ascii?Q?KEntjDBOS+dH4OblpteCIONAUqGA1u1iCh6MVCR46Kt4WYDnZZg5Cgt7LAwR?=
 =?us-ascii?Q?uotwh/y3WinQTXIYlgBn96vjK0j/XI6o124rVF3SIB36eWyV43f0XL0+bdyN?=
 =?us-ascii?Q?YdCIrjNDepU9C4g2HopxZhBiR24xsqx5QFnYuVJ9cSzz82AbaxbVFJY9apXf?=
 =?us-ascii?Q?qNg0W92HEeVrGgQ0rqkWN1gvBVBV4Oj2i6s3HfpIVOckoeIzMtu1tLeXJn5z?=
 =?us-ascii?Q?j4M68xJ0Clp9U3fsoIOhNbbV2wfxBVEQthbsuAOIokXarypvHyysrk6LGNzP?=
 =?us-ascii?Q?jHKRnIVMcwRjgfGMdYgQKY111pdJF1jC+WETk15BGDCyJY0lCNhj9CfIhGIC?=
 =?us-ascii?Q?MobvZDgAMtl3TWCOtNRe4hWJsQ1C+ccaXGe1S2wSx2Lq9213s9vCeCkFmzUe?=
 =?us-ascii?Q?FWuXCePPOWGW1asYbeyNL69vU+b8ykr7S/2LH4jhIZhDaYsKzEDDh/g/0/LD?=
 =?us-ascii?Q?VHVfqFIeLJYZNHXoJI7VvZvRy8gAQhhk6b5ig+O2Nwin/PKtZS4xeaiQDWh3?=
 =?us-ascii?Q?AdI6bEuWbrgpKLeCpe0dMepEW4sv3LBnUzcdKxoDpK+IE2X7EivXSCKxkrdG?=
 =?us-ascii?Q?vgUSgsgS/5TB4ILFRFRUg0jd4owXjYsrnJTHJqTgRUewl8Bt5p+9sBN9Hz8x?=
 =?us-ascii?Q?ZrHirQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kdGpZRlafssjyCjY1/xqhPtVEoED7EO1Idn2TpYHPLzagja7UD/ziD/pEEtsOzUOLIvP6M/79Ic4UIkM5sSpnVWmZmWP10Z0HDbOvS3LaNbhZYSzhqDAxxn1ECbQ92GXBDi4+t68qUy9bLaGtjRwygKeOSzfSwqxrap53QlGgTkAC6XCm464p2PaMGdfFRt4wkcPSw0jNgCZsbW3UDfnnWuDvUIbKb1c1sjBYnvzC9150i+QqW58U0dIQWlzwAeH5xU5V2JCRKCnVAT1IKaWKGdKXMCXzudQQu6aqvjUzRV+nBpST7Q5QnKozOAJ4Opy1VBMinboGGWFPwVuS7j/+KuPP1wHcFDOAPmcrzqkwCIF9+a2NAemxbGqa9HdWd68ule5j8ID18oUB9JLvA77aQAR5qxVaOmpTgwYLE9OBGTNa91V4ofwTT/vu0sJNNJ9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:01:33.5722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2dba75-931e-4d77-263d-08de65883c61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9327
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

drop set_driver_table_location

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 891cdd8bc5cf..73fd2cce1c7f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -1421,7 +1421,6 @@ static const struct pptable_funcs smu_v15_0_0_ppt_funcs = {
 	.get_gpu_metrics = smu_v15_0_0_get_gpu_metrics,
 	.get_enabled_mask = smu_v15_0_0_get_enabled_mask,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
-	.set_driver_table_location = smu_v15_0_set_driver_table_location,
 	.gfx_off_control = smu_v15_0_gfx_off_control,
 	.mode2_reset = smu_v15_0_0_mode2_reset,
 	.get_dpm_ultimate_freq = smu_v15_0_common_get_dpm_ultimate_freq,
-- 
2.43.0

