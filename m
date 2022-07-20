Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C013C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jul 2022 09:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EEDC10F9D9;
	Wed, 20 Jul 2022 09:07:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 159F810F50B
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jul 2022 09:07:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMAXjz/ITaFRMspaGeKavFlf03oz2sPgXfvDBxD/QoaJYM//GJqgBcAUJ8oChmQHA2IkgvVznD/bSFBGNnSEVRJkxUc/UiQX/ejvNm03dKQr2K/VJ+P9BQOCTi/9+1SVJ1R+LEvQx8KXoBi+PvxOI9BfNP5+AYeFwycEdnpBW/pwee/qQkTkUDRb0n39t2opGgKLNsZFMq2FLvq5p/f5mPZDRgAncCPI8+XDlqo6UqAYLpMa/b+Q0TNv5gmdnYWap+VAmobbfUNKYRrajwWXV1UEi4yg9dUuGOYxmxj0NDkxMCBvH6+lsQU4Qapblpuc8VzyGi2DcRsdUKS23pWv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGBr0wwWvlC+yLBmAttzRTrUBg3ZFXVV8ds+TFmRm2k=;
 b=jbPCBVZ01bPQOCN8Y1GB8luOvSPE58cXsr4PoZqkEWZBlhuzZxJEza4ARiEfj5JGPHd/a1Q9TjIlJb8FvPeCXGGIFDxsnbrKUXqNCOLuocM4byGzK5bK9BW7xkJ2QoODS2Utm2GmQU5Bc1MRnZisCrDl2d6CVs8haWklgTs/M35A4GVmoi6RBBUTQfX9mZ/ZhbcbtsNDCFTlexdNSPO506WplARDLL8bINDAiAbQf0EVxWLrbMib/CnaiNC3WymA9mchja0cJAjoaLLGNQYtWE5HbFouoSiym07y1OutZpyLzAyHUVVSASaetssQcr9Um6E4i9HMbe/mS4e+Yf5zRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGBr0wwWvlC+yLBmAttzRTrUBg3ZFXVV8ds+TFmRm2k=;
 b=riCk+krBEGbivtP28+HObTlZ+eQILT2VTcvmg/i2g8aQWQZNzWXb0ZvbvTeYl20ysuPJlu2lO+AkJ2T0Csl0egYHnPwvMBDzODaT6tMVi32B6JAp+Czd9IQLsPyWseHG/ucu3uhLi7lVDcZZj2c9r4XO8XQGo5ayCPpjlJqA1Rc=
Received: from DM6PR03CA0077.namprd03.prod.outlook.com (2603:10b6:5:333::10)
 by BN8PR12MB3011.namprd12.prod.outlook.com (2603:10b6:408:4a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Wed, 20 Jul
 2022 09:07:17 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::99) by DM6PR03CA0077.outlook.office365.com
 (2603:10b6:5:333::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20 via Frontend
 Transport; Wed, 20 Jul 2022 09:07:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Wed, 20 Jul 2022 09:07:16 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 20 Jul
 2022 04:07:02 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: move mes self test after drm sched re-started
Date: Wed, 20 Jul 2022 17:06:40 +0800
Message-ID: <20220720090640.47497-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220720090640.47497-1-evan.quan@amd.com>
References: <20220720090640.47497-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 614ce2ad-07b7-4bea-0d91-08da6a2f3e59
X-MS-TrafficTypeDiagnostic: BN8PR12MB3011:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jMOrYcu9HBdEPBbFSIJ1aC4m+qSonWiXlqfrpkTcgPVjP+360IoovSUBtx/4ex+TI5pmYtDEvTMkz421NJZLNzBm4Da0fii9jd8iV8zgXVYVkajMH+RYAfjjQ7SBrg2lqsN70ArrLKoWWpdv7XyoQFXOqcwT6cyvYU9DEE0iRZO4W/QZeLieZlYL8MV8cXjzWE3AFKoWKURWFs16OzjZrkYNVTB5vOvOXc2PDxLr/nznL3k6CYbCWHMnsn8+1dR9Do/0v3oaOwlBOd4/pHSgXR189ZBOqjouui/PusvwFar7F5t21cf5yusOy+88uHzKQeo0afLt6QlnpxfWA4ZWz5UiCP2+tTIoz5Nib/FkuMaA44dvuL2OOKqWA/Hzu2y9TNn09pJ1Xe2svWuKYR9KutZTFkc4RXfhGevTU9u2VPJ0QfSGZU+94S038F09WNg0gpMH7/uY9MKFIZHpVhe3+S52CqVEF+nryM9Mknge+z4YyBXU8vGXYks6xXLyqzX3qBemc3H8q6KVPmYhkuShHOMNb9/a4nhqJF2e7tS0BYcQa7xMP+bzzSINIH919JYYzl1u86eLeB/KT6xALqqIvQz4S1adhhIlNaM7BvDOHbYS/HC8JsuCiYzDQdXYrIZaVP1Luk+Yt88hmloVeVSAtzzRQXOIv6oRGRNeIjBtzXS24qrWcpfLwriUlbgp3fY3muhpLdhdzg0V/geIiKlFfIwB7+HN8ryicKg+lq5Wm8LvqkvnKUFXvQO1TwXqP6vnbwvpYbsMBhHQg6kUKcEfNRF7l0cP2cltTzuSiZnFZA1cYbYcamG9GMiQrFAfiooQOeWS0pANO8smSGN1qww44Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(396003)(136003)(39860400002)(40470700004)(46966006)(36840700001)(70586007)(70206006)(426003)(1076003)(47076005)(8676002)(4326008)(336012)(186003)(83380400001)(478600001)(36756003)(6666004)(41300700001)(26005)(16526019)(82310400005)(8936002)(7696005)(2616005)(82740400003)(5660300002)(40460700003)(44832011)(40480700001)(6916009)(2906002)(316002)(356005)(86362001)(36860700001)(81166007)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 09:07:16.7283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 614ce2ad-07b7-4bea-0d91-08da6a2f3e59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3011
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
Cc: alexander.deucher@amd.com, Jack Xiao <Jack.Xiao@amd.com>,
 Evan Quan <evan.quan@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

mes self test rely on vm mapping, move it after
drm sched re-started so that vm mapping can work
during gpu reset.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-and-tested-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ib202c04d86191ca47da90d27c2a8cf9e7c8e6732
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c     | 3 ++-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c     | 3 ++-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1b1a70a6da18..8fa3cf8e3a46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5298,6 +5298,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			drm_sched_start(&ring->sched, !tmp_adev->asic_reset_res);
 		}
 
+		if (adev->enable_mes)
+			amdgpu_mes_self_test(tmp_adev);
+
 		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job_signaled) {
 			drm_helper_resume_force_mode(adev_to_drm(tmp_adev));
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 0082e2e1e0b4..067d10073a56 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -1233,7 +1233,8 @@ static int mes_v10_0_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	amdgpu_mes_self_test(adev);
+	if (!amdgpu_in_reset(adev))
+		amdgpu_mes_self_test(adev);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 777f9268d92d..120ea294abef 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1280,7 +1280,8 @@ static int mes_v11_0_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	amdgpu_mes_self_test(adev);
+	if (!amdgpu_in_reset(adev))
+		amdgpu_mes_self_test(adev);
 
 	return 0;
 }
-- 
2.29.0

