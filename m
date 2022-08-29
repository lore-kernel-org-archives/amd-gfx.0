Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1FBECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:31:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5D0C10F2DD;
	Mon, 29 Aug 2022 14:31:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA7B810F2EE
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:30:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAF4RRIatb2F+BE8dQEcSnkAChTbHp8ZOCsYYB4esJ25AkEnkIELU1OAFiypG/ig66ftXC+VUzQOWLBojGxNdsvWjVs6T9Ss30i1kNc/YF0FOvIadPRM6nIfZ00tWsRap+Pn0ssPBE7I4ZydDDvyBjxBUeYO/HYn/45YyLX6MV1qiiEGAAx8k5hluAA6B4LIKb6xpzer7D4MUBuN6bjXc/iLXJzaemMrK8XE7lOjtRbfnWUnHjOESY9U6saY1qvwT1BrLvGyTsinkZF2j9c2ph1IutFz0NgMWNUf26CtUe1vhgP4KtAnThnuEeAVZjZIsQ+GkINerxIo+q9mUBmnig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmRAoe7tlGU/jIv00ut4Zu62+3D7wrOF1bMgVJwomi0=;
 b=T8+ycNvNMQoNwkLNtCVf2/td4Y+/jowPz3yX8fzWK6VPNGtQnSczfC/13+UmkDcsltsAQARz9Q56X2pmUV5jY8OGq+1DT2d41wH9fBP9p3K+8P3q+/wxZVpvzlv8R+Wxx0yokpQ9CmD0AQtGnyapqCqaMDXfBantEDRWG1z8uSIJNbx3CZhHI/izDwmPRUIy5E8yIf3rfLDhBsKG2yIAxYyQgbIW3c0opD5qVxM9a91AXuoTauaW7KTJavtk0Sl5mfvTXlO0/PzNprLEMtHeNU3Rydn4u+GZUswORMu6BiCXMUvTaSoFnj6JmRZ675cf9vkGbMZD5iOR6elXYKFC5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmRAoe7tlGU/jIv00ut4Zu62+3D7wrOF1bMgVJwomi0=;
 b=vNDxXBvZ1gFDenKwn1Z31bauoBgajQSnBquPbajWojvM6ZsVlswyNG5P+KQNUDbzvR7qfUFPfIa0ws30OzjkDguzoWsKFc9HSPWFcRlp45XnBdqIszMjkWTfD4l7KjJ83ypq+wdHQmMd7J/Pemrd2Svr3b2B+5xTZrDK/YlbAmA=
Received: from MW4PR04CA0316.namprd04.prod.outlook.com (2603:10b6:303:82::21)
 by BYAPR12MB2773.namprd12.prod.outlook.com (2603:10b6:a03:72::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 14:30:47 +0000
Received: from CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::46) by MW4PR04CA0316.outlook.office365.com
 (2603:10b6:303:82::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Mon, 29 Aug 2022 14:30:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT100.mail.protection.outlook.com (10.13.175.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:30:47 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:30:42 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/29] drm/amdgpu: setup hw debug registers on driver
 initialization
Date: Mon, 29 Aug 2022 10:30:02 -0400
Message-ID: <20220829143026.1509027-6-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829143026.1509027-1-jonathan.kim@amd.com>
References: <20220829143026.1509027-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7f908d6-e408-4c06-00b6-08da89cb105d
X-MS-TrafficTypeDiagnostic: BYAPR12MB2773:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lErB8uAt1D21hSZeOjLzdGUMSkQBAbpz5tfY6RfZAe1oyg2IvjQMiBUe1Epd8nIjTBVUAzC+zK86HXuC8TSwR30YVxKJYpCYn8SmR1eA9l/Cu/FGICU/yBxCEk2mD8hPfFvur3vtt25lzovu1Sy0pLnL0jvohfG429rYr4SkTiQ3Np8azWsYk5fA9vbrcw4L3GvCQJu1otwmDYDSVtS6M7NDdm+sMqwk08fFkLiqVI8v5BYBBUkv/WzJnRTiOU7nULnjUYX0IInVAWCNQost3c7zO2MPNfcf89e7WthujUtwPJPlBhXqW15BXkPNTX4P3pA7OPne4o9o3/kmT67vinLrR+MQqztYNqu1a8oouQjZo0ZgG42wamCUI+BH+RyHPDNbnU1Ih6yUX3rWm/ml/G/wglxurgKcioT+m6EtXGx3o4XMvIvIA7k9eWEXqfr6845khva5Aq2Dvx7NT/rVhS74RVRw9RnbJSCg9l1my2PTE0yuWt8Bke7bXF5mDNRqkhXIENvU54TvjuS1t47nMbgUaIKOm3joPpaWfKCm5IoJdBRNXWEMM4DUPDMKZIuYpIKdgnL9Jg2HvVHZvU1+VAAXd5RLzIl9fZviMaN9o11FCx5csD5vKVKgHHQI8Bu+Jeggn+9WXNZpE9C8Kiqdr3d/FgrqcFWk3LmrkPG7/4ofsJIFsVrVO3aGXiSeNYumr+eSYrNpY3YYjpCgPd0WwnQcxJ4sRXLjW/cU9PlCb0iKDkkjhqFHNdJG/nVCg71Jg2bO8UBOS99i+N192lH4e32TJf+/eOgDMaHiUZE8o1E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(39860400002)(40470700004)(36840700001)(46966006)(7696005)(2616005)(1076003)(47076005)(186003)(336012)(426003)(16526019)(8936002)(40480700001)(5660300002)(30864003)(44832011)(2906002)(41300700001)(36756003)(86362001)(6666004)(26005)(478600001)(83380400001)(81166007)(36860700001)(40460700003)(82740400003)(356005)(82310400005)(6916009)(4326008)(54906003)(316002)(8676002)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:30:47.0368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f908d6-e408-4c06-00b6-08da89cb105d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2773
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
Cc: Felix.Kuehling@amd.com, Lancelot.Six@amd.com, Laurent.Morichetti@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add missing debug trap registers references and initialize all debug
registers on boot by clearing the hardware exception overrides and the
wave allocation ID index.

For debug devices that only support single process debugging, enable
trap temporary setup by default.

Debug devices that support multi-process debugging require trap
temporary setup to be disabled by default in order to satisfy microbench
performance when in non-debug mode.

The debugger requires that TTMPs 6 & 7 save the dispatch ID to map
waves onto dispatch during compute context inspection.
In order to correctly this up, set the special reserved CP bit by default
whenever the MQD is initailized.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 26 +++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 30 ++++++++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |  5 ++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  5 ++
 .../include/asic_reg/gc/gc_10_1_0_offset.h    | 14 ++++
 .../include/asic_reg/gc/gc_10_1_0_sh_mask.h   | 69 +++++++++++++++++++
 .../include/asic_reg/gc/gc_10_3_0_offset.h    | 10 +++
 .../include/asic_reg/gc/gc_10_3_0_sh_mask.h   |  4 ++
 8 files changed, 163 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 1a915edccb92..54765d5d7d3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5142,6 +5142,29 @@ static u32 gfx_v10_0_init_pa_sc_tile_steering_override(struct amdgpu_device *ade
 
 #define DEFAULT_SH_MEM_BASES	(0x6000)
 
+static void gfx_v10_0_debug_trap_config_init(struct amdgpu_device *adev,
+				uint32_t first_vmid,
+				uint32_t last_vmid)
+{
+	uint32_t data;
+	uint32_t trap_config_vmid_mask = 0;
+	int i;
+
+	/* Calculate trap config vmid mask */
+	for (i = first_vmid; i < last_vmid; i++)
+		trap_config_vmid_mask |= (1 << i);
+
+	data = REG_SET_FIELD(0, SPI_GDBG_TRAP_CONFIG,
+			VMID_SEL, trap_config_vmid_mask);
+	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
+			TRAP_EN, 1);
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_CONFIG), data);
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), 0);
+
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_DATA0), 0);
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_DATA1), 0);
+}
+
 static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
 {
 	int i;
@@ -5173,6 +5196,9 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_OA_VMID0, i, 0);
 	}
+
+	gfx_v10_0_debug_trap_config_init(adev, adev->vm_manager.first_kfd_vmid,
+					AMDGPU_NUM_VMID);
 }
 
 static void gfx_v10_0_init_gds_vmid(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 7f187558220e..4e9cbbab0fef 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2515,6 +2515,29 @@ static void gfx_v9_0_setup_rb(struct amdgpu_device *adev)
 	adev->gfx.config.num_rbs = hweight32(active_rbs);
 }
 
+static void gfx_v9_0_debug_trap_config_init(struct amdgpu_device *adev,
+				uint32_t first_vmid,
+				uint32_t last_vmid)
+{
+	uint32_t data;
+	uint32_t trap_config_vmid_mask = 0;
+	int i;
+
+	/* Calculate trap config vmid mask */
+	for (i = first_vmid; i < last_vmid; i++)
+		trap_config_vmid_mask |= (1 << i);
+
+	data = REG_SET_FIELD(0, SPI_GDBG_TRAP_CONFIG,
+			VMID_SEL, trap_config_vmid_mask);
+	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
+			TRAP_EN, 1);
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_CONFIG), data);
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), 0);
+
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_DATA0), 0);
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_DATA1), 0);
+}
+
 #define DEFAULT_SH_MEM_BASES	(0x6000)
 static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
 {
@@ -4786,6 +4809,13 @@ static int gfx_v9_0_late_init(void *handle)
 	if (r)
 		return r;
 
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
+		gfx_v9_4_2_debug_trap_config_init(adev,
+			adev->vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
+	else
+		gfx_v9_0_debug_trap_config_init(adev,
+			adev->vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index d3e2b6a599a4..cb484ace17de 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -117,6 +117,11 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 			1 << CP_HQD_QUANTUM__QUANTUM_SCALE__SHIFT |
 			1 << CP_HQD_QUANTUM__QUANTUM_DURATION__SHIFT;
 
+	/* Set cp_hqd_hq_scheduler0 bit 14 to 1 to have the CP set up the
+	 * DISPATCH_PTR.  This is required for the kfd debugger
+	 */
+	m->cp_hqd_hq_scheduler0 = 1 << 14;
+
 	if (q->format == KFD_QUEUE_FORMAT_AQL) {
 		m->cp_hqd_aql_control =
 			1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 0778e587a2d6..86f1cf090246 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -164,6 +164,11 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 			1 << CP_HQD_QUANTUM__QUANTUM_SCALE__SHIFT |
 			1 << CP_HQD_QUANTUM__QUANTUM_DURATION__SHIFT;
 
+	/* Set cp_hqd_hq_scheduler0 bit 14 to 1 to have the CP set up the
+	 * DISPATCH_PTR.  This is required for the kfd debugger
+	 */
+	m->cp_hqd_hq_status0 = 1 << 14;
+
 	if (q->format == KFD_QUEUE_FORMAT_AQL) {
 		m->cp_hqd_aql_control =
 			1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
index 18d34bbceebe..7d384f86bd67 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
@@ -5190,6 +5190,20 @@
 #define mmSPI_WCL_PIPE_PERCENT_CS6_BASE_IDX                                                            0
 #define mmSPI_WCL_PIPE_PERCENT_CS7                                                                     0x1f70
 #define mmSPI_WCL_PIPE_PERCENT_CS7_BASE_IDX                                                            0
+#define mmSPI_GDBG_WAVE_CNTL                                                                           0x1f71
+#define mmSPI_GDBG_WAVE_CNTL_BASE_IDX                                                                  0
+#define mmSPI_GDBG_TRAP_CONFIG                                                                         0x1f72
+#define mmSPI_GDBG_TRAP_CONFIG_BASE_IDX                                                                0
+#define mmSPI_GDBG_TRAP_MASK                                                                           0x1f73
+#define mmSPI_GDBG_TRAP_MASK_BASE_IDX                                                                  0
+#define mmSPI_GDBG_WAVE_CNTL2                                                                          0x1f74
+#define mmSPI_GDBG_WAVE_CNTL2_BASE_IDX                                                                 0
+#define mmSPI_GDBG_WAVE_CNTL3                                                                          0x1f75
+#define mmSPI_GDBG_WAVE_CNTL3_BASE_IDX                                                                 0
+#define mmSPI_GDBG_TRAP_DATA0                                                                          0x1f78
+#define mmSPI_GDBG_TRAP_DATA0_BASE_IDX                                                                 0
+#define mmSPI_GDBG_TRAP_DATA1                                                                          0x1f79
+#define mmSPI_GDBG_TRAP_DATA1_BASE_IDX                                                                 0
 #define mmSPI_COMPUTE_QUEUE_RESET                                                                      0x1f7b
 #define mmSPI_COMPUTE_QUEUE_RESET_BASE_IDX                                                             0
 #define mmSPI_RESOURCE_RESERVE_CU_0                                                                    0x1f7c
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
index 4127896ffcdf..08772ba845b0 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
@@ -19646,6 +19646,75 @@
 //SPI_WCL_PIPE_PERCENT_CS7
 #define SPI_WCL_PIPE_PERCENT_CS7__VALUE__SHIFT                                                                0x0
 #define SPI_WCL_PIPE_PERCENT_CS7__VALUE_MASK                                                                  0x7FL
+//SPI_GDBG_WAVE_CNTL
+#define SPI_GDBG_WAVE_CNTL__STALL_RA__SHIFT                                                                   0x0
+#define SPI_GDBG_WAVE_CNTL__STALL_VMID__SHIFT                                                                 0x1
+#define SPI_GDBG_WAVE_CNTL__STALL_RA_MASK                                                                     0x00000001L
+#define SPI_GDBG_WAVE_CNTL__STALL_VMID_MASK                                                                   0x0001FFFEL
+//SPI_GDBG_TRAP_CONFIG
+#define SPI_GDBG_TRAP_CONFIG__ME_SEL__SHIFT                                                                   0x0
+#define SPI_GDBG_TRAP_CONFIG__PIPE_SEL__SHIFT                                                                 0x2
+#define SPI_GDBG_TRAP_CONFIG__QUEUE_SEL__SHIFT                                                                0x4
+#define SPI_GDBG_TRAP_CONFIG__ME_MATCH__SHIFT                                                                 0x7
+#define SPI_GDBG_TRAP_CONFIG__PIPE_MATCH__SHIFT                                                               0x8
+#define SPI_GDBG_TRAP_CONFIG__QUEUE_MATCH__SHIFT                                                              0x9
+#define SPI_GDBG_TRAP_CONFIG__TRAP_EN__SHIFT                                                                  0xf
+#define SPI_GDBG_TRAP_CONFIG__VMID_SEL__SHIFT                                                                 0x10
+#define SPI_GDBG_TRAP_CONFIG__ME_SEL_MASK                                                                     0x00000003L
+#define SPI_GDBG_TRAP_CONFIG__PIPE_SEL_MASK                                                                   0x0000000CL
+#define SPI_GDBG_TRAP_CONFIG__QUEUE_SEL_MASK                                                                  0x00000070L
+#define SPI_GDBG_TRAP_CONFIG__ME_MATCH_MASK                                                                   0x00000080L
+#define SPI_GDBG_TRAP_CONFIG__PIPE_MATCH_MASK                                                                 0x00000100L
+#define SPI_GDBG_TRAP_CONFIG__QUEUE_MATCH_MASK                                                                0x00000200L
+#define SPI_GDBG_TRAP_CONFIG__TRAP_EN_MASK                                                                    0x00008000L
+#define SPI_GDBG_TRAP_CONFIG__VMID_SEL_MASK                                                                   0xFFFF0000L
+//SPI_GDBG_TRAP_MASK
+#define SPI_GDBG_TRAP_MASK__EXCP_EN__SHIFT                                                                    0x0
+#define SPI_GDBG_TRAP_MASK__REPLACE__SHIFT                                                                    0x9
+#define SPI_GDBG_TRAP_MASK__EXCP_EN_MASK                                                                      0x01FFL
+#define SPI_GDBG_TRAP_MASK__REPLACE_MASK                                                                      0x0200L
+//SPI_GDBG_WAVE_CNTL2
+#define SPI_GDBG_WAVE_CNTL2__VMID_MASK__SHIFT                                                                 0x0
+#define SPI_GDBG_WAVE_CNTL2__MODE__SHIFT                                                                      0x10
+#define SPI_GDBG_WAVE_CNTL2__VMID_MASK_MASK                                                                   0x0000FFFFL
+#define SPI_GDBG_WAVE_CNTL2__MODE_MASK                                                                        0x00030000L
+//SPI_GDBG_WAVE_CNTL3
+#define SPI_GDBG_WAVE_CNTL3__STALL_PS__SHIFT                                                                  0x0
+#define SPI_GDBG_WAVE_CNTL3__STALL_VS__SHIFT                                                                  0x1
+#define SPI_GDBG_WAVE_CNTL3__STALL_GS__SHIFT                                                                  0x2
+#define SPI_GDBG_WAVE_CNTL3__STALL_HS__SHIFT                                                                  0x3
+#define SPI_GDBG_WAVE_CNTL3__STALL_CSG__SHIFT                                                                 0x4
+#define SPI_GDBG_WAVE_CNTL3__STALL_CS0__SHIFT                                                                 0x5
+#define SPI_GDBG_WAVE_CNTL3__STALL_CS1__SHIFT                                                                 0x6
+#define SPI_GDBG_WAVE_CNTL3__STALL_CS2__SHIFT                                                                 0x7
+#define SPI_GDBG_WAVE_CNTL3__STALL_CS3__SHIFT                                                                 0x8
+#define SPI_GDBG_WAVE_CNTL3__STALL_CS4__SHIFT                                                                 0x9
+#define SPI_GDBG_WAVE_CNTL3__STALL_CS5__SHIFT                                                                 0xa
+#define SPI_GDBG_WAVE_CNTL3__STALL_CS6__SHIFT                                                                 0xb
+#define SPI_GDBG_WAVE_CNTL3__STALL_CS7__SHIFT                                                                 0xc
+#define SPI_GDBG_WAVE_CNTL3__STALL_DURATION__SHIFT                                                            0xd
+#define SPI_GDBG_WAVE_CNTL3__STALL_MULT__SHIFT                                                                0x1c
+#define SPI_GDBG_WAVE_CNTL3__STALL_PS_MASK                                                                    0x00000001L
+#define SPI_GDBG_WAVE_CNTL3__STALL_VS_MASK                                                                    0x00000002L
+#define SPI_GDBG_WAVE_CNTL3__STALL_GS_MASK                                                                    0x00000004L
+#define SPI_GDBG_WAVE_CNTL3__STALL_HS_MASK                                                                    0x00000008L
+#define SPI_GDBG_WAVE_CNTL3__STALL_CSG_MASK                                                                   0x00000010L
+#define SPI_GDBG_WAVE_CNTL3__STALL_CS0_MASK                                                                   0x00000020L
+#define SPI_GDBG_WAVE_CNTL3__STALL_CS1_MASK                                                                   0x00000040L
+#define SPI_GDBG_WAVE_CNTL3__STALL_CS2_MASK                                                                   0x00000080L
+#define SPI_GDBG_WAVE_CNTL3__STALL_CS3_MASK                                                                   0x00000100L
+#define SPI_GDBG_WAVE_CNTL3__STALL_CS4_MASK                                                                   0x00000200L
+#define SPI_GDBG_WAVE_CNTL3__STALL_CS5_MASK                                                                   0x00000400L
+#define SPI_GDBG_WAVE_CNTL3__STALL_CS6_MASK                                                                   0x00000800L
+#define SPI_GDBG_WAVE_CNTL3__STALL_CS7_MASK                                                                   0x00001000L
+#define SPI_GDBG_WAVE_CNTL3__STALL_DURATION_MASK                                                              0x0FFFE000L
+#define SPI_GDBG_WAVE_CNTL3__STALL_MULT_MASK                                                                  0x10000000L
+//SPI_GDBG_TRAP_DATA0
+#define SPI_GDBG_TRAP_DATA0__DATA__SHIFT                                                                      0x0
+#define SPI_GDBG_TRAP_DATA0__DATA_MASK                                                                        0xFFFFFFFFL
+//SPI_GDBG_TRAP_DATA1
+#define SPI_GDBG_TRAP_DATA1__DATA__SHIFT                                                                      0x0
+#define SPI_GDBG_TRAP_DATA1__DATA_MASK                                                                        0xFFFFFFFFL
 //SPI_COMPUTE_QUEUE_RESET
 #define SPI_COMPUTE_QUEUE_RESET__RESET__SHIFT                                                                 0x0
 #define SPI_COMPUTE_QUEUE_RESET__RESET_MASK                                                                   0x01L
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
index 594bffce93a9..b7c1445b0bed 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
@@ -26,6 +26,8 @@
 #define mmSQ_DEBUG_STS_GLOBAL_BASE_IDX                                                                 0
 #define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x10B0
 #define mmSQ_DEBUG_STS_GLOBAL2_BASE_IDX                                                                0
+#define mmSQ_DEBUG                                                                                     0x10B1
+#define mmSQ_DEBUG_BASE_IDX                                                                            0
 
 // addressBlock: gc_sdma0_sdma0dec
 // base address: 0x4980
@@ -4849,10 +4851,18 @@
 #define mmSPI_WCL_PIPE_PERCENT_CS3_BASE_IDX                                                            0
 #define mmSPI_GDBG_WAVE_CNTL                                                                           0x1f71
 #define mmSPI_GDBG_WAVE_CNTL_BASE_IDX                                                                  0
+#define mmSPI_GDBG_TRAP_CONFIG                                                                         0x1f72
+#define mmSPI_GDBG_TRAP_CONFIG_BASE_IDX                                                                0
 #define mmSPI_GDBG_TRAP_MASK                                                                           0x1f73
 #define mmSPI_GDBG_TRAP_MASK_BASE_IDX                                                                  0
 #define mmSPI_GDBG_WAVE_CNTL2                                                                          0x1f74
 #define mmSPI_GDBG_WAVE_CNTL2_BASE_IDX                                                                 0
+#define mmSPI_GDBG_WAVE_CNTL3                                                                          0x1f75
+#define mmSPI_GDBG_WAVE_CNTL3_BASE_IDX                                                                 0
+#define mmSPI_GDBG_TRAP_DATA0                                                                          0x1f78
+#define mmSPI_GDBG_TRAP_DATA0_BASE_IDX                                                                 0
+#define mmSPI_GDBG_TRAP_DATA1                                                                          0x1f79
+#define mmSPI_GDBG_TRAP_DATA1_BASE_IDX                                                                 0
 #define mmSPI_COMPUTE_QUEUE_RESET                                                                      0x1f7b
 #define mmSPI_COMPUTE_QUEUE_RESET_BASE_IDX                                                             0
 #define mmSPI_RESOURCE_RESERVE_CU_0                                                                    0x1f7c
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
index a827b0ff8905..30d67feba1a8 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
@@ -46386,6 +46386,10 @@
 
 
 // addressBlock: sqind
+//SQ_DEBUG
+#define SQ_DEBUG__SINGLE_MEMOP_MASK 0x00000001L
+#define SQ_DEBUG__SINGLE_MEMOP__SHIFT 0x00000000
+
 //SQ_DEBUG_STS_GLOBAL
 #define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX0_MASK 0x000000ffL
 #define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX0__SHIFT 0x00000000
-- 
2.25.1

