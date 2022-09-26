Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F21C07E9D
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 20:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF4A510E7AA;
	Mon, 26 Sep 2022 20:20:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E481510E0EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 20:20:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S20fQGdHwqY60xp1ZDfoCVPg+0u1ntGE5Qiyvb4VGI63ujFPKdAuhQuu4+e+oPkUkpsmONY4+0ZKuVW9S+CfOpBJNVsfkgdgRz0yztZBSwuAyIFRgjPSc2h76gQoIVMqfWKLRebW/pvQS/E1kzSBOkHtd/xQb4zbpUA3xhfB7zoWu8NfQRMQoZrtXBi4R8NSjHvnAJ9ELvPgAKlJnPYzRi3FkD7rTQ3ye8mPlST963EzsrIngsvXS+LmaEM5zGFQCkRx22AFE8PxWZsGlT3zmjNF9U1II2iDJrAXgPHi1wj9sUNlJ8jw+c+xAOZrPj6kXHojXL9Ohi2IryCuaeQCYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJX4SVVae7xrER5dWTlWriouvf5h/fgg5H2iB6jo4zE=;
 b=gRK85Fa1qVmseyY7GKSvyn4NexYG8G8K5FZ7lVqTQx6aVEPIzUg1ZTuzsEl2yCONXKRbB7TLC1KFMCzm+54PwVINm70tbbVp9/Is17L9uA4pnx6WuINQfa8XOhsDcbGNiwc7yFXCorKHjdml+FKUBPi3FZRec7n+ZwRIdS7jZ9dUZ4XJOQfsWJsbKMrBB1RLwGpg+vTJk3136dTbr5Vcj/zAh/xyLLC/hn9G0GVT6oHFyfPxn/OYH2bXOwfBPa9oWbCkzO0ht6VpPY56N5kQuBC6mm/ucnoZVtkHELYobrAbHQprpg79FURIknpcKinroJKPB7G2J/O735j5L9ihGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJX4SVVae7xrER5dWTlWriouvf5h/fgg5H2iB6jo4zE=;
 b=i5Y9CNcilSLKBKBwmVYc8uNlwsZV3whZi9OWgWmjMwlJv1C+yVIJE5/WNE4Q8V7sdYwq5CGvRjOJOPUVNxGE9sEhkQCm/AGYFQ0mxXqdQzHeNSiTqgrKEGpK7egSUFvHscuy0piFSKGt8b36zrE9a8xvS8eBYsQ5fAom+N5640k=
Received: from DM6PR04CA0003.namprd04.prod.outlook.com (2603:10b6:5:334::8) by
 CH3PR12MB7761.namprd12.prod.outlook.com (2603:10b6:610:14e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 20:20:40 +0000
Received: from DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::65) by DM6PR04CA0003.outlook.office365.com
 (2603:10b6:5:334::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 20:20:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT099.mail.protection.outlook.com (10.13.172.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 20:20:40 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 26 Sep
 2022 15:20:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 26 Sep
 2022 13:20:24 -0700
Received: from ubuntu2004-NV21-clean.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Mon, 26 Sep 2022 15:20:24 -0500
From: Bokun Zhang <Bokun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add amdgpu suspend-resume code path under SRIOV
Date: Tue, 27 Sep 2022 04:20:24 +0800
Message-ID: <20220926202024.8216-1-Bokun.Zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT099:EE_|CH3PR12MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: f043420d-25d2-410a-adc5-08da9ffc94c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eCzYYItP2yTFJl3rgkvjQVbYCKID8Koi2NEi27afhwy3T9f4zsz7u+FQ6rvaZVrl5j41FaUUCRDgk8Qdvz4+R9ow0VyJtups2E2shHPVzo4AwKLaNBRa8BlvbW3REmqd/6tkZdVQNcPAUrnh1YCYPIUqqqfhB0+Muaoh2/RDFltwvU7QkOXuQ63XsL/giKfyvgxuNx4cPqNaeb7GdUykUClsJIOl+jEPEb4l9ZwLvFoP5wltXMPVIrYiCxoT07rmVg/jPAQUizwHTCjDcIGHAhPyi6NPqjSMc3SPotW+RvgQcUKR7fSCobzaKZn2aQ64HtGva0kaZBUTnbhFTITDVREl4sj9wPN5dNUiT/cJnCuBLFYSAfJ6+8U7fHL7bdX6nG59qK4L3iq4eN0HJUbP/t+aCzFmJ/P3KH7ncp0ae5IEE9zDetbUtIl68I/OXBrPzZWZl8gWGKsFGn/eGloAFBCwm/XKlqD4+IHwHOK8Ay6BG0T+SZF3TWMNVhlXo8K5yFKgleoHTTD/tqi6igTTuQY7DOfLxEADBNbUHOxPoUL80IcHMFHp4sn73mwxkuzzs/FRJp4s6K7Tv0WI65CE+Q4rnbsE5ACHYZfOrlzMrlLyyGg8Jur3sdLeusTYbnLtUlkmXDaRleMBF0iLQePfMLA0ixJ7gWLtd0Qg7iFBiXSdighu65d7yjA9PGHNf0+CLkp6NkTKj9XGzcZsZ7gzZHNuzPrblIlqbUZFm3tJgjjW5cFnEBwZN45zVF8jTYO25s26lYhLm3u4bE1h7q7wAdTjTpepzofsVOMGVP2gi+I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199015)(40470700004)(46966006)(36840700001)(82310400005)(36756003)(40460700003)(40480700001)(83380400001)(2616005)(336012)(426003)(1076003)(47076005)(356005)(81166007)(186003)(82740400003)(36860700001)(86362001)(70586007)(70206006)(6916009)(4326008)(8676002)(316002)(2906002)(15650500001)(8936002)(5660300002)(41300700001)(478600001)(26005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 20:20:40.1876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f043420d-25d2-410a-adc5-08da9ffc94c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7761
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
Cc: Bokun Zhang <Bokun.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- Under SRIOV, we need to send REQ_GPU_FINI to the hypervisor
  during the suspend time. Furthermore, we cannot request a
  mode 1 reset under SRIOV as VF. Therefore, we will skip it
  as it is called in suspend_noirq() function.

- In the resume code path, we need to send REQ_GPU_INIT to the
  hypervisor and also resume PSP IP block under SRIOV.

Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c   |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 27 +++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index c5fad52c649d..a5aee19ca30e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1057,6 +1057,10 @@ bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev)
 {
 	if (adev->flags & AMD_IS_APU)
 		return false;
+
+	if (amdgpu_sriov_vf(adev))
+		return false;
+
 #ifdef HAVE_PM_SUSPEND_TARGET_STATE
 	return pm_suspend_target_state != PM_SUSPEND_TO_IDLE;
 #else
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fb09dc32b4c0..c5c94ebd3d57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3176,7 +3176,8 @@ static int amdgpu_device_ip_resume_phase1(struct amdgpu_device *adev)
 			continue;
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
-		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH) {
+		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
+		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP && amdgpu_sriov_vf(adev))) {
 
 			r = adev->ip_blocks[i].version->funcs->resume(adev);
 			if (r) {
@@ -4120,12 +4121,20 @@ static void amdgpu_device_evict_resources(struct amdgpu_device *adev)
 int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
+	int r = 0;
 
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
 	adev->in_suspend = true;
 
+	if (amdgpu_sriov_vf(adev)) {
+		amdgpu_virt_fini_data_exchange(adev);
+		r = amdgpu_virt_request_full_gpu(adev, false);
+		if (r)
+			return r;
+	}
+
 	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D3))
 		DRM_WARN("smart shift update failed\n");
 
@@ -4153,6 +4162,9 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	amdgpu_device_ip_suspend_phase2(adev);
 
+	if (amdgpu_sriov_vf(adev))
+		amdgpu_virt_release_full_gpu(adev, false);
+
 	return 0;
 }
 
@@ -4171,6 +4183,12 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	int r = 0;
 
+	if (amdgpu_sriov_vf(adev)) {
+		r = amdgpu_virt_request_full_gpu(adev, true);
+		if (r)
+			return r;
+	}
+
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
@@ -4185,6 +4203,13 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	}
 
 	r = amdgpu_device_ip_resume(adev);
+
+	/* no matter what r is, always need to properly release full GPU */
+	if (amdgpu_sriov_vf(adev)) {
+		amdgpu_virt_init_data_exchange(adev);
+		amdgpu_virt_release_full_gpu(adev, true);
+	}
+
 	if (r) {
 		dev_err(adev->dev, "amdgpu_device_ip_resume failed (%d).\n", r);
 		return r;
-- 
2.25.1

