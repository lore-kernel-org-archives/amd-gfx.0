Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7E5C79F83
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F40510EA91;
	Mon, 31 Aug 2026 18:29:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vZCbOSOC";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012068.outbound.protection.outlook.com [52.101.43.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D580910EA67
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrNtSzX8O16bQjEH9QZA+Dwd2ihvlv4GvNuxpDt+VB+it02Gxu9xRbUY5jyUU9Ir4iBZScxRubJKyPjEmxuiuFOFwKKjdz5c4Fh+g6QGFG/FW5g5ew/pav7iv7Z/8BO/wdP35caROqaJm8p3FP472c+0dWZ6GEkKe0u6z4ZJxK8n+eZ6BX+IC5Tn//MRWz4/5S+nP94mbn25fSSlJ87sdjQCzy/QCji3r/RxdJmYjRDT0mwW0FYuFrU1R/Stp9hAqkgRXJwyQUT4Oq+Oyz4D0bCBsVXKoCxZx2B4BsYKnFoaTGs3+amLsyK2StyA9i6/fqwj66/A2bec0g3bHOOiQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfO1XJKJgJAzhJCjB5H0t0ghftvWFVrT8yTI2DE3zN4=;
 b=UUlqMxYyTLBBrCD7c+LOJxcl9ghi54OBxcvkcaRgkdpe94wNQMWsWggN2+ik6mfdF7OYLP7RHgjnsVjD1KOZuR7PzDN9+4eX8dl/cL7h+GOePeGACtFoBP5Udg61VODhyKLyu9fyfrDflxe9v3ZvO9SHX9K2Bn6wyAP6sIySjUJa6Xb+z67lM30qVxF8o8Zremogn6376T8uT3kWBrvxxDPSphq48UHvoOeR59PeNR8ZgQLIq/dalXY6VI2GoZFrEEqdH/W40HaqHuzrR5ZFUOOYGhwTDMb0wjo7MVXcHrVkB0FmJEPgpjcCDlhmmf2pKvCMJHRUoASHAYgdbffiHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfO1XJKJgJAzhJCjB5H0t0ghftvWFVrT8yTI2DE3zN4=;
 b=vZCbOSOCc7nzMY54JIsZqrvWdyq3WWdyexeiRDQnGdUklr7iK/dKDcECRJL9B08tUT/7mvDFOafPV4vnrCgiBeEaU/8ss7vcQWjrtx20Px2SUSl6AxZ4uqhfg6lCNSzTpxiWfXSSeeqS9va9pkJCViRsTjkTAaOpqZsSuUye2CI=
Received: from CH5P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::23)
 by SN7PR12MB7154.namprd12.prod.outlook.com (2603:10b6:806:2a5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:46 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::80) by CH5P220CA0024.outlook.office365.com
 (2603:10b6:610:1ef::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:46 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:34 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 45/95] drm/amdgpu: Control NPA DMA-buf importing
Date: Mon, 31 Aug 2026 14:27:04 -0400
Message-ID: <20260831182754.1089811-46-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|SN7PR12MB7154:EE_
X-MS-Office365-Filtering-Correlation-Id: ca3aef0f-dd27-476d-9ae4-08df078db1ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oIQU5bnxAmylvbicKXhyuocfZbR9q4YlsE51J7HlzW8NsAH/Y+b/AGu6pDdSGdPHwjSGBd6BThHmqgCEbCOj9GdinDJWvKBZpUSFRSxxGNc91dP+2fGUUNfft/HZ4hhpvjH8XmqZeO4rB6Mr9KC3+69dZ11g60ArlTYmjq/h3CsY1Ri26UcLMoYH0UnDM/KQtuUvOhx48RoQ9+mj/RY6Kal4P50lwGmEkZNeznrn3u3fIPh7ieXBx0UB/FdJT5cUO/DKykGZgSviVOPnnH03IkbCXLDmX85ZoQ2pvdGNc1k/QWXQWcOpEa3JGI99QZqe/eqfY1mow6ea3en7uRWKMiG0L1uKzXDHRg1+eZr2EUVIarKQx1CeX8NO0e3aCQRgIBw3biiX55tP9E0X9rISP7+E0lK10G8vgufWReU9R97gEjKD3bYWhjF1QdpGZED0z8T+uVO2b/SkBGLSVmCwbCsH9iaxZGSujkj+x5RF5p7MIZui7aOrrvI9ZSvgLONR3uEbUq5JzA06Idj8tUtghn5CZhaT+nBdZths6lagIxTa/4NL/9Lfn41p7xzMBktIK2qVCAMJUqY3IDDXI+MvVk18hC8ZlJtPCE7T9zoKTgdwmKrsmQ0sSmFLOGb3XO2AkPhdH8hC7Cj4ChyPdZjAzdRqIt3lbej4DkpEejNKK6wpRyb6X4/pj1JJDRFp5DXYuRAJL24xSrs5VPgAIV6CCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x1RZRg7rNgFE2C1B5cW/czv+3KlSQtPbOOgM8dm8otV68OIQLRPwiaI+c0ZtPD/f2mYp7yBXdfgZwVxeunm5FsDtOxOCA2rwKLNkOR85rgp9YcaUH4PauDVmbxEDeOYliK+s8wuAJBHP+axJsoRNB+SSXK75lui9ZVdhkzgZXzI1bqi2ub1gKN/mTm+L65LDUzuYVg7nyXXHPPdovf2IKUWho/5JuIVbsFyEu1HyuvwH45qf1x7nXAUycAkLnj1CAEkhQ7RyeHd6wv6L0iXMWoZYkV+GmOEtqNfTE/SJYn5tDhLkNloVrvC/Zyoqa23Q6SaI/Pd2g25ZoiMI2+cQP7TOIrh8lkQAEUsJuRT6vQoEoYyTZnswea0UmXr4yyc5xZjL5FXxjfZQ5sKDryBGBTyK7Rm2i5+4Jno9AOObfxomixXSNhAsEX1OMEwbvytR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:46.6368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3aef0f-dd27-476d-9ae4-08df078db1ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7154
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

From: Mukul Joshi <mukul.joshi@amd.com>

NPA DMA-Bufs can only be imported on the same device as the
original BO. In source-identification mode NPA addresses are
importer-specific. Each GPU needs to import the UALink handle
by themselves. Sharing the NPA addresses between devices is
meaningless and potentially dangerous. Put controls to ensure
this is not violated.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index b33c300e26e2e..b4fbd8a407f15 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -558,6 +558,11 @@ struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
 			 */
 			drm_gem_object_get(obj);
 			return obj;
+		} else {
+			struct ttm_resource *mem = gem_to_amdgpu_bo(obj)->tbo.resource;
+			/* NPA DMA-buf can only be imported on the same device. */
+			if (mem && mem->mem_type == AMDGPU_PL_NPA)
+				return ERR_PTR(-EPERM);
 		}
 	}
 
-- 
2.55.0

