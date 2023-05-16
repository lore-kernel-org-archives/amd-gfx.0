Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC132C77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 04:14:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 388BA10E397;
	Wed, 17 May 2023 04:14:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4A1110E398
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 04:14:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPLxtPN05r/O+82uxFCAJ1Xt2fTnh8GZtAs9yV+AwCdKGMenjCQLHlL23bp+fLGmDe0OqnJW9fuaayuRhyrZfffejS85PV2jePI1OpYAeNK09K5LhD5LWWVQGZ06PYi/9gpKawHW9AsgBy4JA2hiut+6XCBbtjYNEFrR4Nz/Lqr7wp4wjgh6Qx4eJVWMtlbP1/N/GuDh5Wv3rnFZuuvtVBJLZngfleix5Ve1QP0JwceIrN1sQZY4lX4vdlBftspk13GMkr1u2hPqF3oUTT7OLCe+PKEoGP7TNqfzmhbfL/qi2jBkyQ1NN6MCHTWHbyi3aZc74r1TQVUj36MB3gzLSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlzm8iuFeTGRWQ0+0+/e2ua53liMTuFyFTfAysYdBBs=;
 b=J2uXvM3QdQIHEuAPnuUQqNVRkeOVJnly7qozMWQdKUhB+C3pWzTKegsb2TEDqOLGHFDaBf/zhTKw7H6+8w6RD5HF9mvoBM4oTXM6088a0mLEi/RIv8WASKzFh8vgL26EUCGEK0FwThdXB98d0z66Ix60Cn9jCTlcC1lch7YFTlK5/YK/lV2v1vZoiKm5SGK7YLXIUd1KW00/Vc1MPZgG/gUS3h/0oGYrS0B8DSIgqOK6cjKfWf/lafg76oeyjiVjE8z+U0F2+FqYEyRBjd4hxzuHsFmDYA19SyEGmqty0lnUshV6PrsMpyq+LbkL6LfiHUsRHmPkRo7SkdiTEV2Vgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlzm8iuFeTGRWQ0+0+/e2ua53liMTuFyFTfAysYdBBs=;
 b=V2S1nJRtmCIV3/l0j+u3MIAyyf28Zl2I/xnlSuXdYTVSUwJ/FT9dI9elhFCWbpeONnZLsfEG69v7Xnfq35iQLpmzXj4rcmHEosaZBYzLOemf7cpPT+RGkCDa/2gBGVvsttBHl+OTwKg+LF1OxoHoy2UiCq1QbGoAfnw+USBHTGE=
Received: from BN1PR12CA0022.namprd12.prod.outlook.com (2603:10b6:408:e1::27)
 by BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 04:14:47 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::7e) by BN1PR12CA0022.outlook.office365.com
 (2603:10b6:408:e1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34 via Frontend
 Transport; Wed, 17 May 2023 04:14:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.17 via Frontend Transport; Wed, 17 May 2023 04:14:47 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 23:14:46 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/3] drm/amd: Poll for GFX core to be off
Date: Tue, 16 May 2023 18:34:19 -0500
Message-ID: <20230516233420.2087-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516233420.2087-1-mario.limonciello@amd.com>
References: <20230516233420.2087-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT059:EE_|BL1PR12MB5254:EE_
X-MS-Office365-Filtering-Correlation-Id: ec6bdc07-87fa-4846-d3c6-08db568d407b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: //owIMtn7ZjUaYT8widTHVwRFHIHuFQRNc59VYrYLDZCKC5uB2snP0bhumPWm5gwg50frjLeO/flAmf36J2IvgPpBZmdfP9xq/xWB+enRY0wcV1mycy7BTn73bxNoj5IfQuOtx42iBdKZp+w+gQH+/Bx0tyFRoQt94svJYycvraiSiC/LKf/IelKQkqTRdCDzCFXcMDXMutnTxsR217URDluiC6+oBCjiM1uDKeqpqCgZKjY7mVc3kFsxznmpNFOkhUtxlKtF7Ith9QJTDLvijpuHXrcJx/PMEaITmMsy8zUA70xf5zazT4YbVpVqQ6UGPtTjiroRm3RQCkyuMiUrQn42pNmwOmvoTsR4y882NqcntJ6I4ARCEPYgu2AKJSUpIhY2gMHfuHFqz6z+fEnLOoAzsbNlMpYP8f3IMgGTgMKcsg9QMwXq++a8ai61a+JAfeItBscA/0wVtRItGFUGgolzAN1qJKVYzpkIH34cmxhM0STq477X8K1gI1+s3qAX+lQNs0T7reDUhoPY1rBMdVvX058yP2qF8uZEDZGfqRVRFraJSLO62KNfAgIcHdIuH020+kag60Mm/43Hj31l7wUypocpPbfiubliMnhdBBBtf6jZnYsEZr1+LoBZL1fyKAjk3CCEhCnE/DVIFOO74iYeowQiHFqBt5cKivPnW5+6TD1PIdSWQ8eyydUmnWamC/73CnXVM06bQVEJPiS44DtuRyzZuFh/qv0ipbVIwz01eTTlHZVF/TJ9/KPMPm4MVpR86VlUMW0aVVIvYYPXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(40470700004)(46966006)(36840700001)(83380400001)(36860700001)(47076005)(336012)(16526019)(478600001)(54906003)(6666004)(2616005)(7696005)(26005)(1076003)(186003)(40460700003)(426003)(82310400005)(2906002)(44832011)(36756003)(4326008)(70206006)(6916009)(81166007)(70586007)(356005)(86362001)(82740400003)(41300700001)(8936002)(40480700001)(8676002)(5660300002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 04:14:47.4822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6bdc07-87fa-4846-d3c6-08db568d407b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5254
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

Cc: stable@vger.kernel.org # 6.1
Suggested-by: Tim Huang <tim.huang@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Only poll in the s0ix case not all GFXOFF cases
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 18 ++++++++++++++++
 drivers/gpu/drm/amd/include/amd_shared.h   |  1 +
 3 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 059139f1f973..59d5fc65276c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3063,6 +3063,26 @@ static void amdgpu_device_delay_enable_gfx_off(struct work_struct *work)
 		adev->gfx.gfx_off_state = true;
 }
 
+static int amdgpu_device_ensure_gfx_off(struct amdgpu_device *adev)
+{
+	int i, r;
+
+	if (!adev->in_s0ix)
+		return 0;
+
+	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
+		if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_GFX)
+			continue;
+		if (!adev->ip_blocks[i].version->funcs->wait_for_off)
+			continue;
+		r = adev->ip_blocks[i].version->funcs->wait_for_off((void *)adev);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
 /**
  * amdgpu_device_ip_suspend_phase1 - run suspend for hardware IPs (phase 1)
  *
@@ -4318,6 +4338,10 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	cancel_delayed_work_sync(&adev->delayed_init_work);
 	flush_delayed_work(&adev->gfx.gfx_off_delay_work);
 
+	r = amdgpu_device_ensure_gfx_off(adev);
+	if (r)
+		return r;
+
 	amdgpu_ras_suspend(adev);
 
 	amdgpu_device_ip_suspend_phase1(adev);
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

