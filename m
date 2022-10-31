Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A4AFA3743
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 16:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D3710E305;
	Mon, 31 Oct 2022 16:25:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0F9610E2EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 16:24:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpbt0fNbuidPi+YS089tW3ZqLAanU5vs2nyHXRUuyQj35Aw6qLcz2NK2WXuPlozreP6LX15NVlFtNAfTa8c+hxDo7iPfS0U92z7aLALU/uZRBFpUcBvc5DTVJErJib8Cu4JZLYNqkVbXC+WfuiByGXIhjUgL5RnL/y5grQL/O/w8+DP6MXdXK7RP5OR46871bFr5vFLFC2sxuYONAVOlfYb1yEQ0tIWlhFdqtTwGdWOq6GUUgHJ5Qtb8YTlqWP6m67WWHMVBZBzhNQYwFS+HDqmhUlBJClTdfSrLdUVsfYSNoD1H8vVaR0Y2dWmjDfLNx3ihabfVc1hf+aMAJwAOxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ge1ju5S9IDmkkGIdOYtcyIghuQjuhHVVxzqyLgp7vP0=;
 b=mJkYnF/AKDO1CNZkcXnqSRfsUAgQheSmcfXKLQeJRVMPSHmSeGUnPG27twCw1fP9IFLEmyIgZiXSgGcFlIIx4XOItxxvH0xU+ZBFvDs0xPu0b0yqvXyFx3kJuHxnujG0b+RPCpULoZExmWKr5gGP9iXciGsL/fG7CO0ssUahjkZrv5gGwclvFbPyBsg5und3FxwHkV5ZPjLBBjjNbj2E5zfjNT+VrjXq+236/6mJh4j+uelbf4A03kRfTXNB+pIIOBiCY+dtFty+afm3725PiNDv/NFPYVriCrFSAYybtv56xY92TMORoz5HpdRRcmQi0OAT/gWP9oN1robhMsXkrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ge1ju5S9IDmkkGIdOYtcyIghuQjuhHVVxzqyLgp7vP0=;
 b=HXJ6eK0c3qfk2wRBan0wCYgCp57Q0n2OGR1KvI/VHmj2gDYvv4gQp+/uwPxJSI5UYlkv95mOLKMLPlfxdQKijjN9Zg5DEy+dMq4N3umsxrFteoWLBgqG4z3PsZDr3LbiHiHZ+A3/WuzJMEyMu1kWLxC/a6afze34xLxcMpLS7kU=
Received: from MW4PR04CA0175.namprd04.prod.outlook.com (2603:10b6:303:85::30)
 by BN9PR12MB5130.namprd12.prod.outlook.com (2603:10b6:408:137::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 16:24:33 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::14) by MW4PR04CA0175.outlook.office365.com
 (2603:10b6:303:85::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Mon, 31 Oct 2022 16:24:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.21 via Frontend Transport; Mon, 31 Oct 2022 16:24:32 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 11:24:28 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/29] drm/amdkfd: add debug wave launch mode operation
Date: Mon, 31 Oct 2022 12:23:51 -0400
Message-ID: <20221031162359.445805-21-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031162359.445805-1-jonathan.kim@amd.com>
References: <20221031162359.445805-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|BN9PR12MB5130:EE_
X-MS-Office365-Filtering-Correlation-Id: c2290964-085a-4123-79cc-08dabb5c64c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KVyuLxoyiuGSJZiTIJDJMApgyq7qGuL9BW4GEVNLeqL2z7qFlj5jz9G+PDt1wQE1AJm1OZd5dLsS6twOZHg/2Kzdc1INR3LKYLh6rHJlmpzXUfKrEwwLHyZRI96ni8PafjKVlQmppEvaGwciCCXXwuGNRxhA+tmJw+PYlgpI1QV1gSrwtXZDvlFjouzJFGXY5isbtDZJH4KC+HFnNA4XCBL090YH6Y1By86cANYOGnvrZyLvnlGvujr9CLlEOPCIS/Q0wpwWJRQhsE76tk9MpetSGl6LcAwTTs666tdVkOCNi6/zZCbKTfiTddlawy/jo/MtDz67YZUaRZOCPVM9gTVMjgnYZF5OqPQ9x6+rt04CLJ+/t8cSFEXn+K591YS+f8XD9mFz5WDBcgQUYjdym5bh8498hmm2spCJIsk5U42dv1CTGt//94KPhdeRmJm5tssL/836GmqY095/mqDzG0Os6SiURP6x5CjpmkrhXzi012O8mTClmHrm9n8eWDUaZG8E12EfHFM4jZrdiusQUmKhmbgazoU2DF58/SKAPbjtcDJurhnPGlDbWqiaB8gmpMEH/B+05Qepv5kKxifFUgIbmBKT2/f/sY52r7ceTua7sIhrLXltvi5qdczLMccryWxMZheiFFlkYDjs7Lk2tBDu2JetqSTVmNaCKlLzX+XyACb6eHvyTAJFIsz/QjR9eUwbIDuXMGSrtOo2UU7YqOU1NK6QIC0c4h89xMSdtCITET9YpijBcD37YTKb3lLtVWJVrg0DtKoXuKqRyzI/go8uozVWx6YEwI8682NmsdhgLEKy7SA5WWzCCX3fo2yH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199015)(40470700004)(36840700001)(46966006)(81166007)(82740400003)(356005)(36756003)(40460700003)(40480700001)(86362001)(2906002)(44832011)(30864003)(6666004)(478600001)(316002)(4326008)(8676002)(8936002)(70586007)(5660300002)(70206006)(6916009)(41300700001)(7696005)(82310400005)(36860700001)(186003)(1076003)(2616005)(26005)(16526019)(336012)(47076005)(426003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 16:24:32.7054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2290964-085a-4123-79cc-08dabb5c64c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5130
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allow the debugger to set wave behaviour on to either normally operate,
halt at launch, trap on every instruction, terminate immediately or
stall on allocation.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  | 18 ++++++++++
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |  1 +
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 27 +++++++++++++++
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |  3 ++
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |  3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 34 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  3 ++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  3 ++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 27 ++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h        |  5 ++-
 10 files changed, 119 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index a5003f6f05bf..91c7fdee883e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -99,6 +99,23 @@ static uint32_t kgd_aldebaran_set_wave_launch_trap_override(struct amdgpu_device
 	return data;
 }
 
+static uint32_t kgd_aldebaran_set_wave_launch_mode(struct amdgpu_device *adev,
+					uint8_t wave_launch_mode,
+					uint32_t vmid)
+{
+	uint32_t data = 0;
+	bool is_stall_mode = wave_launch_mode == KFD_DBG_TRAP_WAVE_LAUNCH_MODE_HALT;
+
+	if (is_stall_mode)
+		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, STALL_VMID,
+									1);
+	else
+		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, LAUNCH_MODE,
+							wave_launch_mode);
+
+	return data;
+}
+
 const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
@@ -120,6 +137,7 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.disable_debug_trap = kgd_aldebaran_disable_debug_trap,
 	.validate_trap_override_request = kgd_aldebaran_validate_trap_override_request,
 	.set_wave_launch_trap_override = kgd_aldebaran_set_wave_launch_trap_override,
+	.set_wave_launch_mode = kgd_aldebaran_set_wave_launch_mode,
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
 	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index b3682758184f..10470f4a4eaf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -399,6 +399,7 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
 	.disable_debug_trap = kgd_arcturus_disable_debug_trap,
 	.validate_trap_override_request = kgd_gfx_v9_validate_trap_override_request,
 	.set_wave_launch_trap_override = kgd_gfx_v9_set_wave_launch_trap_override,
+	.set_wave_launch_mode = kgd_gfx_v9_set_wave_launch_mode,
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
 	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
 	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 32a6e5fbeacd..66a83e6fb9e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -854,6 +854,32 @@ uint32_t kgd_gfx_v10_set_wave_launch_trap_override(struct amdgpu_device *adev,
 	return 0;
 }
 
+uint32_t kgd_gfx_v10_set_wave_launch_mode(struct amdgpu_device *adev,
+					uint8_t wave_launch_mode,
+					uint32_t vmid)
+{
+	uint32_t data = 0;
+	bool is_stall_mode = wave_launch_mode == KFD_DBG_TRAP_WAVE_LAUNCH_MODE_STALL;
+	bool is_mode_set = wave_launch_mode && !is_stall_mode;
+
+	mutex_lock(&adev->grbm_idx_mutex);
+
+	kgd_gfx_v10_set_wave_launch_stall(adev, vmid, true);
+
+	data = REG_SET_FIELD(data, SPI_GDBG_WAVE_CNTL2,
+			VMID_MASK, is_mode_set ? 1 << vmid : 0);
+	data = REG_SET_FIELD(data, SPI_GDBG_WAVE_CNTL2,
+			MODE, is_mode_set ? wave_launch_mode : 0);
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL2), data);
+
+	if (!is_stall_mode)
+		kgd_gfx_v10_set_wave_launch_stall(adev, vmid, false);
+
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	return 0;
+}
+
 /* kgd_gfx_v10_get_iq_wait_times: Returns the mmCP_IQ_WAIT_TIME1/2 values
  * The values read are:
  *     ib_offload_wait_time     -- Wait Count for Indirect Buffer Offloads.
@@ -941,6 +967,7 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
 	.disable_debug_trap = kgd_gfx_v10_disable_debug_trap,
 	.validate_trap_override_request = kgd_gfx_v10_validate_trap_override_request,
 	.set_wave_launch_trap_override = kgd_gfx_v10_set_wave_launch_trap_override,
+	.set_wave_launch_mode = kgd_gfx_v10_set_wave_launch_mode,
 	.get_iq_wait_times = kgd_gfx_v10_get_iq_wait_times,
 	.build_grace_period_packet_info = kgd_gfx_v10_build_grace_period_packet_info,
 	.program_trap_handler_settings = program_trap_handler_settings,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
index 85c929fc2926..34c04a2bb83b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
@@ -36,6 +36,9 @@ uint32_t kgd_gfx_v10_set_wave_launch_trap_override(struct amdgpu_device *adev,
 					     uint32_t trap_mask_request,
 					     uint32_t *trap_mask_prev,
 					     uint32_t kfd_dbg_trap_cntl_prev);
+uint32_t kgd_gfx_v10_set_wave_launch_mode(struct amdgpu_device *adev,
+					 uint8_t wave_launch_mode,
+					 uint32_t vmid);
 void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev, uint32_t *wait_times);
 void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
 					       uint32_t wait_times,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index ae3ead207df4..8627c5458973 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -675,6 +675,7 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd = {
 	.enable_debug_trap = kgd_gfx_v10_enable_debug_trap,
 	.disable_debug_trap = kgd_gfx_v10_disable_debug_trap,
 	.validate_trap_override_request = kgd_gfx_v10_validate_trap_override_request,
-	.set_wave_launch_trap_override = kgd_gfx_v10_set_wave_launch_trap_override
+	.set_wave_launch_trap_override = kgd_gfx_v10_set_wave_launch_trap_override,
+	.set_wave_launch_mode = kgd_gfx_v10_set_wave_launch_mode
 
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index cb0044bbfae5..3bba7ca21926 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -777,6 +777,39 @@ uint32_t kgd_gfx_v9_set_wave_launch_trap_override(struct amdgpu_device *adev,
 	return 0;
 }
 
+uint32_t kgd_gfx_v9_set_wave_launch_mode(struct amdgpu_device *adev,
+					uint8_t wave_launch_mode,
+					uint32_t vmid)
+{
+	uint32_t data = 0;
+	bool is_stall_mode = wave_launch_mode ==
+				KFD_DBG_TRAP_WAVE_LAUNCH_MODE_STALL;
+	bool is_mode_set = wave_launch_mode && !is_stall_mode;
+
+	mutex_lock(&adev->grbm_idx_mutex);
+
+	kgd_gfx_v9_set_wave_launch_stall(adev, vmid, true);
+
+	data = REG_SET_FIELD(data, SPI_GDBG_WAVE_CNTL2,
+		VMID_MASK, is_mode_set ? 1 << vmid : 0);
+	data = REG_SET_FIELD(data, SPI_GDBG_WAVE_CNTL2,
+		MODE, is_mode_set ? wave_launch_mode : 0);
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL2), data);
+
+	/* Although Pre-GFX9.4.1 stalls globally, the per-VMID stall for
+	 * GFX9.4.1 effectively does the same thing as global STALL_RA as
+	 * all other VMID allocations are back logged by the stalled VMID.
+	 *
+	 * Use with caution.
+	 */
+	if (!is_stall_mode)
+		kgd_gfx_v9_set_wave_launch_stall(adev, vmid, false);
+
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	return 0;
+}
+
 /* kgd_gfx_v9_get_iq_wait_times: Returns the mmCP_IQ_WAIT_TIME1/2 values
  * The values read are:
  *     ib_offload_wait_time     -- Wait Count for Indirect Buffer Offloads.
@@ -1047,6 +1080,7 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.disable_debug_trap = kgd_gfx_v9_disable_debug_trap,
 	.validate_trap_override_request = kgd_gfx_v9_validate_trap_override_request,
 	.set_wave_launch_trap_override = kgd_gfx_v9_set_wave_launch_trap_override,
+	.set_wave_launch_mode = kgd_gfx_v9_set_wave_launch_mode,
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
 	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
 	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index 47cff392b434..2a2ab42037e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -67,6 +67,9 @@ uint32_t kgd_gfx_v9_disable_debug_trap(struct amdgpu_device *adev,
 int kgd_gfx_v9_validate_trap_override_request(struct amdgpu_device *adev,
 					     uint32_t trap_override,
 					     uint32_t *trap_mask_supported);
+uint32_t kgd_gfx_v9_set_wave_launch_mode(struct amdgpu_device *adev,
+					uint8_t wave_launch_mode,
+					uint32_t vmid);
 uint32_t kgd_gfx_v9_set_wave_launch_trap_override(struct amdgpu_device *adev,
 					     uint32_t vmid,
 					     uint32_t trap_override,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 1f0ee2413b13..63665279ce4d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2899,6 +2899,9 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 				&args->launch_override.support_request_mask);
 		break;
 	case KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_MODE:
+		r = kfd_dbg_trap_set_wave_launch_mode(target,
+				args->launch_mode.launch_mode);
+		break;
 	case KFD_IOC_DBG_TRAP_SUSPEND_QUEUES:
 	case KFD_IOC_DBG_TRAP_RESUME_QUEUES:
 	case KFD_IOC_DBG_TRAP_SET_NODE_ADDRESS_WATCH:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 8add359d1cb9..210851f2cdb3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -239,8 +239,10 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
 {
 	int i, count = 0;
 
-	if (!unwind)
+	if (!unwind) {
 		cancel_work_sync(&target->debug_event_workarea);
+		kfd_dbg_trap_set_wave_launch_mode(target, 0);
+	}
 
 	for (i = 0; i < target->n_pdds; i++) {
 		struct kfd_process_device *pdd = target->pdds[i];
@@ -507,6 +509,29 @@ int kfd_dbg_trap_set_wave_launch_override(struct kfd_process *target,
 	return r;
 }
 
+int kfd_dbg_trap_set_wave_launch_mode(struct kfd_process *target,
+					uint8_t wave_launch_mode)
+{
+	int r = 0, i;
+
+	for (i = 0; i < target->n_pdds; i++) {
+		struct kfd_process_device *pdd = target->pdds[i];
+
+		amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
+		pdd->spi_dbg_launch_mode = pdd->dev->kfd2kgd->set_wave_launch_mode(
+				pdd->dev->adev,
+				wave_launch_mode,
+				pdd->dev->vm_info.last_vmid_kfd);
+		amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
+
+		r = debug_refresh_runlist(pdd->dev->dqm);
+		if (r)
+			break;
+	}
+
+	return r;
+}
+
 void kfd_dbg_set_enabled_debug_exception_mask(struct kfd_process *target,
 					uint64_t exception_set_mask)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index b54a50a5d310..ca3ab1f01985 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -25,9 +25,6 @@
 
 #include "kfd_priv.h"
 
-void kgd_gfx_v9_set_wave_launch_stall(struct amdgpu_device *adev,
-					uint32_t vmid,
-					bool stall);
 void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind_count);
 int kfd_dbg_trap_activate(struct kfd_process *target);
 bool kfd_set_dbg_ev_from_interrupt(struct kfd_dev *dev,
@@ -51,6 +48,8 @@ int kfd_dbg_trap_set_wave_launch_override(struct kfd_process *target,
 					uint32_t trap_mask_request,
 					uint32_t *trap_mask_prev,
 					uint32_t *trap_mask_supported);
+int kfd_dbg_trap_set_wave_launch_mode(struct kfd_process *target,
+					uint8_t wave_launch_mode);
 
 int kfd_dbg_send_exception_to_runtime(struct kfd_process *p,
 					unsigned int dev_id,
-- 
2.25.1

