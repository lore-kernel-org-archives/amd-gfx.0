Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DBBECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Aug 2022 08:39:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0966810E287;
	Wed, 31 Aug 2022 08:39:48 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 958D010E2B2
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Aug 2022 08:39:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcXPZMYPCGTom3LqmM6COtlcJupkiCkpNrVU3b7wS1gvzK3xurd5gX+cwT619yZ3oYdbR9g5w1dcstgfj37wQcu9tMx36AxjIFf+KtjuDMxfsJCtqQaSKREksAakjfhoDWDvE+gD6XEec+wqFIkbP6KjxmX7xnRXNLnjHdjHkg/9/AO2n6yCS3snvlGN4rRVy/QfJ744RZocKsw+UYyHuVcT7ak/G5/aGWB+5ylWwUdJUDp4BoACPDaRgD2XBEZx4M3N3kHQMgfW78K1FtMwztkD98Zna+YveF9vsMLUoIEbcVbklp5VH4cBZsZtbyObWMWKtveUkZKhthmvGUnmFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJWQZvr+RrVEISs/LzKqxt61bl7HEbxUL8JCLN7CV2U=;
 b=WC9lAb53t/eUnUpfD2tHfGoRh31p2TPbF7yYiJO9+WviMTCyi0wvh+H9VZIxrezBLjZ6eopVX7OQhrWWArN+sDCF86fWHdcjdmSYc9jpRbMieK0ZMmZEbARk2aiCdw+d5wh7sEH0NFWl1+MD13QbpJWQvXqUOwBlKVRMBuv+hmS+LmR0HBymYFZ3p6ww1zT6L8GT1vHqLR75SgOb7szzCLlOGGlDowExyOqvxPAmwZuCNKHQZrwMOyzrgwAMQKcKY3vPgW4+yRhPdcXgWQrOScZL8w12VHweOmyBBZ46aHMEa3VymfKtASd66+Cxoaq8HQOJWqDuR+75xtDPhfFIPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJWQZvr+RrVEISs/LzKqxt61bl7HEbxUL8JCLN7CV2U=;
 b=xg1fgsPVpqd1L6EauCkmG5jsFnM7hK+e/yjdU3LNRTWHWLiuk9p0RAdzLgNYMBHRmP4Th5cBkszSsYh1YqaiO5z91sq+VY35bzs23jsoVoaXuIJrll0xsXsL6sadfzvuLx89LLQ1qa5vuJxIKiA0/Fr0rYqJLmfLJK0nMIfjB+s=
Received: from BN9PR03CA0199.namprd03.prod.outlook.com (2603:10b6:408:f9::24)
 by SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 08:39:40 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::c7) by BN9PR03CA0199.outlook.office365.com
 (2603:10b6:408:f9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Wed, 31 Aug 2022 08:39:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 08:39:39 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 31 Aug
 2022 03:39:36 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <monk.liu@amd.com>, <Victor.Skvortsov@amd.com>,
 <haijun.chang@amd.com>, <Vignesh.Chander@amd.com>, <Gavin.Wan@amd.com>,
 <Shaoyun.Liu@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: support RAS error inject for SRIOV
Date: Wed, 31 Aug 2022 16:39:24 +0800
Message-ID: <20220831083925.1440-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d0a15ff-bff5-4e80-df74-08da8b2c57fb
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6266:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rc1rVlUjEA4iLvfbp82neuh0LOtvStG5d1k/kXlbsJIHxVg01ss7EnwtLx62/tR+xZ4RQKGIyAXV5ojSem7BbXp80JIZuEEU7pAfknNjCA/RoOLbO2IocMs5lQ4VdyIPezLsYXHvPFqZpx89eIvjskO0ay28c0OEE0azDv7Il0qDl5vHhImwwFtjSzjXoUcCnaMWWr1Ne549GbgSUStO3OzSQvDTU3Ce+QnnQeHf5znD2zb/ybTStMjeLECQsvsI/uGcRYC3Ljjb4GAQi5fY/4WvdlTTDOGzPsL3SeyvunWE8MWtjENz/OjWlvXEBVFgrlBC45x4BBrC7kPhvDX0ivVNXUkss3o2seJbohMI8YUjukfp58ylPzKLX8Z4vq5wYi7Dv6sOKgidQ4ZRhvO8vczjTT3kK6OS94jfJZL44XmaWnevQN76SuSymLiuTlAZYo2fq2dD6mkoVM1FGx1nP/pZgLgvSMYgD66HOJYkTONLrxQzKx8oyBOsh0zw7fd6UDsLGCphMugrjgve0TGVGaxtzcARs0dvULDp1Ci/4bhJzgLWO/VECmXAXO16jIAQso0nqDP1O12RB8C6tc/UemJNh/mR0BQEuOLbGXQ6vn/9W/BwUmSiqB4mjFjyfhTECf1Lnp2wL0YNl3JTracgd/Z1IiX1kz9Wml7dHx6xioGo76hrPYYM8un68ynvK+IUoSd5r1Z/S4U/G2DlLj7dUgWKt/SRXFcjL/ox3LXJBIS8G6U7GhPa9sRx2E+kxhSZJdLnxaX8zC5uVGcRS0/R7cP5r1NWT6U+zI8FQJJLBEeixbbJRbLkTWjGMQ0zuQH8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966006)(40470700004)(36840700001)(70206006)(4326008)(70586007)(8676002)(316002)(36756003)(336012)(1076003)(186003)(16526019)(83380400001)(2616005)(5660300002)(2906002)(8936002)(6636002)(110136005)(478600001)(82310400005)(26005)(81166007)(6666004)(7696005)(41300700001)(86362001)(356005)(82740400003)(40460700003)(426003)(47076005)(40480700001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 08:39:39.6667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0a15ff-bff5-4e80-df74-08da8b2c57fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In SRIOV, RAS error injection request will be sent to PF via mailbox, the
injection input information should also be transferred to PF.

Generally, the error injection is operated on PF side directly, but for RAS
poison test, since workload is launched on VF side, VF has to tell PF
about the injection information.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 26 ++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c    | 24 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h    |  9 ++++++++
 4 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ab9ba5a9c33d..498642eb5fb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1103,15 +1103,25 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 							  block_info.address);
 	}
 
-	if (info->head.block == AMDGPU_RAS_BLOCK__GFX) {
-		if (block_obj->hw_ops->ras_error_inject)
-			ret = block_obj->hw_ops->ras_error_inject(adev, info);
+	if (!amdgpu_sriov_vf(adev)) {
+		if (info->head.block == AMDGPU_RAS_BLOCK__GFX) {
+			if (block_obj->hw_ops->ras_error_inject)
+				ret = block_obj->hw_ops->ras_error_inject(adev, info);
+		} else {
+			/* If defined special ras_error_inject(e.g: xgmi), implement special ras_error_inject */
+			if (block_obj->hw_ops->ras_error_inject)
+				ret = block_obj->hw_ops->ras_error_inject(adev, &block_info);
+			else  /*If not defined .ras_error_inject, use default ras_error_inject*/
+				ret = psp_ras_trigger_error(&adev->psp, &block_info);
+		}
 	} else {
-		/* If defined special ras_error_inject(e.g: xgmi), implement special ras_error_inject */
-		if (block_obj->hw_ops->ras_error_inject)
-			ret = block_obj->hw_ops->ras_error_inject(adev, &block_info);
-		else  /*If not defined .ras_error_inject, use default ras_error_inject*/
-			ret = psp_ras_trigger_error(&adev->psp, &block_info);
+		if (adev->virt.ops && adev->virt.ops->ras_trigger_error) {
+			adev->virt.ops->ras_trigger_error(adev, &block_info);
+			ret = 0;
+		} else {
+			dev_warn(adev->dev,
+				"No ras_trigger_error interface in SRIOV!\n");
+		}
 	}
 
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 239f232f9c02..4534e6f70a4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -84,6 +84,8 @@ struct amdgpu_virt_ops {
 	int (*reset_gpu)(struct amdgpu_device *adev);
 	int (*wait_reset)(struct amdgpu_device *adev);
 	void (*trans_msg)(struct amdgpu_device *adev, u32 req, u32 data1, u32 data2, u32 data3);
+	void (*ras_trigger_error)(struct amdgpu_device *adev,
+				struct ta_ras_trigger_error_input *info);
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index a2f04b249132..3b4c5162a237 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -33,6 +33,7 @@
 #include "mxgpu_ai.h"
 
 #include "amdgpu_reset.h"
+#include "ta_ras_if.h"
 
 static void xgpu_ai_mailbox_send_ack(struct amdgpu_device *adev)
 {
@@ -405,6 +406,28 @@ static int xgpu_ai_request_init_data(struct amdgpu_device *adev)
 	return xgpu_ai_send_access_requests(adev, IDH_REQ_GPU_INIT_DATA);
 }
 
+void amdgpu_virt_ras_trigger_error(struct amdgpu_device *adev,
+               struct ta_ras_trigger_error_input *info)
+{
+       uint32_t addr_lo, addr_hi, data1 = 0;
+
+       addr_lo = lower_32_bits(info->address);
+       addr_hi = upper_32_bits(info->address);
+
+       /* block id : bits[0:4], inject_error_type : bits[5:8]
+        * sub_block_index : bits[9:17], value : bits[18:19]
+        */
+       data1 = info->block_id & RAS_BLOCK_ID_MASK;
+       data1 |= (info->inject_error_type & RAS_INJECT_ERROR_TYPE_MASK) <<
+			RAS_INJECT_ERROR_TYPE_SHIFT;
+       data1 |= (info->sub_block_index & RAS_SUB_BLOCK_INDEX_MASK) <<
+			RAS_SUB_BLOCK_INDEX_SHIFT;
+       data1 |= (info->value & RAS_VALUE_MASK) << RAS_VALUE_SHIFT;
+
+       xgpu_ai_mailbox_trans_msg(adev, IDH_RAS_ERROR_INJECT, data1,
+				addr_lo, addr_hi);
+}
+
 const struct amdgpu_virt_ops xgpu_ai_virt_ops = {
 	.req_full_gpu	= xgpu_ai_request_full_gpu_access,
 	.rel_full_gpu	= xgpu_ai_release_full_gpu_access,
@@ -412,4 +435,5 @@ const struct amdgpu_virt_ops xgpu_ai_virt_ops = {
 	.wait_reset = NULL,
 	.trans_msg = xgpu_ai_mailbox_trans_msg,
 	.req_init_data  = xgpu_ai_request_init_data,
+	.ras_trigger_error = amdgpu_virt_ras_trigger_error,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
index fa7e13e0459e..0841d6632328 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
@@ -29,6 +29,14 @@
 #define AI_MAILBOX_POLL_FLR_TIMEDOUT	10000
 #define AI_MAILBOX_POLL_MSG_REP_MAX	11
 
+#define RAS_BLOCK_ID_MASK 0x1f
+#define RAS_INJECT_ERROR_TYPE_MASK 0xf
+#define RAS_INJECT_ERROR_TYPE_SHIFT 5
+#define RAS_SUB_BLOCK_INDEX_MASK 0x1ff
+#define RAS_SUB_BLOCK_INDEX_SHIFT 9
+#define RAS_VALUE_MASK 0x3
+#define RAS_VALUE_SHIFT 18
+
 enum idh_request {
 	IDH_REQ_GPU_INIT_ACCESS = 1,
 	IDH_REL_GPU_INIT_ACCESS,
@@ -39,6 +47,7 @@ enum idh_request {
 
 	IDH_LOG_VF_ERROR       = 200,
 	IDH_READY_TO_RESET 	= 201,
+	IDH_RAS_ERROR_INJECT = 202,
 };
 
 enum idh_event {
-- 
2.35.1

