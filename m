Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FA4C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 10:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F69E615FF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 10:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F69E615FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 176156EA13;
	Tue, 11 May 2021 10:38:04 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750078.outbound.protection.outlook.com [40.107.75.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E6A56EA11
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 10:38:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QiXVcTsm1yCEOQBSs/oVn7Fm461eMfvxXf9BkicRQCM7piBNXHdejs58XaImu7oZREHr5miAhzAxH5Bh/HWUeWg0Yyfun4PbiNd4bYQOq7bkwMYfr1h5VpwJGbb+S27xO7YJ5xzcJ4FqFfV5zUbiroc17kXfxw2nsNm1Zz1nAPhEZ8RbtI15CNNm/GgvKVgBMZoW5PwhflQazYJDKYGj3T/5+iPX4s0t2bc6UQ+dj8ummpEnMucYMkKFB3fHtOpSSqYJClZDKA5XkdmULapuAGjJ9k6z/mthqjb8rYTj5lltbYbY7BdOg7wlR67vVPusN2BYZ+PHkL39ZAy+PhxiFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFIW4up7GowpC+e1VSPcxcVY0p1jWquQCseM2LWIXYs=;
 b=lQ4P/qFTfOPAZVMWLS899KPaD7gmdBJbOzHVQTtVCIsXwIumcloOyU1oPGGU6+nsRnQAeNh3PwCEZd3VjVjKttjRCqo+Rko/qWZ2q8xpxCg7601BKYQI4wWHaEomQtn0jWQNJz3ciIzo+82b1g0UE9KTBqp+PIKGCePqwHOxDvoVVgnHIl2sz0odSPE0thSpuxW9tOGsNlwnAJ7iU9AfgpiZ1X+1qV9bW6ImW3qUteQCVQ4rLarazoofveoaG1MeBvJalu4gXBjubj6aPrRtOh6wVhzFu9szfcSOMYiqW+iHMmzUxWa0uBpLfd5ZySVgSitmQZbM9HPZwbMNOe8F8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFIW4up7GowpC+e1VSPcxcVY0p1jWquQCseM2LWIXYs=;
 b=4yjk4O2uPT0i+zcv2wzoNziy7mO0P0pUk66VlX+VvEFmhPlNTn9yxcGfYelU+maozFSo1hTnX6nxDLFcVfb1lg3ZW7xApTyhrBIb3R5jxgTdQKG6mlkDfVB0X+fDZ56p+gLEFsyZQLvxqgQu0AnWkLUoC2zomGYa6dU6eSycUwg=
Received: from MW4PR03CA0014.namprd03.prod.outlook.com (2603:10b6:303:8f::19)
 by BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Tue, 11 May
 2021 10:38:00 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::8) by MW4PR03CA0014.outlook.office365.com
 (2603:10b6:303:8f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Tue, 11 May 2021 10:38:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4108.25 via Frontend Transport; Tue, 11 May 2021 10:37:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 11 May
 2021 05:37:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 11 May
 2021 05:37:58 -0500
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Tue, 11 May 2021 05:37:55 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: psp program IH_RB_CTRL on navi12 and navi21
Date: Tue, 11 May 2021 18:37:49 +0800
Message-ID: <20210511103749.524897-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 863314a1-8074-44c8-8acb-08d91468d917
X-MS-TrafficTypeDiagnostic: BY5PR12MB3764:
X-Microsoft-Antispam-PRVS: <BY5PR12MB376460BCF8EEE36CB9412506E5539@BY5PR12MB3764.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FFejAiUDKx2MdfvmOfVHEFoKaRByH1nzEGW+sEBIzNCx08IME/CN3H13hRkKKukY465bMDy41X10JY5/P/GY6ZNVeZe1GiuXMt1KuFsDBYDoilanRVxgh5Zjkrg9GOOsnqBZwKYQRhEQEhCCMEUWTtm679Cy6Ooyu/dlAJT4fktvrLqP92tnrbTbyyK2fDGXk6xMEwJwYeKo2yvHEYo/hAsM+HW7y0/1ie1yIxVoqcW31VIzPCxQ2DXcDTTnh2qkarA/xX6239wDPVbom3i8pgiT5Fg91Z+DX4IQuoSFaAGI2rB4NwEkP4rF5/e8cGpt0QQYXDIXjQlND2ZXHUkGWgo5E26mJ/hSx+ADGXIyCnJlGvaEtuCZtLbnNdmRuvJlWgal3dt5CmHuC8uA0ZWhNI8L5A+GWv5rBF5VyO2pU6pDsz7e94bJaNBUHKF8DQ3rfYW0mGUFqJddXhXwGX19BflLtkNaILUrgmTRpXqrXsNTWG0MOQaYrZu6qNODoQXzev3Ney9vT9lnpgmPocMhsTrcarGRVLCiXemZ3DoHVpIThDVOEnyKa5fI0IEh3KAb9yd/z5kyTFfw49k16vfhP1qLclgNMWyEwZwSb89/E0oZljMdLHZrGGl/9gFWKKMTjj/e9N1yURGsPnerHijoHL+mXgK6OT5zqThRR/YECfOT8jWFback5Gp1ADiJJ0Ay
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(36840700001)(46966006)(1076003)(4326008)(47076005)(186003)(81166007)(6666004)(36756003)(426003)(82310400003)(8676002)(8936002)(6916009)(83380400001)(316002)(5660300002)(2906002)(82740400003)(70586007)(36860700001)(2616005)(26005)(478600001)(356005)(70206006)(54906003)(86362001)(336012)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 10:37:59.9299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 863314a1-8074-44c8-8acb-08d91468d917
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3764
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
Cc: YuBiao Wang <YuBiao.Wang@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
IH_RB_CNTL is blocked by PSP so we need to ask psp to help config it.

[How]
Move psp ip block before ih, and use psp to program IH_RB_CNTL under sriov.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 20 ++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/nv.c        |  4 ++--
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index f4e4040bbd25..5ee923ccdeb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -151,7 +151,15 @@ static int navi10_ih_toggle_ring_interrupts(struct amdgpu_device *adev,
 	/* enable_intr field is only valid in ring0 */
 	if (ih == &adev->irq.ih)
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));
-	WREG32(ih_regs->ih_rb_cntl, tmp);
+
+	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
+			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
+			return -ETIMEDOUT;
+		}
+	} else {
+		WREG32(ih_regs->ih_rb_cntl, tmp);
+	}
 
 	if (enable) {
 		ih->enabled = true;
@@ -261,7 +269,15 @@ static int navi10_ih_enable_ring(struct amdgpu_device *adev,
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_ENABLE, 0);
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_FULL_DRAIN_ENABLE, 1);
 	}
-	WREG32(ih_regs->ih_rb_cntl, tmp);
+
+	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
+			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
+			return -ETIMEDOUT;
+		}
+	} else {
+		WREG32(ih_regs->ih_rb_cntl, tmp);
+	}
 
 	if (ih == &adev->irq.ih) {
 		/* set the ih ring 0 writeback address whether it's enabled or not */
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 75d1f9b939b2..aebd330daaca 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -742,8 +742,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 	case CHIP_NAVI12:
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
@@ -764,9 +764,9 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 	case CHIP_SIENNA_CICHLID:
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
 			amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
 		    is_support_sw_smu(adev))
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
