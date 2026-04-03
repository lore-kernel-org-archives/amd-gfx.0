Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B26E7E35D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2026 09:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9259510F3F6;
	Fri,  3 Apr 2026 09:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qOGnfCqW";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013062.outbound.protection.outlook.com
 [40.93.196.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2373010F480
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2026 09:25:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrYgcWFD9zO3DdbyOGYC4I2LRtQ008s7zWzjF5jabJw295/N6Ci15Ibqu07HKtUMtNW+ke5gyOszSCvZLyV3TSGLW9roYj31A9+ebrUwHGXJjA8z/M8nGCV3JrTQ3hKVqf3vcgmqoVXwbSvR6apPPALOzNYoMHOWmIyVcJ7auAwTzZT04Q5qaCg1bW7ONMpthRsEaH7SS1/2IBkC8qCWdx6X9nEtIvhGT0H2vsZC96Q/4Dkty6pzoc94ZBp2Xk9P5k/4vTgPujzg51jj9GL4OGLcRMSHioj1TU9Dx8I7RQHsYxD7uLC/fZ0lXiXEgnIAhR5Pa8o2BMw9jWK/tD5wAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMjRDqshfBcnH+oYaZW78TCSKX6x24PTXP7nWOVl8Wg=;
 b=ppAuSC1WBjXRTAWAWqCrYEhzMGeDmfecvQUbTsLfXfWCE3rZgITL8uSrdWFaQhadEvC1d/UDo384eABBEFOUcbq+p4ti/bfcRaVAcceCSMmDWgTuJRlQLefHk4rGFgh0JhtNyXne23xAdlHTVz3OQSFsZBDdRjLgy0OxPrMPTxarDI3M0nu9FTzK1UFP+hwsio4Petp64yUDQf1HA9Q2dg0MSiJC7lw5Rpp98HFiwhaBry9ejrUvU/jljPGfQeV0pxR+Px6uX1gKlfCP681mI7IsjQSwXqEVmUDSKU+HlOrK1ddNc7qyM7/r04nxFXSdHP8BcNgkcYbEKzguVMRPlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMjRDqshfBcnH+oYaZW78TCSKX6x24PTXP7nWOVl8Wg=;
 b=qOGnfCqWQVrtey3XI4Zbzk9bnFRRkpGO+XuFj70/9b2Di+4LvU+4+DifmOQZHHP5f4PtGuHj5cU4KbKLxPr9wYDKzZ5uGAG0VxN8XzOr+5hzxEFjPDAE4wMVWSbau8ZS7Nk5b5eQ8VhRvEMliBTOfr+vSWgxJCz13t2AXysjBnA=
Received: from BYAPR06CA0046.namprd06.prod.outlook.com (2603:10b6:a03:14b::23)
 by LV2PR12MB5848.namprd12.prod.outlook.com (2603:10b6:408:173::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 3 Apr
 2026 09:25:52 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:14b:cafe::37) by BYAPR06CA0046.outlook.office365.com
 (2603:10b6:a03:14b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.20 via Frontend Transport; Fri,
 3 Apr 2026 09:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 3 Apr 2026 09:25:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Apr
 2026 04:25:51 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Apr
 2026 04:25:50 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Apr 2026 04:25:44 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Prike Liang <Prike.Liang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>,
 "Jesse Zhang" <jesse.zhang@amd.com>
Subject: [PATCH 3/5] drm/amdgpu/gfx_v12_0: set gfx.rs64_enable from PFP header
 on GFX12
Date: Fri, 3 Apr 2026 17:24:37 +0800
Message-ID: <20260403092529.2238333-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260403092529.2238333-1-Jesse.Zhang@amd.com>
References: <20260403092529.2238333-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|LV2PR12MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: 232279f5-f0fd-439a-4665-08de9163000a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7mkS3UJc/SbWX6X2gwRfiPRr//3S0KTO5lZTbdbJW0ezyUqZmS+rEE0Ab2Ox9KnG64ID8vTSf98v0aObnpt0D9F8/AISiGeDEzheBeascr5RSKd40Z3iuD1LIAcJPWiuplre5mb9EqSY2yk1xkTfsYCWehQ4r7+hvupsLjPMhTLYYBSZJazmvLSdLrQO96weAmNO//lVeGNWBj74GjyQZD3ImsHJFP0msSUvm/WwsHhvGnHM6mjIz2OmDIXSR7Jz4d/57A228tClVH90ztiRG5i9Fh5nZPzSVeOOuDS1g2IB5a7+LjPOO2WeM99qwHw7vEbbsqrt4vm/Rp9LED28oSrbgzapTiTHPoOb4oQr5ZAb9h9/ODVnPlZHzk7I4U+jqnkb9eQNHkIH5PNNQ64vNx31uUwn3XjzB6tyYrXvVGDM1p0fC0jYzSSB1l5+QD3mOqu4HJ+mGfMHZJReKqAbRIo7JPC2MVU8koscAcWz0xkKiADqfMJegDs5AGR8XRCyJhjm4o3ySJQALPgxA6psftFnfwAqS0UjjbBibxBm3WC2VrCxjpT/dpgBTELQeUHmSMdmjNRxH2Vy9yzp2oUEXrVxUSZfV1OGraxTTIvCG7wq0H8XO4RgVD6ltMQwICE6j3ve/QKdWw2mnXyxqf2TO+drwITYzdlIieEogG4uE6n3eG2gBlimf8cHp8yHQIuc9mmSjvi6lD0G6iMxXdRNxNPuQDQOK7kncitn0lLQgPvdvxwYnOFqS2SgLg6C7iZykMT+C8aHPlIwmCPRi8Aw1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YfZsRk9e1tlC3+WyyW8AQHV2cxKU2mcNFhPHDxCEVI8RQ1quB0OjxgeFAQyFvLMw2D4XLsvBYLhbs83g82CtbDgRKUjpn/M9LY+v+dnZrexAnRA1LKuRK6jQ+awvNXMDANGadrHWpPeafGP5t7WjQc3/Pll0qe+EgcLWQRUHviRykJgJWbVSjiDsvK+9WbE8nRF+v4Do9bmZt/Onv8Nx2i7/2Dm7k997KtUIQhXn5jLJyzHp+EbbV0JWtmD6+M0Qi1hEDqqL/mSjm/jv7xRCRJfrop+efB3x0jRU9E97FJr92f3cOlB3CCRSZGZDQPbfd69aTDh/3XonS5sJmQ4IGakHeYQTYJtQlwI6BQ9SI0U8dBK7dSl0ybGt5Ff/l4LqltXX+OkkF3A6JbjOMk+On6RXb0cEX7GbfigZS/BnC4aGS5hxQOsZM5d7AJ/dD3Wr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 09:25:52.0306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 232279f5-f0fd-439a-4665-08de9163000a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848
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

gfx_v12_0_init_microcode() always loads RS64 CP ucode but never set
adev->gfx.rs64_enable, so it stayed false and code that branches on it
(e.g. MEC pipe reset) used the legacy CP_MEC_CNTL path incorrectly.

Match GFX11: derive RS64 mode from the PFP firmware header (v2.0) via
amdgpu_ucode_hdr_version(). Log at debug when RS64 is enabled.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index a418ae609c36..65f308b15691 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -602,6 +602,13 @@ static int gfx_v12_0_init_microcode(struct amdgpu_device *adev)
 				   "amdgpu/%s_pfp.bin", ucode_prefix);
 	if (err)
 		goto out;
+
+	adev->gfx.rs64_enable = amdgpu_ucode_hdr_version(
+				(union amdgpu_firmware_header *)
+				adev->gfx.pfp_fw->data, 2, 0);
+	if (adev->gfx.rs64_enable)
+		dev_dbg(adev->dev, "CP RS64 enable\n");
+
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_PFP);
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_PFP_P0_STACK);
 
-- 
2.49.0

