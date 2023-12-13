Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23A0C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 06:13:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ED3B10E259;
	Wed, 13 Dec 2023 06:13:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 247C510E259
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 06:13:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKg5TByjwuoCxmP5w7MciTnLvNoTc4KpqQ4nmsGt73TLUFXgRvE4i7aYDqDTZaVQjo9xRAVYNVAeGkoG16WW9Wi71cpT59id1wn/E/J0L2GcwF96IvAuUPjeDD7VwoZvD4IjyNlsxB3y4751Xd/1Dm7+9SDSn5NPb8ZQSSTG7HUIfoxgWsxM8xrrtLndd3psnEKWf6e7mRbTfzfquW19MgrdMEOnEUEonzFjWiZ4Pv7NmMBF1Bl0IgpAsAzZrdV2hb56KrV01jF136Z6p8jmtRvR73WYL1+aP47+mJRCw5Pxff/gdyryHJmI5cAFvivub/R7qhkeLsP/hOHIegc8Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdvpaERh11yCGpNigjEdV0yW8sqHobTiyX1/8zQIF8Y=;
 b=CAOLYsjkKn6UkBBhfbqAXT5NqORRMS7JivbahGGtjSYCOSLAXZ893yZy2c1gUW+fAkMJBEUIspduXidiAk5lsI64JGf8taLjJAYmZ3+jPXkZZ6foNlVS1i0lTePPfBiHxqxH+xPQvvx8hfPNHTP36V9KWgBdtIo1N3FY0VnKUJdAnibkSB6nZeHd+bLFkpMmrXlVyc0oxuH9cq5h2Hv8WkqopXtADXVFhPuZXLDfAJBCPNdTWhJFP0vsuVfINNDSYkYQnoi/1/NhqR6GLXw8DU3iG1JQwnQEXK7HOSEVQKMohnomTep4MqxfUfzYaSYcK3a6rxg7Rij4I6/tDpnmAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdvpaERh11yCGpNigjEdV0yW8sqHobTiyX1/8zQIF8Y=;
 b=d3CswAQlylqIjhUaPUlp0KWDJtSDh9Q/XGu2TtLv91ktnzhZUhHrTd/5Swn2JZO4dZfnUDuD2twaadjzYsQGF+41aA9n3Al1BaID5p92V5uFwkoznxtPP+r3nx9rcQb5wQM12OWIPoBusa1fHkoWQvkWlN8leVcj78dGK7T+zAo=
Received: from MW2PR16CA0007.namprd16.prod.outlook.com (2603:10b6:907::20) by
 SJ2PR12MB9192.namprd12.prod.outlook.com (2603:10b6:a03:55d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26; Wed, 13 Dec 2023 06:12:58 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:907:0:cafe::bc) by MW2PR16CA0007.outlook.office365.com
 (2603:10b6:907::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Wed, 13 Dec 2023 06:12:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.7 via Frontend Transport; Wed, 13 Dec 2023 06:12:58 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 00:12:57 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 12 Dec
 2023 22:12:56 -0800
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 00:12:52 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/25] drm/amd/display: do not send commands to DMUB if DMUB
 is inactive from S3
Date: Wed, 13 Dec 2023 14:12:03 +0800
Message-ID: <20231213061227.1750663-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231213061227.1750663-1-Wayne.Lin@amd.com>
References: <20231213061227.1750663-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|SJ2PR12MB9192:EE_
X-MS-Office365-Filtering-Correlation-Id: 99bb8364-1688-45e7-17c4-08dbfba28dac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iDjtbXduE+igxaPPI86Tef44SH2QwJCwMAxkRw3bPiK+JNfXneTgbl20c8Y5EULJdLTl3e0kREUkn66apC5aes9vAeeTq7OdvIPj4zLEHEs0pOcCemFH/8RY8ddLIZI4yf+3tej0nsHDGDcmjE62s2mQdojd8nh7JhzTnlYbJNThRM/MR0oQgeSZLBXrvkdVdNLZTx8EYxukKoc4hTkirwPgqqviZOiP1s39BKQi9pu13KpH0L87qcdAaqPKQUR/eL319L1vHo4vhT+h8jO3LU3dxfRt/VvwbMMyoYia2I1RPYtpsgx7appkD0cDn6LFyEOCPk15fFCnYVx6nwD/WstMbJ1jld5uGwR7I9QGBfQ9hfHX6CI3QNbJcRbj6liMvXhd/v+RgtfgHI80cyTYoCdIK8FUWaiUNiy5RIGzwDBrxOf41LY0T1254NcKGgbj1hD6DGEubWClFLZbGZNVz1vfLO5xXcH4QUJ5NQDcGyILOx/GuPB7Ia/4UQhWEMKJgnxIk1FN2tlNClBcWHWB70/OLoO8OkjAsARXsEawK/yagDEIlZMyx5WNBFSrDZnZ0U5ofNMyA03iw+TWtc/C2ks0F6t3sDps+nDspsYgCEL38caDxbkbToLgzUysrNL0nav4oywcuHxkBUeX+9sl4r4wF8/pBpwn2GesXFGQPRsmCn2VNK6JgSays4Q0gpCHTiMatyMJvlwqqWJ0LuYA42U9V6od6zETbljT9RpDRShuiooZ3vvOCIh3ydcqD3vuBmlteTD0QHrcMdsyOMre0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(82310400011)(451199024)(186009)(1800799012)(64100799003)(36840700001)(46966006)(40470700004)(40480700001)(1076003)(2616005)(336012)(26005)(426003)(7696005)(6666004)(40460700003)(86362001)(81166007)(82740400003)(36756003)(356005)(5660300002)(8936002)(8676002)(4326008)(83380400001)(36860700001)(47076005)(54906003)(70206006)(70586007)(6916009)(41300700001)(2906002)(316002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 06:12:58.1634 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99bb8364-1688-45e7-17c4-08dbfba28dac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9192
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Samson Tam <samson.tam@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <samson.tam@amd.com>

[Why]
On resume from S3, may get apply_idle_optimizations call while DMUB
is inactive which will just time out.

[How]
Set and track power state in dmub_srv and check power state before
sending commands to DMUB.  Add interface in both dmub_srv and
dc_dmub_srv

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 14 +++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  2 ++
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 21 +++++++++++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 15 +++++++++++++
 5 files changed, 55 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9cce2e7b9208..84efa9e7c951 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2685,6 +2685,7 @@ static int dm_suspend(void *handle)
 	hpd_rx_irq_work_suspend(dm);
 
 	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
+	dc_dmub_srv_set_power_state(dm->dc->ctx->dmub_srv, DC_ACPI_CM_POWER_STATE_D3);
 
 	return 0;
 }
@@ -2880,6 +2881,7 @@ static int dm_resume(void *handle)
 		if (r)
 			DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
 
+		dc_dmub_srv_set_power_state(dm->dc->ctx->dmub_srv, DC_ACPI_CM_POWER_STATE_D0);
 		dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
 
 		dc_resume(dm->dc);
@@ -2930,6 +2932,7 @@ static int dm_resume(void *handle)
 	}
 
 	/* power on hardware */
+	dc_dmub_srv_set_power_state(dm->dc->ctx->dmub_srv, DC_ACPI_CM_POWER_STATE_D0);
 	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
 
 	/* program HPD filter */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 53400cc05b5b..1a4d615ccdec 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1268,3 +1268,17 @@ void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 		ASSERT(0);
 }
 
+void dc_dmub_srv_set_power_state(struct dc_dmub_srv *dc_dmub_srv, enum dc_acpi_cm_power_state powerState)
+{
+	struct dmub_srv *dmub;
+
+	if (!dc_dmub_srv)
+		return;
+
+	dmub = dc_dmub_srv->dmub;
+
+	if (powerState == DC_ACPI_CM_POWER_STATE_D0)
+		dmub_srv_set_power_state(dmub, DMUB_POWER_STATE_D0);
+	else
+		dmub_srv_set_power_state(dmub, DMUB_POWER_STATE_D3);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index d4a60f53faab..c25ce7546f71 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -102,4 +102,6 @@ void dc_dmub_srv_subvp_save_surf_addr(const struct dc_dmub_srv *dc_dmub_srv, con
 bool dc_dmub_srv_is_hw_pwr_up(struct dc_dmub_srv *dc_dmub_srv, bool wait);
 void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle);
 void dc_dmub_srv_exit_low_power_state(const struct dc *dc);
+
+void dc_dmub_srv_set_power_state(struct dc_dmub_srv *dc_dmub_srv, enum dc_acpi_cm_power_state powerState);
 #endif /* _DMUB_DC_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index df63aa8f01e9..d1a4ed6f5916 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -150,6 +150,13 @@ enum dmub_memory_access_type {
 	DMUB_MEMORY_ACCESS_DMA
 };
 
+/* enum dmub_power_state type - to track DC power state in dmub_srv */
+enum dmub_srv_power_state_type {
+	DMUB_POWER_STATE_UNDEFINED = 0,
+	DMUB_POWER_STATE_D0 = 1,
+	DMUB_POWER_STATE_D3 = 8
+};
+
 /**
  * struct dmub_region - dmub hw memory region
  * @base: base address for region, must be 256 byte aligned
@@ -485,6 +492,8 @@ struct dmub_srv {
 	/* Feature capabilities reported by fw */
 	struct dmub_feature_caps feature_caps;
 	struct dmub_visual_confirm_color visual_confirm_color;
+
+	enum dmub_srv_power_state_type power_state;
 };
 
 /**
@@ -889,6 +898,18 @@ enum dmub_status dmub_srv_clear_inbox0_ack(struct dmub_srv *dmub);
  */
 void dmub_srv_subvp_save_surf_addr(struct dmub_srv *dmub, const struct dc_plane_address *addr, uint8_t subvp_index);
 
+/**
+ * dmub_srv_set_power_state() - Track DC power state in dmub_srv
+ * @dmub: The dmub service
+ * @power_state: DC power state setting
+ *
+ * Store DC power state in dmub_srv.  If dmub_srv is in D3, then don't send messages to DMUB
+ *
+ * Return:
+ *   void
+ */
+void dmub_srv_set_power_state(struct dmub_srv *dmub, enum dmub_srv_power_state_type dmub_srv_power_state);
+
 #if defined(__cplusplus)
 }
 #endif
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index a329a6ecf4dd..53ac1c66dd86 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -713,6 +713,7 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 		dmub->hw_funcs.reset_release(dmub);
 
 	dmub->hw_init = true;
+	dmub->power_state = DMUB_POWER_STATE_D0;
 
 	return DMUB_STATUS_OK;
 }
@@ -766,6 +767,9 @@ enum dmub_status dmub_srv_cmd_queue(struct dmub_srv *dmub,
 	if (!dmub->hw_init)
 		return DMUB_STATUS_INVALID;
 
+	if (dmub->power_state != DMUB_POWER_STATE_D0)
+		return DMUB_STATUS_INVALID;
+
 	if (dmub->inbox1_rb.rptr > dmub->inbox1_rb.capacity ||
 	    dmub->inbox1_rb.wrpt > dmub->inbox1_rb.capacity) {
 		return DMUB_STATUS_HW_FAILURE;
@@ -784,6 +788,9 @@ enum dmub_status dmub_srv_cmd_execute(struct dmub_srv *dmub)
 	if (!dmub->hw_init)
 		return DMUB_STATUS_INVALID;
 
+	if (dmub->power_state != DMUB_POWER_STATE_D0)
+		return DMUB_STATUS_INVALID;
+
 	/**
 	 * Read back all the queued commands to ensure that they've
 	 * been flushed to framebuffer memory. Otherwise DMCUB might
@@ -1100,3 +1107,11 @@ void dmub_srv_subvp_save_surf_addr(struct dmub_srv *dmub, const struct dc_plane_
 				subvp_index);
 	}
 }
+
+void dmub_srv_set_power_state(struct dmub_srv *dmub, enum dmub_srv_power_state_type dmub_srv_power_state)
+{
+	if (!dmub || !dmub->hw_init)
+		return;
+
+	dmub->power_state = dmub_srv_power_state;
+}
-- 
2.37.3

