Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DF4C77B73
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Apr 2023 11:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DBB010E16C;
	Wed, 19 Apr 2023 11:43:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5DA510E94A
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Apr 2023 11:43:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bodsU32PncVvvyqZvTT4RxekkDQ/i9DDVrIa2zT3Ht3g5hVzkuAmERiyKfqxOY4mW7Z0HgBfBZe9HWqb5TVE8kdg65IZKEvhl7wOeUG1RT+aonQeUGSS2AI/l4zAKJqnFA6ouLn6yEXBC1Z5hezCCAB8EfVmdSvumhW38Gthqv0SN93gtYGxhAUR7zZ42lDnqok3VInoMsDu6AyAdyNUpMkVwd7/keaz6aAn8rAKpB0cwshBVToTPj0LknpE8x78ujHChmZuE5MqZQNLBpyKKqwPuGqUfjeowLcFG/cRag9wTYtscor6tTML7jjJDJ7xIjGViZkCh5zENSoeSd/1wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUT8j6t8uYLRvzJHwgj/x3oGNsb+wjJnDHJ+kHLR7RY=;
 b=MKzsak/+R8mC5xKkG7171UgkIeQjGIzhtcMm2qJGADp8oujNzcTO3L2ovAUZypBQzEQ6DSjYxr/udn9o4AGEyJWHlHl+9auxQu/ntXLTfyFPzv7rnHkM/wooCGm/qjWenQzJuVAqSZHT2Zo6kkaz95x/5hlPbp4TrT8PMegcQexQYOIWs6h6wAigZtjKhwKN1NVMUnPyUZqGaATZ/ngodsBYV5l6TbiDuh9M+ySegUD3uQASDE5UrUNF4YSJYnIMBkujVlLgbhCcXSzqqgzA8EDUvpkFCjM0rNFU4KzIkGafF60jlPU77eOQZr8gFgykFyFvT07HGLQ9cUe7N1F9Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUT8j6t8uYLRvzJHwgj/x3oGNsb+wjJnDHJ+kHLR7RY=;
 b=oEq7Q57GZ60xZt4ofOAyRGgc2+xVGh/xuyno71gApyMmE0lyrilNggeh1JO1wzhO2FoOnyhPqfqyuBoA/QELCb7YeFWZnUFtQw0GPBcL/ejBHDlkvkYpmGMcqGmz6brDbklOAfnM5SST64086JPFCmDgv/t1wXvj19DKWFPVVxk=
Received: from DM6PR07CA0064.namprd07.prod.outlook.com (2603:10b6:5:74::41) by
 PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Wed, 19 Apr
 2023 11:43:22 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::32) by DM6PR07CA0064.outlook.office365.com
 (2603:10b6:5:74::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22 via Frontend
 Transport; Wed, 19 Apr 2023 11:43:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.22 via Frontend Transport; Wed, 19 Apr 2023 11:43:21 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 19 Apr
 2023 06:43:19 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix style errors in amdgpu_drv.c &
 amdgpu_device.c
Date: Wed, 19 Apr 2023 17:12:49 +0530
Message-ID: <20230419114249.123333-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT050:EE_|PH8PR12MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: cd15b01c-08d4-4e2a-3fad-08db40cb471b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j4eX8s76eEWjM5fbu1HXY4BpWbV8ZMsnQvu/rXeRGguU0Q2P5OpQPb9QUvPe0hNsqpBNLXEz0mDAYMOwUKrl+ag/6gJTnZH2WEkkfjPeZJbO5QXKRy+xo9qZQGZLc8MMa0gTO5mvcvk7MbKVFYNZxLS+7NpQ6jRQBhtWWEwIrGN/Smcm1Ppu4/UrsdGes1W5faAkZ2np2UAUdULkURwIdjdLqlCGh1Zn/V4aA+x4ilqx5dUFUjpeWXTgce2JShWqntoX450oCpptuVDF9eO67SX2AlRwawAkgw2YilVgBUZCxjQivvf6l9g42s4rvqkqgnAHYF/Vm7KtYxe6dzwl38WtCqIuR1LvZE5iAuapnMTaJ9/jxOWps+RmjwJn9LUK7sNvBl3w1DKLyFtDcSQQIirSDz6JvRKz1Vmzt4ijwfxGScIro6tI4w8Hbi0X1fjbkK9Xf5tEU0uc+xrBOeDWGtKP5QiREkbdbOMjXKyysKzwEMkjlCtV3K1eYZDw0grXnXIL0fhTcWb+jzcZqJNzev5vG+ijPv9BOrzELUJSzG/3ImtDs2EagXczc1+VgkTSspuN1yq9/e7gmmwlHexRc8i+fdqlaI/8QO3168+rN6GmF6hiCds7tXvLy+dv5Ptl2wEFUKmPAc3b7KMlKzFiS3QY2rKjR696ONYCGMlIQ6OE2H9Ocws0tw6AxRpbQ9Nrni7XWGdU0xODAL8iMejXvpeAR0d+ewTXKkiHAgSh0MI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(46966006)(36840700001)(40470700004)(110136005)(40460700003)(54906003)(36756003)(86362001)(82310400005)(478600001)(81166007)(356005)(82740400003)(41300700001)(8936002)(8676002)(44832011)(5660300002)(2906002)(40480700001)(70206006)(4326008)(6636002)(316002)(70586007)(1076003)(83380400001)(26005)(16526019)(186003)(426003)(336012)(6666004)(7696005)(66574015)(47076005)(2616005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 11:43:21.7782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd15b01c-08d4-4e2a-3fad-08db40cb471b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix following checkpatch style errors in amdgpu_drv.c &
amdgpu_device.c

ERROR: exactly one space required after that #ifdef
ERROR: spaces required around that '+=' (ctx:WxV)
ERROR: space required before the open brace '{'
ERROR: spaces required around that '||' (ctx:VxE)
ERROR: space prohibited before that close parenthesis ')'
ERROR: space required before the open parenthesis '('
ERROR: space required before the open brace '{'
ERROR: code indent should use tabs where possible

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 65 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +-
 2 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3e854cd8d22e..e536886f6d42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -997,7 +997,7 @@ void amdgpu_device_program_register_sequence(struct amdgpu_device *adev,
 	if (array_size % 3)
 		return;
 
-	for (i = 0; i < array_size; i +=3) {
+	for (i = 0; i < array_size; i += 3) {
 		reg = registers[i + 0];
 		and_mask = registers[i + 1];
 		or_mask = registers[i + 2];
@@ -1546,7 +1546,7 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
 		dev_warn(adev->dev, "sched jobs (%d) must be at least 4\n",
 			 amdgpu_sched_jobs);
 		amdgpu_sched_jobs = 4;
-	} else if (!is_power_of_2(amdgpu_sched_jobs)){
+	} else if (!is_power_of_2(amdgpu_sched_jobs)) {
 		dev_warn(adev->dev, "sched jobs (%d) must be a power of 2\n",
 			 amdgpu_sched_jobs);
 		amdgpu_sched_jobs = roundup_pow_of_two(amdgpu_sched_jobs);
@@ -2758,8 +2758,9 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 		DRM_ERROR("enable mgpu fan boost failed (%d).\n", r);
 
 	/* For passthrough configuration on arcturus and aldebaran, enable special handling SBR */
-	if (amdgpu_passthrough(adev) && ((adev->asic_type == CHIP_ARCTURUS && adev->gmc.xgmi.num_physical_nodes > 1)||
-			       adev->asic_type == CHIP_ALDEBARAN ))
+	if (amdgpu_passthrough(adev) &&
+	    ((adev->asic_type == CHIP_ARCTURUS && adev->gmc.xgmi.num_physical_nodes > 1) ||
+	     adev->asic_type == CHIP_ALDEBARAN))
 		amdgpu_dpm_handle_passthrough_sbr(adev, true);
 
 	if (adev->gmc.xgmi.num_physical_nodes > 1) {
@@ -3088,7 +3089,7 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 		}
 		adev->ip_blocks[i].status.hw = false;
 		/* handle putting the SMC in the appropriate state */
-		if(!amdgpu_sriov_vf(adev)){
+		if (!amdgpu_sriov_vf(adev)) {
 			if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
 				r = amdgpu_dpm_set_mp1_state(adev, adev->mp1_state);
 				if (r) {
@@ -4035,7 +4036,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 	/* disable all interrupts */
 	amdgpu_irq_disable_all(adev);
-	if (adev->mode_info.mode_config_initialized){
+	if (adev->mode_info.mode_config_initialized) {
 		if (!drm_drv_uses_atomic_modeset(adev_to_drm(adev)))
 			drm_helper_force_disable_all(adev_to_drm(adev));
 		else
@@ -4698,42 +4699,42 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 
 int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
 {
-        u32 i;
-        int ret = 0;
+	u32 i;
+	int ret = 0;
 
-        amdgpu_atombios_scratch_regs_engine_hung(adev, true);
+	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
 
-        dev_info(adev->dev, "GPU mode1 reset\n");
+	dev_info(adev->dev, "GPU mode1 reset\n");
 
-        /* disable BM */
-        pci_clear_master(adev->pdev);
+	/* disable BM */
+	pci_clear_master(adev->pdev);
 
-        amdgpu_device_cache_pci_state(adev->pdev);
+	amdgpu_device_cache_pci_state(adev->pdev);
 
-        if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
-                dev_info(adev->dev, "GPU smu mode1 reset\n");
-                ret = amdgpu_dpm_mode1_reset(adev);
-        } else {
-                dev_info(adev->dev, "GPU psp mode1 reset\n");
-                ret = psp_gpu_reset(adev);
-        }
+	if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
+		dev_info(adev->dev, "GPU smu mode1 reset\n");
+		ret = amdgpu_dpm_mode1_reset(adev);
+	} else {
+		dev_info(adev->dev, "GPU psp mode1 reset\n");
+		ret = psp_gpu_reset(adev);
+	}
 
-        if (ret)
-                dev_err(adev->dev, "GPU mode1 reset failed\n");
+	if (ret)
+		dev_err(adev->dev, "GPU mode1 reset failed\n");
 
-        amdgpu_device_load_pci_state(adev->pdev);
+	amdgpu_device_load_pci_state(adev->pdev);
 
-        /* wait for asic to come out of reset */
-        for (i = 0; i < adev->usec_timeout; i++) {
-                u32 memsize = adev->nbio.funcs->get_memsize(adev);
+	/* wait for asic to come out of reset */
+	for (i = 0; i < adev->usec_timeout; i++) {
+		u32 memsize = adev->nbio.funcs->get_memsize(adev);
 
-                if (memsize != 0xffffffff)
-                        break;
-                udelay(1);
-        }
+		if (memsize != 0xffffffff)
+			break;
+		udelay(1);
+	}
 
-        amdgpu_atombios_scratch_regs_engine_hung(adev, false);
-        return ret;
+	amdgpu_atombios_scratch_regs_engine_hung(adev, false);
+	return ret;
 }
 
 int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 03e928123d71..ee3d241195a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1661,7 +1661,7 @@ static const u16 amdgpu_unsupported_pciidlist[] = {
 };
 
 static const struct pci_device_id pciidlist[] = {
-#ifdef  CONFIG_DRM_AMDGPU_SI
+#ifdef CONFIG_DRM_AMDGPU_SI
 	{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
 	{0x1002, 0x6784, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
 	{0x1002, 0x6788, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
-- 
2.25.1

