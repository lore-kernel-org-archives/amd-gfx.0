Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E56C43327
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 20:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BABF10E411;
	Fri, 26 Jun 2026 20:41:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KKgwk+BC";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 919FD10E40A
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 20:41:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHa1zSMR3Cf9WIvK/JpcHpo8qR0BFd3FgLkkV05oPciFr0WIsqMqNVgTYg2H7xbHrCaZfkC32EBGV3RZv4vNEZfk4KxhRQ1VGE/xxr/k4fJqWfYPFlSnnvknxTsp91OPshGyOyKnIP7UnjlF8ATE8l9LBEVHf8w9tDERY4fLNvd3OhLqo0d5C7hkkwlQItvI71pK8pbh5RXeWEo51e+YyZfVNPdCf8B8QyYQzqtdVDWOo30Fs2PYxm8s88PJQlgabtxztBodwGU6q43oSjkfCMGJmjoM17cdkHtKIf/zEY5/g47Vbe7p0D6CqsBaHS6A7SHnrUtd7Yy0qLHZlImn/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mezGChtlXPCVSxu3pvYiSbw0xxCXWVNgHSkyXjY9uuo=;
 b=QsaXj/JbF/iMnwCxtEL91aGQZv605XfZo2f3xQaXW9+DRgLtTnj5Ah1Tb/tetCaUZXONQMnvy0xOIzQi1LKKP0Kkp65SANNZlo055Sa8jnCIuYGX3FtaoEvfjoqZmzOwi57h213ie28M32R55NNjwTdLtntTyHNhbbkRXefGLzgDXvfK7QOE6tkyGtYlNOoLP11AtHaGx4JKe8aEPejp/BDQyBYWYOf6pDz1yHIfW6E/HKrOX7oYM41AyG84ezNF/NVCLs5VIxih6aq7zz2X8odIgfr2FZXLa/X3KN2E9hhiq2QZ4UqmNC8zQcLCHuzIOZeJjHGOyl3qA4wkCP8WxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mezGChtlXPCVSxu3pvYiSbw0xxCXWVNgHSkyXjY9uuo=;
 b=KKgwk+BCmHzg4AalTjXBQd8yVihJxNw5LYAvw6vD/qGowp0ZcWpTGB6nbrnzwEIq60RiCgEZYQpS0rnBbIfQd81PkZTiQ5Ojv0MJ0RzZl/PoPY6/e2EN0dKoJF1nb3983LnV/pj3qQF4iOlDYse1HALvZ56O6tpldzgsnnkaMJ8=
Received: from CH0P221CA0043.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::23)
 by PH7PR12MB8593.namprd12.prod.outlook.com (2603:10b6:510:1b1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 20:41:15 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::41) by CH0P221CA0043.outlook.office365.com
 (2603:10b6:610:11d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Fri,
 26 Jun 2026 20:41:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 26 Jun 2026 20:41:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 15:41:10 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 26 Jun 2026 15:41:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu/gfx11: enable gfx pipe1 hardware support
Date: Fri, 26 Jun 2026 16:41:01 -0400
Message-ID: <20260626204101.31172-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626204101.31172-1-alexander.deucher@amd.com>
References: <20260626204101.31172-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|PH7PR12MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: cd6d6ffd-110d-48c7-f7b2-08ded3c3448d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|18002099003|22082099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: KQHJJWh6LNy3/hynQLlr6C7dHitbS13y5U+HCJVCrk9USgRyumn5ZfV99at3zE//Efxn9MwvDUmcpicv+92IXI05JbBFFqgxSdfpzAIcvgft9H3ev4gFcDIN4Osfj6F/JgyDYP3Qi+KZJePmfwWg1V8BZCTcwpt8xA8Ko+KcKDZiOr1KyBwxQL8ZXV8/kMFfCITc9ph17HcbR1Ogq22pd92fIRr97za0qdzQtQ8ceJ077UoGRhPvaKVeHM0AJQhbtdgKCWT9Ue10X67SHrjgc6jT81fOtvfQNiqATsrjUk1NZ8VykTLDaB/g1SSNU5R2nae6jrWbidLQQYlrBVTNir+pyvN+ftwWaDnLsfLOGX9biY/JEWbg87fPrxkXQ+LaMTFIhmi5WxivKQ4CfjAKwjCt26oOsmsTD4+5o+ok/WaCk+G8tqKwRrrzXZ5/ij1mPQGfN9TDdcg2GEGakyd8ZmTMyBIImofFGRZun7exGR/1kAWe6zqGfg2qt8Ek4eqtvYUyNzvkFR41/LiteBVJgBPCESFuUs7btdGO0vigdX8aDiqh53HDOBl9zM+IXDNC97vBjVvI3OWp9iPD6HgxI1Ow2qjkJvAVF4n9JsolrDySds9ArJI1t6OgI3gp1xZsBkiBPtztrFqTaSnPKasDarFDCHHnAHxs68l6PSB/NELgKKPhyvHKjtVDADSRkq/ZP7CKWI4soYWi2TV7L8IULA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gzh0I1ibl9pObzCtQnZ4dhUOSE4hVL0tepY0FA8UzyUOZnTjjnt8pXqlre1QUthSbhR9wFcJ4UWoD9A2jWbdmYwKP3RmPDVgQYzNuN3tfXXI5cdUEkmkdC4Qzq2w+SGn4eaiyHVPAtpSG3B02n/5UPySX3oslpJlMPDNkibaEHXY1E373sFtwT48I7mktYlqp7fv0Xo5FiXDYotAI7B1JsVpEikqCkg8lnAeLOMMwmLV4bfhHaCjF/6OmI2AJbPaO9A6ueaIqAohu1kBSQD7ua8O4aXpQ7KfrlaJcQQIjdaehyZICRHDkfOy9/M1sqZ4BeNVmIBPtG+wp4Acsh9JQVELjdVdu6D2Xs42JR7mHY+36XhAQhqy6WkoSjlWhB0xbzIc8VO4xu9oRcluolL2edJObPd2q5oNyO1dbjW9TUUFNv+Fyz7GWzxpNwcwuu/D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 20:41:15.4878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6d6ffd-110d-48c7-f7b2-08ded3c3448d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8593
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

Enable gfx pipe1 hardware support.  This is only available
on gfx11 chips using the F32 microcontroller.  Chips using
the RS64 microcontroller are not able to use the second gfx
pipe.  In practice this means the second pipe is only
available on APUs. This explains the stability issues
Pierre-Eric saw previously with this on Navi33.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5e7d0cd85c365..c0e34519b6b06 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -51,7 +51,7 @@
 #include "mes_userqueue.h"
 #include "amdgpu_userq_fence.h"
 
-#define GFX11_NUM_GFX_RINGS		1
+#define GFX11_NUM_GFX_RINGS		2
 #define GFX11_MEC_HPD_SIZE	2048
 
 #define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
@@ -1612,7 +1612,10 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
 		adev->gfx.me.num_me = 1;
-		adev->gfx.me.num_pipe_per_me = 1;
+		if (adev->gfx.rs64_enable)
+			adev->gfx.me.num_pipe_per_me = 1;
+		else
+			adev->gfx.me.num_pipe_per_me = 2;
 		adev->gfx.me.num_queue_per_pipe = 2;
 		adev->gfx.mec.num_mec = 1;
 		adev->gfx.mec.num_pipe_per_mec = 4;
@@ -5355,6 +5358,7 @@ static void gfx_v11_0_ring_emit_gds_switch(struct amdgpu_ring *ring,
 static int gfx_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int r;
 
 	switch (amdgpu_user_queue) {
 	case -1:
@@ -5375,6 +5379,11 @@ static int gfx_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 
 	adev->gfx.funcs = &gfx_v11_0_gfx_funcs;
 
+	gfx_v11_0_set_imu_funcs(adev);
+	r = gfx_v11_0_init_microcode(adev);
+	if (r)
+		return r;
+
 	if (adev->gfx.disable_kq) {
 		/* We need one GFX ring temporarily to set up
 		 * the clear state.
@@ -5382,7 +5391,11 @@ static int gfx_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.num_gfx_rings = 1;
 		adev->gfx.num_compute_rings = 0;
 	} else {
-		adev->gfx.num_gfx_rings = GFX11_NUM_GFX_RINGS;
+		/* rs64 only supports one gfx pipe */
+		if (adev->gfx.rs64_enable)
+			adev->gfx.num_gfx_rings = 1;
+		else
+			adev->gfx.num_gfx_rings = GFX11_NUM_GFX_RINGS;
 		adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
 						  AMDGPU_MAX_COMPUTE_RINGS);
 	}
@@ -5393,13 +5406,12 @@ static int gfx_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 	gfx_v11_0_set_gds_init(adev);
 	gfx_v11_0_set_rlc_funcs(adev);
 	gfx_v11_0_set_mqd_funcs(adev);
-	gfx_v11_0_set_imu_funcs(adev);
 
 	gfx_v11_0_init_rlcg_reg_access_ctrl(adev);
 
 	amdgpu_init_rlc_reg_funcs(adev);
 
-	return gfx_v11_0_init_microcode(adev);
+	return 0;
 }
 
 static bool gfx_v11_0_is_rlc_enabled(struct amdgpu_device *adev)
-- 
2.54.0

