Return-Path: <SRS0=/zhQ=I7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E38C433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Apr 2021 06:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C5A6610CB
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Apr 2021 06:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5A6610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41F296EE10;
	Fri,  2 Apr 2021 06:44:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F6EA6EE10
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Apr 2021 06:44:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJ34VKeqR3tb0cSeOKBhrXBVdX3Mccs31jxOMVqi7QQD1nXn3NUlanR4bN0xT4Rg6DfpGcULbgG6Uv4LHkDw1S8Iv8ESWaoG5gf1zLoa/+U/cesSduZ9X2KOIIcIu1+ClcPSeVXrC75iWEifRfFlwfFbt9lpfJ6pBA9x611T5rbiZaVpkbtNKKZxiH5LU7TyD6N2OH9ahIFdX2F1nleevIGycpC7YLThlVvsJGk99UpoYAvORPNEXoU1Td8xBgn2aCU+SxHLvYLHrxgxRp0PnqV9/2d4rlIYxEFg66DQ6iWuLW5+I+Mznuo8OW6DH8couqYQnfgmWaM28MV70vmQsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sa47ZTqf+UAUHNC2ldFH4J79+NXNJGuOc/WYDU8/iXw=;
 b=g4FXke3HUkFflT74I+lqZxzTOIgaRt56uFm41pUnrc9zPs0FuKFK0Gp5DtJgauHdX6WVE33N52imi/vWl9q0RVR8Ti1qTqcl5QNOLXxRLhD5SsPMrga9sIZ0vXotpN8OpLeq0078R+2zwKILaJHytcvpMvati6Kkt5vngLB8Sr165LCQn3f5PlJjU2jusN54AXGi2bCc1RSLYAtk+22Hx3LZZp8Ct+vHEsx3QqWmcP2JdY5JYVEnd62ErcdNGT7U4rVJ4AAJxv5eLoYuwmLymqA+wLVLc8qs9rmZ6w5bGLuhUdeal5fRP2ikatk9mLPMHY4J4uxu4MQDZPtrLycafQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sa47ZTqf+UAUHNC2ldFH4J79+NXNJGuOc/WYDU8/iXw=;
 b=IYEfig0c840vi3NUq1sUr+DezdhsOs4/rPrAQ0n92UkpLd8d4aN5S+5LEXzOslVDWXoqoVAFLmQi2lwqzMqbhz2EMDsQXCQ5njfcl/m5tI8kFPJD1baPLhYtPXK9gMzr5IQdxqB5DvwsFbES/dQBEHwzT9F82zGoP2dnV2QwoVU=
Received: from DM5PR20CA0048.namprd20.prod.outlook.com (2603:10b6:3:13d::34)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Fri, 2 Apr
 2021 06:44:19 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::dd) by DM5PR20CA0048.outlook.office365.com
 (2603:10b6:3:13d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend
 Transport; Fri, 2 Apr 2021 06:44:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Fri, 2 Apr 2021 06:44:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 2 Apr 2021
 01:44:17 -0500
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 2 Apr 2021 01:44:16 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, John Clements <John.Clements@amd.com>,
 Dennis Li <Dennis.Li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/11] drm/amdgpu: split gfx callbacks into ras and non-ras
 ones
Date: Fri, 2 Apr 2021 14:43:45 +0800
Message-ID: <20210402064345.14093-11-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210402064345.14093-1-Hawking.Zhang@amd.com>
References: <20210402064345.14093-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a020f66-b80e-47e8-39c1-08d8f5a2bdda
X-MS-TrafficTypeDiagnostic: MN2PR12MB4111:
X-Microsoft-Antispam-PRVS: <MN2PR12MB41119A61F2A024969BDC7BF1FC7A9@MN2PR12MB4111.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:316;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hxnL9XlVGgJJU8VrdjWKeJV8Y3HuC3w2ENf5at/cmpBBvfY6pqHWzqtRAwgwGV3lEnSKyqtON1kvY1pQcGLxdcI11MRLospFmLcW0WYkPwu+WW6/6gKDKx2DPNZjOMWeShH5MHLo2eSobPB1gDBWqgAGChoe4xVBqYIiZz1rBrWCcc/EkfXSy90Z5bl22s17YlNixqx55sMKmnBY+OKH5G6Pmqzl3SA6ieQSPUabZDgHL5j7tmYX9+qUwTXR9jqyxv7LrKaoPkhn8tOnuvtIhXvL9t8Rgb0piM8cDMIL1mKzDbvheJkuQLqp9vfQDyHkpEVzzFskBNkkRZ3NkwYRgNgHe5qpEpjkJ4RnF1syjQ5zUx2HJF/iSJ0xgebQlznQHiqqO9SdcpXl6V2ZHwsgGd+RVkRdkvK+oH3JkGircq4KKXPqJTpuHfDjh7Tk/CDgXMbUCbgX/n9HHF65/GFTPnhoP3K1CNLn6pF4BI/NsNPYylU8b1IsPAbN5KrUUyeWgC5Qr0mdHFycAajZ47dexmZ6fzi+Zg4GmrH+weMi8CqUqhUmMpsshOCsaFGwl9hlZedYvwo9M5sZ4/CGYsG1uM3UuSLnycTWpTG5HXjs+XDgjZPTvAPHy/+HWBR7QVPXCNkP4qdDPJQ99DiNv28eHbmNaQ/MI51qGFqNu5ktQKxJG+VzOYz/0giXgzeY+AxX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966006)(36840700001)(82310400003)(356005)(5660300002)(26005)(81166007)(36756003)(110136005)(186003)(83380400001)(4326008)(86362001)(70206006)(70586007)(8936002)(478600001)(2616005)(8676002)(2906002)(316002)(6636002)(1076003)(36860700001)(30864003)(426003)(6666004)(7696005)(82740400003)(336012)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 06:44:19.0708 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a020f66-b80e-47e8-39c1-08d8f5a2bdda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

gfx ras is only available in cerntain ip generations.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reivewed-by: Dennis Li <Dennis.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 22 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 30 ++++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 68 ++++++++++---------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c   | 20 ++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h   | 12 +----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 13 ++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h |  9 +---
 8 files changed, 92 insertions(+), 87 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 12e8b527776b..95d4f43a03df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -677,8 +677,9 @@ int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
 	 */
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX)) {
 		kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
-		if (adev->gfx.funcs->query_ras_error_count)
-			adev->gfx.funcs->query_ras_error_count(adev, err_data);
+		if (adev->gfx.ras_funcs &&
+		    adev->gfx.ras_funcs->query_ras_error_count)
+			adev->gfx.ras_funcs->query_ras_error_count(adev, err_data);
 		amdgpu_ras_reset_gpu(adev);
 	}
 	return AMDGPU_RAS_SUCCESS;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 38af93f501e1..d43fe2ed8116 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -205,6 +205,19 @@ struct amdgpu_cu_info {
 	uint32_t bitmap[4][4];
 };
 
+struct amdgpu_gfx_ras_funcs {
+	int (*ras_late_init)(struct amdgpu_device *adev);
+	void (*ras_fini)(struct amdgpu_device *adev);
+	int (*ras_error_inject)(struct amdgpu_device *adev,
+				void *inject_if);
+	int (*query_ras_error_count)(struct amdgpu_device *adev,
+				     void *ras_error_status);
+	void (*reset_ras_error_count)(struct amdgpu_device *adev);
+	void (*query_ras_error_status)(struct amdgpu_device *adev);
+	void (*reset_ras_error_status)(struct amdgpu_device *adev);
+	void (*enable_watchdog_timer)(struct amdgpu_device *adev);
+};
+
 struct amdgpu_gfx_funcs {
 	/* get the gpu clock counter */
 	uint64_t (*get_gpu_clock_counter)(struct amdgpu_device *adev);
@@ -220,14 +233,8 @@ struct amdgpu_gfx_funcs {
 				uint32_t *dst);
 	void (*select_me_pipe_q)(struct amdgpu_device *adev, u32 me, u32 pipe,
 				 u32 queue, u32 vmid);
-	int (*ras_error_inject)(struct amdgpu_device *adev, void *inject_if);
-	int (*query_ras_error_count) (struct amdgpu_device *adev, void *ras_error_status);
-	void (*reset_ras_error_count) (struct amdgpu_device *adev);
 	void (*init_spm_golden)(struct amdgpu_device *adev);
-	void (*query_ras_error_status) (struct amdgpu_device *adev);
-	void (*reset_ras_error_status) (struct amdgpu_device *adev);
 	void (*update_perfmon_mgcg)(struct amdgpu_device *adev, bool enable);
-	void (*enable_watchdog_timer)(struct amdgpu_device *adev);
 };
 
 struct sq_work {
@@ -330,7 +337,8 @@ struct amdgpu_gfx {
 	DECLARE_BITMAP			(pipe_reserve_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
 
 	/*ras */
-	struct ras_common_if		*ras_if;
+	struct ras_common_if			*ras_if;
+	const struct amdgpu_gfx_ras_funcs	*ras_funcs;
 };
 
 #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b55f470eb747..1d905bcbc1ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -792,11 +792,13 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		}
 		break;
 	case AMDGPU_RAS_BLOCK__GFX:
-		if (adev->gfx.funcs->query_ras_error_count)
-			adev->gfx.funcs->query_ras_error_count(adev, &err_data);
+		if (adev->gfx.ras_funcs &&
+		    adev->gfx.ras_funcs->query_ras_error_count)
+			adev->gfx.ras_funcs->query_ras_error_count(adev, &err_data);
 
-		if (adev->gfx.funcs->query_ras_error_status)
-			adev->gfx.funcs->query_ras_error_status(adev);
+		if (adev->gfx.ras_funcs &&
+		    adev->gfx.ras_funcs->query_ras_error_status)
+			adev->gfx.ras_funcs->query_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__MMHUB:
 		if (adev->mmhub.ras_funcs &&
@@ -852,11 +854,13 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 
 	switch (block) {
 	case AMDGPU_RAS_BLOCK__GFX:
-		if (adev->gfx.funcs->reset_ras_error_count)
-			adev->gfx.funcs->reset_ras_error_count(adev);
+		if (adev->gfx.ras_funcs &&
+		    adev->gfx.ras_funcs->reset_ras_error_count)
+			adev->gfx.ras_funcs->reset_ras_error_count(adev);
 
-		if (adev->gfx.funcs->reset_ras_error_status)
-			adev->gfx.funcs->reset_ras_error_status(adev);
+		if (adev->gfx.ras_funcs &&
+		    adev->gfx.ras_funcs->reset_ras_error_status)
+			adev->gfx.ras_funcs->reset_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__MMHUB:
 		if (adev->mmhub.ras_funcs &&
@@ -926,8 +930,9 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 
 	switch (info->head.block) {
 	case AMDGPU_RAS_BLOCK__GFX:
-		if (adev->gfx.funcs->ras_error_inject)
-			ret = adev->gfx.funcs->ras_error_inject(adev, info);
+		if (adev->gfx.ras_funcs &&
+		    adev->gfx.ras_funcs->ras_error_inject)
+			ret = adev->gfx.ras_funcs->ras_error_inject(adev, info);
 		else
 			ret = -EINVAL;
 		break;
@@ -1514,8 +1519,9 @@ static void amdgpu_ras_error_status_query(struct amdgpu_device *adev,
 	 */
 	switch (info->head.block) {
 	case AMDGPU_RAS_BLOCK__GFX:
-		if (adev->gfx.funcs->query_ras_error_status)
-			adev->gfx.funcs->query_ras_error_status(adev);
+		if (adev->gfx.ras_funcs &&
+		    adev->gfx.ras_funcs->query_ras_error_status)
+			adev->gfx.ras_funcs->query_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__MMHUB:
 		if (adev->mmhub.ras_funcs &&
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 6e49b239087a..2111e4c46a52 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2089,45 +2089,22 @@ static void gfx_v9_0_select_me_pipe_q(struct amdgpu_device *adev,
 }
 
 static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs = {
-	.get_gpu_clock_counter = &gfx_v9_0_get_gpu_clock_counter,
-	.select_se_sh = &gfx_v9_0_select_se_sh,
-	.read_wave_data = &gfx_v9_0_read_wave_data,
-	.read_wave_sgprs = &gfx_v9_0_read_wave_sgprs,
-	.read_wave_vgprs = &gfx_v9_0_read_wave_vgprs,
-	.select_me_pipe_q = &gfx_v9_0_select_me_pipe_q,
+        .get_gpu_clock_counter = &gfx_v9_0_get_gpu_clock_counter,
+        .select_se_sh = &gfx_v9_0_select_se_sh,
+        .read_wave_data = &gfx_v9_0_read_wave_data,
+        .read_wave_sgprs = &gfx_v9_0_read_wave_sgprs,
+        .read_wave_vgprs = &gfx_v9_0_read_wave_vgprs,
+        .select_me_pipe_q = &gfx_v9_0_select_me_pipe_q,
+};
+
+static const struct amdgpu_gfx_ras_funcs gfx_v9_0_ras_funcs = {
+	.ras_late_init = amdgpu_gfx_ras_late_init,
+	.ras_fini = amdgpu_gfx_ras_fini,
 	.ras_error_inject = &gfx_v9_0_ras_error_inject,
 	.query_ras_error_count = &gfx_v9_0_query_ras_error_count,
 	.reset_ras_error_count = &gfx_v9_0_reset_ras_error_count,
 };
 
-static const struct amdgpu_gfx_funcs gfx_v9_4_gfx_funcs = {
-	.get_gpu_clock_counter = &gfx_v9_0_get_gpu_clock_counter,
-	.select_se_sh = &gfx_v9_0_select_se_sh,
-	.read_wave_data = &gfx_v9_0_read_wave_data,
-	.read_wave_sgprs = &gfx_v9_0_read_wave_sgprs,
-	.read_wave_vgprs = &gfx_v9_0_read_wave_vgprs,
-	.select_me_pipe_q = &gfx_v9_0_select_me_pipe_q,
-	.ras_error_inject = &gfx_v9_4_ras_error_inject,
-	.query_ras_error_count = &gfx_v9_4_query_ras_error_count,
-	.reset_ras_error_count = &gfx_v9_4_reset_ras_error_count,
-	.query_ras_error_status = &gfx_v9_4_query_ras_error_status,
-};
-
-static const struct amdgpu_gfx_funcs gfx_v9_4_2_gfx_funcs = {
-	.get_gpu_clock_counter = &gfx_v9_0_get_gpu_clock_counter,
-	.select_se_sh = &gfx_v9_0_select_se_sh,
-	.read_wave_data = &gfx_v9_0_read_wave_data,
-	.read_wave_sgprs = &gfx_v9_0_read_wave_sgprs,
-	.read_wave_vgprs = &gfx_v9_0_read_wave_vgprs,
-	.select_me_pipe_q = &gfx_v9_0_select_me_pipe_q,
-	.ras_error_inject = &gfx_v9_4_2_ras_error_inject,
-	.query_ras_error_count = &gfx_v9_4_2_query_ras_error_count,
-	.reset_ras_error_count = &gfx_v9_4_2_reset_ras_error_count,
-	.query_ras_error_status = &gfx_v9_4_2_query_ras_error_status,
-	.reset_ras_error_status = &gfx_v9_4_2_reset_ras_error_status,
-	.enable_watchdog_timer = &gfx_v9_4_2_enable_watchdog_timer,
-};
-
 static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 {
 	u32 gb_addr_config;
@@ -2154,6 +2131,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 		DRM_INFO("fix gfx.config for vega12\n");
 		break;
 	case CHIP_VEGA20:
+		adev->gfx.ras_funcs = &gfx_v9_0_ras_funcs;
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -2179,7 +2157,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 			gb_addr_config = RAVEN_GB_ADDR_CONFIG_GOLDEN;
 		break;
 	case CHIP_ARCTURUS:
-		adev->gfx.funcs = &gfx_v9_4_gfx_funcs;
+		adev->gfx.ras_funcs = &gfx_v9_4_ras_funcs;
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -2200,7 +2178,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 		gb_addr_config |= 0x22010042;
 		break;
 	case CHIP_ALDEBARAN:
-		adev->gfx.funcs = &gfx_v9_4_2_gfx_funcs;
+		adev->gfx.ras_funcs = &gfx_v9_4_2_ras_funcs;
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -2433,7 +2411,9 @@ static int gfx_v9_0_sw_fini(void *handle)
 	int i;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	amdgpu_gfx_ras_fini(adev);
+	if (adev->gfx.ras_funcs &&
+	    adev->gfx.ras_funcs->ras_fini)
+		adev->gfx.ras_funcs->ras_fini(adev);
 
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
@@ -4752,12 +4732,16 @@ static int gfx_v9_0_ecc_late_init(void *handle)
 	if (r)
 		return r;
 
-	r = amdgpu_gfx_ras_late_init(adev);
-	if (r)
-		return r;
+	if (adev->gfx.ras_funcs &&
+	    adev->gfx.ras_funcs->ras_late_init) {
+		r = adev->gfx.ras_funcs->ras_late_init(adev);
+		if (r)
+			return r;
+	}
 
-	if (adev->gfx.funcs->enable_watchdog_timer)
-		adev->gfx.funcs->enable_watchdog_timer(adev);
+	if (adev->gfx.ras_funcs &&
+	    adev->gfx.ras_funcs->enable_watchdog_timer)
+		adev->gfx.ras_funcs->enable_watchdog_timer(adev);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
index bc699d680ce8..830080ff90d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
@@ -863,8 +863,8 @@ static int gfx_v9_4_ras_error_count(struct amdgpu_device *adev,
 	return 0;
 }
 
-int gfx_v9_4_query_ras_error_count(struct amdgpu_device *adev,
-				   void *ras_error_status)
+static int gfx_v9_4_query_ras_error_count(struct amdgpu_device *adev,
+					  void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 	uint32_t sec_count = 0, ded_count = 0;
@@ -906,7 +906,7 @@ int gfx_v9_4_query_ras_error_count(struct amdgpu_device *adev,
 	return 0;
 }
 
-void gfx_v9_4_reset_ras_error_count(struct amdgpu_device *adev)
+static void gfx_v9_4_reset_ras_error_count(struct amdgpu_device *adev)
 {
 	int i, j, k;
 
@@ -971,7 +971,8 @@ void gfx_v9_4_reset_ras_error_count(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, mmATC_L2_CACHE_4K_DSM_INDEX, 255);
 }
 
-int gfx_v9_4_ras_error_inject(struct amdgpu_device *adev, void *inject_if)
+static int gfx_v9_4_ras_error_inject(struct amdgpu_device *adev,
+				     void *inject_if)
 {
 	struct ras_inject_if *info = (struct ras_inject_if *)inject_if;
 	int ret;
@@ -996,7 +997,7 @@ int gfx_v9_4_ras_error_inject(struct amdgpu_device *adev, void *inject_if)
 static const struct soc15_reg_entry gfx_v9_4_rdrsp_status_regs =
 	{ SOC15_REG_ENTRY(GC, 0, mmGCEA_ERR_STATUS), 0, 1, 32 };
 
-void gfx_v9_4_query_ras_error_status(struct amdgpu_device *adev)
+static void gfx_v9_4_query_ras_error_status(struct amdgpu_device *adev)
 {
 	uint32_t i, j;
 	uint32_t reg_value;
@@ -1021,3 +1022,12 @@ void gfx_v9_4_query_ras_error_status(struct amdgpu_device *adev)
 	gfx_v9_4_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
 	mutex_unlock(&adev->grbm_idx_mutex);
 }
+
+const struct amdgpu_gfx_ras_funcs gfx_v9_4_ras_funcs = {
+        .ras_late_init = amdgpu_gfx_ras_late_init,
+        .ras_fini = amdgpu_gfx_ras_fini,
+        .ras_error_inject = &gfx_v9_4_ras_error_inject,
+        .query_ras_error_count = &gfx_v9_4_query_ras_error_count,
+        .reset_ras_error_count = &gfx_v9_4_reset_ras_error_count,
+        .query_ras_error_status = &gfx_v9_4_query_ras_error_status,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
index 875f18473a98..bdd16b568021 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
@@ -24,16 +24,6 @@
 #ifndef __GFX_V9_4_H__
 #define __GFX_V9_4_H__
 
-void gfx_v9_4_clear_ras_edc_counter(struct amdgpu_device *adev);
-
-int gfx_v9_4_query_ras_error_count(struct amdgpu_device *adev,
-				   void *ras_error_status);
-
-int gfx_v9_4_ras_error_inject(struct amdgpu_device *adev,
-				     void *inject_if);
-
-void gfx_v9_4_reset_ras_error_count(struct amdgpu_device *adev);
-
-void gfx_v9_4_query_ras_error_status(struct amdgpu_device *adev);
+extern const struct amdgpu_gfx_ras_funcs gfx_v9_4_ras_funcs;
 
 #endif /* __GFX_V9_4_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 2e94998c9812..9ca76a3ac38c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -1283,4 +1283,15 @@ static void gfx_v9_4_2_reset_sq_timeout_status(struct amdgpu_device *adev)
 	}
 	gfx_v9_4_2_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
 	mutex_unlock(&adev->grbm_idx_mutex);
-}
\ No newline at end of file
+}
+
+const struct amdgpu_gfx_ras_funcs gfx_v9_4_2_ras_funcs = {
+	.ras_late_init = amdgpu_gfx_ras_late_init,
+	.ras_fini = amdgpu_gfx_ras_fini,
+	.ras_error_inject = &gfx_v9_4_2_ras_error_inject,
+	.query_ras_error_count = &gfx_v9_4_2_query_ras_error_count,
+	.reset_ras_error_count = &gfx_v9_4_2_reset_ras_error_count,
+	.query_ras_error_status = &gfx_v9_4_2_query_ras_error_status,
+	.reset_ras_error_status = &gfx_v9_4_2_reset_ras_error_status,
+	.enable_watchdog_timer = &gfx_v9_4_2_enable_watchdog_timer,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
index c143d178ef98..81c5833b6b9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
@@ -30,11 +30,6 @@ void gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
 				      uint32_t die_id);
 void gfx_v9_4_2_set_power_brake_sequence(struct amdgpu_device *adev);
 
-void gfx_v9_4_2_reset_ras_error_count(struct amdgpu_device *adev);
-int gfx_v9_4_2_ras_error_inject(struct amdgpu_device *adev, void *inject_if);
-void gfx_v9_4_2_query_ras_error_status(struct amdgpu_device *adev);
-int gfx_v9_4_2_query_ras_error_count(struct amdgpu_device *adev,
-				   void *ras_error_status);
-void gfx_v9_4_2_reset_ras_error_status(struct amdgpu_device *adev);
-void gfx_v9_4_2_enable_watchdog_timer(struct amdgpu_device *adev);
+extern const struct amdgpu_gfx_ras_funcs gfx_v9_4_2_ras_funcs;
+
 #endif /* __GFX_V9_4_2_H__ */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
