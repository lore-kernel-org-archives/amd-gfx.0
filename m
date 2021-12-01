Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D30C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 10:53:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15D286F560;
	Wed,  1 Dec 2021 10:53:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DEB86F5A6
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 10:53:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lR5GLSljCY0hamupi/Reh4+HEYu9gu39C/ZBVuIUEZbTacFhNsafWVrRDgokhfdzBwyUurbo1D/cqDcEX5r40a3RdATdFxYyiGn0D6fr0VSmKcVLcMVPsrhwsIP0HkTNwk+icVRdfN7n8FVeFPzN2HfjopjXuQOz+/UoHg0XsGboYXX/kpvMd1yG8HJPLWEoF12plqBZqHRvl5PqhoSiiFTuCWO+vau84umeKqjuN2RR770YBullPLesPxpZtk/6BpaOVlTFqslaMJGsUic8zs3paylIB3pQrIEXa9iSuCa4ubunVHlDUfXpne7RfpgIQP4vlU2z1DEAPKEdksDWcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yp9arsHpwxt1kKm8HHqkijjNzJmJiKjENk963hRdSco=;
 b=ETbJpqM+QtqjUieu2cKng/5KoMtLXPuHDQGj7tCpZguIsDEQkNsr3UGG4DK5iMxbegNJEc61feCm5+Zw3eKh6ByN+8VZnXpifO5vmWsACG1TykDUIizPO4XMtMqDh1JpZv0fvf1fCycvnAbeeDkn8US2YRprMvgkxbb++/fEH6hAMi6i77LPUabYEnh/NkbheCp1ycT5PZ9Ba1/kE0jEXUsEsjiHh6RH/n9ffatyujxcgStGs8M0i8KvIpXEO7Nls7PbbjNFYv6Z9wnBFeX2ZyQOZxo5Fild+s1QJG5h6sh5tDjSytY50dJmDdaoqA94oIUC9zM1K0MKD6TvHcwFWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yp9arsHpwxt1kKm8HHqkijjNzJmJiKjENk963hRdSco=;
 b=NOKdvyWcvrKrh3Ljplzewv3/EKwyJI29TBfSgZRCv06uLN4ig7ZctAy+HhhsnBlhLqhFHmDQuG4R9Ift7W/vlP2Za4lv3Y8CY8TExgk/pwkJ/Th/FY0tGpYiAVatyKlqfnyI7w0S9UDkvAFNfrV97tYQmRkbyoQWZyusYOaTUIs=
Received: from BN6PR20CA0064.namprd20.prod.outlook.com (2603:10b6:404:151::26)
 by MN2PR12MB3694.namprd12.prod.outlook.com (2603:10b6:208:165::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Wed, 1 Dec
 2021 10:53:38 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::54) by BN6PR20CA0064.outlook.office365.com
 (2603:10b6:404:151::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend
 Transport; Wed, 1 Dec 2021 10:53:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 1 Dec 2021 10:53:38 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 04:53:35 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 03/11] drm/amdgpu: Modify gfx block to fit for the unified
 ras block data and ops
Date: Wed, 1 Dec 2021 18:52:42 +0800
Message-ID: <20211201105250.298525-3-YiPeng.Chai@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 79da4013-f797-47ac-ebf6-08d9b4b8d4a0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3694:
X-Microsoft-Antispam-PRVS: <MN2PR12MB36943FC5730538D7A86EF1D2FC689@MN2PR12MB3694.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x0R+wtifyQY91ug9TGRYQA89MTqFZypCd929JwGWPpSZwO87/0bjJGL9zLmswOzGSjOawAcjMK6Nuh0euDd4r5U15kuHz7L0F+RfP1Li//8Gmx+K8XmFjuJGDOw6A44p7+QxVTLIwXeGp03D6IlvYC4Us7RfMl/h6ANcrXXbQ9DrjH6uOm+J49QrVxo36iTwxrkckN+pUvCzXUTmEiO2fIYEn85uJz4FmAR2n+qzg/3PXl6VV0joIsRzMBVZnEulvCMEOsQEyjtYF32nY2/RpOSSpBM1WmGBrde1JieSdY5OmWDfGpmvsPJHmNpT55fx7w7rUrg3Q/uEnmI+zT0sYtlisS+UbrjGiIwGyubRIo5qcAStTIJwPWc35+uumHuQjP/tfqIGOzNlnv/mwC2uIXPeBgM+8I9BdVVNdERW1LFD329H7ooMZbRI8l+gL41p8H3xj7Yz/D7Mnj0PCIbckWBlqtmuPItn5XDgdEvb5SgXXvTGT44jqpMyRI4F1OpdcGGwBk6sPS1pTuxzFKCmZ4U6wAt9RWiRob40IArKEi7UQXAaN5t+cA0OJiLrzNSOaqPZCHgmBcQnRa4iC5JH9G4Y+xJOO8bMXuZG76xcDo+KllERtCnCYwXveimB+UpqkHP2TqFG4G68Haf6OEpt5p7eIvbWSvy2+GMMU/GJ7Klt9mYlLTiWD48mO43KoPBl8lyi4H2/asMOdUnmZ0z+L+NhM9uP+kymhNUxo0ok8lCG7WMsSESXuaYXSHlLr9qb+tElGn3NmTBlkFZZhwqKfDfnlDxqgPN0kmknlOhHd+6B4vGbNbFlvunBAzuKtVwtgTedWmLFbgGbJNRJiTKtxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(356005)(82310400004)(36756003)(40460700001)(81166007)(6916009)(508600001)(36860700001)(30864003)(4326008)(186003)(70206006)(8936002)(6666004)(54906003)(336012)(86362001)(83380400001)(8676002)(426003)(7696005)(5660300002)(316002)(16526019)(1076003)(26005)(2616005)(47076005)(70586007)(2906002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 10:53:38.3465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79da4013-f797-47ac-ebf6-08d9b4b8d4a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3694
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

1.Modify gfx block to fit for the unified ras block data and ops
2.Implement .ras_block_match function pointer for gfx block to identify itself.
3.Change amdgpu_gfx_ras_funcs to amdgpu_gfx_ras, and the corresponding variable name remove _funcs suffix.
4.Remove the const flag of gfx ras variable so that gfx ras block can be able to be insertted into amdgpu device ras block link list.
5.Invoke amdgpu_ras_register_ras_block function to register gfx ras block into amdgpu device ras block link list.
6.Remove the redundant code about gfx in amdgpu_ras.c after using the unified ras block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 15 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 80 ++++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 73 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c   | 39 ++++++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 42 +++++++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h |  2 +-
 8 files changed, 178 insertions(+), 81 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 1795d448c700..da8691259ac1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -696,9 +696,9 @@ int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
 	 */
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX)) {
 		kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
-		if (adev->gfx.ras_funcs &&
-		    adev->gfx.ras_funcs->query_ras_error_count)
-			adev->gfx.ras_funcs->query_ras_error_count(adev, err_data);
+		if (adev->gfx.ras && adev->gfx.ras->ras_block.ops &&
+		    adev->gfx.ras->ras_block.ops->query_ras_error_count)
+			adev->gfx.ras->ras_block.ops->query_ras_error_count(adev, err_data);
 		amdgpu_ras_reset_gpu(adev);
 	}
 	return AMDGPU_RAS_SUCCESS;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 6b78b4a0e182..ff4a8428a84b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -31,6 +31,7 @@
 #include "amdgpu_ring.h"
 #include "amdgpu_rlc.h"
 #include "soc15.h"
+#include "amdgpu_ras.h"
 
 /* GFX current status */
 #define AMDGPU_GFX_NORMAL_MODE			0x00000000L
@@ -213,16 +214,8 @@ struct amdgpu_cu_info {
 	uint32_t bitmap[4][4];
 };
 
-struct amdgpu_gfx_ras_funcs {
-	int (*ras_late_init)(struct amdgpu_device *adev);
-	void (*ras_fini)(struct amdgpu_device *adev);
-	int (*ras_error_inject)(struct amdgpu_device *adev,
-				void *inject_if);
-	int (*query_ras_error_count)(struct amdgpu_device *adev,
-				     void *ras_error_status);
-	void (*reset_ras_error_count)(struct amdgpu_device *adev);
-	void (*query_ras_error_status)(struct amdgpu_device *adev);
-	void (*reset_ras_error_status)(struct amdgpu_device *adev);
+struct amdgpu_gfx_ras {
+	struct amdgpu_ras_block_object  ras_block;
 	void (*enable_watchdog_timer)(struct amdgpu_device *adev);
 };
 
@@ -348,7 +341,7 @@ struct amdgpu_gfx {
 
 	/*ras */
 	struct ras_common_if			*ras_if;
-	const struct amdgpu_gfx_ras_funcs	*ras_funcs;
+	struct amdgpu_gfx_ras	*ras;
 };
 
 #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1cf1f6331db1..190a4a4e9d7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -862,6 +862,27 @@ static int amdgpu_ras_enable_all_features(struct amdgpu_device *adev,
 }
 /* feature ctl end */
 
+static struct amdgpu_ras_block_object* amdgpu_ras_get_ras_block(struct amdgpu_device *adev,
+					enum amdgpu_ras_block block, uint32_t sub_block_index)
+{
+	struct amdgpu_ras_block_object *obj, *tmp;
+
+	if (block >= AMDGPU_RAS_BLOCK__LAST) {
+		return NULL;
+	}
+
+	list_for_each_entry_safe(obj, tmp, &adev->ras_list, node) {
+		if( !obj->ops || !obj->ops->ras_block_match) {
+			dev_info(adev->dev, "%s don't config ops or  ras_block_match\n", obj->name);
+			continue;
+		}
+		if (!obj->ops->ras_block_match(obj, block, sub_block_index)) {
+			return obj;
+		}
+	}
+
+	return NULL;
+}
 
 void amdgpu_ras_mca_query_error_status(struct amdgpu_device *adev,
 				       struct ras_common_if *ras_block,
@@ -892,6 +913,7 @@ void amdgpu_ras_mca_query_error_status(struct amdgpu_device *adev,
 int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 				  struct ras_query_if *info)
 {
+	struct amdgpu_ras_block_object* block_obj = NULL;
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &info->head);
 	struct ras_err_data err_data = {0, 0, 0, NULL};
 	int i;
@@ -899,6 +921,8 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 	if (!obj)
 		return -EINVAL;
 
+	block_obj = amdgpu_ras_get_ras_block(adev, info->head.block, 0);
+
 	switch (info->head.block) {
 	case AMDGPU_RAS_BLOCK__UMC:
 		if (adev->umc.ras_funcs &&
@@ -919,13 +943,17 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		}
 		break;
 	case AMDGPU_RAS_BLOCK__GFX:
-		if (adev->gfx.ras_funcs &&
-		    adev->gfx.ras_funcs->query_ras_error_count)
-			adev->gfx.ras_funcs->query_ras_error_count(adev, &err_data);
+		if (!block_obj || !block_obj->ops)	{
+			dev_info(adev->dev, "%s don't config ras function \n",
+				get_ras_block_str(&info->head));
+			return -EINVAL;
+		}
+
+		if (block_obj->ops->query_ras_error_count)
+			block_obj->ops->query_ras_error_count(adev, &err_data);
 
-		if (adev->gfx.ras_funcs &&
-		    adev->gfx.ras_funcs->query_ras_error_status)
-			adev->gfx.ras_funcs->query_ras_error_status(adev);
+		if (block_obj->ops->query_ras_error_status)
+			block_obj->ops->query_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__MMHUB:
 		if (adev->mmhub.ras_funcs &&
@@ -1012,18 +1040,21 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 		enum amdgpu_ras_block block)
 {
+	struct amdgpu_ras_block_object* block_obj = amdgpu_ras_get_ras_block(adev, block, 0);
 	if (!amdgpu_ras_is_supported(adev, block))
 		return -EINVAL;
 
 	switch (block) {
 	case AMDGPU_RAS_BLOCK__GFX:
-		if (adev->gfx.ras_funcs &&
-		    adev->gfx.ras_funcs->reset_ras_error_count)
-			adev->gfx.ras_funcs->reset_ras_error_count(adev);
+		if (!block_obj || !block_obj->ops)	{
+			dev_info(adev->dev, "%s don't config ras function \n", ras_block_str(block));
+			return -EINVAL;
+		}
+		if (block_obj->ops->reset_ras_error_count)
+			block_obj->ops->reset_ras_error_count(adev);
 
-		if (adev->gfx.ras_funcs &&
-		    adev->gfx.ras_funcs->reset_ras_error_status)
-			adev->gfx.ras_funcs->reset_ras_error_status(adev);
+		if (block_obj->ops->reset_ras_error_status)
+			block_obj->ops->reset_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__MMHUB:
 		if (adev->mmhub.ras_funcs &&
@@ -1088,7 +1119,8 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 		.address = info->address,
 		.value = info->value,
 	};
-	int ret = 0;
+	int ret = -EINVAL;
+	struct amdgpu_ras_block_object* block_obj = amdgpu_ras_get_ras_block(adev, info->head.block, info->head.sub_block_index);
 
 	if (!obj)
 		return -EINVAL;
@@ -1102,11 +1134,12 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 
 	switch (info->head.block) {
 	case AMDGPU_RAS_BLOCK__GFX:
-		if (adev->gfx.ras_funcs &&
-		    adev->gfx.ras_funcs->ras_error_inject)
-			ret = adev->gfx.ras_funcs->ras_error_inject(adev, info);
-		else
-			ret = -EINVAL;
+		if (!block_obj || !block_obj->ops)	{
+			dev_info(adev->dev, "%s don't config ras function \n", get_ras_block_str(&info->head));
+			return -EINVAL;
+		}
+		if (block_obj->ops->ras_error_inject)
+			ret = block_obj->ops->ras_error_inject(adev, info);
 		break;
 	case AMDGPU_RAS_BLOCK__UMC:
 	case AMDGPU_RAS_BLOCK__SDMA:
@@ -1727,15 +1760,20 @@ static void amdgpu_ras_log_on_err_counter(struct amdgpu_device *adev)
 static void amdgpu_ras_error_status_query(struct amdgpu_device *adev,
 					  struct ras_query_if *info)
 {
+	struct amdgpu_ras_block_object* block_obj = amdgpu_ras_get_ras_block(adev, info->head.block, info->head.sub_block_index);
 	/*
 	 * Only two block need to query read/write
 	 * RspStatus at current state
 	 */
 	switch (info->head.block) {
 	case AMDGPU_RAS_BLOCK__GFX:
-		if (adev->gfx.ras_funcs &&
-		    adev->gfx.ras_funcs->query_ras_error_status)
-			adev->gfx.ras_funcs->query_ras_error_status(adev);
+		if (!block_obj || !block_obj->ops)	{
+			dev_info(adev->dev, "%s don't config ras function \n", get_ras_block_str(&info->head));
+			return ;
+		}
+
+		if (block_obj->ops->query_ras_error_status)
+			block_obj->ops->query_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__MMHUB:
 		if (adev->mmhub.ras_funcs &&
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 08e91e7245df..2ffde223c4f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -817,7 +817,7 @@ static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
 static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
 static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring);
 static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);
-static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
+static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 					  void *ras_error_status);
 static int gfx_v9_0_ras_error_inject(struct amdgpu_device *adev,
 				     void *inject_if);
@@ -2118,6 +2118,18 @@ static void gfx_v9_0_select_me_pipe_q(struct amdgpu_device *adev,
 	soc15_grbm_select(adev, me, pipe, q, vm);
 }
 
+static int gfx_v9_0_ras_block_match(struct amdgpu_ras_block_object* block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index)
+{
+	if(!block_obj)
+		return -EINVAL;
+
+	if(block_obj->block == block) {
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs = {
         .get_gpu_clock_counter = &gfx_v9_0_get_gpu_clock_counter,
         .select_se_sh = &gfx_v9_0_select_se_sh,
@@ -2127,12 +2139,21 @@ static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs = {
         .select_me_pipe_q = &gfx_v9_0_select_me_pipe_q,
 };
 
-static const struct amdgpu_gfx_ras_funcs gfx_v9_0_ras_funcs = {
-	.ras_late_init = amdgpu_gfx_ras_late_init,
-	.ras_fini = amdgpu_gfx_ras_fini,
-	.ras_error_inject = &gfx_v9_0_ras_error_inject,
-	.query_ras_error_count = &gfx_v9_0_query_ras_error_count,
-	.reset_ras_error_count = &gfx_v9_0_reset_ras_error_count,
+const struct amdgpu_ras_block_ops  gfx_v9_0_ras_ops = {
+		.ras_block_match = gfx_v9_0_ras_block_match,
+		.ras_late_init = amdgpu_gfx_ras_late_init,
+		.ras_fini = amdgpu_gfx_ras_fini,
+		.ras_error_inject = &gfx_v9_0_ras_error_inject,
+		.query_ras_error_count = &gfx_v9_0_query_ras_error_count,
+		.reset_ras_error_count = &gfx_v9_0_reset_ras_error_count,
+};
+
+static struct amdgpu_gfx_ras gfx_v9_0_ras = {
+	.ras_block = {
+		.name = "gfx",
+		.block = AMDGPU_RAS_BLOCK__GFX,
+		.ops = &gfx_v9_0_ras_ops,
+	},
 };
 
 static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
@@ -2161,7 +2182,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 		DRM_INFO("fix gfx.config for vega12\n");
 		break;
 	case CHIP_VEGA20:
-		adev->gfx.ras_funcs = &gfx_v9_0_ras_funcs;
+		adev->gfx.ras = &gfx_v9_0_ras;
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -2187,7 +2208,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 			gb_addr_config = RAVEN_GB_ADDR_CONFIG_GOLDEN;
 		break;
 	case CHIP_ARCTURUS:
-		adev->gfx.ras_funcs = &gfx_v9_4_ras_funcs;
+		adev->gfx.ras = &gfx_v9_4_ras;
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -2208,7 +2229,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 		gb_addr_config |= 0x22010042;
 		break;
 	case CHIP_ALDEBARAN:
-		adev->gfx.ras_funcs = &gfx_v9_4_2_ras_funcs;
+		adev->gfx.ras = &gfx_v9_4_2_ras;
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -2227,6 +2248,14 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 		break;
 	}
 
+	if (adev->gfx.ras) {
+		err = amdgpu_ras_register_ras_block(adev, &adev->gfx.ras->ras_block);
+		if (err) {
+			DRM_ERROR("Failed to register gfx ras block!\n");
+			return err;
+		}
+	}
+
 	adev->gfx.config.gb_addr_config = gb_addr_config;
 
 	adev->gfx.config.gb_addr_config_fields.num_pipes = 1 <<
@@ -2448,9 +2477,9 @@ static int gfx_v9_0_sw_fini(void *handle)
 	int i;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (adev->gfx.ras_funcs &&
-	    adev->gfx.ras_funcs->ras_fini)
-		adev->gfx.ras_funcs->ras_fini(adev);
+	if (adev->gfx.ras && adev->gfx.ras->ras_block.ops &&
+	    adev->gfx.ras->ras_block.ops->ras_fini)
+		adev->gfx.ras->ras_block.ops->ras_fini(adev);
 
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
@@ -4888,16 +4917,16 @@ static int gfx_v9_0_ecc_late_init(void *handle)
 	if (r)
 		return r;
 
-	if (adev->gfx.ras_funcs &&
-	    adev->gfx.ras_funcs->ras_late_init) {
-		r = adev->gfx.ras_funcs->ras_late_init(adev);
+	if (adev->gfx.ras && adev->gfx.ras->ras_block.ops &&
+	    adev->gfx.ras->ras_block.ops->ras_late_init) {
+		r = adev->gfx.ras->ras_block.ops->ras_late_init(adev);
 		if (r)
 			return r;
 	}
 
-	if (adev->gfx.ras_funcs &&
-	    adev->gfx.ras_funcs->enable_watchdog_timer)
-		adev->gfx.ras_funcs->enable_watchdog_timer(adev);
+	if (adev->gfx.ras &&
+	    adev->gfx.ras->enable_watchdog_timer)
+		adev->gfx.ras->enable_watchdog_timer(adev);
 
 	return 0;
 }
@@ -6841,7 +6870,7 @@ static void gfx_v9_0_reset_ras_error_count(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, mmATC_L2_CACHE_4K_EDC_INDEX, 255);
 }
 
-static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
+static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 					  void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
@@ -6850,7 +6879,7 @@ static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 	uint32_t reg_value;
 
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
-		return -EINVAL;
+		return;
 
 	err_data->ue_count = 0;
 	err_data->ce_count = 0;
@@ -6879,8 +6908,6 @@ static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	gfx_v9_0_query_utc_edc_status(adev, err_data);
-
-	return 0;
 }
 
 static void gfx_v9_0_emit_mem_sync(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
index b4789dfc2bb9..2d816addbd4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
@@ -863,7 +863,7 @@ static int gfx_v9_4_ras_error_count(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int gfx_v9_4_query_ras_error_count(struct amdgpu_device *adev,
+static void gfx_v9_4_query_ras_error_count(struct amdgpu_device *adev,
 					  void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
@@ -872,7 +872,7 @@ static int gfx_v9_4_query_ras_error_count(struct amdgpu_device *adev,
 	uint32_t reg_value;
 
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
-		return -EINVAL;
+		return;
 
 	err_data->ue_count = 0;
 	err_data->ce_count = 0;
@@ -903,7 +903,6 @@ static int gfx_v9_4_query_ras_error_count(struct amdgpu_device *adev,
 
 	gfx_v9_4_query_utc_edc_status(adev, err_data);
 
-	return 0;
 }
 
 static void gfx_v9_4_reset_ras_error_count(struct amdgpu_device *adev)
@@ -1029,11 +1028,31 @@ static void gfx_v9_4_query_ras_error_status(struct amdgpu_device *adev)
 	mutex_unlock(&adev->grbm_idx_mutex);
 }
 
-const struct amdgpu_gfx_ras_funcs gfx_v9_4_ras_funcs = {
-        .ras_late_init = amdgpu_gfx_ras_late_init,
-        .ras_fini = amdgpu_gfx_ras_fini,
-        .ras_error_inject = &gfx_v9_4_ras_error_inject,
-        .query_ras_error_count = &gfx_v9_4_query_ras_error_count,
-        .reset_ras_error_count = &gfx_v9_4_reset_ras_error_count,
-        .query_ras_error_status = &gfx_v9_4_query_ras_error_status,
+static int gfx_v9_4_ras_block_match(struct amdgpu_ras_block_object* block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index)
+{
+	if(!block_obj)
+		return -EINVAL;
+
+	if(block_obj->block == block) {
+		return 0;
+	}
+	return -EINVAL;
+}
+
+const struct amdgpu_ras_block_ops  gfx_v9_4_ras_ops = {
+	.ras_block_match = gfx_v9_4_ras_block_match,
+	.ras_late_init = amdgpu_gfx_ras_late_init,
+	.ras_fini = amdgpu_gfx_ras_fini,
+	.ras_error_inject = &gfx_v9_4_ras_error_inject,
+	.query_ras_error_count = &gfx_v9_4_query_ras_error_count,
+	.reset_ras_error_count = &gfx_v9_4_reset_ras_error_count,
+	.query_ras_error_status = &gfx_v9_4_query_ras_error_status,
+};
+
+struct amdgpu_gfx_ras gfx_v9_4_ras = {
+	.ras_block = {
+		.name = "gfx",
+		.block = AMDGPU_RAS_BLOCK__GFX,
+		.ops = &gfx_v9_4_ras_ops,
+	},
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
index bdd16b568021..ca520a767267 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
@@ -24,6 +24,6 @@
 #ifndef __GFX_V9_4_H__
 #define __GFX_V9_4_H__
 
-extern const struct amdgpu_gfx_ras_funcs gfx_v9_4_ras_funcs;
+extern struct amdgpu_gfx_ras gfx_v9_4_ras;
 
 #endif /* __GFX_V9_4_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 54306fd45ff1..2744709fa09d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -1644,14 +1644,14 @@ static int gfx_v9_4_2_query_utc_edc_count(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int gfx_v9_4_2_query_ras_error_count(struct amdgpu_device *adev,
+static void gfx_v9_4_2_query_ras_error_count(struct amdgpu_device *adev,
 					    void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 	uint32_t sec_count = 0, ded_count = 0;
 
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
-		return -EINVAL;
+		return;
 
 	err_data->ue_count = 0;
 	err_data->ce_count = 0;
@@ -1664,7 +1664,6 @@ static int gfx_v9_4_2_query_ras_error_count(struct amdgpu_device *adev,
 	err_data->ce_count += sec_count;
 	err_data->ue_count += ded_count;
 
-	return 0;
 }
 
 static void gfx_v9_4_2_reset_utc_err_status(struct amdgpu_device *adev)
@@ -1934,13 +1933,34 @@ static void gfx_v9_4_2_reset_sq_timeout_status(struct amdgpu_device *adev)
 	mutex_unlock(&adev->grbm_idx_mutex);
 }
 
-const struct amdgpu_gfx_ras_funcs gfx_v9_4_2_ras_funcs = {
-	.ras_late_init = amdgpu_gfx_ras_late_init,
-	.ras_fini = amdgpu_gfx_ras_fini,
-	.ras_error_inject = &gfx_v9_4_2_ras_error_inject,
-	.query_ras_error_count = &gfx_v9_4_2_query_ras_error_count,
-	.reset_ras_error_count = &gfx_v9_4_2_reset_ras_error_count,
-	.query_ras_error_status = &gfx_v9_4_2_query_ras_error_status,
-	.reset_ras_error_status = &gfx_v9_4_2_reset_ras_error_status,
+static int gfx_v9_4_2_ras_block_match(struct amdgpu_ras_block_object* block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index)
+{
+	if(!block_obj)
+		return -EINVAL;
+
+	if(block_obj->block == block) {
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+struct amdgpu_ras_block_ops  gfx_v9_4_2_ras_ops ={
+		.ras_block_match = gfx_v9_4_2_ras_block_match,
+		.ras_late_init = amdgpu_gfx_ras_late_init,
+		.ras_fini = amdgpu_gfx_ras_fini,
+		.ras_error_inject = &gfx_v9_4_2_ras_error_inject,
+		.query_ras_error_count = &gfx_v9_4_2_query_ras_error_count,
+		.reset_ras_error_count = &gfx_v9_4_2_reset_ras_error_count,
+		.query_ras_error_status = &gfx_v9_4_2_query_ras_error_status,
+		.reset_ras_error_status = &gfx_v9_4_2_reset_ras_error_status,
+};
+
+struct amdgpu_gfx_ras gfx_v9_4_2_ras = {
+	.ras_block = {
+		.name = "gfx",
+		.block = AMDGPU_RAS_BLOCK__GFX,
+		.ops = &gfx_v9_4_2_ras_ops,
+	},
 	.enable_watchdog_timer = &gfx_v9_4_2_enable_watchdog_timer,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
index 6db1f88509af..7584624b641c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
@@ -31,6 +31,6 @@ void gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
 void gfx_v9_4_2_set_power_brake_sequence(struct amdgpu_device *adev);
 int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_device *adev);
 
-extern const struct amdgpu_gfx_ras_funcs gfx_v9_4_2_ras_funcs;
+extern struct amdgpu_gfx_ras gfx_v9_4_2_ras;
 
 #endif /* __GFX_V9_4_2_H__ */
-- 
2.25.1

