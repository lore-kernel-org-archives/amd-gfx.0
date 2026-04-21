Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD2CF8925F
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 11:43:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 402D710EC4C;
	Tue, 21 Apr 2026 11:43:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XafD7bv+";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011030.outbound.protection.outlook.com [52.101.57.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BD3710EC38
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 11:43:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORJNF+7Z2VhdjTSq9FnYn70mMvgTRB7kLtHOc0h8p3p7WEc9VNDhYDwoJ3tgC2SFNsBNchwOf/BaIZZJ+/eLTLJVOlWsQ1wc1XKlqBnKwqZXovGD0E3Xpr4wlSjzGkGpZ3YYvkZMaB+SaIDKw/54MsSkNU8/GWxBwTkL5pG2TJREkJ5Bk2ElLx3pWcP2TV+5k8DHxtjiBWtw4i0IwK1Gq4hjyBzrEKViT2KmRoHo6rLckN9wmb+9UYh9hISVVm0l1k2nz6b6B3xlxn7HKJOJnn9D4ibH5tYvazhoc6czbnTewmT8X26x97WcOKn/CsJUh8i6ZyJ0v+fA9JX3PCSbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEjZyO3bhy1iC+dmaZobEm34BkO70RL51hdCEWgpbtc=;
 b=KjEgWH2TR82kgfE4OXA5Q8Fjr8ERWyWc9T8QmOf9Yh2ljd84wm8PGibFlAYbQknJl2SkuI3GeFtEZQRfvwiE2lSDRB/FPibgzPXZmJMYxOh34R78ow0wFrkotTk4Z/I5nh3UWvtQdwstox/8rjQC0SXTXxV7Fa7uNZJxyyOArVCFDdAxxl7P12CtnXE/Hv21o+njW8CqdbWosCypu6nwhxGHBJ4RMbpjT85FdNg2lKCottMH2AnBv+wLoIlvbfXx3v4BdH6PDWSslcP5Tl9Y6dofIXMN6Q2siGGMqoqsnPj7xrWbQO+vSeyG4n+nBG1dg66aisQO/UWmPeEM1ov2/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEjZyO3bhy1iC+dmaZobEm34BkO70RL51hdCEWgpbtc=;
 b=XafD7bv+6VFXImBOmveGv7XTLV6qE9QWYsLVrP1yyGk8GYo5LzHB86rdM0fSOZ/12H2tIs6LiogedSSEKffh/fXGNql/djqGQ27hC3+x+Z1de4cVEmizttKS56vlQAsuz8Pv4oElIcmWx21URxBHHz4+8iegg52+xT1Oipdbpt0=
Received: from DM6PR02CA0158.namprd02.prod.outlook.com (2603:10b6:5:332::25)
 by DS1PR12MB999190.namprd12.prod.outlook.com (2603:10b6:8:495::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Tue, 21 Apr
 2026 11:43:36 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::cf) by DM6PR02CA0158.outlook.office365.com
 (2603:10b6:5:332::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 11:43:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Tue, 21 Apr 2026 11:43:35 +0000
Received: from shubhankar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Apr 2026 06:43:33 -0500
From: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Lijo.Lazar@amd.com>
CC: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
Subject: [PATCH] drm/amdgpu: Avoid reset in AMDGPU unload path for APUs with
 GFX V11 and higher.
Date: Tue, 21 Apr 2026 17:12:55 +0530
Message-ID: <20260421114255.3850980-1-Shubhankar.MilindSardeshpande@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|DS1PR12MB999190:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f14175a-fd86-40f4-23b6-08de9f9b390e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Ys/VhZzVaghUvXwWkaqeIEM6eNjW1Uiw6trQxVo/cfRzU+Eh9ypUUBTRDdkDq7A+9JKNXSvQorQZBAtAm7yJvI7crPOs/LsKtAPwmJqZhBaMDaHlJ1rwzo9cKNBkBALUJy43Bg9eMNXvQDkvq+uhT1E02DhsWWzIbLLlhZcZMY92tVclvqcghKgb5XEKC7LwEvaMXTr3whJ/EO1r+Sq5uTPyuuY+HypVO+po+z0CbzL+sXYWmPa97M4GOQKB3OR4KjJABlc7tACpegva2NLdm4gykgXVdwc/hSMsGRhPUuJKJcnHSwnnaBsCuu9GOoiQoVmx1Vcs/HKxlBS/ex/YVNaaPOhFE/EnKJs2pqZ1mbeGvvX7HbK6Bu+p37i56KsB8elFAP4eOmZFtjVptl5NfIA2i8Z3z7h3Fg69OaFzyYhU9BMm4k/XNGCHXHrMLDYCNtHdIDsozAsg0DcCsqAmGMKXiprQ2zWQSgbxQjGoTxxux5KHUk+Zkc0q/n2JZamgnkqxvWcayrLifkoPsMwQ3T8GiiJIkFYVRc2fkcQHiorPWkw6eegM0ib8dFbslvfbAYGuCqbHmGbUw34e3JsItvcdHuIgKNNWH+HlWZNyCgdsaLqxPYREPcYP2yFpX1a6vA0N+wlIG47LZRq+Eo82chSUx71Kka/HDoq2N75V1XP1VRS6CwliQrsk3u4cJy1OSTmqlvNErEX9/EKJArUVYbU/vtNB5aVQ3C4iexkDU/4tyBI+gDCksX4MSt7nF5OqTyeRZ8AxudUobsuJURUjvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: moz/pzvPfszfknzHGJx0TAp1mIeFx4y0SMMH3BLhdn5/bZtwIdcUwOQmC+JV9FpH5/XM2mdSAQXj/9lFCwAyqEs0ZXKTcdm6sZi4rWAjW13NtKSEhqV0jXEJpDzJppBbRQ2FiD/hjuYaBcChnrHDYgda9C8VzxJiHCSrCK5HN/kE1ha8HNWZHuuAQW2SBMS1DEIHgGnA4eDS21C7W/pfRl8DT8wTMqTnJH1PLXcGCkuX7s0lkgiPOYwD0BQIMN/Yqss/tEwKD2Fg9bTqpp92er38wfTTmDwmE5gkKUw38pW9AG4M1Ks/RMXL7cLgA6t7wqM6FRxug/qBijXuqe1UcquP9UgLmQfuYSoZV7KeE3NaGdoKWmYlE8Az4it4RQy4JN/zdygBSE5U8IZsKxPpt6rSIFfuFqZ3lu9DldC0N5RiNMXYrEBGKoCMIw32wcpg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 11:43:35.8735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f14175a-fd86-40f4-23b6-08de9f9b390e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR12MB999190
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

GFX V11 has GC block as default off IP. Every time AMDGPU driver sends a request
to PMFW to unload MP1, PMFW will put GC in reset and power down the voltage.
Hence, skipping reset for APUs with GFX V11 or later to avoid reset related failures.

Signed-off-by: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b11c4b5fa8fc..b8c812f43a59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2839,8 +2839,11 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 	 * that checks whether the PSP is running. A solution for those issues
 	 * in the APU is to trigger a GPU reset, but this should be done during
 	 * the unload phase to avoid adding boot latency and screen flicker.
+	 * GFX V11 has GC block as default off IP. Every time AMDGPU driver sends
+	 * a request to PMFW to unload MP1, PMFW will put GC in reset and power down
+	 * the voltage. Hence, skipping reset for APUs with GFX V11 or later.
 	 */
-	if ((adev->flags & AMD_IS_APU) && !adev->gmc.is_app_apu) {
+	if ((adev->flags & AMD_IS_APU) && !adev->gmc.is_app_apu && amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(11, 0, 0)) {
 		r = amdgpu_asic_reset(adev);
 		if (r)
 			dev_err(adev->dev, "asic reset on %s failed\n", __func__);
-- 
2.43.0

