Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EFCC4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:18:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EAA210EE2A;
	Wed,  1 May 2024 07:18:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jPxoE4Wm";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85D9E10EE2A
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:18:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JScXvfBr7mT4qjOjJTQ1tTWCp59l7J/61P3XDePdqyIBpfyMgodQ6E4XqKO7biXU6HPPKIZSrZbGSdDMH6q8/bm/j63uXtpz+KreGPRM5YpipxVlSHclrBcN0+EUOdE1XbQtWfzvzbmjKvcZ+/8YTBskIpQD1IeFjNTHY9OF4a5J5hFkxyrk3+bfaZMBRRYe2KsXKtIHQRO8+8AnD866GBM8YNAmkkNXP7Kdaq6DBh2ckAsEG77JIg+Cvxq6txrCsspRqKQeK7X+tPm26vIP9TTdw7ZLVvDOzI2AgGz1GJjOyyB0ETQQqdVyBS1lNdKNFPYzj6AQWZvZXHl/cQs1Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvsXp9F2wGooNggMI8RCYBjyQIb1e4BKP6gQ8nTmLig=;
 b=IF5hz0hXT2gKsAiAZqVTx9S9FIDmDm1Jlovq36g8O0THx1ckhE+dJ3q4wxAUXcrTJg/22+icrqkXTbVnXriOC42jKXx4GHs97JvZbPwPh8yrOuv1GFrEJ4VnsbuKthoZJ0ojoZeuui/zkWvQuSUN4XKNfkNeXQl4CFtKZvk5ZZ5EsOGdVVTiTAu6VO2XOQYNQ3a1Rf+Y53i5MPs2Q5BBPYzyxg6fFaxnpSfi1qH5tj9hCjMvY4sMeMdZIvb5p5lIpqonETr7tBpICRbgFMcaL5O7Mwhh4ODtItiPA+osMktlAC6cZfvhBOzoNvBjGW1YuvBbMUUyRHn6TkyXY1a7bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvsXp9F2wGooNggMI8RCYBjyQIb1e4BKP6gQ8nTmLig=;
 b=jPxoE4WmuSe7eaxDBoIdYxM2/YIip9PMn3iEEbAD+A6HrCBeg0/34vcPyFrZT9z0YnIDGSMhub3KAKBlb7xYKXXSDD8cbdeC55q83jaC4ITx5V4X+CruOWFhtsivFVZArGarZjAiOjFZNS7oJ1u9NRbSOjfMN9g7WLV/XzDMze4=
Received: from PH1PEPF000132F5.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::3a)
 by MW5PR12MB5599.namprd12.prod.outlook.com (2603:10b6:303:194::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 07:18:00 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2a01:111:f403:f90d::) by PH1PEPF000132F5.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Wed, 1 May 2024 07:18:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 07:18:00 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:17:59 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:17:51 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 11/45] drm/amd/display: Add NULL pointer and OVERRUN check
 within amdgpu_dm irq register
Date: Wed, 1 May 2024 15:16:17 +0800
Message-ID: <20240501071651.3541919-12-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|MW5PR12MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fa36841-f054-4103-9d11-08dc69aed52e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kfpCXmHNowzDUVlhZZklfJE+q4sfnOJetH/jgCoOqi9+pie4hAilWfRZicg/?=
 =?us-ascii?Q?Z6YlN5kqhEFG2ZxHul00X8KvgsdCaqAZkCJIk13qKQvVUIShhPEL38sClHR/?=
 =?us-ascii?Q?qZRHa6pi8klyCNSa6GAl6pCLWFATwja/DJ7x4+MZjnSYyJti7pWRkUyKbqBf?=
 =?us-ascii?Q?bzhl1T+FtRCpgOt1hQiFd9dnmONw+48It2tB6zOUDhm6uftWnP7rNao5IWRc?=
 =?us-ascii?Q?+oIssKg/9XLME69RcSrGE3XxDDFLaQS9ebScM3U1mxe6LmNALcNy/2H1qkDl?=
 =?us-ascii?Q?c5oK99HI66DXTRusIF9ALcE1Q3r9Zizf9feiwleZ+PVGx4hQW134sNY10z0S?=
 =?us-ascii?Q?5xlquEtCTdW+85kdV7+EOTP64RHIz6OD+Maswbk/8U3oYNcpOWG/C8jypW3O?=
 =?us-ascii?Q?lF6SDbHjlN7muoBTr5ituUp5UW9ptZDrWF4eeMRLK27IEX3Xy0YawcldkVxz?=
 =?us-ascii?Q?dvVEGTFTuWf9B6/gENATNE5LAklsRt//YN4vPTXcXlm16aHMiWL9OWhNMSDx?=
 =?us-ascii?Q?8e467YcfafHiLVgXphHzviJbkCw3KK+z1nEcGHa7B2dR0QYYYQCiBu4Uh6xC?=
 =?us-ascii?Q?9MWJJwW48uqy6dSM3aa/9PI4T0211nwKt8r8K5mvWysamGjZEJ/hSRi90riE?=
 =?us-ascii?Q?BEJaowchVSk+fb28pjFLGkgWryWRs+yqHSLJHekHP+Dflahn9MMlThK9R/Es?=
 =?us-ascii?Q?LZwSQnUSgKPx+Wj7TwbHVb+tr8GV0F8kmUXjk3iDVqUKBVefckkigum0wO3y?=
 =?us-ascii?Q?0bTcqsvughI5y9fsby+am7BHBplVybYl86NhEWkVc7Y8LPTSWTfzzIueeAR2?=
 =?us-ascii?Q?4rCEfJ5A0wrIShMHWtEwSK2/oWPFbS+Ux2GGagr+iie63NXgnlrN1flZfhgS?=
 =?us-ascii?Q?Q3aoqvxd6STBYjXMxCJ26jt2J41xISvoAe0QdsXtWlBsDJbN6o0uyMyf7HRo?=
 =?us-ascii?Q?L8tvTPNBhHjCpc7OafbY6tA3O2zXxB4lavGudKzl/tpCDE8RxV17IhPPbLOG?=
 =?us-ascii?Q?8A4QQvPNq4GpUqjWqmJZlkP2JuIJAncXVrLDzsxaUCUmIhgA9K0sTLsAhkVo?=
 =?us-ascii?Q?AoucfjzQ5xtZF1EQTtLjzL/F06JlWRVF7FquLBrgZQj/kWjfAFzaH/F276HV?=
 =?us-ascii?Q?uPYi4vFs5p0Km/fpGfQz5VNWT4SmcKy1uXNf36lbCXurNhJZYbZFbTPWdBjn?=
 =?us-ascii?Q?Aay5WMAkTAUS2lGiqg9y90EXIQWUnuIuUKuLMqZJv8IU+H4w2SCmxjn4pROM?=
 =?us-ascii?Q?k4uJOR/TVIpX7c60jWZZnHL/nGs5oOkrUcW8n1LFVdBpOIfV+l2GTDhieyiO?=
 =?us-ascii?Q?i++KcxtmxXTf9ZBE1OleQFaVMrozeq+10vSjZyh1EJ73bcINjo9bNrUDIkrA?=
 =?us-ascii?Q?3WYh180QvZ1aYeOM4PT+Mmv6/0HI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:18:00.0970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa36841-f054-4103-9d11-08dc69aed52e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5599
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

From: Hersen Wu <hersenxs.wu@amd.com>

[WHY]
Coverity reports OVERRUN issues within amdgpu_dm
interrupt registers. Do not check index value before
access array. Do not check NULL pointer.

[HOW]
Add index value check for array. Add check for
pointer from amdgpu_dm_irq_register_interrupt.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 169 +++++++++++++-----
 1 file changed, 128 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5d4716d7a55e..d922751995fc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3584,7 +3584,7 @@ static void handle_hpd_rx_irq(void *param)
 	mutex_unlock(&aconnector->hpd_lock);
 }
 
-static void register_hpd_handlers(struct amdgpu_device *adev)
+static int register_hpd_handlers(struct amdgpu_device *adev)
 {
 	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_connector *connector;
@@ -3596,11 +3596,17 @@ static void register_hpd_handlers(struct amdgpu_device *adev)
 	int_params.current_polarity = INTERRUPT_POLARITY_DEFAULT;
 
 	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
-		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD, dmub_hpd_callback, true))
+		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD,
+			dmub_hpd_callback, true)) {
 			DRM_ERROR("amdgpu: fail to register dmub hpd callback");
+			return -EINVAL;
+		}
 
-		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD_IRQ, dmub_hpd_callback, true))
+		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD_IRQ,
+			dmub_hpd_callback, true)) {
 			DRM_ERROR("amdgpu: fail to register dmub hpd callback");
+			return -EINVAL;
+		}
 	}
 
 	list_for_each_entry(connector,
@@ -3616,9 +3622,16 @@ static void register_hpd_handlers(struct amdgpu_device *adev)
 			int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
 			int_params.irq_source = dc_link->irq_source_hpd;
 
-			amdgpu_dm_irq_register_interrupt(adev, &int_params,
-					handle_hpd_irq,
-					(void *) aconnector);
+			if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
+				int_params.irq_source  < DC_IRQ_SOURCE_HPD1 ||
+				int_params.irq_source  > DC_IRQ_SOURCE_HPD6) {
+				DRM_ERROR("Failed to register hpd irq!\n");
+				return -EINVAL;
+			}
+
+			if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
+				handle_hpd_irq, (void *) aconnector))
+				return -ENOMEM;
 		}
 
 		if (dc_link->irq_source_hpd_rx != DC_IRQ_SOURCE_INVALID) {
@@ -3627,11 +3640,19 @@ static void register_hpd_handlers(struct amdgpu_device *adev)
 			int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
 			int_params.irq_source =	dc_link->irq_source_hpd_rx;
 
-			amdgpu_dm_irq_register_interrupt(adev, &int_params,
-					handle_hpd_rx_irq,
-					(void *) aconnector);
+			if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
+				int_params.irq_source  < DC_IRQ_SOURCE_HPD1RX ||
+				int_params.irq_source  > DC_IRQ_SOURCE_HPD6RX) {
+				DRM_ERROR("Failed to register hpd rx irq!\n");
+				return -EINVAL;
+			}
+
+			if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
+				handle_hpd_rx_irq, (void *) aconnector))
+				return -ENOMEM;
 		}
 	}
+	return 0;
 }
 
 #if defined(CONFIG_DRM_AMD_DC_SI)
@@ -3672,13 +3693,21 @@ static int dce60_register_irq_handlers(struct amdgpu_device *adev)
 		int_params.irq_source =
 			dc_interrupt_to_irq_source(dc, i + 1, 0);
 
+		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
+			int_params.irq_source  < DC_IRQ_SOURCE_VBLANK1 ||
+			int_params.irq_source  > DC_IRQ_SOURCE_VBLANK6) {
+			DRM_ERROR("Failed to register vblank irq!\n");
+			return -EINVAL;
+		}
+
 		c_irq_params = &adev->dm.vblank_params[int_params.irq_source - DC_IRQ_SOURCE_VBLANK1];
 
 		c_irq_params->adev = adev;
 		c_irq_params->irq_src = int_params.irq_source;
 
-		amdgpu_dm_irq_register_interrupt(adev, &int_params,
-				dm_crtc_high_irq, c_irq_params);
+		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
+			dm_crtc_high_irq, c_irq_params))
+			return -ENOMEM;
 	}
 
 	/* Use GRPH_PFLIP interrupt */
@@ -3694,14 +3723,21 @@ static int dce60_register_irq_handlers(struct amdgpu_device *adev)
 		int_params.irq_source =
 			dc_interrupt_to_irq_source(dc, i, 0);
 
+		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
+			int_params.irq_source  < DC_IRQ_SOURCE_PFLIP_FIRST ||
+			int_params.irq_source  > DC_IRQ_SOURCE_PFLIP_LAST) {
+			DRM_ERROR("Failed to register pflip irq!\n");
+			return -EINVAL;
+		}
+
 		c_irq_params = &adev->dm.pflip_params[int_params.irq_source - DC_IRQ_SOURCE_PFLIP_FIRST];
 
 		c_irq_params->adev = adev;
 		c_irq_params->irq_src = int_params.irq_source;
 
-		amdgpu_dm_irq_register_interrupt(adev, &int_params,
-				dm_pflip_high_irq, c_irq_params);
-
+		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
+			dm_pflip_high_irq, c_irq_params))
+			return -ENOMEM;
 	}
 
 	/* HPD */
@@ -3712,9 +3748,9 @@ static int dce60_register_irq_handlers(struct amdgpu_device *adev)
 		return r;
 	}
 
-	register_hpd_handlers(adev);
+	r = register_hpd_handlers(adev);
 
-	return 0;
+	return r;
 }
 #endif
 
@@ -3758,13 +3794,21 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 		int_params.irq_source =
 			dc_interrupt_to_irq_source(dc, i, 0);
 
+		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
+			int_params.irq_source  < DC_IRQ_SOURCE_VBLANK1 ||
+			int_params.irq_source  > DC_IRQ_SOURCE_VBLANK6) {
+			DRM_ERROR("Failed to register vblank irq!\n");
+			return -EINVAL;
+		}
+
 		c_irq_params = &adev->dm.vblank_params[int_params.irq_source - DC_IRQ_SOURCE_VBLANK1];
 
 		c_irq_params->adev = adev;
 		c_irq_params->irq_src = int_params.irq_source;
 
-		amdgpu_dm_irq_register_interrupt(adev, &int_params,
-				dm_crtc_high_irq, c_irq_params);
+		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
+			dm_crtc_high_irq, c_irq_params))
+			return -ENOMEM;
 	}
 
 	/* Use VUPDATE interrupt */
@@ -3779,13 +3823,21 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 		int_params.irq_source =
 			dc_interrupt_to_irq_source(dc, i, 0);
 
+		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
+			int_params.irq_source  < DC_IRQ_SOURCE_VUPDATE1 ||
+			int_params.irq_source  > DC_IRQ_SOURCE_VUPDATE6) {
+			DRM_ERROR("Failed to register vupdate irq!\n");
+			return -EINVAL;
+		}
+
 		c_irq_params = &adev->dm.vupdate_params[int_params.irq_source - DC_IRQ_SOURCE_VUPDATE1];
 
 		c_irq_params->adev = adev;
 		c_irq_params->irq_src = int_params.irq_source;
 
-		amdgpu_dm_irq_register_interrupt(adev, &int_params,
-				dm_vupdate_high_irq, c_irq_params);
+		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
+			dm_vupdate_high_irq, c_irq_params))
+			return -ENOMEM;
 	}
 
 	/* Use GRPH_PFLIP interrupt */
@@ -3801,14 +3853,21 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 		int_params.irq_source =
 			dc_interrupt_to_irq_source(dc, i, 0);
 
+		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
+			int_params.irq_source  < DC_IRQ_SOURCE_PFLIP_FIRST ||
+			int_params.irq_source  > DC_IRQ_SOURCE_PFLIP_LAST) {
+			DRM_ERROR("Failed to register pflip irq!\n");
+			return -EINVAL;
+		}
+
 		c_irq_params = &adev->dm.pflip_params[int_params.irq_source - DC_IRQ_SOURCE_PFLIP_FIRST];
 
 		c_irq_params->adev = adev;
 		c_irq_params->irq_src = int_params.irq_source;
 
-		amdgpu_dm_irq_register_interrupt(adev, &int_params,
-				dm_pflip_high_irq, c_irq_params);
-
+		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
+			dm_pflip_high_irq, c_irq_params))
+			return -ENOMEM;
 	}
 
 	/* HPD */
@@ -3819,9 +3878,9 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 		return r;
 	}
 
-	register_hpd_handlers(adev);
+	r = register_hpd_handlers(adev);
 
-	return 0;
+	return r;
 }
 
 /* Register IRQ sources and initialize IRQ callbacks */
@@ -3873,13 +3932,21 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 		int_params.irq_source =
 			dc_interrupt_to_irq_source(dc, i, 0);
 
+		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
+			int_params.irq_source  < DC_IRQ_SOURCE_VBLANK1 ||
+			int_params.irq_source  > DC_IRQ_SOURCE_VBLANK6) {
+			DRM_ERROR("Failed to register vblank irq!\n");
+			return -EINVAL;
+		}
+
 		c_irq_params = &adev->dm.vblank_params[int_params.irq_source - DC_IRQ_SOURCE_VBLANK1];
 
 		c_irq_params->adev = adev;
 		c_irq_params->irq_src = int_params.irq_source;
 
-		amdgpu_dm_irq_register_interrupt(
-			adev, &int_params, dm_crtc_high_irq, c_irq_params);
+		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
+			dm_crtc_high_irq, c_irq_params))
+			return -ENOMEM;
 	}
 
 	/* Use otg vertical line interrupt */
@@ -3897,9 +3964,11 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 		int_params.irq_source =
 			dc_interrupt_to_irq_source(dc, vrtl_int_srcid[i], 0);
 
-		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID) {
-			DRM_ERROR("Failed to register vline0 irq %d!\n", vrtl_int_srcid[i]);
-			break;
+		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
+			int_params.irq_source < DC_IRQ_SOURCE_DC1_VLINE0 ||
+			int_params.irq_source > DC_IRQ_SOURCE_DC6_VLINE0) {
+			DRM_ERROR("Failed to register vline0 irq!\n");
+			return -EINVAL;
 		}
 
 		c_irq_params = &adev->dm.vline0_params[int_params.irq_source
@@ -3908,8 +3977,10 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 		c_irq_params->adev = adev;
 		c_irq_params->irq_src = int_params.irq_source;
 
-		amdgpu_dm_irq_register_interrupt(adev, &int_params,
-				dm_dcn_vertical_interrupt0_high_irq, c_irq_params);
+		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
+			dm_dcn_vertical_interrupt0_high_irq,
+			c_irq_params))
+			return -ENOMEM;
 	}
 #endif
 
@@ -3932,13 +4003,21 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 		int_params.irq_source =
 			dc_interrupt_to_irq_source(dc, i, 0);
 
+		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
+			int_params.irq_source  < DC_IRQ_SOURCE_VUPDATE1 ||
+			int_params.irq_source  > DC_IRQ_SOURCE_VUPDATE6) {
+			DRM_ERROR("Failed to register vupdate irq!\n");
+			return -EINVAL;
+		}
+
 		c_irq_params = &adev->dm.vupdate_params[int_params.irq_source - DC_IRQ_SOURCE_VUPDATE1];
 
 		c_irq_params->adev = adev;
 		c_irq_params->irq_src = int_params.irq_source;
 
-		amdgpu_dm_irq_register_interrupt(adev, &int_params,
-				dm_vupdate_high_irq, c_irq_params);
+		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
+			dm_vupdate_high_irq, c_irq_params))
+			return -ENOMEM;
 	}
 
 	/* Use GRPH_PFLIP interrupt */
@@ -3955,14 +4034,21 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 		int_params.irq_source =
 			dc_interrupt_to_irq_source(dc, i, 0);
 
+		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
+			int_params.irq_source  < DC_IRQ_SOURCE_PFLIP_FIRST ||
+			int_params.irq_source  > DC_IRQ_SOURCE_PFLIP_LAST) {
+			DRM_ERROR("Failed to register pflip irq!\n");
+			return -EINVAL;
+		}
+
 		c_irq_params = &adev->dm.pflip_params[int_params.irq_source - DC_IRQ_SOURCE_PFLIP_FIRST];
 
 		c_irq_params->adev = adev;
 		c_irq_params->irq_src = int_params.irq_source;
 
-		amdgpu_dm_irq_register_interrupt(adev, &int_params,
-				dm_pflip_high_irq, c_irq_params);
-
+		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
+			dm_pflip_high_irq, c_irq_params))
+			return -ENOMEM;
 	}
 
 	/* HPD */
@@ -3973,9 +4059,9 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 		return r;
 	}
 
-	register_hpd_handlers(adev);
+	r = register_hpd_handlers(adev);
 
-	return 0;
+	return r;
 }
 /* Register Outbox IRQ sources and initialize IRQ callbacks */
 static int register_outbox_irq_handlers(struct amdgpu_device *adev)
@@ -4006,8 +4092,9 @@ static int register_outbox_irq_handlers(struct amdgpu_device *adev)
 		c_irq_params->adev = adev;
 		c_irq_params->irq_src = int_params.irq_source;
 
-		amdgpu_dm_irq_register_interrupt(adev, &int_params,
-				dm_dmub_outbox1_low_irq, c_irq_params);
+		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
+			dm_dmub_outbox1_low_irq, c_irq_params))
+			return -ENOMEM;
 	}
 
 	return 0;
-- 
2.34.1

