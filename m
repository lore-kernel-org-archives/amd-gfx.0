Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B66C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 02:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61FB661943
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 02:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FB661943
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0381E6E145;
	Wed, 12 May 2021 02:55:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 050C56E145
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 02:55:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuA08pD3fqNf9SqskCJNaTIUYvsCr/79Wwih79KAKr+QX21YnLMzUb01IyRNldj7dWycvXETsSeCQQugbGjmFTEJNPJWRAJRLY389Y/Ai/RVDuomfJThYje8tzulMl7FP5n4XRVQ2pd89VNeQdtnBQFRXWtL51XKbZVHYtdnDMR9/LDn50lvG1vypxFrBGhWvJ+KIGPRKi//FVY8G34hJ7lT0YCuVNQEzEEItViZu5eAZuIayqGJbARiNUh7h7kVSubmGC545MB2ybOvcHsbxyPpk0co/aX5njnSA0ornAdVdx7FxkMRlcC6jRyETt3U7SM1JBLs4qsGOzfBftg8Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFIW4up7GowpC+e1VSPcxcVY0p1jWquQCseM2LWIXYs=;
 b=cmyTrGnM4RF0JLPGwMZo4CzpPd5jtnt3SJ3X1ghYlcX3zsWZgMdPDoCwAlR0CfJGq7tudTHIyrf4BT6VTI2jrU8108qhMLLKeYMvi7Rh9JCXMYbK9aUiwjqImbAe1/DnxL916WPPC3Picu3rfxz20tlZFxXwyn2uVRmkP6Y+B3WK0fTBgJMYKT6eeVamA67boHvy5aBkkW7eipje3h9KSfrEeb6trcIEetHlbMEbtXrSnaB3rF8BQ6eNyGeMKh93LtP82enK16SLjx0RUxsx9d+GdggU24qS7NXOE8zBQ4PQocFp6HtB4bLLxOy+XMALcKwhDZS6HzPIrruPiAgBPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFIW4up7GowpC+e1VSPcxcVY0p1jWquQCseM2LWIXYs=;
 b=NCXGP36XzEqWb4V2ORPcROOREUX2ZzUh9gMyXbUPQ6r7Xtn52uFC9FS556LMUwYoUnPdSwv/9FcbNJw9ZGpDyWEQY1fLk2LEdjCAmueize5BnkCpsgXFfkQNbRJ5agwPmPMRoIakSZZXDkAP7Es1dm7W5MmCYwWaE1AbGtHF+Xs=
Received: from MW4PR04CA0291.namprd04.prod.outlook.com (2603:10b6:303:89::26)
 by BN8PR12MB4771.namprd12.prod.outlook.com (2603:10b6:408:a5::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 02:55:25 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::e7) by MW4PR04CA0291.outlook.office365.com
 (2603:10b6:303:89::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Wed, 12 May 2021 02:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Wed, 12 May 2021 02:55:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 11 May
 2021 21:55:23 -0500
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Tue, 11 May 2021 21:55:20 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: psp program IH_RB_CTRL on navi12 and
 sienna_cichlid
Date: Wed, 12 May 2021 10:55:01 +0800
Message-ID: <20210512025501.536547-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8034ebf6-7fb5-49d9-efce-08d914f163ef
X-MS-TrafficTypeDiagnostic: BN8PR12MB4771:
X-Microsoft-Antispam-PRVS: <BN8PR12MB4771D4C0AFE5853A81F72B2DE5529@BN8PR12MB4771.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XirCXKdAdUhmo3C6JGq6yHZooSSfeeolbMAme1IW8e3AOhpgig1sJrAYx2anErCpoLv67PoKMKVVlD7qnb2JtC/5jN15ZSVkE/mWBAKJ1vqP2x5jqGpbow0NpyybpHHBVUIFNt2/xgoKX4n+6u+B3ERnLO+kRQAEDbfY0irkN32OhLjzy6OkeUr/9kcX+/bEVv8qhMThhIzREA+5Js6Up6nk9SBlv6F9kaR6t7ESB1RvFX7ua/1uxP3QsXohsLfxuU/wYHwlFBqR/xRMQSZB2Oq+QauIpsvT5dlIDkdWgI1Aiwqp3jWqar3dWcgniSPfXPlaP675CFMUl7F0KJfKtzoR9HREFeEbK37V+yF7Dc5k5bZZuJJzKKVceQSndRVdTLfKfp6jDB6e6w2XVYBP0UHneAAUCrP/QEgnOVpL0HX/T0KExAYcuugwXSdXhhoSDyv3p/dRyoNYLGIcaqXmy45QSBAp13CApTVeRucUWqftqC8lIJ5BX2lBHAb4mzDYdvXOfMTFhGiqYsYRazaJ6YTj/YS4Mzd6V1jfip0d2JwfdYLcpZ5SxCWZOq+iu3kvUKhzaB1TgOjGPLgGHoIrOC0kawu/VxurOVTSEn22Y3djQBd45H931zBpiLFEjxRDemjhompwZP2oVNa5lX2On7QDeNpLjmdelsaseHn90muqvmbd3CXK3LiY6fhehTgL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966006)(36840700001)(83380400001)(356005)(81166007)(86362001)(1076003)(7696005)(8676002)(36756003)(478600001)(26005)(186003)(5660300002)(82740400003)(2906002)(70206006)(426003)(8936002)(54906003)(336012)(316002)(2616005)(6916009)(47076005)(4326008)(36860700001)(6666004)(70586007)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 02:55:24.4279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8034ebf6-7fb5-49d9-efce-08d914f163ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4771
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
