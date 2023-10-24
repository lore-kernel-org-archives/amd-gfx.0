Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1D3C07545
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 14:49:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 153F610E3CE;
	Tue, 24 Oct 2023 14:49:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CF8710E3CE
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 14:49:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEIlksLFyTSu40F9fyiKEcoz7llWMiwL3IN+zXHWKNYSxQraXlo/fmfSX9X/vSNi6tWiT5/Ce+arnDUtqgjFPnDOu6SVfXk33uwjoWSGmh+LQ0C6NHC7h1Mo2uC6BfMXZvlqQjR4UQ4/PgC6O8bjSqbaFmRdCC7lfXaQgBHJQeNnhX8bXIriWh31Q7igju9WU7v+B00/TYC4KB48mwBiFWjOVM4T6xZ2wBQtI1MDIP9iu13kYARSqU2teTJ+iLQ4NSy0zGJ5asgyt3vm8f/sbxKv3kYo63L8NePmYTR86BJftpx72Y2p+a5vcjm9glgoFL3qQN0R05g14VnaZLKlGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yl6qVWSmfp9FwjnaXJHX2lZnrQsuT/HBzEsihXTuULw=;
 b=C7sMSFvdT0LzoQi5SLylaR7n7JhAY1NZ46h1ufMkhN2TpjkVmpEXWTBdSbmkfQddmDvSs67TeAKRtEjCQK7JDA5a2h7f6dosMYhLZvk+4rOKQR0vvcZ8u7cJwHgQvwnNCvrQj+j99uoE6t380LunPC1cSjQCoiYlP7k9AaeZ4GfWMRdxJrONYQblVWBe50qSBkimLGsVAbaEABp/zt9ub6mod+8lJTsk5yX2pslq5u5NAv9eYIHFdU1en4eTFB90PwOM95wTbe13rUtq+JIh2h+WNzmMu2W+2UUi+7acG/ZR8IqBltjtJ3Ajae3D8T/q/QSl5zLlHaz1QRT/kLfAAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yl6qVWSmfp9FwjnaXJHX2lZnrQsuT/HBzEsihXTuULw=;
 b=u1ofoOFnj73PAd0X9kmlfejyMsSbl1xrzeEHrjzWNlAYLjjQty/vAo0JIg/yf/U/pUynyOa5fEH/jseuEpopCFFqbyOjnv0zdTmSrq9GVh5WeZvHMJQCbwWb+1GD3sr/aOGauPyinlRvEPeM9p+/WX3YBCVErV6B3uxoBH1ieJs=
Received: from SA9PR13CA0168.namprd13.prod.outlook.com (2603:10b6:806:28::23)
 by MW4PR12MB7383.namprd12.prod.outlook.com (2603:10b6:303:219::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 14:49:46 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:28:cafe::f2) by SA9PR13CA0168.outlook.office365.com
 (2603:10b6:806:28::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.15 via Frontend
 Transport; Tue, 24 Oct 2023 14:49:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Tue, 24 Oct 2023 14:49:46 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 24 Oct 2023 09:49:43 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <yifan1.zhang@amd.com>, <kenneth.feng@amd.com>, <Mario.Limonciello@amd.com>
Subject: [PATCH v2 2/3] drm/amdgpu: avoid sending csib command when system
 resumes from S3
Date: Tue, 24 Oct 2023 22:49:33 +0800
Message-ID: <3e270efa46affe3c52614099575368726eb32793.1698158958.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3ad257465bb9fe2542970ae0f3ab06dd29f1f1b2.1698158958.git.perry.yuan@amd.com>
References: <3ad257465bb9fe2542970ae0f3ab06dd29f1f1b2.1698158958.git.perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|MW4PR12MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: 26142ac4-08d5-4139-6d19-08dbd4a0772e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TnLLJNrtHQWxIkXpoiepd+bckkGCwfTbTukRJAjo1/QJsZW9bOXJRzrF9E/EAUBpVq18/WHGdFFETe6TgCva8obu5r3fYhLSBvjZVmCaEZS0s5gde+aknOe55jPfLZ4tV5JP4qzRbALYz5nlPcxQ3bpGqsdVYTDS1AA1HOk1OyXWBWn2GdOulpm/clmvYQW/ZH6VNaHbvjaD4cJH17P8Gw+sa8EVB+DIQXoRncH1aA8N/Z6NPKbUGLlgcERNB0nM39jn6lB61iAMuaIAPrRTfrSZaxRipQPJLo29FEXUaBV8GRmuDYCQKm37L0c9p0ncNn8jZ4U3Z0L3NC/mmPtMH7bSSb0IhNeASoicsuBh97rtlQBeTkMl0WM4eXtw20LUFb8MvAwIz9DpJiByMwZz/ZxwWoopvQCK4TRPByLgdqJz2at5lCB/QwPn3pR7cPMsauwBCWtZwr8FP2HKg4HaQHIsyL7fqNrh30jWFJTAPDqyhxczaQs1+4EhV1MXpovyv+iy27+Dn3MzWAb9a5ziqmji9mqf32m/pxQ4tU1HXCBVL2Q8odoLRlln0NTVpBkd6X6+DrHRbmNXhefUcxL9y4am/FjkwzMBzzFRaG7WLMm8qZ/hQk3Zy4UA5IMGfSVeUi9jPN26Mdhwq5CEfZ7rkq8kCZtGLwHkJ1beoL8s2VbftGjeGaKKGremq6iKr3fTcXJvI4ALEn4OazibEzpT8XLcpmSeWTnhCFuhRf/aKlgPH3Fu9y715kwXv/ibbhBxL5KqvxKqOx3Pkk5DgRxlNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(82310400011)(186009)(1800799009)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(26005)(86362001)(2906002)(40460700003)(5660300002)(4326008)(41300700001)(8676002)(8936002)(36756003)(6666004)(2616005)(54906003)(478600001)(16526019)(7696005)(70586007)(70206006)(110136005)(356005)(6636002)(36860700001)(44832011)(316002)(82740400003)(81166007)(83380400001)(40480700001)(47076005)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 14:49:46.1975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26142ac4-08d5-4139-6d19-08dbd4a0772e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7383
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 kevinyang.wang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Previously the CSIB command pocket was sent to GFX block while amdgpu
driver loading or S3 resuming time all the time.
As the CP protocol required, the CSIB is not needed to send again while
GC is not powered down while resuming from aborted S3 suspend sequence.

PREAMBLE_CNTL packet coming in the ring after PG event where the RLC
already sent its copy of CSIB, send another CSIB pocket will cause
Gfx IB testing timeout when system resume from S3.

Add flag `csib_initialized` to make sure normal S3 suspend/resume
will initialize csib normally, when system abort to S3 suspend and
resume immediately because of some failed suspend callback, GPU is not
power down at that time, so csib command is not needed to send again.

Error dmesg log:
amdgpu 0000:04:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on gfx_0.0.0 (-110).
[drm:amdgpu_device_delayed_init_work_handler [amdgpu]] *ERROR* ib ring test failed (-110).
PM: resume of devices complete after 2373.995 msecs
PM: Finishing wakeup.

v1-v2:
 * align csib_initialized with other failed with space[Kevin]
 * check return value check for gfx_v10_0_wait_for_idle()[Kevin]

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  5 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 32 ++++++++++++++++++-------
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 44df1a5bce7f..7d570f53e66b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1114,6 +1114,7 @@ struct amdgpu_device {
 	bool                            debug_vm;
 	bool                            debug_largebar;
 	bool                            debug_disable_soft_recovery;
+	bool                            csib_initialized;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 420196a17e22..a47c9f840754 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2468,6 +2468,11 @@ static int amdgpu_pmops_suspend_noirq(struct device *dev)
 	if (amdgpu_acpi_should_gpu_reset(adev))
 		return amdgpu_asic_reset(adev);
 
+	/* update flag to make sure csib will be sent when system
+	 * resume from normal S3
+	 */
+	adev->csib_initialized = false;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 6399bc71c56d..138340e1fa95 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3481,6 +3481,7 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev);
 static void gfx_v10_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
 				   u32 sh_num, u32 instance, int xcc_id);
 static u32 gfx_v10_0_get_wgp_active_bitmap_per_sh(struct amdgpu_device *adev);
+static int gfx_v10_0_wait_for_idle(void *handle);
 
 static int gfx_v10_0_rlc_backdoor_autoload_buffer_init(struct amdgpu_device *adev);
 static void gfx_v10_0_rlc_backdoor_autoload_buffer_fini(struct amdgpu_device *adev);
@@ -5958,7 +5959,7 @@ static int gfx_v10_0_cp_gfx_load_microcode(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
+static int gfx_v10_csib_submit(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring;
 	const struct cs_section_def *sect = NULL;
@@ -5966,13 +5967,6 @@ static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
 	int r, i;
 	int ctx_reg_offset;
 
-	/* init the CP */
-	WREG32_SOC15(GC, 0, mmCP_MAX_CONTEXT,
-		     adev->gfx.config.max_hw_contexts - 1);
-	WREG32_SOC15(GC, 0, mmCP_DEVICE_ID, 1);
-
-	gfx_v10_0_cp_gfx_enable(adev, true);
-
 	ring = &adev->gfx.gfx_ring[0];
 	r = amdgpu_ring_alloc(ring, gfx_v10_0_get_csb_size(adev) + 4);
 	if (r) {
@@ -6035,6 +6029,28 @@ static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
 
 		amdgpu_ring_commit(ring);
 	}
+
+	r = gfx_v10_0_wait_for_idle(adev);
+	if (r)
+		return r;
+
+	adev->csib_initialized = true;
+
+	return 0;
+};
+
+static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
+{
+	/* init the CP */
+	WREG32_SOC15(GC, 0, mmCP_MAX_CONTEXT,
+		     adev->gfx.config.max_hw_contexts - 1);
+	WREG32_SOC15(GC, 0, mmCP_DEVICE_ID, 1);
+
+	gfx_v10_0_cp_gfx_enable(adev, true);
+
+	if (!adev->csib_initialized)
+		gfx_v10_csib_submit(adev);
+
 	return 0;
 }
 
-- 
2.34.1

