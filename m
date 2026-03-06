Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BE0FCB619
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 15:40:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA2D10ED63;
	Fri,  6 Mar 2026 15:40:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vz2blZbj";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013014.outbound.protection.outlook.com
 [40.107.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4396A10ED62
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 15:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsIFk+AcE1jgg1VNIgm8aR0tscCe0XUasVhqLV3BOnFYFruhEaP/J5LyHqzeDUEnLkUOYreKx26mBWDAagasIrERqtXAzikiRletbqQONqsnjh+/+R+vNW4w021sT/X90FLMl6auv53xsX284xaooBzf30lIg5+mjh3epzcY30R1jWkBcVfXnE8/a1gxpceBSfTza3qQ8S95IxMv94HPjoYxUeoPJalm0bmSANXmh/KnQgQB/JMKD0nbA0pO650HL2zU+iVSVTW/MHA7XOxJBxgUKVgaiuGfee+E/OfholNBHHXx+JB6Z3YOsIxcS+lKJU+EjlT8rE5uj+VLru2AWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMqPIugCjPtDupCYKaWfTfOEsdI7q6BacZCqes3xnMI=;
 b=ZWOUPvqXaQBRK352n94PyosJ3phD7r5cLhdFH0NSfXrlaf+D2/4NFe6e4u/vDk5YMbex7VRloxc9f07acpZHNP9yT6wEBQyRvXFhLdFzzPu3PDzIBBFrYnqJncZ5WaR3WZK5X8im3RLBna769dBlqDMqnDkPdq7dLO2OyfwBKjUBupMtq6ryBnBjOt0GeGaRS+SXSRHJ6XkqiQRAvB7D6OPan8He+63B5xDdzV3SUIxYTBXMO97e4FABIAPdGo4NdbkoekOMOSQTwCNrGlgb5ze1CYkcnppC4n/rfxhOqJV4CcXMii+c2im425qImiGjlDpkoAYWumZsnfrY70pn9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMqPIugCjPtDupCYKaWfTfOEsdI7q6BacZCqes3xnMI=;
 b=Vz2blZbjpw5yczkCYA33hk0yVbzJwZyrvekHlLuCapXldDApJAGrJRbEkZJewSQJwfeERMpFAf90hGTMkTe0YzkL7O31VmGCa+Kcp9Cz9JRe7r5v8HtK4IiW9969hgUqiUuYQ16Due5quzrIGOZnrKgAKBgAtZGJ1HoKGpqc8tE=
Received: from CH3P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::6)
 by IA1PR12MB8191.namprd12.prod.outlook.com (2603:10b6:208:3f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 15:40:23 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::3f) by CH3P220CA0028.outlook.office365.com
 (2603:10b6:610:1e8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend
 Transport; Fri, 6 Mar 2026 15:40:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 15:40:22 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 09:40:21 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 07:40:20 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 09:40:20 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add default reset method for soc_v1_0
Date: Fri, 6 Mar 2026 10:40:03 -0500
Message-ID: <20260306154012.22525-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306154012.22525-1-alexander.deucher@amd.com>
References: <20260306154012.22525-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|IA1PR12MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 6499c1da-91c3-4598-d905-08de7b96ae06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: GbUYDJNmnSmWkPMls+E/ZCSVEJlDW09gDIeOKmeOFHEmVo5liqXefzAMAtSoulii1fN74zoBhGXzcHpgx1mtDcWF5Mx3wrfcRIH/DJkRUtPrCrJmRhbSUJQoKK88w92W6xT5l8RLydbHDnSLNrIhl/QIbQeO6SAejbeE3PrYdWtJ4hnk2q6sfIIRfwYSXQaVHGWG5dEnEc11YxQld6+FgQiWbHHB1Kvek0NwmKg7Vcenq9NwsZ+m/dcNJ0ioIg+RKI7m2Mv7Wmiv1s0iei3nf5+/gGSZ6qIYgauE0LZ+2U60y9E+AnH+Y+GqiJyNGqmdZv0XH4H5L8V6z9e7Ki58B279FYpHKtEZyCpDk2+Ilcleoh6vATy/gMS7X2pBF1D5OVeNUC8wYDTHxNMH6szJSHuvm5XKcVg0AMjIPO3skq+lwxv2q3TrNQ34BcCIYKpsqpdZl1fbJPB38M9dNScA3+4SI8Cq4DI7evbhPVsY7kMomvNlcNIYD+YWin30pOwCraZupROZMBiDEZOUnXJUyfOeumb2P65sw0hu7rct+rL3KvdykvMD8G7ooyjsl3SqmjS5BdcSiqU6DISwf/Ur626VOKPGrtGcCsb8ODvReA3QnPgizeWr4t0uZ3CQJGtC1pyMm7xonEGy0G04kFpVJCub8ve+FhHR6keL1/qj/yoM8AnuxeRIs8+jPFjWb8jImEZMSIHGA9v/9MXtlNldyow0/k5iQwnKKfMvU8uxFgH4M0om0yGLeBTQ5filpm1vxu/NIKnxPu4VoxZ5RTpxJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: k4NBdDKJwkgDUqQ283U9Hjijdbo1EfQlLrk4VpZnqBulDeQeJV83BRf8jsTftCjKjL8seghY9hLQNCjjW4+Fc1cCQBvDZQ57vkxnw82Jjf6aFROTLtkFsaMSndwoCD9U9YaUEcdz1RwjxvB6rI7l919F7xKE5lVKgi7+GuBckAwtf+BIKS/7zxa/OKmv6xGxRmU3ze5Qj27PE73EvjfV0mJL0vyGkxJQuaBPHnw9y7ZSGPbjlrXEXiYWp8MUMglbFkjGPJOoLlAbfO+/Z0gWXXjjsMLxSsdJ6Vz7oo4FIwgqeGtRe8+19CYk7qmq0KFqgQZ0AyaKfCwl7WRkVe7EAq6WlEQ9FBBMC6rn/96cgDUJEzYFj1H/FmQEvO4gmZPzNajDTFm+bWlSf+j3O/AWnW+ZD73/RJQCcKvh6MU9Hj7hOw+5x7HECgxwT7OW5+Jd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:40:22.7915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6499c1da-91c3-4598-d905-08de7b96ae06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8191
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

From: Asad Kamal <asad.kamal@amd.com>

Add mode2 as default reset method for soc_v1_0

v2: Remove unnecessary overrides while selecting reset method (Lijo)
v4: Add dev_warn_once (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 26e7566a5479c..bd7043729e6a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -229,8 +229,31 @@ static bool soc_v1_0_need_reset_on_init(struct amdgpu_device *adev)
 	return false;
 }
 
+static enum amd_reset_method
+soc_v1_0_asic_reset_method(struct amdgpu_device *adev)
+{
+	if ((adev->gmc.xgmi.supported && adev->gmc.xgmi.connected_to_cpu) ||
+	    (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(15, 0, 8))) {
+		if (amdgpu_reset_method != -1)
+			dev_warn_once(adev->dev, "Reset override isn't supported, using Mode2 instead.\n");
+
+		return AMD_RESET_METHOD_MODE2;
+	}
+
+	return amdgpu_reset_method;
+}
+
 static int soc_v1_0_asic_reset(struct amdgpu_device *adev)
 {
+	switch (soc_v1_0_asic_reset_method(adev)) {
+	case AMD_RESET_METHOD_MODE2:
+		dev_info(adev->dev, "MODE2 reset\n");
+		return amdgpu_dpm_mode2_reset(adev);
+	default:
+		dev_info(adev->dev, "Invalid reset method Not supported\n");
+		return -EOPNOTSUPP;
+	}
+
 	return 0;
 }
 
@@ -244,6 +267,7 @@ static const struct amdgpu_asic_funcs soc_v1_0_asic_funcs = {
 	.need_reset_on_init = &soc_v1_0_need_reset_on_init,
 	.encode_ext_smn_addressing = &soc_v1_0_encode_ext_smn_addressing,
 	.reset = soc_v1_0_asic_reset,
+	.reset_method = &soc_v1_0_asic_reset_method,
 };
 
 static int soc_v1_0_common_early_init(struct amdgpu_ip_block *ip_block)
-- 
2.53.0

