Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEDACD8CB9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 12:11:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9D0310E90C;
	Wed, 10 Jun 2026 12:11:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JVHpfSXC";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012034.outbound.protection.outlook.com
 [40.93.195.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F5F610E55D
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 12:11:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6ZomjR9pxha01fhnMxLXEXAJd10coEwm+sL13ONo45y/IkUMXLnfUJZBJxtgL7GDDCaZhoOAVMuOm2mEC8ozNzm4UYGlD5oKxJFqZtt0lJm7MiNuwRjCFEWqUc4bJC2Is03ssw9jei0FG6oIWyDI5KLNOBmi3RGLN8D/nyTNERNphnonWI6wVMWB7AqL4ZYR41bQ3nKz+jx6lztbmrADwGPaIqGo0txCswVyyQXFipfTCPuRKilx7MtCQPSDPyMpwZHFyXO4KNQ7eAm04UKf8WIZ/u1iJDbP1/HSf6EdNkueBqemcyrYaCu7n3mp5Y7pWvO3Aw8iBcIhXETQJtoSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HlV7clsavtkUG91LVjFLEbbazeEJNj/CIq4N7XdKHA=;
 b=OBQwfJPGEf4iKLGGmz9wgf0m2xCzmMgZUYphMoFAs7F8mXK7MyW3fBanWlnHQsm2gGvJ+TFfDaKHiQgn8z8IL5ZhF6EZj8UQBNnA177QG9EL4MdUCuaz8eys33vhKBE2A/Gscq22OujfGQJqfaP9QyPmnRu1FaIEXJsYnDUZtWOKyKhrynMxDmRjIiHlQLd8RAcesruAj7dudX7G0uujlElnWZyq2RsCyMIm017su0gZfhwjT+Dk+k2SjuJsh1yTngpYMiBtUiTbLXtCD9BRKmwBppgRSbZheYDiE+ScPjWIHhSVqJto+K49Rg/FBfKexbepMUQZsDMvMteVfACvbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HlV7clsavtkUG91LVjFLEbbazeEJNj/CIq4N7XdKHA=;
 b=JVHpfSXCmLdKrN8ambrkcmeImnBrSo8Oziom+nz4YTOOP+KKGk+zD+4/nbCxGp3W3IXhFCKGkeOSdJB1voMx5eK5n8vDCOI8XgkiNbC1POA4gOaEte77bp1TKzJljP9nnp1LuxQkNPMvL93owRc1MpTGNhKHjf9ovz8/CgAarEM=
Received: from CH0PR07CA0024.namprd07.prod.outlook.com (2603:10b6:610:32::29)
 by SA1PR12MB9245.namprd12.prod.outlook.com (2603:10b6:806:3a7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 12:11:46 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::80) by CH0PR07CA0024.outlook.office365.com
 (2603:10b6:610:32::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 12:11:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 12:11:45 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 07:11:43 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 07:09:52 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 07:09:50 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH 2/4] drm/amd/pm: add IP_VERSION(11, 5,
 1) to vclk/dclk DPM sysfs whitelists
Date: Wed, 10 Jun 2026 17:39:42 +0530
Message-ID: <20260610120944.124040-3-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610120944.124040-1-Priya.Hosur@amd.com>
References: <20260610120944.124040-1-Priya.Hosur@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|SA1PR12MB9245:EE_
X-MS-Office365-Filtering-Correlation-Id: b4aef971-0246-47c8-37d0-08dec6e97118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|6133799003|56012099006|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: ucuquWF3P0JeQyjv42FOMfjs+I5T1PUGqI7kHrLMvJGvOgoW2/jbzG9f3SEQxPo+fAXqtTNqGSG15uloxyYK3hKZViQ+mdUthN5lE76m2qt0gsLKKclFxgTw84g/mpGjRhcPOc8E67WASGABNTMMkidumXAaiS6y5/SZBtk4o8SlsNGzvfz+PTQ0UPfNXJuHzY4r6chyaxFv2er9hZ7XoVdAQyOLMA1tHUuMIVGQTWsd5UVMq6GG2rfcQqpOA+8AWjato5STz5EN/55k7E9nuShFaLSnVmx3Cg+Osn62VaVUS1RYKSxwECOh/AZjqxPS9qulYvZGoF/+1vuT54LfM/ebUKBU3s90YBMnEZ74TCP3FovYq3TTybyh9eAlxg+NSwd62kuwUdr9MJjWrRyBPKpPk3roxJrt0JbOgQRVg5kmLWKqp6pZx368dxROeRFVpf25yFLWz0YQA7R/incOiXLxfsON6GVHanXfIkYIWjtoxx7lB+7zrHjR5K8f2xzFoCN2HXsXyqIMnnZ4t1RhMg8h2WN0irIbv11pvpuUB0KutGyRisiTQueQEOfL3lxSmT91/BD3pJin0QV8MBzih1u2y5cgkPJvXyopeLp/Vzks2oQZFfAg8YgDuNHOaP+29CRmvpdvYzPaJfyPW9rsYDeOXbCJd9DC1CyILkGHqrA+lM6D5RyPIiEDfh950EGrXthUZF6UXuSqRMSunX4OqTjIKXuZPfVKpT9WO+zHnno=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(6133799003)(56012099006)(18002099003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c9VaTtaz9tURFkmSRJgHvgmgyAxYLzuZ76zc8QcYK0FAP8yBBcUMO/LRA72PETIDwzOedjP4j71kMUql7iJbmdRcH4v/IK993lh9HYcrbSD/+lRlDUa7+koN3w7nIL1nztOVMklCS1vK9MEIVVVFnlpaDMFL4p+lFWgnX9w7JT1BKctW4R5KWfAudZxRT4geLSHRHR5Qb/HzwEkVXOpWBIdoCOxjH/c84J9vRiOqvDme/kADhtK2ncOCG4hhBoOG2IOqUw1ZDEjFQlYKVhWSPGZNvu9+zQ/pfJ9c1uCUUQp3aPCrKDKcPobFDMw82R5pauAJ6HyBV2zLzvyVKejrM8JDYQpa0XFC76IzQpiPa5nyFi2evGklEyMyyvA1NMEr1hrgv9F75l9yVKSARwvJmvaoEGi1JtNXIa8TlhL3KfodCVLZkT4vIwWeoyR/3LH+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 12:11:45.9736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4aef971-0246-47c8-37d0-08dec6e97118
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9245
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

