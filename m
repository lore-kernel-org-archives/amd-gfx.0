Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B5EC3600C
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Apr 2025 09:44:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3E0910E1D9;
	Thu,  3 Apr 2025 09:44:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cw+mP0So";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 497C810E1D9
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Apr 2025 09:44:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XX/FC26aDAukUiWwxeV5beYash/ORuEzOHDxb+NorTVOCXU41YkMx+V+rdYct0Z5XzT9wRoLt+WChUOniUDK+owyLKJQZ+u8+O314pXY9RVH/z3VU0D+i2ylqSuO0FnaRJu8B6SoIjVaOG17oBqthEW0pmKVASme37WLw6XI5nZ28Mo755wYf8+10744/XlvISUWXP3UiNQZv6Kl6DJU/rg9A1Mzm9L6VPuXehj+F1IANP7hJ7wX+l1ebpmr/yahrtARbLx6deogSgDeOBjKDqMnTsdOI5f8fkzmBPc3cVj2SAglz9yCNzkPSDBdBS320KMlaTBj79Jxbn1J9dvCGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUI2oytj8UC0EM0191j1SFf9yZbuYgAPJPjsxTtL8UQ=;
 b=ehkHwHI1Y9SzTWteUPdLLtDl/UiB6dSi2G/nCJBDu0Dp39lYOCussFLCBFW4f2TbzAP1XlIb1Nhs+n9BhFoFpDgCSZaK5JWsaaQwI0braBFxDYuBz8QtRGMav50g2EZBPtJonkmpW2CdsWcZItFTVOS9QClkfeAbZDrPcnWtJvyH3ylf1xZ35bAC7tHuqv0SCdsudJ/eDmy/AtrHiC8WxpLCohXnOTutKu4RgYVIxYQ/dpa3i2raQMIezS8e2gkasoqk51Qc0pM8Qk4wAnubupyC75X+yZP3fFIcDjVH6bZERdgsosfz25L1ilvkklqKk2HD5Hn7pBQEWLRt8SmElQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUI2oytj8UC0EM0191j1SFf9yZbuYgAPJPjsxTtL8UQ=;
 b=Cw+mP0Soy09ssMHMxcgfgoRy3h4ETQ/UqTU5A2kja9qtia8HMkIIbhgnR8FTh/DJo64L4qVJdKIeNrHScFNgjJwkNMo1u0SqKiwJo0hSa2vRH84T4i7kKYFvsRIGQ2NEYSSh5Tk0xrzGbmiijSIeJOUip9CK9E4TgMOn/wzrJDQ=
Received: from BN0PR04CA0046.namprd04.prod.outlook.com (2603:10b6:408:e8::21)
 by CY5PR12MB6177.namprd12.prod.outlook.com (2603:10b6:930:26::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.52; Thu, 3 Apr
 2025 09:44:04 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:408:e8:cafe::43) by BN0PR04CA0046.outlook.office365.com
 (2603:10b6:408:e8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.26 via Frontend Transport; Thu,
 3 Apr 2025 09:44:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Thu, 3 Apr 2025 09:44:03 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Apr
 2025 04:44:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Apr
 2025 04:44:03 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 3 Apr 2025 04:43:56 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, "Jesse .
 Zhang" <Jesse.zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Enable per-queue reset for SDMA v4.4.2 on IP
 v9.5.0
Date: Thu, 3 Apr 2025 17:43:54 +0800
Message-ID: <20250403094355.1866897-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|CY5PR12MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d969b7-6bd5-4676-b1c7-08dd729411f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k5HvbUAFZ9iFOxOoF2bsyPtgawbNADhTSQXZEoF84ELsAlFVYApH/9vMkKZl?=
 =?us-ascii?Q?voQDWs02xv6myMjTpiFNLHba5ROL+OC9MYVRuGJqFbhzEQmbxf3pagoxEYqD?=
 =?us-ascii?Q?BU8AUkRXyqwHHEfX4drcIA785SV9agw2DfVAs2xAoQ0ykhoy/HNaNTXf8nsH?=
 =?us-ascii?Q?KPTZjVMgrmtqJjj8U8YvKJbEWjgANlgBE4nYFl2QuHna4U2RXLGEfG0j9HMB?=
 =?us-ascii?Q?p/z1LqehZ6FolcQkJkZiDm09yQRd3C6syLhT7Jl3+E46gybINBomrfX+TUbv?=
 =?us-ascii?Q?UVczHV+dejxvDF4NSST8/UzAcCwvuqG9k92DWRTVtMXhWGQw+tvyKFVtYYBe?=
 =?us-ascii?Q?tcVsD1hndrHx7P2jW3wl9V3ogwg2PwfjhXmYxYTjOXIULcobm6INiyxbUCet?=
 =?us-ascii?Q?96lnazZ0znkpOFY0L0F5IFL0TqoM+7ERiQFh/DAQ+q0L9uO7GDI1AHwoRFcH?=
 =?us-ascii?Q?nwc7YiYTl3B4GkJDMtFHFhsKGgDngU6SN9OHZAuNATCxlq1jxXX8YEtm8rNH?=
 =?us-ascii?Q?XcEZ4zahkz4bMFVThS94E+UqMnc15rmBJBiBWZgyyoyIkh4y8bOkPg5VMTfG?=
 =?us-ascii?Q?zcyogzVkhXu3KlAQ1l9oV8Yj5pu41wnXCfvnC69wvQ1g6AyjMI1cNI27DnbD?=
 =?us-ascii?Q?hNOu3ik1yEszMp9j5BHJxWRdnyvWVylP4DdLiPTm93/2mCkqvYiSQ0OALuXY?=
 =?us-ascii?Q?wLL6spIjd3Pvo4LCJ5HsLle5klEtWHBs9Pg9RMkM6I9EuXCgraDrRRy6CsrD?=
 =?us-ascii?Q?tgF/mSwGpkiX/DUFbq1gwh8wCcEuBWUgs/MxkCLaJqpaV5UFyZz7KOnuZNUO?=
 =?us-ascii?Q?44VjVCqOlG+E8wb0FkynSF7it7R7kSr0Np1TBDe7CkEukKWuM62xRzGzbtxR?=
 =?us-ascii?Q?u5ojxbTUvKUNafnWs3oPOWSgcIQH7m0NuHPtf+BsWM/ElsybG1iL3eFTbx9L?=
 =?us-ascii?Q?6OUcWB1uJmPPsBuGWOv68fbnZSp9SYAmvihZKSyk7gYicGC9beV3UF9ZMP80?=
 =?us-ascii?Q?QiMgB8KpGatT4UCKAKHX1iSz7tZQNAMgKvYkqhCR/uZZf7hT5S84jITgURhY?=
 =?us-ascii?Q?9RNBR6PB8V04gzQbT/eMDWXRvx9zLqYU8FfIR3L7rFOozJyKl8WeGDDi7jdQ?=
 =?us-ascii?Q?pVLnCMJP3IDocMG5qui68HTf/9EvUrBDi8jgomZdKr1YzfxYyigRoCbTSj0A?=
 =?us-ascii?Q?qjrz3477rF6S3CvlSnezeL9a+h63AQJofpXX7f4O5M3eotS6ZS38FejGzZWL?=
 =?us-ascii?Q?zxpahBacu36n9XWMXxY+x+f8+n9tU68ZTNHdFax6HEY/QseDtlWZyWFPCRiP?=
 =?us-ascii?Q?awRQmWJ23VNxWgUsnM6DD7MzMU2f7GBmF26u72VIX5oH0SwZBQiY+u+Eq5iV?=
 =?us-ascii?Q?R4X3vpt9NUfRATBpHECcboUYstPrZVxK91R/0bdZclISC9m+8n+7FkgaNWN3?=
 =?us-ascii?Q?EmvPLN4syYxd6tUESDndNYjhd/wlgm+L/4qPfNA5eHRAGzFF2eySUw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 09:44:03.8115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d969b7-6bd5-4676-b1c7-08dd729411f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6177
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

Add support for per-queue reset on SDMA v4.4.2 when running with:
1. MEC firmware version 0xb0 or later
2. DPM indicates SDMA reset is supported

Signed-off-by: Jesse.Zhang <Jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 688a720bbbbd..9a2a5eb93763 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2373,7 +2373,9 @@ static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev)
 			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		break;
 	case IP_VERSION(9, 5, 0):
-		/*TODO: enable the queue reset flag until fw supported */
+		if ((adev->gfx.mec_fw_version >= 0xb0) && amdgpu_dpm_reset_sdma_is_supported(adev))
+			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+		break;
 	default:
 		break;
 	}
-- 
2.25.1

