Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D411FC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Feb 2022 05:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A63910E1C0;
	Wed,  9 Feb 2022 05:58:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C6810E17E
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Feb 2022 05:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5N73QvfEEV+hhwJIHXNbmJ4/d74FLMj2xSElSDJFh7TdND+DL/UVzD0seJQmSEXoD3uPD9SvqB45aHd1Brn7RqF79wyqeUQYGZQ7Rl62kmDTLEbMOg0YBJX0N83+Lbu+efSgECB8iF2eVNWevq7AqOQwEWmd1kXyOn8Clf03MeFZV+hKhvhA3I8Wwc9FudaEPNySPeGDsAcxWUBq28r2tVn6kWtEuzrD08pytq9cOljYpfRoukyy+hkD+oJVNqFUsEIpPZ4TGsm0qTCSjI8LsIbus/+gR0kNekTwUg+ZoLl4vVtjMhzengzGRu0ep7EpBT+ojF6zKTkk2rw+5aX8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQI5TEsz8mkDh/ObqB418Xscz8xMxnvtyfIl/lsZxEw=;
 b=Sp/gpVwiq3c9XRt+PiejPCjsjJIP9aAmWSKVRJwVaA2s8u5+yRuz8AcXBSXfOF8O3VsmqrBDJQQxXyTP+OIB46z/pExT1nj5ovsydg0t1RVkiKq8cGMy7ZG2J30SF0+D08TN/ZjoYWlkB0ozQCQGPGMKBLpTwZ2+5WUwIfasoj2dZPiGlyHgbfvSEf7HUMDku6ZpnJMAZzil+r21OL80YqdPn6pdLKsHvyyUy0uAcxbI5I/OwCYxNvtQjmBRnKpgNrpcXkzTENUjS9/fidsXF0vdE6qR+cn2ygT/VYS4dEEPzwGXlBPNGcDLuAUVko+t1hRk9A+9xmMBpSaHDMalHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQI5TEsz8mkDh/ObqB418Xscz8xMxnvtyfIl/lsZxEw=;
 b=zOk/o7pndna2qRMuBWCPQM3UWy/XKjSiv0FhylZD7bp8SAz1IV2OJhkaElP1CAnm6QpLuOd2JnB3QhyGuE3cOsNDvNISZovIvfcKIKpvorbdiMR5wRS4zjgVn5NQU1hdeq+0x9zuRtLoREidWNqKrT+BZ9Y0DGpzKiy5DZLpnrc=
Received: from BN1PR12CA0014.namprd12.prod.outlook.com (2603:10b6:408:e1::19)
 by MN2PR12MB4989.namprd12.prod.outlook.com (2603:10b6:208:38::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 05:57:58 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::23) by BN1PR12CA0014.outlook.office365.com
 (2603:10b6:408:e1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Wed, 9 Feb 2022 05:57:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 05:57:58 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Feb
 2022 23:57:55 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/11] drm/amdgpu: Optimize
 xxx_ras_late_init/xxx_ras_late_fini for each ras block
Date: Wed, 9 Feb 2022 13:56:34 +0800
Message-ID: <20220209055644.1873011-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 946d9f7f-173c-453a-1eb9-08d9eb911f9d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4989:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4989C2A5693ADF86E175557AFC2E9@MN2PR12MB4989.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:79;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hjh7WKjxgHuskgwkrS8briCdW984alWCsch01ZBoAjvLnZxYGbqHdrOZp2QY9iKCSyPAWj1d6gylpUUoFfJwFZjmK1h/voE1VYUK8Hk7p0/bpuQvmaN4RWc2QimCsX76C7l7WM/9EwgHV0DfYOBsng48WMb5FeFqgkrs2BtSjLVh9+6d4JYGjoO4J595L3DS0cVT+KoTC4K/o6AQOFkvQNVyJ/IU9zN7eEfocUq668Oc3g7jexlD9elExhWl8xXtXOBNwSkg58QWoOc3925LHi8Dj8KtjPE27JfK7CDFSuDcQXJQwt6RRea6/0GhSAoGsgNrmhx0AQtk2eFMPkderT0qvygfVKVJttU7+eO0ZLDgD9XaXYaULQh5eRq8JZzUlcs8uv3u2yNWimhbdo52b1XIbRo3TT8WcxE65XweegVtjbAdArel6nNafE98B3sf9IkBWxci1J8nhUTyw6Jy0uhAQd73Rv7neq9G264OS9JMTuOXxU8A0HFKZoGXo7RKLyWxTmI94abAURXD6fD1TRvMxcuIdM897J/BQ1gRtpwILnAx/K+LrOPYdt2qa96ydC2mS/hBd7ZP2NXLeHUpMH6HAXkpgnKmTOmZBmgA1G56JOfwFwqJfbkud0s8Fs5WN281ASNgig4t+HFK4/ziGCjTKq9iJ6sy7JjXVFMj8rLXvxsmChL+viKmSpPwBoTZQ561nHdzXJvGHy5Rlv4XCtAY7iTc1DdSpmT1ykRO2go=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8936002)(6666004)(5660300002)(7696005)(8676002)(4326008)(81166007)(70206006)(36756003)(356005)(426003)(336012)(2906002)(186003)(508600001)(26005)(40460700003)(47076005)(36860700001)(86362001)(16526019)(2616005)(83380400001)(30864003)(54906003)(6916009)(82310400004)(1076003)(70586007)(316002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 05:57:58.2186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 946d9f7f-173c-453a-1eb9-08d9eb911f9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4989
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

1. Define amdgpu_ras_block_late_init to create sysfs nodes
   and interrupt handles.
2. Define amdgpu_ras_block_late_fini to remove sysfs nodes
   and interrupt handles.
3. Replace ras block variable members in struct
   amdgpu_ras_block_object with struct ras_common_if, which
   can makes it easy to associate each ras block instance
   with each ras block functional interface.
4. Add .ras_cb to struct amdgpu_ras_block_object.
5. Change each ras block to fit for the changement of struct
   amdgpu_ras_block_object.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c  |  7 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 35 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h  | 15 ++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c |  6 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  4 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |  4 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    |  8 +++---
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c    |  6 ++--
 drivers/gpu/drm/amd/amdgpu/mca_v3_0.c    | 28 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c   |  6 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   |  4 +--
 11 files changed, 86 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 52a60c2316a2..ad057d6b2c77 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -83,14 +83,15 @@ int amdgpu_mca_ras_late_init(struct amdgpu_device *adev,
 		.sysfs_name = sysfs_name,
 	};
 
-	snprintf(sysfs_name, sizeof(sysfs_name), "%s_err_count", mca_dev->ras->ras_block.name);
+	snprintf(sysfs_name, sizeof(sysfs_name), "%s_err_count",
+		mca_dev->ras->ras_block.ras_comm.name);
 
 	if (!mca_dev->ras_if) {
 		mca_dev->ras_if = kmalloc(sizeof(struct ras_common_if), GFP_KERNEL);
 		if (!mca_dev->ras_if)
 			return -ENOMEM;
-		mca_dev->ras_if->block = mca_dev->ras->ras_block.block;
-		mca_dev->ras_if->sub_block_index = mca_dev->ras->ras_block.sub_block_index;
+		mca_dev->ras_if->block = mca_dev->ras->ras_block.ras_comm.block;
+		mca_dev->ras_if->sub_block_index = mca_dev->ras->ras_block.ras_comm.sub_block_index;
 		mca_dev->ras_if->type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
 	}
 	ih_info.head = fs_info.head = *mca_dev->ras_if;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5934326b9db3..b7aed19db7e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -877,7 +877,7 @@ static int amdgpu_ras_block_match_default(struct amdgpu_ras_block_object *block_
 	if (!block_obj)
 		return -EINVAL;
 
-	if (block_obj->block == block)
+	if (block_obj->ras_comm.block == block)
 		return 0;
 
 	return -EINVAL;
@@ -2457,6 +2457,23 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
 	return r;
 }
 
+int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
+			struct ras_common_if *ras_block)
+{
+	char sysfs_name[32];
+	struct ras_ih_if ih_info;
+	struct ras_fs_if fs_info;
+	struct amdgpu_ras_block_object *obj;
+
+	obj = container_of(ras_block, struct amdgpu_ras_block_object, ras_comm);
+	ih_info.cb = obj->ras_cb;
+	ih_info.head = *ras_block;
+	snprintf(sysfs_name, sizeof(sysfs_name), "%s_err_count", ras_block->name);
+	fs_info.sysfs_name = (const char *)sysfs_name;
+	fs_info.head = *ras_block;
+	return amdgpu_ras_late_init(adev, ras_block, &fs_info, &ih_info);
+}
+
 /* helper function to remove ras fs node and interrupt handler */
 void amdgpu_ras_late_fini(struct amdgpu_device *adev,
 			  struct ras_common_if *ras_block,
@@ -2470,6 +2487,22 @@ void amdgpu_ras_late_fini(struct amdgpu_device *adev,
 		amdgpu_ras_interrupt_remove_handler(adev, ih_info);
 }
 
+void amdgpu_ras_block_late_fini(struct amdgpu_device *adev,
+			  struct ras_common_if *ras_block)
+{
+	struct ras_ih_if ih_info;
+	struct amdgpu_ras_block_object *obj;
+
+	if (!ras_block)
+		return;
+
+	obj = container_of(ras_block, struct amdgpu_ras_block_object, ras_comm);
+	ih_info.head = *ras_block;
+	ih_info.cb = obj->ras_cb;
+
+	amdgpu_ras_late_fini(adev, ras_block, &ih_info);
+}
+
 /* do some init work after IP late init as dependence.
  * and it runs in resume/gpu reset/booting up cases.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index a55743b12d57..8b94b556baf6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -486,17 +486,13 @@ struct ras_debug_if {
 };
 
 struct amdgpu_ras_block_object {
-	/* block name */
-	char name[32];
-
-	enum amdgpu_ras_block block;
-
-	uint32_t sub_block_index;
+	struct ras_common_if  ras_comm;
 
 	int (*ras_block_match)(struct amdgpu_ras_block_object *block_obj,
 				enum amdgpu_ras_block block, uint32_t sub_block_index);
 	int (*ras_late_init)(struct amdgpu_device *adev, void *ras_info);
 	void (*ras_fini)(struct amdgpu_device *adev);
+	ras_ih_cb ras_cb;
 	const struct amdgpu_ras_block_hw_ops *hw_ops;
 };
 
@@ -605,10 +601,17 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
 			 struct ras_common_if *ras_block,
 			 struct ras_fs_if *fs_info,
 			 struct ras_ih_if *ih_info);
+
+int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
+			struct ras_common_if *ras_block);
+
 void amdgpu_ras_late_fini(struct amdgpu_device *adev,
 			  struct ras_common_if *ras_block,
 			  struct ras_ih_if *ih_info);
 
+void amdgpu_ras_block_late_fini(struct amdgpu_device *adev,
+			  struct ras_common_if *ras_block);
+
 int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 		struct ras_common_if *head, bool enable);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 5929d6f528c9..15707af89212 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -981,8 +981,10 @@ struct amdgpu_ras_block_hw_ops  xgmi_ras_hw_ops = {
 
 struct amdgpu_xgmi_ras xgmi_ras = {
 	.ras_block = {
-		.name = "xgmi",
-		.block = AMDGPU_RAS_BLOCK__XGMI_WAFL,
+		.ras_comm = {
+			.name = "xgmi",
+			.block = AMDGPU_RAS_BLOCK__XGMI_WAFL,
+		},
 		.hw_ops = &xgmi_ras_hw_ops,
 		.ras_late_init = amdgpu_xgmi_ras_late_init,
 		.ras_fini = amdgpu_xgmi_ras_fini,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index ca7b886c6ce6..0a291d2e5f91 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2198,8 +2198,8 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 			return err;
 		}
 
-		strcpy(adev->gfx.ras->ras_block.name,"gfx");
-		adev->gfx.ras->ras_block.block = AMDGPU_RAS_BLOCK__GFX;
+		strcpy(adev->gfx.ras->ras_block.ras_comm.name, "gfx");
+		adev->gfx.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__GFX;
 
 		/* If not define special ras_late_init function, use gfx default ras_late_init */
 		if (!adev->gfx.ras->ras_block.ras_late_init)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index bddaf2417344..2a362c570346 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -672,8 +672,8 @@ static void gmc_v10_0_set_umc_funcs(struct amdgpu_device *adev)
 	if (adev->umc.ras) {
 		amdgpu_ras_register_ras_block(adev, &adev->umc.ras->ras_block);
 
-		strcpy(adev->umc.ras->ras_block.name, "umc");
-		adev->umc.ras->ras_block.block = AMDGPU_RAS_BLOCK__UMC;
+		strcpy(adev->umc.ras->ras_block.ras_comm.name, "umc");
+		adev->umc.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__UMC;
 
 		/* If don't define special ras_late_init function, use default ras_late_init */
 		if (!adev->umc.ras->ras_block.ras_late_init)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 4595027a8c63..af873c99d5e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1232,8 +1232,8 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 	if (adev->umc.ras) {
 		amdgpu_ras_register_ras_block(adev, &adev->umc.ras->ras_block);
 
-		strcpy(adev->umc.ras->ras_block.name, "umc");
-		adev->umc.ras->ras_block.block = AMDGPU_RAS_BLOCK__UMC;
+		strcpy(adev->umc.ras->ras_block.ras_comm.name, "umc");
+		adev->umc.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__UMC;
 
 		/* If don't define special ras_late_init function, use default ras_late_init */
 		if (!adev->umc.ras->ras_block.ras_late_init)
@@ -1280,8 +1280,8 @@ static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgpu_device *adev)
 	if (adev->mmhub.ras) {
 		amdgpu_ras_register_ras_block(adev, &adev->mmhub.ras->ras_block);
 
-		strcpy(adev->mmhub.ras->ras_block.name,"mmhub");
-		adev->mmhub.ras->ras_block.block = AMDGPU_RAS_BLOCK__MMHUB;
+		strcpy(adev->mmhub.ras->ras_block.ras_comm.name, "mmhub");
+		adev->mmhub.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MMHUB;
 
 		/* If don't define special ras_late_init function, use default ras_late_init */
 		if (!adev->mmhub.ras->ras_block.ras_late_init)
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index 6b41fcbf4875..503c292b321e 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -157,8 +157,10 @@ struct amdgpu_ras_block_hw_ops hdp_v4_0_ras_hw_ops = {
 
 struct amdgpu_hdp_ras hdp_v4_0_ras = {
 	.ras_block = {
-		.name = "hdp",
-		.block = AMDGPU_RAS_BLOCK__HDP,
+		.ras_comm = {
+			.name = "hdp",
+			.block = AMDGPU_RAS_BLOCK__HDP,
+		},
 		.hw_ops = &hdp_v4_0_ras_hw_ops,
 		.ras_late_init = amdgpu_hdp_ras_late_init,
 		.ras_fini = amdgpu_hdp_ras_fini,
diff --git a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
index 68565262af9c..386416378a82 100644
--- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
@@ -53,8 +53,8 @@ static int mca_v3_0_ras_block_match(struct amdgpu_ras_block_object *block_obj,
 	if (!block_obj)
 		return -EINVAL;
 
-	if ((block_obj->block == block) &&
-		(block_obj->sub_block_index == sub_block_index)) {
+	if ((block_obj->ras_comm.block == block) &&
+		(block_obj->ras_comm.sub_block_index == sub_block_index)) {
 		return 0;
 	}
 
@@ -68,9 +68,11 @@ const struct amdgpu_ras_block_hw_ops mca_v3_0_mp0_hw_ops = {
 
 struct amdgpu_mca_ras_block mca_v3_0_mp0_ras = {
 	.ras_block = {
-		.block = AMDGPU_RAS_BLOCK__MCA,
-		.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MP0,
-		.name = "mp0",
+		.ras_comm = {
+			.block = AMDGPU_RAS_BLOCK__MCA,
+			.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MP0,
+			.name = "mp0",
+		},
 		.hw_ops = &mca_v3_0_mp0_hw_ops,
 		.ras_block_match = mca_v3_0_ras_block_match,
 		.ras_late_init = mca_v3_0_mp0_ras_late_init,
@@ -103,9 +105,11 @@ const struct amdgpu_ras_block_hw_ops mca_v3_0_mp1_hw_ops = {
 
 struct amdgpu_mca_ras_block mca_v3_0_mp1_ras = {
 	.ras_block = {
-		.block = AMDGPU_RAS_BLOCK__MCA,
-		.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MP1,
-		.name = "mp1",
+		.ras_comm = {
+			.block = AMDGPU_RAS_BLOCK__MCA,
+			.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MP1,
+			.name = "mp1",
+		},
 		.hw_ops = &mca_v3_0_mp1_hw_ops,
 		.ras_block_match = mca_v3_0_ras_block_match,
 		.ras_late_init = mca_v3_0_mp1_ras_late_init,
@@ -138,9 +142,11 @@ const struct amdgpu_ras_block_hw_ops mca_v3_0_mpio_hw_ops = {
 
 struct amdgpu_mca_ras_block mca_v3_0_mpio_ras = {
 	.ras_block = {
-		.block = AMDGPU_RAS_BLOCK__MCA,
-		.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MPIO,
-		.name = "mpio",
+		.ras_comm = {
+			.block = AMDGPU_RAS_BLOCK__MCA,
+			.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MPIO,
+			.name = "mpio",
+		},
 		.hw_ops = &mca_v3_0_mpio_hw_ops,
 		.ras_block_match = mca_v3_0_ras_block_match,
 		.ras_late_init = mca_v3_0_mpio_ras_late_init,
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 39974b449341..c7cca87f1647 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -664,8 +664,10 @@ const struct amdgpu_ras_block_hw_ops nbio_v7_4_ras_hw_ops = {
 
 struct amdgpu_nbio_ras nbio_v7_4_ras = {
 	.ras_block = {
-		.name = "pcie_bif",
-		.block = AMDGPU_RAS_BLOCK__PCIE_BIF,
+		.ras_comm = {
+			.name = "pcie_bif",
+			.block = AMDGPU_RAS_BLOCK__PCIE_BIF,
+		},
 		.hw_ops = &nbio_v7_4_ras_hw_ops,
 		.ras_late_init = amdgpu_nbio_ras_late_init,
 		.ras_fini = amdgpu_nbio_ras_fini,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 06a7ceda4c87..8b0a8587dd36 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2814,8 +2814,8 @@ static void sdma_v4_0_set_ras_funcs(struct amdgpu_device *adev)
 	if (adev->sdma.ras) {
 		amdgpu_ras_register_ras_block(adev, &adev->sdma.ras->ras_block);
 
-		strcpy(adev->sdma.ras->ras_block.name, "sdma");
-		adev->sdma.ras->ras_block.block = AMDGPU_RAS_BLOCK__SDMA;
+		strcpy(adev->sdma.ras->ras_block.ras_comm.name, "sdma");
+		adev->sdma.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__SDMA;
 
 		/* If don't define special ras_late_init function, use default ras_late_init */
 		if (!adev->sdma.ras->ras_block.ras_late_init)
-- 
2.25.1

