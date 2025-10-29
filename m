Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E086CCF9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:50:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A292910E215;
	Wed, 29 Oct 2025 17:50:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jz6NHW6P";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011040.outbound.protection.outlook.com [52.101.62.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E045410E214
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:50:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPRalqqiv+v5C8358ddyvCCuv49sQOsriAGzsm/+4u2lEsYnP68BgEubAT7lajdqjdBjZ9p2ICcNCpMnOiMA5QxNQXZjxXsT+h6GA0lZ3CX6JWBLzFTbamuhUIbND0oOksu9m/EZEu4jwOXQkDPE4x0TkoHHCsEauQOTCpbcrzLBOuwDBdjkyZgEmBUTTy0jIWzcmxIuIMsylaqRbJ7ngY89GM/zaecJDXucvX5Ai3HIxUWVxx0+vFUgy05jRj20AEcWfh6gT3AoEcuij5NlquGwooQKMS5IgN9y7+BNOet2Z1U8fSfZw3z4K56N4gYacKgQcZRPq5xUVd/1xJoIZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZ5vBImQkcprVy8Tio9V6bEPADhcJ6E3UrlFP/Ij0A4=;
 b=rfBwrtseIb42OecHPY2m3+CYjICr+qKCLbPV42KJpfpuPO7XsxpZlVMhPIX5+kkUOPfv2XStgFe+xib5PaQstfytAr7Ic8ZabzPw16RFOfR1Cma+nPvveyw55UNauasSOV/54gck/hpCjfxiP3vOQ07/ZWmhfX2+th4ms62yLbfxtvwlzhWIkYd35HM5h00oRrmAsLwtpgprjPNSAicy6psGhskfqgVfsrHnvE+hULVTjO2mdIOXQLqz7aectrS/TAnhx73sDyEao5yLAa+ROnYHcBYsD04M5vFcYRdKnwiv21J6esANg4M8tkE6TyRohqb+L1oMuEeqGU8dZDaRhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZ5vBImQkcprVy8Tio9V6bEPADhcJ6E3UrlFP/Ij0A4=;
 b=jz6NHW6Pfbxr73H8vHSmbYIHq35hYPhbZaE1Ocl9aEK3avJ+arAr99nQBQxO3lxfEAmkCYu77AtlIxbAMsrz5RUS5Sm5YMbKOk3hTfSAPXwjPe2yKBiQmVEB1QwmAqmevSgaVnJkllVgCKxAI/SR/agzxQgcwaY4rcPnZNSCXGI=
Received: from MN0P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::24)
 by CY8PR12MB8241.namprd12.prod.outlook.com (2603:10b6:930:76::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 17:49:56 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::2e) by MN0P220CA0030.outlook.office365.com
 (2603:10b6:208:52e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 17:49:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:49:56 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:49:54 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Le Ma <le.ma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: fix NULL pointer issue for supports_baco
Date: Wed, 29 Oct 2025 13:49:39 -0400
Message-ID: <20251029174939.2861192-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029174939.2861192-1-alexander.deucher@amd.com>
References: <20251029174939.2861192-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|CY8PR12MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d407cbb-4fb4-4093-3e65-08de171392b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z0nYcBD77wrxxKrgbu+b5y6ejwVFh6ouxa+zZ8F9FKg0h/ZajMiBojSxYuSS?=
 =?us-ascii?Q?z6LUNZcYWANLp1BDDsw5NvqdPZ2+RQ637lqIkz2u3V2pIZLnHZPqwCuRz6Sz?=
 =?us-ascii?Q?a6nE8GHMeAmEPbW+Nz+OfmB4xv/XBflQWXyaT4kK9+OG59xrVKwEVVHmA73t?=
 =?us-ascii?Q?XmR428aeb/k1bh0UbOwxSwbdConIohjgO2jDySrlyUBx7tB+PJ1SVc2dd/7E?=
 =?us-ascii?Q?gunQ08HPc1gTIdgntuCzu4kbioLw9dJ063I63LM80QceK5lWBeKEJs2pvdAZ?=
 =?us-ascii?Q?NQDFb0zzSmy4J9DQe98gb1tATYbteSQlCXs2oD5Y5nuU7fOMVnDo6FMu6CuN?=
 =?us-ascii?Q?0VPqM42kedVA1aTYRVP5oJ/9Ws5GFLiLJG3QTFRzNn3vFU5MbBI1HYaCdbUx?=
 =?us-ascii?Q?zxNKV6UTuyWyNChSQ0DkfAmcGuFAwMt9D1dPO/HTe+D5Yq/hkUv9EVBJTr6h?=
 =?us-ascii?Q?PRR7nYTGDVLftrkp8fJNbyrcj4GpHgajuEsJB9TNXIWhQb0dsOFpfdgdajWm?=
 =?us-ascii?Q?lyhDmhRslPJ4I/ejq8+7QmcA8O5KdyZk0r5/T5DSg17qjW3iSnpqIMOUAh/+?=
 =?us-ascii?Q?rS3y75I1lPzym805+weH5QVGSLJXNVhXi7HaC1IOVy8x3VNpp/RZtQPbk+hW?=
 =?us-ascii?Q?IqbOCBoi9z+VjwZMb9+SFrVL6zc9hmBk68yz8T/PVIx08IrcogYJU1Lt8n5A?=
 =?us-ascii?Q?xTNh+NyRWV3QWMwCUJmfwMFm8o0YXs29yznNKXRhN6x721QqLx7EXzFhRBkv?=
 =?us-ascii?Q?TWoOZoN5dnmehWCrgWGbow6dxPROVJX5PT61j0HUMAp0YlqfnYNV+knrJrXf?=
 =?us-ascii?Q?i1hZxJPuqT7UfMXSH0YpCYsamYRTWLLNcTB0QKd2knK99tvEamIUC6jsPnxx?=
 =?us-ascii?Q?yjEnqqzxodayrMSVbep0rt4Jj1F/w3vVjS9kOtHmh0rSLd/hRMG+Aah92yqn?=
 =?us-ascii?Q?I8wHPVnvjYauimJxWD083VueMr+qVBKjKuWvRhZTQu6tNKl4J0p+uUz0Bz9M?=
 =?us-ascii?Q?l9msf6ZMdcFXGXMkhOIId1/xgpXregE6TnhVb+KOyhgTx5X8mjSc7S8TIrkS?=
 =?us-ascii?Q?kH0+KRVdUWXlr3+L4QPx6f5GaZVdEB+mQkQEfdAbFCc+onqlX4auehZRoom9?=
 =?us-ascii?Q?bwYfgmA/w3v1zVY/KJSKGrftn0mj0xTC169v6dwdK7Dh6X1zJ0vH5fjr1UTN?=
 =?us-ascii?Q?1p+FY5n3y/2wsiERjrR2Khyo16yKTUMAjJUQwaIlm0ocRIAQ+kzet+JUPaSk?=
 =?us-ascii?Q?QqQ7Z+cEE1g60Zs3ZQlJWx8vjcYqk9vWmm2in0nlW/4p8axxPHhNppzVpL1G?=
 =?us-ascii?Q?lCH/2Fuy0sOftPCBDpQyh1CIY+yTlVS8WKXPZ9jNKKmSgEBrPH8mnKksQSY/?=
 =?us-ascii?Q?84FMwFBiC9ZUwWDgmEaSYRuVFoG0v/hs8uyao5lWj0T2ucQ7Wm99QfKZ6IT1?=
 =?us-ascii?Q?H+Z/3fkrDeoRHnukhlv1jweSn7+0gVapAJetLQ7MMjHLxLiYj7oMBuUq32KN?=
 =?us-ascii?Q?44Cb2ScRHn9J6kZINM12p1AqVJeTRpQFjQO1e72hwUDGrjyELNu73TxY0j9+?=
 =?us-ascii?Q?UFm752fLES1TFLM8j1s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:49:56.6203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d407cbb-4fb4-4093-3e65-08de171392b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8241
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

From: Likun Gao <Likun.Gao@amd.com>

Return 0 if the realted ASIC do not have supports_baco
function to fix the NULL pointer issue.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index bcfed46eedaf5..4771d6de9c0a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1544,7 +1544,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define amdgpu_asic_get_pcie_usage(adev, cnt0, cnt1) ((adev)->asic_funcs->get_pcie_usage((adev), (cnt0), (cnt1)))
 #define amdgpu_asic_need_reset_on_init(adev) (adev)->asic_funcs->need_reset_on_init((adev))
 #define amdgpu_asic_get_pcie_replay_count(adev) ((adev)->asic_funcs->get_pcie_replay_count((adev)))
-#define amdgpu_asic_supports_baco(adev) (adev)->asic_funcs->supports_baco((adev))
+#define amdgpu_asic_supports_baco(adev) \
+    ((adev)->asic_funcs->supports_baco ? (adev)->asic_funcs->supports_baco((adev)) : 0)
 #define amdgpu_asic_pre_asic_init(adev) (adev)->asic_funcs->pre_asic_init((adev))
 #define amdgpu_asic_update_umd_stable_pstate(adev, enter) \
 	((adev)->asic_funcs->update_umd_stable_pstate ? (adev)->asic_funcs->update_umd_stable_pstate((adev), (enter)) : 0)
-- 
2.51.0

