Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1BBD35663
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 02:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCC0A10E600;
	Wed, 28 Jan 2026 02:00:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V7AnMY+I";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011049.outbound.protection.outlook.com [52.101.52.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CDEC10E5FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 02:00:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/lJa0EKaOzu7PVW52j8dA5xEJ7IYn3XPVQjjGAhKOkPdHxjEPLIcpj0arprduo/Uuicyfldv3Obqsv6abAQ34vw54XpwUO+7f+8Wf4oObrrq0x87WY2e3Qu/UTbVUs2tAKUtUv4gonhGyWyClmSQ3yHcnLMUX0m3slBwFkBTmBG77213JKyj8wDUUIA0eH1kwwYM8/rSQDNBVp0VIHfTC0U2UTP+CpQ3cjcQ2Q/E7xGPY2InaJEvVJeYOtJ3wYHmB77ekUHrwpg+TvpcJGX6z41KZqR1DYDwePjQegjGdbEDLwrQPU4cuAQV2VtpQW9QOwX8y2JIDNrWCgeO1t8fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEXAYyIwX1/rnBkdTw/8Xr5CVIweKAXhxgZcSbgsEsE=;
 b=SKLO7DwCFjMaFPuLXo9gz77AjcyTSB49/QmJE1PAPWknENBaZFbR+n1O955pv0AXZ1YlEr96LGJkT3TMC6OtupAPlEtIM1HuNtK7qkx8ebiOdn700fTcB1JIb44/iHxd6SSxo4CwLqjDxgbdp33ewXB8chN+P3sopzhDi3UNbOLlDW3s/fF7VpgSy+2PIptYajYKFJTYyCyO00MDKoZHJCoFyoXakxnJZ12AeXGMAxMnWhn+HAdJc9190PHeT0RzbmlYCWW8+H2+Ho0VTfGNRskSM6scI8DTYdH3HtIu+TF72ZGaMPVDGXKZKMVCDHpV8AgEHkK9iOpm6YI/G7xFYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEXAYyIwX1/rnBkdTw/8Xr5CVIweKAXhxgZcSbgsEsE=;
 b=V7AnMY+I6V5zDqBCOTKSzMcpJPo8xMWlhsk4tazOUsCcFFNF88qZWR/r7hc4742Z6JMFptuVh5128jZLe4fvIhYnKfArB7+FZxRAJmfgIK6FvP5MaXmF6m2IuqFd7/Pp7t0fr+uNCU2BIA63yG8Ac+25lfgvgnvdJsm/K2o/6dU=
Received: from BY5PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:1e0::33)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 02:00:25 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::50) by BY5PR03CA0023.outlook.office365.com
 (2603:10b6:a03:1e0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Wed,
 28 Jan 2026 02:00:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 02:00:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 20:00:16 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 20:00:16 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 27 Jan 2026 20:00:13 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 16/21] drm/amd/display: Add CRC 32-bit mode support for DCN3.6+
Date: Wed, 28 Jan 2026 09:51:41 +0800
Message-ID: <20260128015538.568712-17-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128015538.568712-1-Wayne.Lin@amd.com>
References: <20260128015538.568712-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e0f3e4-bef8-45e5-7850-08de5e1100b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013|18082099003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DVyW2t7uA5D/QzKtKMiqk52G7joOE8fUZ/qRzGxIJ2nbi7ka5ihIOPaCA4wz?=
 =?us-ascii?Q?dbX6UKvZBJfdkCiWjSw+whrVm+keRhmGgrjz/C0Ostx7doDHA+oGxl/jhIB+?=
 =?us-ascii?Q?RyV3oPJrspF9BkfSIeTkOpGBME0sU+7jVeJtluDtvhndUfgvacSh+5kMebtp?=
 =?us-ascii?Q?WIlXHxFVhcWQuAj13pfh7l26NdNACpO7cuJp+ojTD57+MG4Dmsz+nZVM73ZD?=
 =?us-ascii?Q?rNuOF2HMjhp2a0C8UOhSfrQp62DYAVdOdvjUyUZ19nsCJaQ1FAK8FKV3TQCl?=
 =?us-ascii?Q?29Ki1jGrvUxlN8KzREKvqn51C9k1b/G9MMujfhe1m596bNaBopV9MIV6jDvx?=
 =?us-ascii?Q?fLFXCL91kB+dNh/rv6yGoh5EL/pQ5GjDGLy5TdndK1CKmMyguuW9LANVMxFO?=
 =?us-ascii?Q?dLtHjXK1rxVIWwofJtB9Tv58uocmg23pgjIVtbrDjRQN6QA1HjvYCSWI+KKE?=
 =?us-ascii?Q?XKKy4TFnRnBnAsEIAqMzS6yAU9RoKDI4k5gh7iuzvKJ4Sf19e97GSCn7VuhO?=
 =?us-ascii?Q?QDq2V8nOdqEPQgR1fN1wa0oe9+k5A5CI7+Vq/Mm+2bNGnIMm/ShHL3rcrggD?=
 =?us-ascii?Q?PVLSSTTvm5sommwoTlTbHjC4e7qBAMJFUDU/gT0dAPbMEh5G/P4senVZflcH?=
 =?us-ascii?Q?cfVRe/FgmWx+JPPH8ZrJcyAoWJlS3eJ3SMGktoFldM9knsFh0X/ZNysOsiVd?=
 =?us-ascii?Q?Cp2mY+7WPLFzTHBgkxjNC7z8oburmk1QUwSwcTyL3i3xf+3QUaddAMobagnW?=
 =?us-ascii?Q?OLZPG2wolYdYse0p3Jj3txfcsJSWoUOUnXc66nxVeW2FTVQrWy8pe4of9khd?=
 =?us-ascii?Q?B440jPdTSw7/MhUOsgxAkUzCvyEkudv7TIbrhYHd43d+GO+vJHvSxI0IneUR?=
 =?us-ascii?Q?4uhNz+7XtOxt1XYOKQiFYOe+h70GYWQkhYDdLpiSM8XR8Q82kK8JG0msgNTN?=
 =?us-ascii?Q?/9iu9XA7jjvlqI730DHFfXp1N6c3JFYgwL08zrG6mprv3x3TeoNrtbSF7iyK?=
 =?us-ascii?Q?gnyqfKquIBLbJrigR/Jl8Tuehzv8etIxeUVOnged1KiQ0T1knrHDm8MMQMMP?=
 =?us-ascii?Q?pZKCyS3WraiD2vpX+nGieKUsKdMXdhAZNVlqW2H2lXlIUzgNqboT+3rmCkbq?=
 =?us-ascii?Q?14llCnSOAbBzyxQriN25AD85MzfxkVwUq5kXpEwPx2X1//HBhHHs02cEKPhw?=
 =?us-ascii?Q?xShggS2OXa/RHAMrQbAc3IlqN0WXkHGMNhhLi1m0pazWJs4stQ/0q0CmQb/p?=
 =?us-ascii?Q?qRUhdU//ymcVsqZm7QqWQP3/a/Ivg6GslqPltKKJAPCCqTTjeVjXVZuRsAIx?=
 =?us-ascii?Q?J0aHXfw6DOYiJTRA7333VzhWAeVknF9UiuFYH9AIok/Zs1KpqBubpD6R+2Tu?=
 =?us-ascii?Q?b0KSr8B+qESz1BPV+U59cKimPrgywebz6JR1YjWSiF879FWYH2GSkCS2EM0t?=
 =?us-ascii?Q?ehrbivNzJVdG/+r/XD/mjCFDjMsTYxjOypAMX14A1OiISq7+Q8/WCorkFPKm?=
 =?us-ascii?Q?1Zc71PvDqbAine+3uITDELMUurIgPglWctLuiY3mUXj/mLEkCU3fhgAwCVMy?=
 =?us-ascii?Q?SnqTUug5obAaCtZHeEl0lGDvrVqmsWPFcYUSLUibsOfjxCytBdnP7U8lzH07?=
 =?us-ascii?Q?LjTi9VrTVrJ0s7PCqa0pTAB3Szo6SLYoReB/vwnrOtOhGGIdoDkkRzLwiLVh?=
 =?us-ascii?Q?k/BYeA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(18082099003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 02:00:25.1954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e0f3e4-bef8-45e5-7850-08de5e1100b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370
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

From: Chenyu Chen <chen-yu.chen@amd.com>

[Why]
DCN 3.6+ hardware supports CRC-32 polynomial in addition to the
legacy CRC-16. Enable 32-bit CRC values per color component for
improvement of precision in display validation.

[How]
When userspace sets crc_poly_mode (0=CRC-16, 1=CRC-32) via the debugfs
interface, the value is stored in dm_irq_params.crc_poly_mode. When CRC
source configuration triggers amdgpu_dm_crtc_configure_crc_source(),
crc_poly_mode is retrieved from dm_irq_params and passed to
dc_stream_configure_crc().

In the DC layer, dc_stream_configure_crc() sets crc_poly_mode into the
crc_params structure and passes it to optc35_configure_crc(). If the
hardware supports the OTG_CRC_POLY_SEL register, the register is
programmed to select CRC-16 or CRC-32 polynomial.

When reading CRC values, optc35_get_crc() checks whether CRC32 register
masks are available. If present, it reads 32-bit CRC values from
OTG_CRC0/1_DATA_R32/G32/B32 registers; otherwise, it falls back
to reading 16-bit CRC values from legacy OTG_CRC0/1_DATA_RG/B
registers.

Reviewed-by: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 15 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 46 +++++++++
 .../display/amdgpu_dm/amdgpu_dm_irq_params.h  |  1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  4 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  3 +-
 .../amd/display/dc/inc/hw/timing_generator.h  |  7 ++
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    | 19 +++-
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    | 96 ++++++++++++++++++-
 .../amd/display/dc/optc/dcn35/dcn35_optc.h    | 10 ++
 .../dc/resource/dcn36/dcn36_resource.c        | 12 ++-
 10 files changed, 203 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 5851f2d55dde..1b03f2bf8d7a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -506,6 +506,7 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 	struct amdgpu_dm_connector *aconnector = NULL;
 	bool enable = amdgpu_dm_is_valid_crc_source(source);
 	int ret = 0;
+	enum crc_poly_mode crc_poly_mode = CRC_POLY_MODE_16;
 
 	/* Configuration will be deferred to stream enable. */
 	if (!stream_state)
@@ -528,10 +529,18 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 		amdgpu_dm_replay_disable(stream_state);
 	}
 
+	/* CRC polynomial selection only support for DCN3.6+ except DCN4.0.1 */
+	if ((amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 6, 0)) &&
+		(amdgpu_ip_version(adev, DCE_HWIP, 0) != IP_VERSION(4, 0, 1))) {
+		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
+
+		crc_poly_mode = acrtc->dm_irq_params.crc_poly_mode;
+	}
+
 	/* Enable or disable CRTC CRC generation */
 	if (dm_is_crc_source_crtc(source) || source == AMDGPU_DM_PIPE_CRC_SOURCE_NONE) {
 		if (!dc_stream_configure_crc(stream_state->ctx->dc,
-					     stream_state, NULL, enable, enable, 0, true)) {
+					     stream_state, NULL, enable, enable, 0, true, crc_poly_mode)) {
 			ret = -EINVAL;
 			goto unlock;
 		}
@@ -877,7 +886,7 @@ void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc)
 			else if (adev->dm.secure_display_ctx.op_mode == DISPLAY_CRC_MODE)
 				/* update ROI via dm*/
 				dc_stream_configure_crc(stream_state->ctx->dc, stream_state,
-					&crc_window, true, true, i, false);
+					&crc_window, true, true, i, false, (enum crc_poly_mode)acrtc->dm_irq_params.crc_poly_mode);
 
 			reset_crc_frame_count[i] = true;
 
@@ -901,7 +910,7 @@ void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc)
 			else if (adev->dm.secure_display_ctx.op_mode == DISPLAY_CRC_MODE)
 				/* Avoid ROI window get changed, keep overwriting. */
 				dc_stream_configure_crc(stream_state->ctx->dc, stream_state,
-						&crc_window, true, true, i, false);
+						&crc_window, true, true, i, false, (enum crc_poly_mode)acrtc->dm_irq_params.crc_poly_mode);
 
 			/* crc ready for psp to read out */
 			crtc_ctx->crc_info.crc[i].crc_ready = true;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index cfe35442dfcb..d6d43f1bf6d2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3839,6 +3839,50 @@ static int crc_win_update_get(void *data, u64 *val)
 
 DEFINE_DEBUGFS_ATTRIBUTE(crc_win_update_fops, crc_win_update_get,
 			 crc_win_update_set, "%llu\n");
+
+/*
+ * Trigger to set crc polynomial mode
+ * 0: 16-bit CRC, 1: 32-bit CRC
+ * only accepts 0 or 1 for supported hwip versions
+ */
+static int crc_poly_mode_set(void *data, u64 val)
+{
+	struct drm_crtc *crtc = data;
+	struct amdgpu_crtc *acrtc;
+	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
+
+	if ((amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 6, 0)) &&
+		(amdgpu_ip_version(adev, DCE_HWIP, 0) != IP_VERSION(4, 0, 1)) &&
+		(val < 2)) {
+		acrtc = to_amdgpu_crtc(crtc);
+		mutex_lock(&adev->dm.dc_lock);
+		spin_lock_irq(&adev_to_drm(adev)->event_lock);
+		acrtc->dm_irq_params.crc_poly_mode = val;
+		spin_unlock_irq(&adev_to_drm(adev)->event_lock);
+		mutex_unlock(&adev->dm.dc_lock);
+	}
+
+	return 0;
+}
+
+/*
+ * Get crc polynomial mode (0: 16-bit CRC, 1: 32-bit CRC)
+ */
+static int crc_poly_mode_get(void *data, u64 *val)
+{
+	struct drm_crtc *crtc = data;
+	struct drm_device *drm_dev = crtc->dev;
+	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
+
+	spin_lock_irq(&drm_dev->event_lock);
+	*val = acrtc->dm_irq_params.crc_poly_mode;
+	spin_unlock_irq(&drm_dev->event_lock);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(crc_poly_mode_fops, crc_poly_mode_get,
+			 crc_poly_mode_set, "%llu\n");
 #endif
 void crtc_debugfs_init(struct drm_crtc *crtc)
 {
@@ -3858,6 +3902,8 @@ void crtc_debugfs_init(struct drm_crtc *crtc)
 				   &crc_win_y_end_fops);
 	debugfs_create_file_unsafe("crc_win_update", 0644, dir, crtc,
 				   &crc_win_update_fops);
+	debugfs_create_file_unsafe("crc_poly_mode", 0644, dir, crtc,
+				   &crc_poly_mode_fops);
 	dput(dir);
 #endif
 	debugfs_create_file("amdgpu_current_bpc", 0644, crtc->debugfs_entry,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
index 3c9995275cbd..f0c1b0c1faa9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
@@ -39,6 +39,7 @@ struct dm_irq_params {
 
 #ifdef CONFIG_DEBUG_FS
 	enum amdgpu_dm_pipe_crc_source crc_src;
+	int crc_poly_mode; /* enum crc_poly_mode from timing_generator.h */
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
 	struct crc_window_param window_param[MAX_CRC_WINDOW_NUM];
 	/* At least one CRC window is activated or not*/
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 441b7e0a3b22..e7d2b861dedd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -701,6 +701,7 @@ dc_stream_forward_multiple_crc_window(struct dc_stream_state *stream,
  *              once.
  * @idx: Capture CRC on which CRC engine instance
  * @reset: Reset CRC engine before the configuration
+ * @crc_poly_mode: CRC polynomial mode
  *
  * By default, the entire frame is used to calculate the CRC.
  *
@@ -709,7 +710,7 @@ dc_stream_forward_multiple_crc_window(struct dc_stream_state *stream,
  */
 bool dc_stream_configure_crc(struct dc *dc, struct dc_stream_state *stream,
 			     struct crc_params *crc_window, bool enable, bool continuous,
-			     uint8_t idx, bool reset)
+			     uint8_t idx, bool reset, enum crc_poly_mode crc_poly_mode)
 {
 	struct pipe_ctx *pipe;
 	struct crc_params param;
@@ -733,6 +734,7 @@ bool dc_stream_configure_crc(struct dc *dc, struct dc_stream_state *stream,
 	param.windowb_y_start = 0;
 	param.windowb_x_end = pipe->stream->timing.h_addressable;
 	param.windowb_y_end = pipe->stream->timing.v_addressable;
+	param.crc_poly_mode = crc_poly_mode;
 
 	if (crc_window) {
 		param.windowa_x_start = crc_window->windowa_x_start;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 719b98d8e8ca..9960494007ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -584,7 +584,8 @@ bool dc_stream_configure_crc(struct dc *dc,
 			     bool enable,
 			     bool continuous,
 			     uint8_t idx,
-			     bool reset);
+			     bool reset,
+			     enum crc_poly_mode crc_poly_mode);
 
 bool dc_stream_get_crc(struct dc *dc,
 		       struct dc_stream_state *stream,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index da7bf59c4b9d..671ab1fc7320 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -122,6 +122,12 @@ enum timing_synchronization_type {
 	VBLANK_SYNCHRONIZABLE
 };
 
+enum crc_poly_mode {
+	CRC_POLY_MODE_16,
+	CRC_POLY_MODE_32,
+	CRC_POLY_MODE_MAX,
+};
+
 struct crc_params {
 	/* Regions used to calculate CRC*/
 	uint16_t windowa_x_start;
@@ -144,6 +150,7 @@ struct crc_params {
 
 	uint8_t crc_eng_inst;
 	bool reset;
+	enum crc_poly_mode crc_poly_mode;
 };
 
 struct dcn_otg_state {
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
index 803bcc25601c..0b3f974f452e 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
@@ -244,7 +244,13 @@
 	uint32_t OTG_TRIGB_MANUAL_TRIG; \
 	uint32_t OTG_UPDATE_LOCK; \
 	uint32_t OTG_V_TOTAL_INT_STATUS; \
-	uint32_t OTG_VSYNC_NOM_INT_STATUS
+	uint32_t OTG_VSYNC_NOM_INT_STATUS; \
+	uint32_t OTG_CRC0_DATA_R32; \
+	uint32_t OTG_CRC0_DATA_G32; \
+	uint32_t OTG_CRC0_DATA_B32; \
+	uint32_t OTG_CRC1_DATA_R32; \
+	uint32_t OTG_CRC1_DATA_G32; \
+	uint32_t OTG_CRC1_DATA_B32
 
 
 struct dcn_optc_registers {
@@ -657,6 +663,15 @@ struct dcn_optc_registers {
 	type OTG_V_COUNT_STOP;\
 	type OTG_V_COUNT_STOP_TIMER;
 
+#define TG_REG_FIELD_LIST_DCN3_6(type) \
+	type OTG_CRC_POLY_SEL; \
+	type CRC0_R_CR32; \
+	type CRC0_G_Y32; \
+	type CRC0_B_CB32; \
+	type CRC1_R_CR32; \
+	type CRC1_G_Y32; \
+	type CRC1_B_CB32;
+
 #define TG_REG_FIELD_LIST_DCN401(type) \
 	type OPTC_SEGMENT_WIDTH_LAST;\
 	type OTG_PSTATE_KEEPOUT_START;\
@@ -670,6 +685,7 @@ struct dcn_optc_shift {
 	TG_REG_FIELD_LIST_DCN2_0(uint8_t)
 	TG_REG_FIELD_LIST_DCN3_2(uint8_t)
 	TG_REG_FIELD_LIST_DCN3_5(uint8_t)
+	TG_REG_FIELD_LIST_DCN3_6(uint8_t)
 	TG_REG_FIELD_LIST_DCN401(uint8_t)
 };
 
@@ -678,6 +694,7 @@ struct dcn_optc_mask {
 	TG_REG_FIELD_LIST_DCN2_0(uint32_t)
 	TG_REG_FIELD_LIST_DCN3_2(uint32_t)
 	TG_REG_FIELD_LIST_DCN3_5(uint32_t)
+	TG_REG_FIELD_LIST_DCN3_6(uint32_t)
 	TG_REG_FIELD_LIST_DCN401(uint32_t)
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index f699e95059f3..0953acbcc6d4 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -180,6 +180,96 @@ static void optc35_phantom_crtc_post_enable(struct timing_generator *optc)
 	REG_WAIT(OTG_CLOCK_CONTROL, OTG_BUSY, 0, 1, 100000);
 }
 
+/**
+ * optc35_get_crc - Capture CRC result per component
+ *
+ * @optc: timing_generator instance.
+ * @idx: index of crc engine to get CRC from
+ * @r_cr: primary CRC signature for red data.
+ * @g_y: primary CRC signature for green data.
+ * @b_cb: primary CRC signature for blue data.
+ *
+ * This function reads the CRC signature from the OPTC registers. Notice that
+ * we have three registers to keep the CRC result per color component (RGB).
+ *
+ * For different DCN versions:
+ * - If CRC32 registers (OTG_CRC0_DATA_R32/G32/B32) are available, read from
+ *   32-bit CRC registers. DCN 3.6+ supports both CRC-32 and CRC-16 polynomials
+ *   selectable via OTG_CRC_POLY_SEL.
+ * - Otherwise, read from legacy 16-bit CRC registers (OTG_CRC0_DATA_RG/B)
+ *   which only support CRC-16 polynomial.
+ *
+ * Returns:
+ * If CRC is disabled, return false; otherwise, return true, and the CRC
+ * results in the parameters.
+ */
+static bool optc35_get_crc(struct timing_generator *optc, uint8_t idx,
+		   uint32_t *r_cr, uint32_t *g_y, uint32_t *b_cb)
+{
+	uint32_t field = 0;
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+
+	REG_GET(OTG_CRC_CNTL, OTG_CRC_EN, &field);
+
+	/* Early return if CRC is not enabled for this CRTC */
+	if (!field)
+		return false;
+
+	if (optc1->tg_mask->CRC0_R_CR32 != 0 && optc1->tg_mask->CRC1_R_CR32 != 0 &&
+	    optc1->tg_mask->CRC0_G_Y32 != 0 && optc1->tg_mask->CRC1_G_Y32 != 0 &&
+	    optc1->tg_mask->CRC0_B_CB32 != 0 && optc1->tg_mask->CRC1_B_CB32 != 0) {
+		switch (idx) {
+		case 0:
+			/* OTG_CRC0_DATA_R32/G32/B32 has the CRC32 results */
+			REG_GET(OTG_CRC0_DATA_R32,
+				CRC0_R_CR32, r_cr);
+			REG_GET(OTG_CRC0_DATA_G32,
+				CRC0_G_Y32, g_y);
+			REG_GET(OTG_CRC0_DATA_B32,
+				CRC0_B_CB32, b_cb);
+			break;
+		case 1:
+			/* OTG_CRC1_DATA_R32/G32/B32 has the CRC32 results */
+			REG_GET(OTG_CRC1_DATA_R32,
+				CRC1_R_CR32, r_cr);
+			REG_GET(OTG_CRC1_DATA_G32,
+				CRC1_G_Y32, g_y);
+			REG_GET(OTG_CRC1_DATA_B32,
+				CRC1_B_CB32, b_cb);
+			break;
+		default:
+			return false;
+		}
+	} else {
+		switch (idx) {
+		case 0:
+			/* OTG_CRC0_DATA_RG has the CRC16 results for the red and green component */
+			REG_GET_2(OTG_CRC0_DATA_RG,
+				CRC0_R_CR, r_cr,
+				CRC0_G_Y, g_y);
+
+			/* OTG_CRC0_DATA_B has the CRC16 results for the blue component */
+			REG_GET(OTG_CRC0_DATA_B,
+				CRC0_B_CB, b_cb);
+			break;
+		case 1:
+			/* OTG_CRC1_DATA_RG has the CRC16 results for the red and green component */
+			REG_GET_2(OTG_CRC1_DATA_RG,
+				CRC1_R_CR, r_cr,
+				CRC1_G_Y, g_y);
+
+			/* OTG_CRC1_DATA_B has the CRC16 results for the blue component */
+			REG_GET(OTG_CRC1_DATA_B,
+				CRC1_B_CB, b_cb);
+			break;
+		default:
+			return false;
+			}
+	}
+
+	return true;
+}
+
 static bool optc35_configure_crc(struct timing_generator *optc,
 				 const struct crc_params *params)
 {
@@ -266,6 +356,10 @@ static bool optc35_configure_crc(struct timing_generator *optc,
 	default:
 		return false;
 	}
+	if (optc1->tg_mask->OTG_CRC_POLY_SEL != 0) {
+		REG_UPDATE(OTG_CRC_CNTL,
+				OTG_CRC_POLY_SEL, params->crc_poly_mode);
+	}
 	return true;
 }
 
@@ -488,7 +582,7 @@ static const struct timing_generator_funcs dcn35_tg_funcs = {
 		.is_optc_underflow_occurred = optc1_is_optc_underflow_occurred,
 		.clear_optc_underflow = optc1_clear_optc_underflow,
 		.setup_global_swap_lock = NULL,
-		.get_crc = optc1_get_crc,
+		.get_crc = optc35_get_crc,
 		.configure_crc = optc35_configure_crc,
 		.set_dsc_config = optc3_set_dsc_config,
 		.get_dsc_status = optc2_get_dsc_status,
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h
index 733a2f149d9a..5c2cb1f27783 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h
@@ -74,6 +74,16 @@
 	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_VUPDATE_KEEPOUT_STATUS, mask_sh),\
 	SF(OTG0_INTERRUPT_DEST, OTG0_IHC_OTG_VERTICAL_INTERRUPT2_DEST, mask_sh)
 
+#define OPTC_COMMON_MASK_SH_LIST_DCN3_6(mask_sh)\
+	OPTC_COMMON_MASK_SH_LIST_DCN3_5(mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_POLY_SEL, mask_sh),\
+	SF(OTG_CRC320_OTG_CRC0_DATA_R32, CRC0_R_CR32, mask_sh),\
+	SF(OTG_CRC320_OTG_CRC0_DATA_G32, CRC0_G_Y32, mask_sh),\
+	SF(OTG_CRC320_OTG_CRC0_DATA_B32, CRC0_B_CB32, mask_sh),\
+	SF(OTG_CRC320_OTG_CRC1_DATA_R32, CRC1_R_CR32, mask_sh),\
+	SF(OTG_CRC320_OTG_CRC1_DATA_G32, CRC1_G_Y32, mask_sh),\
+	SF(OTG_CRC320_OTG_CRC1_DATA_B32, CRC1_B_CB32, mask_sh)
+
 void dcn35_timing_generator_init(struct optc *optc1);
 
 void dcn35_timing_generator_set_fgcg(struct optc *optc1, bool enable);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index 6469d5fe2e6d..0ee16926db4e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -460,16 +460,22 @@ static const struct dcn30_mpc_mask mpc_mask = {
 };
 
 #define optc_regs_init(id)\
-	OPTC_COMMON_REG_LIST_DCN3_5_RI(id)
+	OPTC_COMMON_REG_LIST_DCN3_5_RI(id),\
+	SRI_ARR(OTG_CRC0_DATA_R32, OTG_CRC32, id),\
+	SRI_ARR(OTG_CRC0_DATA_G32, OTG_CRC32, id),\
+	SRI_ARR(OTG_CRC0_DATA_B32, OTG_CRC32, id),\
+	SRI_ARR(OTG_CRC1_DATA_R32, OTG_CRC32, id),\
+	SRI_ARR(OTG_CRC1_DATA_G32, OTG_CRC32, id),\
+	SRI_ARR(OTG_CRC1_DATA_B32, OTG_CRC32, id)
 
 static struct dcn_optc_registers optc_regs[4];
 
 static const struct dcn_optc_shift optc_shift = {
-	OPTC_COMMON_MASK_SH_LIST_DCN3_5(__SHIFT)
+	OPTC_COMMON_MASK_SH_LIST_DCN3_6(__SHIFT)
 };
 
 static const struct dcn_optc_mask optc_mask = {
-	OPTC_COMMON_MASK_SH_LIST_DCN3_5(_MASK)
+	OPTC_COMMON_MASK_SH_LIST_DCN3_6(_MASK)
 };
 
 #define hubp_regs_init(id)\
-- 
2.43.0

