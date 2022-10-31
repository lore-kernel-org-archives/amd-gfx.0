Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01CFFA3743
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 16:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 294F310E306;
	Mon, 31 Oct 2022 16:25:56 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F235810E2ED
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 16:24:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUKHl5BTvrV7UMb3zvvht1w9dKzWfjGUniy6t5vPPx0VRoL07uBSrJYD2MFSdeBokBTp/DWjXJL7tAOnFCy3jB2yDLJcmvZ2MjBEaUZxcBnQTUSGFpcpv08d2bwoYXQoaWjJixn+I3XVjLqdQD5XkoZxc12QEXiPia39cJ51ptJo7hWqz1QZEA2fNABVcKwlEyGExS5Fbsjcn7sD2VyEhBBKDvkLtvCS2cSGPG+OWyZRs8W16sPdugMQQ2PCISf4KMajATmAu3aiQ6Cj+7HpWB3g5jATBeO6NHzHO3g9No7H/4+7fQjwtPNBOKZ+qRXynATZSfA+OhYhh9BL0KKnVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENPAYnIOJ9R817bpkai/a80c55C3Dj+K+ssPRZIN7eM=;
 b=NcJ+2JZ9OpMHWh7j6QyNO4khNC+Yw8Vf5oBZzhJ77LNQsqTKDvtE0nwkbykcGfB7HMqQavMa5+/JHomVz4P1ZsFGWHFse3rDQFF3zHtMHiHGH06qfpjKleddVvcdD0MRlLvZlgbrmjFygKQmJ3EoNvnYpO9wvBoMjWgzNisa68c7pTW3HRmp+GjfI3KqD2TSPLi2iWD+06j5MPv+T3Ekq/Z8uxlv2oW0vlZJpcsZGGzfHDuVo5a+Zd6rShTM3dDAioxF1ej1SuF8F+zNimHKmEZ81FOlPUTA9x3yzXj7Zr3oV1FmDJtj8JIAbyRBrwOgohKmvXuUB7jrvtxFUaWA/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENPAYnIOJ9R817bpkai/a80c55C3Dj+K+ssPRZIN7eM=;
 b=mLa/lovoj2nla10aU2B+KsqQUJnMTTS1W3/i1UeEEnBKUqFE4ev105L0uX9X8fnUw0GpF6NFVV3Hk5qRiW90n0HXD3f/WC3P1jxm6DMGvtqQ8wB3hh4onJLrNQvFE2IS5jVH/cjw+2izYzx9E2FlFR/aQ0tZJBXZy37v6vGA/0o=
Received: from MW4PR04CA0160.namprd04.prod.outlook.com (2603:10b6:303:85::15)
 by IA1PR12MB6650.namprd12.prod.outlook.com (2603:10b6:208:3a1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Mon, 31 Oct
 2022 16:24:27 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::70) by MW4PR04CA0160.outlook.office365.com
 (2603:10b6:303:85::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Mon, 31 Oct 2022 16:24:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.21 via Frontend Transport; Mon, 31 Oct 2022 16:24:26 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 11:24:23 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/29] drm/amdgpu: setup hw debug registers on driver
 initialization
Date: Mon, 31 Oct 2022 12:23:35 -0400
Message-ID: <20221031162359.445805-5-jonathan.kim@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|IA1PR12MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: e7909de8-9274-4e8b-b507-08dabb5c6124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qodl3gE6p1jKluuonlwH4j+44xt5L8tZlzTCu5fCR3EbA9YUQkaWNg4W6pUBfiCcxtMMWCBwpi9Jvtmx/eAcwiLfbmXydykEIxJmWzOUxeIYCPikPZbejRhAOQDUugf5Xj/2hCkjUkcr5NfMnVszC4lSR9FKUnkr47QvWDTXuTwFAjNf8YeXK3PZreEXpXlCMW/JSjjqh0AQfRvzylIm6Z60C7lS42jFl6B5x3UuIr7v3GTYkOCsC1So0fOPSFomy9V9h+KiVhggxc9NFEtltbJVfDYMoMp9J1/+WwYXsn6vmTEyOSOoiemgZoskaQPQ8kkjpY7e9W3l4iRRTJzGGR3LuGtW6b3r6o6bDsuqNjpzum9FRjLzlEHLIQurDOFJfn+1YN1gk/cedLSdouY3w0uSFo9Vh44KSgy/UH3l0rpUiYXqU9rsvXgvSH+cF5Lrgg6lgkcU2AZBdethCQ/4tWJY7dP+/5SjhX/7Brm0FXvzubwg0B7txM/wKhyRG/eNoffHlyZ/nDN91SFDjqhYB9MKiKcERmjF+XiIBdGg930JgeMRJ98Qaq4rQgpVWQy/AXkfojGxZIsxCkmC8BY8CoiQTVCn9C0raEQrZRr1PJNcWGEfwgVixO9y5uY/cGZF5xyrJ3m+VLMVRpJF1DQl5zph9UEgNPhQGamnA9ltMLuncbXkwbA/g39hfKCRQXa5/TFHlX/wzatIEHnGQTwtZL8miBZw9NjLUqohJXcTXkBDP2oJD9JW45Rd5b5rgFBa44aqsiMZ7nB9zRAcvNO5M/hBgtzNJ0fYvqyFY1xsZx0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(426003)(44832011)(47076005)(356005)(81166007)(82740400003)(86362001)(478600001)(30864003)(2906002)(36860700001)(5660300002)(8936002)(70586007)(70206006)(4326008)(41300700001)(186003)(82310400005)(7696005)(8676002)(6666004)(1076003)(26005)(40460700003)(2616005)(16526019)(336012)(6916009)(316002)(83380400001)(40480700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 16:24:26.6121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7909de8-9274-4e8b-b507-08dabb5c6124
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650
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
index af94ac580d3e..d49aff0b4ba3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4904,6 +4904,29 @@ static u32 gfx_v10_0_init_pa_sc_tile_steering_override(struct amdgpu_device *ade
 
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
@@ -4935,6 +4958,9 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_OA_VMID0, i, 0);
 	}
+
+	gfx_v10_0_debug_trap_config_init(adev, adev->vm_manager.first_kfd_vmid,
+					AMDGPU_NUM_VMID);
 }
 
 static void gfx_v10_0_init_gds_vmid(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 0320be4a5fc6..a0e5ad342f13 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2337,6 +2337,29 @@ static void gfx_v9_0_setup_rb(struct amdgpu_device *adev)
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
@@ -4609,6 +4632,13 @@ static int gfx_v9_0_late_init(void *handle)
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
index 3973110f149c..d09f1a06f4bf 100644
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
index d4e8ff22ecb8..fc85aee010fe 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
@@ -47853,6 +47853,10 @@
 
 
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

