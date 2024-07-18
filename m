Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84446C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 17:57:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BC0C10EA90;
	Thu, 18 Jul 2024 17:57:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="atMsGO3l";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97A6E10EA90
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 17:57:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+YqXjFvlWxui3In6NTh/p1qD01xZn2SEfEHmQIkbIrVz34Lw13zbPacn1HrX+F+IT9Fzz4YHwzAzTCDfJJ35gTqK+ECUIXeAyd3LZXhKnftDIQm37DUPw9vUCJmflqzxirWVbaaQH6zk26kZC6dTZGRe3lddlBMYfgIV/CnaA465DPi9QrJOYgxtTFdTjh4gBqfeSxMOSwDDHuudL16xRHMjxi1VvfKDdm/PL0bemq/TxCOrEqC54FigvfTgs75AtvrBGcwXjetj7RJoYG/yDxzGKmpCtdFEXbiYgbb/CVC1/F1uuMUcKY/mDP0+uWYp7nKrBlODrNYeEew3FmxFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TonIyYWW3DsmJ0I+/guYGr+0csqV+RzjX91qliyQc5c=;
 b=Kit0UVsE67aWU1v9RchrGiVXtnbGnILBaYRBuKXT2nll2TrEveI+GgdHqUg8T7aB62GAaei4zUE0MjX3xda6E8RSQL5e8TgYgiElsADroFMnH0gIjD2xsAv+J+aY/F/tSZvlogmnzypbxZ9n0lSXVIHC4xd0RtSoJyeaWBbDc9jA8hTF+FCGujSGohmMC+QRJa8mzR15tMpImeruyGUqUfETLd6tuQKPiq9oBfeIY3+j02bEhyR1scvQRmk1T8BcACPflqYNbRn/DeHg7nzs+/cZ+oYBUjYATGBr+k2h55XCpaQYUEoesN0sNgnE2MbqzzJdafuPf0ohao1EVT49bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TonIyYWW3DsmJ0I+/guYGr+0csqV+RzjX91qliyQc5c=;
 b=atMsGO3ldcDyrAFlRLWhEcKQMxjKwZItQrol84fjRSeqMjwcADi3Cw3SLMmtLwDrWwExlCmBE9THpj8nl3FBJ6ZJN+Fwy1cFbDZndwij5fzh6n+xVKxkO8tz+Xe2ss4fEJPl5oMsQvZRnn/WAcc5ImGwh9iefEyFZenudecOi2w=
Received: from SN6PR01CA0033.prod.exchangelabs.com (2603:10b6:805:b6::46) by
 SA3PR12MB8802.namprd12.prod.outlook.com (2603:10b6:806:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Thu, 18 Jul
 2024 17:57:03 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:805:b6:cafe::a4) by SN6PR01CA0033.outlook.office365.com
 (2603:10b6:805:b6::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Thu, 18 Jul 2024 17:57:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 17:57:03 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 12:57:02 -0500
From: Jonathan Kim <Jonathan.Kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jonathan Kim <Jonathan.Kim@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: support per-queue reset on gfx9
Date: Thu, 18 Jul 2024 13:56:44 -0400
Message-ID: <20240718175645.1002418-1-Jonathan.Kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|SA3PR12MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: e03e4877-f115-42e7-b4b4-08dca75307b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UBnCawiZU9i2qyI/yCAIkx1CaAYCoBMqCS5DFiYhr8CRlSxd/dyyFTpcO7Wj?=
 =?us-ascii?Q?TZLkjJAYLYT9AHrHIvVIeH+vIRdeA4k3qtcnTcAVVgqsIxpMUp/PUYZe7pWk?=
 =?us-ascii?Q?SupKEirM2w9snREHkgvMmq7JxM9wupzQAa7oCyTJIU+G/KE2AXRRKBaTnA3a?=
 =?us-ascii?Q?aL9ldNUwmRlB592rtNLPlyZxBc0d2mqnr20UtJ3Dxw+VW5yKbCTC4w/pGsdp?=
 =?us-ascii?Q?XZVaPvhaYi4J9i5WhvC6a3QpnAxBag8zuEjtyTZIh7qbLfnC4dVvJ4usBt9U?=
 =?us-ascii?Q?jI6JXRopYO2WbnO0kqI1sghA4IE057bN6o99cb7CqGNB74P54FhfooaL0bTA?=
 =?us-ascii?Q?usOrri8pAFAHtmyTp10dwZ8NfZV+TzWY0btjZ5c0jpLR3d4eKMhSBW1cy7h2?=
 =?us-ascii?Q?7m167C8aoqz2d3wfZsffBlnzaNITUHN1h5lPrnF8MXhfeVfpF2PLYMt5wGVN?=
 =?us-ascii?Q?O0s3s09EySyNLltyPwQerdbELHDI56p0ugnuV7SDTKPir5Hsc7LfcWjB4vxL?=
 =?us-ascii?Q?VxFkYISHIwy5WNWk+7vbQtR0aTqA0/e5iez8IkCW+g3U1J61N6AzMDMgQef5?=
 =?us-ascii?Q?FBmIbvnY12pUssXMa0LM0ypeaMjvsz5BjmbCk9PgrxE/cKc1C33zI7kS2qRN?=
 =?us-ascii?Q?/Vsq/RljBtanHQn3lEESiihM5e+Rc47Vj0psWro+P/KBnPyshd9TYXulTs+9?=
 =?us-ascii?Q?82uWRiBkfQ+wsw7weiBvmMumhuI9AjA3VZXSahS08EDZt60pTY6523lO+eP2?=
 =?us-ascii?Q?E1QJjMj7EmL7hX0LqHYMc4vCJdWI9HIKM+V8WXPJDpn9Z7NWPACTfvsTuxia?=
 =?us-ascii?Q?U24U1LQJJxYfk54CU1hDvbAeIuBYW9WjEJQm0Xh/PB9DrKHSWRjK0136oedP?=
 =?us-ascii?Q?nGpcwTg9kGGnSBA/S4KnRCoQG8MVAlEeRoGUyCFRjlxeqMYFqLgOcorZrkva?=
 =?us-ascii?Q?9DaPI8ifPsMUc6+nm+U0T3hX0tBk7Qte+bxXseEbhG96NlPvEIZqulTkyD7t?=
 =?us-ascii?Q?RVwqO5KOnOSstySGVPEcV2qLkaiGxorVPEIPrp/1GeAXBE4hlv8Alg6frRCf?=
 =?us-ascii?Q?cXSqdmeZqGQv0K2cg1rpC6lRArR88ns59Df/CjERwea/auSjLK8ln8ctpXk/?=
 =?us-ascii?Q?E7RxEdMrA9vWA9eB8dh/NTdVS3MZDffNtlcJ32d63uh5+so8tae9jb1Hl99e?=
 =?us-ascii?Q?GchoVZl6kfZq/3y+ra70/hUBU/kgM0RFhWwnJXshTxt3JBn2x6WLt85NunWI?=
 =?us-ascii?Q?zDzzwmLzIwfeHW2dqv9Pm/qJZjoFqQQY5rKUhz3BGbpjWgO+9sgXGEZY61tW?=
 =?us-ascii?Q?J51prztjtIf3C2+Yq5b03Ye7zb29WKdbdy6ugTRl3ZPFKaTEXAtM6ziC5aiW?=
 =?us-ascii?Q?t/a2w9417xO+eyBSp/eMiXYOrkhgYU4AqhU7oEDhKzyyyx5zkMTF1dBhGtug?=
 =?us-ascii?Q?I/vATt1aPytaAN/sbFvI5+liaxlg4J7V?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 17:57:03.1481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e03e4877-f115-42e7-b4b4-08dca75307b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8802
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

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |   1 +
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |   3 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |   3 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |   9 +
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |   6 +
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |   3 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    |  11 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  56 +++++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |   6 +
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 195 ++++++++++++++++--
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  12 ++
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  15 ++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |   6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   4 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   2 +
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |   4 +
 16 files changed, 310 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index aff08321e976..1dc601e4518a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -191,4 +191,5 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
 	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
+	.hqd_detect_and_reset = kgd_gfx_v9_hqd_detect_and_reset
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 3a3f3ce09f00..534975c722df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -418,5 +418,6 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
 	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
 	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
-	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings
+	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
+	.hqd_detect_and_reset = kgd_gfx_v9_hqd_detect_and_reset
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index a5c7259cf2a3..b53c1cfa34de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -541,5 +541,6 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
 			kgd_gfx_v9_4_3_set_wave_launch_trap_override,
 	.set_wave_launch_mode = kgd_aldebaran_set_wave_launch_mode,
 	.set_address_watch = kgd_gfx_v9_4_3_set_address_watch,
-	.clear_address_watch = kgd_gfx_v9_4_3_clear_address_watch
+	.clear_address_watch = kgd_gfx_v9_4_3_clear_address_watch,
+	.hqd_detect_and_reset = kgd_gfx_v9_hqd_detect_and_reset
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 3ab6c3aa0ad1..dd449a0caba8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -1070,6 +1070,14 @@ static void program_trap_handler_settings(struct amdgpu_device *adev,
 	unlock_srbm(adev);
 }
 
+uint64_t kgd_gfx_v10_hqd_detect_and_reset(struct amdgpu_device *adev,
+					  uint32_t pipe_id, uint32_t queue_id,
+					  uint32_t inst, unsigned int utimeout,
+					  bool detect_only)
+{
+	return 0;
+}
+
 const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
 	.program_sh_mem_settings = kgd_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_set_pasid_vmid_mapping,
@@ -1097,4 +1105,5 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
 	.get_iq_wait_times = kgd_gfx_v10_get_iq_wait_times,
 	.build_grace_period_packet_info = kgd_gfx_v10_build_grace_period_packet_info,
 	.program_trap_handler_settings = program_trap_handler_settings,
+	.hqd_detect_and_reset = kgd_gfx_v10_hqd_detect_and_reset
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
index 67bcaa3d4226..9eeda8808a3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
@@ -56,3 +56,9 @@ void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
 					       uint32_t grace_period,
 					       uint32_t *reg_offset,
 					       uint32_t *reg_data);
+uint64_t kgd_gfx_v10_hqd_detect_and_reset(struct amdgpu_device *adev,
+					  uint32_t pipe_id,
+					  uint32_t queue_id,
+					  uint32_t inst,
+					  unsigned int utimeout,
+					  bool detect_only);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index 8c8437a4383f..9872bca4156b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -680,5 +680,6 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd = {
 	.set_wave_launch_trap_override = kgd_gfx_v10_set_wave_launch_trap_override,
 	.set_wave_launch_mode = kgd_gfx_v10_set_wave_launch_mode,
 	.set_address_watch = kgd_gfx_v10_set_address_watch,
-	.clear_address_watch = kgd_gfx_v10_clear_address_watch
+	.clear_address_watch = kgd_gfx_v10_clear_address_watch,
+	.hqd_detect_and_reset = kgd_gfx_v10_hqd_detect_and_reset
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
index b61a32d6af4b..483937c571ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
@@ -786,6 +786,14 @@ static uint32_t kgd_gfx_v11_clear_address_watch(struct amdgpu_device *adev,
 	return 0;
 }
 
+static uint64_t kgd_gfx_v11_hqd_detect_and_reset(struct amdgpu_device *adev,
+						 uint32_t pipe_id, uint32_t queue_id,
+						 uint32_t inst, unsigned int utimeout,
+						 bool detect_only)
+{
+	return 0;
+}
+
 const struct kfd2kgd_calls gfx_v11_kfd2kgd = {
 	.program_sh_mem_settings = program_sh_mem_settings_v11,
 	.set_pasid_vmid_mapping = set_pasid_vmid_mapping_v11,
@@ -808,5 +816,6 @@ const struct kfd2kgd_calls gfx_v11_kfd2kgd = {
 	.set_wave_launch_trap_override = kgd_gfx_v11_set_wave_launch_trap_override,
 	.set_wave_launch_mode = kgd_gfx_v11_set_wave_launch_mode,
 	.set_address_watch = kgd_gfx_v11_set_address_watch,
-	.clear_address_watch = kgd_gfx_v11_clear_address_watch
+	.clear_address_watch = kgd_gfx_v11_clear_address_watch,
+	.hqd_detect_and_reset = kgd_gfx_v11_hqd_detect_and_reset
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 5a35a8ca8922..9428e98ac12b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -1144,6 +1144,61 @@ void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
 	kgd_gfx_v9_unlock_srbm(adev, inst);
 }
 
+uint64_t kgd_gfx_v9_hqd_detect_and_reset(struct amdgpu_device *adev,
+					 uint32_t pipe_id, uint32_t queue_id,
+					 uint32_t inst, unsigned int utimeout,
+					 bool detect_only)
+{
+	uint32_t low, high, temp;
+	unsigned long end_jiffies;
+	uint64_t queue_addr = 0;
+
+	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
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
+	if (detect_only)
+		goto unlock_out;
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
+unlock_out:
+	if (!detect_only)
+		pr_debug("queue reset on XCC %i pipe id %i queue id %i %s\n",
+			 inst, pipe_id, queue_id, !!queue_addr ? "succeeded!" : "failed!");
+	kgd_gfx_v9_release_queue(adev, inst);
+
+	return queue_addr;
+}
+
 const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
@@ -1172,4 +1227,5 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
 	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
+	.hqd_detect_and_reset = kgd_gfx_v9_hqd_detect_and_reset
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index ce424615f59b..cf70d8fc3d10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -101,3 +101,9 @@ void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
 					       uint32_t grace_period,
 					       uint32_t *reg_offset,
 					       uint32_t *reg_data);
+uint64_t kgd_gfx_v9_hqd_detect_and_reset(struct amdgpu_device *adev,
+					 uint32_t pipe_id,
+					 uint32_t queue_id,
+					 uint32_t inst,
+					 unsigned int utimeout,
+					 bool detect_only);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 4f48507418d2..037b75a64e66 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -153,6 +153,19 @@ void program_sh_mem_settings(struct device_queue_manager *dqm,
 
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
+			q->properties.is_reset = true;
+			q->process->has_reset_queue = true;
+		}
+	}
+
 	/*
 	 * Issue a GPU reset if HWS is unresponsive
 	 */
@@ -880,6 +893,12 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 		else if (prev_active)
 			retval = remove_queue_mes(dqm, q, &pdd->qpd);
 
+		/* queue is reset so inaccessable  */
+		if (q->properties.is_reset) {
+			retval = -EACCES;
+			goto out_unlock;
+		}
+
 		if (retval) {
 			dev_err(dev, "unmap queue failed\n");
 			goto out_unlock;
@@ -1629,7 +1648,7 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
 static int start_cpsch(struct device_queue_manager *dqm)
 {
 	struct device *dev = dqm->dev->adev->dev;
-	int retval;
+	int retval, num_hw_queue_slots;
 
 	retval = 0;
 
@@ -1682,6 +1701,14 @@ static int start_cpsch(struct device_queue_manager *dqm)
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
@@ -1715,6 +1742,7 @@ static int stop_cpsch(struct device_queue_manager *dqm)
 	kfd_gtt_sa_free(dqm->dev, dqm->fence_mem);
 	if (!dqm->dev->kfd->shared_resources.enable_mes)
 		pm_uninit(&dqm->packet_mgr);
+	kfree(dqm->detect_hang_info);
 	dqm_unlock(dqm);
 
 	return 0;
@@ -1931,6 +1959,143 @@ static int map_queues_cpsch(struct device_queue_manager *dqm)
 	return retval;
 }
 
+static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q,
+			       struct qcm_process_device *qpd)
+{
+	pr_err("queue id 0x%0x at pasid 0x%0x is reset\n",
+	       q->properties.queue_id, q->process->pasid);
+
+	q->properties.is_reset = true;
+	q->process->has_reset_queue = true;
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
+			uint64_t queue_addr = dqm->dev->kfd2kgd->hqd_detect_and_reset(
+						dqm->dev->adev, pipe, queue, xcc_id,
+						0, true);
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
+static int reset_queues_cpsch(struct device_queue_manager *dqm, uint16_t pasid)
+{
+	int retval = 0, reset_count = 0, i;
+
+	if (pasid) {
+		dqm_lock(dqm);
+
+		retval = unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_BY_PASID,
+					    pasid, USE_DEFAULT_GRACE_PERIOD, true);
+
+		dqm_unlock(dqm);
+		return retval;
+	}
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
+		int pipe = hang_info.pipe_id;
+		int queue = hang_info.queue_id;
+		int xcc_id = hang_info.xcc_id;
+
+		if (!q) {
+			retval = -ENOTRECOVERABLE;
+			goto reset_fail;
+		}
+
+		pdd = kfd_get_process_device_data(dqm->dev, q->process);
+		if (!pdd) {
+			retval = -ENOTRECOVERABLE;
+			goto reset_fail;
+		}
+
+		queue_addr = dqm->dev->kfd2kgd->hqd_detect_and_reset(
+				dqm->dev->adev, pipe, queue, xcc_id,
+				KFD_UNMAP_LATENCY_MS, false);
+
+		if (queue_addr != q->properties.queue_address) {
+			retval = -ENOTRECOVERABLE;
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
+		retval = -ENOTRECOVERABLE;
+
+reset_fail:
+	dqm->detect_hang_count = 0;
+
+	return retval;
+}
+
 /* dqm->lock mutex has to be locked before calling this function */
 static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 				enum kfd_unmap_queues_filter filter,
@@ -1981,11 +2146,14 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	 */
 	mqd_mgr = dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
 	if (mqd_mgr->check_preemption_failed(mqd_mgr, dqm->packet_mgr.priv_queue->queue->mqd)) {
-		while (halt_if_hws_hang)
-			schedule();
-		kfd_hws_hang(dqm);
-		retval = -ETIME;
-		goto out;
+		if (reset_queues_cpsch(dqm, 0)) {
+			while (halt_if_hws_hang)
+				schedule();
+			dqm->is_hws_hang = true;
+			kfd_hws_hang(dqm);
+			retval = -ETIME;
+			goto out;
+		}
 	}
 
 	/* We need to reset the grace period value for this device */
@@ -2003,21 +2171,6 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	return retval;
 }
 
-/* only for compute queue */
-static int reset_queues_cpsch(struct device_queue_manager *dqm,
-			uint16_t pasid)
-{
-	int retval;
-
-	dqm_lock(dqm);
-
-	retval = unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_BY_PASID,
-			pasid, USE_DEFAULT_GRACE_PERIOD, true);
-
-	dqm_unlock(dqm);
-	return retval;
-}
-
 /* dqm->lock mutex has to be locked before calling this function */
 static int execute_queues_cpsch(struct device_queue_manager *dqm,
 				enum kfd_unmap_queues_filter filter,
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
index 9b33d9d2c9ad..30a55d3733e8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -31,6 +31,7 @@
 #include <linux/memory.h>
 #include "kfd_priv.h"
 #include "kfd_events.h"
+#include "kfd_device_queue_manager.h"
 #include <linux/device.h>
 
 /*
@@ -1250,6 +1251,20 @@ void kfd_signal_reset_event(struct kfd_node *dev)
 			continue;
 		}
 
+		if (dev->dqm->detect_hang_count && !p->has_reset_queue)
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
index 2b3ec92981e8..e244242fd1b4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -504,6 +504,7 @@ struct queue_properties {
 	bool is_being_destroyed;
 	bool is_active;
 	bool is_gws;
+	bool is_reset;
 	uint32_t pm4_target_xcc;
 	bool is_dbg_wa;
 	bool is_user_cu_masked;
@@ -982,6 +983,9 @@ struct kfd_process {
 	struct semaphore runtime_enable_sema;
 	bool is_runtime_retry;
 	struct kfd_runtime_info runtime_info;
+
+	/* Tracks queue reset status */
+	bool has_reset_queue;
 };
 
 #define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 17e42161b015..9a1d69f83a08 100644
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
index 6d094cf3587d..20bb4a0c893e 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -318,6 +318,10 @@ struct kfd2kgd_calls {
 	void (*program_trap_handler_settings)(struct amdgpu_device *adev,
 			uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr,
 			uint32_t inst);
+	uint64_t (*hqd_detect_and_reset)(struct amdgpu_device *adev,
+					 uint32_t pipe_id, uint32_t queue_id,
+					 uint32_t inst, unsigned int utimeout,
+					 bool detect_only);
 };
 
 #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
-- 
2.34.1

