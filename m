Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5800FFCB61A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 15:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6D5510ED67;
	Fri,  6 Mar 2026 15:40:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c7depwBe";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29D7F10ED62
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 15:40:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+4oYJy4Hg+/NwKNO6NuYtPxifGSof3SO689EPKI9oiD/nm2HoUNWdhB03IJarEyGVHC6bBW09n5QmWjwL630O8k5ZAW/Rg1Yfdv2qNspejtOmWjxvFSX2AcnjWPAKDmVTY20hrRoH2bAkFHEUJ0CYPoZHts+q2/WUOrB0NM/Iemb3fcYGGnMGSVTHZzjXfZGD28EPnqZcMh4iNr2LMylDX7z6OMY6VhRrPYY5jSj3Hqwoyzw1M3CXeSnirnjJhz7+7sZ8hvjr38QSjRl6r4HWK+hPJlLeMN7BSVVZqolYSWPL8duCXRXQTjFsGsdO2sbHjSFiFAzQJBS7DhRbs9WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGB9Ki9YcOJdbrUvHuJ5V7q/SysC+Z0l+5JeykdelSY=;
 b=m9W17Jpa0BYBhRMP6cIEw4o7R6COlmwXSc1ghtG3mtObcqZOvBFrqNMwJy+mSeOvE9hJo5MZpCKSqyehVpyQ48XQkwXI5kPyl+5qLVCv1ZAhdvh1ZyvgQWWQq7mmHQDOYC9dfG770SVWylU/dZPbrnwQslb9GnokqBPRXGaUBHGz6UAKmZPx55cRuO6JneOz3+daieyBu90sVvZsEA/BCOqj+2qCc+VzXifBewl9F9FCH/CaGjN5SlyouuFguCeRihSfDtnJFhfX1oJ3hgoWfGDSA8FVhJwHCutwnr0VMtiCPAy882DrfK/CCUWExqsNP+I596ea/ABi71yQOZtDDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGB9Ki9YcOJdbrUvHuJ5V7q/SysC+Z0l+5JeykdelSY=;
 b=c7depwBech2y8N+048YHWcMkQS6kCrtRTg7VGwf8Ro6v0ZPL12UMdKckVimf9U26Jj555ims5HJTJZ1q9uo1Ot1UZx0/IbSxUAFnWOdUWkFXrKsftz2j3oHIA33arhX5zRxcJF94Bj+qHrwY068wAMQ4+XEmgVfY3CCJhPifHtc=
Received: from CH3P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::19)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.6; Fri, 6 Mar
 2026 15:40:27 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::1a) by CH3P220CA0008.outlook.office365.com
 (2603:10b6:610:1e8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend
 Transport; Fri, 6 Mar 2026 15:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 15:40:27 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 6 Mar
 2026 09:40:24 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Mar
 2026 09:40:24 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 09:40:23 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: change sdma doorbell size for soc v1
Date: Fri, 6 Mar 2026 10:40:09 -0500
Message-ID: <20260306154012.22525-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306154012.22525-1-alexander.deucher@amd.com>
References: <20260306154012.22525-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 22145fe6-74b8-4d3d-2ee2-08de7b96b0b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: Ixi5LwIwsS22gnVUfo7mLh2s15p2HbA2cGJE+WXts5ZwasAP0ZyX9utdn4hGBhFw9swodqgHTyeR4G9KoBE1SOMdsnk/FKgly0CzvtuIV9b0GhzYbvFJr/6LazDtxMNxppc9cn0AtOe6z3u1ciJ6Tqjg8aQHikryB0n12FaQhfPmeaj3ho0WBBm8wxNw1118KWbWccZwq9RpAkRuETtGcaefEcV21cOLCUcuI4smJTMXwAFgDLp+TU+eugqmuMwLoAkvWfEurNFqvj/HSPK+Bi1rl3naicwbz0Dkl14obFR4PbmhMLPCGEPPnM5zSnAER7Whzz7nWX2xRfxERs/wC5uIG4BlE5jUQRUQwQl1zhi3H2OHB8haWqQ12Huih7XfPimVO6NkJOLb1NSTZhcG70hsr/ATkfOcOHdQiVhXoRt18SZAZNnPHj0jys6j0RPLUJQRFA198iM1nS0fvnfwEByHbbwuAFvqjBfoouXpWAekmzdwvuO6D4ndK+yvyRsSmiWrLP9IDhkhhfgZtQW18/HDedtt2Z5yFLcj77+mEbb9VJ09LCVYlFmJlGjrDBGACqbHS/Q/A9teAOSuFxuq3a02qbZkvRmd/h/jUXTpdyRnK7QfHE4jqsqi1jlOwPaqTbwfKt9gVD+xZxPXGr64eVVXzLj+KV+EAARJkKYJXh3tl5eaGrVq0PvWayhoT31BV1/KwEVi97eo2X2tujVgJFFQNjZON/rj9yZhvcXOFns3BZqNEniXvJmTpv98CSo4MMWzruMXonw8np3mQ/JoeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /vtb+WPQDNP+4Nsx7eObPUW+1Jd4x+EDpU+byxXiH4lGa6Le8hI5wo8UVCrjkDeispwnXfKMeZeHdp/KJO/bV0R4yK6ww3Q2A4U8IFc2dW0JIga+ttHYTq5zwl668x0FfcuvSDMur/3iJjVZ4CpYAFksf7g877SujKq/T1sP8ON5sfcA9oNQrIwHnXKHLBbct0gYnTho1sXKlU7y1XOrCWqbUYKA8trX7uMUgOr8kzBRg7wN9ns5JrxQSRtOtbirbfeIhp6gGnofFeCqxj5ZAZ50NGZJIgt0vB+TnFotL2cVBpMsCtyo5QMSfRBQggVOUDwE4mY5+5OTb9dzDee1Cghjp2cXy4yx3QFYekmFbKdTSOaUE0HbZwhTKcykI/Ajbm1Ond85linPEXi4t0gLeGEnpqdZgyzIZNk++ABV9RtMQgKwDM5650gCGjFcP7I5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:40:27.2551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22145fe6-74b8-4d3d-2ee2-08de7b96b0b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725
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

From: Likun Gao <Likun.Gao@amd.com>

Change SDMA doorbel size to 14 per SDMA engine.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 90a69ef41c4b0..0c7759b82fa63 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -57,7 +57,7 @@ static void soc_v1_0_doorbell_index_init(struct amdgpu_device *adev)
 	adev->doorbell_index.userqueue_end = AMDGPU_SOC_V1_0_DOORBELL_USERQUEUE_END;
 	adev->doorbell_index.xcc_doorbell_range = AMDGPU_SOC_V1_0_DOORBELL_XCC_RANGE;
 
-	adev->doorbell_index.sdma_doorbell_range = 20;
+	adev->doorbell_index.sdma_doorbell_range = 14;
 	for (i = 0; i < adev->sdma.num_instances; i++)
 		adev->doorbell_index.sdma_engine[i] =
 			AMDGPU_SOC_V1_0_DOORBELL_sDMA_ENGINE_START +
-- 
2.53.0

