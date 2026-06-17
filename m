Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4670DCD98E2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 11:08:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8ED610E9B7;
	Wed, 17 Jun 2026 11:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AzNDLW+T";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011013.outbound.protection.outlook.com
 [40.93.194.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2207110E9B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 11:08:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EigukAJhwsygBSBa5T19k0iRfYIJ7mMCKx3nONeR+moIIxwufoIVqJ1iyMABBppE/uxNOQNU0MbKM3ZKjHygjFaW8sxzDb0Xt9pAMuvY9PrMRZMi0DhEflEm1sc4TT09Uz59AIv938F9dpUU0QrlPjVG2kcAITrrH0T+Ef40lmBse885HdVdtd4ipLNtyvsgaRfcwNaP6ZOpDO2rg4MPK1xavx+Jnj9FLvxWOBTWLsAQWFfJ9BNZXNm8pZiVPkF+kovqWhxiw5xyYBGIPJqApx0oVLzUGrNiboe2D5KDicmndnfTPtWNQHq5uC7BrhN8r1/2JVqM2KHNEYpkZ3MH6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HlV7clsavtkUG91LVjFLEbbazeEJNj/CIq4N7XdKHA=;
 b=fZ0WIPDA+gBsavreWDh+U1qQBWqrepHYmQuhxoUBI/0j9WI6XwGiySYmG2oh2R2J22BVdkuOJl4qdSiVmXt7MQz9vppi0NX+6NfSJa/QpohQUt6AkhOR1zG29hP2QfE0vRlTRUyYgBr2JpNabGSaENNXjm2Qw11uNMTpwdrlqIRrIRR0sguArj01ld5QYhmbr325QThvbRRcYmI9dS5I+VvOZwltBiu7onVwxMW1En3Thh/Bet6hFgVhlxGpRlQ1mrGM/C8gwgEz/fXOkSvg4nGwS5vQaJNHP+94GYvCanj73V1H+ZBbPx32myU835NGGQxuG1DsXOa1jT6n2Nwjqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HlV7clsavtkUG91LVjFLEbbazeEJNj/CIq4N7XdKHA=;
 b=AzNDLW+TY7uQ6IbyDkbwxIr3MAKFV8lgJ2CIas1sjrqf0tU5WXHT3TBk+Wr3eb+T+KP20/s5ErRH2ofGScWI6VejkfEj1vPa5bRnwOBI2vOmHN/SxK3hv1fG6tD/oO93e9K1MfPzD8XOhvdORHbBXarAoPsPM3A/5HRHjTJwecE=
Received: from CH5PR02CA0015.namprd02.prod.outlook.com (2603:10b6:610:1ed::9)
 by MN0PR12MB5955.namprd12.prod.outlook.com (2603:10b6:208:37e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 11:08:16 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::57) by CH5PR02CA0015.outlook.office365.com
 (2603:10b6:610:1ed::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 11:08:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 11:08:16 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 06:08:16 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 17 Jun 2026 06:08:13 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH v5 2/4] drm/amd/pm: add IP_VERSION(11, 5,
 1) to vclk/dclk DPM sysfs whitelists
Date: Wed, 17 Jun 2026 16:38:12 +0530
Message-ID: <20260617110812.13586-1-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|MN0PR12MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: ef85858c-1afa-4fe9-3d3f-08decc60bb55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|6133799003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: lGJdcOf4WQ0vaeG9irMGfDIvtVSVipnrQBNWjhjWicENAiQLzqjIIkLuN8j7o3KG6GIy2SzI+CumzqGBFO1tn5ou1G01zQsnfDvWMJ3XrfGvQKz8eoUzSHcH2ZyKanOiK7pl4KBgecXwRJj+4aO1pEsTpC0ay4uz1RPyuJOUTFOkC1W3jkQF059G+BaCquaEaxred/Ri08iWOQXHG1kixIE1s5rz4JSYZClgjk/YHNkWScdyFRhcw6gzi9mPxj9OaM3WXEQ7q2G7Y0v9CFkmVWCZxrgWWlkkimiA4MC3xQYLaWjQGPe+vee7UC/dr1B2cFEJ8LPR0mbzVveSgWRz1lRf/n2XcHY+zCImAQ6BKdRsx0m8RnWxMGp1EFPZ7K7XvZT5K9HffTRKLgupGXgOVNSt+59g6cyPm48NkFxk8m6zSO9WLbeeFU4E+P0ZVLt5XX8vrYTtGuqTDD/JuhMSkByumMD4BVOjEW4MLVS29HsnxzeLTI0tP3pGnGwHS8W5H9OIJn3d6RMr/HC/Ah1NgXU+cvHRLl9IoO6AglzFcmrmcrdk2erSAZX8G9PYuNJO7u41IRh3YTqxnw0fZaLzw/0tcFimiD+M28PfRXlUBQ1SZfJIRIFMzASt7BzUUOsRHmqqd8Aq34MsffmORr6IQ4gfKojkdIKz6Ohdfrb4c7uhdjGs0DsnB32GaI5V3kyb+UdVAwDiA3o9GkJjJbPopbA3COxiDB/HM1DYU33Dm/E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(6133799003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QOHkyadDFcs3A8cqU2i52oU/BeTqMXHevsKYPrFMp/LjjWRgRbcZzx9K2d+3O6lPykls2+w6z0/YtXpvWYjqPvcfTYqk9LtKyOI6paED3CUh7VDQYWcU3LXU6rPFFPFpeN+X93PpoV8vH+D9On5SKNS4fIL76M7XhnqeZlson0/ypPVxYTY2mIV8wnQpKigMZ/6luqm6hnO/K27YHpRTkuczFX7VbSB5NEluS+2siHd/BoELjn1nQ7aOLmwftz+QoHM1W3QkGeENdsx5rDacTndjizQ+dK7BqQX6UxIQqc13ClMZi0KBJKg5xXzwryl/m/sB8GaVYfSBKk+FXZpWZE0rmAI9/X8IDpIKsXj1OJ1VNcgdcljF69wbnxoZ5NvmCDjkA1SwRS0bg/fd6n9hAKmob1JN6fDRjI6h8PmnmahIZDDVPVL3s9hMNyl2ejtO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 11:08:16.4699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef85858c-1afa-4fe9-3d3f-08decc60bb55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5955
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

Add IP_VERSION(11,5,1) to pp_dpm_vclk and pp_dpm_dclk visibility
whitelists so these sysfs entries are exposed on Strix Halo (GC
11.5.1). Add IP_VERSION(11,5,1) to pp_dpm_vclk1 and pp_dpm_dclk1
whitelists with the existing num_vcn_inst >= 2 guard since Strix
Halo has two VCN instances.

Without this, amd-smi reports N/A for VCLK0, VCLK1, DCLK0 and
DCLK1 clocks.

Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index dfebe67c164d..305852f5b153 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2027,6 +2027,7 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 		      gc_ver == IP_VERSION(11, 0, 1) ||
 		      gc_ver == IP_VERSION(11, 0, 4) ||
 		      gc_ver == IP_VERSION(11, 5, 0) ||
+		      gc_ver == IP_VERSION(11, 5, 1) ||
 		      gc_ver == IP_VERSION(11, 0, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 3) ||
 		      amdgpu_is_multi_aid(adev)))
@@ -2035,7 +2036,8 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
 		       gc_ver == IP_VERSION(10, 3, 0) ||
 		       gc_ver == IP_VERSION(11, 0, 2) ||
-		       gc_ver == IP_VERSION(11, 0, 3)) && adev->vcn.num_vcn_inst >= 2))
+		       gc_ver == IP_VERSION(11, 0, 3) ||
+		       gc_ver == IP_VERSION(11, 5, 1)) && adev->vcn.num_vcn_inst >= 2))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
 		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
@@ -2048,6 +2050,7 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 		      gc_ver == IP_VERSION(11, 0, 1) ||
 		      gc_ver == IP_VERSION(11, 0, 4) ||
 		      gc_ver == IP_VERSION(11, 5, 0) ||
+		      gc_ver == IP_VERSION(11, 5, 1) ||
 		      gc_ver == IP_VERSION(11, 0, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 3) ||
 		      amdgpu_is_multi_aid(adev)))
@@ -2056,7 +2059,8 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
 		       gc_ver == IP_VERSION(10, 3, 0) ||
 		       gc_ver == IP_VERSION(11, 0, 2) ||
-		       gc_ver == IP_VERSION(11, 0, 3)) && adev->vcn.num_vcn_inst >= 2))
+		       gc_ver == IP_VERSION(11, 0, 3) ||
+		       gc_ver == IP_VERSION(11, 5, 1)) && adev->vcn.num_vcn_inst >= 2))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
 		if (amdgpu_is_multi_aid(adev))
-- 
2.43.0

