Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3564C77B75
	for <amd-gfx@archiver.kernel.org>; Tue, 16 May 2023 18:15:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 869C310E35B;
	Tue, 16 May 2023 18:15:50 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8867910E07B
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 May 2023 18:15:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgU4sk5UWWPb+GgPJEXsq+H3iO9ditJlQchiH4pQ5y52PMHvfXTIY2RG1YgxCtHuEStpxSguFOCSB0IplCHVHMSPS1wQefc41GKGY/ay/+LbsjYN2rqdN9/6Xp0wpKtHGsfIHJRZegNHmiYIGE8NP3WCBS5I1a/Mg1kNRzIIPztUZDD0lXo1A8ZFlH2bIjH6a5zXugfNXJ1DIDSjJkQfS32QE8DRD6Z9Ub6OY0A2XqfWM3w2mOmT313JfTne1KI/bKvzunSnB9Bsc5D1FGdVjmt5XIlPaJYfBOVUoQuHqV9l5qClXngiUNRJSJm54OeToBpWgBwA6QvJfTaxSKdqzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+Uu9hhgZmvGQSCNRLJaP8/qtP1ZLfQMiCV+x8gWRAE=;
 b=bCiTHVXx6sOBuibLgWNU8mhajXhfXuItOw9bUd8clsadh2RRlUgQlAd8HqjO7VJJOx99vGkVdvRsU+6PmgtBG8B9AbhlfZ5x315FbiE94tfAZ7TwEDYOTIH13T7U/Dx0hapVubP9HMcwW+wZSCihWRedHd/izmdIlZX5anGMsZNt+y/5TnfBK9uzItWtV75h5jfUA8tt4orYUCQXM5DxJbSx8bJb1QsqFJOXJfZPbHqL82D+/qzmzbtZgoVBpslQW5k8UiWdKE7yPO170Po31ZYAh92la0b8+LGUrkYO4bC0dw/FFjAaMFIUm0TlwrV7XWwL+c0/NbBl+RT3cadjCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+Uu9hhgZmvGQSCNRLJaP8/qtP1ZLfQMiCV+x8gWRAE=;
 b=XzwEQ2T/CXGu9ZVNADUq6GocLveE5k2IQU71JbqN7K+UEdCsPH+PbTqWJOaNF1H/R+mHAR8JKjc54bn7B8VSrlJlK8MaeRRjXRSYoAwa67lfYe0HpTXfovoKK3bttIeNA06PVNtaLkXaK/DOxAxfDr3DZ3nH/d2oqr6UqIgPYVg=
Received: from CYZPR02CA0012.namprd02.prod.outlook.com (2603:10b6:930:a1::7)
 by DS0PR12MB8344.namprd12.prod.outlook.com (2603:10b6:8:fe::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.30; Tue, 16 May 2023 18:15:43 +0000
Received: from CY4PEPF0000C979.namprd02.prod.outlook.com
 (2603:10b6:930:a1:cafe::2f) by CYZPR02CA0012.outlook.office365.com
 (2603:10b6:930:a1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 18:15:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C979.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.11 via Frontend Transport; Tue, 16 May 2023 18:15:41 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 13:15:40 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd: Poll for GFX core to be off
Date: Tue, 16 May 2023 12:52:13 -0500
Message-ID: <20230516175214.3491-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516175214.3491-1-mario.limonciello@amd.com>
References: <20230516175214.3491-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C979:EE_|DS0PR12MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: 343e7eeb-1341-43be-9a35-08db56398f0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ht64bZTCyCgPIN01sUo1ezwPlxBf+6ZQkipnWVsostbXt875Q6+7hHipsQoQtXbkIgtM6wlkrCL8UNNAIcK76qqK3OsCT5TM3c8of683Te3PFOZ9LBLIvgLsMReHHOhGNqILRrBJaI0UgcEc2XOy3bEfHKmWg1VHuEW230XhI/pkUndgP/JoaKMese8Pw3R6lIgkwQEdqRAanxFV5iBMGx0Ay1i0g20j/H9vIdUEibzh2rOI50V846E5m1bVXBmEFdPUdntuhyM0GEe9PdFlQZR7LlolIaYeSyYLd482QzJZ1653Uuaup6MkQfsJuxfAS+fchN5MHkkqUKqVZA5dHc2KmGGZnrWNR4wXMsy0yjSHF9OHXQyv9QyjiqKdcylWGpOcnTdthnlmDd/Ft0YLKYgDSOgxQ1l8VQM/LagNNEtOOfSoI0uC+nxfzirnpybapjmbRBFJRcG9dYx0Giq1UMEalgsLVibvRcGblvES27EmvUmV+U7gWeByvwjVs8LiGMKw/xN9hcBHbmxb6KaVgc0EqwCkVCGJvfEJa+v/SvfbNBSPLR68L4ODRkDrboq5P9R8soMvhkYP13g3Vn+VCIOZ8P3BPw02k6ksuGbuy0rJVmi/D7o2nb8wDyPlTOj0kbccId/5eWeNe/HaAL2AWESqO3ZJPCayArnkGV1hNkN8HP3FR4JkeLQ1lZdyaEjLJPfGz5qlZjKIDMavL2ppFUBWWuT+CMPE368IorPVpfA4agPNa6B5iamc+j7TD2t8mYafhJhRr+/0ApGa3Vmx/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(36840700001)(46966006)(40470700004)(186003)(16526019)(26005)(2616005)(47076005)(8936002)(8676002)(426003)(2906002)(82740400003)(40460700003)(40480700001)(1076003)(336012)(83380400001)(36860700001)(70586007)(70206006)(6666004)(7696005)(316002)(54906003)(4326008)(478600001)(6916009)(81166007)(41300700001)(5660300002)(36756003)(356005)(86362001)(82310400005)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 18:15:41.5343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 343e7eeb-1341-43be-9a35-08db56398f0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C979.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8344
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
Cc: anson.tsao@amd.com, Tim Huang <tim.huang@amd.com>, Juan.Martinez@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>, richard.gong@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If GFXOFF was flushed during suspend entry it may take some time
for GFX core to be powered down.  Ensure that it's powered off
before continuing any operations that may try to utilize related
IP. This avoids hangs from stopping RLC as well as problems with
fence interrupts timing out during s2idle entry and exit.

Cc: stable@vger.kernel.org # 6.1+
Tested-by: Juan Martinez <Juan.Martinez@amd.com>
Tested-by: Anson Tsao <anson.tsao@amd.com>
Suggested-by: Tim Huang <tim.huang@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 ++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/include/amd_shared.h   |  1 +
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 059139f1f973..17fc053405ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3055,12 +3055,28 @@ static void amdgpu_device_delay_enable_gfx_off(struct work_struct *work)
 {
 	struct amdgpu_device *adev =
 		container_of(work, struct amdgpu_device, gfx.gfx_off_delay_work.work);
+	int r, i;
 
 	WARN_ON_ONCE(adev->gfx.gfx_off_state);
 	WARN_ON_ONCE(adev->gfx.gfx_off_req_count);
 
-	if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, true))
-		adev->gfx.gfx_off_state = true;
+	r = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, true);
+	if (r) {
+		DRM_ERROR("failed to enable gfxoff: %d\n", r);
+		return;
+	}
+	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
+		if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_GFX)
+			continue;
+		if (!adev->ip_blocks[i].version->funcs->wait_for_off)
+			continue;
+		r = adev->ip_blocks[i].version->funcs->wait_for_off((void *)adev);
+		if (r) {
+			DRM_ERROR("failed to wait for gfxoff: %d\n", r);
+			return;
+		}
+	}
+	adev->gfx.gfx_off_state = true;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 4b7224de879e..dcbdb2641086 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4434,6 +4434,23 @@ static int gfx_v11_0_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
+
+static int gfx_v11_0_wait_for_off(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	u32 tmp;
+	int i;
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		tmp = RREG32_SOC15(GC, 0, regGFX_IMU_MSG_FLAGS);
+		if (!(tmp & 0x06))
+			return 0;
+		udelay(1);
+	}
+	dev_dbg(adev->dev, "GFX IMU is %x\n", tmp);
+	return -ETIMEDOUT;
+}
+
 static int gfx_v11_0_soft_reset(void *handle)
 {
 	u32 grbm_soft_reset = 0;
@@ -6109,6 +6126,7 @@ static const struct amd_ip_funcs gfx_v11_0_ip_funcs = {
 	.resume = gfx_v11_0_resume,
 	.is_idle = gfx_v11_0_is_idle,
 	.wait_for_idle = gfx_v11_0_wait_for_idle,
+	.wait_for_off = gfx_v11_0_wait_for_off,
 	.soft_reset = gfx_v11_0_soft_reset,
 	.check_soft_reset = gfx_v11_0_check_soft_reset,
 	.post_soft_reset = gfx_v11_0_post_soft_reset,
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index f175e65b853a..ce2e2b6fd6ff 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -298,6 +298,7 @@ struct amd_ip_funcs {
 	int (*resume)(void *handle);
 	bool (*is_idle)(void *handle);
 	int (*wait_for_idle)(void *handle);
+	int (*wait_for_off)(void *handle);
 	bool (*check_soft_reset)(void *handle);
 	int (*pre_soft_reset)(void *handle);
 	int (*soft_reset)(void *handle);
-- 
2.34.1

