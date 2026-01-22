Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D454C44500
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 08:58:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D87DA10E952;
	Thu, 22 Jan 2026 08:58:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zXWIVr1t";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013043.outbound.protection.outlook.com
 [40.107.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A980610E952
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 08:58:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIKNJX1DLz6qiU6wth+E6hQVtL6lX0XlYLXw6fLKUPIMGUN6EeMq1GogKk6qKuhPjBvrovg99h8tFQl5NGw5tQWAGfYJBv1uWKe0YlHvHtlssilAibNwtbxPzNNKFsXvMqrpTreH+dRU5QGqlch4HkyBkbwlf6VO1in3ofpMiBl91pcgNOO3l6Un+MOM1JcNVw1fxVt6ZVMabQxyCcOgG96cIYjaKOyHpgeP3s95uuxBBmfN60SbFgNtqu/HKmmUPTRcIHM9ZMVMEW+BlLTxlrSYHaUby7BftEbCst8XarbsIqXt6REha8p8WkZE0PSZFzgZ7L8iH4gmhdWvIrh/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGozuf+4daDIa4SkXgp7g5OJ97m6Wdps+Tf3itU2AY8=;
 b=e+Sry0cT+ZqSQydnxwBWIa9fr3R98gdowWZLu1SZVJSsr6GZ8peCRcnxInPEchS3ibFZfusF3YAuLjtvfWyQ2+rBPYxqvjoRFZeLoKi3F+/g4et4sXGbYtGeESl9nRJiuhMqkZ9vRjD4nIs+fbz2N/a1jvSX8JBN6ohE7TfJc7bTk3nb/Lv7bQGRtYD6Rfon+c7H9fotqsb9dzW/yBF1e2fytFb+rfc1Rji5hZsJc1A9UQHxuSTsyk4ki5+mYpKmPFiesmRkPdYnEP/f7qbqPTQiQHWMbWGDTk5Az7kv/jQxL5E/q/yfmmOh+KTbI/15MvtNSsZxjt0ed2ctAJJKCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGozuf+4daDIa4SkXgp7g5OJ97m6Wdps+Tf3itU2AY8=;
 b=zXWIVr1tK1Kz96Kvs5WlbCZMXuXACuPN2+b12VLWnXT2t3gaqMebb2EcpH3MPaW1UVebPbrGFih0PU5C/ePYr6QnTjFZQWxzOhs8PDQzUzKzgwznqHtX82Mamxlko9zdgoEYHqGcr25S4BVfP25TBzXU0Sg40Cu+OcJ6ZatPLlk=
Received: from BYAPR11CA0073.namprd11.prod.outlook.com (2603:10b6:a03:f4::14)
 by BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 08:58:12 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::d1) by BYAPR11CA0073.outlook.office365.com
 (2603:10b6:a03:f4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 08:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 08:58:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 02:58:10 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 00:58:10 -0800
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 22 Jan 2026 02:58:04 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 4/9] drm/amd/amdgpu/gfx11: Add CU mask and priority support to
 GFX11 compute MQD update
Date: Thu, 22 Jan 2026 16:57:14 +0800
Message-ID: <20260122085738.1542800-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260122085738.1542800-1-Jesse.Zhang@amd.com>
References: <20260122085738.1542800-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|BY5PR12MB4115:EE_
X-MS-Office365-Filtering-Correlation-Id: fc44bc3b-4cdd-4330-4d39-08de59945f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6bcOEx97Z1ZkXzLLVqwxRkHwpOC2zDdaw712sG83Y+qbHzb5+Rq+rXJ/NEz/?=
 =?us-ascii?Q?+rf24wCnHzXW4CUjPLn0aoOriDfqpyBAVQb1hU05LB4wEFZTCPqIptlAWSL6?=
 =?us-ascii?Q?TUT7RCbMgyKHxf/CIS/xh954wG8TmFFTBmCyeGZAdeRw+WnWhjNew2w+MjXw?=
 =?us-ascii?Q?GSAc3iQm0GP/gAOzNkc/1bpr1Bsxn0yA0oAafLKLfO6LyWDilMNuAQuGqCPk?=
 =?us-ascii?Q?ltj1wcopWRxVkUcfF9PEBN4jYxFapSRIuhc+mWdl6KQG74SQXglOOtff7CTD?=
 =?us-ascii?Q?5Oo3Mjpl0Zk5zL86Twj+8p9P6g93puGPr/AF1Qzv8dpfn+Kp4F2LxULYYZQU?=
 =?us-ascii?Q?JuiydZsnzvlFxSkJElriPZN85PZSyNAsHw6Kaoq8VmR3Y2iSmB5vhKgc0Ebb?=
 =?us-ascii?Q?RXiR1Xr9nQW/fPAdavRW3GHiPEPgXY6elvMoa18NQV8i4y40Y84lT+teFSHg?=
 =?us-ascii?Q?WnFF3AxdudD4jYUQCTIrQTNReAq497Bm5CJ6cYezGTk2cVdhnUf40MUIJPTM?=
 =?us-ascii?Q?3BrU5CjfWrXTOSrCY4Dm5xZqhtKK7D8efTsYbS7OooTAQNtdyoIGASQhDROh?=
 =?us-ascii?Q?i9IhIjnOqrkG/1suCbgPQ0TSi53hgBqmrO4LPVdz3bXiA2hnM6a5EDn2vbNN?=
 =?us-ascii?Q?GJnC3dw/WnrPyeBX8SXXnM93N+YMRBf66vGsgYUCmXaVGe3kwiL2b4pAK0cu?=
 =?us-ascii?Q?p1RcJmoO2pnTbJDk3i8+yh66te6S4zetM+5CEsK3aVq7dC9qYWhMUjOwuCqN?=
 =?us-ascii?Q?I6ogwLSOVtD2OA5V7tVyFM01YNGiVVPQcScr91mQzFEpFW5ZCfC2vdiKQE35?=
 =?us-ascii?Q?KFrRguWZD/ONbB+/ik55Qn2KY5PohtaBY0/0bu3YG/OaKO7ckw0J4qunpSGG?=
 =?us-ascii?Q?11TLzCqurh6MU//IawnKK6g6PNxGkS2Sjemzgsui7hALOn+IfgCwZM6tQ3Mp?=
 =?us-ascii?Q?uziUC00Wcmte+rd75It5BJBD9xcqGH3//D3Qcki8XSokqhRagJU2nVKXNi9h?=
 =?us-ascii?Q?XeFjUJETSE7ZGQ9Xu28pFGzGgByjAEQdjCiC4Mswnx9U+IYeObM2U4FVHkW8?=
 =?us-ascii?Q?OooO2QjzOgp80T06La18yzKb6VV5YP4afGowONvsOaPv1pDDpBS+wJ/DWi+3?=
 =?us-ascii?Q?2VASTUiTM0Ct/tOoCebqFG6wuYqLAdoUyxH85qmeoJvQMyWvXpxXuAzkVDBV?=
 =?us-ascii?Q?XqTxQNsIRx3nfCrsE+cmOUAAH47s13lfOZZE116R9E8z2jjOodNNEPgMlYv1?=
 =?us-ascii?Q?EtSromMB2fb5GbPn9Uv8k73OwDGFG6ZsXBDVNuKnFy7BhrQsQMiv3a4BJ+zW?=
 =?us-ascii?Q?5eVx8pdDabh4C8RP8WylpVmbgtaiSewQ4J1U3zphqJ5ha4xaAUSOZsVzye+Y?=
 =?us-ascii?Q?NNVNgJ1FxX8ZpnKa7xL6z47DzMV+CbiPH4kFFkfsTEquMhHK6IqidEbHR7y7?=
 =?us-ascii?Q?98d9VyuCdIKvUMmBanPzc9sezCMLs1v6klA7EJe/vFOtPml2E4EMLFPSKJxq?=
 =?us-ascii?Q?PYXkdyPYwuMv3F2lb2fI7Z8oka/upd97WIz5sEnOAkOJgF3LN4qopdqJTSi+?=
 =?us-ascii?Q?vMmvTwfmgkaWSOkAKwXdxHNkc5rr1iUu/0n28RLsEe6wpQphW02JneU+piEb?=
 =?us-ascii?Q?zZ49FdMKX26CfrXSQfh6FvxfToaYn5utDnywqSX/IDsoazSv9UxVii0jZfPC?=
 =?us-ascii?Q?ERABAQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 08:58:11.9009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc44bc3b-4cdd-4330-4d39-08de59945f32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4115
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- Extend amdgpu_mqd_prop with CU mask fields and debug WA flags
- Implement GFX11 CU mask mapping (WGP mode) and MQD setters for CU mask/priority
- Integrate setters into gfx_v11_0_compute_mqd_update() to apply runtime changes

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h    |  4 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 82 ++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 64e69f0f9a02..246d74205b48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -809,6 +809,10 @@ struct amdgpu_mqd_prop {
 	uint64_t fence_address;
 	bool tmz_queue;
 	bool kernel_queue;
+	uint32_t *cu_mask;
+	uint32_t cu_mask_count;
+	uint32_t cu_flags;
+	bool is_user_cu_masked;
 };
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a47c91d33846..d807d77c56b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4238,6 +4238,87 @@ static int gfx_v11_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 	return gfx_v11_0_cp_gfx_start(adev);
 }
 
+static void gfx_v11_0_mqd_symmetrically_map_cu_mask(struct amdgpu_device *adev,
+						    const uint32_t *cu_mask,
+						    uint32_t cu_mask_count,
+						    uint32_t *se_mask)
+{
+	struct amdgpu_cu_info *cu_info = &adev->gfx.cu_info;
+	struct amdgpu_gfx_config *gfx_info = &adev->gfx.config;
+	uint32_t cu_per_sh[8][4] = {0};
+	int i, se, sh, cu, cu_bitmap_sh_mul;
+	int xcc_inst = ffs(adev->gfx.xcc_mask) - 1;
+	int cu_inc = 2; /* WGP mode */
+	int num_xcc, inc, inst = 0;
+	uint32_t en_mask = 3;
+
+	if (xcc_inst < 0)
+		xcc_inst = 0;
+
+	num_xcc = hweight16(adev->gfx.xcc_mask);
+	if (!num_xcc)
+		num_xcc = 1;
+
+	inc = cu_inc * num_xcc;
+
+	cu_bitmap_sh_mul = 2;
+
+	for (se = 0; se < gfx_info->max_shader_engines; se++)
+		for (sh = 0; sh < gfx_info->max_sh_per_se; sh++)
+			cu_per_sh[se][sh] = hweight32(
+				cu_info->bitmap[xcc_inst][se % 4][sh + (se / 4) *
+				cu_bitmap_sh_mul]);
+
+	for (i = 0; i < gfx_info->max_shader_engines; i++)
+		se_mask[i] = 0;
+
+	i = inst;
+	for (cu = 0; cu < 16; cu += cu_inc) {
+		for (sh = 0; sh < gfx_info->max_sh_per_se; sh++) {
+			for (se = 0; se < gfx_info->max_shader_engines; se++) {
+				if (cu_per_sh[se][sh] > cu) {
+					if ((i / 32) < cu_mask_count && (cu_mask[i / 32] & (1 << (i % 32))))
+						se_mask[se] |= en_mask << (cu + sh * 16);
+					i += inc;
+					if (i >= cu_mask_count * 32)
+						return;
+				}
+			}
+		}
+	}
+}
+
+static void gfx_v11_0_compute_mqd_set_cu_mask(struct amdgpu_device *adev,
+					      struct v11_compute_mqd *mqd,
+					      struct amdgpu_mqd_prop *prop)
+{
+	uint32_t se_mask[8] = {0};
+	uint32_t wa_mask;
+	bool has_wa_flag = prop->cu_flags & (AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE |
+					  AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE);
+
+	if (!has_wa_flag && (!prop->cu_mask || !prop->cu_mask_count))
+		return;
+
+	if (has_wa_flag) {
+		wa_mask = (prop->cu_flags & AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE) ?
+			  0xffff : 0xffffffff;
+		mqd->compute_static_thread_mgmt_se0 = wa_mask;
+		mqd->compute_static_thread_mgmt_se1 = wa_mask;
+		mqd->compute_static_thread_mgmt_se2 = wa_mask;
+		mqd->compute_static_thread_mgmt_se3 = wa_mask;
+		return;
+	}
+
+	gfx_v11_0_mqd_symmetrically_map_cu_mask(adev, prop->cu_mask,
+						prop->cu_mask_count, se_mask);
+
+	mqd->compute_static_thread_mgmt_se0 = se_mask[0];
+	mqd->compute_static_thread_mgmt_se1 = se_mask[1];
+	mqd->compute_static_thread_mgmt_se2 = se_mask[2];
+	mqd->compute_static_thread_mgmt_se3 = se_mask[3];
+}
+
 /**
  * gfx_v11_0_compute_update_queue - Update runtime-configurable queue parameters
  * @adev: amdgpu device pointer
@@ -4278,6 +4359,7 @@ static int gfx_v11_0_compute_mqd_update(struct amdgpu_device *adev, void *m,
 	mqd->cp_hqd_queue_priority = prop->hqd_queue_priority;
 
 	mqd->cp_hqd_active = prop->hqd_active;
+	gfx_v11_0_compute_mqd_set_cu_mask(adev, mqd, prop);
 
 	return 0;
 }
-- 
2.49.0

