Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09EADC021A4
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 15:16:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9A4B10E8D8;
	Wed, 12 Feb 2025 15:16:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ly/aBFNr";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B3D710E327
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 15:16:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5QcG+tCEkIITEaWsnUGnLer0tQ53xFNNbFryB3pSoajShpy0mVe7rA4lrm80Rqukrmj5mGvTBzByqg3zIncoETTgucR6kdyLxB8xywXQww63ShRAM28lqBELv2FBrHSSJ4p5BPiJpoKiZ3MO3ajGG4vwVd6wKprP4otpOz3riT15EVkQ92CTQ+Tib/apgOvVogVFghbE623QX7Fkj2ZZ7fF8P3gqIuDZiBz4DyUhYlFTR5wr6kkib3EUD00rNN9+Krk1lAquy9rfMtwpXcG57pJ1+aEB7Rx17kAQwSpcVhMlRZ+MH+p+YP3I+CuW6dyTQTgeIE59+aDXe82y/VbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SC1/7y51cFzJBCT67samhTHwIXW2/ce6G6T5udDf3mk=;
 b=dZ5WodVzVcJk+Vxdde12vqtxX+Di5cRXOYJ2Pq0kYcMxwKz89w4tnHRnICQE+YhC4A6EKz1e+U8ZWKM9UdzSaebF9prB4cifbLx0N46OaFkiSGyVNq8FC6mhTkZHP2JxZKwRI2vIrYtgBbdWOpIE4gWXWNvAyKyyWOGJm7Wcd7eOhUcVSZCdJK40xmzD+K7cxsfeaXxWmkrZiBX9/qZZsSunohWsVPfXU3HZDVrdbHypfP7d9SPrr4IhpbDi5kfgEIqUVZOacS0/amp6f5b0esUUW4isKlJCx3PiIJL5Jyd8hLVU9JI4vFD/IUpOeAMDc41zsR6mAqhMPZr9X9Q22w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SC1/7y51cFzJBCT67samhTHwIXW2/ce6G6T5udDf3mk=;
 b=ly/aBFNrEbHgL7nA0z1LdxM2LPYOgLQND3oSmTV+gxTI1N2fvTODQkgov0Ts0WQM2O8Sbs0MyyC13hW7eyJqRrOIKZHw37EOvCjbuV0H2755/0nCwbT309bnel5CbZwfq6RGjg8xP5YXOg8zrgTILjzm8bJPc+3xMrO4mDpxIA0=
Received: from SA0PR11CA0076.namprd11.prod.outlook.com (2603:10b6:806:d2::21)
 by DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Wed, 12 Feb
 2025 15:16:20 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::eb) by SA0PR11CA0076.outlook.office365.com
 (2603:10b6:806:d2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Wed,
 12 Feb 2025 15:16:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 15:16:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 09:16:18 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu/vcn2.5: drop dpm power helpers
Date: Wed, 12 Feb 2025 10:15:58 -0500
Message-ID: <20250212151559.2683916-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212151559.2683916-1-alexander.deucher@amd.com>
References: <20250212151559.2683916-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|DS0PR12MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 10090806-c104-4c70-47e0-08dd4b78342f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4UA37rT0bVHsyWlmPphY4peAgzybiS00Q/RAIll+Z2Jvr1gA6HOIMZakELeD?=
 =?us-ascii?Q?QDB46ONnAuphpBRlRQRo/tAj7cnXsleQtR6aCcQ2ekt3y7wZKw2h1oASw8FK?=
 =?us-ascii?Q?QDdpjaInfyTsHQ/5NLRrngRUvW966+RolHIxekjVKFOwwb3nUcEE3AB/xeuU?=
 =?us-ascii?Q?dTtpkbiHMoxea3s9nglk9Svp1YW2LLH2daBBM0Ei55acwB7DZzutHC4+SfGS?=
 =?us-ascii?Q?B4T97nmF41RGzrdqvTUJBtev0ePpjKNVcAV+zh8RpAobdm7pCMLFonK8eZ24?=
 =?us-ascii?Q?LNxA3H1pRk/waLRZtPpllrG1QrixVmfCFq1qPFSbTnqsRXoQLjQ38hCEcVhW?=
 =?us-ascii?Q?dJtwXGklqMJ1G5GCkCtiCEU1IXKyXIAXFSS+YHR3mMJPikxGmuDIOiSgK8r8?=
 =?us-ascii?Q?CDf+Iw7u0Z/LwP13zW/OgnQt+N4ln6WPeae4zFJM92a/UdvgNuvylCBQ94la?=
 =?us-ascii?Q?2YzTt2YVgfZP2Cm0dzLsovTC9ObAhsvi/9sR4o+JT988sbITjOR714eZ+tst?=
 =?us-ascii?Q?+nwCm0rkDpscpSf7OkkBw0Ijmja/ngNYCYRTXaGoQqduUwqQ3Q9e7uj4S7Oy?=
 =?us-ascii?Q?4u8X2dooHvOQM6k1SA8IE9DvGMBYdxngTXO5twPqrK0uxJ0pXORMa9X7CKX9?=
 =?us-ascii?Q?9r7dpa2LOj3oZrfJbznY0qSOXpms4eaucAFixH6ffVuo6Lk18Cv082D2TF5b?=
 =?us-ascii?Q?5QjMCjlDx38H6wHvTHNKAq7VKkMYz3A5JWvTb//JUri8LnHfsEeIEEplErBs?=
 =?us-ascii?Q?hknik0qAyF25bj33ngnn/NyJTc1iQJjDBX7DuW4rIv+oq624C3MmDvLNllqd?=
 =?us-ascii?Q?xt01GzU2hdGsoVRS4oNm0N/rh72x1Es7E0iuBzayZjs6OVeZg3ZXc461fBFD?=
 =?us-ascii?Q?4evalqGyucVSLLbYOZ9zm8t2xjRMpx9ruAvysiWbv1piNTwhZI448pqR/kgV?=
 =?us-ascii?Q?tjKvs7NSDB4gVVheWZwSQuWONxK6qq1gcOppbUJdxyGezzcMP1YaY22ZdGQP?=
 =?us-ascii?Q?96ndjeOLviZdUCj67faJdoSKZbHqWuj2Xw69WqSqkCAWmFLCeo+MH4TLTjBn?=
 =?us-ascii?Q?O5BlzEpdnMTWTszZUcp9ufGHavH5+uhgbJUVXChF2AP3gr+e6UUNRQ/MdA+Y?=
 =?us-ascii?Q?XFrzLiXJxMNE6tDxhVdaL4knv4jjS85UFjokpeooR3KzYTVa950yeFVxi79Q?=
 =?us-ascii?Q?uRc9dFCWB1YdX1OIZfFfwmhz6TllvUvDzJ29YF9RMrDKvAGz6yYZ3adyT3Xf?=
 =?us-ascii?Q?DEHtSaevs3340pB9CHD4vHkFIz8ABPgAByYioSg/UlLel1tOqDsft2j32g2P?=
 =?us-ascii?Q?8Ja+MlBi30z71sCcn9GEyZzNGCmgBn1yeEA3O1Z77XdDPHRto8G8cPnxS4in?=
 =?us-ascii?Q?zKfO+cWTPY42cpu+LwS+PbM1upPiNZRyzyEMwOEqfOtWwk8oTsx4ci2676BB?=
 =?us-ascii?Q?OkytrMIKuEN6AJxNPouh1joFnEFozgy4d19spKOX2OXrPf8qwDEDgFIQ93+e?=
 =?us-ascii?Q?WITBN9UV820CvWU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 15:16:19.9369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10090806-c104-4c70-47e0-08dd4b78342f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780
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

VCN 2.5 doesn't support powergating so there is
no need to call these.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index b9be304aa294b..08e73d1685e92 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1011,9 +1011,6 @@ static int vcn_v2_5_start(struct amdgpu_device *adev, int i)
 	if (adev->vcn.harvest_config & (1 << i))
 		return 0;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true, i);
-
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		return vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
 
@@ -1465,9 +1462,6 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev, int i)
 		 UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
 		 ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false, i);
-
 	return 0;
 }
 
-- 
2.48.1

