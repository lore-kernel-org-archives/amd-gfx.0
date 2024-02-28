Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480B5C47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 07:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9112D10E5FA;
	Wed, 28 Feb 2024 07:00:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1h5Qap8E";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83ED510E5FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 07:00:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQktOnA6upeE/KL5N6bXlFpX7HkjuMXkbeMm3rrAxX+jjwSMXTojnA+ZHSPk/HsnrfOn9pC9n5+9/RXf5ZKhRJ2Q2xLtd5vPmWnnFKzHjrOQdv6RXK5FPf2SvYjBy8gllbAqOMTKUFD6Dgt+uDUwK9SD1zfAngiCJvQtupsr/JbgZ4kIdijZEXunIGlpQxSK/AgWn1+BOFsDANA22i2BBsB0iqbsmMcT8hdxGDbxV4r1JaZ64pBnEhYhehVUui1+xCGVWlP8OM8ByoJ0rRNvPwGsOICAXI3RdCKdEOsp8RQSTm4nSgJV3hdZC+241WYc9Qgb2QInCDoVmuGphmehjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUHAMKwKGZMonMSY70VlBK24NO2tmVNJfOhYv9iodwc=;
 b=fmdZFBs42xwVMSgFAN/HM8SyQiV73/FDjhncxGXs8HI2rktYMWKb+5N7qH8SrKll3CTBli8Jb3LUnonY81ySVb5MpR/QwzgSP9/BMmFf3X6bB/8BGirbjPyC7mk9cyLh/3Q2ObspV3SsIRq8tgXa349HFvwHhhtmiGxFKNZZXVq/oIpnf7gciMRY9niwFhu+hDxxJ6dkrT1fc6EeiLbAgbhLS/GbH7D/qnLe0oVBLzWVhC+kS0DY8xjhxVJ9ZVdeqn5isNsgDDeojxSOqgd2mtUqPwmErCPzXaV6ytVOCivX2gO+tH4UYNAKF4Ia8bxnJHyilrLv+KavcUWZCIfaag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUHAMKwKGZMonMSY70VlBK24NO2tmVNJfOhYv9iodwc=;
 b=1h5Qap8EvFsmNmVa8Y0fB/M8F5OkvuRIAKQgG8zsjDfCFdTsSAS9i0BRFtO9M49R/OF94mKX5+qjKt4JUC6Z61TogbUmT/8K1/bO6eEO2YELWGuozk2k8/gN9C6QZPgeBARf+IgOmmmpQknK7jaE8xxSfnRL6671m2985ktLeTk=
Received: from MN2PR16CA0036.namprd16.prod.outlook.com (2603:10b6:208:134::49)
 by CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 07:00:52 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:134:cafe::89) by MN2PR16CA0036.outlook.office365.com
 (2603:10b6:208:134::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Wed, 28 Feb 2024 07:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 07:00:52 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 01:00:50 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.zhang@amd.com>, <Lijo.Lazar@amd.com>, <Davis.Ming@amd.com>,
 <vignesh.chander@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Subject: [PATCH v3] drm/amdgpu: enable pp_od_clk_voltage for gfx 9.4.3 SRIOV
Date: Wed, 28 Feb 2024 15:00:36 +0800
Message-ID: <20240228070036.4143328-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|CH3PR12MB8935:EE_
X-MS-Office365-Filtering-Correlation-Id: cf3c1548-13b3-4c1b-6f70-08dc382b0072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ogd+2NOhWpY8rHpmVVvVIIl1stTuQXI1D2HfzUOM5P8XBLmJGeIN4pK8Fny2nCPeNvNL69rWiEJ+IcHYIH7kyahD1eW32yFRy60k3OJs+egC48SeGlFGsHC7/BdBf5A93oQCOIDvJI04WynfVwdxNSzZy+HQHx6Os8aXG8ziUkgCKUid69drHK76srmPkcEORs6J8F6d+55VafD7vrtklg/WHbXh4nALU6EpfcBWOGvPDzDaaEPJVy+8qysgWgnJlCLSazwEwEDRgvNdsGsE4lLd1LQkIk0huPN4ERRUcqfwh/tIcZXruSr5siczby3Mo+CmAlFAHZO+e7BxSUeDQ4bN1QHJkJaOy2ndSAI7KQWNUiqJqxJOkUp8X4n1MBf6a8hNFkqktUwdxgmii3ebf8a6WQBGzEHqsheGnzyoyVMjwUAoHvZVs6fpY9crdGCXxro6SasbYpJpolngcZT5k/HTGChQVtTzMM89uX9GRd0xfRnNEvjezbhFI2lzVepNlcOGh7t9wFp2rKUWATBYGexT1iS3IZVWBBoFAYVKZHHMM5dkAl9txTR9zh4/MF4HRrFH4vmFik1EdmjTI9mtNZ2EHr3g8N+DnMlpA3fQLsY19lWK3XyU/rfBSPTy4H7jq+QYUN+Xkipzv8vsLmj6uD3Hddz/0ZWqGiz+gdQOXkTOSYESfwL+ASBMVcrd7UdaE4BbVjEH+g8tzK1QcgRqIzNnQvXiN8eEEQwdb6o1HrpNUTOHkgIU3LakXiO1PVCm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 07:00:52.1547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3c1548-13b3-4c1b-6f70-08dc382b0072
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935
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

v1:
enabel pp_od_clk_voltage node for gfx 9.4.3 SRIOV and BM.

v2:
add onevf check for gfx 9.4.3

v3:
refine code check order to make function clearly.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 32 +++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 087d57850304..ad4e260c8052 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2034,6 +2034,31 @@ static int ss_bias_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 	return 0;
 }
 
+static int pp_od_clk_voltage_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
+					 uint32_t mask, enum amdgpu_device_attr_states *states)
+{
+	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
+
+	*states = ATTR_STATE_SUPPORTED;
+
+	if (!amdgpu_dpm_is_overdrive_supported(adev)) {
+		*states = ATTR_STATE_UNSUPPORTED;
+		return 0;
+	}
+
+	/* Enable pp_od_clk_voltage node for gc 9.4.3 SRIOV/BM support */
+	if (gc_ver == IP_VERSION(9, 4, 3)) {
+		if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+			*states = ATTR_STATE_UNSUPPORTED;
+		return 0;
+	}
+
+	if (!(attr->flags & mask))
+		*states = ATTR_STATE_UNSUPPORTED;
+
+	return 0;
+}
+
 /* Following items will be read out to indicate current plpd policy:
  *  - -1: none
  *  - 0: disallow
@@ -2118,7 +2143,8 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RW(pp_sclk_od,				ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(pp_mclk_od,				ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(pp_power_profile_mode,			ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_od_clk_voltage,			ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RW(pp_od_clk_voltage,			ATTR_FLAG_BASIC,
+			      .attr_update = pp_od_clk_voltage_attr_update),
 	AMDGPU_DEVICE_ATTR_RO(gpu_busy_percent,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(mem_busy_percent,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(pcie_bw,					ATTR_FLAG_BASIC),
@@ -2163,10 +2189,6 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 	} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
 		if (mp1_ver < IP_VERSION(10, 0, 0))
 			*states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
-		*states = ATTR_STATE_UNSUPPORTED;
-		if (amdgpu_dpm_is_overdrive_supported(adev))
-			*states = ATTR_STATE_SUPPORTED;
 	} else if (DEVICE_ATTR_IS(mem_busy_percent)) {
 		if ((adev->flags & AMD_IS_APU &&
 		     gc_ver != IP_VERSION(9, 4, 3)) ||
-- 
2.34.1

