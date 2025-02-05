Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81108C02193
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 02:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C50EB10E720;
	Wed,  5 Feb 2025 02:56:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WNNDwv0s";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2F6410E17B
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 02:48:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MUlm4rCjMZ6XYrZvlRG0O65cTP6wXSoIqzs4ENQofhhtblJFsFzvezYZLZ6iD7uzylc4+DcZupf5F0QTY5HZD8PPrYJyFuoeu6sMFacMGIZp06+V1aWlWCOsuyheJ2Hcs+DH45snK/4cpnBVCokutcgsCdCCSuMiceDyAhr7x05FiUzUeKUPdvukPapuWSXCbFJHVL92xbAi32jf3chEksIh7sbzJXRhzaTjRZNWvZDkxtTDoyl5i9KbLofiXJhUNuCvKM0XbrZA8+zHsXy5MCcDE8pQQoVII1aW81X8FRHvS1hMMDXOzO4ODDrDPhDBnDuJl0hHV7cA09smVrOVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNYOWwDIqDaCYQ27CYvtO4q9acBqEC2nmGmJY3FG018=;
 b=OECSmqCHTqJOz3j89VvzG4T8P9HmGkK5pDEsTdSPL0w6Whqx+M+j2VKVpvR7aeKXzNmZyMJAl79lN7HzpEmbAhcG5yTHDEipULHo1IANDtvym+EwKeAZoakKSPHupXpVAxFy0UKRrA6uA8RUSomGTgN5Daihp4EBt79zLr48aX/HOLXbRADrRXV9KlYL91D3dbw+Mt0d9QnHKTLTBiYQpE4Y08SumD9c044J0aYlVkcmkp6tYjwvpj8PpIHFhkGc5jxx8yfjAZWZmJFFKW7b+OjhsZFPlKiSGEs5cFQQHNPRBlc6zgqx/g2kmZcPUgE8zyLZ897BL6NeoLG0Y0u3YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNYOWwDIqDaCYQ27CYvtO4q9acBqEC2nmGmJY3FG018=;
 b=WNNDwv0sVnhTR4qLzOgROefnVTYFEToPo9nqmu5yj+BPgYVwj9ozUV5X5axppeBCVLWV2ja816peVnxyesFfS5bQPVUJh86D4JSdv9O0K6CAZN7PIh/63uL0zUOMIIR6AsRe4nBLkFyRZo5YEhyFhkuCEda14RqeB6or23f9fFE=
Received: from SN7PR18CA0011.namprd18.prod.outlook.com (2603:10b6:806:f3::19)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.23; Wed, 5 Feb 2025 02:48:51 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::4d) by SN7PR18CA0011.outlook.office365.com
 (2603:10b6:806:f3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Wed,
 5 Feb 2025 02:48:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 02:48:50 +0000
Received: from rliang-PowerEdge-R740.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Feb 2025 20:48:47 -0600
From: Ying Li <yingli12@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Mario <Mario.Limonciello@amd.com>,
 <ray.huang@amd.com>
CC: Richard <Richardqi.Liang@amd.com>, YING LI <yingli12@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: add support for IP version 11.5.2
Date: Tue, 4 Feb 2025 21:48:37 -0500
Message-ID: <20250205024837.976890-2-yingli12@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205024837.976890-1-yingli12@amd.com>
References: <20250205024837.976890-1-yingli12@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: f869483d-10c2-4fbb-af06-08dd458f9edd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fCMauHvtNdUjL8X+/31liqW0jNiWF7GabuWRD/+XW1/yi5xPcf3r/QGGsfFi?=
 =?us-ascii?Q?hJv4mFcRo0Xm7PcRAjomKEjY8+YLq9P+oRmSd2iXVZ51Xftjc5dSbtEZXLA2?=
 =?us-ascii?Q?7E5q8HAzVDHMlyfxGSIu9LHDxCI1dLmWd1JClQvk0dSZUeT1vy5SjC5xaEvm?=
 =?us-ascii?Q?0XLEzH9E83YCAq3xuAquQt9tH8Gj5/i/6NtJELznSAkY26ARXtv1IPu5slvp?=
 =?us-ascii?Q?iq+ROzdOoSygsWvY1xM8ZEPFgY4aK/tEoNo8mAo5YAwcEW0ssDUmsDehkJQy?=
 =?us-ascii?Q?iE8HE80zG/SiuOqhcLErwquKyk8X8ELyIHaNZozvWg/KgAM7Kfz4biCETdoQ?=
 =?us-ascii?Q?wCdDlg8DTG4sqjWaNKHhYLfodo/jYnS4Xglni9V2BcKWHuLrttELuipx6gIP?=
 =?us-ascii?Q?dl1hkTSt30asIqgfGbTE8CnyYNs2jg7UbYPLcymKrH69XjnAumJEun+hfNVH?=
 =?us-ascii?Q?6A2X2IiJc/O2tA245X+CwMb58cQzcXRP8Im8dE5pIF78JZ6prG7QIeCHwqyM?=
 =?us-ascii?Q?VKxZugq1SVziiv0lhN9V5CUs/HzKmW0c8OQ7eVN7fjWMWqEGRs25T7B71rWm?=
 =?us-ascii?Q?xUubNF9z/HwBSKa4QDpbE9li+0bAr8k94X1Y9e9O7h3ixVxN0R1WDO0gkx9U?=
 =?us-ascii?Q?1haN9ANTqz7BirUtokChq0GPV/4qpfm5EhQr/0PLRqDtR2Cnk9B09A4VHHmw?=
 =?us-ascii?Q?bk0+wlyagTFo/Ry3o2DT5ueXRrsl3oEHHkqcXEWxdcR0/7C62mOZ8QbNaUmu?=
 =?us-ascii?Q?uxQQzbajUOTTjf8xMyLhkpXX9fcGv6S78KFZ6YYamkHlx2j/BecN+pEXJTjB?=
 =?us-ascii?Q?wJA3qUjVuHUE+z9eBR1UbrMeXw/3GCoMufCCkNFzOoEcwAJYslBkq0rNksWI?=
 =?us-ascii?Q?KGSnz+abZOsf83jrkTTubcgbwqbDQdgiskr8eCagz+lbv7v4W3IofjN17jdL?=
 =?us-ascii?Q?+QEH7qVXEjHAsQ7vpoxjUPyqLVRcNw9PM+t20caIdzwicYZlw+YPvgbwH0UA?=
 =?us-ascii?Q?UrDMMPXrv84+McWBxyD6f43OAOqHcT8hdKj9HzYQ1MBDqMA650Rq11Ygepto?=
 =?us-ascii?Q?hIjeeculnv9Q1EVJm3g/PJonb6lHwuTnpnog8Yk5kVo8pG82I9+NXH5JQD/d?=
 =?us-ascii?Q?Ijre0w9djepmv8JNaVNaZiVCDJ1nO1M6ypMrNPhyPuE7E22+VDT0yTi5Xupb?=
 =?us-ascii?Q?tRkChSvn+iNSh4o/p6p68B6/QAEe++NSCtbEwbx93ajIYoBtJwCpcYCzw+KU?=
 =?us-ascii?Q?OO6khw0D1eDQf02jL2WYbAg5uR6WOESX6mmH8cWg5mfHwG7OjPckW0VO+P4o?=
 =?us-ascii?Q?QqHxtOAGWZ1wZ97TcmCwY8DOD+mWdaN5Tz0QDLN8qY5AoKObzeQrQDkGEVla?=
 =?us-ascii?Q?OSgLUYarb2VG9jh1Kk2ko2ppiidnh+qdRjsdnX/k11SnPVnUg6GhrpSaZvep?=
 =?us-ascii?Q?btDOJOzciBVxkwUMyH3x0lpoxRH29SPIEAUGcnJTAeM9p5XRWkVN7Iz5cGoq?=
 =?us-ascii?Q?fA5vo6w0PvK2I88=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 02:48:50.3665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f869483d-10c2-4fbb-af06-08dd458f9edd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6021
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

This initializes drm/amd/pm version 11.5.2

Signed-off-by: YING LI <yingli12@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 51c2a7f4aba2..dd4cffd94a90 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -693,6 +693,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 		renoir_set_ppt_funcs(smu);
 		break;
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 2):
 		vangogh_set_ppt_funcs(smu);
 		break;
 	case IP_VERSION(13, 0, 1):
@@ -1565,6 +1566,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	case IP_VERSION(11, 0, 7):
 	case IP_VERSION(11, 0, 11):
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 0, 12):
 		if (adev->in_suspend && smu_is_dpm_running(smu)) {
 			dev_info(adev->dev, "dpm has been enabled\n");
@@ -1918,6 +1920,7 @@ static int smu_disable_dpms(struct smu_context *smu)
 		case IP_VERSION(11, 0, 7):
 		case IP_VERSION(11, 0, 11):
 		case IP_VERSION(11, 5, 0):
+		case IP_VERSION(11, 5, 2):
 		case IP_VERSION(11, 0, 12):
 		case IP_VERSION(11, 0, 13):
 			return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 189c6a32b6bd..48912c7295ab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -227,6 +227,7 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Navy_Flounder;
 		break;
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 2):
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_VANGOGH;
 		break;
 	case IP_VERSION(11, 0, 12):
@@ -472,7 +473,7 @@ int smu_v11_0_init_power(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	struct smu_power_context *smu_power = &smu->smu_power;
 	size_t size = amdgpu_ip_version(adev, MP1_HWIP, 0) ==
-				      IP_VERSION(11, 5, 0) ?
+				      (IP_VERSION(11, 5, 0) || IP_VERSION(11, 5, 2)) ?
 			      sizeof(struct smu_11_5_power_context) :
 			      sizeof(struct smu_11_0_power_context);
 
@@ -731,6 +732,7 @@ int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count)
 	 */
 	if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 11) ||
 	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5, 0) ||
+	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5, 2) ||
 	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 12) ||
 	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 13))
 		return 0;
@@ -1110,6 +1112,7 @@ int smu_v11_0_gfx_off_control(struct smu_context *smu, bool enable)
 	case IP_VERSION(11, 0, 12):
 	case IP_VERSION(11, 0, 13):
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 2):
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
 		if (enable)
-- 
2.34.1

