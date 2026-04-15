Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F46AFA0C42
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 07:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2352D10E69A;
	Wed, 15 Apr 2026 07:44:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FbkDRx/k";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E69D10E69A
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 07:44:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPwTGdC90koiFLESNltMCzY+RPcDQulJAyRYrVt5WiomHSEyeqcOH3ZM4GmymWPDQiQE3WHim6rHU9rFx6uZuZI8pohOiWf7kbqjS787BLLsgZc+/1U3rUHu3ioiowWRUCEQc3gz2wOmkt2FNoe/an/lZLwt6Vdp0wG6kLPhR7P/gOmFM+iJRgKjnLVGjKwV9RaS+l1bxP6rjxK6cyVtuTxkIH1qkKO9R/eiGgkhKTGMxfiUaTQVLU3M6HYDb4zGbTektiIb6KDXwXuvXRsSQgcosFmLhs2utTh604wmfzN4/fAcULqA1pSjpLG8ycVm4UCbjJ9O6aSFHL4Hdvfn9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOF24ALXSRJlnSJoQiWDq/K0IJfpVUilmdyc3JNP99o=;
 b=xlA7BEsj7dGW1Kx0sMTDHj2M8s2rRc4QPib8S/jDn5OWFojXD7qCawfbo2Tmyjnpl5JJKIcDsT5KZ07ePGBrJWo46fulm2src3eg+5reydRMXhVhk5i4RLeyZ/hVMpUUUINI/qIbhH6FxjHNKbU8lBuXWE1XiYLQYEIhzEeD6hiQkjR0C9g7op0EtiaYa9ExLOOztDwFxvXX7SX5qh/OouTEzV4dUWo/3Ozu8mKwLq46Rza2cdRT0Zojx6q9i2T71aS2H6BrD4I2VoBE7fggAHE5m58rEcz5ACKBH9qWaxZ6U5HzTkoI74FEN0se9kkH0T/+qj9O+4/HWKgWj4pRfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOF24ALXSRJlnSJoQiWDq/K0IJfpVUilmdyc3JNP99o=;
 b=FbkDRx/ku83dIsCKt4sdEBeb6K02TxRGlj0Sum9IakTBzgRsOlB3hrf/RcslkqkVnQwWr0wvpfdfxePqsS+6YeYJXzYRS4zSKvJxZ3HKmmflvejrI2iAJ4RLyVqHLut5V8pu4ROEJ643evft6Ddn+1Nx9ceeGFdVrGbbLO7G2qw=
Received: from MN2PR19CA0041.namprd19.prod.outlook.com (2603:10b6:208:19b::18)
 by DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 07:43:58 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:19b:cafe::99) by MN2PR19CA0041.outlook.office365.com
 (2603:10b6:208:19b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 07:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 07:43:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 02:43:56 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 15 Apr 2026 02:43:48 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Allen Li
 <Allen.Li@amd.com>, ChunTao Tso <chuntao.tso@amd.com>, Allen Li
 <allen.li@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 11/19] drm/amd/display: Add Replay/PSR active check in link
 loss status check
Date: Wed, 15 Apr 2026 15:39:50 +0800
Message-ID: <20260415074223.34848-12-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415074223.34848-1-chen-yu.chen@amd.com>
References: <20260415074223.34848-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|DS0PR12MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: 78916b19-955a-422f-c33c-08de9ac2c04c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: QsKIpR7XAR7zYTFdEQWYeDvAqLcwRnS4weJuG3+M3bmqMMzxa1a5oTiHQnDe2emaHZiBBIHIjXz4hvNSZv1zrWDX/eTWBVhpEuOkPI5DUf4xfzLUdkZXwIrmPOQC7Ck/EokN0jMl5fHH0J97IqH1Fq4XMSmHUw5BAysPpBPJybNs4bpWB7zZ0OKuUJeJqL85KQmJMOUALfrLIQ87Jjl3iBEnxkh35ZiIgY8yUnwSHAk99rkfyOuORuuJ1WMNMywO5Qp9MaRLmj4SRTX0iKifjtTd2w53xOMTpB5Ql7mTIqNFaRGDVmAZUn/S9ZI8xchI+xdcofyDLqF1d9A0jgd5/qMEV3pnrAsHLKeMb61RP/24gW4pZ2ht23OhISuSNUtBEzr0EH/jHjO8l9vs/4rsrrsBliwcX4capZYHXHqXOJJAf26JDVhStkbY75ULu/gzwGPY0a7eko/R7jnl9y8H5HJMvkCizaIRmSeEMChIWfWrb/rUHrvWeNLlY3zYnP/GD8StC05yXC0R3WZuAE8F9H98mecKU9iDXj0TAvFlZf/xhas3MXttyldKkgd2tFvFsys1v7QARtIhFgbqEqAOX/ZnPwK4pExR2S+Y+JUYiVuI0LevhCMF6eStiIc3JU05NcxfKkC4dcbLdCNfsdu0sW9EBpEPwf94265Ca7FCu7snKTkC5IULKQ6rhs+9UWly0q0nsUVwmXdDf1PK5hdCx1uJw4roebyNVAzPnpduIiYhU2d85JllcGCdBl5yCfovTvWMoyEJQhkjU8nnlv9rhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QtiSoiCZj6xS7JcFqjSy1vSFxa2leVV2/tAskoaHosNbjwVRzT99gEUrDUca9T5LwFWeN8gWdsgeI8BJ08/nheJyrWkVFekxrJY7N3ZDP0Y573eZlvZ0kJDFuKuS/zndINGrPEe8YOqUv7d1EYPiEFOpB62AX2Q7ABVnKf7Jhg3bRq0fYsSsKGyrMQrbL98NmcKjfirERlkX4vg17FIzF7Hp78vRaGKlprzZzK2zDNU14IwO6avhcWWOZgo4hscjNXR54n6ie8ajygzgDg5GwxSeq3b409vqPGmTmNbSfiRlRTUFUzW/Hs0KLfIHZ6+XdU1ySzOgZZDnjphl+9ivEKeBViRKkHSLvAdkUMeMGVSSZXbtYOsm3xdesfz6CqlCwpgphG/cf10PqQwimVRTI5j0AJxR36i8drFmgL6OyEqyGecMpsOqM0n9wwJ+WYfi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 07:43:57.3325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78916b19-955a-422f-c33c-08de9ac2c04c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6415
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

From: Allen Li <Allen.Li@amd.com>

[Why&How]
To avoid unnecessary link retraining when the panel is in Replay/PSR mode,
we need to check if it's in active state and ESD information before we
decide to retrain the link.

Reviewed-by: ChunTao Tso <chuntao.tso@amd.com>
Signed-off-by: Allen Li <allen.li@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../dc/link/protocols/link_dp_irq_handler.c   | 57 +++++++++++--------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index 1860d44f63c1..dd19b912c48c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -223,7 +223,7 @@ static void handle_hpd_irq_vesa_replay_sink(struct dc_link *link)
 	}
 }
 
-static void handle_hpd_irq_replay_sink(struct dc_link *link, bool *need_re_enable)
+static void handle_hpd_irq_replay_sink(struct dc_link *link, bool *need_re_enable, bool *replay_esd_detection_needed)
 {
 	union dpcd_replay_configuration replay_configuration = {0};
 	union dpcd_replay_configuration replay_sink_status = {0};
@@ -311,6 +311,14 @@ static void handle_hpd_irq_replay_sink(struct dc_link *link, bool *need_re_enabl
 			*need_re_enable = true;
 		}
 	}
+
+	if (!link->replay_settings.replay_allow_active &&
+	    replay_sink_status.bits.SINK_DEVICE_REPLAY_STATUS == 0x7) {
+	    /* If sink device replay status is 0x7 and replay is disabled,
+	     * it means sink is in a bad state and link retraining is needed to recover
+	     */
+	    *replay_esd_detection_needed = true;
+	}
 }
 
 void dp_handle_link_loss(struct dc_link *link)
@@ -469,6 +477,7 @@ bool dp_handle_hpd_rx_irq(struct dc_link *link,
 	enum dc_status result;
 	bool status = false;
 	bool replay_re_enable_needed = false;
+	bool replay_esd_detection_needed = false;
 
 	if (out_link_loss)
 		*out_link_loss = false;
@@ -482,6 +491,7 @@ bool dp_handle_hpd_rx_irq(struct dc_link *link,
 	DC_LOG_HW_HPD_IRQ("%s: Got short pulse HPD on link %d\n",
 		__func__, link->link_index);
 
+	handle_hpd_irq_replay_sink(link, &replay_re_enable_needed, &replay_esd_detection_needed);
 
 	 /* All the "handle_hpd_irq_xxx()" methods
 		 * should be called only after
@@ -528,8 +538,6 @@ bool dp_handle_hpd_rx_irq(struct dc_link *link,
 		/* PSR-related error was detected and handled */
 		return true;
 
-	handle_hpd_irq_replay_sink(link, &replay_re_enable_needed);
-
 	/* If PSR-related error handled, Main link may be off,
 	 * so do not handle as a normal sink status change interrupt.
 	 */
@@ -552,27 +560,30 @@ bool dp_handle_hpd_rx_irq(struct dc_link *link,
 	 * Downstream port status changed,
 	 * then DM should call DC to do the detection.
 	 * NOTE: Now includes eDP link loss detection and retraining
+	 * Link will be retrained if panel is not EDP or
+	 * Replay ESD recovery is needed.
 	 */
-
-	if (dp_parse_link_loss_status(
-			link,
-			&hpd_irq_dpcd_data)) {
-		/* Connectivity log: link loss */
-		CONN_DATA_LINK_LOSS(link,
-					hpd_irq_dpcd_data.raw,
-					sizeof(hpd_irq_dpcd_data),
-					"Status: ");
-
-		if (defer_handling && has_left_work)
-			*has_left_work = true;
-		else
-			dp_handle_link_loss(link);
-
-		status = false;
-		if (out_link_loss)
-			*out_link_loss = true;
-
-		dp_trace_link_loss_increment(link);
+	if (link->connector_signal != SIGNAL_TYPE_EDP || replay_esd_detection_needed) {
+		if (dp_parse_link_loss_status(
+				link,
+				&hpd_irq_dpcd_data)) {
+			/* Connectivity log: link loss */
+			CONN_DATA_LINK_LOSS(link,
+						hpd_irq_dpcd_data.raw,
+						sizeof(hpd_irq_dpcd_data),
+						"Status: ");
+
+			if (defer_handling && has_left_work)
+				*has_left_work = true;
+			else
+				dp_handle_link_loss(link);
+
+			status = false;
+			if (out_link_loss)
+				*out_link_loss = true;
+
+			dp_trace_link_loss_increment(link);
+		}
 	}
 
 	if (link->dpcd_caps.usb4_dp_tun_info.dp_tun_cap.bits.dp_tunneling) {
-- 
2.43.0

