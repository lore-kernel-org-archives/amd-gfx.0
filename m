Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0478CC5AD5A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 03:47:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D22610E3C6;
	Wed, 12 Aug 2026 03:47:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Av95heC6";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A882310E3C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 03:47:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXgm8VCZ5qcOZd3C2HRgRikP+WzwpoL0jPgTyP3i5M7zF1MA4Js7Er9xD1MH0wREA45NvYw84mvpCJWjkvKREDVq9jEabrt9Vd6pwefrxtxMTq8zHPLjWCP4zMXLrOsNUhMHQuJETi9TG7SXGU12h9lYtMY6bIdZxq/FXpdSRN/B+v9+jKP90uUhE6tSHN96KcAbxz96GJSv/5ccepFREiZZApGRbopo0+CkAuZEHxHvoTe0zzVluT+AMRE9oRBwlUyjs248iWmNsmjqSUomaTB2hL9AZVb8zE9JRvWm7rayP9HGoFvdec+UxILqJ5RquLKvf49AkhIaTlkMn2lqhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoxdEKIyEDmDkScOqRsDEYwrZ5hIL5ivCCmm7+t5+9w=;
 b=QOGUIbE8cJARasNbbuRy2zt4P7lKFa/6w3c6t9HgrrvTCJimghRNFYrDyvm8Yu7j9V8Aj0z4GuNEfjgw4C/aXVYEl/kqgLqz4Isd6jMJ2oRgGCjWEDhKUZ31SmZasnyuXjYlsduenqkkKp5zHR58PIUimHWMgE2wCR6hY9JMGgSon1bO63V1W7PflCtMU16ZqEg6+aFu1A2x5Xsf4L8GdHrl1VfDoFgThL4rd5cAMLArJcW5OZn2lFgvaoZczuLjOESdJDGsOKh91qGfZ3qIIc0VtjBHMEPTc4HlYAfojblfm0hdxpca4qhyp9zvMHOV/qJnLGZXlp1fBLBGF6TanA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoxdEKIyEDmDkScOqRsDEYwrZ5hIL5ivCCmm7+t5+9w=;
 b=Av95heC6pXg8EwJ8DOFfM0g+V77rvtWSFbu2ZLUvxz78Avf7xP9v+Rqu2sGpbCjrxLQeHYrH5AmyWLuyKaVNfUJPCbWZgHy3z77lCCuWEQyO374HXx8/s1uN0uiQCS+WBq21NqrhrmhLT/03zec2WrcCfE4aF6Ca+HCSr9xornU=
Received: from PH8PR21CA0007.namprd21.prod.outlook.com (2603:10b6:510:2ce::13)
 by DS7PR12MB5742.namprd12.prod.outlook.com (2603:10b6:8:71::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 03:47:46 +0000
Received: from MW1PEPF0001615E.namprd21.prod.outlook.com
 (2603:10b6:510:2ce:cafe::75) by PH8PR21CA0007.outlook.office365.com
 (2603:10b6:510:2ce::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.2 via Frontend Transport; Wed, 12
 Aug 2026 03:47:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615E.mail.protection.outlook.com (10.167.249.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.0 via Frontend Transport; Wed, 12 Aug 2026 03:47:45 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 22:47:44 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amdgpu: check thunderbolt before switcheroo registration
Date: Wed, 12 Aug 2026 11:47:33 +0800
Message-ID: <20260812034733.2087420-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615E:EE_|DS7PR12MB5742:EE_
X-MS-Office365-Filtering-Correlation-Id: d4e63ba5-6cfb-4c88-7fe2-08def82478ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: LVbO3ClO5PjaDpy5+v11w3m3h3Rx9PlnIHOydsSAtiaL6jhdlH4m9zZ4ZA4mnfZa78Y2rh87H6HD094uOWZMZqe+hhG5GnfjxGP1lupvOM948KL/OGWgW3pQssHz6gQlzPICVJvIXKZym/B7gnMy5PgJes+HKjJ/cttwUh7/nK7MONcmjADJODHrZ4jgjgbRGN4zZCTbeDcDR6hhmaS+OaTItBorDPkbNvJkFFTzi/UcZ9C2VBPZV4YXJHjaarynYivJ3lauAz4pA+pJztPSJCBuOPQri1cb3OuG+ah1c1eGpKubY43eGUIMDjWRHtb6GQHxdHZs0v8j64fwi0zJz4SUZepEH7qLPh0ck+cdsv3OaqsJSA+dCkO0+nkqAtVJ4ED243t4bz7UDcjIwEjQGOhA+eQRHpulGkRO3MW2ZDuHXy42m3hAtuhhOJwkP0nwRIUMeQu70hjiXMcDd5ywDVhUlB9DK3d3EzfErAvT1/Nk5XQELRr+e0WcPzVswhhQtkj5kzX5XY9tDoWlUpS/JrmqnKtwD8pn+f40HBqjNJcikiCWbyCmGBEaCuYZzrcRI9/4lT+9QAIF9w5IBj6FHqZRRIhoEmy9E/faBt5jsWbVgwYPGlUOVV3222tFrfkmGwhzU+SQl/gBUxi1U6PScaiH+V6ZGzVgNlWgo5aOkv3uhC24srKKNHsEXLpZwUNcMk49ZQ4iO1jjtGIen9K8cA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W/kZ9JpMbqgc6WS0NVx8n0CN/9e8o3SXA2N8IsTZuZ/8VdmS5LUxeiJRkKGlqN18eGO2VO1/+mHkz0otoc7tjg5/ztaR/dvDTSnibwGFoll0pk2MlMr6TYyumy0R6f+qOHxMyDUo1mfKRkyn4X3TuSJo6DI/n+ClmEYdeGSKS4KErzg574G0GRpUrnwA42LFyhIocT1vLSQg1QN+BQxC3pjA7A6Js2OKdelGuvkk74D3nSq295F+ZKqa67+2sKDTWsaa2Wh2b9jgS44roHu+6zIUziVCE8C/3wvlGqZpopJ0f6pqfyg8lnOfX/nUisRWrVoFQa3qtryBmJE8E5QmpE8K96J+TOyNmwn8zZAVAKt6wUzB4NQ2hMmx+ltu22eH0Ix/DAeW5nRIbZG8wSo/1QPWTqwsqzZZxV4CgUhF2WWZl3rE5ayz/KxK1Bc7X2xK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 03:47:45.9065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e63ba5-6cfb-4c88-7fe2-08def82478ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5742
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

introduce a helper to consolidate the vga_switcheroo registration condition
used by the init and fini paths.

keep the explicit pci_is_thunderbolt_attached() check, as dev_is_removable()
does not provide equivalent coverage for thunderbolt-attached gpus.

this ensures such devices remain excluded from switcheroo registration while
preserving the existing px and apple gmux handling.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index dd48ad6e9c52..5fd9116d3581 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3807,6 +3807,14 @@ static void amdgpu_device_sys_interface_fini(struct amdgpu_device *adev)
 	amdgpu_ptl_sysfs_fini(adev);
 }
 
+static bool
+amdgpu_device_should_register_switcheroo(struct amdgpu_device *adev, bool px)
+{
+	return !pci_is_thunderbolt_attached(adev->pdev) &&
+	       (px || (!dev_is_removable(&adev->pdev->dev) &&
+		       apple_gmux_detect(NULL, NULL)));
+}
+
 /**
  * amdgpu_device_init - initialize the driver
  *
@@ -4257,9 +4265,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	px = amdgpu_device_supports_px(adev);
 
-	if (!pci_is_thunderbolt_attached(adev->pdev) &&
-	    (px || (!dev_is_removable(&adev->pdev->dev) &&
-		    apple_gmux_detect(NULL, NULL))))
+	if (amdgpu_device_should_register_switcheroo(adev, px))
 		vga_switcheroo_register_client(adev->pdev,
 					       &amdgpu_switcheroo_ops, px);
 
@@ -4424,9 +4430,7 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 
 	px = amdgpu_device_supports_px(adev);
 
-	if (!pci_is_thunderbolt_attached(adev->pdev) &&
-	    (px || (!dev_is_removable(&adev->pdev->dev) &&
-		    apple_gmux_detect(NULL, NULL))))
+	if (amdgpu_device_should_register_switcheroo(adev, px))
 		vga_switcheroo_unregister_client(adev->pdev);
 
 	if (px)
-- 
2.54.0

