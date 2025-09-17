Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4985CAC59A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 16:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86E8E10E56D;
	Wed, 17 Sep 2025 16:42:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M6WWSUd1";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAACD10E56D
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 16:42:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yhm0csqE/n3QttUC46HYnvSV4TWXni/Ad1TcQbGPqood7SM4QV6XtSwhHUK9ITQLABd/SeXdscLQHxr1uBtn5qZvgsTU78VpxkG10MJ2ryVJoh0hCHg2enmAI7DCsgM17t2+LCMXUBbyJ3XNgnyRymXv9SHVzXx6VPEE0synYvVq0AzNGfTT/75IEDI6Lcg6CWKs7xTVDYG4Pc/x15+U0PfbccQCu9/cM0oR7h9eavbfr1kQ1h+K3hwbgzEx0fuOMW3Mx09LUwO415U5C9+4AX8SmSN+hAO5TWhhgAE60qx/LDTX53c2NjR8KAzzh/8uc6r68wX0fswb/e32fX0c3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7EHagqvnLqLKol9bvVOvsdBdL51uhC+BaNB8/qD6zc=;
 b=xnvcPWaGZOHuY4eC4IIvG/OvXHf78YyZa5drv+P+XH7lYizQhwDP/fb4PG4parnrQyv2DNxUI1tmue21xuKz4e/QDkMYgSKNUjkPq6/JaBG4ke6qAZCVfud+OmeQxbsm8nGIR5uhgchwe2H1UtJwuMCesdhiKFQgtsKiBR33fH5NgfpAsUjg2v5VNv1KDe6RR3uMhJ5QlTVOHrSHmq5bPahe+eaCCYsAE7kWrs5q/2oh9gvlHmAoVCFg2sH2ncL5JpgsV/P5mzw/iG9tykwNlHD+w5W8kVspa4p8GGKAC8VO/9Be5F2TmKNXW1+l+gmMxVfqQCkwMQTc33fbmB6iVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7EHagqvnLqLKol9bvVOvsdBdL51uhC+BaNB8/qD6zc=;
 b=M6WWSUd1JvfA9pnRAkL3PkgIKgmuX70+F+EKEQRPoyrvJJNtm66q9iYUEaX+8pMkqAsGeAUKCxhRt3tNdIm0DItIrUsQLVlnobiyJljjsxTWDXIfCbjkWM9c/jtcnSQVjaFZ3LufwnhBcrsWi/gahMueBMPp3Xcc0e1u5PBva3Y=
Received: from CH0PR03CA0434.namprd03.prod.outlook.com (2603:10b6:610:10e::16)
 by SN7PR12MB7299.namprd12.prod.outlook.com (2603:10b6:806:2af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Wed, 17 Sep
 2025 16:42:31 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::3a) by CH0PR03CA0434.outlook.office365.com
 (2603:10b6:610:10e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 16:42:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 16:42:31 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 09:42:28 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <mario.limonciello@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: suspend KFD and KGD user queues for S0ix
Date: Wed, 17 Sep 2025 12:42:11 -0400
Message-ID: <20250917164211.1761304-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917164211.1761304-1-alexander.deucher@amd.com>
References: <20250917164211.1761304-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|SN7PR12MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c2252e9-dc4d-4e87-72fe-08ddf609322d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8SsCe5puU/uzQCEUImDPyuwik2cKX5Uu4vMBz10zn0kNwk8CiKDTMuMp0Ldn?=
 =?us-ascii?Q?h20ugtgy0rP+icYwJdG8f2KC4QruGGXY6p8HetIkdcWXS1HNGQOZe/JhnxcG?=
 =?us-ascii?Q?oAQo7FhCDbPTmErdcp+gabJ/9y19QlkA+/0zp6gk4JPDBtzwEfXYEDWYkKRN?=
 =?us-ascii?Q?BqqZ/jzqHR99V5qAuVEZlIA4KrVP1KpheOjrd+Cp4+SE0jotUL9cORrJNkjw?=
 =?us-ascii?Q?cBbXlUIiaRY55gJ2QMRhsrM0l3KmbZZrD4v8xirP9hUFdF0gIGk6CN8R9w3i?=
 =?us-ascii?Q?DZoviEEcQ7hqFUY2/0a9QPcQ1FRzFM+clFQp8gqPDH8KH67fGmPsRnjyqaSy?=
 =?us-ascii?Q?ZCaOgYf/cMJ8HNjC/wAvTuCLLSC6EptGFkMBKtf6jpc0AzOpkUVDDyZ95BiX?=
 =?us-ascii?Q?nkQtaNfpDTGd9lUD34A/O/ivP4YIF4Z9HaHBX3UYIQDk9lRoiRn/NaYH+gTf?=
 =?us-ascii?Q?xFfg1Mb8nXcIFntJWbkcIeY+KI3Xg6ikUztWAVprI45MGDd9X8gAIDApHH5j?=
 =?us-ascii?Q?cExpoVyqYExxGqCQ5OFyIRPiqSKTbLvsKXq2U+n7Vk1up/aGB6RZWkELjG8X?=
 =?us-ascii?Q?zlp7KbLGiZgGck6gbEi/K0cm8SeDn/1Q6cbvOkcsNVBIMnGX6sCoKEdxvkZZ?=
 =?us-ascii?Q?ojuW/T2CuNAz57Vqt9ooRf58fhaSZNO3mVYoHcR7sHXNfmEVPE8ZX5eZPYKC?=
 =?us-ascii?Q?J1/aKd/0YQcZaqtMFbctnPq06LEzX0hqfrovV0BkIur5p/DPiPppku6YpdRB?=
 =?us-ascii?Q?BCpwNnxdCBGmL1rZz9dOMeayGN0ipTqzNLof7dj5+JPByYiXt0OQNKX+VUH8?=
 =?us-ascii?Q?shZ1T5KqMhLp2bi/J7V6ryVu2wyhGMF+18AvwvMX5L32FHFzZ5mI3TUkROWe?=
 =?us-ascii?Q?ILGczAvt8vWzQi2IWw18fc+/k8m1JAN1inAvzWmCN77MeXxsUGj6j8RitKg7?=
 =?us-ascii?Q?ROS39T7JUGvk4/t6jQp2yM1MrZQF5gBpHr5fZlzlJ5NtjuI6jgUpJva3goMy?=
 =?us-ascii?Q?8QRI5FuTAlQU1004k1LUKcCxOARdboA/J/EFl9nsCF9kvM0t/WPJ0mpbeAiO?=
 =?us-ascii?Q?8JBGDjm7xVAGbGYGE5E84pbjE2Q8Lk6kQQG1M4nxz4rKKw8FCx9gfocfb6fg?=
 =?us-ascii?Q?DGimZ1qIUNQxsqXMPssuaDOtcFRDOzEY3/qYmgvETmQKTaJWu2Wtp+7rhzY4?=
 =?us-ascii?Q?6UPwQuHALkwt0njJ33yFvaEAC3E3Pyq0EucuEqRx6jpNqd5lElYxaaHMxMO0?=
 =?us-ascii?Q?bz8kEb+TPNTpvn9y8PyT6HTLFftL2oPJ2is6u6cv+aFlXhl09UR9NiKQ/epT?=
 =?us-ascii?Q?IWbwnO37aOBfDpao87cy8parkrsuzWlKGb4dy9gI86cCQTHHzB/92FV3LYge?=
 =?us-ascii?Q?HwdPPjdmR2rk+hG7ra3YKNu7trjprGPMNeopu5n/q4aoLn1udWGsX3GwKIYs?=
 =?us-ascii?Q?3UThy1LBDyHQ9lzqEb4EuLWwd7o4oFvhj5voZ7PfeQga8pXM4jH8I4pN/2pL?=
 =?us-ascii?Q?e2Ic4IceN7m2IpOttOOpGBVYXe9S4VHRMf+n?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 16:42:31.2915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2252e9-dc4d-4e87-72fe-08ddf609322d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7299
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

We need to make sure the user queues are preempted so
GFX can enter gfxoff.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 +++++++++-------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2325a64fe6f12..136f0b6d0ba22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5203,7 +5203,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	adev->in_suspend = true;
 
 	if (amdgpu_sriov_vf(adev)) {
-		if (!adev->in_s0ix && !adev->in_runpm)
+		if (!adev->in_runpm)
 			amdgpu_amdkfd_suspend_process(adev);
 		amdgpu_virt_fini_data_exchange(adev);
 		r = amdgpu_virt_request_full_gpu(adev, false);
@@ -5223,10 +5223,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 
 	amdgpu_device_ip_suspend_phase1(adev);
 
-	if (!adev->in_s0ix) {
-		amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
-		amdgpu_userq_suspend(adev);
-	}
+	amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
+	amdgpu_userq_suspend(adev);
 
 	r = amdgpu_device_evict_resources(adev);
 	if (r)
@@ -5321,15 +5319,13 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 		goto exit;
 	}
 
-	if (!adev->in_s0ix) {
-		r = amdgpu_amdkfd_resume(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
-		if (r)
-			goto exit;
+	r = amdgpu_amdkfd_resume(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
+	if (r)
+		goto exit;
 
-		r = amdgpu_userq_resume(adev);
-		if (r)
-			goto exit;
-	}
+	r = amdgpu_userq_resume(adev);
+	if (r)
+		goto exit;
 
 	r = amdgpu_device_ip_late_init(adev);
 	if (r)
@@ -5342,7 +5338,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 		amdgpu_virt_init_data_exchange(adev);
 		amdgpu_virt_release_full_gpu(adev, true);
 
-		if (!adev->in_s0ix && !r && !adev->in_runpm)
+		if (!r && !adev->in_runpm)
 			r = amdgpu_amdkfd_resume_process(adev);
 	}
 
-- 
2.51.0

