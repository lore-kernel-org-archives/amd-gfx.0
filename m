Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF17C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 10:54:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 179AF6FA31;
	Wed,  1 Dec 2021 10:54:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC8326FA30
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 10:54:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/YWs9XAVeIrbt+q8CSV83cqaYT3kMOHXVtJNaXEeMG3TCYFNjB+k1decEskTzh9Ws1Q6TvPNmt/CscdD8YrkNczMC985ZkWgUyQ++X9bZXHOmsCEYdAOkyFpYOLWKezbTOT/L9vKlhBAvYQ7Wye1wQSq6WELhFB+x80fD6/xvsUgVIaLfi1962kY3wg36RU178qgBMGbeBkCyeVB/kS3HuoyKFeSyoHH2msPl6pHydmmvqz1te7TRTf6SH3t3VHoXXomME90nBY3Tpx+72bNw6evC0sTKHhNSKOEIZXS3eEbO1uk/tlHbWp44sr7P0qyKX531YyaxYI6U0/syKUzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IU2QbNOffwsamDMErhutqGyyE4G5V26JFP/TQy0dRTc=;
 b=S/0zBg7BjasKdfJ1vHI0/ANFz6d31L+ooRzlNRrVDbcu4jaH/0zEDO1/Q1c3NpV4vUPc0asQL8rIU2jb3wShcdq7wmSiIm2XvW+ng8ZwY/BMeOO+AfAhHxBd8mkB/9SAdLr0PzFsBuVqhuzUrKC6np2SOFtu6ursRl61bt5nWJ2NRaIdHWPs8Ijwzwz7l8vLYZKOE0PrWASu6bteCJjUsriC0nGmaUWsPErIck6VPwfyhoi+M0bjT3Xo1+oLIlGidux9xXyH5oUHSwDxWWz+znpQd5JsdUpODVcYqyJzagNlmHOH/emz/+aSd3ivzhaGZd0b25Fw6ccY+gllt5/VOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IU2QbNOffwsamDMErhutqGyyE4G5V26JFP/TQy0dRTc=;
 b=VKmitEI7AxIAULd5pEqDb2F1GPY4zXX0i1Fa0pWJcA396E2IOEq0Cx09RaRl9trQVak8xjJ/cC712pGQNCXjWoVpwEA2dU4ljn8gdOc4fiRpoY93XTU3m/948XTKXWjD/M9RqomJgMMIfYYg5yOHi98jdXK2ITVhNkxGmptrkIw=
Received: from BN9PR03CA0095.namprd03.prod.outlook.com (2603:10b6:408:fd::10)
 by BN6PR12MB1122.namprd12.prod.outlook.com (2603:10b6:404:20::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 10:54:00 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::e3) by BN9PR03CA0095.outlook.office365.com
 (2603:10b6:408:fd::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Wed, 1 Dec 2021 10:54:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 1 Dec 2021 10:54:00 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 04:53:49 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 10/11] drm/amdgpu: Modify mca block to fit for the unified
 ras block data and ops
Date: Wed, 1 Dec 2021 18:52:49 +0800
Message-ID: <20211201105250.298525-10-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201105250.298525-1-YiPeng.Chai@amd.com>
References: <20211201105250.298525-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58d81cb9-56e7-46b8-5f23-08d9b4b8e1dc
X-MS-TrafficTypeDiagnostic: BN6PR12MB1122:
X-Microsoft-Antispam-PRVS: <BN6PR12MB11223C63CEB2B4880023EF3DFC689@BN6PR12MB1122.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a0kV0jit1TbUpt7+scfcQu9UHF2qR0txWOP8bjFiFTeZ6EfJ88HL4FI4iQIBFpgA7md9lEK2Y+oOKsW6HNSz/hUlzzmQHDIdawjsHrwvCZZ50+YRx+mBQyjP7BMb5wDTsqVjm29MIAXmi6eDRM9Lgux3ZNUlYTZH07pFhekbCmWyd2dCUfFjsVfMDB40QBKSWXYOqkKpERxGpXMNn296IqYmONtQkpzeq+/nZ4SBxEz6HYQBoFy2WesQWPMzJlK0jdJ8OK/AmqeNjLx5hMVs2qNvm7uXfkZeSb+02PnvKeYa52FOPeMafJU4NAkczbnNnqMHzu6kUCAekap0Y/xFLS6VQhShHknOQB6xQJuorRlp+SV+pqlTLfbkqT0dpq+5dtSo935o9ZlruDfBScwP2ZtA+VaPw53/S4Rni1Zw5M4MMauFYhJOmKmkdPoRP8GzYAUJ1DleGapK6MJErbwaSNWcZpglyB0EzIjXuczfVmL1mjVMKHdgOczHTI9ENA26+6DoHrjyiuavfIXcZc+3rxEXN8uC5X18baaMicdmJLDnTsMlMRXdz+nCkySbVkz5QUdFMpAobvTcXRYMG/82HwdYyDRK3rEv6vc+DF4/0tHOAr7wRPS8Sh2rRqyoVRqOs/iXjLIIdHEAANiOxIuO3Rc39AJoClseO/SKKckvaUcpPJRCddo7iaKSc33LTHjW421f6wdPFFrlVhqcMGlBaW9EzbceBWl/zaEVA91FOw5tq7CFs0rfY4391igb/jAS8sRtQNIoZijd0c1Ih5bUZWMrhYGljD5GlnZDlR5IMn3Wjy1AZ0taTLAoWAF6h69k
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(508600001)(47076005)(2616005)(6916009)(16526019)(316002)(8676002)(83380400001)(26005)(36756003)(186003)(81166007)(40460700001)(86362001)(1076003)(70206006)(426003)(5660300002)(36860700001)(70586007)(8936002)(7696005)(2906002)(54906003)(4326008)(336012)(82310400004)(356005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 10:54:00.1871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d81cb9-56e7-46b8-5f23-08d9b4b8e1dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1122
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, yipechai <YiPeng.Chai@amd.com>,
 yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1.Modify mca block to fit for the unified ras block data and ops.
2.Implement .ras_block_match function pointer for mca block to identify itself.
3.Change amdgpu_mca_ras_funcs to amdgpu_mca_ras_block(amdgpu_mca_ras had been used), and the corresponding variable name remove _funcs suffix.
4.Remove the const flag of cma ras variable so that cma ras block can be able to be insertted into amdgpu device ras block link list.
5.Invoke amdgpu_ras_register_ras_block function to register cma ras block into amdgpu device ras block link list.
6.Remove the redundant code about cma in amdgpu_ras.c after using the unified ras block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 18 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c |  6 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h | 14 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 29 +----------
 drivers/gpu/drm/amd/amdgpu/mca_v3_0.c   | 67 +++++++++++++++++++------
 5 files changed, 68 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index ead143214448..065d98cc028f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -467,23 +467,23 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-	if (adev->mca.mp0.ras_funcs &&
-	    adev->mca.mp0.ras_funcs->ras_late_init) {
-		r = adev->mca.mp0.ras_funcs->ras_late_init(adev);
+	if (adev->mca.mp0.ras && adev->mca.mp0.ras->ras_block.ops &&
+	    adev->mca.mp0.ras->ras_block.ops->ras_late_init) {
+		r = adev->mca.mp0.ras->ras_block.ops->ras_late_init(adev);
 		if (r)
 			return r;
 	}
 
-	if (adev->mca.mp1.ras_funcs &&
-	    adev->mca.mp1.ras_funcs->ras_late_init) {
-		r = adev->mca.mp1.ras_funcs->ras_late_init(adev);
+	if (adev->mca.mp1.ras && adev->mca.mp1.ras->ras_block.ops &&
+	    adev->mca.mp1.ras->ras_block.ops->ras_late_init) {
+		r = adev->mca.mp1.ras->ras_block.ops->ras_late_init(adev);
 		if (r)
 			return r;
 	}
 
-	if (adev->mca.mpio.ras_funcs &&
-	    adev->mca.mpio.ras_funcs->ras_late_init) {
-		r = adev->mca.mpio.ras_funcs->ras_late_init(adev);
+	if (adev->mca.mpio.ras && adev->mca.mpio.ras->ras_block.ops &&
+	    adev->mca.mpio.ras->ras_block.ops->ras_late_init) {
+		r = adev->mca.mpio.ras->ras_block.ops->ras_late_init(adev);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index ce538f4819f9..86dbe485a644 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -79,15 +79,15 @@ int amdgpu_mca_ras_late_init(struct amdgpu_device *adev,
 		.cb = NULL,
 	};
 	struct ras_fs_if fs_info = {
-		.sysfs_name = mca_dev->ras_funcs->sysfs_name,
+		.sysfs_name = mca_dev->ras->ras_block.name,
 	};
 
 	if (!mca_dev->ras_if) {
 		mca_dev->ras_if = kmalloc(sizeof(struct ras_common_if), GFP_KERNEL);
 		if (!mca_dev->ras_if)
 			return -ENOMEM;
-		mca_dev->ras_if->block = mca_dev->ras_funcs->ras_block;
-		mca_dev->ras_if->sub_block_index = mca_dev->ras_funcs->ras_sub_block;
+		mca_dev->ras_if->block = mca_dev->ras->ras_block.block;
+		mca_dev->ras_if->sub_block_index = mca_dev->ras->ras_block.sub_block_index;
 		mca_dev->ras_if->type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
 	}
 	ih_info.head = fs_info.head = *mca_dev->ras_if;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
index c74bc7177066..be030c4031d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
@@ -21,21 +21,13 @@
 #ifndef __AMDGPU_MCA_H__
 #define __AMDGPU_MCA_H__
 
-struct amdgpu_mca_ras_funcs {
-	int (*ras_late_init)(struct amdgpu_device *adev);
-	void (*ras_fini)(struct amdgpu_device *adev);
-	void (*query_ras_error_count)(struct amdgpu_device *adev,
-				      void *ras_error_status);
-	void (*query_ras_error_address)(struct amdgpu_device *adev,
-					void *ras_error_status);
-	uint32_t ras_block;
-	uint32_t ras_sub_block;
-	const char* sysfs_name;
+struct amdgpu_mca_ras_block {
+	struct amdgpu_ras_block_object ras_block;
 };
 
 struct amdgpu_mca_ras {
 	struct ras_common_if *ras_if;
-	const struct amdgpu_mca_ras_funcs *ras_funcs;
+	struct amdgpu_mca_ras_block *ras;
 };
 
 struct amdgpu_mca_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 6a145d0e0032..2e38bd3d3d45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -884,31 +884,6 @@ static struct amdgpu_ras_block_object* amdgpu_ras_get_ras_block(struct amdgpu_de
 	return NULL;
 }
 
-void amdgpu_ras_mca_query_error_status(struct amdgpu_device *adev,
-				       struct ras_common_if *ras_block,
-				       struct ras_err_data  *err_data)
-{
-	switch (ras_block->sub_block_index) {
-	case AMDGPU_RAS_MCA_BLOCK__MP0:
-		if (adev->mca.mp0.ras_funcs &&
-		    adev->mca.mp0.ras_funcs->query_ras_error_count)
-			adev->mca.mp0.ras_funcs->query_ras_error_count(adev, &err_data);
-		break;
-	case AMDGPU_RAS_MCA_BLOCK__MP1:
-		if (adev->mca.mp1.ras_funcs &&
-		    adev->mca.mp1.ras_funcs->query_ras_error_count)
-			adev->mca.mp1.ras_funcs->query_ras_error_count(adev, &err_data);
-		break;
-	case AMDGPU_RAS_MCA_BLOCK__MPIO:
-		if (adev->mca.mpio.ras_funcs &&
-		    adev->mca.mpio.ras_funcs->query_ras_error_count)
-			adev->mca.mpio.ras_funcs->query_ras_error_count(adev, &err_data);
-		break;
-	default:
-		break;
-	}
-}
-
 /* query/inject/cure begin */
 int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 				  struct ras_query_if *info)
@@ -956,6 +931,7 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 	case AMDGPU_RAS_BLOCK__PCIE_BIF:
 	case AMDGPU_RAS_BLOCK__XGMI_WAFL:
 	case AMDGPU_RAS_BLOCK__HDP:
+	case AMDGPU_RAS_BLOCK__MCA:
 		if (!block_obj || !block_obj->ops)	{
 			dev_info(adev->dev, "%s don't config ras function \n",
 				get_ras_block_str(&info->head));
@@ -964,9 +940,6 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		if (block_obj->ops->query_ras_error_count)
 			block_obj->ops->query_ras_error_count(adev, &err_data);
 		break;
-	case AMDGPU_RAS_BLOCK__MCA:
-		amdgpu_ras_mca_query_error_status(adev, &info->head, &err_data);
-		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
index 8f7107d392af..99edc75ed4ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
@@ -47,14 +47,34 @@ static void mca_v3_0_mp0_ras_fini(struct amdgpu_device *adev)
 	amdgpu_mca_ras_fini(adev, &adev->mca.mp0);
 }
 
-const struct amdgpu_mca_ras_funcs mca_v3_0_mp0_ras_funcs = {
+static int mca_v3_0_ras_block_match(struct amdgpu_ras_block_object* block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index)
+{
+	if(!block_obj)
+		return -EINVAL;
+
+	if( (block_obj->block == block) &&
+		(block_obj->sub_block_index == sub_block_index)) {
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+const struct amdgpu_ras_block_ops mca_v3_0_mp0_ops = {
+	.ras_block_match = mca_v3_0_ras_block_match,
 	.ras_late_init = mca_v3_0_mp0_ras_late_init,
 	.ras_fini = mca_v3_0_mp0_ras_fini,
 	.query_ras_error_count = mca_v3_0_mp0_query_ras_error_count,
 	.query_ras_error_address = NULL,
-	.ras_block = AMDGPU_RAS_BLOCK__MCA,
-	.ras_sub_block = AMDGPU_RAS_MCA_BLOCK__MP0,
-	.sysfs_name = "mp0_err_count",
+};
+
+struct amdgpu_mca_ras_block mca_v3_0_mp0_ras = {
+	.ras_block = {
+		.ops = &mca_v3_0_mp0_ops,
+		.block = AMDGPU_RAS_BLOCK__MCA,
+		.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MP0,
+		.name = "mp0_err_count",
+	},
 };
 
 static void mca_v3_0_mp1_query_ras_error_count(struct amdgpu_device *adev,
@@ -75,14 +95,21 @@ static void mca_v3_0_mp1_ras_fini(struct amdgpu_device *adev)
 	amdgpu_mca_ras_fini(adev, &adev->mca.mp1);
 }
 
-const struct amdgpu_mca_ras_funcs mca_v3_0_mp1_ras_funcs = {
+const struct amdgpu_ras_block_ops mca_v3_0_mp1_ops = {
+	.ras_block_match = mca_v3_0_ras_block_match,
 	.ras_late_init = mca_v3_0_mp1_ras_late_init,
 	.ras_fini = mca_v3_0_mp1_ras_fini,
 	.query_ras_error_count = mca_v3_0_mp1_query_ras_error_count,
 	.query_ras_error_address = NULL,
-	.ras_block = AMDGPU_RAS_BLOCK__MCA,
-	.ras_sub_block = AMDGPU_RAS_MCA_BLOCK__MP1,
-	.sysfs_name = "mp1_err_count",
+};
+
+struct amdgpu_mca_ras_block mca_v3_0_mp1_ras = {
+	.ras_block = {
+		.ops = &mca_v3_0_mp1_ops,
+		.block = AMDGPU_RAS_BLOCK__MCA,
+		.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MP1,
+		.name = "mp1_err_count",
+	},
 };
 
 static void mca_v3_0_mpio_query_ras_error_count(struct amdgpu_device *adev,
@@ -103,14 +130,21 @@ static void mca_v3_0_mpio_ras_fini(struct amdgpu_device *adev)
 	amdgpu_mca_ras_fini(adev, &adev->mca.mpio);
 }
 
-const struct amdgpu_mca_ras_funcs mca_v3_0_mpio_ras_funcs = {
+const struct amdgpu_ras_block_ops mca_v3_0_mpio_ops = {
+	.ras_block_match = mca_v3_0_ras_block_match,
 	.ras_late_init = mca_v3_0_mpio_ras_late_init,
 	.ras_fini = mca_v3_0_mpio_ras_fini,
 	.query_ras_error_count = mca_v3_0_mpio_query_ras_error_count,
 	.query_ras_error_address = NULL,
-	.ras_block = AMDGPU_RAS_BLOCK__MCA,
-	.ras_sub_block = AMDGPU_RAS_MCA_BLOCK__MPIO,
-	.sysfs_name = "mpio_err_count",
+};
+
+struct amdgpu_mca_ras_block mca_v3_0_mpio_ras = {
+	.ras_block = {
+		.ops = &mca_v3_0_mpio_ops,
+		.block = AMDGPU_RAS_BLOCK__MCA,
+		.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MPIO,
+		.name = "mpio_err_count",
+	},
 };
 
 
@@ -118,9 +152,12 @@ static void mca_v3_0_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_mca *mca = &adev->mca;
 
-	mca->mp0.ras_funcs = &mca_v3_0_mp0_ras_funcs;
-	mca->mp1.ras_funcs = &mca_v3_0_mp1_ras_funcs;
-	mca->mpio.ras_funcs = &mca_v3_0_mpio_ras_funcs;
+	mca->mp0.ras = &mca_v3_0_mp0_ras;
+	mca->mp1.ras = &mca_v3_0_mp1_ras;
+	mca->mpio.ras = &mca_v3_0_mpio_ras;
+	amdgpu_ras_register_ras_block(adev, &mca->mp0.ras->ras_block);
+	amdgpu_ras_register_ras_block(adev, &mca->mp1.ras->ras_block);
+	amdgpu_ras_register_ras_block(adev, &mca->mpio.ras->ras_block);
 }
 
 const struct amdgpu_mca_funcs mca_v3_0_funcs = {
-- 
2.25.1

