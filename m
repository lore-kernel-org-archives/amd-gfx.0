Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B708C4345F
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Apr 2024 09:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0076F10FA55;
	Sun, 28 Apr 2024 09:55:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2EVQJ5AF";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 071CD10FA55
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Apr 2024 09:55:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kjv3xIWEzPtqI6exk9DAku2oLZzfiWRNEIsfp91+gIctZjwS2ulejSBDmx8G29pubtJfCHEKPRMk8e12qcsj1yorn+tpZ3er+j5VCy8iyFL3QayG2Rgqi3RrBt+J1qrbTDGknG7epBx635OufhuvQW/hwhhUXAcy6tlAeiO9E44d/tfjHPivR7SRaCBpfzfY6IhMdm6wIzrZC42TJPSjDG6jSagivmcWaz99QiY/hZQYkvGolw5WUKzNaD6E7I3AZEDn+lhWCutBsXGHBy8WRU2JYE4YZAXzCEXD39cC9fVYZ3uX5fkDYdQfkEBYPEw3CzBEj+d+XAucc91pkK/1HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vqbzmS/YPfGF5sSpsALWnnHbBTawD/0XQdLtt9NrZg=;
 b=OjwFK1BJz8I2VtROypJQWOASlRLexMNImtI5gBzJnopKA3nIE3az7nJ3uWlnHB4K35Cb+p2vHnfM9q5MgOYtLjpylZWqUEHzlJwwFouRn3bYtDjmH0cikggQicwds2YwjmDQr6ZCaKg+tezMzB7ed6CfFHQGhO/JhcuRt/JNZQQtInI2/Tqi7oVtO1FG6tQjhKwClWCYEl8xpD13kMsfWAUDEzkpfkk/KF5RvbLlpd+JTOkmaUeqWYhuoWR4Wj/w28DnTUPSkgUyTZoUe9vUt8ThjEqo7bsSbT+tmWIYtlt+oidY0S+JADA7Ysi7kOxMGBBUf+JI9EcSqOgFJ707ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vqbzmS/YPfGF5sSpsALWnnHbBTawD/0XQdLtt9NrZg=;
 b=2EVQJ5AF7Kv/ILFJDIJaofAhzngk5QpMqkMP7Xx9IWdqd5XFJ7oAhqaIhb6KSM2Xl9k+gnmFKeuKPVFqdbsElwBz90AjX+AjJR6GkmqxmwrvMEhieXdpMlyNL5vVsHG+AFZdCt3VySa5SVUQ+NTH3/dGN9uarYG5wC+HZ2H/4t0=
Received: from MN2PR14CA0019.namprd14.prod.outlook.com (2603:10b6:208:23e::24)
 by SA1PR12MB8598.namprd12.prod.outlook.com (2603:10b6:806:253::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Sun, 28 Apr
 2024 09:55:01 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::b1) by MN2PR14CA0019.outlook.office365.com
 (2603:10b6:208:23e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Sun, 28 Apr 2024 09:55:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Sun, 28 Apr 2024 09:55:01 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 28 Apr
 2024 04:54:58 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <christian.koenig@amd.com>, Ma Jun
 <Jun.Ma2@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/pm: Fix uninitialized variable warning
Date: Sun, 28 Apr 2024 17:54:35 +0800
Message-ID: <20240428095435.126980-2-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240428095435.126980-1-Jun.Ma2@amd.com>
References: <20240428095435.126980-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|SA1PR12MB8598:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e4a4c75-1624-4200-1e3c-08dc6769455d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7OvG+lJ99NsXdN9ayEWw+bSEjoMen5M03qRwCcCKnKbLneFuv9D746lhOeF7?=
 =?us-ascii?Q?RXc7Cpo6Dd/dd3Z5u9RfcV3BY2xbPZa1dmWSARWSuCCPzbmTCXiAa0wOQaZj?=
 =?us-ascii?Q?L1Jnu3zKlntc3+Gt9h4J6i8AQLLzaJP7kWMPMzMxv68z1GiVoKKJ18QyuMVm?=
 =?us-ascii?Q?RhB0MTrbgw55OB9Ibc6pTqj0lERn5ygrPpjXy+RvNvxxRJGuT1/txCyngKmN?=
 =?us-ascii?Q?L85pusBOQ4fGXxbxyVKjkGxOI9GbVjXjVSiPDtEhDnqxkrHZns7b96zxj5NW?=
 =?us-ascii?Q?o8iwZByu+WbF4tRY+r4tJZDYkayXEMATLeh4FfTrzVQGCpfo8J9Iu1hAOKfH?=
 =?us-ascii?Q?SGDqbOrlDgAU5TRcSJhP2bT7usOI0XxKxLWN7r5EjSpOEPMnlr4D33fdKXMd?=
 =?us-ascii?Q?5OPi32EKr+5WCN7W+JniI3JSE8Uc/H8C6JDC3ahaN28EMLhqRHCD1ooOBIG9?=
 =?us-ascii?Q?mwAHNYirVAfJaSRt7C1Ft+G+MclEir1aeSp+Gm77hySqFW8rh/3gXSAhAWns?=
 =?us-ascii?Q?uup9tgBocJ0sVmVWl4lfocqm1cBxQSbPqQfXjeLZzfOOoVmiML1RTMpS5z2L?=
 =?us-ascii?Q?E/ELj4+tSwOuNPU9QqFQuuVEQAOR8ZDTzT8tPjF0X8P2/ZmVxbpe+KiIgyT0?=
 =?us-ascii?Q?q2WQyBCNGim29xjPOOnaSI0EuonDus5ftslUI0iKYxuqW/5HfYLmvWSiPs7o?=
 =?us-ascii?Q?woDH0ir1FfoKFD/8BRNQV8P/O94/fJmL8YnWzljLBfQ0Zd8ZR9Jp+P6VI6y1?=
 =?us-ascii?Q?yovmH+1h5bLfZs3m1GluRx32oY+caD3cebJclHY/SM/HHFl/TUGxbSy8WRqj?=
 =?us-ascii?Q?rDkvHajVXv9TkgC1Hlq4zNzfiPxNFl3Yx01vkKZhUpxpn4ORTSNhqbsf/Ni/?=
 =?us-ascii?Q?/xJVUKw1gfr9ikyg2AxXS8b1bbIt6klA3R92e6TcYi8nfLMGfUEfo+DVsQSI?=
 =?us-ascii?Q?+M+9EoAkqxLirMtOI/AHy5uTOF9f4tt6Hpag8UJZwhIj+zSQE71guR53HTbZ?=
 =?us-ascii?Q?Q+EtExnVinRrRUk1ICa/05C8/YOr/bpBrE1Y3uh3wp8qXWvuTNdBfR+plYas?=
 =?us-ascii?Q?eGiL6+pyE+VCYkmIB4pPZ049/zNQ8/DYvsJXlFPozjwrbPjPRklhUGq4526U?=
 =?us-ascii?Q?x+B26MFLuAezL5rLCya8+cl2AEynm6ebZJFH+p+CrTbv+uJoGBicv3FzWPbI?=
 =?us-ascii?Q?G0IstMcz7X+cX29Ta3rbEft4tFdOD6yFxCKsSzCmHQukKpf+rJ0pw4dfvbc3?=
 =?us-ascii?Q?bob2+QBBYM8x9QmmmvJb4vdDxlDFp4M5CGhzogjim20HGYzWb4d0NCe3Gtpk?=
 =?us-ascii?Q?iAWw9/cC+5JE8rdsPajrCArFb81af6t8AD7EfbAGOTQ3dfEhfsFsbNrfgIjE?=
 =?us-ascii?Q?6ra6K/aZUb/ER0NLazYlr9licxLI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 09:55:01.2256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4a4c75-1624-4200-1e3c-08dc6769455d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8598
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

Check return value of smum_send_msg_to_smc to fix
uninitialized variable varning

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 21 ++++++++++++++-----
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c |  8 +++++--
 .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c |  6 ++++--
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c |  6 ++++--
 4 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 0b181bc8931c..f62381b189ad 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1554,7 +1554,10 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
 		}
 
 		if (input[0] == 0) {
-			smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency, &min_freq);
+			ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency, &min_freq);
+			if (ret)
+				return ret;
+
 			if (input[1] < min_freq) {
 				pr_err("Fine grain setting minimum sclk (%ld) MHz is less than the minimum allowed (%d) MHz\n",
 					input[1], min_freq);
@@ -1562,7 +1565,10 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
 			}
 			smu10_data->gfx_actual_soft_min_freq = input[1];
 		} else if (input[0] == 1) {
-			smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency, &max_freq);
+			ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency, &max_freq);
+			if (ret)
+				return ret;
+
 			if (input[1] > max_freq) {
 				pr_err("Fine grain setting maximum sclk (%ld) MHz is greater than the maximum allowed (%d) MHz\n",
 					input[1], max_freq);
@@ -1577,10 +1583,15 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
 			pr_err("Input parameter number not correct\n");
 			return -EINVAL;
 		}
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency, &min_freq);
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency, &max_freq);
-
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency, &min_freq);
+		if (ret)
+			return ret;
 		smu10_data->gfx_actual_soft_min_freq = min_freq;
+
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency, &max_freq);
+		if (ret)
+			return ret;
+
 		smu10_data->gfx_actual_soft_max_freq = max_freq;
 	} else if (type == PP_OD_COMMIT_DPM_TABLE) {
 		if (size != 0) {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 74a33b9ace6c..c60666f64601 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -2486,9 +2486,13 @@ static int vega10_populate_and_upload_avfs_fuse_override(struct pp_hwmgr *hwmgr)
 	struct vega10_hwmgr *data = hwmgr->backend;
 	AvfsFuseOverride_t *avfs_fuse_table = &(data->smc_state_table.avfs_fuse_override_table);
 
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
+	result = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
+	if (result)
+		return result;
 
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
+	result = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
+	if (result)
+		return result;
 
 	serial_number = ((uint64_t)bottom32 << 32) | top32;
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index c223e3a6bfca..9dd407134770 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -364,8 +364,10 @@ static void vega12_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 	}
 
 	/* Get the SN to turn into a Unique ID */
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
+	if (smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32))
+		return;
+	if (smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32))
+		return;
 
 	adev->unique_id = ((uint64_t)bottom32 << 32) | top32;
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index f9efb0bad807..3a95f7c4c6e3 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -404,8 +404,10 @@ static void vega20_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 	}
 
 	/* Get the SN to turn into a Unique ID */
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
+	if (smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32))
+		return;
+	if (smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32))
+		return;
 
 	adev->unique_id = ((uint64_t)bottom32 << 32) | top32;
 }
-- 
2.34.1

