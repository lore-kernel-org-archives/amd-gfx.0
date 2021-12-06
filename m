Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DECC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:27:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 565EE73FEE;
	Mon,  6 Dec 2021 10:21:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A8017347E
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 06:35:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXuDfXj8cUXL6F5jL9T8WwWjD1H6ieePdxOXcWD4ZcFCboLfl93D2ZmRPemBp8YngoSFZhWjExcMnIWp8n45d5xO34lGyiVjWXY6hOjFgHPjX/wc7OwT8sNdXfaQpFwGRikr0WOZLAgOSOyiXXFclnHhvfh9RS2yNmarKjfCyc/terFHb7uJv2lDO95/8qGtECj19n0yEbn5NuCZ+LuuSwfZLIaH5vqN0opEWPkjJs8AqbRQEAUoX5qzfWbdcAOoQrO/+/v+dW8cSuDt7e1wDK7Fqdy7kv2O17W2kFNZ9Phogd9DYODTeISEotillfEKuxqdqcoAKWcSZx14dKwyTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Hx+jyIX1gEo3X00hrZFXLnba8OEUmygEBHyAOpgVmw=;
 b=cuSAg/eK7rem5ArUH0hmAFVgsOd95eq/PumpFM2K7m/2OC1ikBT186QuVEXVYDy+6sxWXzdtEeAdk4k6C5mbQ1rEkc8QizqKzJ0FNZ/B/VFsYdV6d/Z5rWnjCEdX7/o00SmZ4qURfUwkHXr+2a7gJqiGGvyfPumpoJr7Sf12qVyIsZU17VZ+6IxkzZ4kRBE4Xy5ORryLJKt/MsWUaKwkmZr6Lzk2LZzGAIE0XKYtP4GuSj2RWxv6V4QGREGNjNxswebsAKwM7qQDFPU/qtK6s64DKiIGknzgfKJvLTshJNacyPsuWpUAAfWaRgQGq+EDI5s/W/nUjpIWCzf9uvvOyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Hx+jyIX1gEo3X00hrZFXLnba8OEUmygEBHyAOpgVmw=;
 b=TO/zjEhjXVFcg8jqMn6uHjyTtb112quyUumPOk5XGQXQJOrHpvl8oDRB+YjfdSpuPDjz+6kwpRF/OQyuSZp7Mjy9PXNlBU2AN81MTM7krOMtQqE89peJpyFISgAOnAsXJfH/7XJZHVzzoAuIQVArVRTJ9WJNCI8j+lgW9bNi3jg=
Received: from BN8PR04CA0060.namprd04.prod.outlook.com (2603:10b6:408:d4::34)
 by BYAPR12MB2645.namprd12.prod.outlook.com (2603:10b6:a03:61::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.15; Mon, 6 Dec
 2021 06:35:13 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::cb) by BN8PR04CA0060.outlook.office365.com
 (2603:10b6:408:d4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Mon, 6 Dec 2021 06:35:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Mon, 6 Dec 2021 06:35:12 +0000
Received: from flora.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 6 Dec
 2021 00:35:04 -0600
From: Flora Cui <flora.cui@amd.com>
To: <=guchun.chen@amd.com>, <perry.yuan@amd.com>, <yuliang.shi@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: free vkms_output after use
Date: Mon, 6 Dec 2021 14:34:45 +0800
Message-ID: <20211206063445.104874-2-flora.cui@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211206063445.104874-1-flora.cui@amd.com>
References: <20211206063445.104874-1-flora.cui@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 015170f5-8f10-4f3e-b9f4-08d9b8828e88
X-MS-TrafficTypeDiagnostic: BYAPR12MB2645:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2645D35F1047624C6421F618FA6D9@BYAPR12MB2645.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: piyMnuPT39xuQhJm19LhhFntjB2cK5HCJuolUMNzXSa+yiGWEzUC6Ehjj2oHOLi+rszuvaSTN7Sg9j0kU5I41e0PVVtdjsG3l1DOeB5z2IeBIY+ln9/ASEOLr+Dwjrw/8DN4sp9j82eVJ3cSUCg/BiuxthMVnc/Ja8oVHbKPHQvnEB38Djp6ak118U0FayMLcIXxTQD530HLhY3l+wz2l7B7umGKdk0lhUiObMw+KZzf4db3EuWj/CuanF1bv+8J0oQ4BrHe1W4ScIDOb7BNLpya2Md/jk3F6cfRyirSQC6DAmWuVwU+m362yBzkiVkVudb3hhfzzYtNnOUChQs2aADnJEP+c0ATrDdG0Bwt//cZlAE3D0GUa81RF6AD5Bn8RGMFmJnlBy6UILC4TA+iGxry4xgThcCsdjccRV0z4ZOCFr2uemIaTVjGQqAR/pHBMP7HgQvTjjx/IGwv//PzBIhD9IiUMigjT80RCepHRNp/7l55dmZrMd71yfRup6Iz86iBZsw7Zo9eiuFNsjvgZ4O8MYFJcYQnPFfFKlBWmZtGYVfYs3EDd/EXFFi8Gqp4dEcK3sfL7GaogQNOIkTlYn4c8bKloKIU+FsQB9QhIYVcHsqPs9Qwo74b1+ZMIfjotDmany/Xp+aNmq5bUrpEZ06wtJyPFwscsucrRF2iAc8V/lonStDhQyq/tkNhlrz400/FTLeY3BRFi4m/DuwbDDWgWlsCJ3R5bWXBNi+tZ1JQcTb4E0ycp6lOjWxFasiWgJstDa1IzvtaVdaF4AKJg+YNdIim9IFQlsYrXVGMQwM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(7696005)(86362001)(16526019)(36860700001)(81166007)(5660300002)(6666004)(8676002)(426003)(70206006)(2906002)(1076003)(336012)(54906003)(356005)(83380400001)(36756003)(70586007)(82310400004)(4326008)(316002)(508600001)(8936002)(110136005)(47076005)(44832011)(40460700001)(186003)(2616005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 06:35:12.5907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 015170f5-8f10-4f3e-b9f4-08d9b8828e88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2645
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
Cc: Leslie Shi <Yuliang.Shi@amd.com>, Flora Cui <flora.cui@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Flora Cui <flora.cui@amd.com>
Reviewed-by: Leslie Shi <Yuliang.Shi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index acc2d31ea93f..af3a2f8c12b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -480,6 +480,11 @@ static int amdgpu_vkms_sw_init(void *handle)
 	int r, i;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	adev->amdgpu_vkms_output = kcalloc(adev->mode_info.num_crtc,
+		sizeof(struct amdgpu_vkms_output), GFP_KERNEL);
+	if (!adev->amdgpu_vkms_output)
+		return -ENOMEM;
+
 	adev_to_drm(adev)->max_vblank_count = 0;
 
 	adev_to_drm(adev)->mode_config.funcs = &amdgpu_vkms_mode_funcs;
@@ -496,10 +501,6 @@ static int amdgpu_vkms_sw_init(void *handle)
 	if (r)
 		return r;
 
-	adev->amdgpu_vkms_output = kcalloc(adev->mode_info.num_crtc, sizeof(struct amdgpu_vkms_output), GFP_KERNEL);
-	if (!adev->amdgpu_vkms_output)
-		return -ENOMEM;
-
 	/* allocate crtcs, encoders, connectors */
 	for (i = 0; i < adev->mode_info.num_crtc; i++) {
 		r = amdgpu_vkms_output_init(adev_to_drm(adev), &adev->amdgpu_vkms_output[i], i);
@@ -522,12 +523,13 @@ static int amdgpu_vkms_sw_fini(void *handle)
 		if (adev->mode_info.crtcs[i])
 			hrtimer_cancel(&adev->mode_info.crtcs[i]->vblank_timer);
 
-	kfree(adev->mode_info.bios_hardcoded_edid);
-	kfree(adev->amdgpu_vkms_output);
-
 	drm_kms_helper_poll_fini(adev_to_drm(adev));
+	drm_mode_config_cleanup(adev_to_drm(adev));
 
 	adev->mode_info.mode_config_initialized = false;
+
+	kfree(adev->mode_info.bios_hardcoded_edid);
+	kfree(adev->amdgpu_vkms_output);
 	return 0;
 }
 
-- 
2.25.1

