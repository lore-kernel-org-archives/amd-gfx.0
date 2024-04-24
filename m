Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89D6C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2448B10FE32;
	Wed, 24 Apr 2024 08:54:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cKSU5OA4";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9515110FE32
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:54:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYN1tKclrfTPJZwpgfNKJfwccOwg0rAwDWAKzfn5C14r7pKCHClPrstPQ+lr/HU2IXE8wZEe2YWXVoNTt3KhXOwaiQRKIZ3kkXqh+LoET50UUVvRHQoRxfaKKR+gOaUB1ele3vR9Mgo5qlyC+RbekipgDKQtiVDo5Wwjd53TiqB4YhxB1ocDzbMiRoxVWgwL4QLKbIOldvgzxpmkECshoOOCig4N/Hxmkxyr1AedMg8Kvmz3FStoNCiAefOHOh4YQF3TaNWK3ugLoLxsgxO3eFmrbioVyMI/cHAK2VsTVmjA/RWbssbRRWlHYDA73wRFk0vO0g8MGzeTzZT89I5gcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dB3nroOKySKwZLlNfiDGvBdSts9Y1Nz+zB0z6b6Ywro=;
 b=PQRDEDhG8zbuCioxWrR9FTM14N3lyuKK4VfEh4ZVTbMi4jleKvVR+W1Kbgy6stAyKumCkoVwM8K5J2RlcCEe6g5bvmL0Dzj7oUfXilJTNes4Rt3moNoAjEw2AfdIVz/t88X58eEFbL/IXbwrGyDIk4mJ5rC0/V3TxRU0mWAfgUnU1u5P8evs9GCU4XMM2i69tSGFbGzj5LQlDHHkW8n/apqdELPISWkdpVkWA2mvJz8FtgE5X1PK6H2zgBK7I2vqHEK/6KyWaUWpsOwusrexneSr0pKzEFG92IzxVGbbHKhnOVYMBewi3TbQyEvim1vZDAbJp+r3R9ul8qVBzY6Sbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dB3nroOKySKwZLlNfiDGvBdSts9Y1Nz+zB0z6b6Ywro=;
 b=cKSU5OA44UqQlJjwU3qX/RnZdyny/xzGzccUk/+oPW/hX187o2CPyKXOAFtV+JWl1yKyHcrMKir/AOe9gCazGUe3m88+T6R/286al7cfI3mHqP4XCy2Syyo0sU/BUsLXXWw6CqzxpCbW3iu+sDdN8Cp96VGotHZ0/9qevy/YS18=
Received: from MW4PR03CA0137.namprd03.prod.outlook.com (2603:10b6:303:8c::22)
 by CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:54:01 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:8c:cafe::b) by MW4PR03CA0137.outlook.office365.com
 (2603:10b6:303:8c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Wed, 24 Apr 2024 08:54:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:54:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:54:00 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:53:56 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Duncan Ma <duncan.ma@amd.com>
Subject: [PATCH 41/46] drm/amd/display: Notify idle link detection through
 shared state
Date: Wed, 24 Apr 2024 16:49:26 +0800
Message-ID: <20240424084931.2656128-42-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|CH3PR12MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: dff31fa0-e6d1-455f-103f-08dc643c1654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d7jmQSOlMoV+EHGa0jPCnFxHcM3YdVvdEsy63i3v690BlitR+BhazdVKvgJJ?=
 =?us-ascii?Q?w+V5O8R8Y8n613jH4XCbxmOwbdFewkYviktYLnd5cT+JnQ47VxuH7+uOeTeS?=
 =?us-ascii?Q?HGyGqc2n5/kjuBFCMJQM9/nAYpm4PrDnLobfvwtyivK1xkVYy9g+68b/km7+?=
 =?us-ascii?Q?eH10tjiM6CS88yXDE6yRLbuCHH50Rwr77zLZjhGDFpKAgVDk2bGyj7yPF7xU?=
 =?us-ascii?Q?iwNxwp9dNAJoFvFEzRlTs4dBng1yVceoDza5iaXNKyW0icW/TyFIJ9x1R68e?=
 =?us-ascii?Q?k4Qtv1A2dVl1FteqmNT/EpzbDv7nOi5ZtPmmWxgHyUaOmbTTHfTPzuQuhhFq?=
 =?us-ascii?Q?ne+XKDO5X+0KdSoTpPYzyWUWLGbo525bPFiHkLOC12lwGzOcTurmvJnDr0Go?=
 =?us-ascii?Q?e0D5C6V0WC6vNmMuYcSxCT2SH6+5qakTZMlZwsSB8jsRzXBLZwFJQkFtanWU?=
 =?us-ascii?Q?HMXD3WVK5iij2FBwrsgcXNJ9xMZs1B6qRZqJ/drUi02sTa2s/QmAklGQ6vEO?=
 =?us-ascii?Q?kkfhYW8bIweHbn3ultwfpL7HVipW1QLGU3HAr8nUUYKFZgKj5XOTAYFzHVNo?=
 =?us-ascii?Q?tiiOz7pNKOYdK5xFT6bKddMYlcmqzjGdjKqs+ULjEmd0apkTwY0ZNJ9Sg6JG?=
 =?us-ascii?Q?BerbgR44GrGHdy3Qs0sfgcJ0IlELRMSjUr8aWfd5GRDHexeORrVykXDDyfQb?=
 =?us-ascii?Q?KZVzLSkFA+EZ4VMu0QW9P/FXOjnGsgyRjHEOYLalW4+qFnav2GlG1Xd7lTfi?=
 =?us-ascii?Q?EGucxH25d3QdEWrSUVgg0vf3p4XcLcTfuDGgfgjB1oDApt+PbyGOybgOMGxB?=
 =?us-ascii?Q?doN5n344sHoZsoFbxC3t9QxwnpfLu+KcXHeGTkO2+VrCVv06KjW+FSp0liov?=
 =?us-ascii?Q?SFKKZvmWYFHghNHz/RiFiHz0PXBnr/LgRG6I1X8WMYBh3vvKU80KfVd4K2Gh?=
 =?us-ascii?Q?twgRBruhfYw0SJJEV+caHKKYRPExntiuozebgRgGzisStPGEV9QOWekAhRfm?=
 =?us-ascii?Q?UpCC69/ay1g4P3RWoSanVA054EzdqRdzLpbqklAjzFvvrsyKzdi/Y/U06CEu?=
 =?us-ascii?Q?icNfRmYLQzJ0dkIsUcA0IKUYPbTvDjo84j+xeBjuWCZtgaHdMZFwHnLW+LfF?=
 =?us-ascii?Q?AeJZVZPv0Bmmj6sFGV954xN/xJobxX1+QqL5tmFbzULnEPNvxrhtqP+BM2yJ?=
 =?us-ascii?Q?vLAdC1xEzxiQPU+qdfUywE0F5AL1LySZHGcDp4tJyl6xGbx0N9Oa/CCp10m9?=
 =?us-ascii?Q?o7QS1eEGVYke71YAj8JdtC1xHiC+jzdq4s2VB/Y6R0WXGhU0e21jHqOijniO?=
 =?us-ascii?Q?3cdq0XTaE4h8vQL/DeQZYKXgzliwGe/v83Ilm+sqPATijWHnFf1/SvfubFXl?=
 =?us-ascii?Q?H/oE1cY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:54:01.3628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dff31fa0-e6d1-455f-103f-08dc643c1654
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
We can hang in IPS2 checking DMCUB_SCRATCH0 for link detection state.

[How]
Replace the HW access with a check on the shared state bit. This will
work the same way as the SCRATCH0 but won't require a wake in the case
where link detection isn't required.

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 30 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  | 10 +++++++
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 15 +++++++++-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  2 ++
 5 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 33d3307f5c1c..364ef9ae32f1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1460,6 +1460,36 @@ void dc_dmub_srv_set_power_state(struct dc_dmub_srv *dc_dmub_srv, enum dc_acpi_c
 		dmub_srv_set_power_state(dmub, DMUB_POWER_STATE_D3);
 }
 
+bool dc_dmub_srv_should_detect(struct dc_dmub_srv *dc_dmub_srv)
+{
+	volatile const struct dmub_shared_state_ips_fw *ips_fw;
+	bool reallow_idle = false, should_detect = false;
+
+	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
+		return false;
+
+	if (dc_dmub_srv->dmub->shared_state &&
+	    dc_dmub_srv->dmub->meta_info.feature_bits.bits.shared_state_link_detection) {
+		ips_fw = &dc_dmub_srv->dmub->shared_state[DMUB_SHARED_SHARE_FEATURE__IPS_FW].data.ips_fw;
+		return ips_fw->signals.bits.detection_required;
+	}
+
+	/* Detection may require reading scratch 0 - exit out of idle prior to the read. */
+	if (dc_dmub_srv->idle_allowed) {
+		dc_dmub_srv_apply_idle_power_optimizations(dc_dmub_srv->ctx->dc, false);
+		reallow_idle = true;
+	}
+
+	should_detect = dmub_srv_should_detect(dc_dmub_srv->dmub);
+
+	/* Re-enter idle if we're not about to immediately redetect links. */
+	if (!should_detect && reallow_idle && dc_dmub_srv->idle_exit_counter == 0 &&
+	    !dc_dmub_srv->ctx->dc->debug.disable_dmub_reallow_idle)
+		dc_dmub_srv_apply_idle_power_optimizations(dc_dmub_srv->ctx->dc, true);
+
+	return should_detect;
+}
+
 void dc_dmub_srv_apply_idle_power_optimizations(const struct dc *dc, bool allow_idle)
 {
 	struct dc_dmub_srv *dc_dmub_srv = dc->ctx->dmub_srv;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 3297c5b33265..580940222777 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -111,6 +111,16 @@ void dc_dmub_srv_apply_idle_power_optimizations(const struct dc *dc, bool allow_
 
 void dc_dmub_srv_set_power_state(struct dc_dmub_srv *dc_dmub_srv, enum dc_acpi_cm_power_state powerState);
 
+/**
+ * @dc_dmub_srv_should_detect() - Checks if link detection is required.
+ *
+ * While in idle power states we may need driver to manually redetect in
+ * the case of a missing hotplug. Should be called from a polling timer.
+ *
+ * Return: true if redetection is required.
+ */
+bool dc_dmub_srv_should_detect(struct dc_dmub_srv *dc_dmub_srv);
+
 /**
  * dc_wake_and_execute_dmub_cmd() - Wrapper for DMUB command execution.
  *
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index cec8aa1face5..cd51c91a822b 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -529,6 +529,7 @@ struct dmub_srv {
 	uint32_t psp_version;
 
 	/* Feature capabilities reported by fw */
+	struct dmub_fw_meta_info meta_info;
 	struct dmub_feature_caps feature_caps;
 	struct dmub_visual_confirm_color visual_confirm_color;
 
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 7a0574e6c129..35096aa3d85b 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -496,6 +496,17 @@ struct dmub_visual_confirm_color {
 /* Offset from the end of the file to the dmub_fw_meta_info */
 #define DMUB_FW_META_OFFSET 0x24
 
+/**
+ * union dmub_fw_meta_feature_bits - Static feature bits for pre-initialization
+ */
+union dmub_fw_meta_feature_bits {
+	struct {
+		uint32_t shared_state_link_detection : 1; /**< 1 supports link detection via shared state */
+		uint32_t reserved : 31;
+	} bits; /**< status bits */
+	uint32_t all; /**< 32-bit access to status bits */
+};
+
 /**
  * struct dmub_fw_meta_info - metadata associated with fw binary
  *
@@ -521,6 +532,7 @@ struct dmub_fw_meta_info {
 	uint32_t shared_state_size; /**< size of the shared state region in bytes */
 	uint16_t shared_state_features; /**< number of shared state features */
 	uint16_t reserved2; /**< padding bytes */
+	union dmub_fw_meta_feature_bits feature_bits; /**< static feature bits */
 };
 
 /**
@@ -698,7 +710,8 @@ union dmub_shared_state_ips_fw_signals {
 		uint32_t ips1_commit : 1;  /**< 1 if in IPS1 */
 		uint32_t ips2_commit : 1; /**< 1 if in IPS2 */
 		uint32_t in_idle : 1; /**< 1 if DMCUB is in idle */
-		uint32_t reserved_bits : 29; /**< Reversed */
+		uint32_t detection_required : 1; /**< 1 if detection is required */
+		uint32_t reserved_bits : 28; /**< Reversed */
 	} bits;
 	uint32_t all;
 };
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 9bb4c51b1f5b..db16066bc893 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -510,6 +510,8 @@ enum dmub_status
 	fw_info = dmub_get_fw_meta_info(params);
 
 	if (fw_info) {
+		memcpy(&dmub->meta_info, fw_info, sizeof(*fw_info));
+
 		fw_state_size = fw_info->fw_region_size;
 		trace_buffer_size = fw_info->trace_buffer_size;
 
-- 
2.37.3

