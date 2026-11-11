Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B94606A333
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wZo75OFw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC06810ED76;
	Wed, 11 Nov 2026 15:16:30 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013010.outbound.protection.outlook.com
 [40.107.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A93F710F0B2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 15:16:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8JHFOcAwjuXSwGzxwFG6bmLb+GUPoBb2ew5ti4iw6TbK19XWaY23yo/qYx4Pvt22HO9ZZopzOv0ZeamRptTXN00CPn1ePSrTxsivN111nEhXXF9+OkrJ/89zZUEA6eLcEf9qModokrc/M5NAEdt802oUrjh31AY4Yyn8i0vWkhI8PC5Zj21TR4doBn7mA1RqcffG0CsuDxod3Sk50oGCL6DkGOENmH25p7bU82Ge8BQ1x2NuotpMZgDCGv2eS5YM/oD9ofYHToiEw+49S3n9L+m1Hd2R19IatNBCPNDKTWQalfNkbtgFkXLgFkmVVBsZhr21oWEErCI+9A+XF4uTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OU4lbZGPNCzVxtbBR9EeSemKZShAjHJ6KpduZ9bk7qM=;
 b=CkuFyZgGjYZuzfd4qF1GkYadpZySrpq3FPEU1FHSbC2txF3XYlWnC9bU1UbOk1qF5kbKH9zuIepuT1QAxNsCwmpVMXkMmMhK2dLcWrF8fDteR1QG1WqX9Cj7FsCd+aWFf1c85nlt+4qY9zZQgGnn59zXZEINQI7IYsr2pHkgBDoDDRPHc90jdIonKo2+wnlTCn0cT4A195nMKEnMS6CpnJg3/zaqktaIKRfmOV/UzNMetRnaSiP+1G2w7jwznbHZHZHH/tXPUqbsVTJ1WiJDtOl0L9zsfSC6skSGPqPEHYm58RBUKaeh/MhRZ4yrPvrAuCrMDntC6kQBJx5dK2/0GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OU4lbZGPNCzVxtbBR9EeSemKZShAjHJ6KpduZ9bk7qM=;
 b=wZo75OFw54jmve8uTQS+gsHsy+Lg9Or2InuaO/hzaRPLbiaAbf9VMHBAU5pQ/MW4fHb4sqRLjdWaKe95cB1LizdOERAOM47tQIhoPn2uCDTDqV7skGxw5zVXoMw4uFsI8cAtOEouDKcPLhgHTLrkZrbnVy2Mksr/foRjRORGNuc=
Received: from PH8PR02CA0020.namprd02.prod.outlook.com (2603:10b6:510:2d0::9)
 by DSSPR12MB999211.namprd12.prod.outlook.com (2603:10b6:8:375::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 15:16:19 +0000
Received: from BY1PEPF00026967.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::89) by PH8PR02CA0020.outlook.office365.com
 (2603:10b6:510:2d0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 15:16:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF00026967.mail.protection.outlook.com (10.167.244.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 15:16:19 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 09:16:04 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 11 Nov 2026 09:16:03 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <tzimmermann@suse.de>,
 <timur.kristof@gmail.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7/7] drm/amdgpu: warn when driver is built without SI/DCE
 display support
Date: Wed, 11 Nov 2026 10:15:45 -0500
Message-ID: <20261111151546.3105062-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111151546.3105062-1-alexander.deucher@amd.com>
References: <20261111151546.3105062-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026967:EE_|DSSPR12MB999211:EE_
X-MS-Office365-Filtering-Correlation-Id: 09edb724-e5e3-4d92-e2dc-08df4006bd10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|56012099006|22082099003|18002099003|11063799006|10067099003|261009223027099003|261026140227099003|261021121427099003|261022105027099003|261102123227099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: xqXJEAvRjK28MbjjdBAKK8XyscKuDsTHV9BMPOUAb6MUOrwbPgErJ0U5iBqsmp/pTXeRbl90IOnl8pCSK2ohZkRXbSulKRARimrkEGr4fugh0uI1Zre+mwYkd+00DJVJOc3coMT4rUERLoJ/1rZi4dnUwaOsB5KOgfqIrn16rAytPKg2b9jGklrEsMi+4msKJks1rPzlVoqHohym/SWwlaOU0Gs4FQu6to1/JMVFNIexIeXo/2oA9dEe88BfnqSJJaXs83FfTW6Ty1YC5vJk4xfyovAcn4kP0nCNttgnxSUH8VJmfN48pB0p0GcRrBQIpInUWwLj31RKBjmYNLqzW2QXP+YRGEYt7iHC0P76Jm8+n4P9cTwOfs1d1xtLy8Sw+VgO9oAS9FIBmYq/sw/TUo/txcQ7nYmTHPDwqGEFn0L431jSAgNnAKIK/bBSOR7QAt2RSu/HPUVDzKZcjAD7kfezEi/xugnStumKUATfgAZsjALGb5wIYrRXwmuUD7hYO218AcrMSYkovZgRBOQAADjRZFty1fFirqJpKBr8OYf4JXPP30EunRDmNES5IZ/AHpVM3pwdKpYdt8s+aO3udjwatG+6Wvy2SJTYfvQG6Y84Kbogn0UpdIlsOA4lHVtrWX2pXG3+rBvUqRcxKH73ifZWdFx5WMhniR1yMIWmuj34981sRSMT+mSB/bKMinW2/1nRG2Z3Kz5Vt1JTowZZ9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(56012099006)(22082099003)(18002099003)(11063799006)(10067099003)(261009223027099003)(261026140227099003)(261021121427099003)(261022105027099003)(261102123227099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KKzdgLl8Fi1619iWr32ssA4iSNaEAiIJVX3Wnc3k5s8F9mSzLPlYNXSJXsgYj2gHdczzlxUfFkoENGRrjFxYy0NIC8522/wRAp/nBWdVatALoZTm/RA80uHpe7kCC5sN1STdxvVSdSdoFN2qmrTZucQuH010tlbY6JOFMJn1y9uAs1BdwCDQ0fascnGvjcpf9I9QcNPqS/3fB2Hrgdj2zMrL0YOg3MKOpZra9uZiP53hLycIaQZBqOUW8+uW48uBgTPW+V4bUWmiCdItYXNzHnmr/F1rpO+EJBOYibOMIKx/M2gL3zDNfzvep/kfKfVf4x7k+XAXcmEoXrtU830tuqboSwfXPziPfzOPwPobNySot9CiaThkFdWWnMm7Whii6WXVkD/K58cleJxc3+q1cdXY70oEvz6lnCdfF93oUztvoRYw3lRWsa27e2kReFqq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 15:16:19.4568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09edb724-e5e3-4d92-e2dc-08df4006bd10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026967.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999211
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If the display CONFIG options are disabled, warn the user since
they will end up with a blank screen.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 41790155ac8fd..2ec9334d14639 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3529,7 +3529,30 @@ static bool amdgpu_device_asic_has_dc_support(struct pci_dev *pdev,
 	case CHIP_PITCAIRN:
 	case CHIP_VERDE:
 	case CHIP_OLAND:
+		if (!IS_ENABLED(CONFIG_DRM_AMD_DC_SI))
+			dev_warn_once(&pdev->dev,
+				      "Driver built without SI display support!\n");
 		return IS_ENABLED(CONFIG_DRM_AMD_DC_SI);
+	case CHIP_BONAIRE:
+	case CHIP_KAVERI:
+	case CHIP_KABINI:
+	case CHIP_HAWAII:
+	case CHIP_MULLINS:
+	case CHIP_TONGA:
+	case CHIP_FIJI:
+	case CHIP_CARRIZO:
+	case CHIP_STONEY:
+	case CHIP_POLARIS10:
+	case CHIP_POLARIS11:
+	case CHIP_POLARIS12:
+	case CHIP_VEGAM:
+	case CHIP_VEGA10:
+	case CHIP_VEGA12:
+	case CHIP_VEGA20:
+		if (!IS_ENABLED(CONFIG_DRM_AMD_DC_DCE))
+			dev_warn_once(&pdev->dev,
+				      "Driver built without DCE display support!\n");
+		return IS_ENABLED(CONFIG_DRM_AMD_DC_DCE);
 	default:
 		return true;
 #else
-- 
2.56.0

