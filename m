Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280EBCD6E78
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 14:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83632112851;
	Thu,  4 Jun 2026 14:55:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T4BBQEQl";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3DAC112847
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 14:55:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcgHpbExHpr7p7Hrn3lCo9vRwvp645EHFRTtUEUN2Luc73ULvoxUqoULNQx09tHCBnKglHzvZgqMZausyBZTKpDm7s04XkQzqbacwEa7TOgTiEP5OoeMB7B8VkKl5ym3z5cVwlMxKRbpk5gEyab0/t64FCu25aPu/wE208EO1BZMOqKwbYrfw2upkx53PSBnxTE48Xk9WC+LzPegTyR68cjwGk7tWCwGoOtqlg/GHIBEwXsRFaRNKKZz14uHkkpRH+LoIwA42Zls80zKC99c70dvm/laONqYtMDX25MDSGoTWAmt9L0HZ603gGSVWyi3KGwkAKS93gbJ++WZN/lVLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlZ53a8cazNNRqINgKX/YLw+iYGde/9aFQ+YNEZYRWI=;
 b=fMKu1c55tyFkh3RxzqrIYD8TQNI8/Pr/SlqFAUUMCFIPi+VsBM8DAGAb3htF/Wd8g2LrkakGBU7pvv+Kk6J2NCWR3pYYWSjfQL9yWPra6+c9SvPxh3+Faa8MTL/G8HwRqbCSQrPnH5k5MykMQTdPle7sLpsqPXOMAmhPiwcyVgaU+oYX+98uIpWpUNDSx4uqkitB7t93yZj5zpYOakunJz0S1plHw+Zdtufsect6im4EoX4JyI2OwxvD0zybzkJfgOhQW5O1/2MhuiOyfcwhMk8emG5s8sjw1OtsGRUKYSx0N9zsBqtpVN1dNEfk8xdATt2gs5lHnkVs8uUy3ZM8MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlZ53a8cazNNRqINgKX/YLw+iYGde/9aFQ+YNEZYRWI=;
 b=T4BBQEQldAtWKpcBf8y99tH0lV18xL8UgEJOIhIQNgV9g0W3tXMzbKKhg6x/97cER2Xfd0MLnGeR63PwML8DKeHMVBQqtFjLPdjFrkellWKjXCYsyyPLPQhz+HwFHrifInPxEHNOjIPoiI5ZYEsbPqToxsIkXM/BprXWKKS2dog=
Received: from BL1PR13CA0370.namprd13.prod.outlook.com (2603:10b6:208:2c0::15)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 14:55:20 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::20) by BL1PR13CA0370.outlook.office365.com
 (2603:10b6:208:2c0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 14:55:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 14:55:20 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:55:08 -0500
Received: from aaurabin-tumbleweed.king-squeaker.ts.net (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 4 Jun 2026 09:55:07 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>
Subject: [PATCH 19/24] drm/amd/display: Use handle_hpd_irq_helper for HPD RX
Date: Thu, 4 Jun 2026 10:52:13 -0400
Message-ID: <20260604145428.809959-20-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604145428.809959-1-aurabindo.pillai@amd.com>
References: <20260604145428.809959-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SJ0PR12MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e776a84-5f13-441d-4a2f-08dec2494c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: U1r4JCqBFApeh/w2v6ZGPMDhmoxJo9/A0kQIq/pzspgYNW2gxzuGhS5VfXAdyAQU2zVbQZBV2OiehghDrnhuS45YjEo4YLhoLLvlMJqI3uuGY5gWwSvhSJE03OTlDvdAVHOiJeS7QuAcJZc7QSdESKjUFr7UOssFY11xWUpw+UEGEqA5MFWpj++ZM4V2YE0Fv0vrgy082SW0BqEqqDQDRrvpd3y5EplbvMXE0d68DEls5jZgZmcAxnbUjReQgKAEDGjyFsaJf//HK6ubsl/2av5kYqBeRJgz9Ngv3JWTsqpBLykSkIQ97uLPOwmkLUW7IygkuVA6PYV0sPoaZKhQbDh678eaYMcPeQtJ5rOOiLqW64I5QC82Q8r/UtS8nufjgiZQZgoNNmPsxq96Z8Fp7qqTQNXMsa5G6bu4bsmGfgfJ96bFV9TVAc/tUzdqK799gEZzFITPn4iQ6KkrdKBY6VdAZAIwBGrHTM8tkuIgvrxbbhv1SaD+Dvt1WXCbWU8v1KxEG0hC+t3xsC3Y1T5AeLwBa9GooEDOY9NysimaPorvBOt3pEzOzX8b/rZLl20o3DM6Zh0p+0a1LxU0tagMe9TbacTJLcOi4Ytw6LN7yD/rEv2TzDpe62PZ3Kyy2WYi1a6ERo9qIN0VeJfAhQ7tx6YZ9AVhFr0NqU3AtfDRZqbaNmq0lY+7JqAxIA/xpT+U4CFFuwWeFQA3eEVmZCJrzHqwKlCFgrxz8wHLHMvnfT4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ND/KfiFEhsGxr1KfZrMxDTF+6eV98ixdZBHsndeEKFXiUW6zjbpbpUTGh7lXFIIvQUv/6msxngI33TZWxJUjoOSnGc8+wUPcT0urCHFSQ/Wmf121mfgd1xGPbswUjcU+ulJ/k1NIwEnFn/Wm4Fzt2Q6qKy1dyyfFXMX4qz71nJBFHJ6FksVkTflJGLP+sNEpyZOwJVmKHAWXS0qtMdr8kGPKGBVEY7qIzxB6oy1Ddq5Tn2shFYVpRTsJhZT4l6eCgDpRL6T6dTX8pdwnmZhfQ9xatKbFKpeD8YU6rqiwU8TM6kVlotD/UhwDCcm8OrAwUlJQ/04avuC5PXUtETdKCcZNbafJuwO1PlCNsBtXD6YsgSwTjRFtVL+Gdxxqz+MoNR/A4LiU2SBNxiBe12akoFHh2vQYKbpZuxRJdB3cGRPnR2XOpf51ueGYhSdHXIyP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 14:55:20.0238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e776a84-5f13-441d-4a2f-08dec2494c3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458
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

From: Timur Kristóf <timur.kristof@gmail.com>

Remove duplicated code and just call handle_hpd_irq_helper
with the appropriate detect reason.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 41 +------------------
 1 file changed, 1 insertion(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 52cfe32f14b8..e1d23dd3c2a7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4491,14 +4491,12 @@ static void handle_hpd_rx_irq(void *param)
 	struct dc_link *dc_link = aconnector->dc_link;
 	bool is_mst_root_connector = aconnector->mst_mgr.mst_state;
 	bool result = false;
-	enum dc_connection_type new_connection_type = dc_connection_none;
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	union hpd_irq_data hpd_irq_data;
 	bool link_loss = false;
 	bool has_left_work = false;
 	int idx = dc_link->link_index;
 	struct hpd_rx_irq_offload_work_queue *offload_wq = &adev->dm.hpd_rx_offload_wq[idx];
-	struct dc *dc = aconnector->dc_link->ctx->dc;
 
 	memset(&hpd_irq_data, 0, sizeof(hpd_irq_data));
 
@@ -4567,44 +4565,7 @@ static void handle_hpd_rx_irq(void *param)
 out:
 	if (result && !is_mst_root_connector) {
 		/* Downstream Port status changed. */
-		if (!dc_link_detect_connection_type(dc_link, &new_connection_type))
-			drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
-
-		if (aconnector->base.force && new_connection_type == dc_connection_none) {
-			emulated_link_detect(dc_link);
-
-			if (aconnector->fake_enable)
-				aconnector->fake_enable = false;
-
-			amdgpu_dm_update_connector_after_detect(aconnector);
-
-
-			drm_modeset_lock_all(dev);
-			dm_restore_drm_connector_state(dev, connector);
-			drm_modeset_unlock_all(dev);
-
-			drm_kms_helper_connector_hotplug_event(connector);
-		} else {
-			bool ret = false;
-
-			mutex_lock(&adev->dm.dc_lock);
-			dc_exit_ips_for_hw_access(dc);
-			ret = dc_link_detect(dc_link, DETECT_REASON_HPDRX);
-			mutex_unlock(&adev->dm.dc_lock);
-
-			if (ret) {
-				if (aconnector->fake_enable)
-					aconnector->fake_enable = false;
-
-				amdgpu_dm_update_connector_after_detect(aconnector);
-
-				drm_modeset_lock_all(dev);
-				dm_restore_drm_connector_state(dev, connector);
-				drm_modeset_unlock_all(dev);
-
-				drm_kms_helper_connector_hotplug_event(connector);
-			}
-		}
+		handle_hpd_irq_helper(aconnector, DETECT_REASON_HPDRX);
 	}
 	if (hpd_irq_data.bytes.device_service_irq.bits.CP_IRQ) {
 		if (adev->dm.hdcp_workqueue)
-- 
2.54.0

