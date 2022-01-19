Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A49FC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 09:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B60210EA14;
	Wed, 19 Jan 2022 09:25:16 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2078.outbound.protection.outlook.com [40.107.100.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9BBB10EA03
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 09:25:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Md5WwD1r0D+4YSO8Ejy0raqIYfKLpspUy89og3aHfR9UWk/NauFjAtiKRhPrpBioKuoUcp62cpE3aG7wQ8YWa5NLeIAdlV46iOD7f7bmEgLEbAlxgw0cnDZ7cSVxS+ASYO1i2YEEv34Jvhi8/wG2Y98tM+H44m1/5CVpfFyTq0H7F723zqn/uMi8jjnXQblk1P5tVq06yJ27W4KoV05AKeVPlElmXDyUekCJGCmvRLF4Gk1Y2IRZmInZAaNPOstAu0MURc3aahJGaVkFt9z0nEyQ/OHxxmlPktyiW0/HZ50kTXnGcmSgm/GKcTTP5gi9I79covpfGSTjfOF/CFRb/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8hWabhLvoj3CQW+lJgeMvYVoU27e6waWRHnjHeQyfY=;
 b=I6lPJrRZ950qWXWsIiW9A6WPedeHlqsbW4uFOVa2etSv41Ly4Gwt+bRUtFKUZYVBZyl7ZZdc80Q1tHKWbRqd0W4Ne0CT10rwv5GSkd0szcuhFT8z0jjVoKLM5Dnw6FpiEqVgelgpgVHViUBgpRSuSB6TfqDgH8g8aVLV/jmuS7K8oG4j6d9rBzGUkqsKgzRtmo0gM3Woa3vyiilcewYyHK09yqgHVA89E9+Kf6taxyEKxVnOasqY0/ZeWhkLZvSrkuqAOAXmJSmJj92bgE6RpmJcrPmGTNaAqJy32YZ7l9m4t1FyAKCeHqAwAXgDVCjHxGUurHrjObx4WvFx+kuuRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8hWabhLvoj3CQW+lJgeMvYVoU27e6waWRHnjHeQyfY=;
 b=Zi3Y9sOpd6FEaVXuY5MrhCW3hSkcbVuM827f7AIDgCSUAZLWy4lL/W5fxJ0Z4AxUJf7UPtUU6FLVQV9aSty36nmPmTXGCwHDFJtsQ0H/xHOiwi2H0ZFrzlrLVMAEGGav61u41820leBsKAw+1cyKkgkIiYeXSOt47hidCWdn3xA=
Received: from BN0PR04CA0112.namprd04.prod.outlook.com (2603:10b6:408:ec::27)
 by CH0PR12MB5041.namprd12.prod.outlook.com (2603:10b6:610:e0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 09:25:13 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::55) by BN0PR04CA0112.outlook.office365.com
 (2603:10b6:408:ec::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Wed, 19 Jan 2022 09:25:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 09:25:12 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jan
 2022 03:25:09 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Move xgmi ras initialization from .late_init
 to early_init
Date: Wed, 19 Jan 2022 17:24:34 +0800
Message-ID: <20220119092435.287721-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9700eba6-2d03-400b-4f73-08d9db2d9887
X-MS-TrafficTypeDiagnostic: CH0PR12MB5041:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB50416AB2229FA3BE071B947BFC599@CH0PR12MB5041.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5HRfG1TpyMcQDbn46eN6pw5yHJXHfm9Gk+YCobiHxx1h6aXMhNQj3329ui2FPQ8S+I03HhLc57XWzijx7dPzRsBOIvgRj7DPljxGLIjvL1aPA65wYX5tb2U+Jc/SdqTZ/kdjHuk7oWEhuIriRViTPiWT6TdQK4Kk/DNQzyat7l24FBquj4rCG5Hxbu0S/nlTOg3Ul5VUVNcBBXL+alG4kLjkFiLXPFlZzgWtfO0acUBVopzBnPjU05wlznfnLCubWM1aDdHFaIrETc0//Zbom2C2+0a1lhiqLEDyu2ORyiJ6YGKy9x3zp9UWTIZIYm6HRcZJcPln3iN/bNDs4/PR9fY2c9ipJC3Hz98WiSvZOhFMuhKTsRBzfNMJAcucmraTVePsQwTqZM0mIBhpRAL6Mt5FMHG9kxs07O1/AtmsPUHy//3fdiySp4LSP5zyf9Uf54f2TBzlTXjti2MZunVaz1xjiCjiTW6I9BxRt14DMjYCC+WgleZoT9MOLG5fMAA77IjNVzA9T/suDSVmB0FSIJfho2gk7MXhQxxrHfRyQ5ATitaE7ODBqTpMXKV7EsHVe0PekaYXFH0hBIuUQAQ0cYjcjaI+887vZqaNvs74J/8y4IWN/AEmeD3x6vjSY4nI1jl+IUuTjeqmHbWKYtoBLP2x1LOUPrb/RhkuUBSqljazuUeI31xtPZzyHBfG5FU7U1Yb5pr/6rpvUg6KwIvc+H7cj0vsI3KOWkd64TcixxiHK0UBWEpjfeJjf5m5T1Bnw9oUSVYmn4LhvO4p9PoTlXWDmuc2YVQNU6/7eoXmYiOgwrIOwDZOku06A9PfWN5gADTadcVpskUNV5jOGcbYWvHUcV1cUyE1dQtACtvlqzY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(40460700001)(82310400004)(26005)(316002)(186003)(16526019)(7696005)(6916009)(336012)(83380400001)(426003)(2616005)(508600001)(5660300002)(81166007)(356005)(36756003)(36860700001)(4326008)(8676002)(1076003)(47076005)(8936002)(70586007)(86362001)(54906003)(2906002)(70206006)(6666004)(43062005)(142923001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 09:25:12.8182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9700eba6-2d03-400b-4f73-08d9db2d9887
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5041
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move xgmi ras initialization from .late_init to early_init, which let
xgmi ras can be initialized only once.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  5 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |  3 +++
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 22f50aadf694..ece6397f81de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2189,6 +2189,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		}
 	}
 
+	amdgpu_ras_early_init(adev);
+
 	adev->cg_flags &= amdgpu_cg_mask;
 	adev->pg_flags &= amdgpu_pg_mask;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 3483a82f5734..d83eee1984c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -452,11 +452,6 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-	if (!adev->gmc.xgmi.connected_to_cpu) {
-		adev->gmc.xgmi.ras = &xgmi_ras;
-		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_block);
-	}
-
 	if (adev->gmc.xgmi.ras && adev->gmc.xgmi.ras->ras_block.ras_late_init) {
 		r = adev->gmc.xgmi.ras->ras_block.ras_late_init(adev, NULL);
 		if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 7a1d2bac698e..2b71611be388 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2238,6 +2238,16 @@ static void amdgpu_ras_counte_dw(struct work_struct *work)
 	pm_runtime_put_autosuspend(dev->dev);
 }
 
+int amdgpu_ras_early_init(struct amdgpu_device *adev)
+{
+	if (!adev->gmc.xgmi.connected_to_cpu) {
+		adev->gmc.xgmi.ras = &xgmi_ras;
+		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_block);
+	}
+
+	return 0;
+}
+
 int amdgpu_ras_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index a51a281bd91a..7d99e3736ab9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -600,6 +600,9 @@ amdgpu_ras_error_to_ta(enum amdgpu_ras_error_type error) {
 	}
 }
 
+/* called in ip_early_init */
+int amdgpu_ras_early_init(struct amdgpu_device *adev);
+
 /* called in ip_init and ip_fini */
 int amdgpu_ras_init(struct amdgpu_device *adev);
 int amdgpu_ras_fini(struct amdgpu_device *adev);
-- 
2.25.1

