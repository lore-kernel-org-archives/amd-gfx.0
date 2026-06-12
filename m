Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A356ACD8CA8
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 11:17:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA1C110E9DA;
	Fri, 12 Jun 2026 11:17:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zyUTGMZn";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013020.outbound.protection.outlook.com
 [40.93.196.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79B1D10E9DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 11:17:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plfDiqU2jvmbQCAZRhuI8Z0lC+UhNQYdSd5X/uKGB0OPJOjKuhhitU02Jj0dEA/VVvtVzhc+VL4+Cz4ovoU8Tf4zwQ4lSTcUpyAEw8sBzI+2USkd31mf3lKnWMlRCvVZ68tS5CxKgpIXjip2cOYz+A5CGxM2wK0zpWrT7lD3AjQ8qnw3cMTv3nnfWOijU+bfKIOck7+DGwvaVtdZRTeTaMIMm6RVxKVQqxQgmJ7s2WrFlNRqmlmT84+tyy2uTT4MhnV20mFFGTRtRk+4AHUsW/++HlLCf5bC5hj+3VfXcdeYnlGq92sdTbV0juAqYjNFIAkQBSt1zmRKk9AGd9xY7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HlV7clsavtkUG91LVjFLEbbazeEJNj/CIq4N7XdKHA=;
 b=qC+pyEi8hp2VKVe9uPZv2yeh9lQd1RUvoAGrCrxGkv9lIsjIKrxffiFxFWXGBSWVnRZxTcBG2AMOsJu81lXQfu5oLYc3Rc3sI2oGoq6ce1s/qGxkFjW4hUWP77jYP9RfB59MQIwX7BxSbiwwjB/c9BB80PTXM7SvqeQ60KNCXCIlMZEJojLiBzlQ3eZ4GsVQUhmoralPfm8EIGY0BiiQJojiwJ40dLfn02vZ1U12gHp8wlmZAhByWDDuRsMncMw+ECjfcmr57s8tXkUeuFX6YwV29r2VxQu1t9mHrWKYNkmGnSLFmZEsqJ9GjfIXWIDZnIHu2INrW8viPt3DsPB/wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HlV7clsavtkUG91LVjFLEbbazeEJNj/CIq4N7XdKHA=;
 b=zyUTGMZnbFnmtHTexPwu2vP7nD2lHMo02tAYZ3EYeUvLP8aKTOpGvG3KRoxMmOLWMNx0dG8YfNLPEHCTEQfiFSFm4MqYCYzR7LPg3JFE7V4Th/q/Kjn+Pqi3kIdlnc3iDP6JvwULCfLUAGjpEUEPCo8sWmOIMV7WHwOfiYyL0BU=
Received: from BY5PR04CA0024.namprd04.prod.outlook.com (2603:10b6:a03:1d0::34)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 11:17:17 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::4f) by BY5PR04CA0024.outlook.office365.com
 (2603:10b6:a03:1d0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 11:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 11:17:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 06:17:15 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 06:17:15 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 12 Jun 2026 06:17:12 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH v4 2/4] drm/amd/pm: add IP_VERSION(11, 5,
 1) to vclk/dclk DPM sysfs whitelists
Date: Fri, 12 Jun 2026 16:47:12 +0530
Message-ID: <20260612111712.11564-1-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612104408.9596-1-Priya.Hosur@amd.com>
References: <20260612104408.9596-1-Priya.Hosur@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: e2664308-8d4b-4713-532e-08dec8742935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: POQeyP+qqj3X1cSWErUxItRaDL2CHqIvAn8wxoh8MzFap5Oz9tfMtYkv2sYa90WRpbOuXwfiPUm1maYeZTjbcYYm/jLHNRJW7MRGEi0spNJ9E3tUOZ42UN8WbRjnYo+NsfJZtaVQ1vOYe7eIudDoFlW2zYiLPz0cqcqO/FgvhzULrkT/g+DzbhOdTQ/rzOuIvBjpi1CU8M1+AUeqDp7n+m0qdHwpkp/MXCdbn4Z22YDXEZijsC8jAY19VVniMTEayRp+KRSnibbm4dVjxj/n76+Ac36AnBGUiarz+W8evQzXxcNp8tWf3x6U+t3ysP8qXpRfD5GYfFwygTaQCh+cY8hp1zY6VVgn8VF3oyrKijplt0Uhol2HtczP8QUg2BhaFB49QYBRVPaSKBDZbxBpntjYtGmUsKJ2zNkZV3kBgE8mMt2aHJ05lX7f5H1YJgcjpGOJzpdtAbGrI/qqD+ayq97VSAqIt3UovbxVbmbkWdmfGeh4f3iulR15dEsmq7cGHW7olkV2NleL94ViTs6TX1ECxO0ab8jpqaPfsIcLqkLkPDJIh+wauDoX4ZshO0E9srpf5u8IWrs2qYa9bcKmalh+aIkawzRYiSopDkt0FIoCm5+KBSKp0CZVvwBGpoInlJmCmygM+EST1fHupFfinZAKb2KmD/wc/PXMuBQ/w4Q94c3iyhRZgSd+N0FAUt/IBE7XYjCaFma9XMI4+aCCIN7/qu2JaKaSy2jzAyJdv1I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OQf4WGqC76ScuoC82PreQYSA0Khk5UEBqR5biF1e79AUzRj4RPdpDDmIKRbRarRP6PVnMbYFoMNcJX3RV7wPA4Vh8GTxUeOzXE0201boprlBWNYIJuBsHC9Gi546kFKn6PNPJ9dOFQDWdADvPk4ZDL2VsHOU6MIQLH0eipJj4soHiFNZ40QBRl72ZIcqfnG1KTvzyrltzVKx2PmnF6HX4yLv3nwEP3C29TW4fYcoS+SkdEDA0rArUDfhwaffIVEX5/mluXfrXNwCKik0Vl+Rqm7VrGLCvFw2IIfqOg078uHRJvkZg2aJd3Dds7QaEBlR9H17MEVmEg6WW+slrUPF3DahtDz/r8WJvVZWT97QSgbOi/6Z9/W642tYFwZdTZJyajtMt47TJdybe4gOQ09nRhqAPUHCcTRCjEjnDsKNcpXsf5agxk+7bEwQsU3h74uf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:17:16.5049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2664308-8d4b-4713-532e-08dec8742935
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913
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

