Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DD1CCF2C1
	for <amd-gfx@archiver.kernel.org>; Sat, 17 Oct 2026 15:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 223E910E096;
	Sat, 17 Oct 2026 15:59:26 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011050.outbound.protection.outlook.com [52.101.52.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFB8A10E096
 for <amd-gfx@lists.freedesktop.org>; Sat, 17 Oct 2026 15:59:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZK1sTQRZWiUC5/hbaSBilFG0fs3RVnpkJX9FNVts0eaMJODR/JZocDI7KJQXr+3eBpEHxyJpcthV42MINeMIC7nw4sETDVYAnyXsiAXVwd9yjwGrvlF54lIz3RXLuLEvy5+sLGfSY6SAi55mY7wMfURJKPirFw0jaWUol2NdftH4ocsezemeHPoU3h+HIwncIUGkMHq8w7MjPbDUuD5H4ZnEQX12iFsnacoM+bKUb8ytLe7tnCDgcBwPC9dFaHrdgBfUEHmprrWZZB8c8FyfTVby0jkZE7hLWCyVZQMnVlEvxAE/Dm+NxefQvSQK/N3G8zH4gaS38crqgY2BUD2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNtbVxhlFRcr/9GUI37MZHI01er/P7DumJ9aCayqpzY=;
 b=rgmQAlFsfzEtlZbGyv7Zi4DPAlFvWr/mN9rL11ETtmGH5NLewgEkBS5GPp9x7r53PIP009G98SdMM2hBbDe4FQHoyyoAYIwu4Qya2ZCtmBxFhELGGU/AJHVivLrHYxkA2Rw5BpphFgtkVwDbvGz1oltHm3cd557Aag8GckvT15GpxBROQsWmlZqhhZIHbv7/167BWEFQBAZXHIaxafU91JSIxghpgKgHyWvYCNJ39chKAiD54QcuFYAoMlC+OZc4qKDgyIYzbpWmoxC65fcg1lSk0BWB4UH4KSnalw4Nsti228iATHfD5cFQNEje5jeYVkqkHD8I3BH9ATpdL1OY6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNtbVxhlFRcr/9GUI37MZHI01er/P7DumJ9aCayqpzY=;
 b=Tc8bLVha4+qezeCK05ulpK3GmDkKxpTgx6/3CnaLPxacDT1mURIgRKA7wGz4+2GWj7A6Pdgo4Ntd5kzeCFhxWZ6bzImEZcmB5rG65iJoc8ZyhZoh3BGy+EXjLD9C0SGB//lowKwhWJg7tEDnWzHWZOPyRNuDm2aqqH0GBa1EKug=
Received: from BN0PR02CA0019.namprd02.prod.outlook.com (2603:10b6:408:e4::24)
 by CH3PR12MB9124.namprd12.prod.outlook.com (2603:10b6:610:1a7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Sat, 17 Oct
 2026 15:59:16 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:408:e4:cafe::3e) by BN0PR02CA0019.outlook.office365.com
 (2603:10b6:408:e4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Sat,
 17 Oct 2026 15:59:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Sat, 17 Oct 2026 15:59:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sat, 17 Oct
 2026 10:59:08 -0500
Received: from drvdevbldsrv2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sat, 17 Oct 2026 10:59:01 -0500
From: Raghavendra Prasad Mallela <raghavendraprasad.mallela@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 <Wayne.Lin@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Yu.Wang4@amd.com>, <RaghavendraPrasad.Mallela@amd.com>,
 <Pavan.Ramayanam@amd.com>, Raghavendra Prasad Mallela
 <raghavendraprasad.mallela@amd.com>
Subject: [PATCH] drm/amd/display: restore vblank state across GPU reset
Date: Sat, 17 Oct 2026 21:29:07 +0530
Message-ID: <20261017155907.1243691-1-raghavendraprasad.mallela@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|CH3PR12MB9124:EE_
X-MS-Office365-Filtering-Correlation-Id: b3cc680b-1d8f-4cb1-5c87-08df2c67982d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|10067099003|18002099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: yD0f1UvCPy54EIAIS9LEt1uvSJ9UQLNk95/RaemBHbsFDDQ9hsaG5Q0xxaF3JaWd0pcFJZeMU1L4Sm5pUX6t6DApHoWTWKsnIVNBbN/FwpsYVAHQPRluBdXHY0xntsuSiMTLyqACO8nVOBPQTJdBezJHQR1fNMJFnMudQaA9d3ssj4413pLspqIIsFU0HVqvwwotwGpM3pHcNGTUlypJbCnZqMUxNJaGnv+x5ddBE/frbjC/ikYJHpDC6A+VJ25pfqAd30y4MHIjzlPFn6lPHDk6Tj/lOAz440PTVzFKOH3Z2vm7XTQmr5jHClAkiPkDJ4tge+4BLaw8aQA7VmcQ7CyT/IuiM5EfEJq38vEdJ3RyBO02ZewhFipbl45uK9TFJU84gYvcIokxddxL0FErVJjP9qVw0HZgOHRBC2f34MJqEPLGCIE89Ea8oT246sfgrDkZJkORzHJBGv4duZOqmWGCNxxuHkJGBD3ZUys7W5F93BO2zbnphoO7ZUY+D3ivp8eag6wQpfaoFpkTewEpFtv/E+k1ll6HS8ySrPQmL0p89OMgoTsCxHwSGK/+iS3y2+keLa/VKwE6XJwt5a46oHt56WVdVwcS4yAHaciz9qaQBQoQ7ppRVDCWXo0vxsfrziarsQ5EESU1QAwYIHu/exjbKhngpa4t4b/3J6sxi3INC8u7ognRb3scdMiQoXEVh1/P+i32AyVvHccoxXR7KA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(10067099003)(18002099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FmXdBI8NDJeK1SHVld3JG3EvKKIli6cXEUDQ7aysIQnnZlk9onxtpZwh5bCpuJtzdmxHFfq2iX1svXv6Wkfl7bjwDpLlOnEgnL8PX5E90dsL1GChsA/Cdxw1JN8r7rz/q+8qZbej3G9wDIYixjTHB1u01ReIGqYr21giScdrHW61EI+rD+Kjg9hqLFRxKNuABuZ280Xt+EoBvoKQO2nEfUaezgnt92PnXyMqsEG/ZLNE+HNzir9uRikLGQ16VKp/bm1Ry07MGf5Y5YkuQsrHKpeIYtlvkldn4PVvCppyfGvT69T7An/IFwg7V+flNeZ6ymPka2ASl+6HT1NosXTMZo9p7TXf16/V8Dx8L3TL9hqhUCccd1n9YaJ10GItVWAffZIOx2ojmn+xmnFcVZw8TN03pGwZ1XfqX5I+wgzMm/IgHroKAs5ZZHKmX8PTmqVZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 15:59:15.5901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3cc680b-1d8f-4cb1-5c87-08df2c67982d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9124
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

[Why]
GPU reset disables the OTG and restarts the hardware frame counter. DRM
framework expects to be informed when the hardware frame counter changes
Without informing DRM, the last vblank value holds the last pre- reset
value causing the vblanck sequence jumps by a 24-bit wrap when display
comes up. This causes the page flip operations to timeout during GPU
reset because of the DRM vblank counter not reset.

[How]
Call drm_crtc_vblank_off() during suspend before streams tearing down,
and drm_crtc_vblank_on_config() in resume after they are restored which
helps DRM rebases onto the new hardware counter. Timestamping constants
need to restored before vblank_on, since vblank_off clears them.

Co-authored-by: Hemalatha Pinnamreddy <hemalatha.pinnamreddy2@amd.com>
Signed-off-by: Raghavendra Prasad Mallela <raghavendraprasad.mallela@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 36 +++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 47a0ff2ed035..ef4e082182df 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1414,12 +1414,16 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 	struct amdgpu_crtc *acrtc;
 	int rc = -EBUSY;
 	int i = 0;
+	struct drm_display_mode hwmode;
 
 	for (i = 0; i < state->stream_count; i++) {
 		acrtc = amdgpu_dm_get_crtc_by_otg_inst(
 				adev, state->stream_status[i].primary_otg_inst);
 
-		if (acrtc && state->stream_status[i].plane_count != 0 &&
+		if(!acrtc)
+			continue;
+
+		if (state->stream_status[i].plane_count != 0 &&
 		    amdgpu_ip_version(adev, DCE_HWIP, 0) == 0) {
 			irq_source = IRQ_TYPE_PFLIP + acrtc->otg_inst;
 			rc = amdgpu_dm_irq_set(adev, irq_source, enable) ? 0 : -EBUSY;
@@ -1449,13 +1453,41 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 			if (!amdgpu_dm_irq_set(adev, irq_source, enable))
 				drm_warn(adev_to_drm(adev), "Failed to %sable vblank interrupt\n", enable ? "en" : "dis");
 
-		} else if (acrtc && state->stream_status[i].plane_count != 0) {
+		} else if (state->stream_status[i].plane_count != 0) {
 			/* DCN only needs to toggle VUPDATE_NO_LOCK */
 			rc = amdgpu_dm_crtc_set_vupdate_irq(&acrtc->base, enable);
 			if (rc)
 				drm_warn(adev_to_drm(adev), "Failed to %sable vupdate interrupt\n",
 					 enable ? "en" : "dis");
 		}
+		/* During GPU reset, all the active streams are removed and disable the
+		 * OPTC timing genrator and resets the HW vsync counter. If HW Vsync
+		 * counter resets to 0, drm expects the SW vsync counter to be reset.
+		 */
+		if (enable) {
+			const struct drm_vblank_crtc_config config = drm_crtc_vblank_crtc(&acrtc->base)->config;
+			/*
+			 * drm_crtc_vblank_off() leaves the per-CRTC config in
+			 * place. drm_crtc_vblank_on() would replace it with the
+			 * device defaults, so put the cached config back.
+			 */
+			drm_calc_timestamping_constants(
+					&acrtc->base,
+					&acrtc->base.state->adjusted_mode);
+			drm_crtc_vblank_on_config(&acrtc->base, &config);
+		}
+		else {
+			drm_mode_init(&hwmode, &drm_crtc_vblank_crtc(&acrtc->base)->hwmode);
+			drm_crtc_vblank_off(&acrtc->base);
+			/*
+			 * drm_crtc_vblank_off() invalidates only crtc_clock in the
+			 * cached hwmode, but the CRTC state stays active across the
+			 * reset and comes back with the same mode. Restore the
+			 * timings so a commit racing the reset does not warn.
+			 */
+			if (hwmode.crtc_clock)
+				drm_calc_timestamping_constants(&acrtc->base, &hwmode);
+		}
 	}
 
 }
-- 
2.17.1

