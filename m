Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CC8CC6B1D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 11:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38C9A10E9B4;
	Wed, 14 Oct 2026 11:39:27 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0116B10E9B4
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 11:39:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXusz7+vhhza5WR1UcBEoRhcn/Z73fy/fhSFscX8pWQc2m97OrTK04lMaRSP/cs4WVvgc1qZSwK6pPP5EY16fviBSDzd+sDS2Y24rP3cp5LZhYMWyDwvRLd6mJJwCGweWOgiHRKEklF0PHxcNhMclqH6eGxvPrKIIwdHKBOO9ko3Lr1CW5O7aDzQ+UBxHfgq5GC8vcKunWJ5lgNZQ9Z/BDNdzLH7qkhMkb7PYn4u6l+ijOS6amp6Y9951vH8HAgIbJe+bytVwFMaM6K9FOBfBIZ4gxXNp8E81+QYqZxEEWyBhv8DPU9SONCJcB3DzOkUbGf+H1v0j28WCFcb4PLw1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSEI0L3+moLYVSr3z+gzFNH/+U1p5LeiaxnbvA5GKdg=;
 b=smQX3Ro4MiVnsT4Azmn6sqnfPc+Jkz6vZRqWcD4ygcZgrqQEie9CEvHh+oyv4HZsi1j0Zqqy0T3oVPWT5IaMjNj5REASTmkWkWE3+uUaJDroDFxKIzRpGRZjdXbHPMswuKt5lvsHjeCNvZ7iA+PJx3mKkhEfTqBpI27HeATOiwXbfCSYNCZL8rEc65N8HfCnc6WM18kOywjYbTvZkTrdWBMSdFGmoq4VP6UAxiFX+J+pphkdZ2zuo+QrheCk+1KeWXGapiavn8wzN6FajBLfcarQ3mXp+TPHNWkA0/2nxDyRy8Uubdy0hDSxwFbYXXyPlLsDwcIsw3GXTDyEzb1znQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSEI0L3+moLYVSr3z+gzFNH/+U1p5LeiaxnbvA5GKdg=;
 b=cwQuPx+j++ajkBd75IJrWE4d+W5b/xZVn7wyWsVEOe+2Xy+yY1phFxJtTxEIQxrwASZrhby0zHIU2UYD4IYv15Te/qLqn9IN4ZGMRjY7uWqRHv0ns+qK3zpuYqn0MrdU8GVcJIoVUH26h7/+keSZbhkqLtkSDa1myj2lcEGIq4o=
Received: from BN0PR04CA0176.namprd04.prod.outlook.com (2603:10b6:408:eb::31)
 by DS2PR12MB285917.namprd12.prod.outlook.com (2603:10b6:8:401::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 11:39:16 +0000
Received: from BN3PEPF00022BCB.namprd03.prod.outlook.com
 (2603:10b6:408:eb:cafe::66) by BN0PR04CA0176.outlook.office365.com
 (2603:10b6:408:eb::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 14
 Oct 2026 11:39:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BCB.mail.protection.outlook.com (10.167.248.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 11:39:16 +0000
Received: from stanley-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 06:39:07 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <YiPeng.Chai@amd.com>,
 <Candice.Li@amd.com>, <Xiang.Liu@amd.com>, <Ce.Sun@amd.com>,
 <Gangliang.Xie@amd.com>, Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amd/ras: Fix APU platform ras block feature
 mask
Date: Wed, 14 Oct 2026 19:38:58 +0800
Message-ID: <20261014113858.289753-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BCB:EE_|DS2PR12MB285917:EE_
X-MS-Office365-Filtering-Correlation-Id: ec053154-b40a-4caa-ebf7-08df29e7c731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: lrUAjh4aRf8OlLJ+Wr9JOBj9W+zqVCZVghvsYaOgN5Wh8zd568xEZxchXk2K+gVwMTVjMlsv19/9uEFghsmN+JxauiFdJcgDklCLC8iv9FIqHC3TKP0cxGYNOp+SIAofs5zxLgw85jbxnE+a7lfoC5B+IZM+qNMdbzPFGWkB3YkBjwFRbAAEVopmipmqL9GePRoUo/VDMqzReUxAyawzknIre4Kpy2oV44/eOYbaxYuhNJbBqMrR+UYyLCr+VsB2zKCD3nXkhzvLd2VZ+hR7MvbzMSnNiomB8kWxN5WeeyBGswz/nXargRvuHTwhdbx9R/TULulweQskAzRal9eCn0eZAAWfzYaOJHwjlmD7+KCbeQR5+IDc+Fv4PjglipNUnUtVJJc/q/+cev5cHKsCTR8PCD0NVpgBEVRUuBD8DF8Gty9nq9k+NjbWa5OualPYecBV0XM3tfnrB7HoCn+g8vPHoSz9pfvttL9xjWoGOC7IKw6q/94eKT+6Qmv5DcouBsioowxdU4fKKn+6E19qPiPoQ1w5a4/6h1lKYRHMLq7Bc88uXRQ58E8GWFyAQ5KE4Q5gbP8q1y8PNQdc0FYRw06Lqll5GtS87CEAutrpeiCGVVPu89UmgevrfjFagAbvHdh2g6YrtIHcFzc4WP7ATfcsIsGlUrH5gVwxOybqCNcwRtTbGDNetpoix7h/avWOCO264nP+dzBlcHQd9E7KIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iHoBBQZUJlTlkiy9U0/2BptyWzgAnGKOiUUUtyrUh7gzSi8hcT1afVHg9nG+tBay0h5eUaalmFjETm0dbEWJxyNAitXYbSL8IMmz+FIH5H6WirT+psd/eKh7saB7B+1dfcC1aZ/5JhI53BKkqKvNpCKep5C1k2+j9kcgbyQ58Cwo8hkbpfWC+Ba2cT9fZZzZyl3Yu05zhPcDRt9Vgp2P0M1FPdyHRvwPItowhP3DzAdw4LfBlbmezGR83CJAE7drAw+iHyFP1l1cx1zP4hgvWW967CwOFIDVhtVW91i9cqt1AT8d74pmqPXsrSPrKH87/5Zcc3QrUwTJ0PNjRGLLTnuiGSNDUbjptI53JC6oTUnBDGkJHMNTyo3to+1DkHBZGo5coTRjkpNiNQ7JUHbeoQv0axvyCP6Ih2eLVo0YlP0ijOtc4u/cFBsSEZa7tlHt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 11:39:16.5590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec053154-b40a-4caa-ebf7-08df29e7c731
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BCB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB285917
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

the register c2pmsg_127 design only applies to dGPU not
APU platform, so hard code ras block feature mask on APU
platform.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c | 14 ++++++++++++--
 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h    |  6 ++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c b/drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c
index 49ba57f58878c..fe971cf19e493 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c
@@ -80,13 +80,23 @@ static int ras_psp_v13_0_get_ras_block_maps(struct ras_core_context *ras_core,
 static int ras_psp_v13_0_get_ras_hw_caps(struct ras_core_context *ras_core,
 				struct ras_hw_caps *ras_cap)
 {
-	uint32_t ras_hw_cap, bit;
+	uint32_t ras_hw_cap = 0, bit;
 	uint32_t i;
 
 	if (!ras_cap)
 		return -EINVAL;
 
-	ras_hw_cap = RAS_DEV_RREG32_SOC15(ras_core->dev, MP0, 0, regMP0_SMN_C2PMSG_127);
+	/*
+	 * driver only manages a few IP block RAS fearure
+	 * when GPU is connected CPU through XGMI
+	 */
+	if (RAS_DEV_GET_DEVICE_FLAGS(ras_core->dev) & AMD_IS_APU) {
+		ras_hw_cap |= (1 << AMDGPU_RAS_BLOCK__GFX |
+					   1 << AMDGPU_RAS_BLOCK__SDMA |
+					   1 << AMDGPU_RAS_BLOCK__MMHUB);
+	} else {
+		ras_hw_cap = RAS_DEV_RREG32_SOC15(ras_core->dev, MP0, 0, regMP0_SMN_C2PMSG_127);
+	}
 
 	ras_cap->poison_supported = true;
 	ras_cap->flex_mca_enabled = false;
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
index de3da5571ef82..fada8b1b41453 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
@@ -107,6 +107,12 @@
 		adev->ip_map.logical_to_dev_mask(adev, ip##_HWIP, mask) : mask); \
 })
 
+#define RAS_DEV_GET_DEVICE_FLAGS(dev) \
+({ \
+	struct amdgpu_device *adev = (struct amdgpu_device *)dev; \
+	adev->flags; \
+})
+
 static inline void *ras_radix_tree_delete_iter(struct radix_tree_root *root, void *iter)
 {
 	return radix_tree_delete(root, ((struct radix_tree_iter *)iter)->index);
-- 
2.43.0

