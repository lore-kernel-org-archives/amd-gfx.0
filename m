Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89339C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Dec 2021 06:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2715310E442;
	Wed, 29 Dec 2021 06:33:15 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2078.outbound.protection.outlook.com [40.107.95.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99F4510E405
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Dec 2021 06:33:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eduA+MyEpb1Gr3oqKgjwj13eU7vC8WL4c45ZpNZS9JQuoEFjHbSCUSJvhtXwqq2v/rv5SfQawZay27VXQsviK6tTFTMQeQrR58JhCDST1upvpx586OOr22VZ4bA/QiVEU6HwEDXL2PG5gACsGl3w/rBy/mq7pj4THcYrJdKFJrD2YG2+Ljp739ZjyJlKgwYMPaGJCSt9abOlE3jX3+F6Mdl+l/PWVMyXp88witAAkdnS5s8YdNQhgMizYyByCh9J80PAlVisAy29A5Z2H1fnSeELE+f2i0PsxVFeIwYcxDllQ+oKFMop5aOQ7FV3Iz9DG4UblTULDjKAfZbcGBbJFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSm9WF2Eo8s9+BFEdBkRlRM8/fgQMQ8ChyoavPdfKys=;
 b=aD1cCGO5Oba0cs7TOiDVPy10UbmbKorS5WUueaQJM/UcNIqM0yfsUVkZQ10UaTwZe1N64QNbQhlKPg1l1pMkuKtf5RGkfXNheTinTFkUTwQzVUpU+CVogxvxBZnDkKDAIbe+ZINBzGJE6caAsY8+cR1qZMJ1pTHXoa8IO9Th/PshcezeLpYPPudAmMwQEGqS29dikjXNqAs6DXMINBwF9YEwnIgGpkNWms1XU9nAiaHIqwgxIWH9ebz+bHJxXt8dmjuyR64FmoalsLduwYXgWI1vy7dVfPVm77aTXkOkIyyekCgvzb2fmejLOjjFRHfKTit0YXThU8Ivu2mmG6FhnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSm9WF2Eo8s9+BFEdBkRlRM8/fgQMQ8ChyoavPdfKys=;
 b=Hsk1PYOZ48G3pHa61gXAX2Yvzh65Hnqr/sMOrLA4fRFMPrOXAF1YypAEfS8f2olINChklUOVMo1QB+KWK4Cmk1xiQWiuQXaNmMigFPuYp6q+bRTLUdnjQSYLY2vMODGPzppA6yy4QB7oUh+wsz2THIzvDV9uueNy9R3GBqomoRU=
Received: from MW2PR16CA0001.namprd16.prod.outlook.com (2603:10b6:907::14) by
 CH0PR12MB5186.namprd12.prod.outlook.com (2603:10b6:610:b9::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.13; Wed, 29 Dec 2021 06:33:11 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::e4) by MW2PR16CA0001.outlook.office365.com
 (2603:10b6:907::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13 via Frontend
 Transport; Wed, 29 Dec 2021 06:33:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4844.14 via Frontend Transport; Wed, 29 Dec 2021 06:33:10 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 29 Dec
 2021 00:33:08 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 10/12] drm/amdgpu: Modify mca block to fit for the unified
 ras block data and ops
Date: Wed, 29 Dec 2021 14:32:09 +0800
Message-ID: <20211229063211.43840-10-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211229063211.43840-1-YiPeng.Chai@amd.com>
References: <20211229063211.43840-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 196535ed-d64d-46cf-634f-08d9ca95158a
X-MS-TrafficTypeDiagnostic: CH0PR12MB5186:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5186A98AAC60D42C28954059FC449@CH0PR12MB5186.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:422;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3E4O1REov+XRbR0FjM7SMzegwKFM7bIvHvC0SvTg1n3ftBFpOq+qrmNCB9hzdpv0yRwtZwh7Xjnm4OxPcuVzy1lwDNOSfN7FxA92braknYddff2JZ2gyySqy/Sa7A1IUaxUcLSv9mBmKJAZ/acRLzCQM0D2hfiwG9mlKv+IbcH2ubRr9VXjEOcFV6YmGtwauh6SzV+88uZy4bXQXBhWu0LEyfQkHsg/7U9K1uKccAZXZvZUKaCEdMXjnjX+ji6BMq8qS6Y9ymrkRyaXyw2TRkOI9JW3NXhYofHFoSqJYaXLHIYv3dQpOMkWFqhbOxVt04x183Y84KlT0wZW9rzvowguuix1gey3U5zr/bewY8JfouVvLm1ChjakoxNKyFRpc4q1ji3zvOof5ilaQwCmvBgbLcvjZHJEihtPGcB5Rpwm4sITBGJwbcYQ8G/jtuTlADtMBRWXbh4KanlPg+Kxd3eBHnMFVymNBehqoTZMxPFgkNm4y3i2fRSF2y4rD/e1h5U7cjuf1K3JkehYhAsXQZaArtsfIq5zCD9vikX6CUzicFPT+AJZj1Q4M3rlEQG2aRpZgWwM3R7e+W836DCgJC2aW/kL5KF6jMSP9uKz21z6IoFjgc8cwPLQx4tfTbx8jVmK7zVONSy3sHp05h4ZzVIOlNIsvXZS5HAm9VA/oLROCrH7KtOV5asHvX5TJz5XZUyEvEUQiW6phRB0OHj92p8SwRERHxsKUXboU4Uo3hauL2cd81uecNwZBG8hGqR6fE90Rmr9fazSrU6Jx0eotJjmnsZUu9NjDZ8iFyhJs3X9pS8nXJsU+GLsfcoBwzHBl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(82310400004)(186003)(36860700001)(16526019)(81166007)(26005)(356005)(36756003)(83380400001)(316002)(54906003)(47076005)(86362001)(40460700001)(2906002)(70586007)(1076003)(5660300002)(70206006)(6916009)(30864003)(2616005)(336012)(4326008)(508600001)(426003)(8936002)(8676002)(7696005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2021 06:33:10.8402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 196535ed-d64d-46cf-634f-08d9ca95158a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5186
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

1.Modify mca block to fit for the unified ras block data and ops.
2.Define special .ras_block_match function for mca block to identify itself.
3.Change amdgpu_mca_ras_funcs to amdgpu_mca_ras_block(amdgpu_mca_ras had been used), and the corresponding variable name remove _funcs suffix.
4.Remove the const flag of cma ras variable so that cma ras block can be able to be inserted into amdgpu device ras block link list.
5.Invoke amdgpu_ras_register_ras_block function to register cma ras block into amdgpu device ras block link list.
6.Remove the redundant code about cma in amdgpu_ras.c after using the unified ras block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 15 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 11 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h | 14 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 29 +--------
 drivers/gpu/drm/amd/amdgpu/mca_v3_0.c   | 85 ++++++++++++++++++-------
 5 files changed, 78 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 429d89188d94..b7306724898d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -463,23 +463,20 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-	if (adev->mca.mp0.ras_funcs &&
-	    adev->mca.mp0.ras_funcs->ras_late_init) {
-		r = adev->mca.mp0.ras_funcs->ras_late_init(adev);
+	if (adev->mca.mp0.ras && adev->mca.mp0.ras->ras_block.ras_late_init) {
+		r = adev->mca.mp0.ras->ras_block.ras_late_init(adev, NULL);
 		if (r)
 			return r;
 	}
 
-	if (adev->mca.mp1.ras_funcs &&
-	    adev->mca.mp1.ras_funcs->ras_late_init) {
-		r = adev->mca.mp1.ras_funcs->ras_late_init(adev);
+	if (adev->mca.mp1.ras && adev->mca.mp1.ras->ras_block.ras_late_init) {
+		r = adev->mca.mp1.ras->ras_block.ras_late_init(adev, NULL);
 		if (r)
 			return r;
 	}
 
-	if (adev->mca.mpio.ras_funcs &&
-	    adev->mca.mpio.ras_funcs->ras_late_init) {
-		r = adev->mca.mpio.ras_funcs->ras_late_init(adev);
+	if (adev->mca.mpio.ras && adev->mca.mpio.ras->ras_block.ras_late_init) {
+		r = adev->mca.mpio.ras->ras_block.ras_late_init(adev, NULL);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index ce538f4819f9..52a60c2316a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -74,20 +74,23 @@ void amdgpu_mca_query_ras_error_count(struct amdgpu_device *adev,
 int amdgpu_mca_ras_late_init(struct amdgpu_device *adev,
 			     struct amdgpu_mca_ras *mca_dev)
 {
+	char sysfs_name[32] = {0};
 	int r;
 	struct ras_ih_if ih_info = {
 		.cb = NULL,
 	};
-	struct ras_fs_if fs_info = {
-		.sysfs_name = mca_dev->ras_funcs->sysfs_name,
+	struct ras_fs_if fs_info= {
+		.sysfs_name = sysfs_name,
 	};
 
+	snprintf(sysfs_name, sizeof(sysfs_name), "%s_err_count", mca_dev->ras->ras_block.name);
+
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
index 4ca51f623751..edba3ee292c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -897,31 +897,6 @@ static struct amdgpu_ras_block_object* amdgpu_ras_get_ras_block(struct amdgpu_de
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
@@ -969,6 +944,7 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 	case AMDGPU_RAS_BLOCK__PCIE_BIF:
 	case AMDGPU_RAS_BLOCK__XGMI_WAFL:
 	case AMDGPU_RAS_BLOCK__HDP:
+	case AMDGPU_RAS_BLOCK__MCA:
 		if (!block_obj || !block_obj->hw_ops)	{
 			dev_info(adev->dev, "%s doesn't config ras function \n",
 				get_ras_block_str(&info->head));
@@ -977,9 +953,6 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		if (block_obj->hw_ops->query_ras_error_count)
 			block_obj->hw_ops->query_ras_error_count(adev, &err_data);
 		break;
-	case AMDGPU_RAS_BLOCK__MCA:
-		amdgpu_ras_mca_query_error_status(adev, &info->head, &err_data);
-		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
index 8f7107d392af..f51092041edc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
@@ -37,7 +37,7 @@ static void mca_v3_0_mp0_query_ras_error_count(struct amdgpu_device *adev,
 				         ras_error_status);
 }
 
-static int mca_v3_0_mp0_ras_late_init(struct amdgpu_device *adev)
+static int mca_v3_0_mp0_ras_late_init(struct amdgpu_device *adev, void *ras_info)
 {
 	return amdgpu_mca_ras_late_init(adev, &adev->mca.mp0);
 }
@@ -47,14 +47,34 @@ static void mca_v3_0_mp0_ras_fini(struct amdgpu_device *adev)
 	amdgpu_mca_ras_fini(adev, &adev->mca.mp0);
 }
 
-const struct amdgpu_mca_ras_funcs mca_v3_0_mp0_ras_funcs = {
-	.ras_late_init = mca_v3_0_mp0_ras_late_init,
-	.ras_fini = mca_v3_0_mp0_ras_fini,
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
+const struct amdgpu_ras_block_hw_ops mca_v3_0_mp0_hw_ops = {
 	.query_ras_error_count = mca_v3_0_mp0_query_ras_error_count,
 	.query_ras_error_address = NULL,
-	.ras_block = AMDGPU_RAS_BLOCK__MCA,
-	.ras_sub_block = AMDGPU_RAS_MCA_BLOCK__MP0,
-	.sysfs_name = "mp0_err_count",
+};
+
+struct amdgpu_mca_ras_block mca_v3_0_mp0_ras = {
+	.ras_block = {
+		.block = AMDGPU_RAS_BLOCK__MCA,
+		.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MP0,
+		.name = "mp0",
+		.hw_ops = &mca_v3_0_mp0_hw_ops,
+		.ras_block_match = mca_v3_0_ras_block_match,
+		.ras_late_init = mca_v3_0_mp0_ras_late_init,
+		.ras_fini = mca_v3_0_mp0_ras_fini,
+	},
 };
 
 static void mca_v3_0_mp1_query_ras_error_count(struct amdgpu_device *adev,
@@ -65,7 +85,7 @@ static void mca_v3_0_mp1_query_ras_error_count(struct amdgpu_device *adev,
 				         ras_error_status);
 }
 
-static int mca_v3_0_mp1_ras_late_init(struct amdgpu_device *adev)
+static int mca_v3_0_mp1_ras_late_init(struct amdgpu_device *adev, void *ras_info)
 {
 	return amdgpu_mca_ras_late_init(adev, &adev->mca.mp1);
 }
@@ -75,14 +95,21 @@ static void mca_v3_0_mp1_ras_fini(struct amdgpu_device *adev)
 	amdgpu_mca_ras_fini(adev, &adev->mca.mp1);
 }
 
-const struct amdgpu_mca_ras_funcs mca_v3_0_mp1_ras_funcs = {
-	.ras_late_init = mca_v3_0_mp1_ras_late_init,
-	.ras_fini = mca_v3_0_mp1_ras_fini,
+const struct amdgpu_ras_block_hw_ops mca_v3_0_mp1_hw_ops = {
 	.query_ras_error_count = mca_v3_0_mp1_query_ras_error_count,
 	.query_ras_error_address = NULL,
-	.ras_block = AMDGPU_RAS_BLOCK__MCA,
-	.ras_sub_block = AMDGPU_RAS_MCA_BLOCK__MP1,
-	.sysfs_name = "mp1_err_count",
+};
+
+struct amdgpu_mca_ras_block mca_v3_0_mp1_ras = {
+	.ras_block = {
+		.block = AMDGPU_RAS_BLOCK__MCA,
+		.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MP1,
+		.name = "mp1",
+		.hw_ops = &mca_v3_0_mp1_hw_ops,
+		.ras_block_match = mca_v3_0_ras_block_match,
+		.ras_late_init = mca_v3_0_mp1_ras_late_init,
+		.ras_fini = mca_v3_0_mp1_ras_fini,
+	},
 };
 
 static void mca_v3_0_mpio_query_ras_error_count(struct amdgpu_device *adev,
@@ -93,7 +120,7 @@ static void mca_v3_0_mpio_query_ras_error_count(struct amdgpu_device *adev,
 				         ras_error_status);
 }
 
-static int mca_v3_0_mpio_ras_late_init(struct amdgpu_device *adev)
+static int mca_v3_0_mpio_ras_late_init(struct amdgpu_device *adev, void *ras_info)
 {
 	return amdgpu_mca_ras_late_init(adev, &adev->mca.mpio);
 }
@@ -103,14 +130,21 @@ static void mca_v3_0_mpio_ras_fini(struct amdgpu_device *adev)
 	amdgpu_mca_ras_fini(adev, &adev->mca.mpio);
 }
 
-const struct amdgpu_mca_ras_funcs mca_v3_0_mpio_ras_funcs = {
-	.ras_late_init = mca_v3_0_mpio_ras_late_init,
-	.ras_fini = mca_v3_0_mpio_ras_fini,
+const struct amdgpu_ras_block_hw_ops mca_v3_0_mpio_hw_ops = {
 	.query_ras_error_count = mca_v3_0_mpio_query_ras_error_count,
 	.query_ras_error_address = NULL,
-	.ras_block = AMDGPU_RAS_BLOCK__MCA,
-	.ras_sub_block = AMDGPU_RAS_MCA_BLOCK__MPIO,
-	.sysfs_name = "mpio_err_count",
+};
+
+struct amdgpu_mca_ras_block mca_v3_0_mpio_ras = {
+	.ras_block = {
+		.block = AMDGPU_RAS_BLOCK__MCA,
+		.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MPIO,
+		.name = "mpio",
+		.hw_ops = &mca_v3_0_mpio_hw_ops,
+		.ras_block_match = mca_v3_0_ras_block_match,
+		.ras_late_init = mca_v3_0_mpio_ras_late_init,
+		.ras_fini = mca_v3_0_mpio_ras_fini,
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

