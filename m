Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE34AC43458
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 20:41:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FA0610E3F2;
	Fri, 26 Jun 2026 20:41:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VRbWNdBA";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EC6C10E3F2
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 20:41:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsDkTmfURTRq16Sj/xTWzY4xTt/8YsCDt10nx2z5VGlMTYqL50NvibiGyUfSeZxwrKtfDS0ZjB0CrKSYlkp+50lriuterjntNVWDx9HyGfduHKFHv1z5J97D/rdYgcHEVEPubKLTgEPonxJ8/7f7LH+mLMJ6+ePZNcXTHl0VX2Biye7Wqt3BZ/HKPE3yS9aVk4Xglp0XIi9sWAFBCY+8oWteXVSTf+i/66ck/xHlliGth/er3NlLBvk4xLNt3ojY1EwDmuB7zsxpxQF3Fe0+fxL6+d3yX1UBVcorWKraye5TWn/DO4l2m9i//oZPwpa2HxTptwkOHjy4nTB5GSBqnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2O3T678jWauar3lyjR57O/DXSmks1i9r/iu4vr6Gic=;
 b=GfKyXDj9vo+bOt7bEz5G1AADT9W/NqEK9Yjo3Ib8w78Id/TMNgneciJnd9OS/kxNrftAL4KFRUmTlPBURjdTStwNbSNMoahhXiDzQmvBOvroCOn1AYQrgovtizolui2Il8wXcTweUzWdS+tDw5t21hb7FtS/XK/qWFkVaaRqVr1ChNnoCG78Q6DpG3OFSdVyRzoEX6Q9jxz3oE12OSqJT6RdbEuK9iUEpkEG08Xm6bZQeonCWJlp3qgIFg9puuEoXqGOoScewA7nNqH1qATUZ1xDxtwI0QibTaIYx4guRVogY0JEOUMxY1BCgy6H8+B0oIJZL9KoAbywJ4lPenA/xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2O3T678jWauar3lyjR57O/DXSmks1i9r/iu4vr6Gic=;
 b=VRbWNdBA8Rlttd6clSfFf6R/yRNRq07yma0YXIxByCWJJ4yg1Znn4KFtd2Z2TRqdTeiU6Ea/wOv2XT/0cCOgX4b2lohjMsKkOnRQmLrvKkUMzxdPkck8WKtl3t9K8zBZUipUo0axLQ30RTVVZDi3zLICf5HpMpw1VFTTBt7F/9Y=
Received: from CH0P221CA0040.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::20)
 by DM4PR12MB5722.namprd12.prod.outlook.com (2603:10b6:8:5d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Fri, 26 Jun
 2026 20:41:14 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::15) by CH0P221CA0040.outlook.office365.com
 (2603:10b6:610:11d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Fri,
 26 Jun 2026 20:41:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 26 Jun 2026 20:41:14 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 15:41:09 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 26 Jun 2026 15:41:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/gfx11: Program DB_RING_CONTROL
Date: Fri, 26 Jun 2026 16:40:59 -0400
Message-ID: <20260626204101.31172-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626204101.31172-1-alexander.deucher@amd.com>
References: <20260626204101.31172-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|DM4PR12MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: 02aeec92-41b7-4232-f6a2-08ded3c343b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tYhwUZm8VfcX6GOdeVzZoAr3dCGUDBjpiZU5C4c7ZefKLqGNVZg5w4v14cc5XtiBkXovMgn1LV1e6W7KGK/rXhlxfDTRnkM+NJ8zESmvrRXwSxjo6NKeg2TuFOH0bp4hSJXy7c2U6DOEIcMmdar+8ls15HTfh4WUD7Bmgz7YEEzabEXn2Htp4CZ2ymDVGA8B3/2eJ9dTtzG9Rrrz4SEPYWT6x4sHeiCzNeeBh2oR/OGOE72da2aL4c0VAEk3ZD6GdUwtWNNWZRjbI+8hSEI098NpLCunOiVE1cGWuNXpTKwP1Lckna8d34fWmERzDDF4xkCrjFakVK8g2GD7eyLDG3OzKK0uDTRo9jyuPFWOGwY91ck8ocyBUD67SUcRvipEqyPtai5NBCh4gtW3wpM8jltU6QAPn0DcNCrKo1UtDgRON3pnXXJE8eOCumoJc+5nm5+DKAjD28Bq37BDSBH++1K+d5/iWIlAUfVf0VSHiyKdDLpixg7Lsa2ZRrQbA0kLQZlyw4nAuVQzpBLi1A15ibSuiLQXZV/Ruq1yqL1v/aMiUoosMWN+n5spmC5Z8bfP5k0VVKUWz1XcVL+EpaBYSEGqmctOIJ3fZFiC5UOizrGYfCUnHe2tPrjPt78EXE8bazyIxEJHWw5p4Xg48Qzggv6W3yg6slurZvFm02ZxA/MDPM6UF9SXOh/OxDLbllJvjB5kjvCQiIDl2QIEmYvMMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SFXr9K1HgsA3bhUwd1AXiFN1yT88WMNu37mcHwhW7O4ApbzZurbgvtcg9YrH96oeF9ruiW5vNrK9LiEWl+9IqorZn2HicDVkG+aUIRxJIDdpW0AYrV900S5wJildcUAEgDEYbHR1cx0OoOw7uKntk/8quHJPKZuQlbaii7qrGl7wwtRD3lghC9BV9+qcTEV17DcAyg2MrD6eP4BxfNbDR0pgeYcAX2SVeHNmzOAxZyYT3QGV9lALBJL1IqSFQlpF2vmF4ylUs0X7dYH4gM1u7/CSwxwREbvW5uuKzecFfTa2FxSZVvUmM0d2/sZ340yCTGBsnH1tqWefQKJKEOV45TBxT8hEC7htP5bIZbLaoJ/Y/GYuf92vtVivzqsZ+BOIhF0smExorVWrYHnHLYBZf5vAlQT2hA0HjRtRFOQCjOm3GcU1EkiQFc0LTYrl9e2q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 20:41:14.0965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02aeec92-41b7-4232-f6a2-08ded3c343b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5722
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

This is needed to allocate occlusion counters across
both gfx pipes. No functional change since we only
use one gfx pipe at the moment (default value is 1).

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index d171d41654980..5e7d0cd85c365 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -2178,6 +2178,9 @@ static void gfx_v11_0_constants_init(struct amdgpu_device *adev)
 	tmp = RREG32_SOC15(GC, 0, regTA_CNTL2);
 	adev->gfx.config.ta_cntl2_truncate_coord_mode =
 		REG_GET_FIELD(tmp, TA_CNTL2, TRUNCATE_COORD_MODE);
+	/* program DB_RING_CONTROL for multiple GFX pipes */
+	WREG32_FIELD15_PREREG(GC, 0, DB_RING_CONTROL, COUNTER_CONTROL,
+			      (adev->gfx.me.num_pipe_per_me > 1) ? 0 : 1);
 
 	/* XXX SH_MEM regs */
 	/* where to put LDS, scratch, GPUVM in FSA64 space */
-- 
2.54.0

