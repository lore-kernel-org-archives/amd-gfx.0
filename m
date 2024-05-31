Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133C4C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 06:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3402711268E;
	Fri, 31 May 2024 06:53:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oWN20bnH";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46B4410E7CC
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 06:53:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9jBPc6ijd89j6dYfEbMH42rwEznRx6/HQPYgIAAKp+NhTJcPOmvHVTluLm3rkNfiqdvN/eMHAWUyVRnlwQpQLJmI2XEu066rxrcVkFlu7wdkzkr0PXAv0UAwoxRIsech6mkSfUyJ+53FDe1M1uKG/WnWrNx0wWNmGcXm8wfXVIMVMIvRjnFSvTw7ONZKLFbBUqcUeTJUkx27OqNl5nRObY7lO4qjp/KsoDJOEF/ioQ78MeORXByAo1rs9dcBX7Lc9HA2MMJ+2RUsHgfpSddmUR/3nz4GrwO+PbFXQrWlXkL1XShDNHfhdGvMsb8SRQyaM34DNYG+22vm6W15LuH/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUcshEzg4T9B2uMR8I3IF9PyC6+rqBGj77H1hXAB4kY=;
 b=nMa9bqLWrgzm7DHk+OMhPyjTrvCh1VoBVHinqklDvBb5f3eaSwu2wzAicD7VmK5MYE6kko5zUH8ms2nk7v/gy9tLK51N3KjxDgS8Q7rx+Qg+8YzCQWb3t2jjzomVivN8Mt/ihgDj6spXPFNk/q+cA1k4TfssseGyG/E1F+Qs3IDDkD/ON+hVtMdpDOsEXFHmugwm8CEUARX0tOp16tFwcozf/JFk3OJDLRE61+BfCn4X7nNOJzWW3R20NA1s4oXjamG2hwl37/pPgNEf/LB0uE3m4ZG0SncSCobIUiWB0+Fhy5mL8N+KvYoyCXzjTJ4BkwGvYArameYiHWQO/XSRBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUcshEzg4T9B2uMR8I3IF9PyC6+rqBGj77H1hXAB4kY=;
 b=oWN20bnHWjv8W86+Y4mgLJOT5xCWSY3ZrKcGPu1Uty5Wb5j/+QwTE3AC7f5ySG6IMCetJnHCigQprYzTjJWsh8Gl3ZBDQOH4PrMNelj/wJ/tvtj7qaNcSfkV7c1c6z6/fFk9UJIJ2CpSc48nDA9T37CJ1ZMTSamSn36I+jbxbm8=
Received: from SJ0PR03CA0092.namprd03.prod.outlook.com (2603:10b6:a03:333::7)
 by PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 06:53:13 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::ef) by SJ0PR03CA0092.outlook.office365.com
 (2603:10b6:a03:333::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Fri, 31 May 2024 06:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 06:53:13 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 01:53:11 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 09/18] drm/amdgpu: refine gmc firmware loading
Date: Fri, 31 May 2024 14:52:40 +0800
Message-ID: <20240531065249.1746350-9-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531065249.1746350-1-kevinyang.wang@amd.com>
References: <20240531065249.1746350-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|PH7PR12MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b95cbb-89b2-474b-4e72-08dc813e576d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ojq94v4jHcd9mbxAI9H5xrjKp9i252ryQuf/jTAsT+GiiAbyMFOp96XajzuQ?=
 =?us-ascii?Q?uySbZv057GUQmsGV8BJx/9uCzQxnahctP6oHTFma8IPIc+M0+af2aehbVu95?=
 =?us-ascii?Q?fbG6dFM0xaUmQ5nah494vfEHN+SGmT+o245mjftMV/LGZfHLRrD2lOc6wzth?=
 =?us-ascii?Q?9GiNCju+F0CO08ILdsLDX19PIAls2i9Ztll5/Yw68ojmqhAVlO9zU6MyHA/I?=
 =?us-ascii?Q?alLpMqu9e/rrHRMiXA5DjZaBMzIcec7HS7HWWpWnPMDGexBmQPMzZMPfJAAS?=
 =?us-ascii?Q?wJJDpE3c2MYMRAe1zVbNT5Sb1E4xYvy3YyCm+Df9kG4DIVneDNEbWiZBGZiS?=
 =?us-ascii?Q?r1acpnqAiMDZUzixecP0GQGZudUsdK00wlMEgFxJ4NvAxuM88CaAh+7A0XaS?=
 =?us-ascii?Q?eR7UM1pZdHivZVFn4CuFDGB5xARC+w2gugy1z772iyyExRgdSq2B2vcHOyUB?=
 =?us-ascii?Q?oSvqhEH4BC0vp+Du3iZgh4FCmMO+m4zmu+vG6xcfwuBY4D9wwZCPtk5QFkRC?=
 =?us-ascii?Q?3gB4E0+U2k3Omfe4z2b5IYkrnEPtCChQ+5gDDcfYlSrJNjVtuJME6UWQbOij?=
 =?us-ascii?Q?5WolWIxknwl2G1tx7M6ozh3q+iru5mp78HdLphcs618WQFd4CHJ3A0ua0/59?=
 =?us-ascii?Q?GUR311qhPHJ2q/nO91Nx2xqM0JpnqJVqG6Qeo4F7OuYWM4kVzkN7WP3CylfI?=
 =?us-ascii?Q?1ShcE4OLCcwl5wbFARj3TZWvQLV9X1seh6Z/9OW6ZlG5dykH0NWSvQ4PjHW/?=
 =?us-ascii?Q?KnAKBk1H8aepHpsyG6Oj99Qki6wEyd3ZYSogCpcPanHJu8gNgPGIppqMXeNP?=
 =?us-ascii?Q?Tf/cakOTOAfqAMqDagYupdj1I84Ql55v1KkpMl5PdSpNlsA7lS+KH2q6h+j9?=
 =?us-ascii?Q?T8JI85ylOXw+FEIHHNWDURUPZNpXuxFkxmCQR8bKzrwsLO77JcLndgUOvXsN?=
 =?us-ascii?Q?hDhrT/VNSy/F52l6Tf510svxfTFfQT5pwYiBkFpVLsbx5RRkqKel6qGH1de1?=
 =?us-ascii?Q?hKY9AqHwAvHwwJKWOC6uXNoPUB/pvd8zlIWH+kuL/n7WedBtH4rOIYKivvuS?=
 =?us-ascii?Q?U50cYnoMydXi1AKqvNiMB17mmvLLMzU5XnqFAUQyXgSP32UZH5JDKMPvQc2T?=
 =?us-ascii?Q?fhdYA/bOpP9KIbX1LsGdHuDUnETnpYT6Z/pwUM9KSaROdAs6aiG9YrQA4lAU?=
 =?us-ascii?Q?eVpPEIST6tjcgbIxU5bplmMVoKLJgeXZQSvnvSBZOpecYXiiahlVrt25DzzG?=
 =?us-ascii?Q?x4isSu3EPLROn13Hd133oZrJzfKvRi6yK+vFisqCSrQBt93apQfPV+H7RjeM?=
 =?us-ascii?Q?gZM3X1Q5rlOXHh/7ARmpYr6dFK6K1DVouOoA7IMt3eJT9RXBhAPlTFKx29HT?=
 =?us-ascii?Q?7mKEf0+6+wUmPlIy5c83esjw2aP9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:53:13.3098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b95cbb-89b2-474b-4e72-08dc813e576d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951
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

refine gmc firmware loading

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 14 ++++----------
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c |  7 ++-----
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c |  6 ++----
 3 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 3e38d8bfcb69..d36725666b54 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -98,9 +98,7 @@ static void gmc_v6_0_mc_resume(struct amdgpu_device *adev)
 static int gmc_v6_0_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err;
-	bool is_58_fw = false;
 
 	DRM_DEBUG("\n");
 
@@ -126,17 +124,13 @@ static int gmc_v6_0_init_microcode(struct amdgpu_device *adev)
 
 	/* this memory configuration requires special firmware */
 	if (((RREG32(mmMC_SEQ_MISC0) & 0xff000000) >> 24) == 0x58)
-		is_58_fw = true;
+		chip_name = "si58";
 
-	if (is_58_fw)
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/si58_mc.bin");
-	else
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mc.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gmc.fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gmc.fw, "amdgpu/%s_mc.bin", chip_name);
 	if (err) {
 		dev_err(adev->dev,
-		       "si_mc: Failed to load firmware \"%s\"\n",
-		       fw_name);
+		       "si_mc: Failed to load firmware \"%s_mc.bin\"\n",
+		       chip_name);
 		amdgpu_ucode_release(&adev->gmc.fw);
 	}
 	return err;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 85df8fc81065..994432fb57ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -130,7 +130,6 @@ static void gmc_v7_0_mc_resume(struct amdgpu_device *adev)
 static int gmc_v7_0_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err;
 
 	DRM_DEBUG("\n");
@@ -153,11 +152,9 @@ static int gmc_v7_0_init_microcode(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mc.bin", chip_name);
-
-	err = amdgpu_ucode_request(adev, &adev->gmc.fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gmc.fw, "amdgpu/%s_mc.bin", chip_name);
 	if (err) {
-		pr_err("cik_mc: Failed to load firmware \"%s\"\n", fw_name);
+		pr_err("cik_mc: Failed to load firmware \"%s_mc.bin\"\n", chip_name);
 		amdgpu_ucode_release(&adev->gmc.fw);
 	}
 	return err;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index fc97757e33d9..86488c052f82 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -212,7 +212,6 @@ static void gmc_v8_0_mc_resume(struct amdgpu_device *adev)
 static int gmc_v8_0_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err;
 
 	DRM_DEBUG("\n");
@@ -255,10 +254,9 @@ static int gmc_v8_0_init_microcode(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mc.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gmc.fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gmc.fw, "amdgpu/%s_mc.bin", chip_name);
 	if (err) {
-		pr_err("mc: Failed to load firmware \"%s\"\n", fw_name);
+		pr_err("mc: Failed to load firmware \"%s_mc.bin\"\n", chip_name);
 		amdgpu_ucode_release(&adev->gmc.fw);
 	}
 	return err;
-- 
2.34.1

