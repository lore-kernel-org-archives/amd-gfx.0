Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CBCC3601E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 16:13:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7330D10E201;
	Wed,  2 Apr 2025 16:13:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HR11pU5y";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A325F10E82A
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 16:13:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYFtiXja/tfy2Fs4q2Q/sbesYcPdDtlfkqQuGiI0IETxaqDHpSubtyFspW+Cwx9Kohuyq9WdwP69Xre7KYUgEIy7dU1wjQLUMTSrZxnobIKIzChea9lGjB1UeHoWxxOyNAHQBNNP/7eSCF6CJoqsMrXT4Euws8E12PxZ1yNUgFAzAB5blvOzDs1Ms/3EHJFArywXYI2AD5sYAmGTK+6XHaY99q+wbqQYpPugArriBVSl8MC+PxamWCk15qbh6Mh7/fAvrqoibMRwgi0bMOS510EMy+cwhQXcvlyDGcUCM/qtcFNFumjK8PvBR0bCyAFusFySGqgkTv1DcMhcrW7I6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmFRPglYOpI2RR5fK7kBWTWMPaNP1oH5ojYzhomcWK4=;
 b=qF/lmDH4rJrbLcnXoTksIj/f2wmvIxWgGNAslQYYFVDiTf3x5Y4BSK+us+GC/bL9DobzuoFKo/2oMeMH9lvh1mjy4iH2aMKD40YKP22FrkBTfCNgML1YhBUrmOpw4kr5aP8+jyi9Zgnz1ZxJeUYIZwRjYp583EhVDeScDwNUGVARMVoTMwhszhGZt7bxClJwYVYGp1Fi1jCBMbRHM8RBAMxfUNAbmfvaC7hfW42kNwllSflYdMNhg9jlKF2fpN/qZU5hHF8q/s5gmmH9KZATdGCWbQ2WvC1TcP/V4ehDdHnXfG2cXPt1RXDW2aBw9bytCotysupCjkDXps9ygzCtJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmFRPglYOpI2RR5fK7kBWTWMPaNP1oH5ojYzhomcWK4=;
 b=HR11pU5yPERoIpsEGRQ8W/+7vfLyLFMpodb8QdW++r/APKAWoyYNOpJmZVpRskS6vVSwwJoLQ8uohffWVcVc315qQsJXymOx/jR1dSaML5haOiyYRnCrhaKJrEsPIX2l0q1fRDxme49/nO6Z0PYQhVsme5jhHZrbECZNaP/E3Zk=
Received: from CH3P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::29)
 by IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 16:13:40 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::2b) by CH3P221CA0005.outlook.office365.com
 (2603:10b6:610:1e7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.24 via Frontend Transport; Wed,
 2 Apr 2025 16:13:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 16:13:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 11:13:39 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 2 Apr 2025 11:13:39 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Dominik Kaszewski
 <dominik.kaszewski@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 03/16] drm/amd/display: HDCP Locality check using DMUB Fused IO
Date: Wed, 2 Apr 2025 12:13:07 -0400
Message-ID: <20250402161320.983072-4-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250402161320.983072-1-Roman.Li@amd.com>
References: <20250402161320.983072-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|IA1PR12MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: f03db08b-dda0-4ba1-f9c6-08dd720154de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PiJSsHp7L0I9WlLAE5xApPLjh6SyWVUCuvf2qbdnakkCkfXiEbAfAWKdm3ah?=
 =?us-ascii?Q?2M/DeEO5XJal6Od/MOdpa+ZZ+tvdfaRk5Skx3mN5+4gVA6ACGtjpwAxlvSUb?=
 =?us-ascii?Q?CJs8xMFrP0gI0IQLjAkMERifsTedsHbu89VxJ6rQ7es2rP7dHyhzuCGO9eb8?=
 =?us-ascii?Q?HG3nndDyY3V23vdTRLygDdah6UF6THjLpa9JEnVL9mvLAJSQ1YTUM31oUkzJ?=
 =?us-ascii?Q?bm+JFvtjNgZsR1x4u6Zex61UYx0/miYjDHopMSxkB9tIMJrP1vhkU9ul0bFA?=
 =?us-ascii?Q?4sUTPjRcoFC2JytQUtCWwDuKt6r5dmMy5DNF1vEoPepLlMbmGVJWE9HxCwlB?=
 =?us-ascii?Q?4kmPKq5gX0csJ26PjFQe6qD+3duZ3uCfVmk8U21l4OsBWTH6D8gbXk5GUHe7?=
 =?us-ascii?Q?UIl4c265F/O4OxhCHQl2Kwcidj7fNdhrzpnuOAy6qM8DjTfipRrDlCRT49A1?=
 =?us-ascii?Q?/31vvTqtdtz68E/cdTddnDAtoyHKBxL5fCSW1c7YFGcAaMuHaDb8a2YhHRoA?=
 =?us-ascii?Q?56HJ6g2/UWGe6/Uy+gV01Vg10fq/0JC+NIgZpUFO9o8n0zRhrft7dJglxnGi?=
 =?us-ascii?Q?IYWNcdQ6vp4MzukbWeSth1E1ZoQC2bUEiB6OEU19t7YfkTQuZo3xmRPlSzNC?=
 =?us-ascii?Q?KU+NgCE9zFUUkCzYc88t1wXPgB29Xe6xHPk160X88BI4id2iysKIIftuUM03?=
 =?us-ascii?Q?Ej6UYZUhE7H9JmWe/ars1C9/0CtURcXTd1R2nsFzq9y4HQgAS4JlgZ8ApDoC?=
 =?us-ascii?Q?JzX6MA+ciIhNqbG/86pLgzQZXEWF8Og3lFq2Vb9iXvTKBxGEMoWf9XjZeWwb?=
 =?us-ascii?Q?Gz3gk55v6K1DleAX65o6WndfcEhvv2AmJqOSZEkn7b7P0Smku0DtfZAHVt4a?=
 =?us-ascii?Q?n6FJ9z42x3QZW7NgNeVZaPGH9C31VAnMFdYsdyd2mAt5EFKVV8/uXSSDcMyl?=
 =?us-ascii?Q?7i+Z8oVTTwsBT2ib7vaXJrc4dEbLwfuQ7wlxSxLzqamFPkU/+bkMGQE+ddnR?=
 =?us-ascii?Q?REd9y9O/iOQFeYVT8E7qNZXGNbg/j4M6DBnIKvhRqMy6bdYuvA0QOcdsMSTY?=
 =?us-ascii?Q?DKhq/Yfb34vJdib/KeCGksNs/ECEodxTz6Gv2/kY5Fd0Bo/NNvXjdzuLuaun?=
 =?us-ascii?Q?AMQEojVz2CmBQ/HpEJEfuS11MYVWMehCPr7dxNyxvBT5SY52NVI1h5Y9s47U?=
 =?us-ascii?Q?2V+vftjy2gjwBcm9GffYRH9z0rNoHmc4ew3NI6OBFw5Bn8nIuDveLOTMZgyY?=
 =?us-ascii?Q?24fMUjpjm1Qf/oRFronBFcoP3rpJ7C0S800t9MOG/nz7S7keeTY8czCUkl8t?=
 =?us-ascii?Q?T7KatZ20VTRvrUk7YADg3UJAMWvh5QoZJGT8lVj5998DUo3bYX2JHygFIlVP?=
 =?us-ascii?Q?czRf+OQJwcMPFPAIWDG7FPW06hJoquUPUwNgdQbBYd1j5BETc0qieMLsp2ag?=
 =?us-ascii?Q?fWtid25TaxS0gAizPRmUTBFU+2hDqfjzp31ztAD2DTq4fMBVY6ueAg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 16:13:40.0286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f03db08b-dda0-4ba1-f9c6-08dd720154de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7663
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

From: Dominik Kaszewski <dominik.kaszewski@amd.com>

[Why]
HDCP locality check has strict timing requirements, currently broken
due to reliance on msleep which does not guarantee accuracy.
The PR moves the write-poll-read sequence into DMUB using new generic
Fused IO interface, where the timing accuracy is greatly improved.
New flow is enabled using DCN resource capability bit (none for now),
or using a debug flag.

[How]
* Extended mod_hdcp_config with new function for requesting DMUB
to execute a sequence of fused I2C/AUX commands and synchronously
wait until an outbox reply arrives or a timeout expires.
* If the timeout expires, send an abort to DMUB.
* Update HDCP to use the DMUB for locality check if supported.
* Add DC_HDCP_LC_FORCE_FW_ENABLE and DC_HDCP_LC_ENABLE_SW_FALLBACK.
* Make the first enable new flow regardless of resource capabilities.
* Make the second enable fallback to old SW flow.
* Clean up makefile source file listings for easier updates.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 148 ++++++++++++++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  16 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  56 ++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  13 ++
 drivers/gpu/drm/amd/display/dc/Makefile       |  41 +++--
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +
 drivers/gpu/drm/amd/display/dc/dc_fused_io.c  | 144 +++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_fused_io.h  |  31 ++++
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   8 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   2 +
 .../drm/amd/display/dmub/src/dmub_srv_stat.c  |   4 +
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |   1 +
 .../display/modules/hdcp/hdcp2_execution.c    |  53 +++++--
 .../display/modules/hdcp/hdcp2_transition.c   |  48 ++++--
 .../drm/amd/display/modules/hdcp/hdcp_ddc.c   |  73 +++++++++
 .../drm/amd/display/modules/inc/mod_hdcp.h    |  38 ++++-
 16 files changed, 617 insertions(+), 63 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_fused_io.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_fused_io.h

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5105d4b5e972..1533d0a623ce 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -114,6 +114,8 @@
 #include "modules/inc/mod_freesync.h"
 #include "modules/power/power_helpers.h"
 
+static_assert(AMDGPU_DMUB_NOTIFICATION_MAX == DMUB_NOTIFICATION_MAX, "AMDGPU_DMUB_NOTIFICATION_MAX mismatch");
+
 #define FIRMWARE_RENOIR_DMUB "amdgpu/renoir_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_RENOIR_DMUB);
 #define FIRMWARE_SIENNA_CICHLID_DMUB "amdgpu/sienna_cichlid_dmcub.bin"
@@ -748,6 +750,29 @@ static void dmub_aux_setconfig_callback(struct amdgpu_device *adev,
 		complete(&adev->dm.dmub_aux_transfer_done);
 }
 
+static void dmub_aux_fused_io_callback(struct amdgpu_device *adev,
+					struct dmub_notification *notify)
+{
+	if (!adev || !notify) {
+		ASSERT(false);
+		return;
+	}
+
+	const struct dmub_cmd_fused_request *req = &notify->fused_request;
+	const uint8_t ddc_line = req->u.aux.ddc_line;
+
+	if (ddc_line >= ARRAY_SIZE(adev->dm.fused_io)) {
+		ASSERT(false);
+		return;
+	}
+
+	struct fused_io_sync *sync = &adev->dm.fused_io[ddc_line];
+
+	static_assert(sizeof(*req) <= sizeof(sync->reply_data), "Size mismatch");
+	memcpy(sync->reply_data, req, sizeof(*req));
+	complete(&sync->replied);
+}
+
 /**
  * dmub_hpd_callback - DMUB HPD interrupt processing callback.
  * @adev: amdgpu_device pointer
@@ -884,6 +909,30 @@ static void dm_handle_hpd_work(struct work_struct *work)
 
 }
 
+static const char *dmub_notification_type_str(enum dmub_notification_type e)
+{
+	switch (e) {
+	case DMUB_NOTIFICATION_NO_DATA:
+		return "NO_DATA";
+	case DMUB_NOTIFICATION_AUX_REPLY:
+		return "AUX_REPLY";
+	case DMUB_NOTIFICATION_HPD:
+		return "HPD";
+	case DMUB_NOTIFICATION_HPD_IRQ:
+		return "HPD_IRQ";
+	case DMUB_NOTIFICATION_SET_CONFIG_REPLY:
+		return "SET_CONFIG_REPLY";
+	case DMUB_NOTIFICATION_DPIA_NOTIFICATION:
+		return "DPIA_NOTIFICATION";
+	case DMUB_NOTIFICATION_HPD_SENSE_NOTIFY:
+		return "HPD_SENSE_NOTIFY";
+	case DMUB_NOTIFICATION_FUSED_IO:
+		return "FUSED_IO";
+	default:
+		return "<unknown>";
+	}
+}
+
 #define DMUB_TRACE_MAX_READ 64
 /**
  * dm_dmub_outbox1_low_irq() - Handles Outbox interrupt
@@ -901,15 +950,6 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 	struct dmcub_trace_buf_entry entry = { 0 };
 	u32 count = 0;
 	struct dmub_hpd_work *dmub_hpd_wrk;
-	static const char *const event_type[] = {
-		"NO_DATA",
-		"AUX_REPLY",
-		"HPD",
-		"HPD_IRQ",
-		"SET_CONFIGC_REPLY",
-		"DPIA_NOTIFICATION",
-		"HPD_SENSE_NOTIFY",
-	};
 
 	do {
 		if (dc_dmub_srv_get_dmub_outbox0_msg(dm->dc, &entry)) {
@@ -939,7 +979,7 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 			}
 			if (!dm->dmub_callback[notify.type]) {
 				drm_warn(adev_to_drm(adev), "DMUB notification skipped due to no handler: type=%s\n",
-					event_type[notify.type]);
+					dmub_notification_type_str(notify.type));
 				continue;
 			}
 			if (dm->dmub_thread_offload[notify.type] == true) {
@@ -2107,6 +2147,12 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		adev->dm.dc->debug.using_dml21 = true;
 	}
 
+	if (amdgpu_dc_debug_mask & DC_HDCP_LC_FORCE_FW_ENABLE)
+		adev->dm.dc->debug.hdcp_lc_force_fw_enable = true;
+
+	if (amdgpu_dc_debug_mask & DC_HDCP_LC_ENABLE_SW_FALLBACK)
+		adev->dm.dc->debug.hdcp_lc_enable_sw_fallback = true;
+
 	adev->dm.dc->debug.visual_confirm = amdgpu_dc_visual_confirm;
 
 	/* TODO: Remove after DP2 receiver gets proper support of Cable ID feature */
@@ -2189,6 +2235,15 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 			drm_err(adev_to_drm(adev), "amdgpu: fail to register dmub aux callback");
 			goto error;
 		}
+
+		for (size_t i = 0; i < ARRAY_SIZE(adev->dm.fused_io); i++)
+			init_completion(&adev->dm.fused_io[i].replied);
+
+		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_FUSED_IO,
+			dmub_aux_fused_io_callback, false)) {
+			drm_err(adev, "amdgpu: fail to register dmub fused io callback");
+			goto error;
+		}
 		/* Enable outbox notification only after IRQ handlers are registered and DMUB is alive.
 		 * It is expected that DMUB will resend any pending notifications at this point. Note
 		 * that hpd and hpd_irq handler registration are deferred to register_hpd_handlers() to
@@ -12777,6 +12832,79 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(
 	return ret;
 }
 
+static void abort_fused_io(
+		struct dc_context *ctx,
+		const struct dmub_cmd_fused_request *request
+)
+{
+	union dmub_rb_cmd command = { 0 };
+	struct dmub_rb_cmd_fused_io *io = &command.fused_io;
+
+	io->header.type = DMUB_CMD__FUSED_IO;
+	io->header.sub_type = DMUB_CMD__FUSED_IO_ABORT;
+	io->header.payload_bytes = sizeof(*io) - sizeof(io->header);
+	io->request = *request;
+	dm_execute_dmub_cmd(ctx, &command, DM_DMUB_WAIT_TYPE_NO_WAIT);
+}
+
+static bool execute_fused_io(
+		struct amdgpu_device *dev,
+		struct dc_context *ctx,
+		union dmub_rb_cmd *commands,
+		uint8_t count,
+		uint32_t timeout_us
+)
+{
+	const uint8_t ddc_line = commands[0].fused_io.request.u.aux.ddc_line;
+
+	if (ddc_line >= ARRAY_SIZE(dev->dm.fused_io))
+		return false;
+
+	struct fused_io_sync *sync = &dev->dm.fused_io[ddc_line];
+	struct dmub_rb_cmd_fused_io *first = &commands[0].fused_io;
+	const bool result = dm_execute_dmub_cmd_list(ctx, count, commands, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY)
+			&& first->header.ret_status
+			&& first->request.status == FUSED_REQUEST_STATUS_SUCCESS;
+
+	if (!result)
+		return false;
+
+	while (wait_for_completion_timeout(&sync->replied, usecs_to_jiffies(timeout_us))) {
+		reinit_completion(&sync->replied);
+
+		struct dmub_cmd_fused_request *reply = (struct dmub_cmd_fused_request *) sync->reply_data;
+
+		static_assert(sizeof(*reply) <= sizeof(sync->reply_data), "Size mismatch");
+
+		if (reply->identifier == first->request.identifier) {
+			first->request = *reply;
+			return true;
+		}
+	}
+
+	reinit_completion(&sync->replied);
+	first->request.status = FUSED_REQUEST_STATUS_TIMEOUT;
+	abort_fused_io(ctx, &first->request);
+	return false;
+}
+
+bool amdgpu_dm_execute_fused_io(
+		struct amdgpu_device *dev,
+		struct dc_link *link,
+		union dmub_rb_cmd *commands,
+		uint8_t count,
+		uint32_t timeout_us)
+{
+	struct amdgpu_display_manager *dm = &dev->dm;
+
+	mutex_lock(&dm->dpia_aux_lock);
+
+	const bool result = execute_fused_io(dev, link->ctx, commands, count, timeout_us);
+
+	mutex_unlock(&dm->dpia_aux_lock);
+	return result;
+}
+
 int amdgpu_dm_process_dmub_set_config_sync(
 		struct dc_context *ctx,
 		unsigned int link_index,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 53e49c1d0ce0..f84d6cd4f733 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -50,7 +50,7 @@
 
 #define AMDGPU_DM_MAX_NUM_EDP 2
 
-#define AMDGPU_DMUB_NOTIFICATION_MAX 7
+#define AMDGPU_DMUB_NOTIFICATION_MAX 8
 
 #define HDMI_AMD_VENDOR_SPECIFIC_DATA_BLOCK_IEEE_REGISTRATION_ID 0x00001A
 #define AMD_VSDB_VERSION_3_FEATURECAP_REPLAYMODE 0x40
@@ -81,6 +81,7 @@ struct amdgpu_bo;
 struct dmub_srv;
 struct dc_plane_state;
 struct dmub_notification;
+struct dmub_cmd_fused_request;
 
 struct amd_vsdb_block {
 	unsigned char ieee_id[3];
@@ -637,6 +638,11 @@ struct amdgpu_display_manager {
 	 * OEM i2c bus
 	 */
 	struct amdgpu_i2c_adapter *oem_i2c;
+
+	struct fused_io_sync {
+		struct completion replied;
+		char reply_data[0x40];  // Cannot include dmub_cmd here
+	} fused_io[8];
 };
 
 enum dsc_clock_force_state {
@@ -1016,6 +1022,14 @@ extern const struct drm_encoder_helper_funcs amdgpu_dm_encoder_helper_funcs;
 int amdgpu_dm_process_dmub_aux_transfer_sync(struct dc_context *ctx, unsigned int link_index,
 					struct aux_payload *payload, enum aux_return_code_type *operation_result);
 
+bool amdgpu_dm_execute_fused_io(
+		struct amdgpu_device *dev,
+		struct dc_link *link,
+		union dmub_rb_cmd *commands,
+		uint8_t count,
+		uint32_t timeout_us
+);
+
 int amdgpu_dm_process_dmub_set_config_sync(struct dc_context *ctx, unsigned int link_index,
 					struct set_config_cmd_payload *payload, enum set_config_status *operation_result);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index a3e93b2891f0..2bd8dee1b7c2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -26,6 +26,7 @@
 #include "amdgpu_dm_hdcp.h"
 #include "amdgpu.h"
 #include "amdgpu_dm.h"
+#include "dc_fused_io.h"
 #include "dm_helpers.h"
 #include <drm/display/drm_hdcp_helper.h>
 #include "hdcp_psp.h"
@@ -76,6 +77,34 @@ lp_read_dpcd(void *handle, uint32_t address, uint8_t *data, uint32_t size)
 	return dm_helpers_dp_read_dpcd(link->ctx, link, address, data, size);
 }
 
+static bool lp_atomic_write_poll_read_i2c(
+		void *handle,
+		const struct mod_hdcp_atomic_op_i2c *write,
+		const struct mod_hdcp_atomic_op_i2c *poll,
+		struct mod_hdcp_atomic_op_i2c *read,
+		uint32_t poll_timeout_us,
+		uint8_t poll_mask_msb
+)
+{
+	struct dc_link *link = handle;
+
+	return dm_atomic_write_poll_read_i2c(link, write, poll, read, poll_timeout_us, poll_mask_msb);
+}
+
+static bool lp_atomic_write_poll_read_aux(
+		void *handle,
+		const struct mod_hdcp_atomic_op_aux *write,
+		const struct mod_hdcp_atomic_op_aux *poll,
+		struct mod_hdcp_atomic_op_aux *read,
+		uint32_t poll_timeout_us,
+		uint8_t poll_mask_msb
+)
+{
+	struct dc_link *link = handle;
+
+	return dm_atomic_write_poll_read_aux(link, write, poll, read, poll_timeout_us, poll_mask_msb);
+}
+
 static uint8_t *psp_get_srm(struct psp_context *psp, uint32_t *srm_version, uint32_t *srm_size)
 {
 	struct ta_hdcp_shared_memory *hdcp_cmd;
@@ -719,7 +748,10 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev,
 		INIT_DELAYED_WORK(&hdcp_work[i].watchdog_timer_dwork, event_watchdog_timer);
 		INIT_DELAYED_WORK(&hdcp_work[i].property_validate_dwork, event_property_validate);
 
-		hdcp_work[i].hdcp.config.psp.handle = &adev->psp;
+		struct mod_hdcp_config *config = &hdcp_work[i].hdcp.config;
+		struct mod_hdcp_ddc_funcs *ddc_funcs = &config->ddc.funcs;
+
+		config->psp.handle = &adev->psp;
 		if (dc->ctx->dce_version == DCN_VERSION_3_1 ||
 		    dc->ctx->dce_version == DCN_VERSION_3_14 ||
 		    dc->ctx->dce_version == DCN_VERSION_3_15 ||
@@ -727,12 +759,22 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev,
 		    dc->ctx->dce_version == DCN_VERSION_3_51 ||
 		    dc->ctx->dce_version == DCN_VERSION_3_6 ||
 		    dc->ctx->dce_version == DCN_VERSION_3_16)
-			hdcp_work[i].hdcp.config.psp.caps.dtm_v3_supported = 1;
-		hdcp_work[i].hdcp.config.ddc.handle = dc_get_link_at_index(dc, i);
-		hdcp_work[i].hdcp.config.ddc.funcs.write_i2c = lp_write_i2c;
-		hdcp_work[i].hdcp.config.ddc.funcs.read_i2c = lp_read_i2c;
-		hdcp_work[i].hdcp.config.ddc.funcs.write_dpcd = lp_write_dpcd;
-		hdcp_work[i].hdcp.config.ddc.funcs.read_dpcd = lp_read_dpcd;
+			config->psp.caps.dtm_v3_supported = 1;
+		config->ddc.handle = dc_get_link_at_index(dc, i);
+
+		ddc_funcs->write_i2c = lp_write_i2c;
+		ddc_funcs->read_i2c = lp_read_i2c;
+		ddc_funcs->write_dpcd = lp_write_dpcd;
+		ddc_funcs->read_dpcd = lp_read_dpcd;
+
+		config->debug.lc_enable_sw_fallback = dc->debug.hdcp_lc_enable_sw_fallback;
+		if (dc->caps.fused_io_supported || dc->debug.hdcp_lc_force_fw_enable) {
+			ddc_funcs->atomic_write_poll_read_i2c = lp_atomic_write_poll_read_i2c;
+			ddc_funcs->atomic_write_poll_read_aux = lp_atomic_write_poll_read_aux;
+		} else {
+			ddc_funcs->atomic_write_poll_read_i2c = NULL;
+			ddc_funcs->atomic_write_poll_read_aux = NULL;
+		}
 
 		memset(hdcp_work[i].aconnector, 0,
 		       sizeof(struct amdgpu_dm_connector *) *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 2cd35392e2da..62954b351ebd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -630,6 +630,19 @@ bool dm_helpers_submit_i2c(
 	return result;
 }
 
+bool dm_helpers_execute_fused_io(
+		struct dc_context *ctx,
+		struct dc_link *link,
+		union dmub_rb_cmd *commands,
+		uint8_t count,
+		uint32_t timeout_us
+)
+{
+	struct amdgpu_device *dev = ctx->driver_context;
+
+	return amdgpu_dm_execute_fused_io(dev, link, commands, count, timeout_us);
+}
+
 static bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
 		bool is_write_cmd,
 		unsigned char cmd,
diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 3e1f5b689718..3c9ecea7eebc 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -53,31 +53,30 @@ DC_LIBS += hdcp
 
 ifdef CONFIG_DRM_AMD_DC_FP
 DC_LIBS += sspl
-DC_SPL_TRANS += dc_spl_translate.o
+AMD_DISPLAY_FILES += $(addprefix $(AMDDALPATH)/dc/, dc_spl_translate.o)
 endif
 
 AMD_DC = $(addsuffix /Makefile, $(addprefix $(FULL_AMD_DISPLAY_PATH)/dc/,$(DC_LIBS)))
 
 include $(AMD_DC)
 
-DISPLAY_CORE = dc.o dc_stat.o dc_resource.o dc_hw_sequencer.o dc_sink.o \
-dc_surface.o dc_debug.o dc_stream.o dc_link_enc_cfg.o dc_link_exports.o dc_state.o
+FILES =
+FILES += dc_dmub_srv.o
+FILES += dc_edid_parser.o
+FILES += dc_fused_io.o
+FILES += dc_helper.o
+FILES += core/dc.o
+FILES += core/dc_debug.o
+FILES += core/dc_hw_sequencer.o
+FILES += core/dc_link_enc_cfg.o
+FILES += core/dc_link_exports.o
+FILES += core/dc_resource.o
+FILES += core/dc_sink.o
+FILES += core/dc_stat.o
+FILES += core/dc_state.o
+FILES += core/dc_stream.o
+FILES += core/dc_surface.o
+FILES += core/dc_vm_helper.o
+
+AMD_DISPLAY_FILES += $(addprefix $(AMDDALPATH)/dc/, $(FILES))
 
-DISPLAY_CORE += dc_vm_helper.o
-
-AMD_DISPLAY_CORE = $(addprefix $(AMDDALPATH)/dc/core/,$(DISPLAY_CORE))
-
-AMD_DM_REG_UPDATE = $(addprefix $(AMDDALPATH)/dc/,dc_helper.o)
-
-AMD_DC_SPL_TRANS = $(addprefix $(AMDDALPATH)/dc/,$(DC_SPL_TRANS))
-
-AMD_DISPLAY_FILES += $(AMD_DISPLAY_CORE)
-AMD_DISPLAY_FILES += $(AMD_DM_REG_UPDATE)
-
-DC_DMUB += dc_dmub_srv.o
-DC_EDID += dc_edid_parser.o
-AMD_DISPLAY_DMUB = $(addprefix $(AMDDALPATH)/dc/,$(DC_DMUB))
-AMD_DISPLAY_EDID = $(addprefix $(AMDDALPATH)/dc/,$(DC_EDID))
-AMD_DISPLAY_FILES += $(AMD_DISPLAY_DMUB) $(AMD_DISPLAY_EDID)
-
-AMD_DISPLAY_FILES += $(AMD_DC_SPL_TRANS)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a24d004f8b57..c989bb9798dd 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -282,6 +282,7 @@ struct dc_caps {
 	bool edp_dsc_support;
 	bool vbios_lttpr_aware;
 	bool vbios_lttpr_enable;
+	bool fused_io_supported;
 	uint32_t max_otg_num;
 	uint32_t max_cab_allocation_bytes;
 	uint32_t cache_line_size;
@@ -903,6 +904,9 @@ struct dc_debug_options {
 	bool voltage_align_fclk;
 	bool disable_min_fclk;
 
+	bool hdcp_lc_force_fw_enable;
+	bool hdcp_lc_enable_sw_fallback;
+
 	bool disable_dfs_bypass;
 	bool disable_dpp_power_gate;
 	bool disable_hubp_power_gate;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_fused_io.c b/drivers/gpu/drm/amd/display/dc/dc_fused_io.c
new file mode 100644
index 000000000000..fff41b0a0a5a
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dc_fused_io.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2025 Advanced Micro Devices, Inc.
+
+#include "dc_fused_io.h"
+
+#include "dm_helpers.h"
+#include "gpio.h"
+
+static bool op_i2c_convert(
+		union dmub_rb_cmd *cmd,
+		const struct mod_hdcp_atomic_op_i2c *op,
+		enum dmub_cmd_fused_request_type type,
+		uint32_t ddc_line
+)
+{
+	struct dmub_cmd_fused_request *req = &cmd->fused_io.request;
+	struct dmub_cmd_fused_request_location_i2c *loc = &req->u.i2c;
+
+	if (!op || op->size > sizeof(req->buffer))
+		return false;
+
+	req->type = type;
+	loc->is_aux = false;
+	loc->ddc_line = ddc_line;
+	loc->address = op->address;
+	loc->offset = op->offset;
+	loc->length = op->size;
+	memcpy(req->buffer, op->data, op->size);
+
+	return true;
+}
+
+static bool op_aux_convert(
+		union dmub_rb_cmd *cmd,
+		const struct mod_hdcp_atomic_op_aux *op,
+		enum dmub_cmd_fused_request_type type,
+		uint32_t ddc_line
+)
+{
+	struct dmub_cmd_fused_request *req = &cmd->fused_io.request;
+	struct dmub_cmd_fused_request_location_aux *loc = &req->u.aux;
+
+	if (!op || op->size > sizeof(req->buffer))
+		return false;
+
+	req->type = type;
+	loc->is_aux = true;
+	loc->ddc_line = ddc_line;
+	loc->address = op->address;
+	loc->length = op->size;
+	memcpy(req->buffer, op->data, op->size);
+
+	return true;
+}
+
+static bool atomic_write_poll_read(
+		struct dc_link *link,
+		union dmub_rb_cmd commands[3],
+		uint32_t poll_timeout_us,
+		uint8_t poll_mask_msb
+)
+{
+	const uint8_t count = 3;
+	const uint32_t timeout_per_request_us = 10000;
+	const uint32_t timeout_per_aux_transaction_us = 10000;
+	uint64_t timeout_us = 0;
+
+	commands[1].fused_io.request.poll_mask_msb = poll_mask_msb;
+	commands[1].fused_io.request.timeout_us = poll_timeout_us;
+
+	for (uint8_t i = 0; i < count; i++) {
+		struct dmub_rb_cmd_fused_io *io = &commands[i].fused_io;
+
+		io->header.type = DMUB_CMD__FUSED_IO;
+		io->header.sub_type = DMUB_CMD__FUSED_IO_EXECUTE;
+		io->header.multi_cmd_pending = i != count - 1;
+		io->header.payload_bytes = sizeof(commands[i].fused_io) - sizeof(io->header);
+
+		timeout_us += timeout_per_request_us + io->request.timeout_us;
+		if (!io->request.timeout_us && io->request.u.aux.is_aux)
+			timeout_us += timeout_per_aux_transaction_us * (io->request.u.aux.length / 16);
+	}
+
+	if (!dm_helpers_execute_fused_io(link->ctx, link, commands, count, timeout_us))
+		return false;
+
+	return commands[0].fused_io.request.status == FUSED_REQUEST_STATUS_SUCCESS;
+}
+
+bool dm_atomic_write_poll_read_i2c(
+		struct dc_link *link,
+		const struct mod_hdcp_atomic_op_i2c *write,
+		const struct mod_hdcp_atomic_op_i2c *poll,
+		struct mod_hdcp_atomic_op_i2c *read,
+		uint32_t poll_timeout_us,
+		uint8_t poll_mask_msb
+)
+{
+	if (!link)
+		return false;
+
+	const uint32_t ddc_line = link->ddc->ddc_pin->pin_data->en;
+	union dmub_rb_cmd commands[3] = { 0 };
+	const bool converted = op_i2c_convert(&commands[0], write, FUSED_REQUEST_WRITE, ddc_line)
+			&& op_i2c_convert(&commands[1], poll, FUSED_REQUEST_POLL, ddc_line)
+			&& op_i2c_convert(&commands[2], read, FUSED_REQUEST_READ, ddc_line);
+
+	if (!converted)
+		return false;
+
+	const bool result = atomic_write_poll_read(link, commands, poll_timeout_us, poll_mask_msb);
+
+	memcpy(read->data, commands[0].fused_io.request.buffer, read->size);
+	return result;
+}
+
+bool dm_atomic_write_poll_read_aux(
+		struct dc_link *link,
+		const struct mod_hdcp_atomic_op_aux *write,
+		const struct mod_hdcp_atomic_op_aux *poll,
+		struct mod_hdcp_atomic_op_aux *read,
+		uint32_t poll_timeout_us,
+		uint8_t poll_mask_msb
+)
+{
+	if (!link)
+		return false;
+
+	const uint32_t ddc_line = link->ddc->ddc_pin->pin_data->en;
+	union dmub_rb_cmd commands[3] = { 0 };
+	const bool converted = op_aux_convert(&commands[0], write, FUSED_REQUEST_WRITE, ddc_line)
+			&& op_aux_convert(&commands[1], poll, FUSED_REQUEST_POLL, ddc_line)
+			&& op_aux_convert(&commands[2], read, FUSED_REQUEST_READ, ddc_line);
+
+	if (!converted)
+		return false;
+
+	const bool result = atomic_write_poll_read(link, commands, poll_timeout_us, poll_mask_msb);
+
+	memcpy(read->data, commands[0].fused_io.request.buffer, read->size);
+	return result;
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dc_fused_io.h b/drivers/gpu/drm/amd/display/dc/dc_fused_io.h
new file mode 100644
index 000000000000..c74917240985
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dc_fused_io.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ */
+
+#ifndef __DC_FUSED_IO_H__
+#define __DC_FUSED_IO_H__
+
+#include "dc.h"
+#include "mod_hdcp.h"
+
+bool dm_atomic_write_poll_read_i2c(
+		struct dc_link *link,
+		const struct mod_hdcp_atomic_op_i2c *write,
+		const struct mod_hdcp_atomic_op_i2c *poll,
+		struct mod_hdcp_atomic_op_i2c *read,
+		uint32_t poll_timeout_us,
+		uint8_t poll_mask_msb
+);
+
+bool dm_atomic_write_poll_read_aux(
+		struct dc_link *link,
+		const struct mod_hdcp_atomic_op_aux *write,
+		const struct mod_hdcp_atomic_op_aux *poll,
+		struct mod_hdcp_atomic_op_aux *read,
+		uint32_t poll_timeout_us,
+		uint8_t poll_mask_msb
+);
+
+#endif  // __DC_FUSED_IO_H__
+
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index 5efddd48d5c5..9d160b39e8c5 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -153,6 +153,14 @@ bool dm_helpers_submit_i2c(
 		const struct dc_link *link,
 		struct i2c_command *cmd);
 
+bool dm_helpers_execute_fused_io(
+		struct dc_context *ctx,
+		struct dc_link *link,
+		union dmub_rb_cmd *commands,
+		uint8_t count,
+		uint32_t timeout_us
+);
+
 bool dm_helpers_dp_write_dsc_enable(
 		struct dc_context *ctx,
 		const struct dc_stream_state *stream,
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 22615b47d9bf..440a426b81c1 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -142,6 +142,7 @@ enum dmub_notification_type {
 	DMUB_NOTIFICATION_SET_CONFIG_REPLY,
 	DMUB_NOTIFICATION_DPIA_NOTIFICATION,
 	DMUB_NOTIFICATION_HPD_SENSE_NOTIFY,
+	DMUB_NOTIFICATION_FUSED_IO,
 	DMUB_NOTIFICATION_MAX
 };
 
@@ -595,6 +596,7 @@ struct dmub_notification {
 		enum dp_hpd_status hpd_status;
 		enum set_config_status sc_status;
 		struct dmub_rb_cmd_hpd_sense_notify_data hpd_sense_notify;
+		struct dmub_cmd_fused_request fused_request;
 	};
 };
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
index 1c33857aa513..567c5b1aeb7a 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
@@ -102,6 +102,10 @@ enum dmub_status dmub_srv_stat_get_notification(struct dmub_srv *dmub,
 			    &cmd.hpd_sense_notify.data,
 			    sizeof(cmd.hpd_sense_notify.data));
 		break;
+	case DMUB_OUT_CMD__FUSED_IO:
+		notify->type = DMUB_NOTIFICATION_FUSED_IO;
+		dmub_memcpy(&notify->fused_request, &cmd.fused_io.request, sizeof(cmd.fused_io.request));
+		break;
 	default:
 		notify->type = DMUB_NOTIFICATION_NO_DATA;
 		break;
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
index 55c7d873175f..a37634942b07 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
@@ -386,6 +386,7 @@ enum mod_hdcp_status mod_hdcp_write_repeater_auth_ack(struct mod_hdcp *hdcp);
 enum mod_hdcp_status mod_hdcp_write_stream_manage(struct mod_hdcp *hdcp);
 enum mod_hdcp_status mod_hdcp_write_content_type(struct mod_hdcp *hdcp);
 enum mod_hdcp_status mod_hdcp_clear_cp_irq_status(struct mod_hdcp *hdcp);
+enum mod_hdcp_status mod_hdcp_write_poll_read_lc_fw(struct mod_hdcp *hdcp);
 
 /* hdcp version helpers */
 static inline uint8_t is_dp_hdcp(struct mod_hdcp *hdcp)
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
index 1d41dd58f6bc..bb8ae80b37f8 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
@@ -452,21 +452,12 @@ static enum mod_hdcp_status validate_h_prime(struct mod_hdcp *hdcp,
 	return status;
 }
 
-static enum mod_hdcp_status locality_check(struct mod_hdcp *hdcp,
+static enum mod_hdcp_status locality_check_sw(struct mod_hdcp *hdcp,
 		struct mod_hdcp_event_context *event_ctx,
 		struct mod_hdcp_transition_input_hdcp2 *input)
 {
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
-	if (event_ctx->event != MOD_HDCP_EVENT_CALLBACK) {
-		event_ctx->unexpected_event = 1;
-		goto out;
-	}
-
-	if (!mod_hdcp_execute_and_set(mod_hdcp_hdcp2_prepare_lc_init,
-			&input->lc_init_prepare, &status,
-			hdcp, "lc_init_prepare"))
-		goto out;
 	if (!mod_hdcp_execute_and_set(mod_hdcp_write_lc_init,
 			&input->lc_init_write, &status,
 			 hdcp, "lc_init_write"))
@@ -482,6 +473,48 @@ static enum mod_hdcp_status locality_check(struct mod_hdcp *hdcp,
 			&input->l_prime_read, &status,
 			hdcp, "l_prime_read"))
 		goto out;
+out:
+	return status;
+}
+
+static enum mod_hdcp_status locality_check_fw(struct mod_hdcp *hdcp,
+		struct mod_hdcp_event_context *event_ctx,
+		struct mod_hdcp_transition_input_hdcp2 *input)
+{
+	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
+
+	if (!mod_hdcp_execute_and_set(mod_hdcp_write_poll_read_lc_fw,
+			&input->l_prime_read, &status,
+			hdcp, "l_prime_read"))
+		goto out;
+
+out:
+	return status;
+}
+
+static enum mod_hdcp_status locality_check(struct mod_hdcp *hdcp,
+		struct mod_hdcp_event_context *event_ctx,
+		struct mod_hdcp_transition_input_hdcp2 *input)
+{
+	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
+	const bool use_fw = hdcp->config.ddc.funcs.atomic_write_poll_read_i2c
+			&& hdcp->config.ddc.funcs.atomic_write_poll_read_aux
+			&& !hdcp->connection.link.adjust.hdcp2.force_sw_locality_check;
+
+	if (event_ctx->event != MOD_HDCP_EVENT_CALLBACK) {
+		event_ctx->unexpected_event = 1;
+		goto out;
+	}
+
+	if (!mod_hdcp_execute_and_set(mod_hdcp_hdcp2_prepare_lc_init,
+			&input->lc_init_prepare, &status,
+			hdcp, "lc_init_prepare"))
+		goto out;
+
+	status = (use_fw ? locality_check_fw : locality_check_sw)(hdcp, event_ctx, input);
+	if (status != MOD_HDCP_STATUS_SUCCESS)
+		goto out;
+
 	if (!mod_hdcp_execute_and_set(mod_hdcp_hdcp2_validate_l_prime,
 			&input->l_prime_validation, &status,
 			hdcp, "l_prime_validation"))
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
index c5f6c11de7e5..89ffb89e1932 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
@@ -184,17 +184,28 @@ enum mod_hdcp_status mod_hdcp_hdcp2_transition(struct mod_hdcp *hdcp,
 		callback_in_ms(0, output);
 		set_state_id(hdcp, output, H2_A2_LOCALITY_CHECK);
 		break;
-	case H2_A2_LOCALITY_CHECK:
+	case H2_A2_LOCALITY_CHECK: {
+		const bool use_fw = hdcp->config.ddc.funcs.atomic_write_poll_read_i2c
+				&& !adjust->hdcp2.force_sw_locality_check;
+
+		/*
+		 * 1A-05: consider disconnection after LC init a failure
+		 * 1A-13-1: consider invalid l' a failure
+		 * 1A-13-2: consider l' timeout a failure
+		 */
 		if (hdcp->state.stay_count > 10 ||
 				input->lc_init_prepare != PASS ||
-				input->lc_init_write != PASS ||
-				input->l_prime_available_poll != PASS ||
-				input->l_prime_read != PASS) {
-			/*
-			 * 1A-05: consider disconnection after LC init a failure
-			 * 1A-13-1: consider invalid l' a failure
-			 * 1A-13-2: consider l' timeout a failure
-			 */
+				(!use_fw && input->lc_init_write != PASS) ||
+				(!use_fw && input->l_prime_available_poll != PASS)) {
+			fail_and_restart_in_ms(0, &status, output);
+			break;
+		} else if (input->l_prime_read != PASS) {
+			if (use_fw && hdcp->config.debug.lc_enable_sw_fallback) {
+				adjust->hdcp2.force_sw_locality_check = true;
+				callback_in_ms(0, output);
+				break;
+			}
+
 			fail_and_restart_in_ms(0, &status, output);
 			break;
 		} else if (input->l_prime_validation != PASS) {
@@ -205,6 +216,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_transition(struct mod_hdcp *hdcp,
 		callback_in_ms(0, output);
 		set_state_id(hdcp, output, H2_A3_EXCHANGE_KS_AND_TEST_FOR_REPEATER);
 		break;
+	}
 	case H2_A3_EXCHANGE_KS_AND_TEST_FOR_REPEATER:
 		if (input->eks_prepare != PASS ||
 				input->eks_write != PASS) {
@@ -498,12 +510,23 @@ enum mod_hdcp_status mod_hdcp_hdcp2_dp_transition(struct mod_hdcp *hdcp,
 		callback_in_ms(0, output);
 		set_state_id(hdcp, output, D2_A2_LOCALITY_CHECK);
 		break;
-	case D2_A2_LOCALITY_CHECK:
+	case D2_A2_LOCALITY_CHECK: {
+		const bool use_fw = hdcp->config.ddc.funcs.atomic_write_poll_read_aux
+				&& !adjust->hdcp2.force_sw_locality_check;
+
 		if (hdcp->state.stay_count > 10 ||
 				input->lc_init_prepare != PASS ||
-				input->lc_init_write != PASS ||
-				input->l_prime_read != PASS) {
+				(!use_fw && input->lc_init_write != PASS)) {
 			/* 1A-12: consider invalid l' a failure */
+			fail_and_restart_in_ms(0, &status, output);
+			break;
+		} else if (input->l_prime_read != PASS) {
+			if (use_fw && hdcp->config.debug.lc_enable_sw_fallback) {
+				adjust->hdcp2.force_sw_locality_check = true;
+				callback_in_ms(0, output);
+				break;
+			}
+
 			fail_and_restart_in_ms(0, &status, output);
 			break;
 		} else if (input->l_prime_validation != PASS) {
@@ -514,6 +537,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_dp_transition(struct mod_hdcp *hdcp,
 		callback_in_ms(0, output);
 		set_state_id(hdcp, output, D2_A34_EXCHANGE_KS_AND_TEST_FOR_REPEATER);
 		break;
+	}
 	case D2_A34_EXCHANGE_KS_AND_TEST_FOR_REPEATER:
 		if (input->eks_prepare != PASS ||
 				input->eks_write != PASS) {
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
index 6e064e6ae949..2e6408579194 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
@@ -688,3 +688,76 @@ enum mod_hdcp_status mod_hdcp_clear_cp_irq_status(struct mod_hdcp *hdcp)
 
 	return MOD_HDCP_STATUS_INVALID_OPERATION;
 }
+
+static bool write_stall_read_lc_fw_aux(struct mod_hdcp *hdcp)
+{
+	struct mod_hdcp_message_hdcp2 *hdcp2 = &hdcp->auth.msg.hdcp2;
+
+	struct mod_hdcp_atomic_op_aux write = {
+		hdcp_dpcd_addrs[MOD_HDCP_MESSAGE_ID_WRITE_LC_INIT],
+		hdcp2->lc_init + 1,
+		sizeof(hdcp2->lc_init) - 1,
+	};
+	struct mod_hdcp_atomic_op_aux stall = { 0, NULL, 0, };
+	struct mod_hdcp_atomic_op_aux read = {
+		hdcp_dpcd_addrs[MOD_HDCP_MESSAGE_ID_READ_LC_SEND_L_PRIME],
+		hdcp2->lc_l_prime + 1,
+		sizeof(hdcp2->lc_l_prime) - 1,
+	};
+
+	hdcp2->lc_l_prime[0] = HDCP_2_2_LC_SEND_LPRIME;
+
+	return hdcp->config.ddc.funcs.atomic_write_poll_read_aux(
+			hdcp->config.ddc.handle,
+			&write,
+			&stall,
+			&read,
+			16 * 1000,
+			0
+	);
+}
+
+static bool write_poll_read_lc_fw_i2c(struct mod_hdcp *hdcp)
+{
+	struct mod_hdcp_message_hdcp2 *hdcp2 = &hdcp->auth.msg.hdcp2;
+	uint8_t expected_rxstatus[2] = { sizeof(hdcp2->lc_l_prime) };
+
+	hdcp->buf[0] = hdcp_i2c_offsets[MOD_HDCP_MESSAGE_ID_WRITE_LC_INIT];
+	memmove(&hdcp->buf[1], hdcp2->lc_init, sizeof(hdcp2->lc_init));
+
+	struct mod_hdcp_atomic_op_i2c write = {
+		HDCP_I2C_ADDR,
+		0,
+		hdcp->buf,
+		sizeof(hdcp2->lc_init) + 1,
+	};
+	struct mod_hdcp_atomic_op_i2c poll = {
+		HDCP_I2C_ADDR,
+		hdcp_i2c_offsets[MOD_HDCP_MESSAGE_ID_READ_RXSTATUS],
+		expected_rxstatus,
+		sizeof(expected_rxstatus),
+	};
+	struct mod_hdcp_atomic_op_i2c read = {
+		HDCP_I2C_ADDR,
+		hdcp_i2c_offsets[MOD_HDCP_MESSAGE_ID_READ_LC_SEND_L_PRIME],
+		hdcp2->lc_l_prime,
+		sizeof(hdcp2->lc_l_prime),
+	};
+
+	return hdcp->config.ddc.funcs.atomic_write_poll_read_i2c(
+			hdcp->config.ddc.handle,
+			&write,
+			&poll,
+			&read,
+			20 * 1000,
+			6
+	);
+}
+
+enum mod_hdcp_status mod_hdcp_write_poll_read_lc_fw(struct mod_hdcp *hdcp)
+{
+	const bool success = (is_dp_hdcp(hdcp) ? write_stall_read_lc_fw_aux : write_poll_read_lc_fw_i2c)(hdcp);
+
+	return success ? MOD_HDCP_STATUS_SUCCESS : MOD_HDCP_STATUS_DDC_FAILURE;
+}
+
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
index a4d344a4db9e..c42468bb70ac 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
@@ -133,9 +133,22 @@ enum mod_hdcp_display_disable_option {
 	MOD_HDCP_DISPLAY_DISABLE_ENCRYPTION,
 };
 
+struct mod_hdcp_atomic_op_i2c {
+	uint8_t address;
+	uint8_t offset;
+	uint8_t *data;
+	uint32_t size;
+};
+
+struct mod_hdcp_atomic_op_aux {
+	uint32_t address;
+	uint8_t *data;
+	uint32_t size;
+};
+
 struct mod_hdcp_ddc {
 	void *handle;
-	struct {
+	struct mod_hdcp_ddc_funcs {
 		bool (*read_i2c)(void *handle,
 				uint32_t address,
 				uint8_t offset,
@@ -153,6 +166,22 @@ struct mod_hdcp_ddc {
 				uint32_t address,
 				const uint8_t *data,
 				uint32_t size);
+		bool (*atomic_write_poll_read_i2c)(
+				void *handle,
+				const struct mod_hdcp_atomic_op_i2c *write,
+				const struct mod_hdcp_atomic_op_i2c *poll,
+				struct mod_hdcp_atomic_op_i2c *read,
+				uint32_t poll_timeout_us,
+				uint8_t poll_mask_msb
+		);
+		bool (*atomic_write_poll_read_aux)(
+				void *handle,
+				const struct mod_hdcp_atomic_op_aux *write,
+				const struct mod_hdcp_atomic_op_aux *poll,
+				struct mod_hdcp_atomic_op_aux *read,
+				uint32_t poll_timeout_us,
+				uint8_t poll_mask_msb
+		);
 	} funcs;
 };
 
@@ -185,7 +214,8 @@ struct mod_hdcp_link_adjustment_hdcp2 {
 	uint8_t force_type		: 2;
 	uint8_t force_no_stored_km	: 1;
 	uint8_t increase_h_prime_timeout: 1;
-	uint8_t reserved		: 3;
+	uint8_t force_sw_locality_check : 1;
+	uint8_t reserved		: 2;
 };
 
 struct mod_hdcp_link_adjustment {
@@ -272,6 +302,10 @@ struct mod_hdcp_display_query {
 struct mod_hdcp_config {
 	struct mod_hdcp_psp psp;
 	struct mod_hdcp_ddc ddc;
+	struct {
+		uint8_t lc_enable_sw_fallback : 1;
+		uint8_t reserved : 7;
+	} debug;
 	uint8_t index;
 };
 
-- 
2.34.1

