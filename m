Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A118BEE208F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 11:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43F3C10E1B5;
	Fri,  6 Feb 2026 11:25:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZOiCy0zE";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011009.outbound.protection.outlook.com [40.107.208.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3120C10E1B5
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 11:25:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrtKwjyikNzFvXyhPEfyNmma3w+RBGhvpmMySb62TJYqxzU3EB3tXO9olCVDaezp99/8HpVrrhG3LCq4pHQOxc0I5jLAh2ekNF3WT5+RO2GUHCfEgkK3KuLbs9m6ZIt3vYYmjoW4I/ewuAikLv0UuA5DZentbDsgLWUxOMhvk+JhLRaw9tpY0tLP3gi+BB66ji8OZKTp5uKiulYJv+FEBHtW0VmmNQ0RCJnGJo/kHHbwMZbeblvLkz8riH896bQ/LU930DPUGf7br/mXanaCCkwW1W0I3zdM1KDyrE9wsqQU1pAIhD9QPjnrQ3YcFSrLCpyClHQ2X1wKxM4UzKJDIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bF6Qzdyx7EBM3HoGEtPRn1thUQkc3EX2GonTEc/PBQ=;
 b=vImWxyUCanN4S9+jmiiMiJ2XS84SN8J9P1o906MpJBR7yLVmwTZqCQuTE+FjAhMG3DLV2tVCyThHJ8JJgmi+zx2Pg3fh2kEhUxNenridphq3moiE14mS2L56DQjJxRQuC6B87D1ZnxOeo7Dsh8YItXGq6N63jNKvynjT45ydX7+LBiWCuauGcKshcZ4JupsCYA1rnTIXQLgddiER6mWSDEeaqEcOgb+N4Q5Zw4V59ozfXrhxeNtlOpejmy5ANmTBdB8zA4mXHXB4vy6BO/HWdkjxyo/WfrmbEul4Kak30n39m8FxMRg00ksOiH4ue9iXR2suxmH2fuom/ycnOyM3oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bF6Qzdyx7EBM3HoGEtPRn1thUQkc3EX2GonTEc/PBQ=;
 b=ZOiCy0zEvEuXNr0vfSTDWVBHVVDp+xTb6XC1pMq94dyIOaAu0ZcV/voTctIkr2zu2ejg7L79xT1dN5tsTg63ijjo7dE59TCN5XMrcaOqKbINxS2cfLTU1/0D3kyY3qDgL5tqNmzpTaKLUaNAdjZ/iohG2WDYQEn2+rugyB/XD08=
Received: from MN2PR06CA0014.namprd06.prod.outlook.com (2603:10b6:208:23d::19)
 by SA1PR12MB7320.namprd12.prod.outlook.com (2603:10b6:806:2b7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Fri, 6 Feb
 2026 11:25:16 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::96) by MN2PR06CA0014.outlook.office365.com
 (2603:10b6:208:23d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 11:25:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 11:25:16 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 05:25:14 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH v3 06/11] drm/amdgpu: Fix is_dpm_running
Date: Fri, 6 Feb 2026 11:24:44 +0000
Message-ID: <20260206112449.45381-6-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206112449.45381-1-Pratik.Vishwakarma@amd.com>
References: <20260206112449.45381-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|SA1PR12MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: cea30685-c26f-4b19-cb23-08de6572671d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hSvt5Jk+Nm57WGFZYnMo9IwTBHB2DbluUbW39AsMfIMp4E8xgL/U1tWUezgo?=
 =?us-ascii?Q?LngLI0dxBTSjhlMfsJ5+hWyrKuS2MISH+fa3japmWFb5zlII6N83Mbw6ncY/?=
 =?us-ascii?Q?4P71BT9Oby6RgUbLwJAXICda8C0/4NG8RKGPonPVnMpwjTHlnCNZ848UHlQ+?=
 =?us-ascii?Q?8QrqfrdNpt5UHGcBmp5SAEyiTOiW8/GVdO5/T4MK1B+2dXAU/W635dghcI05?=
 =?us-ascii?Q?ZSTuJDuN0sbXwCLr26w5uW/08GmH5Nj2XnpV+wu3VfGp07EFwnp3hFVX2DX+?=
 =?us-ascii?Q?vDjOTbGzzt+epPOst89EPppaF5VmxAKFFA9x18sUjxHICld4+eTD5l9Qs49c?=
 =?us-ascii?Q?SWrpSn2bAPbkfjZ++QPgp0LK7Q7nlhSaR3zZTy+bNWW5+tL/DA/NcVyS7S2c?=
 =?us-ascii?Q?lxx7Lz8RIv92lKyXLBRcBWMpzStR1nj+S02e6mQFR4qWHXX7fZnuspDrxkNa?=
 =?us-ascii?Q?iXGO+qar4wrYEsIf8YV6Us3IhRm580CWr2893V39+K8H92EafWh/qErcUrFk?=
 =?us-ascii?Q?IUx4e8f/9OPwq/OFX0QI20/fRkIgqZdbMUrY3nuVGRpsnR0bq5phDWux/XzJ?=
 =?us-ascii?Q?8lxxQZkhgFT7H8XfVjIEGbpnmX2ufR1I3NxhLWlgeZb/NGpK1J3e8RBtBY75?=
 =?us-ascii?Q?44MEhR+w+jDv0fQqLWsIBxUpSzDh97TLNoqcyjUcnWGyZ4s+85iiiZOgFMa8?=
 =?us-ascii?Q?j3z8rSzJWBGSJy4MbRRXMMv8062y5eu9t7ItpHIIti2D7QAdgm2EFlRTdPig?=
 =?us-ascii?Q?djJTqbj5YqclFvj9XYjQUF28OldvhFOdBSQK2vl1UAbbu1GbHI5Ql50FVwiF?=
 =?us-ascii?Q?bkheKLer0EcdPAqIoDpwQBgoOl8f/DQa2Nh2xR6MJKuPra59KNnBwQ2wCTWr?=
 =?us-ascii?Q?lPIBOSI7vb+0FqY/FGm5yTtNGVB1gHfNhgpfB4hpMCO9/M8UbzZaiPCIz390?=
 =?us-ascii?Q?lMh0weGLy1yJjMVUzixkHRHlcX/rrU/FqgwpKik+yf+Kh+DwJ8wzxAAvrYPl?=
 =?us-ascii?Q?PHtB1AriIqum0VWyVnxuAI/VfIEWakXVNOurhci75FWugEELtgAdB9/8KqMm?=
 =?us-ascii?Q?2fWDAWVJT0b6fCTLkSdGTzcoq/00AzkqUEAQforwrsL558v9970XhwbA+tqS?=
 =?us-ascii?Q?PU02zCzGYeKPBZUxt0zlYN1gQwNXydw/qyHV3TBWesqUIMNSPWzFxUeU7JWy?=
 =?us-ascii?Q?BfM5a8tLPpnTDYLtOK9o1bVMNKJaNQjLrhmuyM9g4KMKqtFOlLb+I8Dga6QV?=
 =?us-ascii?Q?oCa2hQI2pil4hrCyCrsAXXexNEaeHx2sMAri4B9xATrcBFe/v/vX2rnqrx3S?=
 =?us-ascii?Q?SlMsWsgrEaHw+5VoNTNMgrBAGvpuxruzg+eCq2K7jgESaCEQShuEmaaLRsQe?=
 =?us-ascii?Q?A9zTXgGvdq4CTP45hgbRREChBJlm+2Seva9PJvC88iSp7u2mJfN+tWrp63Pq?=
 =?us-ascii?Q?0qWZa8kfjIZ8jLJV72nnN5muH9OfIp8W/8MT95jhLsxBGBwO/+MlxqcRvV8h?=
 =?us-ascii?Q?6pk3LJ2f7QPm/D+xYGykv2xjL/j/061GOhfzShc+C7+N4zeq6RZlCJd7O1/A?=
 =?us-ascii?Q?rhV2yLT3wwcP22mGcxjaClacN/ZOb/LpfaaNhnwTm5rK62ssZmJurlFZY9YU?=
 =?us-ascii?Q?u0/WpExysToNarmRZxmsGz7bBgv6N2kB7UtWUH653N/epGs4L9J7WI4pyd7S?=
 =?us-ascii?Q?qKWF3w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /9H3XGXnfZQ4Fm+7Q4XigR9jVB1pGQIOCjjr59RgQCGaUSsRnFZ3rU8l9z11fkxbx7pFUVpGRethMruOp6tm2txskMtiC3nHX3nnVeBrCLQLATILjmpfTNpPFv0SJZrRh34e/FM5nv+NzY2ideO1CUJHc8PKxZh+eyQBnZ9W7bazEbZCddhcnZt9aNLyacJo2NrhowzGoqwYg/lJ1lWSrl/LwCJjxXCy7lTOx8Em+0xXksqC8bXXzG8G6CYlNZMtUUxJFMJFl0xZd6n0IsnzNmNhIpNT3AFHg81THOT+jgpEz7ccekUDeNMRw9HV6KyEahxycMoPTYwpNP5myYljjDbD6FUmsM+qcqnGoxDvhMeu3k0UMa9K/obUEVBLyIuK0febUWbw1nO0+f51YXAVfLRoD8HJEdfgfS0VK+bXDCPCpd0nD8BYvTLVBn8VrIni
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 11:25:16.3442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cea30685-c26f-4b19-cb23-08de6572671d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7320
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

Use multi args for get_enabled_mask to fix is_dpm_running

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 35 +++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 2987ff1b13e4..f90d274c0f67 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -479,12 +479,43 @@ static int smu_v15_0_0_read_sensor(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v15_0_0_get_enabled_mask(struct smu_context *smu,
+					struct smu_feature_bits *feature_mask)
+{
+	uint32_t *feature_mask_high;
+	uint32_t *feature_mask_low;
+	int ret = 0;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+
+	if (!feature_mask)
+		return -EINVAL;
+
+	feature_mask_low = &((uint32_t *)feature_mask)[0];
+	feature_mask_high = &((uint32_t *)feature_mask)[1];
+
+	struct smu_msg_args args = {
+		.msg = SMU_MSG_GetEnabledSmuFeatures,
+		.num_args = 0,
+		.num_out_args = 2,
+	};
+
+	ret = ctl->ops->send_msg(ctl, &args);
+
+	if (ret)
+		return ret;
+
+	*feature_mask_low = args.out_args[0];
+	*feature_mask_high = args.out_args[1];
+
+	return ret;
+}
+
 static bool smu_v15_0_0_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
 	struct smu_feature_bits feature_enabled;
 
-	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
+	ret = smu_v15_0_0_get_enabled_mask(smu, &feature_enabled);
 
 	if (ret)
 		return false;
@@ -1356,7 +1387,7 @@ static const struct pptable_funcs smu_v15_0_0_ppt_funcs = {
 	.is_dpm_running = smu_v15_0_0_is_dpm_running,
 	.set_watermarks_table = smu_v15_0_0_set_watermarks_table,
 	.get_gpu_metrics = smu_v15_0_0_get_gpu_metrics,
-	.get_enabled_mask = smu_cmn_get_enabled_mask,
+	.get_enabled_mask = smu_v15_0_0_get_enabled_mask,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_driver_table_location = smu_v15_0_set_driver_table_location,
 	.gfx_off_control = smu_v15_0_gfx_off_control,
-- 
2.43.0

