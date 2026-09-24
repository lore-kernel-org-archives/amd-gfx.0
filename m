Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16573C98324
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:46:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 624FF10F72A;
	Thu, 24 Sep 2026 18:46:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cI9Z5eEf";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010056.outbound.protection.outlook.com
 [40.93.198.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D68610F72B
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suC/60KsOjsfmf17PU6yFdMfSqxDGoXn7MexSABU0CqHQDqNRSpaUaucJb/gLNwwIZme+f0jvRAsCLokfkQdeuRURTbBSmzzzvBJMUqFWm4Ze01080NY+mcEV1ILRYMWdLqnSSo55sMlaVGFfdXuvIADrBgUD3AqL+Yh/FVg5+vIW7gnlRbkv7IGOArGFNk+hwDsPNTcKLoHzx8oP1DGB8trMwZTb8a1kEhF6UbrmESGNkis5dXiMn7nVmbEW4+tEvNZ5/81Sn/EmRBgpY/SrTWC5mt1u+/BqdGT1c8rXEQfw1ihkco/lRf89CwWHgyCcfGxbhAsZvZInYuXtxK4cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiTy1ydJvdUVh8nMGqwiRgMEeCgMDrI7FTXzeYRT/8s=;
 b=Iu06J2lN3FsyT5IRZDGe43dz2DUXaN+aQZnUyWr39ndwDK4co/BBL1BZNqKFTHpn1oAQZqcD1c+FhRsurCWxaNd27F0/wBrCYcBVRB2B8nFtU6Yw2Kha2Ley145/gnTSRn2z7VKMNQY5B93V3gj3Dsw7qzKn3Ryamu+ZgqzWHW0XvS/q3JtX/gk6Txv/4JH1K9a6K9Y+CPAam7UcN9kSkVxkDAI3yvubF0eqSSyT3IO5dinxoXFJVq+G4DNdpvd0V1wy6I1RVtij1NXTCgOkjZ3NfOfxbU6OFXAxvAHXpiQC4cJdwokZZWjkHCFbnRGtxzIzrZcnvXnTqgTE3HCK1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiTy1ydJvdUVh8nMGqwiRgMEeCgMDrI7FTXzeYRT/8s=;
 b=cI9Z5eEfinn//axcvqKqGyDMxfnXqizCbBbbpwNwKw+mqaXe0FYzHyuD7N+dP77exjem8t8yp3H4tcZyyb3sS/CDAtwwQovQC9R7a79ZFppfjwtabJsBlyF85h/AKrUoMpK6k6KlPg9gc7XZQxCurgcDXDUVOkqsL1Oh+OFt73g=
Received: from SJ0P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::33)
 by CY5PR12MB6177.namprd12.prod.outlook.com (2603:10b6:930:26::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Thu, 24 Sep
 2026 18:46:22 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::7) by SJ0P220CA0022.outlook.office365.com
 (2603:10b6:a03:41b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:21 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:11 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 15/34] drm/amd/display: Add temporary programming for port
 control in dc_init
Date: Thu, 24 Sep 2026 14:45:28 -0400
Message-ID: <20260924184824.596894-16-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|CY5PR12MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: 73631cc7-945f-4cbb-ab47-08df1a6c20db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|10067099003|56012099006|3023799007|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 0vAfv2rDyCsU90sr36BRiizt6By5qYtDdUg4aPRttcHwGOdgPZV+GqDCelv7PLW9+NsL/T8wH00lmQYeT4KFD0CrXufCrufeMGNUoJXuMe0NzOiFocCGZxJWB+F8NdsyCw4lU3u5bdU3izCfgVjUdp4gsatHKKBu2mPWTTDV7EOL6mAC/oMoglx+fCNiIyinGNbfRNq4v3QLPUmsulKvP32pzNeK2EDbrhyUW8C31AFLnmbXMNbXPlFhQdcteAUWZPSlKbGae2G2FG3pvUXxj2NdH6GTmMDQbuhlAvdQ9n3LThnrnKUihFzJmfdeF+Y0hXcn7tWn1jX23xd8ornwyAL1lpK4O83mM7Q7bk2DmWgjKWFK/41WHWAJXafT0plRqI9TP65Onrvv8e76lM/tp4gqeClEjwm9nyYo08xMHgN4Ol/3/oAcLNc/8sB+zD22Qu2g8ixg9sr0yx1PvCxsR96fq2OsE/jgN5CKHXMYmKZemdEHSf47KUFp08eNOaPXIZ6mzkU9RPB/4A3KOWr6C+daTX6ewMR94/TpTi85HASNy7iBz8Is0jdIdHsZQFjGJ/2O92F8smZuDx6fusiBI3NV+RWtLwVz876aIQhzKqXZFk9RfWEdvyM54J5aR851ohimgIfNP/LP36S1+BX/zd2KAobhuTTc/FWNTm1BPsQgcIZf7IE9ffr/9PDJqSmxZG1p80NciCQpmcDzLJJYnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xnwPem5OCpJkPDzzs5Acekyyfw6gY6BYTNJuY+85tS4WtnmPkuWWGocBiWfOOreYuxLwXgpf8Neo1D76RM9BXKJrTfUcmrzeKoNeGR3jV2dgOj8yYFlFmKPMSthLDNfonSOaGBZ3Wsi9TB/fSBOKORvCaCG6EmaalnoEwHZTwArU0ZQ157SCmZoHsbEgdVxzbls0xX04rXixDnI79ctzp4czMoV1VYLDLwlj56fXlYDDO2fdCkKspGxgDfOY4EtGETPbA+3JIQBG5mELyFla8WCbJXzk+30XOJYEN/qMnV8JTJRXxytJHoB0sY+cM2l0Sll3VBNgQ6dN6B0F8VMtBEJ98/qLr6YjLFwSRcktHFtwEiaxJrXEms0qlK5ma85CT+Tl01YCJJgAYypv5rkscNa1U99jZfO1WcigexFtVBXOC43U24yciCR/O7zZHI8U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:21.8676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73631cc7-945f-4cbb-ab47-08df1a6c20db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6177
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
Add the POR setting for SDP_PORT_CONTROL into dc init sequence.
This is temporary until the initialization moves into pre-OS DMCUB.

Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
---
 .../gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c    | 8 ++++++++
 drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c   | 5 +++++
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h          | 2 ++
 3 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
index 639c71cf1123..843a0da4bdd7 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
@@ -1905,6 +1905,13 @@ static void hubbub60_override_utm_client_qc_profile(struct hubbub *hubbub, uint8
 	}
 }
 
+static void hubbub60_set_sdpif_port_control(struct hubbub *hubbub, bool ignore_cstate_req)
+{
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+
+	REG_UPDATE(DCHUBBUB_SDPIF_CFG0, SDPIF_PORT_CONTROL, ignore_cstate_req);
+}
+
 static const struct hubbub_funcs hubbub60_funcs = {
 	.update_dchub = hubbub2_update_dchub,
 	.init_dchub_sys_ctx = hubbub60_init_dchub_sys_ctx,
@@ -1970,6 +1977,7 @@ static const struct hubbub_funcs hubbub60_funcs = {
 		.reset_display_qos_profile =
 			hubbub60_reset_display_qos_profile,
 	},
+	.set_sdpif_port_control = hubbub60_set_sdpif_port_control,
 };
 
 void hubbub60_construct(struct dcn20_hubbub *hubbub2,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
index ef1c10bc9bfa..d515b9cbc934 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
@@ -885,6 +885,11 @@ void dcn60_init_hw(struct dc *dc)
 		dc->res_pool->hubbub->funcs->override_utm_client_qc_profile(dc->res_pool->hubbub, dc->debug.utm_client_qc_profiles[1], 1);
 		dc->res_pool->hubbub->funcs->override_utm_client_qc_profile(dc->res_pool->hubbub, dc->debug.utm_client_qc_profiles[2], 2);
 	}
+		/* Temporary init for SDP port control in driver.
+		 * Remove once programming is in pre-OS DMU init.
+		 */
+	if (dc->res_pool->hubbub->funcs->set_sdpif_port_control)
+		dc->res_pool->hubbub->funcs->set_sdpif_port_control(dc->res_pool->hubbub, false);
 
 	// Get DMCUB capabilities
 	if (dc->ctx->dmub_srv) {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index 8d1024a875a7..d68232f10f3e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -226,6 +226,8 @@ struct hubbub_funcs {
 
 	void (*hubbub_read_reg_state)(struct hubbub *hubbub, struct dcn_hubbub_reg_state *hubbub_reg_state);
 
+	void (*set_sdpif_port_control)(struct hubbub *hubbub, bool ignore_cstate_req);
+
 	/**
 	 * @program_det_size:
 	 *
-- 
2.53.0

