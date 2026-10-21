Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580D2606A333
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jFeNxXN9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB40B10F96F;
	Wed, 21 Oct 2026 06:28:40 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10D9A10F972
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:28:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOsFQhq47AzvHRc9aH8LDPWL104NOajBFtaerHBrpPrjdYVtHBFbqaM8ElgcRMB94J90m6V99QccNhR/CS0VTLO547NjYiZxar1iS+R961WDRSAivOgJQ4+E8SFprbimK4Dw6o9lvisHxdyLo+/bT0YPFdOOo/2MjFuXdtCEn/5cuUlR1SqI2FaE8aC8VYWa127xzLE1whcwPzoBZiWV31kvjL90KiMsN2N905rdAzIHSX76sXEu0frGchubb+XQsm7opX7T/x5LO3VORNQJ6zi2c5D2M/mqxSjxc4qfco8SqyStYBga73P7Iz74UtVpPm4JOME+tC7ibtOKwSQmWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWjJ+hqkPp57kdmPgH8QLvcDMhsiTqQ2w2yY7Kjohxg=;
 b=f3urAdnHKhvH+fNheuoQfSdhJsXp2Pe/pYcIKY+z7ZBFxN57nSIjKAShIGgf1/WlsldDUP3q2ProoVdgbC4HKRreJQwl71E1pdGicFmCUsWWWnklUsfHprMzqelHoGVF9xnVTgFGqg0hKs5ppKAwxy5fXq0kr5qrOkLHQkLE0/BLPbWfBNeHYlXBdONVlGkoa9hzF36o6uHfwQhWHZmH3DSdGVprdV50NkJjOSji1/uP3kwE4zvKiNRcTcX/y3gfYBj8Nl0qtZ2kiN/vL9uy+DbI6Cagx6Rs9MSXo8zOXtHydmntP6rn4jNqWIrB0kzHTYfddsJigLGnfquSY6rTiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWjJ+hqkPp57kdmPgH8QLvcDMhsiTqQ2w2yY7Kjohxg=;
 b=jFeNxXN9qxESl2RUa7PIV0GSoR/V+AcXljf/WMOZOvmjS00gbtgzQorezm11goKb+23eqEJTJ7p84wJf5yKEjotmUpUDD5AbvU5uCGpSnTLig2O/LcP8N7D/IvIYlB0qnCpVlDzgqY0x74GGbCBPT+O74Zrjxixo1t2l3Ay01dc=
Received: from SJ0PR13CA0084.namprd13.prod.outlook.com (2603:10b6:a03:2c4::29)
 by CH0PR12MB8462.namprd12.prod.outlook.com (2603:10b6:610:190::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:26:25 +0000
Received: from SJ1PEPF000037A8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::5c) by SJ0PR13CA0084.outlook.office365.com
 (2603:10b6:a03:2c4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 06:26:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037A8.mail.protection.outlook.com (10.167.244.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:26:25 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:26:24 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:26:21 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 17/49] drm/amd/display: Flatten CRC update flow
Date: Wed, 21 Oct 2026 14:22:23 +0800
Message-ID: <20261021062519.674697-18-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A8:EE_|CH0PR12MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca92479-0dd4-4464-f323-08df2f3c3b8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: lp/WgZbc6W8OiQSiui3i8N6XGqwkY7n/XbxKBkSe4u21clpDMo0dZ2EWzOCn22idaNdFxpue6UnSTq32+R67gAgXkF5Qs+5/UQk+A8Vz+vhE/dWuP2EHvshZQm108ejTCOgurYwwgoqimMp1V2ESLHgPn8fkCD2BL64BLC/DhTNFd32VsQy+8lbN8IbPo61K3dq0gzkAsDJhjARcPfryv5EaihrRMX18ycL6D9rzgSXHLpvcPySY1jb+DgJN/vPJ62bucaUejfGjF5fm+8gOXldur5uTCVrjp+N1BaLJeVBAW4PfhOjq7uusLIkxoqhcyuQS1wbmfdzk+4MpDFNyNYtEItolMWCfmOQx6Db1gmrU37mP1sepdD4z2goB0Y2TIvgPgfn1ElLJA+ymXNBMZbmOdOxcI5Wj6dnGxR8640vkESpjHABun1li1TMfn07BLmf3qYEAxt8+MnOeYfII2gMPIavSogDOQJ/kA/l5J3Z/Uzqk+1yAG/Jq8U3vwY0DHVZ9gvmM8rlSZ81mINFACASvte6Wmt7VdQPe27WYVquBt8IDs/mIzPmrMHJ3FIHcqPobEYTF9n6Mnb5HvoJhiJ5Vv+mldzE3ubXH46y5EmQQmKZFHYGbZ+naDEze/8yf9SwBkAHQbRZ7GY64wyn8n/PzDAk01w5D0ng4NWNkak0i+RygbK/VDjZAx6TpXVd0IIGlAHRLlC6FbcexxKKPNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5EZSUPvdjB0nhHiIq7gBv/qy0Kesf/sSjI64f0JUQ2MNOjELiYmqd/jtGLHft/8qxENcpAgiLXHp7fFamu5XuGPLCanC4zGTqKRLSOqnJWDPs9T8MIBEWg5NWXuJ25j8rQzCjsmP+q93H/EAxfr10DTxRPN6wCRtUpYZThJmmx+TZwXC+alKDAKw+ScOR0LtX7CHnBbolUcJ5LJE55b/vU6OhL+GJub9p3uNf7KKxfIEc25ojLLvCeoE+grIaWiEy001vndFAWXteN8lHjNhxxJgrw7dZnhX81I0ZL1w3ZRm9qfMe7jETNNNKkrwnC2DvW9Np5ECyRpUW4UzXoEjIzzrW8NNNcRbRlZtAp40kx8fWD7tOQ7Ee77R8CFwXKDqN7doENMjLg5wrs1MSrfeZJq7wXDuXW1yCdglkizcp8IkDWTV5ZnCRl2Pl/MpW+qm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:26:25.2634 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca92479-0dd4-4464-f323-08df2f3c3b8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8462
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alex Hung <alex.hung@amd.com>

[WHY]
Deep nesting makes the CRC reconfiguration path in the atomic commit
tail harder to follow.

[HOW]
Replace the outer CRTC and CRC-source conditions with early continue
guards. Preserve window updates, locking, and CRC configuration.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 56 +++++++++----------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bdabb4bf14da..5c5bd331a9a9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5340,38 +5340,38 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 		amdgpu_dm_handle_vrr_transition(dm, dm_old_crtc_state, dm_new_crtc_state);
 
 #ifdef CONFIG_DEBUG_FS
-		if (new_crtc_state->active &&
-		    (!old_crtc_state->active ||
-		     drm_atomic_crtc_needs_modeset(new_crtc_state))) {
-			/**
-			 * Frontend may have changed so reapply the CRC capture
-			 * settings for the stream.
-			 */
-			if (amdgpu_dm_is_valid_crc_source(cur_crc_src)) {
+		if (!new_crtc_state->active ||
+		    (old_crtc_state->active && !drm_atomic_crtc_needs_modeset(new_crtc_state)))
+			continue;
+
+		/**
+		 * Frontend may have changed so reapply the CRC capture
+		 * settings for the stream.
+		 */
+		if (!amdgpu_dm_is_valid_crc_source(cur_crc_src))
+			continue;
+
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
-				if (amdgpu_dm_crc_window_is_activated(crtc)) {
-					uint8_t cnt;
-
-					spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
-					for (cnt = 0; cnt < MAX_CRC_WINDOW_NUM; cnt++) {
-						if (acrtc->dm_irq_params.window_param[cnt].enable) {
-							acrtc->dm_irq_params.window_param[cnt].update_win = true;
-
-							/**
-							 * It takes 2 frames for HW to stably generate CRC when
-							 * resuming from suspend, so we set skip_frame_cnt 2.
-							 */
-							acrtc->dm_irq_params.window_param[cnt].skip_frame_cnt = 2;
-						}
-					}
-					spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
+		if (amdgpu_dm_crc_window_is_activated(crtc)) {
+			uint8_t cnt;
+
+			spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
+			for (cnt = 0; cnt < MAX_CRC_WINDOW_NUM; cnt++) {
+				if (acrtc->dm_irq_params.window_param[cnt].enable) {
+					acrtc->dm_irq_params.window_param[cnt].update_win = true;
+
+					/**
+					 * It takes 2 frames for HW to stably generate CRC when
+					 * resuming from suspend, so we set skip_frame_cnt 2.
+					 */
+					acrtc->dm_irq_params.window_param[cnt].skip_frame_cnt = 2;
 				}
-#endif
-				if (amdgpu_dm_crtc_configure_crc_source(
-					crtc, dm_new_crtc_state, cur_crc_src))
-					drm_dbg_atomic(dev, "Failed to configure crc source");
 			}
+			spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 		}
+#endif
+		if (amdgpu_dm_crtc_configure_crc_source(crtc, dm_new_crtc_state, cur_crc_src))
+			drm_dbg_atomic(dev, "Failed to configure crc source");
 #endif
 	}
 
-- 
2.43.0

