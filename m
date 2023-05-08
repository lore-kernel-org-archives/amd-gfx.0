Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6411DC7EE23
	for <amd-gfx@archiver.kernel.org>; Mon,  8 May 2023 10:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE47C10E1E6;
	Mon,  8 May 2023 10:19:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A35AD10E1E6
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 May 2023 10:19:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYspaVqfephaXJJ46seW0SieCuRbejjsNRZQkQ84SeKNidfq+eJeJ3RN1NoP8+lbQIx9SxJdNADDEQPQaBN1Xr49mvNulrrFDIvYa8BAkc4MLKc+NpPbMuDWJNFo0UrchpkRX0INDOXSmq2XdoEhxv/NK8DjrzIO/soZhDf4L+0xu+Oygpd8Qqd/9QHiB1xPQmi7w01GDn4/hlJ2tyKd2jUdmYGlN43oRS0x7THQwLqc13CStt4Yv4nv8xUrrfrjL9LUdliMp/hAwaRP7hzaMHPaGlkUgicgJ7xd9ezflAIAitKcxcl7xOaOPpVxmotydu5UgzYG3rhBw5ipDEorXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdZpTijIHik4FDFA287nlmGdjuhbzg9zaDup1SWyzsA=;
 b=l9fRLeZGuXnuUT36ziNIlR8+oNWtN20jRTPNDddlV3oQwPBls8LZuN0C71+FKNklyVBBw7xJk8nBViwHTOHuKCYTLu9NdypEsyoi2uTuw/KHsJSY35UwLmQrNQxVf+CNlOU0UXABlGSVcawRjS0YpCLM55Lv/xGqpPp5ad5T9Q+t7t6wWPxiCM4BuXpA3XGpEkEubMcxwAmYNoRcm8v3l202j7blR4RUJ8E8nMd47Nb0bbsE1VTUMw6IKcjqXqAVLmuu6nekMYPXwysP6Vr5OHAxYdn/t4tVRBl4ZKp++vp97WhQwCrJ05TTg12bEj6zuB2lTCkaSvE72YOtUFI33A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdZpTijIHik4FDFA287nlmGdjuhbzg9zaDup1SWyzsA=;
 b=ckkFK4vla+ACxIuY+rJ5EA1KVb3FhRL7sy2bqqmvlJtk7Nu54IDAUUFuEx5FMX1sLvawtk7mY18pW6MwKL4FIaf/ecqVYN7/XuRKOTRgpPuiAPseV7cz7Yegn4Jzp3a/mBLbjMbajWJ2L5kxeyzW78teueLhvhMrVjUQsoCOZdA=
Received: from BN9PR03CA0921.namprd03.prod.outlook.com (2603:10b6:408:107::26)
 by PH7PR12MB9104.namprd12.prod.outlook.com (2603:10b6:510:2f3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 10:19:39 +0000
Received: from BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::3d) by BN9PR03CA0921.outlook.office365.com
 (2603:10b6:408:107::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32 via Frontend
 Transport; Mon, 8 May 2023 10:19:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT092.mail.protection.outlook.com (10.13.176.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.32 via Frontend Transport; Mon, 8 May 2023 10:19:38 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 8 May
 2023 05:19:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 8 May
 2023 03:19:37 -0700
Received: from hongkzha-test-pc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via
 Frontend Transport; Mon, 8 May 2023 05:19:35 -0500
From: Horatio Zhang <Hongkun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: fix amdgpu_irq_put call trace in
 vcn_v4_0_hw_fini
Date: Mon, 8 May 2023 06:19:31 -0400
Message-ID: <20230508101931.32544-2-Hongkun.Zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230508101931.32544-1-Hongkun.Zhang@amd.com>
References: <20230508101931.32544-1-Hongkun.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT092:EE_|PH7PR12MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: a21363a8-c0ac-4661-525e-08db4fadbac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rjfFIZELO5jfbvCeB7tj/0dCoieyQ389Y3f3ESFThMBN14LhSpcqklnBubHY+liU9+ogyccNQr2+8FzUDxsLliMNwxsHHj36wKJY5zqRamgdwoInKwm1SkYWAS6axg/Gwc+DTN5sWFRFUnXnZKEvqyo6KHedAgOnirfPUEabeWliyqz2H1T6iIKFvo+KXSL+ZxJPnh78d2DxvgR7H5kAhhZ7CQI6FHWdML53AVrlmmIyQ94b3rRrTmG25O75y6ch+7gBMQ1lT1IYtYfxd2RmmIwQEDt8jrbSOSyOPb4IW3vQ7Wpf7lOGOIoNyv0EE4Bb8d8sXgA16HTDJMoOUUnn9Te3DCURsFIVK68g4KVC23ZLahOZzn9vQ2OptpMg1trbU/Y33ISKxm6F4mQWpsKRVVe78gewU+IcmFFAetZyR9/p+X0biKXtCFl47IyfHMKacLYYS24toK9kEmbLYsniQp1WhXHgkZCAzNQMunrMmEm9Kd7NTBS3JLsvrsZMYBh6bSo2a3PWjpUO2j28YhY/caGz1NLnYLU6dWp+D7l4wok/bnRjhDYS4syK0CO4EsST38jE1rLbpao44ih8beOa+LMysKucOq5pO37WokBpUJ4qu45/unZR/D/y47mcW0+fBglvSyvDBY499Z1iChYotgysrzWUuyx/pA+j/c5Tx+hAqfXbRxTWP/lhlA/EY6IWKHTy9b2FiMNW/2TdwsxPhwvG8PUzqr/BZqS/5JNySgY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(426003)(336012)(83380400001)(186003)(2616005)(36756003)(86362001)(82310400005)(82740400003)(356005)(81166007)(40480700001)(36860700001)(2906002)(47076005)(7696005)(8676002)(8936002)(41300700001)(316002)(6666004)(5660300002)(54906003)(70206006)(70586007)(6916009)(4326008)(478600001)(26005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 10:19:38.3887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a21363a8-c0ac-4661-525e-08db4fadbac3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9104
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
Cc: HaoPing.Liu@amd.com, Horatio Zhang <Hongkun.Zhang@amd.com>,
 feifei.xu@amd.com, tao.zhou1@amd.com, Sonny.Jiang@amd.com,
 Mario.Limonciello@amd.com, Leo.Liu@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

During the suspend, the vcn_v4_0_hw_init function will
use the amdgpu_irq_put to disable the irq of vcn.inst, but it
was not enabled during the resume process, which resulted in a
call trace during the GPU reset process.

[   44.563572] RIP: 0010:amdgpu_irq_put+0xa4/0xc0 [amdgpu]
[   44.563629] RSP: 0018:ffffb36740edfc90 EFLAGS: 00010246
[   44.563630] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[   44.563630] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   44.563631] RBP: ffffb36740edfcb0 R08: 0000000000000000 R09: 0000000000000000
[   44.563631] R10: 0000000000000000 R11: 0000000000000000 R12: ffff954c568e2ea8
[   44.563631] R13: 0000000000000000 R14: ffff954c568c0000 R15: ffff954c568e2ea8
[   44.563632] FS:  0000000000000000(0000) GS:ffff954f584c0000(0000) knlGS:0000000000000000
[   44.563632] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   44.563633] CR2: 00007f028741ba70 CR3: 000000026ca10000 CR4: 0000000000750ee0
[   44.563633] PKRU: 55555554
[   44.563633] Call Trace:
[   44.563634]  <TASK>
[   44.563634]  vcn_v4_0_hw_fini+0x62/0x160 [amdgpu]
[   44.563700]  vcn_v4_0_suspend+0x13/0x30 [amdgpu]
[   44.563755]  amdgpu_device_ip_suspend_phase2+0x240/0x470 [amdgpu]
[   44.563806]  amdgpu_device_ip_suspend+0x41/0x80 [amdgpu]
[   44.563858]  amdgpu_device_pre_asic_reset+0xd9/0x4a0 [amdgpu]
[   44.563909]  amdgpu_device_gpu_recover.cold+0x548/0xcf1 [amdgpu]
[   44.564006]  amdgpu_debugfs_reset_work+0x4c/0x80 [amdgpu]
[   44.564061]  process_one_work+0x21f/0x400
[   44.564062]  worker_thread+0x200/0x3f0
[   44.564063]  ? process_one_work+0x400/0x400
[   44.564064]  kthread+0xee/0x120
[   44.564065]  ? kthread_complete_and_exit+0x20/0x20
[   44.564066]  ret_from_fork+0x22/0x30

Fixes: ea5309de7388 ("drm/amdgpu: add VCN 4.0 RAS poison consumption handling")
Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index bf0674039598..b55eb1bf3e30 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -281,6 +281,21 @@ static int vcn_v4_0_hw_init(void *handle)
 	return r;
 }
 
+static int vcn_v4_0_late_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int i;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
+		amdgpu_irq_get(adev, &adev->vcn.inst[i].irq, 0);
+	}
+
+	return 0;
+}
+
 /**
  * vcn_v4_0_hw_fini - stop the hardware block
  *
@@ -2047,7 +2062,7 @@ static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev)
 static const struct amd_ip_funcs vcn_v4_0_ip_funcs = {
 	.name = "vcn_v4_0",
 	.early_init = vcn_v4_0_early_init,
-	.late_init = NULL,
+	.late_init = vcn_v4_0_late_init,
 	.sw_init = vcn_v4_0_sw_init,
 	.sw_fini = vcn_v4_0_sw_fini,
 	.hw_init = vcn_v4_0_hw_init,
-- 
2.34.1

