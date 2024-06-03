Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B06FC25B76
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 08:46:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C508F10E309;
	Mon,  3 Jun 2024 08:46:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wl6n0ZfE";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6A2A10E309
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 08:46:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8dvEfZVbntA0ibTkrulNGQygU0kzSMC5E515LMPVZ/hf2D33LgMX/VZCznvwEvuEgfT5yNXihtzjATU3rsJkefCEfdcrWePemxW/F5GdKit4Bb3DQlm3LmDs12jg95E+7QYS4SjteJel6F1eBVapOyFIHFHThY0uDUbso6bdKWB3tTsYDAC0REI1bkuwlcVyAU/DdAkyI/KGutldOlErb8AxzGcF2HCy/ESHtly76hbbW2ns/9pAGXL2NM9q6GBADdFfqUymuxR2wUv+YDM9WCiryKnIibIttjT2p32rB5uOtmZMaB3TH6j4URyfbrxTPr2F5/ayd5wQ9LGvNlHKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmkDdqqkewEC0dbH79H1IrZjpKnbRW5B8NML/lAteVY=;
 b=QmFhS1D52WE9n/T38FqJUB0VZctd0mnzBk7LrzAj1Utj1B9tQkgQ7Q+X8tTf3c0yYSb8wX6fUkOvR3PWTKukKhmBMp2zRmW650C0olYSIEowg2TyER7n29VLYynNr3bWTwWa91sLXszC14CRSTMOhn2tdNQxeZ+7XR2+uoOzHtHspFAt/u7J2SlVmy2x8RsgPB05Aj3FD1WUhHdgZgvYFyW8kK7YlfRLijCsW1nBMS6hT4lQMK4lr8c5xz3J4Km5cHKZ1wxEHFuyCjivBvSQhKCfSbldp0QOtTT5ZoDpQCBJg1Hn0/I+Dt47dBqEBDihvLmixNxlhIITOuEvUPPwNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmkDdqqkewEC0dbH79H1IrZjpKnbRW5B8NML/lAteVY=;
 b=wl6n0ZfEKaIeonVZ27DXWa1WXBNKNOs838wdajR87WDIQ8chdpUnsMpYptgjsStJGMJwm5sBY5IoBTna6qNI3l8YqR40zkDswslDCmfKb4R+ara8E+hZHtcta74LRdYyTGHwKqo8Hte/5ntxHGz+AZUhJlF0BTyl5wTg9jLBfVQ=
Received: from CH2PR17CA0012.namprd17.prod.outlook.com (2603:10b6:610:53::22)
 by SJ2PR12MB9140.namprd12.prod.outlook.com (2603:10b6:a03:55f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 08:46:13 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::ea) by CH2PR17CA0012.outlook.office365.com
 (2603:10b6:610:53::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.28 via Frontend
 Transport; Mon, 3 Jun 2024 08:46:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 3 Jun 2024 08:46:12 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 03:46:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 03:46:11 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 3 Jun 2024 03:46:04 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, <Tim.Huang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 01/12] drm/amd/pm: remove dead code in
 si_convert_power_level_to_smc
Date: Mon, 3 Jun 2024 16:46:03 +0800
Message-ID: <20240603084603.2569757-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|SJ2PR12MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df06a43-d06c-433e-57cb-08dc83a99f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O6cpd4FxLbT/oJi11L3pVwwiJEq3/1BgOZd8eLRO8TVS8jhkFIkFln2GyoZu?=
 =?us-ascii?Q?XlGjWEQx5hF2tL6fvNJ1uV+XSeaCLR4YaQV67V/rsiDaVC7p/52sxm3geTCJ?=
 =?us-ascii?Q?iEBLGbSGQHhudH0D6B5NAoGhz++ROUSOWXK6QSMxEX53dJl1mVED8Kc1TCwD?=
 =?us-ascii?Q?a6qof/pUSkexWwj9ayGBYRG3MEMegCSsiUtxx6pcLtXfvS314npXEujcOoM2?=
 =?us-ascii?Q?eFYEa2LKk8DrMN9tWquL550fo5jSZZLW3RtyErZN1dmci44VYI9GNoRRhYYE?=
 =?us-ascii?Q?fDYT6/xdxTbrRPDbQIqAtjubLsIxG7kCw0ZxI1pAEdd1IqB7gKLjjL/BYyKn?=
 =?us-ascii?Q?r7O2wmrbkfwkiXLbS5HzH2HMNJKfWYqKjIb4gD3OXt1T3zIVRaZy+NC0hilK?=
 =?us-ascii?Q?J3bZ0aKtix4d/b7g15e+nGGYnhZ2bH69jSdMduC6xjvmNdOFjGHTAdEFaw00?=
 =?us-ascii?Q?NzAiejtmWhSaM/kc8ZbSANr34iBk+oAf1euGYqMtYV3sakHY2ICUerAIeg7D?=
 =?us-ascii?Q?h7PVQ4bMxuZfDPIjk/vy5SGOsbsp4O6ubmeCaKWKOExeuxUArNIcHttRyfTl?=
 =?us-ascii?Q?HDviqUPhZFpb5T9S9NqrQcrCajNZftMIQDT9UuLOVYKX0wNOrd3Z5KVqFYrG?=
 =?us-ascii?Q?9JcHkAWk/WMBGez54SWdvEWhosd7flrtB7gvuYpJCeCWMd1J1QMKUSbZ38cH?=
 =?us-ascii?Q?6gff4AnznHF8wzD2mMxxCse8HfrEUjq7b0wIHq/J/+vVoXBYgIqOq9BaWn6T?=
 =?us-ascii?Q?DGQ9RFc/hRgw2nnurVOfL+tTXSyjaPsIrPvK+8X0t/GcQs8kpp5E9F1dMje2?=
 =?us-ascii?Q?5wiGSNphLNSwTiWav/jjEwUNewBa9uuDZ0KAsjzKvDHuznlAudAO4s/uz1kQ?=
 =?us-ascii?Q?zThoNBXTrMGEU/6XhlmTHWPlIHMgw4bIbi2BlsXyVLovl1AaeUbSRBsifk7L?=
 =?us-ascii?Q?sprBd977vLb2GFN1MahKNO7i60VSnntjVOYahvU8fc5W7AGJ9zMvALanwDE+?=
 =?us-ascii?Q?ermNx1KajdoQDlCAUf3om8UmUq2gKDVSiI7NmiFz6tDLKaD+Cvzes4PMyj96?=
 =?us-ascii?Q?fIP/sDbBXh9j/XjCCOIh9WRkxdRa6SsGkb0Q8Hzvc7R4To/RYyyXxvXys8L3?=
 =?us-ascii?Q?s+r2Ttm+N7udHkmIJ8bml2QjTDSSuBcN14pbpIeootq6fbG3j3f1GnVG8+p+?=
 =?us-ascii?Q?oFLX4yECSLAll9vct8IlR4ibhs2qMPNVqX32szzH8bdM60vRkT6g026KzwGE?=
 =?us-ascii?Q?Q3mohTfU/p1ZbjWLvxhFurCQExX+a533DWZ723ggGm+waJHL+JdLkx8tqilq?=
 =?us-ascii?Q?lDBdTKe0+XMExEme8uhhhysTC8S5MXADSX66ftLlZ8b3pKWSK2G7M581s8Hw?=
 =?us-ascii?Q?BIzbypRHXqz5n0iNpziSRC1lJyXW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 08:46:12.5680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df06a43-d06c-433e-57cb-08dc83a99f5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9140
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

Since gmc_pg is false, setting mcFlags with SISLANDS_SMC_MC_PG_EN  cannot be reach.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 68ac01a8bc3a..a18f75a6d480 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -5487,9 +5487,6 @@ static int si_convert_power_level_to_smc(struct amdgpu_device *adev,
 	    (RREG32(DPG_PIPE_STUTTER_CONTROL) & STUTTER_ENABLE) &&
 	    (adev->pm.dpm.new_active_crtc_count <= 2)) {
 		level->mcFlags |= SISLANDS_SMC_MC_STUTTER_EN;
-
-		if (gmc_pg)
-			level->mcFlags |= SISLANDS_SMC_MC_PG_EN;
 	}
 
 	if (adev->gmc.vram_type == AMDGPU_VRAM_TYPE_GDDR5) {
-- 
2.25.1

