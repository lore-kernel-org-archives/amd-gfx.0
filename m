Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5131DFF60F9
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 09:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB51010EA89;
	Tue, 31 Mar 2026 09:54:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JRj5kIpR";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9963F10EA89
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 09:54:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1PfslT0vSKdwlEP16xlE3iTHfRyuO00OOINU9zXislkpdNnIeYpGiX3ea+VZIsUEXITzF9zAOKWs2jzD51+S5EFUEtl+YY/Bctm3bV5pwGZosKc5OqP/RZue2Qa510avxhSYSXYFcZvzGPS7FBPs2Q677/OiMObihN7yMjo33brlKBDA+U44mawPHfQMI5S3n1xuLZH73ZwNiaGjML36PTvUI7T5zyFscxXW+4YzIN80NzyAbIHU4+DiAF0v0Qd65QdN9XcQ1vk1lglEeleFXU7zoNqwhSxfmhp/dG4wH/eIyjtvOBtDheLy4Y/Uhq19zswT+kewrfyWr8GN9NWbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEEtD5yfOG66GJ9uFHH+3CQ4ZAEGMrzXRW4Z/qa5e50=;
 b=UXTVwdzemmGGUN3j58+f8rGpGcYj6wgMgZbnhSYi2JAC2OMu0TqKxM03tDTLQOPLeSj32yV6IwzPZoMtRyYzhtpAJiKPurJ2VZkNLuQOXaUC/bALp6xByl5ZMQtf1EzqmyLhD8yfgzGS54IYrbVH9TqtOF8z+W63R8jzDVILt+yjtujWKYwFPHqB5m4ZKEyrSJl/0gTKyhL15/l2hJP8TJllgG7glkopeslD4QhNzwaolsnvcQna1vrL5jderB2cHc+ejofihCBj9rNBnvlTtIQr0uZ7rzsjTtjl2+/nBTUmEBPcBmxWBgL4Cfsf//GfFIQP6/m1jByibyB7sinsDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEEtD5yfOG66GJ9uFHH+3CQ4ZAEGMrzXRW4Z/qa5e50=;
 b=JRj5kIpRuTCprh5ZxKCgm4RTCprhO+RtKJCtuPQVOXTjjdaHWE6zW3mvxzmF/V6nkZkockKpxSCV0nltbLkpTNVpnLF+2FuRccr+yaZhfyLnVGHN0zBFuU33Ht7hjeKejvPu91UfXdN3ilIbm7DOIrv6EkNp/NwJx0IyjLbl4ao=
Received: from SN7PR04CA0163.namprd04.prod.outlook.com (2603:10b6:806:125::18)
 by SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 09:54:01 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:125:cafe::e3) by SN7PR04CA0163.outlook.office365.com
 (2603:10b6:806:125::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 09:54:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 09:54:01 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 31 Mar
 2026 04:54:00 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 31 Mar 2026 04:53:54 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/sdma_v7.0: enable WPTR polling for UMQ SDMA MQD
Date: Tue, 31 Mar 2026 17:53:37 +0800
Message-ID: <20260331095346.1331511-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260331095346.1331511-1-Jesse.Zhang@amd.com>
References: <20260331095346.1331511-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|SJ0PR12MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f414ce-185e-491f-f7fe-08de8f0b6f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: saYmJQabn9nNLJkxxX2TnBKtAsaNMInxklnOrCaHHwX5uQBOanEHJcNGN34wFo+dWMEDLzOzV+Lx3AOwdx5Trzuf0oZh7KwZwFxkaFX6r5zRX5MVLqfKSEsH083hZhAurKgDY4OZctWT6GdT+/SZWDtjzggXNm5SdWazNlkVAVqCtkdlFJQwRmkqs2wpcRoUDx6fU86qnId/0emF9Yz4Bnh8yIgc4h+9+zyHlQ57w12HdSUhQyhvKbUje7V2ldZmjtDtv0K7m8BccOhd9Q4pVKm5l/srK0mYQhtASSk/nvtY8A81Ki5i+9eZsnOOQy8fnf3w7h2VJ9Y7+eBDOcULtM4IYZ0Lvj3tkrB9UaxMIkS+qSGmTVQLiPaGqx/HQahgCkSrekQJUn+yEiaFRZi+S5z96QgYrdbN+pJs1A84COtugv6QTEOeR7h3c7c2bMCwt7bu8fbr30ery+G2/4pE8TA2j+664R1Uge0W3ue/tWJhuHTfZUzov1uyKbGPKKy2dCfICsQYG13jzkzWNncx5Qf43xfb4/Sri35vOSNto4kUh9VXQTi4kZjoUfzsACypMlsaRXR+ujsz2c/9BBg8DCoshprwbXP2dvJ7fyug4IURfZ2i0FMSIkK/kkxMwyOalQHc8blYcINZmw2R4ldzt7qlQOtUNoLW+f9XU3eR+7WLW3AYdhry0zccz4bgFTBTbU1xRVUWD161ywURJSCjsSVhTOGK/DKrXGhGTnMB4gXNH09PkOJJgFi8MuO5VnSL7x+R3G42TMWM/A0NQp5z6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q575o2n1zQCYBn/xaFlQ8ErU5H1ejtfFlRPEsZlyeO6t/sh0cp9W7fIivR0lQ03lPOatT4l4/MrAh/+ChNIgRD4HENGqKTlrp3rc1xuEO09HgPZ5yKxr+I6bGXSs4sktqF3CsdD+k4dQaDn15qot00BbK6saTd0DVV8uM6JNRHMYjoNC0go1Xqmk9CEDlgaWwWbACsB4fzCqd3SYIYOQzBrTJLDTI8jzvuSs6eEA3KhuPPUPRNQfTilxBlHZItJEFQi3INtLR4hfZQSKSRXtOlA0XkRBxu0assDlAkQuHAb26rQ5jYqSqT5+0E6r9bqyvcvFzjfpTWCz8pNwH7Dvmus3vRuKEJ/wJ05elWK+h01EP65tUsgA5maIZ/qNEb+OFKZb3W2HLj/Py340uOm9/AKhMldhK3aBfcD5/375GC2WF6A2UufrKU/0gDInHZqx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 09:54:01.2556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f414ce-185e-491f-f7fe-08de8f0b6f9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6806
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

Enable WPTR_POLL_ENABLE in sdma_v7_0 init so hardware can reliably observe WB write pointer updates
while keeping the existing doorbell path enabled.

This fixes UMQ SDMA submissions timing out on subsequent packets where wptr/rptr no longer advance.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 5679a94d0815..ba6b7a2e6577 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -882,6 +882,7 @@ static int sdma_v7_0_mqd_init(struct amdgpu_device *adev, void *mqd,
 		order_base_2(prop->queue_size / 4) << SDMA0_QUEUE0_RB_CNTL__RB_SIZE__SHIFT |
 		1 << SDMA0_QUEUE0_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT |
 		4 << SDMA0_QUEUE0_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT |
+		1 << SDMA0_QUEUE0_RB_CNTL__WPTR_POLL_ENABLE__SHIFT |
 		1 << SDMA0_QUEUE0_RB_CNTL__MCU_WPTR_POLL_ENABLE__SHIFT;
 
 	m->sdmax_rlcx_rb_base = lower_32_bits(prop->hqd_base_gpu_addr >> 8);
-- 
2.49.0

