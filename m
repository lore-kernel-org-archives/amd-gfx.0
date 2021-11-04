Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F944C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:53:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0D4461207
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D0D4461207
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72743737F2;
	Thu,  4 Nov 2021 20:53:01 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2067.outbound.protection.outlook.com [40.107.95.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3813C73870
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 20:53:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lf4qCNHyz7TANWG8/b2zCroZ/lGbCxJkRr40Nu1AHE4IlY1FE+UDLAcUe3Ty8w2F4u4SA3bXO3a1UzNYz1RC1uU07BXP2B/UEeCbrcmIghTAtacgCWENfiKS+MoFoWfE/qlmWB6CLAVr/4JQXrCDgz2sMlBpR57QupjQ0hxfa709LuA5flpg4f6G8gdQ6omQ7nFQuD5b6Z3drrWo4YukG+h5Mb7i11pedF3kl4EMVN1KxG3In4GwtvFQnsPICahF1OX65EB70bi5a+tRZgluV1eIZBXYIGcayUbUAQ3LhG5FvOnMXbvYzyJ+ECjmU8LJ4FVGFO/NpBm18rUzHw4RlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcROMSwMNxRlaJc8kLTWzteRz//32yauQLiMJ8iKfeY=;
 b=Z2H2HuXpUrHAfuQws2VdnNC6w10DqgS7RZ31klGOrDKIkhtFeisjrNK6MFQUGM1GKs1Z9KOguTqyzoel0cmZ0qnRtS/L2hK8XpeaJWPme5/MXqFVsAoStYk6FdPgcxR6P9XS6JiKP330xRfVf/t1SnPec1gcB58FCTpb3N8+AodVOvBEBVAh4Vib9vUMjkzFRzi6uD2Dy3jlyejIRUrgE3bQjJa+mF+nc0pVTv1mswCN9I1AygUkinvZB6kcoMXb2APi9FGdy9+xgGNDZygZGq1IKKqKVD8ZCzwjFYR7A6jydH/wI3ulDdtbz+laRZ0PphykW7BolCiOdWv8Wuw8Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcROMSwMNxRlaJc8kLTWzteRz//32yauQLiMJ8iKfeY=;
 b=QRnQahuR/Q56ubjmXC2sos7fOI+OS6Er3lDktoyOjEXhAJtUDwsmwVisc1vuZXBH5CLRqkPFted0tuS+Rywq2y209c4qloADs12t2P81plFqw0rPhcdd1QDJpxtEaXxeLtVhRbX35WfvpmYYRDzbD6RRWj72Iz9LidBHvIgXXkI=
Received: from DM6PR12CA0012.namprd12.prod.outlook.com (2603:10b6:5:1c0::25)
 by SJ0PR12MB5488.namprd12.prod.outlook.com (2603:10b6:a03:3ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 4 Nov
 2021 20:52:57 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::9b) by DM6PR12CA0012.outlook.office365.com
 (2603:10b6:5:1c0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Thu, 4 Nov 2021 20:52:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 20:52:57 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:46 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 13:52:46 -0700
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Thu, 4 Nov 2021 15:52:40 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/22] drm/amd/display: Add callbacks for DMUB HPD IRQ
 notifications
Date: Thu, 4 Nov 2021 16:52:07 -0400
Message-ID: <20211104205215.1125899-15-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211104205215.1125899-1-Anson.Jacob@amd.com>
References: <20211104205215.1125899-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f049445e-bc2a-4fd1-5cd3-08d99fd514d5
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5488:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5488A1D21626E9D00DFEF140EB8D9@SJ0PR12MB5488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGA4XQ/AnmUt7nyR3yg7CeqKNnxBVhaR4OLNwSgbYm5VVit53Oewvrg3iD2HwsAFE7od5iI9PpB44X92vgso85Fn1jx0rr3BTqNdyp4RKxYihZZX/PPUc5EKoSaXz2YdwdvAUI6PJzMhJeSX+aYuFyTiAH7+faknW1/H399hKTk4Bhymo1B8SrrwyYTRd269RuqwzimeRMe1Xs2D08tUhaRK8xo9Hy9hc28z6p6UT8gGFxbnNKPJ5YSrPmMGaiO28QTyeMUULRIG40ssI4tKevJFBi8N6f7v7MkrZ9MK8VRlNYKpyNsLCR09hDvdRNR7vIC+TlWL4XWommbVwJ2AY20LOIJAPHb2Q9Cl/84xApicnLBBWXWVWYAXu92l/726GKSmguM4fr8cH3jwNwFblJ1dNkW1RpV+f06s1uGdOVXAhE0gh/AZuksHpCjvkg4Ro79MhMsn9NTQfWrOj1R/m6e1punB0hrtM2SiqqaKkbFDz6SfzpE56m45gLE+DW3HbcPDNgg9a1xzQhM9LzAPRWCZQ9wRdGDpuM3Lg8fB44ocZL294WpPuSpkLYWBs+jTKutSq1lxvBn586jYeLhI9xwDKuHFRXpqJotP0IeMfZw+gMlVFiXol+PFLAbnzNZ4JyfO5nl32FVNco1SIx5xk90IYs7ELxvE/aY9udO6eqOY4GWY2sAZYa1A6cKh04+b1o/dzFH/84VuOI0z8FtICgSecCe+Cd9iVJZD4XThYvk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(5660300002)(316002)(186003)(6916009)(426003)(54906003)(356005)(6666004)(70206006)(8676002)(8936002)(1076003)(26005)(81166007)(15650500001)(7696005)(70586007)(36860700001)(36756003)(86362001)(83380400001)(82310400003)(2906002)(336012)(47076005)(2616005)(4326008)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 20:52:57.5223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f049445e-bc2a-4fd1-5cd3-08d99fd514d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5488
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Jude Shih <shenshih@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
We need HPD IRQ notifications (RX, short pulse) to properly handle
DP MST for DPIA connections.

[How]
A null pointer exception currently occurs when these are received
so add a check to validate that we have a handler installed for
the notification.

Extend the HPD handler to also handle HPD IRQ (RX) since the logic is
the same.

Fixes: 00be4268d32c ("drm/amd/display: Support for DMUB HPD interrupt handling")

Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
Reviewed-by: Jude Shih <shenshih@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0fa0c7bb07a0..7a54ccb794f9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -217,6 +217,7 @@ static const struct drm_format_info *
 amd_get_format_info(const struct drm_mode_fb_cmd2 *cmd);
 
 static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector);
+static void handle_hpd_rx_irq(void *param);
 
 static bool
 is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
@@ -683,8 +684,12 @@ void dmub_hpd_callback(struct amdgpu_device *adev, struct dmub_notification *not
 	}
 	drm_connector_list_iter_end(&iter);
 
-	if (hpd_aconnector)
-		handle_hpd_irq_helper(hpd_aconnector);
+	if (hpd_aconnector) {
+		if (notify->type == DMUB_NOTIFICATION_HPD)
+			handle_hpd_irq_helper(hpd_aconnector);
+		else if (notify->type == DMUB_NOTIFICATION_HPD_IRQ)
+			handle_hpd_rx_irq(hpd_aconnector);
+	}
 }
 
 /**
@@ -760,6 +765,10 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 				DRM_ERROR("DM: notify type %d invalid!", notify.type);
 				continue;
 			}
+			if (!dm->dmub_callback[notify.type]) {
+				DRM_DEBUG_DRIVER("DMUB notification skipped, no handler: type=%d\n", notify.type);
+				continue;
+			}
 			if (dm->dmub_thread_offload[notify.type] == true) {
 				dmub_hpd_wrk = kzalloc(sizeof(*dmub_hpd_wrk), GFP_ATOMIC);
 				if (!dmub_hpd_wrk) {
@@ -1559,6 +1568,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 			DRM_ERROR("amdgpu: fail to register dmub hpd callback");
 			goto error;
 		}
+		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD_IRQ, dmub_hpd_callback, true)) {
+			DRM_ERROR("amdgpu: fail to register dmub hpd callback");
+			goto error;
+		}
 #endif /* CONFIG_DRM_AMD_DC_DCN */
 	}
 
-- 
2.25.1

