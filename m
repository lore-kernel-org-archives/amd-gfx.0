Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325E5CD98D2
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 11:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81C5810EEA1;
	Thu, 11 Jun 2026 11:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E7RMUpLm";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010068.outbound.protection.outlook.com [52.101.201.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C018210EE9F
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 11:41:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNlTYumYKFEaU4q4rjLPWo8fz52+zgj0d5XVShzb1lBOuCmUt58ZgEfEdYD4NoyGE4878lmQG7SkOiDwFoToe13hcLOz4p3SW+jtx9ylfz32yAk1U98dD19lDgwrPmWgxDcnNcTFPrYEx7KjL3B0zGo7yg+nQV4hNIroFw4fi7287f1yY+xKpU7Cr63sZUJB+xes3Dl/Ld5d7Yr5VOlkWiVZ/3NN1UCnzhu0w6wZZkDy8rLI/Ca/J9L7GYa5nkh3GqPBbq9i65bRaksbX92SidAwS+WmEu/mFKR+PptCUgrXhrR4bI+HfKu74UnDNsLd3h52WH4pUw5JUP3vSuL0VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HlV7clsavtkUG91LVjFLEbbazeEJNj/CIq4N7XdKHA=;
 b=S2HlThDRHyGaJ915ZNYHkZQD1LV+uvPYZaYfB5cOYmGDJeGEkyI1hoAsvYE/n3ClYzcyssZcQ8BXFaGUR/SYaSJqTo9QTJ2uPGwENjxDP1Ubr9KN4I1f5SVOUFL2NLXAW2C6MwmvZcX6VJYSbeZc6IcKbfW/ysJzq7EiLZ4jDlTG7107cKbpmREu43yDZXRTi1VFfLIidhB8Fdlw+FJooTsmDQXMA1tddO0uZWyoRSSlM3E1dBJD+B6lkLrQ08qWWeAO2Z1iOaHoRR1B0qNnaP/frVs7nwxbagPTVbm7Y1yfRkgsCH9BrQsmckG8plwiA/pm5wNug2c3dmhbopHAvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HlV7clsavtkUG91LVjFLEbbazeEJNj/CIq4N7XdKHA=;
 b=E7RMUpLm4gh+ZBqpiwWENzrtHQFb9ozf2+pW3dqbIna9v7JszItZ9zEwKSaP+4JaYwDUsx8RvTKr3JmDAV33ZiKO+HpVS8ge85agvTIcFDdutNDubp3KjTK6kYEK2GLBoaTTVlbG5xvMMADgGYf0xtsx6wGAyG6X+jKyFf+ZT1I=
Received: from PH0PR07CA0099.namprd07.prod.outlook.com (2603:10b6:510:4::14)
 by DS5PPFBB8C78349.namprd12.prod.outlook.com (2603:10b6:f:fc00::660) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Thu, 11 Jun
 2026 11:41:27 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:510:4:cafe::2a) by PH0PR07CA0099.outlook.office365.com
 (2603:10b6:510:4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Thu,
 11 Jun 2026 11:41:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 11:41:26 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 06:41:16 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 04:36:43 -0700
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 11 Jun 2026 06:36:41 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH v3 2/4] drm/amd/pm: add IP_VERSION(11, 5,
 1) to vclk/dclk DPM sysfs whitelists
Date: Thu, 11 Jun 2026 17:06:13 +0530
Message-ID: <20260611113628.3217-3-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611113628.3217-1-Priya.Hosur@amd.com>
References: <20260611113628.3217-1-Priya.Hosur@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|DS5PPFBB8C78349:EE_
X-MS-Office365-Filtering-Correlation-Id: a156186a-f94a-4a05-e5a8-08dec7ae5eda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|56012099006|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dfz7jxIVOzFdzTmaZhEDtddWf5o+Qdqew9OsCIRR5Rvy5UyjTIj8etvaqxmABS4cPql8MHw9eS0bV83akxzRUnMOUOf4vOhibPJPtBR+oahC366gMX6L9LIqnCQHxP4CoRuyy7X68F7NblSb9TIcd+JEi6NCM0kvMCpXLMmLm+hlTMCYDHt/FsULgkVhIHKglN1iCt9cddVES8BnetN5ZnozEJDKrgFI1p5Mi+sWaCBpNIeghQ48WNVRZ+iJK/uw7DmYz/mcd1JOw4YXTd+Oqdg+oMJAqPN/OS20n5xdbbE1aQwJ5Suu4rTFFMzwotvCkUchPNNIiCsdiY9hqwACLSNP+aSY2GBvrMaQ4Dxtb6zlCi3QzK+rjAtWrEN79coC2SRlmoh1ZcAb20AkeNnu1Z5shwZOG+t2WS/d4UDUChu1rxLj9yXbdryYR1Q1wkkLU6nh11AfEt4uyTFprZwDPASSmeYcq4E2x80SbY1UVoodzo/jQLhWlPmokkg8cUjJtgLEGcFQnLuUzAVhkWMMj3kTiug68W8N9QWV72vc/ZDBmRtRAkUxiR+Mtch9Vr0/eSX3UMGPVDy7qmEp41f3+TaQZpb5OYl7Y+18uoFF0C1hXOu6DkS5jlzbbdBvdv9zGZb6jApJRVZJfQjQVym25eGyPK001ohE1nGAcYsttvSF/QayCzFf+0US9gIBeg1Xo667Xm8c/0mOIJfU9Cus/IUbb0n6Zs60nf3/xZ+WALQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /M/gcurut/hDWHDISWq2fMvQMPamQJXymxkWHB0PYY4UCjNAPy7pDfltQQFphfSfSJHfXcIWMUWHMfFLwZRWeWBRxnEigSvl0N/EiOkARJS5ondmO8laLLANUgEZnybdAohGxTscg3GWBTkzHG3uD4D6WbGnQLPP2A+Wjx928QVeH7xtvI0UWR98og2/QTJVgn0RTaLgrBt8O2BXGrAXEIuYioqv9+6TCkjQCpYJ0qdHRKZj1y9gs2l+jEJ243Mlhi77W9WK3HUX+vsdHw9zu4DswVgx9vVl6UTgu26wUY/Wv72Sze0QFrjWjiMdx6PQmgeJJp/05ypk4iHR2dP0uygu3Y7wk6Cmz6e+PAQ9VoY9oGcTc2XuS47GvW1YUXB8XPLjnWyTvk0SccO2/hiF5eOXAQpwPzqxyIrqLAe0mYt/XmJJxOW5QXDtWhipDWas
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 11:41:26.2443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a156186a-f94a-4a05-e5a8-08dec7ae5eda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFBB8C78349
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

