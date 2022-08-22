Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9E8C28D13
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Aug 2022 15:53:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E077910DE;
	Mon, 22 Aug 2022 15:53:03 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 872559566F
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 15:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJinEACBXZXmmjw3eV4/USBtUwfww+L5SeVfWujApewnSxX6CI+VjzDN2PaOMW+AsCiL+TLD4slyqVZ3TSGcuuIaKozC4foZoaNwDU7v5dXQyR2l/Ephn0VZN+JrowT3CqZd9cE4T8rPbIYhi7RAH9TUvMU8xkd9z6SSqYZgBvVZSLy2Ftz/cdh/yH2v0glBqoLMTBkTmCeYyRE0/MxzEWbD8rM8MOE2FcUYfpbVaiDAj8mv6rCETq9aionJ6P6bEEcokLjYS2atdI3AJwknMWRc6F/6GySltScx/0bhS2wHQECpZmqzWEQ02pxA7w7xLMwDBmGB0c1x8GWhK3DB5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7OhAX2/oRi7CaNLMhKjAGoSuBHTc4lpuojINfvlOxE=;
 b=TwOf9+jNrpDkJ+ZQVkfb+RDxMytY06VYhqE7zQksZ+rV92gmVtPSQvJXs2J1OAmSXsyurFA4tCjocMqEdwnBlgnxt8iI9LO9QXjb0z6HX385dM/01kNlVWvGfC/+MvOiVz+RU5hBZ4SH2MvcrOMK1pDRRXFZXXUtdp0acHXCkzC5Cq7J7IE+vJ4FOzvatOpUkfdzFEI5sMDBxRDLxkY1ZQzSnmB9lcQYvD62B+9+3zzCbV1xN9K28V9G4ypR3g1KnBeJEXmU2AcFzFQ3TbfWd6A0HTSrrmHMK2+WxQ4l5R67lSR7LS3BqwzOMnErWU8waRIj35IUJMnOFGYtvw2n/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7OhAX2/oRi7CaNLMhKjAGoSuBHTc4lpuojINfvlOxE=;
 b=h5wYsXpij/bB3nC1XUy4Np1eTj255/DectgLHmtSiSN08eLJIIuPEmcAz9EI15qEe7XldlA7r8/XgYpYGK8TAe3waD7devFAVVpeSrVd4wnL3PH6faEd5qg3zF/uV/Z+0jfOAq8+d/W0BDNHBup3XuGQ2EQU58SjQhuRGiqIBDA=
Received: from BN9PR03CA0945.namprd03.prod.outlook.com (2603:10b6:408:108::20)
 by BL0PR12MB4658.namprd12.prod.outlook.com (2603:10b6:207:32::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Mon, 22 Aug
 2022 15:52:39 +0000
Received: from BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::de) by BN9PR03CA0945.outlook.office365.com
 (2603:10b6:408:108::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21 via Frontend
 Transport; Mon, 22 Aug 2022 15:52:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT109.mail.protection.outlook.com (10.13.176.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Mon, 22 Aug 2022 15:52:39 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 10:52:33 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix page table setup on Arcturus
Date: Mon, 22 Aug 2022 11:52:17 -0400
Message-ID: <20220822155217.911506-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bb2bdab-c920-4e49-32ee-08da8456575a
X-MS-TrafficTypeDiagnostic: BL0PR12MB4658:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oSmMFCqDWxSjRumT1WhvAVm/LPKSExW1eM2aTRE34hMwo8axcAUx+EzKme+dqO/8PUmFijvtFD4KBd5f7UfUzlaKPrhlIO23K+Sf0sT47lHwon9lddRD7XIdM9RhjYeMnFof3vcLDVwNZ/lQlMvqMAc2jWiQOsjQngvHQFMVccRIRQ70IJzEuXTF5SntWy353nExcCmurWdjwu49+G7vS7p/e0RbvawEMmnu0XbehaETXBUxZEtSyOMfzl/05I+WInd3EH1U21HQHLBXxLqN+0UIEJeTjAXVV5rotpIX8GF5D0qZD+T0RKdOal8CIqE0Yv1h2PxqrVrUPVBaHxW98Z5OSW/o7P9OKZObHDHxGLHRea1D5uZaI6dXze0lw1JofjBjKtDrgLGG8VAkMhMTb4QMnVvF5tKY2fTyfnCb66B8SMNsfGNHAWJvNKEw1J663rQSGozuO6XIEMb0aK1ykRgiTZhH1nGSFPQo2Ff6FHy9AQVrrZM/ooBPlcqHPwBJ0QdKV+IpJcncP/KT4U3bi/G1AxlxFgxITIf+ASxCN9uIufC7+Z1lipXB1m1oez4CfSBJb/cCV1HBJ6a33RNgGgql4aDGox115WpfjuRFuODg/3ZHX16e83NeR1o/ceHyhg/2z5glBhBr7mOWaqd0chkj6wDlajWg7CALRiF4+EZqwpq+FnezIUPHzpSagMn+pS6xW+oBB/uODE+UboCchz5NSUIM20lGi1TgTwQi+79YF+66FbeiYIHk3L3rWQJfrauTt2UcSRyDfW/B10wasIdUt1DHbSjBxIfLEHx1dP4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(136003)(396003)(346002)(46966006)(36840700001)(40470700004)(83380400001)(36756003)(2616005)(36860700001)(16526019)(336012)(186003)(1076003)(2906002)(40460700003)(7696005)(426003)(47076005)(26005)(44832011)(82740400003)(40480700001)(8936002)(316002)(478600001)(86362001)(70586007)(6666004)(8676002)(41300700001)(356005)(82310400005)(5660300002)(70206006)(81166007)(6916009)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 15:52:39.3148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb2bdab-c920-4e49-32ee-08da8456575a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4658
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
Cc: Mukul Joshi <mukul.joshi@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When translate_further is enabled, page table depth needs to
be updated. This was missing on Arcturus MMHUB init. This was
causing address translations to fail for SDMA user-mode queues.

Fixes: 2abf2573b1c69 ("drm/amdgpu: Enable translate_further to extend UTCL2 reach"
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index 6e0145b2b408..445cb06b9d26 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -295,9 +295,17 @@ static void mmhub_v9_4_disable_identity_aperture(struct amdgpu_device *adev,
 static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	unsigned int num_level, block_size;
 	uint32_t tmp;
 	int i;
 
+	num_level = adev->vm_manager.num_level;
+	block_size = adev->vm_manager.block_size;
+	if (adev->gmc.translate_further)
+		num_level -= 1;
+	else
+		block_size -= 9;
+
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmVML2VC0_VM_CONTEXT1_CNTL,
 				hubid * MMHUB_INSTANCE_REGISTER_OFFSET + i);
@@ -305,7 +313,7 @@ static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
 				    ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
 				    PAGE_TABLE_DEPTH,
-				    adev->vm_manager.num_level);
+				    num_level);
 		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
 				    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
 		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
@@ -323,7 +331,7 @@ static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
 				    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
 		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
 				    PAGE_TABLE_BLOCK_SIZE,
-				    adev->vm_manager.block_size - 9);
+				    block_size);
 		/* Send no-retry XNACK on fault to suppress VM fault storm. */
 		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
-- 
2.35.1

