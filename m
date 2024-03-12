Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3CEC54E66
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:21:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 889B61123E7;
	Tue, 12 Mar 2024 09:21:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rqzcOTE8";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAD051123E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:21:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0oj00krRJtBwPRWmrdHUaEU17JJgAkXf3vEwSzaSMbh/Aw78rbQmYjo9DBdDF4HpddQr+2stvHpxzBH7LioGPyV6xlwnrNNFLBN1O8O2ZdnD/s6UzzfaFi0CCSXGVC0NfnX63l3L/ZRhAfMYqoCe8oTBXDMrNnDoR1MlX/K46hpuYZd1epapGvNV0VwMgaxk3dTLhhvYoV6nQpyoVbz50sJOS1o2TZ5+yiR24R2NOLweGHCaBl9IqXgrV/vNl1kuYL8aNFzHWEqnYoKSJZmkzU7u8H+VDUUWUs9lLhizsjord9DihZFqI/NUxx78JpzCgipwElQ0myGvYakTXGDSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTj2KtjgHeKLvq2CRzdaSNQw0a9fyZMxxwM7mCgRy5g=;
 b=lu1DWnXI4B7yeUd6InlBrJXo13Tp5DKF+0oKs3WQezgLeROkBhXoluNLGURna9vGtv05OuiR4Y3RNZojMqD33kbYUrBQJQDdVEP9jXcJcgtz4GrgJNNq9oxW1MOpfr5mAzEeI9AouD2iR5pKm8Qit+mwSHsRoGzwKMSXXbb6utM3Tg5gXriqQGT/1Ok35Rie/clS+/O269xxSNBC+TvqS2ycWij+Emhe54S0FqK49DgNVBTcDKF/aPZfpTZ19s/vaQCZgTI/MAyqSz7v8RKjvKcccolPkhJUfN48YGmmAC1z0WbjgKgdpgyhIMuqZ78fkTL7K74pbqqTmKGVBPsgMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTj2KtjgHeKLvq2CRzdaSNQw0a9fyZMxxwM7mCgRy5g=;
 b=rqzcOTE8JY4Y21WB7cO/6ZVT0a4jfBMV+WWvpvQr2+aEJVwvcjRT/2pCKOgzGUP9Y8SYygDYhSKNM8Cv0dq3nHYNS0yFv+GkFmhOwM6FhOoWCOppptTnXBa8SyfUCCmw0MaQGZcxyyB/5EFFan+G8OusUKz3+Eoftm8t9Sa8GTU=
Received: from MW4P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::27)
 by MN6PR12MB8589.namprd12.prod.outlook.com (2603:10b6:208:47d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 09:21:15 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::d5) by MW4P222CA0022.outlook.office365.com
 (2603:10b6:303:114::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 09:21:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:21:14 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:21:13 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:21:09 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 03/43] drm/amd/display: Enable 2to1 ODM policy for DCN35
Date: Tue, 12 Mar 2024 17:19:56 +0800
Message-ID: <20240312092036.3283319-4-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|MN6PR12MB8589:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c36ea06-73fc-448c-11ed-08dc4275c3ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v4Veo1M4LaPaIVsrlyp9h9dNqyo4Yg6CeIFMnw3feS/Vh2benXQ2JyCbPC+oeYf6+HQaq4WYDFhqawjhTeGfLTxRQz+9wQNv3XptAUo3gTbuAsESSE1aGNmu+ZREd34Brim8TSx/C17ztZAawY89y4g/5Xwi6/R2CseOVf89jnxf5RusphXjBgllpK5VcFhRY9QkDivxa8KMmAUvnOPUZg9kH2XL1QBu87vKakafDWVqYmQCKCwK1fUyQe5AUXc3aD0pcAAfD5yNtQQJSKDvUVLqjHpXn5eoYDYHU/2d2djQARvUMx8JNAxFvkFYqiwXHUmB+OeArLOfkbXSQ/fm1hAVVfcXPscXtOXqrAZWDl9GchpbAjv3F7AI/b1RMprirOivBKN/ZOjb/K/Bv1JZmSjkPJRHOQZWx7Fp8LWvJ5H5hiB6mWoPBxFY+R9vJ7tMSGY53hETELik65o7LI4eoj1OWj4BXETNMqWg+AGN/7kguJcPj+4TEXf+5aSlGXBe/KP6eVedp11QWInYbRGJB2DWH8znOmMC5avJP6R5Ep0CD0ATHgExXdb21h613KGx0S2Ayn30nfyeLJ2+vJPh+vZnxzOVSMF2XGcnT6sow2MywTDVC4LQl13jncSKzq3YFvc2OySBkjJCrkuYrosDuQzlt9EW5dHNrnIYBx8MQ4G54TIMyGR6qmBOmvW9VA1im226qdjCWUSvJmUwxY/c73QAAcPiyors0F2lJl8Ks9ppnr6cG+Nnhc0YknGEXvv5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:21:14.3749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c36ea06-73fc-448c-11ed-08dc4275c3ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8589
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[Why & How]
Enable 2to1 ODM policy for DCN35

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 5d52853cac96..a8f4023ff3b1 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -769,7 +769,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.support_eDP1_5 = true,
 	.enable_hpo_pg_support = false,
 	.enable_legacy_fast_update = true,
-	.enable_single_display_2to1_odm_policy = false,
+	.enable_single_display_2to1_odm_policy = true,
 	.disable_idle_power_optimizations = false,
 	.dmcub_emulation = false,
 	.disable_boot_optimizations = false,
-- 
2.37.3

