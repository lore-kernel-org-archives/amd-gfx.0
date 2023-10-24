Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE50C00A8F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 02:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A83CA10E2CF;
	Tue, 24 Oct 2023 02:33:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06FCC10E08B
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 02:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbArSloLLdjLDG6OVTagKeUdrCZuqV4HUTtchJzZzFFNZVB/Dlby0tMj/a3XsXyWkbtIafZLb6x5zyrEPGip4ZjDyECnQiLqoTKPcJilc388G0QzEHSTVhmCPIGr73mhU5dWxBCaVnuRwmHzGnkEU064hGV++27y62i4yRzwgKRk2EcJQko0U7lCe5RjjWyZGKC69Y3yJQHsNLCSYC7vKUZul7Qzg4Gb9d896wWygGAAFrn6+jbspTQIIPk7YjmsyDiyceXjhfzILUE8RE0TvUUScf2MKKYxrc4lcy6g7EM6R9fjGXrZB9fFtL+c3EEk+YywBC/A+dLB8u6Bh063xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eq0XN0EXqElJGH3V3hQEad2HAf9sEM3UQEw7/9xP9m8=;
 b=Du/BkGKHUXralSoQknDTgUBgYqdibT6W62so5vXfXni4GdFG1UO9N2lMc0+1a7XBbLa48X6Wcb7XreETNnMKDC00K3QFG7GoiJ86PsVbNosml/g+AcyYaaE6w6cVcEG087Ii2vQBtLkx7eQ+MMjHnMvRJdkmln0LQkQ8b86kKdacUpCRGwXj9seP7KpZcVRSXfNBoYm3kAMWuwjnbYIZ4Q5JIuRnOI6D42MUqj/RsAMlypW4JZIcPzcvW2ygKrZPg0uyHbtzl2//wdFG4ocvpSargmuKQkPl/BPe439K8AGaqV75TtQlkqpcSEG9U1iKnwa04lmutrTJlBj7KXcxZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eq0XN0EXqElJGH3V3hQEad2HAf9sEM3UQEw7/9xP9m8=;
 b=CFS7RJffPj4io3MnPn7KSSa7CJKSgX4Lcvfe+iUjRNmAVcieLl8tk7RWZ5OxTI2Kjcta5Zn2Nr70DJTFefp3Rts4sGSK7EU9Lp9PcwPvoZIYP6ZNlbpyKaG5Ek54qlqY8egQjAtQE+WIbX50i/OfVVLkW1CRoi1DYCIoXc404tg=
Received: from BL1PR13CA0157.namprd13.prod.outlook.com (2603:10b6:208:2bd::12)
 by SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 02:33:36 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2bd:cafe::65) by BL1PR13CA0157.outlook.office365.com
 (2603:10b6:208:2bd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.16 via Frontend
 Transport; Tue, 24 Oct 2023 02:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Tue, 24 Oct 2023 02:33:35 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 23 Oct 2023 21:33:32 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <yifan1.zhang@amd.com>, <kenneth.feng@amd.com>, <Mario.Limonciello@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: avoid sending csib command when system
 resumes from S3
Date: Tue, 24 Oct 2023 10:33:17 +0800
Message-ID: <c8aab746fe07c1385caa25afac8e69bfad2e693d.1698114574.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <9d71cec3a900bedfc4a9f2409a606405deb60985.1698114574.git.perry.yuan@amd.com>
References: <9d71cec3a900bedfc4a9f2409a606405deb60985.1698114574.git.perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: b089c3fd-dd33-4518-0d8d-08dbd4399f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +0aSjEEnwb4CGMAImmvAJHW26KfB10ezUjvv1ROJOtorP80s6qDzZxaXh+szv2vY7yB0s9XWHoHiT8EKnjjx+CVJdtMaXjcOuE4aI7yP485QUzOKcV+a0mRrKinOnUqRSLjtoJy2Z5+n0oNzX97J6tCDrl+ShlY2gZcHp1dZy3GcCLqHP5QfUiJ8CWKXKOpphFM8o/e9hEKS6nSHcaKgkIx9ktKdLTbPpLDqWt2k+Ty4PDYWiVKRzwlbgYBkXDTEOAJMWmqu1BtVd1lZsQcsjzfazcYGfKn4XoObMEvMqXml4yttql8w1xUYxcsdX5+EPbgxtGCoSJZ076WsXSUyZShoEov67p/lu2hHQLAvqzkvPbSy4FwFxMqj8nBd5YC1NeG6Wm/A6S81+iprcXrN+aqXw8f0cO7MQ6Iyqhca+JV0Htcwcg3Tl75P4/Nq7jm67dgiaDOLXgi0nfgbMvUIWspAZcbfUWB6li/3aK/8xS4py2ShTj6lep/0/knfsIJaExlGRAN0Xk/aFl2tl0ecIovl4xfT7GLpcQneFaz/nZhBzi/s3FA5DHUFI3wcXihbcUszUbXRxce8Sf/9XR7r5tHTZ8YtOM0lNSN5L8XHgXsgC6XSr9l3fOFy49oR4lFEFPZsEGvXpqkKR80dHTPI1WkMxABDHb0i9ORh84Mo34YkUf9HeyOpQONWEdZ0Y7OGql+Y1ZxwhwdGGhKr9QVP8jPPLb0bxC8hFKqs1KtE03gRfHUaXJW7+QeFS3fHLZllItuatPnUsfII3n6kj4ZHaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(64100799003)(36840700001)(46966006)(40470700004)(6666004)(7696005)(44832011)(110136005)(6636002)(54906003)(70206006)(478600001)(70586007)(316002)(5660300002)(8676002)(8936002)(4326008)(40460700003)(41300700001)(16526019)(2906002)(40480700001)(82740400003)(83380400001)(36860700001)(2616005)(426003)(336012)(26005)(36756003)(356005)(86362001)(47076005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 02:33:35.3243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b089c3fd-dd33-4518-0d8d-08dbd4399f4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759
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

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  5 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 29 ++++++++++++++++++-------
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 44df1a5bce7f..e5d85ea26a5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1114,6 +1114,7 @@ struct amdgpu_device {
 	bool                            debug_vm;
 	bool                            debug_largebar;
 	bool                            debug_disable_soft_recovery;
+	bool				csib_initialized;
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
index 6399bc71c56d..ab2e3e592dfc 100644
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
@@ -6035,6 +6029,25 @@ static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
 
 		amdgpu_ring_commit(ring);
 	}
+
+	gfx_v10_0_wait_for_idle(adev);
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

