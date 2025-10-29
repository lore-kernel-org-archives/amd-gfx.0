Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7C1CCF9EA
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 03:10:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 416E310E6E4;
	Wed, 29 Oct 2025 03:10:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mDaG0Tzp";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010054.outbound.protection.outlook.com [52.101.56.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C44C510E6E4
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 03:10:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ml1pX4EuRM9Gp7GaiNJL/slq16rqAkbemv2lManL1a7ziIrM57+4/j2a1lTS917vkbdVo4qNz+t3PxkGHBJ5DJDaMy/2ymiPUg6uP6UUh9t6C+ldfl49ZE9CUs/fcXZdoh542HU3YWPAkhARNMt4RVRvhZevzrcPDys6ED3mBi5PfYKc25wIf0a7R8o7V6AEv8eDXoL7MuZGFZy8JM2c+hB9fHZlM0yVvSflfQVe/SCfm4XMjFeuV9dVRukWHECNoC9ZnUxTQVjDeBl02ouQd4d5vYn8eMxMAwZbCXX/3bhpGJjODo4QS0YQfu9H895ynKxiKxNYH7mVLBhMATnJ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDKHUfN4P2k33RAM6QW2dmvCWCUbp/owlqwUR7p2ccc=;
 b=oWtObEoVDLlA/FJhn6kskxzO7LfxXwyI63vXbkijcfOwPYBAKMV0aKNUiBXwFSmrXSXOu0Mp4DM8n28qG0noLx5U0OZtoCODm86o/MkVaveYpuSUUo2J30XoFHqD9LbOsEBpHfwL/WtmI1/eEP0Dkqn4VTdRkTYT083N9s1fq4iKDE5JwaTjo+UiTi0DVXpjCS06wiW8sT0SIxANpoH5GlpBEfOuBn7VGW7DM+9d3w62HpZwNoBeKjTcGm2jz95o6arOYCuJ9o6UWRWeek/eM2CL1FI9VW9hPn/BlYiLCkscR3XNVx/Pbp0KUIiAKcwakbum/bQBMpRTEL9Xss67Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDKHUfN4P2k33RAM6QW2dmvCWCUbp/owlqwUR7p2ccc=;
 b=mDaG0TzptjflWiS7hiL/aaEjuRELWs4vGioVRkpai1/wDscWbHxG0czDswRngplr3Ql5989JQlBr4uJMcPBQJUnYkH3oU5CtY0a2WwFUvcPHGf4qY935zzTw6rggBI15ofnIZvyyFieklO3xoGX1xvaWPZRLT+kR4ADLHVjZ5Qc=
Received: from BYAPR06CA0025.namprd06.prod.outlook.com (2603:10b6:a03:d4::38)
 by MN2PR12MB4285.namprd12.prod.outlook.com (2603:10b6:208:1d7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.20; Wed, 29 Oct
 2025 03:10:41 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::6a) by BYAPR06CA0025.outlook.office365.com
 (2603:10b6:a03:d4::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 03:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 03:10:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 28 Oct
 2025 20:10:21 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Oct
 2025 22:10:20 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Oct 2025 20:10:12 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Aric Cyr
 <aric.cyr@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 01/13] drm/amd/display: fw locality check refactors
Date: Wed, 29 Oct 2025 11:02:49 +0800
Message-ID: <20251029030935.2785560-2-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029030935.2785560-1-ray.wu@amd.com>
References: <20251029030935.2785560-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|MN2PR12MB4285:EE_
X-MS-Office365-Filtering-Correlation-Id: 038d1090-dba7-4c4e-f27b-08de1698be0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y9u1sGN1fdFHi98/10bhOee+tQq8MuWzlTD973rAv7m5uRHmEz6b2Wnwnnxt?=
 =?us-ascii?Q?D9Gi0icOrsPmMdOfvRv+V7JZ8ksnkaY4uGUiz9ZS30lvwkfy55ExJGJgyUN7?=
 =?us-ascii?Q?rk9wGW2kOi9px5sGnKP3/oE7OSX/fZREFhFuqXhqPxsN7Be2jjkdUR88+dzt?=
 =?us-ascii?Q?YJmk5bSAHI54g0VFgYNCOva16qpfrLgbsKaVOG32MjJI0Jy+IVjyG7N/T2xs?=
 =?us-ascii?Q?3PJbNgNkwLPF/Vq+VrXgW51I5KZUY4vlC9NpUHTQTwkr0cxuj8YtDL6NQm2H?=
 =?us-ascii?Q?wBKZfhfmZ9OjQb6m89mRGPD6Le3arxwnwBeYHRLKKVGJwZ3fPBRPO9VCsDnj?=
 =?us-ascii?Q?bRs+SJTMMIkM89qccbt34WVXxyXHHmDEmZqhLglFsbxFJFhATVUfkMLaMOjW?=
 =?us-ascii?Q?Q/JsoVq/8hNT9NzMOdLbK6SmeV3m0Rz4uZn01PMI5rjde3txy+QfY66BwzyT?=
 =?us-ascii?Q?4xouz66qFkyAiwpZwz5sV4H7k4gd8RWOR2nLHwqJeB3z3ghGowxmGmGLvoCu?=
 =?us-ascii?Q?SzghJqzJVb2zfExMt7zI40BjIFP0dNMIQQQcJfXERVNH8etCj+LRSO/paO4h?=
 =?us-ascii?Q?ksH1zh3HnEzNamHZHpHHL9xco9UFXCA49eYirSn6Wz+E9tWKEijJBIDA8JCv?=
 =?us-ascii?Q?WA1zZQiTRlMWITl/XjxKEHtI8TGGry6iqahoCD6lJstk4s4fFN/guxe+EzUN?=
 =?us-ascii?Q?0wbt5APl/+y3q7boblk+p+Z/Utm7Krio7hVPiYnhSjJZU+S4SvtqlrivxSTo?=
 =?us-ascii?Q?msSy64373BLYTewTebvFsX5MGYwl+quw9ouSQOzLgBaVICvp+BFMqzhMKEDV?=
 =?us-ascii?Q?pUO4mdFp6BZR2WyN7xhkifSV9H7UwQq4waqXR3kfT900YxYresjGFzirz7Ji?=
 =?us-ascii?Q?gKBfvBhfQNU89uOxCcAbsAcZdHRnOXSptIqq1b/I9dVon2WH2FS+SVzEjR/7?=
 =?us-ascii?Q?Gn+H6DTLVGlKS1zizklQW4RHzXXHPQfqgyLRrfjBdLRtCKjzxX+5uwMu7H+9?=
 =?us-ascii?Q?FTAcsEEHnPMXDWb7S12Do20Z1p/7MjIy7D5796YsFLbnmloBDNjCboBbjhcZ?=
 =?us-ascii?Q?buvwJE32bNxJNWnUMgt6RSu3DLBze2i1V3I1R+YQ+WtaYm+boGWkcV9WKCbG?=
 =?us-ascii?Q?l7t0ZOuI5d8zSiCSWl2YmEn+WXPVXJGvoRSlCv4rPkKXCa2XJlrnSnJ/o0k4?=
 =?us-ascii?Q?R4wfCmqUp5PUsxO3tPbsx8tO16RczTvsRDFAx85DOEbOPHX/7C/pbSdi8gGL?=
 =?us-ascii?Q?pT30Fdfzr9cLbKAXxoCskwRm5rF2EydQ1+Do2+csFrj2IBg7jMFoBZWw2n4F?=
 =?us-ascii?Q?vt9TzNwaR6/z/xYW3YashNl/QwIT/i/ibwfqz2bCTtDwFkmjKsepRUHs1ZzY?=
 =?us-ascii?Q?53F0Z2hPPzh9r4Kj+9a96emRe7Wf7pQb9bcqXdwjClakFTrBpD95NZHqL1Nj?=
 =?us-ascii?Q?68PJcWeVgeCjC4vCiyqS5+80ryJQz8fpM65fKDwrjSJeVsS8EsnsTLuAu7w3?=
 =?us-ascii?Q?0Od15mYK902pyzCBt1AhyDBFMbqtoFK4N/DDl5/ttlwiu8dCpzo9+Ebc24QY?=
 =?us-ascii?Q?Xcsm7/Cgvdzj3JMNRz0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 03:10:41.1195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 038d1090-dba7-4c4e-f27b-08de1698be0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
There are some new changes for HDCP2 firmware locality check. The
implementation doesn't perfectly fit the intended design and clarity.

1. Clarify and consolidate variable responsibilities.
The previous implementation introduced the following variables:
- config.ddc.funcs.atomic_write_poll_read_i2c (optional pointer)
- hdcp->config.ddc.funcs.atomic_write_poll_read_aux (optional pointer)
- hdcp->connection.link.adjust.hdcp2.force_sw_locality_check (bool)
- hdcp->config.debug.lc_enable_sw_fallback (bool)
- use_fw (bool)
They will be used together to determine two operations:
- Whether to use FW locality check
- Whether to use SW fallback on FW locality check failure
The refactor streamlines this by introducing two variables in the hdcp2
link adjustment, while ensuring function pointers are always assigned
and remain independent from policy decisions:
- use_fw_locality_check (bool) -> true if fw locality should be used.
- use_sw_locality_fallback (bool) -> true to reset use_fw_locality_check
back to false and retry on fw locality check failure.

2. Mixed meanings of l_prime_read transition input
l_prime_read originally means if l_prime is read when sw locality check
is used. When FW locality check is used, l_prime_read means if lc init
write, l prime poll and l_prime read combo operation is successful. The
mix of meanings is confusing. The refactor introduces a new variable
l_prime_combo_read to isolate the second meaning into its own variable.

3. Missing specific error code on firmware locality error.
The original change reuses the generic DDC failure error code when
firmware fails to return locality check result. This is not ideal as
DDC failure indicates an error occurred during an I2C/AUX transaction.
FW locality failure could be caused by polling timeout in firmware or
failure to acquire firmware access. Which sits at a higher level of
abstraction above DDC hardware. An incorrect error code could mislead
the debug into a wrong direction.

4. Adding macros to simplify the process of adding new error codes.
Currently, to add an error code, the developer needs to add both the
enum and the string translation. This is error prone and can lead to
inconsistencies. The refactor adds a macro to automatically add the
string translation based on the enum.

5. Correcting misplaced comments. The previous implementation of the
firmware locality check resulted in some comments in hdcp2_transition
being incorrectly positioned. This refactor relocates those comments to
their appropriate locations for better clarity.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  18 +--
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |   1 +
 .../display/modules/hdcp/hdcp2_execution.c    |  68 +++------
 .../display/modules/hdcp/hdcp2_transition.c   |  61 ++++----
 .../drm/amd/display/modules/hdcp/hdcp_ddc.c   |   2 +-
 .../drm/amd/display/modules/hdcp/hdcp_log.c   | 123 +---------------
 .../drm/amd/display/modules/inc/mod_hdcp.h    | 134 +++++++++---------
 7 files changed, 136 insertions(+), 271 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 38eeb1211cca..b680a3547856 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -201,6 +201,7 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 	struct mod_hdcp_link_adjustment link_adjust;
 	struct mod_hdcp_display_adjustment display_adjust;
 	unsigned int conn_index = aconnector->base.index;
+	const struct dc *dc = aconnector->dc_link->dc;
 
 	guard(mutex)(&hdcp_w->mutex);
 	drm_connector_get(&aconnector->base);
@@ -231,6 +232,9 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 			link_adjust.hdcp1.disable = 1;
 			link_adjust.hdcp2.force_type = MOD_HDCP_FORCE_TYPE_1;
 		}
+		link_adjust.hdcp2.use_fw_locality_check =
+				(dc->caps.fused_io_supported || dc->debug.hdcp_lc_force_fw_enable);
+		link_adjust.hdcp2.use_sw_locality_fallback = dc->debug.hdcp_lc_enable_sw_fallback;
 
 		schedule_delayed_work(&hdcp_w->property_validate_dwork,
 				      msecs_to_jiffies(DRM_HDCP_CHECK_PERIOD_MS));
@@ -534,6 +538,7 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	struct hdcp_workqueue *hdcp_w = &hdcp_work[link_index];
 	struct dc_sink *sink = NULL;
 	bool link_is_hdcp14 = false;
+	const struct dc *dc = aconnector->dc_link->dc;
 
 	if (config->dpms_off) {
 		hdcp_remove_display(hdcp_work, link_index, aconnector);
@@ -575,6 +580,8 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	link->adjust.auth_delay = 2;
 	link->adjust.retry_limit = MAX_NUM_OF_ATTEMPTS;
 	link->adjust.hdcp1.disable = 0;
+	link->adjust.hdcp2.use_fw_locality_check = (dc->caps.fused_io_supported || dc->debug.hdcp_lc_force_fw_enable);
+	link->adjust.hdcp2.use_sw_locality_fallback = dc->debug.hdcp_lc_enable_sw_fallback;
 	hdcp_w->encryption_status[display->index] = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
 
 	DRM_DEBUG_DRIVER("[HDCP_DM] display %d, CP %d, type %d\n", aconnector->base.index,
@@ -786,15 +793,8 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev,
 		ddc_funcs->read_i2c = lp_read_i2c;
 		ddc_funcs->write_dpcd = lp_write_dpcd;
 		ddc_funcs->read_dpcd = lp_read_dpcd;
-
-		config->debug.lc_enable_sw_fallback = dc->debug.hdcp_lc_enable_sw_fallback;
-		if (dc->caps.fused_io_supported || dc->debug.hdcp_lc_force_fw_enable) {
-			ddc_funcs->atomic_write_poll_read_i2c = lp_atomic_write_poll_read_i2c;
-			ddc_funcs->atomic_write_poll_read_aux = lp_atomic_write_poll_read_aux;
-		} else {
-			ddc_funcs->atomic_write_poll_read_i2c = NULL;
-			ddc_funcs->atomic_write_poll_read_aux = NULL;
-		}
+		ddc_funcs->atomic_write_poll_read_i2c = lp_atomic_write_poll_read_i2c;
+		ddc_funcs->atomic_write_poll_read_aux = lp_atomic_write_poll_read_aux;
 
 		memset(hdcp_work[i].aconnector, 0,
 		       sizeof(struct amdgpu_dm_connector *) *
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
index b883d626f1c3..26a351a184f3 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
@@ -88,6 +88,7 @@ struct mod_hdcp_transition_input_hdcp2 {
 	uint8_t lc_init_write;
 	uint8_t l_prime_available_poll;
 	uint8_t l_prime_read;
+	uint8_t l_prime_combo_read;
 	uint8_t l_prime_validation;
 	uint8_t eks_prepare;
 	uint8_t eks_write;
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
index 5628f0ef73fd..27500abf9fee 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
@@ -465,54 +465,11 @@ static enum mod_hdcp_status validate_h_prime(struct mod_hdcp *hdcp,
 	return status;
 }
 
-static enum mod_hdcp_status locality_check_sw(struct mod_hdcp *hdcp,
-		struct mod_hdcp_event_context *event_ctx,
-		struct mod_hdcp_transition_input_hdcp2 *input)
-{
-	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
-
-	if (!mod_hdcp_execute_and_set(mod_hdcp_write_lc_init,
-			&input->lc_init_write, &status,
-			 hdcp, "lc_init_write"))
-		goto out;
-	if (is_dp_hdcp(hdcp))
-		msleep(16);
-	else
-		if (!mod_hdcp_execute_and_set(poll_l_prime_available,
-				&input->l_prime_available_poll, &status,
-				hdcp, "l_prime_available_poll"))
-			goto out;
-	if (!mod_hdcp_execute_and_set(mod_hdcp_read_l_prime,
-			&input->l_prime_read, &status,
-			hdcp, "l_prime_read"))
-		goto out;
-out:
-	return status;
-}
-
-static enum mod_hdcp_status locality_check_fw(struct mod_hdcp *hdcp,
-		struct mod_hdcp_event_context *event_ctx,
-		struct mod_hdcp_transition_input_hdcp2 *input)
-{
-	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
-
-	if (!mod_hdcp_execute_and_set(mod_hdcp_write_poll_read_lc_fw,
-			&input->l_prime_read, &status,
-			hdcp, "l_prime_read"))
-		goto out;
-
-out:
-	return status;
-}
-
 static enum mod_hdcp_status locality_check(struct mod_hdcp *hdcp,
 		struct mod_hdcp_event_context *event_ctx,
 		struct mod_hdcp_transition_input_hdcp2 *input)
 {
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
-	const bool use_fw = hdcp->config.ddc.funcs.atomic_write_poll_read_i2c
-			&& hdcp->config.ddc.funcs.atomic_write_poll_read_aux
-			&& !hdcp->connection.link.adjust.hdcp2.force_sw_locality_check;
 
 	if (event_ctx->event != MOD_HDCP_EVENT_CALLBACK) {
 		event_ctx->unexpected_event = 1;
@@ -524,9 +481,28 @@ static enum mod_hdcp_status locality_check(struct mod_hdcp *hdcp,
 			hdcp, "lc_init_prepare"))
 		goto out;
 
-	status = (use_fw ? locality_check_fw : locality_check_sw)(hdcp, event_ctx, input);
-	if (status != MOD_HDCP_STATUS_SUCCESS)
-		goto out;
+	if (hdcp->connection.link.adjust.hdcp2.use_fw_locality_check) {
+		if (!mod_hdcp_execute_and_set(mod_hdcp_write_poll_read_lc_fw,
+				&input->l_prime_combo_read, &status,
+				hdcp, "l_prime_combo_read"))
+			goto out;
+	} else {
+		if (!mod_hdcp_execute_and_set(mod_hdcp_write_lc_init,
+				&input->lc_init_write, &status,
+				hdcp, "lc_init_write"))
+			goto out;
+		if (is_dp_hdcp(hdcp))
+			msleep(16);
+		else
+			if (!mod_hdcp_execute_and_set(poll_l_prime_available,
+					&input->l_prime_available_poll, &status,
+					hdcp, "l_prime_available_poll"))
+				goto out;
+		if (!mod_hdcp_execute_and_set(mod_hdcp_read_l_prime,
+				&input->l_prime_read, &status,
+				hdcp, "l_prime_read"))
+			goto out;
+	}
 
 	if (!mod_hdcp_execute_and_set(mod_hdcp_hdcp2_validate_l_prime,
 			&input->l_prime_validation, &status,
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
index 89ffb89e1932..9316312a4df5 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
@@ -184,31 +184,33 @@ enum mod_hdcp_status mod_hdcp_hdcp2_transition(struct mod_hdcp *hdcp,
 		callback_in_ms(0, output);
 		set_state_id(hdcp, output, H2_A2_LOCALITY_CHECK);
 		break;
-	case H2_A2_LOCALITY_CHECK: {
-		const bool use_fw = hdcp->config.ddc.funcs.atomic_write_poll_read_i2c
-				&& !adjust->hdcp2.force_sw_locality_check;
-
-		/*
-		 * 1A-05: consider disconnection after LC init a failure
-		 * 1A-13-1: consider invalid l' a failure
-		 * 1A-13-2: consider l' timeout a failure
-		 */
+	case H2_A2_LOCALITY_CHECK:
+		/* 1A-05: consider disconnection after LC init a failure */
 		if (hdcp->state.stay_count > 10 ||
-				input->lc_init_prepare != PASS ||
-				(!use_fw && input->lc_init_write != PASS) ||
-				(!use_fw && input->l_prime_available_poll != PASS)) {
+				input->lc_init_prepare != PASS) {
 			fail_and_restart_in_ms(0, &status, output);
 			break;
-		} else if (input->l_prime_read != PASS) {
-			if (use_fw && hdcp->config.debug.lc_enable_sw_fallback) {
-				adjust->hdcp2.force_sw_locality_check = true;
+		} else if (adjust->hdcp2.use_fw_locality_check &&
+				input->l_prime_combo_read != PASS) {
+			/* 1A-13-2: consider l' timeout a failure */
+			if (adjust->hdcp2.use_sw_locality_fallback) {
+				/* switch to software locality check */
+				adjust->hdcp2.use_fw_locality_check = 0;
 				callback_in_ms(0, output);
+				increment_stay_counter(hdcp);
 				break;
 			}
-
+			fail_and_restart_in_ms(0, &status, output);
+			break;
+		} else if (!adjust->hdcp2.use_fw_locality_check &&
+					(input->lc_init_write != PASS ||
+					input->l_prime_available_poll != PASS ||
+					input->l_prime_read != PASS)) {
+			/* 1A-13-2: consider l' timeout a failure */
 			fail_and_restart_in_ms(0, &status, output);
 			break;
 		} else if (input->l_prime_validation != PASS) {
+			/* 1A-13-1: consider invalid l' a failure */
 			callback_in_ms(0, output);
 			increment_stay_counter(hdcp);
 			break;
@@ -216,7 +218,6 @@ enum mod_hdcp_status mod_hdcp_hdcp2_transition(struct mod_hdcp *hdcp,
 		callback_in_ms(0, output);
 		set_state_id(hdcp, output, H2_A3_EXCHANGE_KS_AND_TEST_FOR_REPEATER);
 		break;
-	}
 	case H2_A3_EXCHANGE_KS_AND_TEST_FOR_REPEATER:
 		if (input->eks_prepare != PASS ||
 				input->eks_write != PASS) {
@@ -510,26 +511,29 @@ enum mod_hdcp_status mod_hdcp_hdcp2_dp_transition(struct mod_hdcp *hdcp,
 		callback_in_ms(0, output);
 		set_state_id(hdcp, output, D2_A2_LOCALITY_CHECK);
 		break;
-	case D2_A2_LOCALITY_CHECK: {
-		const bool use_fw = hdcp->config.ddc.funcs.atomic_write_poll_read_aux
-				&& !adjust->hdcp2.force_sw_locality_check;
-
+	case D2_A2_LOCALITY_CHECK:
 		if (hdcp->state.stay_count > 10 ||
-				input->lc_init_prepare != PASS ||
-				(!use_fw && input->lc_init_write != PASS)) {
-			/* 1A-12: consider invalid l' a failure */
+				input->lc_init_prepare != PASS) {
 			fail_and_restart_in_ms(0, &status, output);
 			break;
-		} else if (input->l_prime_read != PASS) {
-			if (use_fw && hdcp->config.debug.lc_enable_sw_fallback) {
-				adjust->hdcp2.force_sw_locality_check = true;
+		} else if (adjust->hdcp2.use_fw_locality_check &&
+				input->l_prime_combo_read != PASS) {
+			if (adjust->hdcp2.use_sw_locality_fallback) {
+				/* switch to software locality check */
+				adjust->hdcp2.use_fw_locality_check = 0;
 				callback_in_ms(0, output);
+				increment_stay_counter(hdcp);
 				break;
 			}
-
+			fail_and_restart_in_ms(0, &status, output);
+			break;
+		} else if (!adjust->hdcp2.use_fw_locality_check &&
+					(input->lc_init_write != PASS ||
+					input->l_prime_read != PASS)) {
 			fail_and_restart_in_ms(0, &status, output);
 			break;
 		} else if (input->l_prime_validation != PASS) {
+			/* 1A-12: consider invalid l' a failure */
 			callback_in_ms(0, output);
 			increment_stay_counter(hdcp);
 			break;
@@ -537,7 +541,6 @@ enum mod_hdcp_status mod_hdcp_hdcp2_dp_transition(struct mod_hdcp *hdcp,
 		callback_in_ms(0, output);
 		set_state_id(hdcp, output, D2_A34_EXCHANGE_KS_AND_TEST_FOR_REPEATER);
 		break;
-	}
 	case D2_A34_EXCHANGE_KS_AND_TEST_FOR_REPEATER:
 		if (input->eks_prepare != PASS ||
 				input->eks_write != PASS) {
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
index 2e6408579194..0ca39873f807 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
@@ -758,6 +758,6 @@ enum mod_hdcp_status mod_hdcp_write_poll_read_lc_fw(struct mod_hdcp *hdcp)
 {
 	const bool success = (is_dp_hdcp(hdcp) ? write_stall_read_lc_fw_aux : write_poll_read_lc_fw_i2c)(hdcp);
 
-	return success ? MOD_HDCP_STATUS_SUCCESS : MOD_HDCP_STATUS_DDC_FAILURE;
+	return success ? MOD_HDCP_STATUS_SUCCESS : MOD_HDCP_STATUS_HDCP2_LOCALITY_COMBO_READ_FAILURE;
 }
 
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
index 6b3b5f610907..409a7d0e70fa 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
@@ -125,129 +125,12 @@ void mod_hdcp_log_ddc_trace(struct mod_hdcp *hdcp)
 	}
 }
 
+#define CASE_FORMAT(entry) case entry: return #entry;
+
 char *mod_hdcp_status_to_str(int32_t status)
 {
 	switch (status) {
-	case MOD_HDCP_STATUS_SUCCESS:
-		return "MOD_HDCP_STATUS_SUCCESS";
-	case MOD_HDCP_STATUS_FAILURE:
-		return "MOD_HDCP_STATUS_FAILURE";
-	case MOD_HDCP_STATUS_RESET_NEEDED:
-		return "MOD_HDCP_STATUS_RESET_NEEDED";
-	case MOD_HDCP_STATUS_DISPLAY_OUT_OF_BOUND:
-		return "MOD_HDCP_STATUS_DISPLAY_OUT_OF_BOUND";
-	case MOD_HDCP_STATUS_DISPLAY_NOT_FOUND:
-		return "MOD_HDCP_STATUS_DISPLAY_NOT_FOUND";
-	case MOD_HDCP_STATUS_INVALID_STATE:
-		return "MOD_HDCP_STATUS_INVALID_STATE";
-	case MOD_HDCP_STATUS_NOT_IMPLEMENTED:
-		return "MOD_HDCP_STATUS_NOT_IMPLEMENTED";
-	case MOD_HDCP_STATUS_INTERNAL_POLICY_FAILURE:
-		return "MOD_HDCP_STATUS_INTERNAL_POLICY_FAILURE";
-	case MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE:
-		return "MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE";
-	case MOD_HDCP_STATUS_CREATE_PSP_SERVICE_FAILURE:
-		return "MOD_HDCP_STATUS_CREATE_PSP_SERVICE_FAILURE";
-	case MOD_HDCP_STATUS_DESTROY_PSP_SERVICE_FAILURE:
-		return "MOD_HDCP_STATUS_DESTROY_PSP_SERVICE_FAILURE";
-	case MOD_HDCP_STATUS_HDCP1_CREATE_SESSION_FAILURE:
-		return "MOD_HDCP_STATUS_HDCP1_CREATE_SESSION_FAILURE";
-	case MOD_HDCP_STATUS_HDCP1_DESTROY_SESSION_FAILURE:
-		return "MOD_HDCP_STATUS_HDCP1_DESTROY_SESSION_FAILURE";
-	case MOD_HDCP_STATUS_HDCP1_VALIDATE_ENCRYPTION_FAILURE:
-		return "MOD_HDCP_STATUS_HDCP1_VALIDATE_ENCRYPTION_FAILURE";
-	case MOD_HDCP_STATUS_HDCP1_NOT_HDCP_REPEATER:
-		return "MOD_HDCP_STATUS_HDCP1_NOT_HDCP_REPEATER";
-	case MOD_HDCP_STATUS_HDCP1_NOT_CAPABLE:
-		return "MOD_HDCP_STATUS_HDCP1_NOT_CAPABLE";
-	case MOD_HDCP_STATUS_HDCP1_R0_PRIME_PENDING:
-		return "MOD_HDCP_STATUS_HDCP1_R0_PRIME_PENDING";
-	case MOD_HDCP_STATUS_HDCP1_VALIDATE_RX_FAILURE:
-		return "MOD_HDCP_STATUS_HDCP1_VALIDATE_RX_FAILURE";
-	case MOD_HDCP_STATUS_HDCP1_BKSV_REVOKED:
-		return "MOD_HDCP_STATUS_HDCP1_BKSV_REVOKED";
-	case MOD_HDCP_STATUS_HDCP1_KSV_LIST_NOT_READY:
-		return "MOD_HDCP_STATUS_HDCP1_KSV_LIST_NOT_READY";
-	case MOD_HDCP_STATUS_HDCP1_VALIDATE_KSV_LIST_FAILURE:
-		return "MOD_HDCP_STATUS_HDCP1_VALIDATE_KSV_LIST_FAILURE";
-	case MOD_HDCP_STATUS_HDCP1_KSV_LIST_REVOKED:
-		return "MOD_HDCP_STATUS_HDCP1_KSV_LIST_REVOKED";
-	case MOD_HDCP_STATUS_HDCP1_ENABLE_ENCRYPTION_FAILURE:
-		return "MOD_HDCP_STATUS_HDCP1_ENABLE_ENCRYPTION_FAILURE";
-	case MOD_HDCP_STATUS_HDCP1_ENABLE_STREAM_ENCRYPTION_FAILURE:
-		return "MOD_HDCP_STATUS_HDCP1_ENABLE_STREAM_ENCRYPTION_FAILURE";
-	case MOD_HDCP_STATUS_HDCP1_MAX_CASCADE_EXCEEDED_FAILURE:
-		return "MOD_HDCP_STATUS_HDCP1_MAX_CASCADE_EXCEEDED_FAILURE";
-	case MOD_HDCP_STATUS_HDCP1_MAX_DEVS_EXCEEDED_FAILURE:
-		return "MOD_HDCP_STATUS_HDCP1_MAX_DEVS_EXCEEDED_FAILURE";
-	case MOD_HDCP_STATUS_HDCP1_DEVICE_COUNT_MISMATCH_FAILURE:
-		return "MOD_HDCP_STATUS_HDCP1_DEVICE_COUNT_MISMATCH_FAILURE";
-	case MOD_HDCP_STATUS_HDCP1_LINK_INTEGRITY_FAILURE:
-		return "MOD_HDCP_STATUS_HDCP1_LINK_INTEGRITY_FAILURE";
-	case MOD_HDCP_STATUS_HDCP1_REAUTH_REQUEST_ISSUED:
-		return "MOD_HDCP_STATUS_HDCP1_REAUTH_REQUEST_ISSUED";
-	case MOD_HDCP_STATUS_HDCP1_LINK_MAINTENANCE_FAILURE:
-		return "MOD_HDCP_STATUS_HDCP1_LINK_MAINTENANCE_FAILURE";
-	case MOD_HDCP_STATUS_HDCP1_INVALID_BKSV:
-		return "MOD_HDCP_STATUS_HDCP1_INVALID_BKSV";
-	case MOD_HDCP_STATUS_DDC_FAILURE:
-		return "MOD_HDCP_STATUS_DDC_FAILURE";
-	case MOD_HDCP_STATUS_INVALID_OPERATION:
-		return "MOD_HDCP_STATUS_INVALID_OPERATION";
-	case MOD_HDCP_STATUS_HDCP2_NOT_CAPABLE:
-		return "MOD_HDCP_STATUS_HDCP2_NOT_CAPABLE";
-	case MOD_HDCP_STATUS_HDCP2_CREATE_SESSION_FAILURE:
-		return "MOD_HDCP_STATUS_HDCP2_CREATE_SESSION_FAILURE";
-	case MOD_HDCP_STATUS_HDCP2_DESTROY_SESSION_FAILURE:
-		return "MOD_HDCP_STATUS_HDCP2_DESTROY_SESSION_FAILURE";
-	case MOD_HDCP_STATUS_HDCP2_PREP_AKE_INIT_FAILURE:
-		return "MOD_HDCP_STATUS_HDCP2_PREP_AKE_INIT_FAILURE";
-	case MOD_HDCP_STATUS_HDCP2_AKE_CERT_PENDING:
-		return "MOD_HDCP_STATUS_HDCP2_AKE_CERT_PENDING";
-	case MOD_HDCP_STATUS_HDCP2_H_PRIME_PENDING:
-		return "MOD_HDCP_STATUS_HDCP2_H_PRIME_PENDING";
-	case MOD_HDCP_STATUS_HDCP2_PAIRING_INFO_PENDING:
-		return "MOD_HDCP_STATUS_HDCP2_PAIRING_INFO_PENDING";
-	case MOD_HDCP_STATUS_HDCP2_VALIDATE_AKE_CERT_FAILURE:
-		return "MOD_HDCP_STATUS_HDCP2_VALIDATE_AKE_CERT_FAILURE";
-	case MOD_HDCP_STATUS_HDCP2_AKE_CERT_REVOKED:
-		return "MOD_HDCP_STATUS_HDCP2_AKE_CERT_REVOKED";
-	case MOD_HDCP_STATUS_HDCP2_VALIDATE_H_PRIME_FAILURE:
-		return "MOD_HDCP_STATUS_HDCP2_VALIDATE_H_PRIME_FAILURE";
-	case MOD_HDCP_STATUS_HDCP2_VALIDATE_PAIRING_INFO_FAILURE:
-		return "MOD_HDCP_STATUS_HDCP2_VALIDATE_PAIRING_INFO_FAILURE";
-	case MOD_HDCP_STATUS_HDCP2_PREP_LC_INIT_FAILURE:
-		return "MOD_HDCP_STATUS_HDCP2_PREP_LC_INIT_FAILURE";
-	case MOD_HDCP_STATUS_HDCP2_L_PRIME_PENDING:
-		return "MOD_HDCP_STATUS_HDCP2_L_PRIME_PENDING";
-	case MOD_HDCP_STATUS_HDCP2_VALIDATE_L_PRIME_FAILURE:
-		return "MOD_HDCP_STATUS_HDCP2_VALIDATE_L_PRIME_FAILURE";
-	case MOD_HDCP_STATUS_HDCP2_PREP_EKS_FAILURE:
-		return "MOD_HDCP_STATUS_HDCP2_PREP_EKS_FAILURE";
-	case MOD_HDCP_STATUS_HDCP2_ENABLE_ENCRYPTION_FAILURE:
-		return "MOD_HDCP_STATUS_HDCP2_ENABLE_ENCRYPTION_FAILURE";
-	case MOD_HDCP_STATUS_HDCP2_VALIDATE_RX_ID_LIST_FAILURE:
-		return "MOD_HDCP_STATUS_HDCP2_VALIDATE_RX_ID_LIST_FAILURE";
-	case MOD_HDCP_STATUS_HDCP2_RX_ID_LIST_REVOKED:
-		return "MOD_HDCP_STATUS_HDCP2_RX_ID_LIST_REVOKED";
-	case MOD_HDCP_STATUS_HDCP2_RX_ID_LIST_NOT_READY:
-		return "MOD_HDCP_STATUS_HDCP2_RX_ID_LIST_NOT_READY";
-	case MOD_HDCP_STATUS_HDCP2_ENABLE_STREAM_ENCRYPTION_FAILURE:
-		return "MOD_HDCP_STATUS_HDCP2_ENABLE_STREAM_ENCRYPTION_FAILURE";
-	case MOD_HDCP_STATUS_HDCP2_STREAM_READY_PENDING:
-		return "MOD_HDCP_STATUS_HDCP2_STREAM_READY_PENDING";
-	case MOD_HDCP_STATUS_HDCP2_VALIDATE_STREAM_READY_FAILURE:
-		return "MOD_HDCP_STATUS_HDCP2_VALIDATE_STREAM_READY_FAILURE";
-	case MOD_HDCP_STATUS_HDCP2_PREPARE_STREAM_MANAGEMENT_FAILURE:
-		return "MOD_HDCP_STATUS_HDCP2_PREPARE_STREAM_MANAGEMENT_FAILURE";
-	case MOD_HDCP_STATUS_HDCP2_REAUTH_REQUEST:
-		return "MOD_HDCP_STATUS_HDCP2_REAUTH_REQUEST";
-	case MOD_HDCP_STATUS_HDCP2_REAUTH_LINK_INTEGRITY_FAILURE:
-		return "MOD_HDCP_STATUS_HDCP2_REAUTH_LINK_INTEGRITY_FAILURE";
-	case MOD_HDCP_STATUS_HDCP2_DEVICE_COUNT_MISMATCH_FAILURE:
-		return "MOD_HDCP_STATUS_HDCP2_DEVICE_COUNT_MISMATCH_FAILURE";
-	case MOD_HDCP_STATUS_UNSUPPORTED_PSP_VER_FAILURE:
-		return "MOD_HDCP_STATUS_UNSUPPORTED_PSP_VER_FAILURE";
+	MOD_HDCP_STATUS_LIST(CASE_FORMAT)
 	default:
 		return "MOD_HDCP_STATUS_UNKNOWN";
 	}
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
index 46e52fb3a118..835467225458 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
@@ -35,69 +35,74 @@ struct mod_hdcp;
 #define MAX_NUM_OF_DISPLAYS 6
 #define MAX_NUM_OF_ATTEMPTS 4
 #define MAX_NUM_OF_ERROR_TRACE 10
+#define MOD_HDCP_STATUS_LIST(FORMAT) \
+	FORMAT(MOD_HDCP_STATUS_SUCCESS) \
+	FORMAT(MOD_HDCP_STATUS_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_RESET_NEEDED) \
+	FORMAT(MOD_HDCP_STATUS_DISPLAY_OUT_OF_BOUND) \
+	FORMAT(MOD_HDCP_STATUS_DISPLAY_NOT_FOUND) \
+	FORMAT(MOD_HDCP_STATUS_INVALID_STATE) \
+	FORMAT(MOD_HDCP_STATUS_NOT_IMPLEMENTED) \
+	FORMAT(MOD_HDCP_STATUS_INTERNAL_POLICY_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_CREATE_PSP_SERVICE_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_DESTROY_PSP_SERVICE_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP1_CREATE_SESSION_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP1_DESTROY_SESSION_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP1_VALIDATE_ENCRYPTION_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP1_NOT_HDCP_REPEATER) \
+	FORMAT(MOD_HDCP_STATUS_HDCP1_NOT_CAPABLE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP1_R0_PRIME_PENDING) \
+	FORMAT(MOD_HDCP_STATUS_HDCP1_VALIDATE_RX_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP1_BKSV_REVOKED) \
+	FORMAT(MOD_HDCP_STATUS_HDCP1_KSV_LIST_NOT_READY) \
+	FORMAT(MOD_HDCP_STATUS_HDCP1_VALIDATE_KSV_LIST_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP1_KSV_LIST_REVOKED) \
+	FORMAT(MOD_HDCP_STATUS_HDCP1_ENABLE_ENCRYPTION_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP1_ENABLE_STREAM_ENCRYPTION_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP1_MAX_CASCADE_EXCEEDED_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP1_MAX_DEVS_EXCEEDED_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP1_DEVICE_COUNT_MISMATCH_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP1_LINK_INTEGRITY_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP1_REAUTH_REQUEST_ISSUED) \
+	FORMAT(MOD_HDCP_STATUS_HDCP1_LINK_MAINTENANCE_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP1_INVALID_BKSV) \
+	FORMAT(MOD_HDCP_STATUS_DDC_FAILURE) /* TODO: specific errors */ \
+	FORMAT(MOD_HDCP_STATUS_INVALID_OPERATION) \
+	FORMAT(MOD_HDCP_STATUS_HDCP2_NOT_CAPABLE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP2_CREATE_SESSION_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP2_DESTROY_SESSION_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP2_PREP_AKE_INIT_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP2_AKE_CERT_PENDING) \
+	FORMAT(MOD_HDCP_STATUS_HDCP2_H_PRIME_PENDING) \
+	FORMAT(MOD_HDCP_STATUS_HDCP2_PAIRING_INFO_PENDING) \
+	FORMAT(MOD_HDCP_STATUS_HDCP2_VALIDATE_AKE_CERT_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP2_AKE_CERT_REVOKED) \
+	FORMAT(MOD_HDCP_STATUS_HDCP2_VALIDATE_H_PRIME_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP2_VALIDATE_PAIRING_INFO_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP2_PREP_LC_INIT_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP2_L_PRIME_PENDING) \
+	FORMAT(MOD_HDCP_STATUS_HDCP2_VALIDATE_L_PRIME_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP2_PREP_EKS_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP2_ENABLE_ENCRYPTION_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP2_RX_ID_LIST_NOT_READY) \
+	FORMAT(MOD_HDCP_STATUS_HDCP2_VALIDATE_RX_ID_LIST_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP2_RX_ID_LIST_REVOKED) \
+	FORMAT(MOD_HDCP_STATUS_HDCP2_ENABLE_STREAM_ENCRYPTION_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP2_STREAM_READY_PENDING) \
+	FORMAT(MOD_HDCP_STATUS_HDCP2_VALIDATE_STREAM_READY_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP2_PREPARE_STREAM_MANAGEMENT_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP2_REAUTH_REQUEST) \
+	FORMAT(MOD_HDCP_STATUS_HDCP2_REAUTH_LINK_INTEGRITY_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP2_DEVICE_COUNT_MISMATCH_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_UNSUPPORTED_PSP_VER_FAILURE) \
+	FORMAT(MOD_HDCP_STATUS_HDCP2_LOCALITY_COMBO_READ_FAILURE)
+
+#define ENUM_FORMAT(entry) entry,
 
 /* detailed return status */
 enum mod_hdcp_status {
-	MOD_HDCP_STATUS_SUCCESS = 0,
-	MOD_HDCP_STATUS_FAILURE,
-	MOD_HDCP_STATUS_RESET_NEEDED,
-	MOD_HDCP_STATUS_DISPLAY_OUT_OF_BOUND,
-	MOD_HDCP_STATUS_DISPLAY_NOT_FOUND,
-	MOD_HDCP_STATUS_INVALID_STATE,
-	MOD_HDCP_STATUS_NOT_IMPLEMENTED,
-	MOD_HDCP_STATUS_INTERNAL_POLICY_FAILURE,
-	MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE,
-	MOD_HDCP_STATUS_CREATE_PSP_SERVICE_FAILURE,
-	MOD_HDCP_STATUS_DESTROY_PSP_SERVICE_FAILURE,
-	MOD_HDCP_STATUS_HDCP1_CREATE_SESSION_FAILURE,
-	MOD_HDCP_STATUS_HDCP1_DESTROY_SESSION_FAILURE,
-	MOD_HDCP_STATUS_HDCP1_VALIDATE_ENCRYPTION_FAILURE,
-	MOD_HDCP_STATUS_HDCP1_NOT_HDCP_REPEATER,
-	MOD_HDCP_STATUS_HDCP1_NOT_CAPABLE,
-	MOD_HDCP_STATUS_HDCP1_R0_PRIME_PENDING,
-	MOD_HDCP_STATUS_HDCP1_VALIDATE_RX_FAILURE,
-	MOD_HDCP_STATUS_HDCP1_BKSV_REVOKED,
-	MOD_HDCP_STATUS_HDCP1_KSV_LIST_NOT_READY,
-	MOD_HDCP_STATUS_HDCP1_VALIDATE_KSV_LIST_FAILURE,
-	MOD_HDCP_STATUS_HDCP1_KSV_LIST_REVOKED,
-	MOD_HDCP_STATUS_HDCP1_ENABLE_ENCRYPTION_FAILURE,
-	MOD_HDCP_STATUS_HDCP1_ENABLE_STREAM_ENCRYPTION_FAILURE,
-	MOD_HDCP_STATUS_HDCP1_MAX_CASCADE_EXCEEDED_FAILURE,
-	MOD_HDCP_STATUS_HDCP1_MAX_DEVS_EXCEEDED_FAILURE,
-	MOD_HDCP_STATUS_HDCP1_DEVICE_COUNT_MISMATCH_FAILURE,
-	MOD_HDCP_STATUS_HDCP1_LINK_INTEGRITY_FAILURE,
-	MOD_HDCP_STATUS_HDCP1_REAUTH_REQUEST_ISSUED,
-	MOD_HDCP_STATUS_HDCP1_LINK_MAINTENANCE_FAILURE,
-	MOD_HDCP_STATUS_HDCP1_INVALID_BKSV,
-	MOD_HDCP_STATUS_DDC_FAILURE, /* TODO: specific errors */
-	MOD_HDCP_STATUS_INVALID_OPERATION,
-	MOD_HDCP_STATUS_HDCP2_NOT_CAPABLE,
-	MOD_HDCP_STATUS_HDCP2_CREATE_SESSION_FAILURE,
-	MOD_HDCP_STATUS_HDCP2_DESTROY_SESSION_FAILURE,
-	MOD_HDCP_STATUS_HDCP2_PREP_AKE_INIT_FAILURE,
-	MOD_HDCP_STATUS_HDCP2_AKE_CERT_PENDING,
-	MOD_HDCP_STATUS_HDCP2_H_PRIME_PENDING,
-	MOD_HDCP_STATUS_HDCP2_PAIRING_INFO_PENDING,
-	MOD_HDCP_STATUS_HDCP2_VALIDATE_AKE_CERT_FAILURE,
-	MOD_HDCP_STATUS_HDCP2_AKE_CERT_REVOKED,
-	MOD_HDCP_STATUS_HDCP2_VALIDATE_H_PRIME_FAILURE,
-	MOD_HDCP_STATUS_HDCP2_VALIDATE_PAIRING_INFO_FAILURE,
-	MOD_HDCP_STATUS_HDCP2_PREP_LC_INIT_FAILURE,
-	MOD_HDCP_STATUS_HDCP2_L_PRIME_PENDING,
-	MOD_HDCP_STATUS_HDCP2_VALIDATE_L_PRIME_FAILURE,
-	MOD_HDCP_STATUS_HDCP2_PREP_EKS_FAILURE,
-	MOD_HDCP_STATUS_HDCP2_ENABLE_ENCRYPTION_FAILURE,
-	MOD_HDCP_STATUS_HDCP2_RX_ID_LIST_NOT_READY,
-	MOD_HDCP_STATUS_HDCP2_VALIDATE_RX_ID_LIST_FAILURE,
-	MOD_HDCP_STATUS_HDCP2_RX_ID_LIST_REVOKED,
-	MOD_HDCP_STATUS_HDCP2_ENABLE_STREAM_ENCRYPTION_FAILURE,
-	MOD_HDCP_STATUS_HDCP2_STREAM_READY_PENDING,
-	MOD_HDCP_STATUS_HDCP2_VALIDATE_STREAM_READY_FAILURE,
-	MOD_HDCP_STATUS_HDCP2_PREPARE_STREAM_MANAGEMENT_FAILURE,
-	MOD_HDCP_STATUS_HDCP2_REAUTH_REQUEST,
-	MOD_HDCP_STATUS_HDCP2_REAUTH_LINK_INTEGRITY_FAILURE,
-	MOD_HDCP_STATUS_HDCP2_DEVICE_COUNT_MISMATCH_FAILURE,
-	MOD_HDCP_STATUS_UNSUPPORTED_PSP_VER_FAILURE,
+	MOD_HDCP_STATUS_LIST(ENUM_FORMAT)
 };
 
 struct mod_hdcp_displayport {
@@ -214,8 +219,9 @@ struct mod_hdcp_link_adjustment_hdcp2 {
 	uint8_t force_type		: 2;
 	uint8_t force_no_stored_km	: 1;
 	uint8_t increase_h_prime_timeout: 1;
-	uint8_t force_sw_locality_check : 1;
-	uint8_t reserved		: 2;
+	uint8_t use_fw_locality_check 	: 1;
+	uint8_t use_sw_locality_fallback: 1;
+	uint8_t reserved		: 1;
 };
 
 struct mod_hdcp_link_adjustment {
@@ -317,10 +323,6 @@ struct mod_hdcp_display_query {
 struct mod_hdcp_config {
 	struct mod_hdcp_psp psp;
 	struct mod_hdcp_ddc ddc;
-	struct {
-		uint8_t lc_enable_sw_fallback : 1;
-		uint8_t reserved : 7;
-	} debug;
 	uint8_t index;
 };
 
-- 
2.43.0

