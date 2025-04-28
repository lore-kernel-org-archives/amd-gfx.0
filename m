Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50283C369D5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 13:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC30F10E560;
	Mon, 28 Apr 2025 13:56:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gNZTa7xt";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A84810E55E
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 13:56:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yf4SmGQV+lsr1PNH17QQSyz1jjB/vCPVQDhZ4nkAWPRQL6VC7cS9V2C7AK/ghA+240k5hp2z0OmDzq+lbZ3XfNIg3bv1CjF4Pl93Dlr7jhz1QdVN7x4vjSvw8WQXO4EIjCdq83ZZfhKERi1QVNanLyaaTV/28llGcXg8RIN46p46i5zsye8R/rg4Ent9mJJe4WDeaGQN8VgzH3YAT61zoD/G3a9H+oL8AJpJ/eAQ5HVUCmPIjXEpVSDaKxRZMROBTzoR/ZPikFejsjeKMNIsyktQoKa4Lx9HKcIaF2uRButNeAeI40wGRtbT1PyYj41EKtKNtdz266Gvf9/pTxv37Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lT/67TgpPH7e1R1CCbIEFdiw/vwwetq5yjTe9PV0Mcw=;
 b=pZFawHBXUH2IIo8IBoajOP/XKvByjXLXzxuZeL3UnwptDYarX2irnr/m4lP5eIt9XddhFAnQmZVCrpqKmVTN5mbc7BGxapgZkr65Ji5gEv+mbJjyKo3A0aANQK02qApz2ueMsrVAr25pziQgWt7Dctnvy+jXfXAeeaDWWiOok7cXbLPHlaEcLxR+U63qvF2kQTjguSGN8i4OX3SCmZBj2riL/+3rK2EyGX0gT1SqCcgxCLqPQesgSH6eh57a83p/nTiMGygerWWZWMntdVJhm3BojAid8aZb/Z0JEO+i9Rkk1qf4n/vUd4E3DtENT18CegkXXgug1zkL1vrjO/szng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lT/67TgpPH7e1R1CCbIEFdiw/vwwetq5yjTe9PV0Mcw=;
 b=gNZTa7xtgeioaYHaV3f3N3VPPzsxpvlJCid2KrCGDus1UxQDtHEo8YcaQJpArr81FVH/rDdPQ3iu3xhzVF9N3x6okq78N+sC8a4Q0H8mN1Jr3s31d7zclkbQ3eSSbhlbA/9rPD/Aa806HLa7jpLXv77/al4QHrD8uRR4Dg2MRNM=
Received: from CH0PR03CA0340.namprd03.prod.outlook.com (2603:10b6:610:11a::28)
 by CYYPR12MB8937.namprd12.prod.outlook.com (2603:10b6:930:cb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 13:56:28 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::dc) by CH0PR03CA0340.outlook.office365.com
 (2603:10b6:610:11a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Mon,
 28 Apr 2025 13:56:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:56:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:56:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:56:27 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Apr 2025 08:56:24 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 10/28] drm/amd/display: more liberal vmin/vmax update for
 freesync
Date: Mon, 28 Apr 2025 21:50:40 +0800
Message-ID: <20250428135514.20775-11-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428135514.20775-1-ray.wu@amd.com>
References: <20250428135514.20775-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|CYYPR12MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: 695fed9f-1cc6-4e83-266a-08dd865c7922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I2L6thSOqTDJ351ZEor65PvPNbJyvzbAqljQ8G0siGnMihfHzycI9yPn4h1Z?=
 =?us-ascii?Q?v6x2bxEqesW6FxlWCFcdjePBBgPu2KAjL1xpALaHHLrBNXKPp01JRZI3o2B0?=
 =?us-ascii?Q?gFDdAeOKi6ml926lFpTMxYSmOD3/9DNF+CIxkWpy+wxKzdV/2+Fka8hjhbHR?=
 =?us-ascii?Q?4TVh3xyq4d1s6+/P1Nv78Bt7ku3PnpTvHz7MT14VCgPmPBEIMjL7dw+pcrnW?=
 =?us-ascii?Q?f0X2eYWvGFa3r7QZd2BpMn97eVwm2auXmrbzfYEXH4d+Ycyhm5ctfp8rly9k?=
 =?us-ascii?Q?5MEwGyxJDT110hKZQ/s/C0lFnq7FRAgOrsYnYpG6Nw42LLa9jdlewshvicUW?=
 =?us-ascii?Q?WDlgSDeqtiPDcVARbAxtzAkftWIBxLSb693gAXm41Iv5sgpRw1Jj1jFFLkmo?=
 =?us-ascii?Q?fy2TGswUxdCP6i0vzE8uuZ831Rwz1aXdomph53QaxtKyJ44O9BnC7SIdkZRa?=
 =?us-ascii?Q?us1mOoRsEuj5x28uc5ZXiBvZs6bqXCfvfnYSMA8mHNLdqm9VEn9D6ezKPBkh?=
 =?us-ascii?Q?r+tmpEby0Sc4wm6L5R6NQRaxY0BKrxzJ9ZKIH/g7VBc/bb/VMCqcu/g/InPQ?=
 =?us-ascii?Q?bzMtakKgu0VjDZPi/cqwcutmWyUPZKIIBP+Iz5CMlL2POZdy8opAe9qr5BZE?=
 =?us-ascii?Q?DcuVZMKLRqUzm4is328mfsCBRvGDTpi4lMqRoV344svfXrklhPJ3w386S/8Q?=
 =?us-ascii?Q?F1DQemkzV1B+bcD0GYtmAgaXJj3V/j7CwBMnC2enFx1S2nQ3a+3jZIz9Xzos?=
 =?us-ascii?Q?eE6Z0PBaJikMQ93TbQ4SxT0rrozZ6wQbeLbAIGpGBZSn15aT5NsO9eS1+VUe?=
 =?us-ascii?Q?KR+DcaIyKGkVIc1e51c/25iSw35KJeGGpDVToAURntnDypnx/cgwcZ9Fo/lm?=
 =?us-ascii?Q?Q4NQryplog+AewiTrZmvF8vli+IgNEmjts5dEVLlamppngCCdLKMV+EMjTkA?=
 =?us-ascii?Q?VUmdMSCt4oH1tDuwNRXygGQWxIuLsvPXpL1FcNS2LCM33Ck6phl/rYEuaokt?=
 =?us-ascii?Q?607qo+aidohTGyGNhnp9GpNYQ9nJWYH2qUw+Rrsuvq/LYsJ2hm5fABi/LG10?=
 =?us-ascii?Q?sJtMNp5/Z3sXDDcTZEZl7tSHbbiNgpKB469AFpPG6rUSHE+l07NZE8lZ9hGl?=
 =?us-ascii?Q?cKqtxjenyTiv4/L8U6OJ8c2CB8VOdjYJ26+n8q5syrsaB+gKzmBR+pekOAIX?=
 =?us-ascii?Q?BFiGfx5beFmxHjYKPisM9dZ4MY/8Nu0fSuYuIBCCznJrLtuLFPyAsxbIzv/i?=
 =?us-ascii?Q?vZ+0uIy0XKgYHisRHugnsiniNe3MOUtsB1pWud5AydQAiOmFkg7KIyGmUVD8?=
 =?us-ascii?Q?itIqyWkCAEKHESU2x74ih0SYL+jaVU9dSaHo6vSULcD1412esscIbnSq8Sqt?=
 =?us-ascii?Q?+pnkTAylmeRlNpKM287KMrPTWHp04XJx9desTOXL+SwkSsNKbRgb9OKw4RA1?=
 =?us-ascii?Q?G1D0QZ0yKv90dQs4cQtWsdQYiIFxqFX0ALm4CAStD1vJZRqZgJaxjw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:56:28.3235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 695fed9f-1cc6-4e83-266a-08dd865c7922
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8937
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why]
FAMS2 expects vmin/vmax to be updated in the case when freesync is
off, but supported. But we only update it when freesync is enabled.

[How]
Change the vsync handler such that dc_stream_adjust_vmin_vmax() its called
irrespective of whether freesync is enabled. If freesync is supported,
then there is no harm in updating vmin/vmax registers.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3546

Reviewed-by: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6cf02d2f536f..bd71f911e279 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -675,15 +675,21 @@ static void dm_crtc_high_irq(void *interrupt_params)
 	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
 
 	if (acrtc->dm_irq_params.stream &&
-	    acrtc->dm_irq_params.vrr_params.supported &&
-	    acrtc->dm_irq_params.freesync_config.state ==
-		    VRR_STATE_ACTIVE_VARIABLE) {
+		acrtc->dm_irq_params.vrr_params.supported) {
+		bool replay_en = acrtc->dm_irq_params.stream->link->replay_settings.replay_feature_enabled;
+		bool psr_en = acrtc->dm_irq_params.stream->link->psr_settings.psr_feature_enabled;
+		bool fs_active_var_en = acrtc->dm_irq_params.freesync_config.state == VRR_STATE_ACTIVE_VARIABLE;
+
 		mod_freesync_handle_v_update(adev->dm.freesync_module,
 					     acrtc->dm_irq_params.stream,
 					     &acrtc->dm_irq_params.vrr_params);
 
-		dc_stream_adjust_vmin_vmax(adev->dm.dc, acrtc->dm_irq_params.stream,
-					   &acrtc->dm_irq_params.vrr_params.adjust);
+		/* update vmin_vmax only if freesync is enabled, or only if PSR and REPLAY are disabled */
+		if (fs_active_var_en || (!fs_active_var_en && !replay_en && !psr_en)) {
+			dc_stream_adjust_vmin_vmax(adev->dm.dc,
+					acrtc->dm_irq_params.stream,
+					&acrtc->dm_irq_params.vrr_params.adjust);
+		}
 	}
 
 	/*
-- 
2.43.0

