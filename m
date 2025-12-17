Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591EED65C51
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 13:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E338F10ECDF;
	Wed, 17 Dec 2025 13:55:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wBuSBXWD";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2817510ECE0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 13:55:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bY9SM4U38JJDcVqo8TNYTra5IOEj5t7tKNA1v60wEq7TVbvHsEMGo8n0X+0IGkC7xxc39IFGIpy020HuZC1aUm0aaRbfmGNTPtjxKNBIZX0gK8c/9SQ2u1nvuJofAe0UvLgzi18DIQl01kYeJHx/A8QYIa/764OW8gI96BJ0a+Vs3I47eNaGwbnPCTJgTp1CtiK05A0wUH5cKXZ7rUz+NuKmxYfaKqtGJfjprAKHOfSYR10ApKq+1M3SY7+PBHo0wB3zkgcXc6Zz2u2+W1I9rjwDVBF9vNkwZvHJDcJFpRU7r6aPCoaxwSPKOKGzPL0sGG2eAAg/2RZMpYzseIfHTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbyfLAaxCkBeMzPBId2IwHTlQYG29QKusQ/fjKlCZgw=;
 b=EYhAZajE9sPiGNjD6OY6S1dKT5rbxD5AE2bhUlMJ5RXJ3e48HnOIIFUEM7Ja0DxxQIj7n0vBJKze+W6tjHTKRzN31+IXsDCp2xCAyhyI+2UWWAxzd8gm5sIJFeui5StxMub14OvzdXAbZlipDnHs2EYuz7BO5f1ynAElVsK8IHqyQ4Zpb+l4Tyy8oCVtVwHoYRdPIVAR76f25k+rBRUOWFuKoRpPIphxAyHI+0WJs46T4T7fpPucxOFXb1HY09Pwag2N4GtAVykhzIdrsfy/6ZO3lgJXiX7hhMXEVEN0nXOxti90qI4l95U1XoVqYAoQWFdgH48LHBEGdlE2ZebJiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbyfLAaxCkBeMzPBId2IwHTlQYG29QKusQ/fjKlCZgw=;
 b=wBuSBXWDhCAychrzbNw7qePY9d4D2qhAoDczkSSuM+6S1yUq6Drbr0mBOV3EQC06VCg2+jDwcb25Zv2mgQjLg+AROv5zelKrz9c4lULmCyeEHdVn34HyEYkXyM6yeYatwJW7ypVhl50UFW+ZqGpfwnG2u+YT7W3ba7Taf7Li1zg=
Received: from CH0P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::8)
 by DM4PR12MB6447.namprd12.prod.outlook.com (2603:10b6:8:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 13:55:28 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::ee) by CH0P221CA0019.outlook.office365.com
 (2603:10b6:610:11c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 13:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 13:55:27 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 07:55:25 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 18/21] drm/amd/pm: Drop unused ppt callback from SMUv14
Date: Wed, 17 Dec 2025 19:18:11 +0530
Message-ID: <20251217135431.2943441-19-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251217135431.2943441-1-lijo.lazar@amd.com>
References: <20251217135431.2943441-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|DM4PR12MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: fb65594d-ef78-43ba-9f9a-08de3d73ef43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JRUmEPEvHVsYhxtg7K6BiQYAlJJxKoILKXKo6Xe0y+5Ib7EUoZwpQ0tJ5T/G?=
 =?us-ascii?Q?zbaMjB6p4rx7jPDWTwv5WkLxuUxggpvUbesH+DHZKa/bEVgyrBXmELVXfERw?=
 =?us-ascii?Q?YtoUMUYE1cPumfOVFZXW2yb+UFEMisc6HKWPyaqfuIdXN7m18D5ZmadVmfi6?=
 =?us-ascii?Q?soA+Pc1DkT2vh1PfkMC/jJ5rTRJhUP2OvB1e+ymU/GlMVAROdYgksUdXMQwT?=
 =?us-ascii?Q?LPKGKHUYS8rnchs60R9o1taKwrSGtgx/D9XcvHZeCbNF0+aEb0a0CeUjYvwP?=
 =?us-ascii?Q?Q3CKU6wtdCUy2q+1E/NiU/Np7PILpLAb5jeaT10sAoRd8DuZ+sX962yEHYFV?=
 =?us-ascii?Q?v5XxNs1D3NlqOQAHLmszIp0c4QOx0Z/2OMzCk8W39OE7Il1UPBnG5gw/bru9?=
 =?us-ascii?Q?nAHDobR6fGX78BCPHSws+jSxLw88pyXpXxAkACDplPWT5N2fICd3X/9qEO2a?=
 =?us-ascii?Q?/SFMghXc1wpkwRgknQrZrBYQ0v6xVBDwJrkKwVdRIAXjq/bhBcF4rMcT6b81?=
 =?us-ascii?Q?ZuG/LA81i0i90MJNdNspMqpUKga18nLn3yiWom55UY4Jmmk5f5VUJL/gPr0O?=
 =?us-ascii?Q?gw+h0HnyPY1YKUUAlwC0mpy12NathyEvhEEeUWm79qjhFpVpwjzoZDuuQ7oJ?=
 =?us-ascii?Q?eURuM3if/SOMlVcSU8wx2e72kSwmG+DZM4gdPgSKFtOVKV8clMQDiCMOK0CC?=
 =?us-ascii?Q?uySRACtNTTrCl+gJZIUtonVyqZBFA+QeVgJWnxHe5jS0+9wAkUKVj4wGAR94?=
 =?us-ascii?Q?/jRJc72sq2BSXz/gSlmWm2ozTne9lpcaoCmkT+36DjIp+OmVxwtSup5erXOB?=
 =?us-ascii?Q?wZfY/5G7bNYMgUsXOg+hysUOJ1s25JSR2iR8KGJdHzKKZBZth4jw4/y7IVdm?=
 =?us-ascii?Q?efyiubSZ9RSBWng5rvFT2Olvivx4ZWJNAmRrCkmPIF8ko8HDrE5fe6V9wris?=
 =?us-ascii?Q?ZlR/fiX+xanDhflJ6FscYbVAD1JeYVybAAFbLg/8FIY5Gh1MSNZQ7plNrsby?=
 =?us-ascii?Q?xwSCgi0dmthofPz/GiRy1vT8s4loawPwvCNgDed65GNWPmFDJoKFL0I5o6na?=
 =?us-ascii?Q?E05MhkWl8bLIrUXRGUpSAeEqRjljCP13SSMiackm3E1eg/QQ2dIHkDvIQtko?=
 =?us-ascii?Q?8vmc1fLKsDERoT1TOm8Pt/FOSpHl11gczLhDxwJmFsVL6VhoUJD6eG1GW26G?=
 =?us-ascii?Q?03p6I4v71NcEIaQhjXf6YGybw40TyGRokDocgALti3ejG/rMWmznFrfNpp10?=
 =?us-ascii?Q?vpAQM2UFSLqb/urE7WcbpOZEbYOpMHvPFB6MUQN+ZiiBNDGCMdGjQHkQz8Tp?=
 =?us-ascii?Q?ih1vNUz9AifFZYGsg7GUAIygAHrxvP46jbnANv9P8b2rQ515LacSDdxWzTAf?=
 =?us-ascii?Q?DaWvyw2i+loe2WTTgkLuXkYr1htbfTWlITV2j+4g6L5zfpwLbyRayPQh45tA?=
 =?us-ascii?Q?C02NpoT25DCWy8FVqH9u8LpAPE/34SvBgXXeD2bPaAlJdYn+xvJSWVjYlina?=
 =?us-ascii?Q?SHejGFdpwEUFq3T6sWXKE5GaryzjhTftK9EVLW1qDPa/I2hgzfjUsR76sgjM?=
 =?us-ascii?Q?HUnz7Tt4qkXx+GZ+XK8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:55:27.7358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb65594d-ef78-43ba-9f9a-08de3d73ef43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6447
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

SMU message related ppt callbacks are not used. Drop from SMUv14.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 0a509fec2180..a4e376e8328c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1701,8 +1701,6 @@ static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.fini_smc_tables = smu_v14_0_0_fini_smc_tables,
 	.get_vbios_bootup_values = smu_v14_0_get_vbios_bootup_values,
 	.system_features_control = smu_v14_0_0_system_features_control,
-	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
-	.send_smc_msg = smu_cmn_send_smc_msg,
 	.dpm_set_vcn_enable = smu_v14_0_set_vcn_enable,
 	.dpm_set_jpeg_enable = smu_v14_0_set_jpeg_enable,
 	.set_default_dpm_table = smu_v14_0_set_default_dpm_tables,
-- 
2.49.0

