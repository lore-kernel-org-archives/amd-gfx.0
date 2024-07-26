Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133B9C3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 15:31:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF9C410E9CF;
	Fri, 26 Jul 2024 15:31:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RGasGsrw";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 869E310E9CF
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 15:31:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMiYcTC2I1J3wj68BZ3iBkE5MV6LJswmp5iDTj2lCgmjfmFx3IEmjJwzoabwnx2BIytsy1rukOwF6L8Xd31lqpbNASQq9xpacMh582UtC5ayRXfl1z8w1poHKtOYsHH2tiKRdSzM03f3Ula4wNppsxrEXpJBc7CiPcSW/Le/PIeQbv7q6vMnJeVkuI8U00nQacOD6y8oUBOVSrdDn941rp0PlGvGm6qWkWEtQIHsB9WPtfd1OTSiQjVwEyjVCrRiNGAwC7wrM9lQJoVAPhp0pTvGXbp5RuVza9rA2e8IE/Bz/Oca08gor9dDzK1bvRJmn9X4xH94seerkRaiWjczZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJ3C7zXcdAaTAqsH/tF6RCdOhLJLEqSwp+zuE7bdWRA=;
 b=LDYbVXU8Bpgb5V7X1C84MbqfFm7xeol7GVkMSSXnyITHYcpvzTmx4+kOKR51x9ZgIdKM+DQW1xexEtN6XSQocZOrAZyQK/yqoW6y027rvxlqCtpPNVplzBRgVY9cIdFAk/0OUqQkHlVKkrq9bWUkxOVnUMconUjEjyoKSSnkhQ8GnrmO2QCC/9JUQcqwiBByNxiWgWapAmp/7ee9QejA/eykoEQp5+6lZFRt2mO8hgQhPPl/RcOC0re3VQdSQzknBkYDRl1zkGHD782HjY6CqdLHoJn/j+tG3X38kfSryTFkOL0JWCM2rc95lIAnUjPO/hrvdj2H//w4DD9nvulFfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJ3C7zXcdAaTAqsH/tF6RCdOhLJLEqSwp+zuE7bdWRA=;
 b=RGasGsrw66du/MC/KdR+O51QfS6UkgpyiuNEvx20MaLBT17cV17WBKscPbBxWWYxCPSYEzEoGSAa3OI1b4f0/odkYPMhUHvOIrV2kVP+mIvHDbTPLc5/iwqeORmBymUJeFiWUx47NcXYj0ET3sedGouKlgNkHryJIV4zR0Dg4lQ=
Received: from BLAPR05CA0028.namprd05.prod.outlook.com (2603:10b6:208:335::9)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.31; Fri, 26 Jul
 2024 15:31:03 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:335:cafe::b5) by BLAPR05CA0028.outlook.office365.com
 (2603:10b6:208:335::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Fri, 26 Jul 2024 15:31:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Fri, 26 Jul 2024 15:31:02 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Jul
 2024 10:31:01 -0500
From: Jonathan Kim <Jonathan.Kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: support per-queue reset on gfx9
Date: Fri, 26 Jul 2024 11:30:48 -0400
Message-ID: <20240726153049.1296575-1-Jonathan.Kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|DM6PR12MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: 147e8d4d-be68-4509-4232-08dcad87f548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xmJb7SbN42eAvdVxXcZrL/pj+ihV833A30Ryc4Gmiqr/ObtVbp2Yjp111Cgs?=
 =?us-ascii?Q?zk65E0ah1smlcFLTCAEodVXYCzqN6fbLpGQH0uV8+PmpWoEAEP+b6CdoBAXe?=
 =?us-ascii?Q?DfNDEitUt5S2x/cuEg30EjUSlhjL8QfDlXodRdTFhjQilsPtGoX5mQFbDqJU?=
 =?us-ascii?Q?MDynxwMWXu0BlNSW/FiPdcQPGkXi8UWmz7YISCk1iIk/Eu4P0wDwjo7LMVt6?=
 =?us-ascii?Q?s0ZLxhgqaXjDCplqqtUcKQttvh0dF4K6hRSggFEa8UhPMRnL4j927qk08x1o?=
 =?us-ascii?Q?E84TRgxmpTy4h+o0+68weyJTv5KAxJeN6Gpxhxqkhb0AE098MYwRd7KggcKL?=
 =?us-ascii?Q?moMO0jrbwBNN/LKstvyxueP2WxlOsJ6ZbLH5eopJjYBjHaQC94UpJk+13Usz?=
 =?us-ascii?Q?yIqL7D1rV8fVWnRVXRPH4fbS0b1wRNam82yFLq466qKFg+Qf0biXmHHCJfiT?=
 =?us-ascii?Q?E05FYKwFvfQHAriQgLR3A4eUZo75Wz6r+KgOEDg0bpTz8CV0tTN3pOD0IX4I?=
 =?us-ascii?Q?F5zRX/rPytWqdHJVBkzghH+OlrpJxqPs6y+/TcZU0ErU6ZtoJyG761L6ucZU?=
 =?us-ascii?Q?dU3QZOqRXou+iuEVmW3CbU637Qi4Au9YkK1OwyFAaipPDmW3RFdmHTjbf3eI?=
 =?us-ascii?Q?BChxRmw015/iKfWQ55mUoxGu8ptdRkmoXpZlGfoK1CiPJfiA2QNM6MS5Otyn?=
 =?us-ascii?Q?72TZ1EO1RefKEvm9n+hOprmXcX36qoNT7DEmwOBIOGJ+ktsxPS26GkHCmEg0?=
 =?us-ascii?Q?Xuasfx+GfC29jMFwfTS3obp8qiJhncRENtptiXeDKj4RFamXxQ/QMVvDAfPu?=
 =?us-ascii?Q?w837HuiIiMsRJ8vQ1KbDjPCNsNw56c4hLcbto6l52CHzZNdrVEANa9Gewqph?=
 =?us-ascii?Q?wbe7CzOBZP+e4EPtsGI7MCu+33IgPSp1qNSiE4s9IdDAB/BK+ZriJ8OeE0dP?=
 =?us-ascii?Q?9fBvDk+PzQPe+dsK5qopy/yL4kMtotl3uFZTCDOfvTM9PZoLHWrTJFx9lpNg?=
 =?us-ascii?Q?OU0SJjuzly7VW0amqkJ5gkd1Io20Tvm5CHAUotZ/GeBWDLLUg9U3QHCe3f6d?=
 =?us-ascii?Q?pd7I7Bo6fEkbtWqLWPihuIyQXmIts1YpYNNHyOMK5e17xHmEyaL5xaxu8X57?=
 =?us-ascii?Q?y6E/UK+9dw9cyitfKLOjmQ3rwDlM2/Wxb6ERXFjmsx1x3e94zzMS0s/oU+32?=
 =?us-ascii?Q?/2F/zark1JJXzpPeyil4B2ZhrDsTHKTekIkwGn1l4IU23WkQaHP+H8YPHeAK?=
 =?us-ascii?Q?Ytp5haDAgnCSv5yZLAvIV0A6YvRTA2BO0IB90WuvSc8/ukW1VnqYO5fJjazy?=
 =?us-ascii?Q?5Fj8tZyAz/DHS/sleAO1YDpoR+3fy9SakUa7tvUPV5BlXDfNh18Zfgk1IJlo?=
 =?us-ascii?Q?Y5l/CMdVHr0fZqyfHdNlwlIJC2LI2kF8U9O/Lv+2UIOQJ4vqH+RlP+tmn1Yv?=
 =?us-ascii?Q?XyjFk/xZubmiFqS8YQ1z6aa85mv6z5XF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 15:31:02.6173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 147e8d4d-be68-4509-4232-08dcad87f548
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465
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

Support per-queue reset for GFX9.  The recommendation is for the driver
to target reset the HW queue via a SPI MMIO register write.

Since this requires pipe and HW queue info and MEC FW is limited to
doorbell reports of hung queues after an unmap failure, scan the HW
queue slots defined by SET_RESOURCES first to identify the user queue
candidates to reset.

Only signal reset events to processes that have had a queue reset.

If queue reset fails, fall back to GPU reset.

v2: move reset queue flag for house keeping to process device.
split detect and reset into separate functions.
make reset call safe during power saving modes.
clean up some other nitpicks.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |   2 +
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |   4 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |   4 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  16 ++
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |   9 +
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |   4 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    |  18 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  85 +++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |   9 +
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 172 +++++++++++++++++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  12 ++
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  21 +++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |   6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   3 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   2 +
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |   6 +
 16 files changed, 360 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index aff08321e976..8dfdb18197c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -191,4 +191,6 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
 	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
+	.hqd_get_pq_addr = kgd_gfx_v9_hqd_get_pq_addr,
+	.hqd_reset = kgd_gfx_v9_hqd_reset,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 3a3f3ce09f00..017e8a3013aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -418,5 +418,7 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
 	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
 	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
-	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings
+	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
+	.hqd_get_pq_addr = kgd_gfx_v9_hqd_get_pq_addr,
+	.hqd_reset = kgd_gfx_v9_hqd_reset
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index a5c7259cf2a3..e2ae714a700f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -541,5 +541,7 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
 			kgd_gfx_v9_4_3_set_wave_launch_trap_override,
 	.set_wave_launch_mode = kgd_aldebaran_set_wave_launch_mode,
 	.set_address_watch = kgd_gfx_v9_4_3_set_address_watch,
-	.clear_address_watch = kgd_gfx_v9_4_3_clear_address_watch
+	.clear_address_watch = kgd_gfx_v9_4_3_clear_address_watch,
+	.hqd_get_pq_addr = kgd_gfx_v9_hqd_get_pq_addr,
+	.hqd_reset = kgd_gfx_v9_hqd_reset
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 3ab6c3aa0ad1..62176d607bef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -1070,6 +1070,20 @@ static void program_trap_handler_settings(struct amdgpu_device *adev,
 	unlock_srbm(adev);
 }
 
+uint64_t kgd_gfx_v10_hqd_get_pq_addr(struct amdgpu_device *adev,
+				     uint32_t pipe_id, uint32_t queue_id,
+				     uint32_t inst)
+{
+	return 0;
+}
+
+uint64_t kgd_gfx_v10_hqd_reset(struct amdgpu_device *adev,
+			       uint32_t pipe_id, uint32_t queue_id,
+			       uint32_t inst, unsigned int utimeout)
+{
+	return 0;
+}
+
 const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
 	.program_sh_mem_settings = kgd_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_set_pasid_vmid_mapping,
@@ -1097,4 +1111,6 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
 	.get_iq_wait_times = kgd_gfx_v10_get_iq_wait_times,
 	.build_grace_period_packet_info = kgd_gfx_v10_build_grace_period_packet_info,
 	.program_trap_handler_settings = program_trap_handler_settings,
+	.hqd_get_pq_addr = kgd_gfx_v10_hqd_get_pq_addr,
+	.hqd_reset = kgd_gfx_v10_hqd_reset
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
index 67bcaa3d4226..9efd2dd4fdd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
@@ -56,3 +56,12 @@ void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
 					       uint32_t grace_period,
 					       uint32_t *reg_offset,
 					       uint32_t *reg_data);
+uint64_t kgd_gfx_v10_hqd_get_pq_addr(struct amdgpu_device *adev,
+				    uint32_t pipe_id,
+				    uint32_t queue_id,
+				    uint32_t inst);
+uint64_t kgd_gfx_v10_hqd_reset(struct amdgpu_device *adev,
+			      uint32_t pipe_id,
+			      uint32_t queue_id,
+			      uint32_t inst,
+			      unsigned int utimeout);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index 8c8437a4383f..c718bedda0ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -680,5 +680,7 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd = {
 	.set_wave_launch_trap_override = kgd_gfx_v10_set_wave_launch_trap_override,
 	.set_wave_launch_mode = kgd_gfx_v10_set_wave_launch_mode,
 	.set_address_watch = kgd_gfx_v10_set_address_watch,
-	.clear_address_watch = kgd_gfx_v10_clear_address_watch
+	.clear_address_watch = kgd_gfx_v10_clear_address_watch,
+	.hqd_get_pq_addr = kgd_gfx_v10_hqd_get_pq_addr,
+	.hqd_reset = kgd_gfx_v10_hqd_reset
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
index b61a32d6af4b..a4ba49cb22db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
@@ -786,6 +786,20 @@ static uint32_t kgd_gfx_v11_clear_address_watch(struct amdgpu_device *adev,
 	return 0;
 }
 
+static uint64_t kgd_gfx_v11_hqd_get_pq_addr(struct amdgpu_device *adev,
+					    uint32_t pipe_id, uint32_t queue_id,
+					    uint32_t inst)
+{
+	return 0;
+}
+
+static uint64_t kgd_gfx_v11_hqd_reset(struct amdgpu_device *adev,
+				      uint32_t pipe_id, uint32_t queue_id,
+				      uint32_t inst, unsigned int utimeout)
+{
+	return 0;
+}
+
 const struct kfd2kgd_calls gfx_v11_kfd2kgd = {
 	.program_sh_mem_settings = program_sh_mem_settings_v11,
 	.set_pasid_vmid_mapping = set_pasid_vmid_mapping_v11,
@@ -808,5 +822,7 @@ const struct kfd2kgd_calls gfx_v11_kfd2kgd = {
 	.set_wave_launch_trap_override = kgd_gfx_v11_set_wave_launch_trap_override,
 	.set_wave_launch_mode = kgd_gfx_v11_set_wave_launch_mode,
 	.set_address_watch = kgd_gfx_v11_set_address_watch,
-	.clear_address_watch = kgd_gfx_v11_clear_address_watch
+	.clear_address_watch = kgd_gfx_v11_clear_address_watch,
+	.hqd_get_pq_addr = kgd_gfx_v11_hqd_get_pq_addr,
+	.hqd_reset = kgd_gfx_v11_hqd_reset
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 5a35a8ca8922..32f28c12077b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -1144,6 +1144,89 @@ void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
 	kgd_gfx_v9_unlock_srbm(adev, inst);
 }
 
+uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct amdgpu_device *adev,
+				    uint32_t pipe_id, uint32_t queue_id,
+				    uint32_t inst)
+{
+	uint32_t low, high;
+	uint64_t queue_addr = 0;
+
+	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
+
+	if (!RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_ACTIVE))
+		goto unlock_out;
+
+	low = RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_PQ_BASE);
+	high = RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_PQ_BASE_HI);
+
+	/* only concerned with user queues. */
+	if (!high)
+		goto unlock_out;
+
+	queue_addr = (((queue_addr | high) << 32) | low) << 8;
+
+unlock_out:
+	amdgpu_gfx_rlc_exit_safe_mode(adev, inst);
+	kgd_gfx_v9_release_queue(adev, inst);
+
+	return queue_addr;
+}
+
+uint64_t kgd_gfx_v9_hqd_reset(struct amdgpu_device *adev,
+			      uint32_t pipe_id, uint32_t queue_id,
+			      uint32_t inst, unsigned int utimeout)
+{
+	uint32_t low, high, temp;
+	unsigned long end_jiffies;
+	uint64_t queue_addr = 0;
+
+	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
+
+	if (!RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_ACTIVE))
+		goto unlock_out;
+
+	low = RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_PQ_BASE);
+	high = RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_PQ_BASE_HI);
+
+	/* only concerned with user queues. */
+	if (!high)
+		goto unlock_out;
+
+	queue_addr = (((queue_addr | high) << 32) | low) << 8;
+
+	pr_debug("Attempting queue reset on XCC %i pipe id %i queue id %i\n",
+		 inst, pipe_id, queue_id);
+
+	/* assume previous dequeue request issued will take affect after reset */
+	WREG32_SOC15(GC, GET_INST(GC, inst), mmSPI_COMPUTE_QUEUE_RESET, 0x1);
+
+	end_jiffies = (utimeout * HZ / 1000) + jiffies;
+	while (true) {
+		temp = RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_ACTIVE);
+
+		if (!(temp & CP_HQD_ACTIVE__ACTIVE_MASK))
+			break;
+
+		if (time_after(jiffies, end_jiffies)) {
+			queue_addr = 0;
+			break;
+		}
+
+		usleep_range(500, 1000);
+	}
+
+	pr_debug("queue reset on XCC %i pipe id %i queue id %i %s\n",
+		 inst, pipe_id, queue_id, !!queue_addr ? "succeeded!" : "failed!");
+
+unlock_out:
+	amdgpu_gfx_rlc_exit_safe_mode(adev, inst);
+	kgd_gfx_v9_release_queue(adev, inst);
+
+	return queue_addr;
+}
+
 const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
@@ -1172,4 +1255,6 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
 	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
+	.hqd_get_pq_addr = kgd_gfx_v9_hqd_get_pq_addr,
+	.hqd_reset = kgd_gfx_v9_hqd_reset
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index ce424615f59b..988c50ac3be0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -101,3 +101,12 @@ void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
 					       uint32_t grace_period,
 					       uint32_t *reg_offset,
 					       uint32_t *reg_data);
+uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct amdgpu_device *adev,
+				    uint32_t pipe_id,
+				    uint32_t queue_id,
+				    uint32_t inst);
+uint64_t kgd_gfx_v9_hqd_reset(struct amdgpu_device *adev,
+			      uint32_t pipe_id,
+			      uint32_t queue_id,
+			      uint32_t inst,
+			      unsigned int utimeout);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index fdc76c24b2e7..e335703eff84 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -153,6 +153,20 @@ void program_sh_mem_settings(struct device_queue_manager *dqm,
 
 static void kfd_hws_hang(struct device_queue_manager *dqm)
 {
+	struct device_process_node *cur;
+	struct qcm_process_device *qpd;
+	struct queue *q;
+
+	/* Mark all device queues as reset. */
+	list_for_each_entry(cur, &dqm->queues, list) {
+		qpd = cur->qpd;
+		list_for_each_entry(q, &qpd->queues_list, list) {
+			struct kfd_process_device *pdd = qpd_to_pdd(qpd);
+
+			pdd->has_reset_queue = true;
+		}
+	}
+
 	/*
 	 * Issue a GPU reset if HWS is unresponsive
 	 */
@@ -878,6 +892,12 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 		else if (prev_active)
 			retval = remove_queue_mes(dqm, q, &pdd->qpd);
 
+		/* queue is reset so inaccessable  */
+		if (pdd->has_reset_queue) {
+			retval = -EACCES;
+			goto out_unlock;
+		}
+
 		if (retval) {
 			dev_err(dev, "unmap queue failed\n");
 			goto out_unlock;
@@ -1627,7 +1647,7 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
 static int start_cpsch(struct device_queue_manager *dqm)
 {
 	struct device *dev = dqm->dev->adev->dev;
-	int retval;
+	int retval, num_hw_queue_slots;
 
 	retval = 0;
 
@@ -1680,6 +1700,14 @@ static int start_cpsch(struct device_queue_manager *dqm)
 					&dqm->wait_times);
 	}
 
+	/* setup per-queue reset detection buffer  */
+	num_hw_queue_slots =  dqm->dev->kfd->shared_resources.num_queue_per_pipe *
+			      dqm->dev->kfd->shared_resources.num_pipe_per_mec *
+			      NUM_XCC(dqm->dev->xcc_mask);
+
+	dqm->detect_hang_info_size = num_hw_queue_slots * sizeof(struct dqm_detect_hang_info);
+	dqm->detect_hang_info = kzalloc(dqm->detect_hang_info_size, GFP_KERNEL);
+
 	dqm_unlock(dqm);
 
 	return 0;
@@ -1713,6 +1741,7 @@ static int stop_cpsch(struct device_queue_manager *dqm)
 	kfd_gtt_sa_free(dqm->dev, dqm->fence_mem);
 	if (!dqm->dev->kfd->shared_resources.enable_mes)
 		pm_uninit(&dqm->packet_mgr);
+	kfree(dqm->detect_hang_info);
 	dqm_unlock(dqm);
 
 	return 0;
@@ -1929,6 +1958,131 @@ static int map_queues_cpsch(struct device_queue_manager *dqm)
 	return retval;
 }
 
+static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q,
+			       struct qcm_process_device *qpd)
+{
+	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
+
+	pr_err("queue id 0x%0x at pasid 0x%0x is reset\n",
+	       q->properties.queue_id, q->process->pasid);
+
+	pdd->has_reset_queue = true;
+	if (q->properties.is_active) {
+		q->properties.is_active = false;
+		decrement_queue_count(dqm, qpd, q);
+	}
+}
+
+static int detect_queue_hang(struct device_queue_manager *dqm)
+{
+	int i;
+
+	memset(dqm->detect_hang_info, 0, dqm->detect_hang_info_size);
+
+	for (i = 0; i < AMDGPU_MAX_QUEUES; ++i) {
+		uint32_t mec, pipe, queue;
+		int xcc_id;
+
+		mec = (i / dqm->dev->kfd->shared_resources.num_queue_per_pipe)
+			/ dqm->dev->kfd->shared_resources.num_pipe_per_mec;
+
+		if (mec || !test_bit(i, dqm->dev->kfd->shared_resources.cp_queue_bitmap))
+			continue;
+
+		amdgpu_queue_mask_bit_to_mec_queue(dqm->dev->adev, i, &mec, &pipe, &queue);
+
+		for_each_inst(xcc_id, dqm->dev->xcc_mask) {
+			uint64_t queue_addr = dqm->dev->kfd2kgd->hqd_get_pq_addr(
+						dqm->dev->adev, pipe, queue, xcc_id);
+			struct dqm_detect_hang_info hang_info;
+
+			if (!queue_addr)
+				continue;
+
+			hang_info.pipe_id = pipe;
+			hang_info.queue_id = queue;
+			hang_info.xcc_id = xcc_id;
+			hang_info.queue_address = queue_addr;
+
+			dqm->detect_hang_info[dqm->detect_hang_count] = hang_info;
+			dqm->detect_hang_count++;
+		}
+	}
+
+	return dqm->detect_hang_count;
+}
+
+static struct queue *find_queue_by_address(struct device_queue_manager *dqm, uint64_t queue_address)
+{
+	struct device_process_node *cur;
+	struct qcm_process_device *qpd;
+	struct queue *q;
+
+	list_for_each_entry(cur, &dqm->queues, list) {
+		qpd = cur->qpd;
+		list_for_each_entry(q, &qpd->queues_list, list) {
+			if (queue_address == q->properties.queue_address)
+				return q;
+		}
+	}
+
+	return NULL;
+}
+
+/* only for compute queue */
+static int reset_queues_on_hws_hang(struct device_queue_manager *dqm)
+{
+	int r = 0, reset_count = 0, i;
+
+	if (!dqm->detect_hang_info || dqm->is_hws_hang)
+		return -EIO;
+
+	/* assume dqm locked. */
+	if (!detect_queue_hang(dqm))
+		return -ENOTRECOVERABLE;
+
+	for (i = 0; i < dqm->detect_hang_count; i++) {
+		struct dqm_detect_hang_info hang_info = dqm->detect_hang_info[i];
+		struct queue *q = find_queue_by_address(dqm, hang_info.queue_address);
+		struct kfd_process_device *pdd;
+		uint64_t queue_addr = 0;
+
+		if (!q) {
+			r = -ENOTRECOVERABLE;
+			goto reset_fail;
+		}
+
+		pdd = kfd_get_process_device_data(dqm->dev, q->process);
+		if (!pdd) {
+			r = -ENOTRECOVERABLE;
+			goto reset_fail;
+		}
+
+		queue_addr = dqm->dev->kfd2kgd->hqd_reset(dqm->dev->adev,
+				hang_info.pipe_id, hang_info.queue_id, hang_info.xcc_id,
+				KFD_UNMAP_LATENCY_MS);
+
+		/* either reset failed or we reset an unexpected queue. */
+		if (queue_addr != q->properties.queue_address) {
+			r = -ENOTRECOVERABLE;
+			goto reset_fail;
+		}
+
+		set_queue_as_reset(dqm, q, &pdd->qpd);
+		reset_count++;
+	}
+
+	if (reset_count == dqm->detect_hang_count)
+		kfd_signal_reset_event(dqm->dev);
+	else
+		r = -ENOTRECOVERABLE;
+
+reset_fail:
+	dqm->detect_hang_count = 0;
+
+	return r;
+}
+
 /* dqm->lock mutex has to be locked before calling this function */
 static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 				enum kfd_unmap_queues_filter filter,
@@ -1979,11 +2133,14 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	 */
 	mqd_mgr = dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
 	if (mqd_mgr->check_preemption_failed(mqd_mgr, dqm->packet_mgr.priv_queue->queue->mqd)) {
-		while (halt_if_hws_hang)
-			schedule();
-		kfd_hws_hang(dqm);
-		retval = -ETIME;
-		goto out;
+		if (reset_queues_on_hws_hang(dqm)) {
+			while (halt_if_hws_hang)
+				schedule();
+			dqm->is_hws_hang = true;
+			kfd_hws_hang(dqm);
+			retval = -ETIME;
+			goto out;
+		}
 	}
 
 	/* We need to reset the grace period value for this device */
@@ -2002,8 +2159,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 }
 
 /* only for compute queue */
-static int reset_queues_cpsch(struct device_queue_manager *dqm,
-			uint16_t pasid)
+static int reset_queues_cpsch(struct device_queue_manager *dqm, uint16_t pasid)
 {
 	int retval;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 3b9b8eabaacc..dfb36a246637 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -210,6 +210,13 @@ struct device_queue_manager_asic_ops {
 				 struct kfd_node *dev);
 };
 
+struct dqm_detect_hang_info {
+	int pipe_id;
+	int queue_id;
+	int xcc_id;
+	uint64_t queue_address;
+};
+
 /**
  * struct device_queue_manager
  *
@@ -264,6 +271,11 @@ struct device_queue_manager {
 	uint32_t		wait_times;
 
 	wait_queue_head_t	destroy_wait;
+
+	/* for per-queue reset support */
+	struct dqm_detect_hang_info *detect_hang_info;
+	size_t detect_hang_info_size;
+	int detect_hang_count;
 };
 
 void device_queue_manager_init_cik(
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 9b33d9d2c9ad..3a6e7a4c8895 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -31,6 +31,7 @@
 #include <linux/memory.h>
 #include "kfd_priv.h"
 #include "kfd_events.h"
+#include "kfd_device_queue_manager.h"
 #include <linux/device.h>
 
 /*
@@ -1244,12 +1245,32 @@ void kfd_signal_reset_event(struct kfd_node *dev)
 	idx = srcu_read_lock(&kfd_processes_srcu);
 	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
 		int user_gpu_id = kfd_process_get_user_gpu_id(p, dev->id);
+		struct kfd_process_device *pdd = kfd_get_process_device_data(dev, p);
 
 		if (unlikely(user_gpu_id == -EINVAL)) {
 			WARN_ONCE(1, "Could not get user_gpu_id from dev->id:%x\n", dev->id);
 			continue;
 		}
 
+		if (unlikely(!pdd)) {
+			WARN_ONCE(1, "Could not get device data from pasid:0x%x\n", p->pasid);
+			continue;
+		}
+
+		if (dev->dqm->detect_hang_count && !pdd->has_reset_queue)
+			continue;
+
+		if (dev->dqm->detect_hang_count) {
+			struct amdgpu_task_info *ti;
+
+			ti = amdgpu_vm_get_task_info_pasid(dev->adev, p->pasid);
+			if (ti) {
+				DRM_ERROR("Process info: process %s tid %d thread %s pid %d\n",
+				ti->process_name, ti->tgid, ti->task_name, ti->pid);
+				amdgpu_vm_put_task_info(ti);
+			}
+		}
+
 		rcu_read_lock();
 
 		id = KFD_FIRST_NONSIGNAL_EVENT_ID;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 66c73825c0a0..84e8ea3a8a0c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -321,8 +321,11 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 static bool check_preemption_failed(struct mqd_manager *mm, void *mqd)
 {
 	struct v9_mqd *m = (struct v9_mqd *)mqd;
+	uint32_t doorbell_id = m->queue_doorbell_id0;
 
-	return kfd_check_hiq_mqd_doorbell_id(mm->dev, m->queue_doorbell_id0, 0);
+	m->queue_doorbell_id0 = 0;
+
+	return kfd_check_hiq_mqd_doorbell_id(mm->dev, doorbell_id, 0);
 }
 
 static int get_wave_state(struct mqd_manager *mm, void *mqd,
@@ -624,6 +627,7 @@ static bool check_preemption_failed_v9_4_3(struct mqd_manager *mm, void *mqd)
 		m = get_mqd(mqd + hiq_mqd_size * inst);
 		ret |= kfd_check_hiq_mqd_doorbell_id(mm->dev,
 					m->queue_doorbell_id0, inst);
+		m->queue_doorbell_id0 = 0;
 		++inst;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index b5cae48dff66..892a85408c09 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -843,6 +843,9 @@ struct kfd_process_device {
 	void *proc_ctx_bo;
 	uint64_t proc_ctx_gpu_addr;
 	void *proc_ctx_cpu_ptr;
+
+	/* Tracks queue reset status */
+	bool has_reset_queue;
 };
 
 #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 9e29b92eb523..a902950cc060 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1851,6 +1851,8 @@ int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger)
 			goto fail;
 		}
 		n_evicted++;
+
+		pdd->dev->dqm->is_hws_hang = false;
 	}
 
 	return r;
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 6d094cf3587d..7744ca3ef4b1 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -318,6 +318,12 @@ struct kfd2kgd_calls {
 	void (*program_trap_handler_settings)(struct amdgpu_device *adev,
 			uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr,
 			uint32_t inst);
+	uint64_t (*hqd_get_pq_addr)(struct amdgpu_device *adev,
+				    uint32_t pipe_id, uint32_t queue_id,
+				    uint32_t inst);
+	uint64_t (*hqd_reset)(struct amdgpu_device *adev,
+			      uint32_t pipe_id, uint32_t queue_id,
+			      uint32_t inst, unsigned int utimeout);
 };
 
 #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
-- 
2.34.1

