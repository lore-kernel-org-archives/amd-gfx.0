Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5A5C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 08:43:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCD8E10E4FD;
	Mon,  7 Mar 2022 08:43:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5DC510E4F9
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 08:43:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQ7cERl6SPKZDr/HfAxaTNIuELaaXud1/Uqk0vmRVnHEBxgtBvP6OhcvhEDhyiu4t3hspHlhPMn0X0Su24JtBLapduihMS5WyBVJ/2PEDQLoIw40OkHQw4Wszb8h3UXgjBOF3rRVkye8vqBWWL0t+VzHPpBx+ozJj1OK33u7+Iy//NkYj7U1I5pGT1BNp1cKw2fWcSYw5EtyojWYMXd5zT3LHSirlu781brvNuKnkQvijJjiKh0sLp49BdxUmShnfvlZ05VjPwD9upYtgYhNSzeBbcd0iiCVibrnMVchlJ7jO/ybOZnbGbcwQACheiaQRiCI/VM4gYrlIoq3XwblvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5v+z6bWLtCw7zs5gEAmWigllqRt6vT2f8AXwDp0rZxI=;
 b=nxN3nRuhxVGYp+yUpgyP5iIMMt7wNgRnHPdP1MnRyCpoNtPgcYZ2DhRcEPW5yENJTrp9CDFr4glaW2H2cp5ixN+LXSoZL9IY9+SFKGDaLmNnIyfoMU0frJpOOBqEJHRy1vTx+4KumVI9TOSX+FojQg8YpELpUlLc2a5kqmTr+0E6ULk6E1sdJ2/lMqKKcQ1g7esOxFOrokDfRDt5u/rD/APomSMudWq1Alf67zrYyNkRbnR8nHkylqPdBIf8hP36FHK0JQd2rhpYIuYIQMHjT7EvDuNmSuYfylBOAHu/T0wlaX39KTGqVG2rijoq+QOvmKAwIBnR8gwu7307ZK8kkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5v+z6bWLtCw7zs5gEAmWigllqRt6vT2f8AXwDp0rZxI=;
 b=mAhjiZG0H07ZBZLfZkDJwOoRKapRn//7eSUoboc1/UXAM6omVfmmcznhe0g3zabAAvLeB2rTMLYZRMp+UlAm/dlN5QWgaqw1iNJQDOotPvYg6/FNtWqu+44XpYbRTtJ0mw0sYkfKZK2QYFzZZgqOmJKrl4LiBPzHmc10SIToSKU=
Received: from DM6PR02CA0151.namprd02.prod.outlook.com (2603:10b6:5:332::18)
 by BN6PR12MB1697.namprd12.prod.outlook.com (2603:10b6:404:105::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Mon, 7 Mar
 2022 08:43:32 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::95) by DM6PR02CA0151.outlook.office365.com
 (2603:10b6:5:332::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 08:43:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 08:43:31 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 02:43:28 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2] drm/amdgpu: Move common initialization operations of each
 ras block to one function
Date: Mon, 7 Mar 2022 16:42:59 +0800
Message-ID: <20220307084259.1752140-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb95fcfb-97b3-47ba-f3e8-08da00168efb
X-MS-TrafficTypeDiagnostic: BN6PR12MB1697:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1697A3B81C8F169AEEA1A32DFC089@BN6PR12MB1697.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z7jI4kdnfRIDUmHdYZpEvQPE6fZURZaCOK0AD4n9MjBgaLE3ousbsnKboMKnuOVkpe9xQbdFc6Kgw5Bk5tAWzL8uMfdS7wk+Zd30ftHLy6XVW2HvZiD8+NJ2aPZqD6edzKmf9alH+i2vLu2plz7H7DgVnQs7WpRx3g+zQjMLKcQEEqXY7qVdzeR860/98OlhhvJ9zRydTuIzYJbDuFgOB4BhbicbnovFFXk05nDFuIAIbBXaGiYYVsujEFMzJC0ljZ/VycB0ZILZSvxgZmEZ6BmxcNWMtBNVHTyV94r35yotiydgxz1sg7HM44Mm1RRGlvGjnflhb7YuEbJiyy2PoXT0PVzgkDTi+/E75HeOAttvSGjFsIVnlhCAQ54PgsVcnEnEIaeQD7HQxQNy2cvwF344jVmfEedWlUvROc/UK1LW8St6c0u8Qfr1WOJbu3SRfW8OzI6EXLQLIedHNjS0NWOa6+Wt55j0WAzpVpgEf7ee8PQHiGsyd6GVWO0sqtbQlRVuTCSQqe4YXUfnPsb8byxh6D1TUCv1ff44MZgQn7zGyXMBFqynHBhdE5dUd0HjKKjvwQyLQnZQJ0Vg7aEFnK4wtUPwSsVILYAT5jsvHIyDI03ldIpDMPU56uxCdXIWTFgl/aj8ooVZYHgVeJg1KdRFg8RbVyeQLsRTpVAbLq1L1jcDcOtwcSmdCF2YqdwAl1Oa4Cusq6n2Vyozcq/xYimoQgJBz5qFvix/721LXw8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6666004)(2616005)(8936002)(4326008)(8676002)(70206006)(508600001)(5660300002)(36756003)(83380400001)(1076003)(86362001)(70586007)(2906002)(26005)(316002)(186003)(36860700001)(7696005)(30864003)(54906003)(6916009)(16526019)(81166007)(336012)(426003)(47076005)(40460700003)(356005)(82310400004)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 08:43:31.3566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb95fcfb-97b3-47ba-f3e8-08da00168efb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1697
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

Define amdgpu_ras_sw_init function to initialize all ras blocks.

V2: Modify error debugging information.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |   2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 143 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  21 ---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  16 ---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  28 ----
 drivers/gpu/drm/amd/amdgpu/mca_v3_0.c      |   6 -
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  17 ---
 9 files changed, 148 insertions(+), 92 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6113ddc765a7..0c83eb69dad5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2402,6 +2402,12 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 		}
 	}
 
+	r = amdgpu_ras_sw_init(adev);
+	if (r) {
+		DRM_ERROR("amdgpu_ras_sw_init failed (%d).\n", r);
+		goto init_failed;
+	}
+
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_init_data_exchange(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index ab75e189bc0b..544241f357b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -440,8 +440,6 @@ int amdgpu_gmc_ras_early_init(struct amdgpu_device *adev)
 {
 	if (!adev->gmc.xgmi.connected_to_cpu) {
 		adev->gmc.xgmi.ras = &xgmi_ras;
-		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_block);
-		adev->gmc.xgmi.ras_if = &adev->gmc.xgmi.ras->ras_block.ras_comm;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index d3875618ebf5..89075ab9e82e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2299,8 +2299,6 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	case CHIP_ALDEBARAN:
 		if (!adev->gmc.xgmi.connected_to_cpu) {
 			adev->nbio.ras = &nbio_v7_4_ras;
-			amdgpu_ras_register_ras_block(adev, &adev->nbio.ras->ras_block);
-			adev->nbio.ras_if = &adev->nbio.ras->ras_block.ras_comm;
 		}
 		break;
 	default:
@@ -2533,6 +2531,147 @@ void amdgpu_ras_suspend(struct amdgpu_device *adev)
 		amdgpu_ras_disable_all_features(adev, 1);
 }
 
+int amdgpu_ras_sw_init(struct amdgpu_device *adev)
+{
+	int err = 0;
+
+	if (!amdgpu_ras_asic_supported(adev))
+		return 0;
+
+	if (adev->nbio.ras) {
+		err = amdgpu_ras_register_ras_block(adev, &adev->nbio.ras->ras_block);
+		if (err) {
+			dev_err(adev->dev, "Failed to register nbio ras block!\n");
+			return err;
+		}
+		adev->nbio.ras_if = &adev->nbio.ras->ras_block.ras_comm;
+	}
+
+	if (adev->gmc.xgmi.ras) {
+		err = amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_block);
+		if (err) {
+			dev_err(adev->dev, "Failed to register xgmi ras block!\n");
+			return err;
+		}
+		adev->gmc.xgmi.ras_if = &adev->gmc.xgmi.ras->ras_block.ras_comm;
+	}
+
+	if (adev->gfx.ras) {
+		err = amdgpu_ras_register_ras_block(adev, &adev->gfx.ras->ras_block);
+		if (err) {
+			dev_err(adev->dev, "Failed to register gfx ras block!\n");
+			return err;
+		}
+
+		strcpy(adev->gfx.ras->ras_block.ras_comm.name, "gfx");
+		adev->gfx.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__GFX;
+		adev->gfx.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
+		adev->gfx.ras_if = &adev->gfx.ras->ras_block.ras_comm;
+
+		/* If not define special ras_late_init function, use gfx default ras_late_init */
+		if (!adev->gfx.ras->ras_block.ras_late_init)
+			adev->gfx.ras->ras_block.ras_late_init = amdgpu_gfx_ras_late_init;
+
+		/* If not defined special ras_cb function, use default ras_cb */
+		if (!adev->gfx.ras->ras_block.ras_cb)
+			adev->gfx.ras->ras_block.ras_cb = amdgpu_gfx_process_ras_data_cb;
+	}
+
+	if (adev->umc.ras) {
+		err = amdgpu_ras_register_ras_block(adev, &adev->umc.ras->ras_block);
+		if (err) {
+			dev_err(adev->dev, "Failed to register umc ras block!\n");
+			return err;
+		}
+
+		strcpy(adev->umc.ras->ras_block.ras_comm.name, "umc");
+		adev->umc.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__UMC;
+		adev->umc.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
+		adev->umc.ras_if = &adev->umc.ras->ras_block.ras_comm;
+
+		/* If don't define special ras_late_init function, use default ras_late_init */
+		if (!adev->umc.ras->ras_block.ras_late_init)
+			adev->umc.ras->ras_block.ras_late_init = amdgpu_umc_ras_late_init;
+
+		/* If not defined special ras_cb function, use default ras_cb */
+		if (!adev->umc.ras->ras_block.ras_cb)
+			adev->umc.ras->ras_block.ras_cb = amdgpu_umc_process_ras_data_cb;
+	}
+
+	if (adev->mmhub.ras) {
+		err = amdgpu_ras_register_ras_block(adev, &adev->mmhub.ras->ras_block);
+		if (err) {
+			dev_err(adev->dev, "Failed to register mmhub ras block!\n");
+			return err;
+		}
+
+		strcpy(adev->mmhub.ras->ras_block.ras_comm.name, "mmhub");
+		adev->mmhub.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MMHUB;
+		adev->mmhub.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
+		adev->mmhub.ras_if = &adev->mmhub.ras->ras_block.ras_comm;
+	}
+
+	if (adev->hdp.ras) {
+		err = amdgpu_ras_register_ras_block(adev, &adev->hdp.ras->ras_block);
+		if (err) {
+			dev_err(adev->dev, "Failed to register hdp ras block!\n");
+			return err;
+		}
+
+		adev->hdp.ras_if = &adev->hdp.ras->ras_block.ras_comm;
+	}
+
+	if (adev->mca.mp0.ras) {
+		err = amdgpu_ras_register_ras_block(adev, &adev->mca.mp0.ras->ras_block);
+		if (err) {
+			dev_err(adev->dev, "Failed to register mca mp0 ras block!\n");
+			return err;
+		}
+		adev->mca.mp0.ras_if = &adev->mca.mp0.ras->ras_block.ras_comm;
+	}
+
+	if (adev->mca.mp1.ras) {
+		err = amdgpu_ras_register_ras_block(adev, &adev->mca.mp1.ras->ras_block);
+		if (err) {
+			dev_err(adev->dev, "Failed to register mca mp1 ras block!\n");
+			return err;
+		}
+		adev->mca.mp1.ras_if = &adev->mca.mp1.ras->ras_block.ras_comm;
+	}
+
+	if (adev->mca.mpio.ras) {
+		err = amdgpu_ras_register_ras_block(adev, &adev->mca.mpio.ras->ras_block);
+		if (err) {
+			dev_err(adev->dev, "Failed to register mca mpio ras block!\n");
+			return err;
+		}
+		adev->mca.mpio.ras_if = &adev->mca.mpio.ras->ras_block.ras_comm;
+	}
+
+	if (adev->sdma.ras) {
+		err = amdgpu_ras_register_ras_block(adev, &adev->sdma.ras->ras_block);
+		if (err) {
+			dev_err(adev->dev, "Failed to register sdma ras block!\n");
+			return err;
+		}
+
+		strcpy(adev->sdma.ras->ras_block.ras_comm.name, "sdma");
+		adev->sdma.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__SDMA;
+		adev->sdma.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
+		adev->sdma.ras_if = &adev->sdma.ras->ras_block.ras_comm;
+
+		/* If don't define special ras_late_init function, use default ras_late_init */
+		if (!adev->sdma.ras->ras_block.ras_late_init)
+			adev->sdma.ras->ras_block.ras_late_init = amdgpu_sdma_ras_late_init;
+
+		/* If not defined special ras_cb function, use default ras_cb */
+		if (!adev->sdma.ras->ras_block.ras_cb)
+			adev->sdma.ras->ras_block.ras_cb = amdgpu_sdma_process_ras_data_cb;
+	}
+
+	return 0;
+}
+
 int amdgpu_ras_late_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras_block_list *node, *tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 7cddaad90d6d..fc5ed6c47443 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -595,6 +595,7 @@ amdgpu_ras_error_to_ta(enum amdgpu_ras_error_type error) {
 
 /* called in ip_init and ip_fini */
 int amdgpu_ras_init(struct amdgpu_device *adev);
+int amdgpu_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_ras_late_init(struct amdgpu_device *adev);
 int amdgpu_ras_fini(struct amdgpu_device *adev);
 int amdgpu_ras_pre_fini(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 8def7f630d4c..e26fc2ae98e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2188,27 +2188,6 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 		break;
 	}
 
-	if (adev->gfx.ras) {
-		err = amdgpu_ras_register_ras_block(adev, &adev->gfx.ras->ras_block);
-		if (err) {
-			DRM_ERROR("Failed to register gfx ras block!\n");
-			return err;
-		}
-
-		strcpy(adev->gfx.ras->ras_block.ras_comm.name, "gfx");
-		adev->gfx.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__GFX;
-		adev->gfx.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
-		adev->gfx.ras_if = &adev->gfx.ras->ras_block.ras_comm;
-
-		/* If not define special ras_late_init function, use gfx default ras_late_init */
-		if (!adev->gfx.ras->ras_block.ras_late_init)
-			adev->gfx.ras->ras_block.ras_late_init = amdgpu_gfx_ras_late_init;
-
-		/* If not defined special ras_cb function, use default ras_cb */
-		if (!adev->gfx.ras->ras_block.ras_cb)
-			adev->gfx.ras->ras_block.ras_cb = amdgpu_gfx_process_ras_data_cb;
-	}
-
 	adev->gfx.config.gb_addr_config = gb_addr_config;
 
 	adev->gfx.config.gb_addr_config_fields.num_pipes = 1 <<
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index d9353bb99314..5046be86702f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -669,22 +669,6 @@ static void gmc_v10_0_set_umc_funcs(struct amdgpu_device *adev)
 	default:
 		break;
 	}
-	if (adev->umc.ras) {
-		amdgpu_ras_register_ras_block(adev, &adev->umc.ras->ras_block);
-
-		strcpy(adev->umc.ras->ras_block.ras_comm.name, "umc");
-		adev->umc.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__UMC;
-		adev->umc.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
-		adev->umc.ras_if = &adev->umc.ras->ras_block.ras_comm;
-
-		/* If don't define special ras_late_init function, use default ras_late_init */
-		if (!adev->umc.ras->ras_block.ras_late_init)
-				adev->umc.ras->ras_block.ras_late_init = amdgpu_umc_ras_late_init;
-
-		/* If not defined special ras_cb function, use default ras_cb */
-		if (!adev->umc.ras->ras_block.ras_cb)
-			adev->umc.ras->ras_block.ras_cb = amdgpu_umc_process_ras_data_cb;
-	}
 }
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 4c3483fbe613..8f6aefb9be08 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1228,23 +1228,6 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 	default:
 		break;
 	}
-
-	if (adev->umc.ras) {
-		amdgpu_ras_register_ras_block(adev, &adev->umc.ras->ras_block);
-
-		strcpy(adev->umc.ras->ras_block.ras_comm.name, "umc");
-		adev->umc.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__UMC;
-		adev->umc.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
-		adev->umc.ras_if = &adev->umc.ras->ras_block.ras_comm;
-
-		/* If don't define special ras_late_init function, use default ras_late_init */
-		if (!adev->umc.ras->ras_block.ras_late_init)
-				adev->umc.ras->ras_block.ras_late_init = amdgpu_umc_ras_late_init;
-
-		/* If not defined special ras_cb function, use default ras_cb */
-		if (!adev->umc.ras->ras_block.ras_cb)
-			adev->umc.ras->ras_block.ras_cb = amdgpu_umc_process_ras_data_cb;
-	}
 }
 
 static void gmc_v9_0_set_mmhub_funcs(struct amdgpu_device *adev)
@@ -1278,15 +1261,6 @@ static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgpu_device *adev)
 		/* mmhub ras is not available */
 		break;
 	}
-
-	if (adev->mmhub.ras) {
-		amdgpu_ras_register_ras_block(adev, &adev->mmhub.ras->ras_block);
-
-		strcpy(adev->mmhub.ras->ras_block.ras_comm.name, "mmhub");
-		adev->mmhub.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MMHUB;
-		adev->mmhub.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
-		adev->mmhub.ras_if = &adev->mmhub.ras->ras_block.ras_comm;
-	}
 }
 
 static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *adev)
@@ -1297,8 +1271,6 @@ static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 static void gmc_v9_0_set_hdp_ras_funcs(struct amdgpu_device *adev)
 {
 	adev->hdp.ras = &hdp_v4_0_ras;
-	amdgpu_ras_register_ras_block(adev, &adev->hdp.ras->ras_block);
-	adev->hdp.ras_if = &adev->hdp.ras->ras_block.ras_comm;
 }
 
 static void gmc_v9_0_set_mca_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
index d4bd7d1d2649..3d2b974f6e0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
@@ -129,12 +129,6 @@ static void mca_v3_0_init(struct amdgpu_device *adev)
 	mca->mp0.ras = &mca_v3_0_mp0_ras;
 	mca->mp1.ras = &mca_v3_0_mp1_ras;
 	mca->mpio.ras = &mca_v3_0_mpio_ras;
-	amdgpu_ras_register_ras_block(adev, &mca->mp0.ras->ras_block);
-	amdgpu_ras_register_ras_block(adev, &mca->mp1.ras->ras_block);
-	amdgpu_ras_register_ras_block(adev, &mca->mpio.ras->ras_block);
-	mca->mp0.ras_if = &mca->mp0.ras->ras_block.ras_comm;
-	mca->mp1.ras_if = &mca->mp1.ras->ras_block.ras_comm;
-	mca->mpio.ras_if = &mca->mpio.ras->ras_block.ras_comm;
 }
 
 const struct amdgpu_mca_funcs mca_v3_0_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 01b385568c14..fe61fcd22f18 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2809,23 +2809,6 @@ static void sdma_v4_0_set_ras_funcs(struct amdgpu_device *adev)
 	default:
 		break;
 	}
-
-	if (adev->sdma.ras) {
-		amdgpu_ras_register_ras_block(adev, &adev->sdma.ras->ras_block);
-
-		strcpy(adev->sdma.ras->ras_block.ras_comm.name, "sdma");
-		adev->sdma.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__SDMA;
-		adev->sdma.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
-		adev->sdma.ras_if = &adev->sdma.ras->ras_block.ras_comm;
-
-		/* If don't define special ras_late_init function, use default ras_late_init */
-		if (!adev->sdma.ras->ras_block.ras_late_init)
-			adev->sdma.ras->ras_block.ras_late_init = amdgpu_sdma_ras_late_init;
-
-		/* If not defined special ras_cb function, use default ras_cb */
-		if (!adev->sdma.ras->ras_block.ras_cb)
-			adev->sdma.ras->ras_block.ras_cb = amdgpu_sdma_process_ras_data_cb;
-	}
 }
 
 const struct amdgpu_ip_block_version sdma_v4_0_ip_block = {
-- 
2.25.1

