Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3FACD8CA8
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 10:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A37E10F431;
	Fri, 12 Jun 2026 10:44:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yVeFT7FD";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3514F10F430
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 10:44:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qV3dmjasUSdxlHxWurpRFkjEnQof28lTMlJdM3UQqMkaqiCnuvq+E5FsBzOFSD2R1H36o75/3CVFcCnTdzi28hmyO9tx4Sote4roDbvZMOQaJozwGA2ters6Zv8dzJLiuDbx5qMg/2rAjhKTsZ6p/kXQSLjC7tBcWbVGY5+V3DtEgGiIFU7MUuohkvl7plQ2mW5hkMjzWnyGL7rg2IQAdNihJ7w3TvJkdIGFHiG5fu11dHJ2XWUDeQUnIz/GGMzjumFWlQ9G/p23dZUBzA/yuLXvSuoVRllX39dyyvg9cQIPb47f5zKqqhlt+PJ9Klz+vzP648ggvVhbfIl/1rQpDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HlV7clsavtkUG91LVjFLEbbazeEJNj/CIq4N7XdKHA=;
 b=guVKbkVJxrOdDrVNeDo4DPexjuI3wAhgc+C9BSpvnre0k1+8tbb3dCkrW0P2prRtJA3esPmqYhi4GX884ctaKJMow6nPIihIvnH2XKGzLCYEmeeT4gm/AB0LV3VRZafgwq/dhxXH+3zdKIc84G2nBbx+h1UBNOSwt3MvsOZgwYrTI/2YMynKs6lq4WmuOC5kR4ImhQQUgLng0AxLrhydf3EyX1XWKKYzBcifPRIFM3zhViwkWSvQ72c8tliW6I68s863sIH8Gp/S8BiKEx4Z7sc/QLxoi6gztcX/XnmHDYOgdHE6rE0VI41Nq+d8lq3AgCURLvN0wHwcdU+qMh9UoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HlV7clsavtkUG91LVjFLEbbazeEJNj/CIq4N7XdKHA=;
 b=yVeFT7FD/9FblTQkw6gfRVyj4YMjCBXNoBEAlGX0c1u1NyDkSLksaxiJ+qRsaqm1pbFAY4/iGS1qFfeB4AT7bIFkWvcrPcUqahjrbt13VmIPv9w355a657CqoiAMuGpGh8U4bVMEN/o5+CnVmwfuArvfosAH6KmgqzQbcNH8CDQ=
Received: from BN9PR03CA0430.namprd03.prod.outlook.com (2603:10b6:408:113::15)
 by CH3PR12MB7620.namprd12.prod.outlook.com (2603:10b6:610:150::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Fri, 12 Jun
 2026 10:44:23 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:113:cafe::36) by BN9PR03CA0430.outlook.office365.com
 (2603:10b6:408:113::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Fri,
 12 Jun 2026 10:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 10:44:23 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 05:44:22 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 05:44:22 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 12 Jun 2026 05:44:19 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH v4 2/4] drm/amd/pm: add IP_VERSION(11, 5,
 1) to vclk/dclk DPM sysfs whitelists
Date: Fri, 12 Jun 2026 16:14:06 +0530
Message-ID: <20260612104408.9596-3-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612104408.9596-1-Priya.Hosur@amd.com>
References: <20260612104408.9596-1-Priya.Hosur@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|CH3PR12MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: a74cefae-79d6-4f6d-baff-08dec86f90f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: RB051R2Ow5uPd+SPY1CJGuyJ27W4WZSlsPtYBEJFupdjZCgDC80FkFdVxjDlqOrJnxKugfiFDM+KXbDAGsNd+1r/HkDmsgc9MqN4T1qxZE25f24MkuXf/Vh7n/k9wLhrrGe47ZrJ+wBfATITIA9bjjmndqiRftrx/atdahnxfBaCyRNuhs2EQiV43vJBVlT3lPCwSyvhP3bssCw0EHeOB2Ycam2XMmKLp+72v8sN+ZsSzTMpRYhySQkuIBB6i6B4ojnHPfDjGLCDRvfLpO8bPrh9H60/1Ko0ng5D85Cl4mjmoVz8h8T7XDFcbN1KWyJ0z78ObxpNSSVEAVUFi+iI8rwfuLXDKVktvameE/tLvpFYOhaBLFh5772Ipv1cC568J7Pp01+zhtrWud/S0zW+S34Sj2sk92ZcAdd72z34HyCAOGJGmOQqoCLxUAS7uT5EU8kcBUu9HK+U8zaFrZvdsL1k89PtFFZP7MvxRLbqrhXE+s1II05rt97Mnvc1t3krN8xWJ45FJ/97vBrhyflD41IDCpJaZGkHOPRjLgO/UYDOag00jvxbOYvqjJG63nM/k975Jv/OR3sOIiycGGLWVkUhM4mamqZldSBomOahpm/6P/qBLAZvXaObazhZyVfUpRarmr6qb7CqKl17OkKLlwHKnpt+fgvnOkumOkmIDBTBQJU7t8aTCH2RRjJ+lusBzukcOmwW4ftF1Ks/61PurPC6roy1AXSbrFT8Hnb39i0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FB8iBsjgVcSBhIg9WfgHN5/yoiuSjoAOKcctoS+bMOX40QwRo5aORh2zHHk+kmKXYFo2ABiFmHz+5T0PZ16/WQuXOarnwSyXll9ykNthqrEjBsptmRCy1IYjRpO8uf+j2OzP2iE89XKSTjTsXX+x6y91kXsNysAntpkNTTZ+3VRz1nsn1xmdMdq2xaUFteQXIQtQiuTbsV2YuTQG1tB3OvTQQwN9GYXvv6VF66CeiKV9MbVb/rBQcTaW6Boy14Jfr1t2T7Ip/PLBPHPWOXoMDL/KMIwakt8tfZOCbwfYpoAlmD1mR7TXM9VR+iKyVUInII0NVwMa3oNGUWYCeFcFKqdwhNlbcRcLsgoW5iD08Pbx0N5hn+2KMtyG3wRCl3zLbZZX13cly6zUw3msF0AnlzfV5HpEZN84jXkHXznx4WRpn8qkvtdku7i0V1Oddr8Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 10:44:23.1987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a74cefae-79d6-4f6d-baff-08dec86f90f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7620
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

