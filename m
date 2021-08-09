Return-Path: <SRS0=nf5+=NA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E3BC4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 20:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D5AC61002
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 20:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2D5AC61002
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9948489D5F;
	Mon,  9 Aug 2021 20:41:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47C7B89D5F
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Aug 2021 20:41:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jr1Vab+1lEwNKfy7tSh6Klcb9aBSrCAASP3anWZ08bqZE5EQPNqRgT1vbQihm/ajWM2tOP4LlwJdcwJ4UYKYnfCGdzOHZvPIqpp655g9GuPksb4Xri32rPVRUTRvRjkcdJ/SoT2cgypM6KqLbnXOwIiNh6EiYYvZXbuRU8zSwHR8IePHkMgFnZz+/j+ObCIgf2A3YpSzSZKU2zYR6s868xneqb01G77Emrpev+GWa3bQrdBU/AdVP+dpM96VmyOcV3toJkf3mxXjS5GF6naTREOE13aoJ5lUuGhmtpJ+kIVaDb++VejiIavRpaUGY8F0fTX2GXLl6wns11QpjedeSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60m26O/PBYhU53vRA9uSvWcSku0pSlZ9t4zDJvQmPcA=;
 b=Urdr9B8jtWXI8IIYLhsamKXMNyowrqVrGMifWeG1oGEgP1BNjkV2uivlNNicrbwq9S2yCFjIi251AYEUIigLHR1KHiHHRZqOadWjuoX7nd5AlQWDquXT7x0wqaH+0myRsAAEDjyyjogfJFMOZpPO37Y4hDprWE7KmJ7tWBRxcfuq8uz4rENc0xLgRQXImR4KFw59dByJpMq/X6CrBc7HHGt6q78/JKkxRUyb5/4FnxGUePUuifjg8GDCIuaZEMB0VznXYVUwPxT03SshYyZQxJsXB3oRWzlzSIuhV2Kyp0qkhpKgZjFHF1b2bNjoxdbuHyb8ngCGZNHQmb4htKsu5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60m26O/PBYhU53vRA9uSvWcSku0pSlZ9t4zDJvQmPcA=;
 b=W2YNPPgEs17qQVNYQxp1u3qn7yS1bB58hXXvltyLsc7o1Fkw6ELZiW1wg5v3eD7R63WCJSoxFoTMt2FkNOUidyZi2wpGmhDdUNij5zcUUtfafFBFuVVpS2SOKMnhYSNKRZgDaCRURzm4d8W3D53G9R0OgBSEQdg8NY7S3163Y60=
Received: from MW4PR03CA0015.namprd03.prod.outlook.com (2603:10b6:303:8f::20)
 by BYAPR12MB2775.namprd12.prod.outlook.com (2603:10b6:a03:6b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Mon, 9 Aug
 2021 20:41:05 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::6f) by MW4PR03CA0015.outlook.office365.com
 (2603:10b6:303:8f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Mon, 9 Aug 2021 20:41:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Mon, 9 Aug 2021 20:41:04 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 9 Aug
 2021 15:41:02 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <jay.cornwall@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>
Subject: [PATCH] drm/amdkfd: CWSR with software scheduler
Date: Mon, 9 Aug 2021 16:40:48 -0400
Message-ID: <20210809204048.2735-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94687e80-926c-4feb-4649-08d95b760220
X-MS-TrafficTypeDiagnostic: BYAPR12MB2775:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2775585760EDD3D87D66E5DAEEF69@BYAPR12MB2775.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y4BolBDaZY9CDgoQjDcrsTBG9GPZ9oe7gMwG1JaPOApIXkw7FE6zsE6sP0WWutgQxP6Yo6MO7qNh6FrN04P+M3dRi519dGlj8CJc6sQzHqyLJepDUAb2qRciC3UH5jT+06gArGnDVkUEIXJKw0fCBMkFrA67kIdNSatTXJ8HvPiJuVOo4lPwUllhxRQ5+hmra5ryiUz8Hjh9FQtGJQx8pdaOlcrHCmBuwOxpkbVSFQgm7r+5BL7dIKRHk6S42lGSDKM0QyiKcMrcEmR0ArGngXZGH0629PcNBtj+BBjkG+G3bvxfrx3/ND3/sWJ0OaFSLwy52oEA/XkICLKLEbAJNCGQ/f0/aET/om/NxZ6k3mZLWRWlTOKpUrUpyyMquRxcfN/fnmrEMjTo3GdMVJlOBGogJ0pk1p9oK1vSvx2QnHGLgOScH5ykkRKlo78EId612PB3PEkvkLBgstN0bSSbQTskmdLO8HvXecZSJlemY8Di3ADn+GqUsqufu3m0bCVqwJWrzjVIF0rKTVCwOdxpKr4U8ffhKJxDnKdJxQye2MiFsO/U3hRrBAao6eqnrBeYn1VrYaLZ08A1Wl9Z5xod0TeeeXJoAlPq4ob86AIrW5F72W1RLb6Y8i7dbNGQ0wG0ZPPdJrnHx3ddCKTq1AvzzEonnq65+GvFWt5ib+eWk6PDEmYkw/qbgzKJ6uMzgT30pRcJKEriWAkeuLoBoGySIYQT6aP6PODTi8/cTIOivZAtMWoX4oBPtRc+uaFxnkjxEp9jjlyB7r5+hJNynaa1yQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(46966006)(36840700001)(4326008)(7696005)(186003)(426003)(82310400003)(478600001)(16526019)(1076003)(2906002)(6666004)(36860700001)(2616005)(44832011)(83380400001)(47076005)(70586007)(8936002)(6916009)(26005)(356005)(36756003)(34020700004)(336012)(8676002)(81166007)(5660300002)(54906003)(86362001)(316002)(70206006)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 20:41:04.7994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94687e80-926c-4feb-4649-08d95b760220
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2775
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

This patch adds support to program trap handler settings
when loading driver with software scheduler (sched_policy=2).

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Suggested-by: Jay Cornwall <Jay.Cornwall@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 31 +++++++++++++++++
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  | 31 +++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 33 ++++++++++++++++++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 20 +++++++++--
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  3 ++
 5 files changed, 115 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 491acdf92f73..960acf68150a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -560,6 +560,9 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	case KFD_PREEMPT_TYPE_WAVEFRONT_RESET:
 		type = RESET_WAVES;
 		break;
+	case KFD_PREEMPT_TYPE_WAVEFRONT_SAVE:
+		type = SAVE_WAVES;
+		break;
 	default:
 		type = DRAIN_PIPE;
 		break;
@@ -754,6 +757,33 @@ static void set_vm_context_page_table_base(struct kgd_dev *kgd, uint32_t vmid,
 	adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, page_table_base);
 }
 
+static void program_trap_handler_settings(struct kgd_dev *kgd,
+		uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr)
+{
+	struct amdgpu_device *adev = get_amdgpu_device(kgd);
+
+	lock_srbm(kgd, 0, 0, 0, vmid);
+
+	/*
+	 * Program TBA registers
+	 */
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_LO),
+			lower_32_bits(tba_addr >> 8));
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_HI),
+			upper_32_bits(tba_addr >> 8) |
+			(1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
+
+	/*
+	 * Program TMA registers
+	 */
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_LO),
+			lower_32_bits(tma_addr >> 8));
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_HI),
+			upper_32_bits(tma_addr >> 8));
+
+	unlock_srbm(kgd);
+}
+
 const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
 	.program_sh_mem_settings = kgd_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_set_pasid_vmid_mapping,
@@ -774,4 +804,5 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
 	.get_atc_vmid_pasid_mapping_info =
 			get_atc_vmid_pasid_mapping_info,
 	.set_vm_context_page_table_base = set_vm_context_page_table_base,
+	.program_trap_handler_settings = program_trap_handler_settings,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index 1f5620cc3570..dac0d751d5af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -537,6 +537,9 @@ static int hqd_destroy_v10_3(struct kgd_dev *kgd, void *mqd,
 	case KFD_PREEMPT_TYPE_WAVEFRONT_RESET:
 		type = RESET_WAVES;
 		break;
+	case KFD_PREEMPT_TYPE_WAVEFRONT_SAVE:
+		type = SAVE_WAVES;
+		break;
 	default:
 		type = DRAIN_PIPE;
 		break;
@@ -658,6 +661,33 @@ static void set_vm_context_page_table_base_v10_3(struct kgd_dev *kgd, uint32_t v
 	adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, page_table_base);
 }
 
+static void program_trap_handler_settings_v10_3(struct kgd_dev *kgd,
+			uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr)
+{
+	struct amdgpu_device *adev = get_amdgpu_device(kgd);
+
+	lock_srbm(kgd, 0, 0, 0, vmid);
+
+	/*
+	 * Program TBA registers
+	 */
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_LO),
+			lower_32_bits(tba_addr >> 8));
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_HI),
+			upper_32_bits(tba_addr >> 8) |
+			(1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
+
+	/*
+	 * Program TMA registers
+	 */
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_LO),
+			lower_32_bits(tma_addr >> 8));
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_HI),
+			 upper_32_bits(tma_addr >> 8));
+
+	unlock_srbm(kgd);
+}
+
 #if 0
 uint32_t enable_debug_trap_v10_3(struct kgd_dev *kgd,
 				uint32_t trap_debug_wave_launch_mode,
@@ -820,6 +850,7 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd = {
 	.address_watch_get_offset = address_watch_get_offset_v10_3,
 	.get_atc_vmid_pasid_mapping_info = NULL,
 	.set_vm_context_page_table_base = set_vm_context_page_table_base_v10_3,
+	.program_trap_handler_settings = program_trap_handler_settings_v10_3,
 #if 0
 	.enable_debug_trap = enable_debug_trap_v10_3,
 	.disable_debug_trap = disable_debug_trap_v10_3,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index ed3014fbb563..154244916727 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -42,7 +42,8 @@
 enum hqd_dequeue_request_type {
 	NO_ACTION = 0,
 	DRAIN_PIPE,
-	RESET_WAVES
+	RESET_WAVES,
+	SAVE_WAVES
 };
 
 static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev *kgd)
@@ -566,6 +567,9 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	case KFD_PREEMPT_TYPE_WAVEFRONT_RESET:
 		type = RESET_WAVES;
 		break;
+	case KFD_PREEMPT_TYPE_WAVEFRONT_SAVE:
+		type = SAVE_WAVES;
+		break;
 	default:
 		type = DRAIN_PIPE;
 		break;
@@ -878,6 +882,32 @@ void kgd_gfx_v9_get_cu_occupancy(struct kgd_dev *kgd, int pasid,
 				adev->gfx.cu_info.max_waves_per_simd;
 }
 
+static void kgd_gfx_v9_program_trap_handler_settings(struct kgd_dev *kgd,
+                        uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr)
+{
+	struct amdgpu_device *adev = get_amdgpu_device(kgd);
+
+	lock_srbm(kgd, 0, 0, 0, vmid);
+
+	/*
+	 * Program TBA registers
+	 */
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_LO),
+                        lower_32_bits(tba_addr >> 8));
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_HI),
+                        upper_32_bits(tba_addr >> 8));
+
+	/*
+	 * Program TMA registers
+	 */
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_LO),
+			lower_32_bits(tma_addr >> 8));
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_HI),
+			upper_32_bits(tma_addr >> 8));
+
+	unlock_srbm(kgd);
+}
+
 const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
@@ -899,4 +929,5 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 			kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
 	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
 	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
+	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index a972ef5eae68..6fd6b2248992 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -211,6 +211,14 @@ static void deallocate_doorbell(struct qcm_process_device *qpd,
 	WARN_ON(!old);
 }
 
+static void program_trap_handler_settings(struct device_queue_manager *dqm,
+				struct qcm_process_device *qpd)
+{
+	return dqm->dev->kfd2kgd->program_trap_handler_settings(
+						dqm->dev->kgd, qpd->vmid,
+						qpd->tba_addr, qpd->tma_addr);
+}
+
 static int allocate_vmid(struct device_queue_manager *dqm,
 			struct qcm_process_device *qpd,
 			struct queue *q)
@@ -241,6 +249,10 @@ static int allocate_vmid(struct device_queue_manager *dqm,
 
 	program_sh_mem_settings(dqm, qpd);
 
+	if (dqm->dev->device_info->asic_family >= CHIP_VEGA10 &&
+	    dqm->dev->cwsr_enabled)
+		program_trap_handler_settings(dqm, qpd);
+
 	/* qpd->page_table_base is set earlier when register_process()
 	 * is called, i.e. when the first queue is created.
 	 */
@@ -582,7 +594,9 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q)
 		}
 
 		retval = mqd_mgr->destroy_mqd(mqd_mgr, q->mqd,
-				KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN,
+				(dqm->dev->cwsr_enabled?
+				 KFD_PREEMPT_TYPE_WAVEFRONT_SAVE:
+				KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN),
 				KFD_UNMAP_LATENCY_MS, q->pipe, q->queue);
 		if (retval) {
 			pr_err("destroy mqd failed\n");
@@ -675,7 +689,9 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
 			continue;
 
 		retval = mqd_mgr->destroy_mqd(mqd_mgr, q->mqd,
-				KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN,
+				(dqm->dev->cwsr_enabled?
+				 KFD_PREEMPT_TYPE_WAVEFRONT_SAVE:
+				KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN),
 				KFD_UNMAP_LATENCY_MS, q->pipe, q->queue);
 		if (retval && !ret)
 			/* Return the first error, but keep going to
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 95c656d205ed..c84bd7b2cf59 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -44,6 +44,7 @@ struct kgd_mem;
 enum kfd_preempt_type {
 	KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN = 0,
 	KFD_PREEMPT_TYPE_WAVEFRONT_RESET,
+	KFD_PREEMPT_TYPE_WAVEFRONT_SAVE
 };
 
 struct kfd_vm_fault_info {
@@ -298,6 +299,8 @@ struct kfd2kgd_calls {
 
 	void (*get_cu_occupancy)(struct kgd_dev *kgd, int pasid, int *wave_cnt,
 			int *max_waves_per_cu);
+	void (*program_trap_handler_settings)(struct kgd_dev *kgd,
+			uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr);
 };
 
 #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
-- 
2.17.1

