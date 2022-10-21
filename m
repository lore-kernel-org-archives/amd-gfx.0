Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5907EC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 02:30:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7BBD10E0F8;
	Fri, 21 Oct 2022 02:30:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC9EB10E0F8
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 02:30:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGF+RBvXs6EFMzsUn8KniPNmKeD2Up+3oZs05xTm4Zd/xxOnEH9zRWhQ03pYt4XKD5vEO4xnb4IHmSblbdAoyZnxr280q/9CBxkdZxcg56CrYgLGZkTF9eP75ksehuI8qYB93IiMmFLm13rJ3Fc6WgrSol/9YCpy4F604hzf6o/AgqlH0/68LuNoRi4sujMEBN8ST6pAdRS+THCSabnbgok8aJcY/8UYxzt25zeUdzWsI8b7dR7LucT2kQcdXNQJjj40LowAZ7SexkdRuACeUnUtQqePrpTY91AbQX7NxXN3PHxYWBs9ppjDGE99TP9JVE9R2oZUXHrzTD/VTKWFTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8PaLL84dheS5joZZ9vzTFJs0FFYAvO0PWX6QW4Fbec=;
 b=J+lHuzvhQzC34RgC6+iJbWnmuPCxHwmsMIqt/sF88qAKLX9/33tx6nYcMBbGlbFFbTr1jWaDau5zCorpCPZ8r/C5f2xS0ZihmI5H7dUl8wAruNxaLk36sLyEZvu6myJy51PP3xnf0GOATzoQHtsMOpEKiQsaY/MGsrKvNgp77a6QRYBGB17l6fUlkA2xtd7cnlivLQPYPuYeETPF9V1JiKyw+A5PumTiU7BkY6jAjYvssgDCKeVLse17rNl8EI08S7rfBzaIzidXi+oc+nHBOn/o9fg/3WNlMNHWpgTjnA1nGDcZ88trJoMIeY0sfPlQdaJuDragrvQrSc7vsCkZ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8PaLL84dheS5joZZ9vzTFJs0FFYAvO0PWX6QW4Fbec=;
 b=U84+ZMVOBGoJ2v2MTval7WBoxf5BpafT0Dbi/8L4wSyEPzukV1kxJqN7ScLzEEhggkz23rKydZj2mnzNWyQuNvX5ShPRAuUBBDRFuLfStuE03pJ2sXJCYK5XyKFG7If8KT5M/jKkev5miA7rS4o4O36Xa8aOazbB0WzFeitbR7o=
Received: from DM5PR07CA0070.namprd07.prod.outlook.com (2603:10b6:4:ad::35) by
 SJ0PR12MB6783.namprd12.prod.outlook.com (2603:10b6:a03:44e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Fri, 21 Oct
 2022 02:30:01 +0000
Received: from DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::df) by DM5PR07CA0070.outlook.office365.com
 (2603:10b6:4:ad::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Fri, 21 Oct 2022 02:30:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT105.mail.protection.outlook.com (10.13.173.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Fri, 21 Oct 2022 02:30:01 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 21:29:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 19:29:58 -0700
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Thu, 20 Oct 2022 21:29:57 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: disallow gfxoff until GC IP blocks complete
 s2idle resume
Date: Fri, 21 Oct 2022 10:29:56 +0800
Message-ID: <20221021022956.2775675-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT105:EE_|SJ0PR12MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: ca2aeb16-f1a3-4aae-c19a-08dab30c279e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zjhknal/vAIFnOQpbF2NRnu9vYNLD0r8iQUBc8aVpGGZ7p78OzpD7sUu8yaSpIYqG+7NUcW0r4h3u2eEHL3uuKH3w33NKtFbQQ6Ml/X+4k8ep8iWzQsTQ8BpElMTb7khTMRCh/YvnqR3SJTh+5KAdjicfC9nGrY1fo6Cf8sWVM8DFDYpKhgmu+M6Hc5GO3xLZI/6BElX9O1wmMt5VwARPS+LAZg2vfwn9sVHEkf1Mjkk3i5sTyH6+GKRBSid3ZGyyuNeW5yeQ5IB4KUVOAnHQAJlTWBxKQfnuxMx8MQTRel0mgk0V+xiVpmm/G8Iyp823Z0SZ6Tlf/lnHLt44jmZZYlU4ZnfznZSKlergb0FoVojfC1iPrLPCjIdqDGkR7PRnsyc83Mh/CS12UM3CtLWfoSHP88CoBeJTrAwv9f3O4gzF/sLjFgNsQ21I5zMLhXoGK9sb21gxtLnY6WtskJQHF0PjjRFfxo4dAEud7Yfmj+SMBPX6L5BvlYDhCQ1ex57ZCZ9WJ/hQ0dv4vHniQi4BurvmuSFdQM7zjV0xCggnaEdc72Qhmqk0E11GL6JrJU4eO7bw3lfm5YEiwmB+NMuoLtbNBju2uAuWyjFcTkQOLXUxj0LR+yD9gKXkF+CtC+YKGLU2Wu3bUiNmGsQYgSEu4bE8BczKMuG802W0q7HWi+5iWKuU6JsfO08NSSHyG596+Fniif8smtJeCdjVqoSpvEVgqvfELmo2+t/tZ5M95wmcUUCv4c7kWCzWkZuDk2jLD0+OeHi8vnrok6uW8YjmJ5Ij0tuBhU5oF6UoB09rSAChxI9BIqU+AlqgX4arrsK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(36840700001)(46966006)(40470700004)(6916009)(54906003)(70206006)(5660300002)(8676002)(40460700003)(2906002)(36756003)(70586007)(36860700001)(82310400005)(86362001)(316002)(478600001)(41300700001)(8936002)(336012)(7696005)(83380400001)(1076003)(4326008)(186003)(47076005)(426003)(40480700001)(356005)(82740400003)(81166007)(26005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 02:30:01.1260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2aeb16-f1a3-4aae-c19a-08dab30c279e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 Ray.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In the S2idle suspend/resume phase the gfxoff is keeping functional so
some IP blocks will be likely to reinitialize at gfxoff entry and that
will result in failing to program GC registers.Therefore, let disallow
gfxoff until AMDGPU IPs reinitialized completely.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e0445e8cc342..1624ed15fbc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4185,6 +4185,10 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	/* Make sure IB tests flushed */
 	flush_delayed_work(&adev->delayed_init_work);
 
+	if (adev->in_s0ix) {
+		amdgpu_gfx_off_ctrl(adev, true);
+		DRM_DEBUG("will enable gfxoff for the mission mode\n");
+	}
 	if (fbcon)
 		drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)->fb_helper, false);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 4fe75dd2b329..3948dc5b1d6a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1664,6 +1664,11 @@ static int smu_resume(void *handle)
 
 	dev_info(adev->dev, "SMU is resumed successfully!\n");
 
+	if (adev->in_s0ix) {
+		amdgpu_gfx_off_ctrl(adev, false);
+		dev_dbg(adev->dev, "will disable gfxoff for re-initializing other blocks\n");
+       }
+
 	return 0;
 }
 
-- 
2.25.1

