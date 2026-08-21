Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573A3C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:46:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E92AA10F4BC;
	Fri, 21 Aug 2026 19:46:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wvHgGuDO";
	dkim-atps=neutral
X-Greylist: delayed 590 seconds by postgrey-1.36 at gabe;
 Fri, 21 Aug 2026 19:46:21 UTC
Received: from BL2PR02CU003.outbound.protection.outlook.com (unknown
 [52.101.52.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F6D010F4BC
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:46:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UwID6CBEeGXAStqIfhyaI46QQ/OhNm0Q8GmtbkVMvFAmye2B5887MgAjAOFD3Gk9Gyhu/kHfn1PyOZdEYdslbFdSO+kLO31tUXHr+1W3XUP6LsuOWqPl8tvCvP2XxJ17jGr+tMhcr+/drBddozsVO8zE8pFf16DdEzLra3XI9Uliy+AddRXgzRghHS+RRsKsV67uETo/J3cQ/fYILu/vTvdVvYbN6tFkIjrysXp79DEsdlBKARxxMyjDPA5AGmfRJkQH4dPokzpQ6Ds5OUJPFbcvqFA9YNqMzZNjdcYUwktWQDaBSccIqsDwv59a+qgnYiWX7bVXjTnKob5UfcTszA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8rEtuuBKNtnjZ5UTpk1PMWme852WLSRDgINtQuvhzo=;
 b=gZOeFTzzyrc0IMDL8+msd2ZqA+doxOcrp0V7UHa5QVwajCdKqoT8vl5YCfwPu25dIj3v2eawFBQMiU9zFsqtqiHcIPv/hHq5W4z8Mk4WCcn1CLcb3PHvCLW9IyySXBgKoLZO655SJUEL0MMsVJn8i0qvjh07cnMHxbQhXCuCGCOp5DRzIGcA6UxCKKf2d3zIfAH7UfGHCSQpU7AGHxlr+8YCKLWf1U7YBpYrg4Eoh9nRy8BZVXHhHJw1k/4w7LKbtVDapmhnNOA+BM2rGGuzoLXIFGOv4XWY373JebCn9UxDrf0CIBv9VCY5sNocOwj0DD/tvhQ5Yb/dwCgzx9Rxog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8rEtuuBKNtnjZ5UTpk1PMWme852WLSRDgINtQuvhzo=;
 b=wvHgGuDO2JcfA5/he1sALSrHTTxjbpnAfYfGKY8QaUWbCxmanRDUFfuaho0f96YHHIuf6VAxLvvmGmyAP0wjSq5NaMLc/H0z5byapY1m/PiFv/lh74tEanLSijytxrWC+xL1aiqmW3WN4AcyN97a6PUYnrRpYwac2GVYRyRHBew=
Received: from SJ0PR03CA0211.namprd03.prod.outlook.com (2603:10b6:a03:39f::6)
 by IA0PPF7D094C5BF.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:39 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::9) by SJ0PR03CA0211.outlook.office365.com
 (2603:10b6:a03:39f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:37 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:29 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:29 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 29/95] drm/amdgpu: Enable UALink Manager when pod becomes
 active
Date: Fri, 21 Aug 2026 15:33:52 -0400
Message-ID: <20260821193458.808626-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|IA0PPF7D094C5BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c85737c-0ab6-4bed-fffc-08deffbb6077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Tvj3OzoFD7MxlobM250grULfgsBqeTpsR86kE9ZGLnQM75EQLz4WuwFPK+fUljzfCPUuLoVIYFGKx7GVenK/4IPSsKEq87C7NoazVqgIdAHlsapsd5miebcRXbNQPnLGXmocZsWk3to6weKFeKDOmtdBJuKyMVIVda7NENIY1qMFptRMnCncWPKu2x7NkrgKeyxRgSB1Sl+xKtKnxvQ7ub/WtBJBWc7gy0mYUHoSM0/vSJ7IQxitXYLKovCENq9cSkOmnj0s9Htv/Tz9OTSFqoKfVNXXjgnyBhd4S7NZNATALzTlT+bsJIT1plo6UvsUKryRzDplK6AAKPhekpvDo/L5htYDxNC3Q7ovueh0C5M2MKtqxj5OJLi//vaV48q/1syWN28db2Tn5lBNCFjSTe1c4LahkgX/4Iv+Jl/0A0v8euIJk/lHO1rn0ZViGjrkC0VNRD32iRQ3vNFyHzsUrtu88+sbtpc57SDYp4ukrCqV0+ggB6emv8gjZtFLEQIxPcFkixjGTUs+LTdtC3y+pgtNk+ds7dYy81dIHXoGynys7BaRcN3M7SGJgoN/Gx9q0kf+exNX8oXA9f9zX0I6apd9Vfbm1v2ygVpslDkykqqFtpPqYSh+XygA9I9mmB3vyYyQToZscHveMu4MgiQl/sw/OTxKNL8zYmpGqixQpavQbuVIMHUUy+Y/nAqeMJ0ymV3VSCFjWiQfGRlOoXp1ZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mQ18c6DtzMwRP9sB8i6m7L+kblehMZ2pc9rpLdttZqipQR+5S27rJD4dDgcGhhGEL9owp2miEn173E7HA2IC8BTrEoESbnw1CSqN5MtOtx3nD+zKDWYQuEOxQLmQPkZeqn6ngN2xTbwYXPwidI0S62NXX7AJ6+A41yvWxfVCu4rjDOPtkmqqRB3hHI1Do/A19sI9DhYIT2UT00O9svLfvtAGfwzNc9x0yXYouya9iTnYXtSIdmKsynESdtvoObdGl8MzLb5v/2VQlIMzaSindVI535kSqITn433lAW1NZHAZx6G+zDWZ0NECtSRL1maA+TsJJTgFWwhtv45x3awa4aEQ0M7BWFI7jvcCLw15aIXUNGo0ZXHwGIbYt+rCduyvo4PQ7oeRXCiKG0CY0q/4LZrpaJCHVPfLYDcoRo5zriYwM8WhE6llVDWiOfBy1iEL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:37.4532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c85737c-0ab6-4bed-fffc-08deffbb6077
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF7D094C5BF
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

From: Mukul Joshi <mukul.joshi@amd.com>

Enable the UALink manager when the pod state transitions to active.
This would enable exchanging of memory across GPUs in a rack-scale
setup.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index e1e1757050152..e00686a902ef9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -656,8 +656,18 @@ static void activate_accelerator(struct amdgpu_device *adev)
 	/* Enable incoming NPA address translation with NPA VMID */
 	r = psp_ual_set_npa_config(&adev->psp, adev->ualink.psp_if_ver,
 				   adev->vm_manager.npa_vmid, true);
-	if (!r)
-		adev->ualink.info->accel_state = AMDGPU_UALINK_ACCEL_STATE_READY;
+	if (r) {
+		dev_err(adev->dev, "Failed to set NPA config\n");
+		return;
+	}
+
+	r = amdgpu_ualink_manager_start(adev);
+	if (r) {
+		dev_err(adev->dev, "Failed to start UALink manager\n");
+		return;
+	}
+
+	adev->ualink.info->accel_state = AMDGPU_UALINK_ACCEL_STATE_READY;
 }
 
 static void deactivate_accelerator(struct amdgpu_device *adev)
@@ -670,6 +680,8 @@ static void deactivate_accelerator(struct amdgpu_device *adev)
 			       adev->vm_manager.npa_vmid, false);
 	/* ignore return value */
 	adev->ualink.info->accel_state = AMDGPU_UALINK_ACCEL_STATE_CONFIGURED;
+
+	amdgpu_ualink_manager_stop(adev);
 }
 
 static void activate_local_vpod(struct amdgpu_device *adev)
-- 
2.55.0

