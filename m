Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB216C61DC4
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 15:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3179010E2BD;
	Thu, 27 Aug 2026 15:08:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vqpjJc/f";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D79610E2BD
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 15:08:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pcADGGQDlvdY3BOKpzVtO9aGx5/8+hbSh3VPZNdTZ4R4a6BK3FwD8nHr17tYoeyEySH5unY8yFI753l8zd7ijwbZu6j19HD30s+PZFxgJxn8Mt9QQS07PwmQpLhek7AWZQAfsn2mxm2lnDDX1nTWB+kCXxZ3EnpNjg0935jJOqsWE1HOOyLDFIzFoTpWredIEKO9PIYIW7J5lLQwS7vNH/Otp1extYpUPRwhSWngO8CKsEztc1k2H9QCnx2AXnCfsDO87lkhRVH9SFnAF8/dYVjmgN36/SHdrEsuu9xxwBhD9hUtcP3YahdasFT/L1wqsCgpuWd7fhge6F4098uwPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YoXq2F5Q4OzqGoyMEYnYPjtAY+TJWaaOU/HE9qSHY0=;
 b=Mfna4hFl3oPAagVTfIGBXPAGKxCqR9xpGbJtvubHNL2cW6ezYRZ4FtoH6LlL/Yv6GAwj4FzMhhl1fsTtCyFNeIfAz6lYsTfFBV9T/J4rCzNoJp9lD5EGJpWsOM4Js/II0Tvx4felIRdQUdNT/nHFS6esfoawGVsFlKAeHPSIpqIYI9NyHfLM47TwubbS+rOWbFycfHZE7nsHiEDyOu4L+12S6my6tdz9ncfK1n5UCli00iD9LIcdJit/KK+2Pxzkndm4TswnP6YyIdjfSbBH3F5QBu3kXR3+juSv9DMhvI0MiHajQbXWctEXy6kMsn76SQlrpK500ClFGX5jGkyJqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YoXq2F5Q4OzqGoyMEYnYPjtAY+TJWaaOU/HE9qSHY0=;
 b=vqpjJc/f+xApIfivTCOzLiF1D1oV1+8SXSI1tLTze4Rp+E3lehWb5RYq40RlSOB8i5Q7XkJtbtIJxC7JMuhSHPew/JxjAH1/EsD3TYSihNv60PK8PT9p829vRrbRBJkqEFJoyLpzNtmE5KEeMhVTqH8Jcza/fK6hPp5AjgRelLE=
Received: from PH7PR17CA0034.namprd17.prod.outlook.com (2603:10b6:510:323::12)
 by LV9PR12MB9830.namprd12.prod.outlook.com (2603:10b6:408:2ec::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 15:08:14 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:510:323:cafe::50) by PH7PR17CA0034.outlook.office365.com
 (2603:10b6:510:323::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 15:08:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 27 Aug 2026 15:08:13 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 10:01:06 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>
Subject: [PATCH] drm/amd/display: Enable HDMI FRL by default
Date: Thu, 27 Aug 2026 11:00:54 -0400
Message-ID: <20260827150054.1426016-1-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|LV9PR12MB9830:EE_
X-MS-Office365-Filtering-Correlation-Id: 804b49e3-9d5f-47d1-cba0-08df044d03b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: zPdhHJHQOXxzsTU7121ebbsoWxguzjshudRiZBfpfSX7tZM3mWPy3ZGnEUEgClPzOmpiE7Q8tb+iqF71yIGcOxcWg4QbiDhkVUm2626mSWJ53bPmdP2WJ3Jv993SOflg0pEDOgsf1WOqcPUDXqGeCVP/L6fX/udONdJ+jkRNnumhYakLpmWP+GFXriw5XpTPutXr5GwtWuApHDDuy3fq6w+iK/fsAJXaJQN6GcyXm8/FKCWxSSozqrGCUy4cCS5mGJ/t5aa7bqVrhlQdD3/4mHLgImIo3oDbDZDo/hTtO0IaKkb8gDmLUSvYhkd2mjiB60xYhzV0QIvqjAE1xPycN0zrmHKdny9qQegDCMwRRB5sNckwFRigH+p7fxP/VEGzLYD253xj7JhD9SndGn6nu6WkEpvA9gYOMBSYmgHhAjya76e1Q7FwTiGlsWdVxVqxkltMg8nW1sYoUeMtT629pMBBZd67RXqD6XKNx+ugZxGtDtH6m71lCj1GM1lKzWhpwEL+RN4zL+BXlqx52hMX98UqZxcHPbnu2BNWxHh0Z5sa2g0vz4YFSRhl4g9QSG+ZNuDpccKx4lX+LHq4i14IuCdo+IsWe4WmuXc4kox74DzVTbJZ1IZ91Qsi6s0jRnEwh9lBpDOeo05fr2JYC8kG5lNfnSWM2G9JGGrtppiDs0TC8FNYDqOUas5J4JZ+zLZTTj8IJuvth4fyCliE5liJqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rFOxztwvkxKYUEmq0KwVIZygVRqxDNU6io1+HrZMY8eWIhJlLam21C8nzZsY4Nb9JBLfdVpBRXEV92oDOsojXyy5sQ8V7tWxkYqcpl5kHIphy4Z8FWA0VCOa4UqwyRPG8mYQyanUkktIp+7pkbfAh8/VkBg40m+9Rkfk90XACHb0qv4m63hC5DDh7Da4mg2ZA49UWw1L1lmtkt+w2OzQVKC+XYehmZg/ItdElTyfbNF9AKWcXQ2Tk7Y0QevZwmOzPGEJG08Bg6thjiF4fvpBYf2N+he0rIGRWIG7SvnlcBezyZBK3bqhSmMwZ8EIGiDldMX2F64osgUlaLWIEPukmjPeLo5kM+s96OQm4SQPsFxAG0DhQh8NA8NOoXLpDmZru/afzS+O/VSul0gxSBw+3qkNAbRjsy+lzzUBIoaXi3bc24tLGeOBh55a6DIDRWdq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 15:08:13.0662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 804b49e3-9d5f-47d1-cba0-08df044d03b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9830
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

FRL (Fixed Rate Link) was gated behind the DC_FRL_MASK feature flag,
leaving it disabled unless a user explicitly opted in via the
amdgpu.dcfeaturemask module parameter.

Invert the DC_FRL_MASK check so init_data.flags.enable_frl defaults to
true, and repurpose the mask bit as an opt-out for users who need to
fall back to TMDS-only signalling. Update the DC_FEATURE_MASK
documentation accordingly.

Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 drivers/gpu/drm/amd/include/amd_shared.h          | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a27c1fa74994..bf5369cc8b13 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -555,7 +555,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_dc_feature_mask & DC_DISABLE_LTTPR_DP2_0)
 		init_data.flags.allow_lttpr_non_transparent_mode.bits.DP2_0 = true;
 
-	if (amdgpu_dc_feature_mask & DC_FRL_MASK)
+	/* FRL is enabled by default; DC_FRL_MASK can be set to opt out. */
+	if (!(amdgpu_dc_feature_mask & DC_FRL_MASK))
 		init_data.flags.enable_frl = true;
 
 	init_data.flags.seamless_boot_edp_requested = false;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index e3baef809cd1..87eea3360450 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -287,7 +287,7 @@ enum DC_FEATURE_MASK {
 	 */
 	DC_REPLAY_MASK = (1 << 9),
 	/**
-	 * @DC_FRL_MASK: (0x400) disabled by default
+	 * @DC_FRL_MASK: (0x400) enabled by default; set to disable FRL
 	 */
 	DC_FRL_MASK = (1 << 10),
 };
-- 
2.53.0

