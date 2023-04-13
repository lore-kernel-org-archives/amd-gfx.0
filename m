Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE99C77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 10:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C62C10E205;
	Thu, 13 Apr 2023 10:19:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2067D10E205
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 10:19:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqQcLPxWhWxrBf0IpoN9VHkZt6JBexDJwXLWfKdiloUKjDfxBZPDrAOXUo7ZQDT49goJDwygXCZQUchQgIZcrR+PiCtYGmlePJzP/0BYIW179/gi9VIWW1PBNOJfJbWPxIZPfc38wqX1IXzKrVjB7bDMk6Yxu5qe7J+7vmj1st8yuHfE12jrVWWTslMgbYzH5S1ta9vL+zxOrGh6TKWhZN+P3EXv3z8m4XSFcmUcR1ctdno0ba/7BrP8YUzn1NHlnk8674WbUa8D0fnhxZwnQn8liv/2W1LEQEZX+q2pInFNrKA6EkVNbzhTlISgUevAO2D2ZYd2wUhc1lXlfzq8QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+k2UDL+Khep5UgHSZtzQ+7P0g1upAM0mxhHf2Vq+gs=;
 b=OVTEPQhND3F5ZymbvSbSe9vdfbMF1O3Hx7RM69Hc2sA923FJus+dsr1okYo3o/xIJTHQ7rKoE5NaamZYfIDeBXKJ2KaPmReB14yqO6jYAPrLcS1ogUzg00HS89G+t3r3mTdVrqTIMxag5CB34Sahxwla0eB5FTLr2gNwiLWNoW3mIlFqxKSknOvrcV1b8FuWVhq2Oz1WMAuvXQKzRdvHf4WsQ03b2buLGpYdeM4JCvWAQeBmOc8Q9l7SlIhZakuUEhlk5xl0+n6tq0z2wnRarBPuatxie58PEWxK0KJG23i1Uz6xU0VKqYXvTJwnGcikLkvoHAQb3GhKjzDNX+PUnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+k2UDL+Khep5UgHSZtzQ+7P0g1upAM0mxhHf2Vq+gs=;
 b=mtn8tzYh8N9rgT6cfbor3VLg42tYE2iadHGdUihnrBnPCP9zgh7gc94HpvQwhT9Zop7yjiXFmc1WZ8GzEqh4QN7v9vr4RGFBda513o2RbGxf0hh8y59IwGxOBoff7L+msdBmgMNGJxe1te6tQDEcUGh63ZdLpOx2wmPq0crNtYA=
Received: from CY5PR15CA0098.namprd15.prod.outlook.com (2603:10b6:930:7::7) by
 SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 10:19:51 +0000
Received: from CY4PEPF0000C971.namprd02.prod.outlook.com
 (2603:10b6:930:7:cafe::1f) by CY5PR15CA0098.outlook.office365.com
 (2603:10b6:930:7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.32 via Frontend
 Transport; Thu, 13 Apr 2023 10:19:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C971.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.27 via Frontend Transport; Thu, 13 Apr 2023 10:19:50 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 13 Apr
 2023 05:19:49 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add new flag to AMDGPU_CTX_QUERY2
Date: Thu, 13 Apr 2023 12:18:23 +0200
Message-ID: <20230413101823.80732-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C971:EE_|SJ0PR12MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c6f4ff-b0b3-444b-db7d-08db3c089dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ABN9pwrikqdMsPd4Nz4AGKKnqjZmMOujnD/2omedidq+5Fapvt0nRtCVl1y/5jCuWIAySkRbPVVneof2rNcsuhc/nZPPZ8xNJrxKzKGFpPNoIGf5QVQJVhjzZoVG2a+xf24DN0naUx7y3cAPfZekLAnu9Pd18V31JxxnXK79sKImZmzEe5i1d1zOBcLsrETjggdapkFlRZYmagRqaxmZEwaQIfnHIRamB7ED1YIUwcpnx3ekaL609AeysllHuGCe8D9cr/PvAMij1RXkPn6KsIMHsYCxlf3/ahZDJTxm2U7mIOidtdOZcW3NBceijMGwPOAN/FZ1muwp+Fs/RZTfGyZXEuLxCBK5PHNwubzXSuLUH5VHobXEV7Hcaf/Y12mJsbNF717W98l6dWp5VvWOxc5NScAPEJ1uHo3nRlhj3U2XNRaAEVLLJh2j7GH6FT6fb4o+7apVJfGEQQelgnxCyJ6CPAZeEokdByN2UcnSEfndE36wQHiMn6Fjo/qqysKihR0V5YM531tQzhqyWF2cNBV+1sXTLL/lFdB3bbtJIRikw46SiXNdfhMqBFxX6oum/9PprnB22ocwUqQ0fT3gg0miWhfLbZHzENTgP4YoX5HmI7pZW+5UENsUfRZXPnN5NHvG7bO/wgBmJsZ0En7XqyXg7eJYrdDUbezNr608efCrpdzihHbQYJ95KSHAA4gd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(6666004)(7696005)(40460700003)(966005)(6916009)(70206006)(70586007)(4326008)(36756003)(2906002)(86362001)(81166007)(82740400003)(356005)(41300700001)(5660300002)(82310400005)(8676002)(8936002)(316002)(478600001)(40480700001)(54906003)(1076003)(26005)(336012)(426003)(36860700001)(2616005)(186003)(16526019)(47076005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 10:19:50.6947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c6f4ff-b0b3-444b-db7d-08db3c089dce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C971.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 andrealmeid@igalia.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

OpenGL EXT_robustness extension expects the driver to stop reporting
GUILTY_CONTEXT_RESET when the reset has completed and the GPU is ready
to accept submission again.

This commit adds a AMDGPU_CTX_QUERY2_FLAGS_RESET_IN_PROGRESS flag,
that let the UMD know that the reset is still not finished.

Mesa MR: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/22290

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 include/uapi/drm/amdgpu_drm.h           | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index d2139ac12159..e1f642a3dc2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -576,6 +576,9 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
 	if (atomic_read(&ctx->guilty))
 		out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_GUILTY;
 
+	if (amdgpu_in_reset(adev))
+		out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_RESET_IN_PROGRESS;
+
 	if (adev->ras_enabled && con) {
 		/* Return the cached values in O(1),
 		 * and schedule delayed work to cache
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e652ffb2c68e..223be5d75b8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -111,9 +111,10 @@
  *   3.52.0 - Add AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD, add device_info fields:
  *            tcp_cache_size, num_sqc_per_wgp, sqc_data_cache_size, sqc_inst_cache_size,
  *            gl1c_cache_size, gl2c_cache_size, mall_size, enabled_rb_pipes_mask_hi
+ *   3.53.0 - Add AMDGPU_CTX_QUERY2_FLAGS_RESET_IN_PROGRESS support
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	52
+#define KMS_DRIVER_MINOR	53
 #define KMS_DRIVER_PATCHLEVEL	0
 
 unsigned int amdgpu_vram_limit = UINT_MAX;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index b6eb90df5d05..3d820750c1c9 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -245,6 +245,8 @@ union drm_amdgpu_bo_list {
 /* indicate some errors are detected by RAS */
 #define AMDGPU_CTX_QUERY2_FLAGS_RAS_CE   (1<<3)
 #define AMDGPU_CTX_QUERY2_FLAGS_RAS_UE   (1<<4)
+/* indicate that the reset hasn't completed yet */
+#define AMDGPU_CTX_QUERY2_FLAGS_RESET_IN_PROGRESS (1<<5)
 
 /* Context priority level */
 #define AMDGPU_CTX_PRIORITY_UNSET       -2048
-- 
2.40.0

