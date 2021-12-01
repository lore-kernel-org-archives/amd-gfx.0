Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC913C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 10:53:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29A4F6F5A6;
	Wed,  1 Dec 2021 10:53:44 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2086.outbound.protection.outlook.com [40.107.95.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FBE86F560
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 10:53:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clrpNn7Wj6d3w6fNiB8t4Qj4EOJ0YPPTF6dDoXTnMlnY8gk1DDdJjye62JZOIhMYAhu8ZIJ6/QooyrGW97+QPQ6yG+WNwcah/JJ8vCdNyVKC5gcHC5U2HlwTDtVK35h0bG6OA7owO5xijeRcorf/MKhMIwDkzCWU9QW8j3G36q2XQ8cGkoVHxJsHg7wEuXYSL2fZj8ZR0W8MO6DqXVy9n/JCMN4XvovPaIOiayPYrrglTiS1Bfabegf6bHhlifG5rDsx/4veUkAclP1MSftSyBWchewLS+KrUBc+V35cDQeEzs2gd5kuFDYK8c7LfCdyDIuZ8HcLIh0DiSdhyxTtFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLIer2+G3Ihc4XpeCUnpErMP+GSwZJs/PA1WdxP8Lnc=;
 b=agAXVVf7keIzAwDNVerD/y0uHKhmHXHA8Y8H7cM7psfZNkPrAaepwINskQi5eAFNxyvyDXfeVicv/f6dkxC5BCvNR6I59sNDMEI/NHMKHwpccrq2Bhf2Gdg+8F3XI7N2x6xnfWaBoxAYJEBzvQtQqoTwJAizFvpooQD+tFrOL8gzYkikfP0yWuKAf0qg0NR+2tc/Y+MesO7TCRSawogikGiq0AT1cpksy/sf5KNWpVdiIgWwUdDHWUVUKF8ZNhY/l3VllexLwAUVJyZoumJ1b8A3mNWZqxmVacNWl2AOSCGWT0gs5JZtMGb23NzlKbqv2V+XcFKDQvkh9sDTfoiW1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLIer2+G3Ihc4XpeCUnpErMP+GSwZJs/PA1WdxP8Lnc=;
 b=GIIHg7dv5fP2UtsPG63PJ+tZsNxOAzn+PlFUqVIp6Nk6PbUf7NWYd7shFu2+WWI5IFHp9Gy6O6re6VRRZ/RTeOw9SN8ds6PfL8PBz9bFrEwJxkYmJkZR2lHbjChhlpNGbI3j11wGlNgN5g/9uDkhFGc9rhpsrz0OW5xZ14H2hMs=
Received: from BN9PR03CA0592.namprd03.prod.outlook.com (2603:10b6:408:10d::27)
 by BN6PR12MB1554.namprd12.prod.outlook.com (2603:10b6:405:3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 10:53:40 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::af) by BN9PR03CA0592.outlook.office365.com
 (2603:10b6:408:10d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Wed, 1 Dec 2021 10:53:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 1 Dec 2021 10:53:40 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 04:53:38 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 04/11] drm/amdgpu: Modify gmc block to fit for the unified
 ras block data and ops
Date: Wed, 1 Dec 2021 18:52:43 +0800
Message-ID: <20211201105250.298525-4-YiPeng.Chai@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f573d42b-b0a5-48d5-5652-08d9b4b8d617
X-MS-TrafficTypeDiagnostic: BN6PR12MB1554:
X-Microsoft-Antispam-PRVS: <BN6PR12MB15549CFE3741186928C7C080FC689@BN6PR12MB1554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OzAWH5SIrngGln7GxUe4DeTK8s2dGw3Xdw0D9wXTUJg4bcECPuIhVB8/h4EL+f5t1afmUV5NagqVP/7FY9fCmMMBJu6iWzhGkXvN5lnoeuK6k+mG7hK3bv/b8CnnTOCgUpMJ8E3dfWZ0CJv6z1HnpaiZnTb6qBRUh89GUHo9vsWrrl+Kex+3nFiQd/n/LGoZ3ZRfSPA7yJbJhh8NgrcTT5oTv697OGDAFU2BZ0L2RvVUH2GT38uXNR1xDgauOsB1zbjMENRtQM8lW/SS8bhKbYGaaTYDUUAd6fkHkUXVPaxZWo8Ou9xSDh//hT466wfF8JyBoPEzjYjNpFPy18Z9g48HuqH6JDOfno/Y4qHSa0xybauXg4pD82zKeYKxwsOLqgXdXA7J/Z04aHVfSDS22fa6FFbzIwIjQ8KTzKRJ9fPluE0ikdS8QuITRqfukPEXZqCxM7b8PftnVuOYSbDljpfL1u/mkC776m3t3y1vy075HeF57/pf4kM7obNTIYjFOoCq8o4fKxRlSXrujvm0CkmRR95TOeiqKERsd+nDTMGq59HZjjfk7JCYmZEuxdR3NKxdeNQBIak6Zb9qFODs4yUIolCpIZky6qgf8TjeFxShKej+RtVV0euBNQdlIu/+QpeMYAURBh1ka+uqyd6ZPYGVawvp4hNNr8ymgo2+wdx3H5yiT5yTGFy4c0SDjr6gUt8F8tkdtjGn6Vj8FMoPEYxOlFx3g+h1Ki8FpCl7E5HQaE4rBytmMi3Of4/hWCQLG70A71gYMQoF4IvHZ8dF7DB7184D/DpuYcCAG8DcCSAVZzH5g2XPx0grJRX19FcthSHohGda213YsIRjYxUy6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(1076003)(508600001)(81166007)(36860700001)(4326008)(2906002)(36756003)(356005)(7696005)(6916009)(82310400004)(70206006)(40460700001)(47076005)(70586007)(86362001)(336012)(83380400001)(8936002)(5660300002)(2616005)(426003)(26005)(16526019)(54906003)(316002)(8676002)(186003)(6666004)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 10:53:40.4721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f573d42b-b0a5-48d5-5652-08d9b4b8d617
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1554
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

1.Modify gmc block to fit for the unified ras block data and ops
2.Implement .ras_block_match function pointer for gmc block to identify itself.
3.Change amdgpu_xgmi_ras_funcs to amdgpu_xgmi_ras, and the corresponding variable name remove _funcs suffix.
4.Remove the const flag of gmc ras variable so that gmc ras block can be able to be insertted into amdgpu device ras block link list.
5.Invoke amdgpu_ras_register_ras_block function to register gmc ras block into amdgpu device ras block link list.
6.Remove the redundant code about gmc in amdgpu_ras.c after using the unified ras block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 18 ++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  | 11 +++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 10 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 31 +++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h |  4 +--
 5 files changed, 48 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 83f26bca7dac..3ba2f0f1f1b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -448,12 +448,14 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-	if (!adev->gmc.xgmi.connected_to_cpu)
-		adev->gmc.xgmi.ras_funcs = &xgmi_ras_funcs;
+	if (!adev->gmc.xgmi.connected_to_cpu) {
+		adev->gmc.xgmi.ras = &xgmi_ras;
+		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_block);
+	}
 
-	if (adev->gmc.xgmi.ras_funcs &&
-	    adev->gmc.xgmi.ras_funcs->ras_late_init) {
-		r = adev->gmc.xgmi.ras_funcs->ras_late_init(adev);
+	if (adev->gmc.xgmi.ras && adev->gmc.xgmi.ras->ras_block.ops &&
+	    adev->gmc.xgmi.ras->ras_block.ops->ras_late_init) {
+		r = adev->gmc.xgmi.ras->ras_block.ops->ras_late_init(adev);
 		if (r)
 			return r;
 	}
@@ -499,9 +501,9 @@ void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
 	    adev->mmhub.ras_funcs->ras_fini)
 		adev->mmhub.ras_funcs->ras_fini(adev);
 
-	if (adev->gmc.xgmi.ras_funcs &&
-	    adev->gmc.xgmi.ras_funcs->ras_fini)
-		adev->gmc.xgmi.ras_funcs->ras_fini(adev);
+	if (adev->gmc.xgmi.ras && adev->gmc.xgmi.ras->ras_block.ops &&
+	    adev->gmc.xgmi.ras->ras_block.ops->ras_fini)
+		adev->gmc.xgmi.ras->ras_block.ops->ras_fini(adev);
 
 	if (adev->hdp.ras_funcs &&
 	    adev->hdp.ras_funcs->ras_fini)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index e55201134a01..923db5ff5859 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -29,6 +29,7 @@
 #include <linux/types.h>
 
 #include "amdgpu_irq.h"
+#include "amdgpu_ras.h"
 
 /* VA hole for 48bit addresses on Vega10 */
 #define AMDGPU_GMC_HOLE_START	0x0000800000000000ULL
@@ -135,12 +136,8 @@ struct amdgpu_gmc_funcs {
 	unsigned int (*get_vbios_fb_size)(struct amdgpu_device *adev);
 };
 
-struct amdgpu_xgmi_ras_funcs {
-	int (*ras_late_init)(struct amdgpu_device *adev);
-	void (*ras_fini)(struct amdgpu_device *adev);
-	int (*query_ras_error_count)(struct amdgpu_device *adev,
-				     void *ras_error_status);
-	void (*reset_ras_error_count)(struct amdgpu_device *adev);
+struct amdgpu_xgmi_ras {
+	struct amdgpu_ras_block_object ras_block;
 };
 
 struct amdgpu_xgmi {
@@ -159,7 +156,7 @@ struct amdgpu_xgmi {
 	struct ras_common_if *ras_if;
 	bool connected_to_cpu;
 	bool pending_reset;
-	const struct amdgpu_xgmi_ras_funcs *ras_funcs;
+	struct amdgpu_xgmi_ras *ras;
 };
 
 struct amdgpu_gmc {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 190a4a4e9d7a..a6a2f928c6ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -970,9 +970,13 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 			adev->nbio.ras_funcs->query_ras_error_count(adev, &err_data);
 		break;
 	case AMDGPU_RAS_BLOCK__XGMI_WAFL:
-		if (adev->gmc.xgmi.ras_funcs &&
-		    adev->gmc.xgmi.ras_funcs->query_ras_error_count)
-			adev->gmc.xgmi.ras_funcs->query_ras_error_count(adev, &err_data);
+		if (!block_obj || !block_obj->ops)	{
+			dev_info(adev->dev, "%s don't config ras function \n",
+				get_ras_block_str(&info->head));
+			return -EINVAL;
+		}
+		if (block_obj->ops->query_ras_error_count)
+			block_obj->ops->query_ras_error_count(adev, &err_data);
 		break;
 	case AMDGPU_RAS_BLOCK__HDP:
 		if (adev->hdp.ras_funcs &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 0d149f5f000e..da541c7b1ec2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -739,7 +739,7 @@ static int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev)
 	    adev->gmc.xgmi.num_physical_nodes == 0)
 		return 0;
 
-	adev->gmc.xgmi.ras_funcs->reset_ras_error_count(adev);
+	adev->gmc.xgmi.ras->ras_block.ops->reset_ras_error_count(adev);
 
 	if (!adev->gmc.xgmi.ras_if) {
 		adev->gmc.xgmi.ras_if = kmalloc(sizeof(struct ras_common_if), GFP_KERNEL);
@@ -859,7 +859,7 @@ static int amdgpu_xgmi_query_pcs_error_status(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
+static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 					     void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
@@ -868,7 +868,7 @@ static int amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 	uint32_t ue_cnt = 0, ce_cnt = 0;
 
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__XGMI_WAFL))
-		return -EINVAL;
+		return ;
 
 	err_data->ue_count = 0;
 	err_data->ce_count = 0;
@@ -934,17 +934,36 @@ static int amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 		break;
 	}
 
-	adev->gmc.xgmi.ras_funcs->reset_ras_error_count(adev);
+	adev->gmc.xgmi.ras->ras_block.ops->reset_ras_error_count(adev);
 
 	err_data->ue_count += ue_cnt;
 	err_data->ce_count += ce_cnt;
+}
 
-	return 0;
+static int amdgpu_xgmi_ras_block_match(struct amdgpu_ras_block_object* block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index)
+{
+	if(!block_obj)
+		return -EINVAL;
+
+	if(block_obj->block == block) {
+		return 0;
+	}
+
+	return -EINVAL;
 }
 
-const struct amdgpu_xgmi_ras_funcs xgmi_ras_funcs = {
+struct amdgpu_ras_block_ops  xgmi_ras_ops = {
+	.ras_block_match = amdgpu_xgmi_ras_block_match,
 	.ras_late_init = amdgpu_xgmi_ras_late_init,
 	.ras_fini = amdgpu_xgmi_ras_fini,
 	.query_ras_error_count = amdgpu_xgmi_query_ras_error_count,
 	.reset_ras_error_count = amdgpu_xgmi_reset_ras_error_count,
 };
+
+struct amdgpu_xgmi_ras xgmi_ras = {
+	.ras_block = {
+		.name = "xgmi",
+		.block = AMDGPU_RAS_BLOCK__XGMI_WAFL,
+		.ops = &xgmi_ras_ops,
+	}
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index d2189bf7d428..0afca51c3c0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -24,7 +24,7 @@
 
 #include <drm/task_barrier.h>
 #include "amdgpu_psp.h"
-
+#include "amdgpu_ras.h"
 
 struct amdgpu_hive_info {
 	struct kobject kobj;
@@ -50,7 +50,7 @@ struct amdgpu_pcs_ras_field {
 	uint32_t pcs_err_shift;
 };
 
-extern const struct amdgpu_xgmi_ras_funcs xgmi_ras_funcs;
+extern struct amdgpu_xgmi_ras  xgmi_ras;
 struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev);
 void amdgpu_put_xgmi_hive(struct amdgpu_hive_info *hive);
 int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_device *adev);
-- 
2.25.1

