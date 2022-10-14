Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8634C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Oct 2022 07:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73EB910E388;
	Fri, 14 Oct 2022 07:23:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 412D010E9C5
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 07:23:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSbwuQtNjOaRsGeGrJIsJKJps6svAYARSQznUawLFIXGtofKa2HhS01+9m9VG+8xnjpFFKcFory6ACY6M4i6+5jUR4vIcEFbmdWYhhmRyFebu2UwPjbj3LKBxhQues6VSnreQUnC594F4rYA5muwIiMDqrgHht09uw33CK7i4DRQn6du2ir/+60TmVRJuJZCZkG7RCUomuswB7HLRYqBBp3LomqKTe2fA7DvPhceWadnpMDMmltYT6D4ZsDTznr9zza4UJpIUVS5eu1F7ixxiOx/fgS8HCysgXR0tuFJNXQ4supIUPvY3GhFQknf3cjvBhXQYywdi1pgujqfSpTI1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKy9sAPaKqaE0IAThcry9F+AFOrIs1RXfuY1tB4IiC0=;
 b=d0NIbsFyu1tIFVc9p0qwF5akGYwgVFScu81FPtUTm4z8U0Ek4CsKpgW6Rc2brTTvo1Rq3q/VXMsuAh0NVIm0IYrxbQo/ZFlwRhcKl9LYzDDy3xSNPwyh9graVprllJpScoH8IbFDYHDOQhwbXT62v9A4rIfDCdUpwRgg1N9xj7zXpsD/+oh5T6UWZ/7AKkjWPpCHUPDcxH2apL4NwUnfEZBv1dSLFTkzBi0kOj2e2gBZlUA/IMnWJeqmvteXQcH4da6Q/NmYbwDfGZe4R0YtnDQ+gXK5v59lIc96PEH6TlBdt5ImJGmGtweAKRscM9RJgDqeqeFS2fgKfYVxm+1Adw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKy9sAPaKqaE0IAThcry9F+AFOrIs1RXfuY1tB4IiC0=;
 b=c/THqolY0iCw+X+El9weta4LSmmWA2KtNfpfX+QKx0soCHP5EWZn5FKxkhwt6q4QZbaREy8L4KLPZbqaV6APrDVgB3lhqJQiqCO7urUtMkLnlwE5wpzJOZM4oRbfrHfpU2XuO3cioqFF/+i4IYoY/6TUXtbIhKN9VJshjgU7YqU=
Received: from DS7PR06CA0015.namprd06.prod.outlook.com (2603:10b6:8:2a::26) by
 DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.29; Fri, 14 Oct 2022 07:23:48 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::3f) by DS7PR06CA0015.outlook.office365.com
 (2603:10b6:8:2a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Fri, 14 Oct 2022 07:23:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Fri, 14 Oct 2022 07:23:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 14 Oct
 2022 02:23:46 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 14 Oct 2022 02:23:44
 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>
Subject: [PATCH] drm/amdgpu: move convert_error_address out of umc_ras
Date: Fri, 14 Oct 2022 15:23:40 +0800
Message-ID: <20221014072340.3054-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|DM4PR12MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e7489f5-f36e-490b-cadf-08daadb50903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dWgBjCNItHtKoWnUtVCwBlBVwOUjBAR+1GXrkz77eHdHl52ixzUtn1iJcnz+N5Hql9GEwGZd0orMvJxw1VnTd+dsZvxlSPwL9RromvmcCfkj3QioHOTh5bdd3fhXwuasD95xfRPwC9R6K4g0rBbvWvcBsyKFfK3rkEbsmIbC3Qi16sPIPyfVXKg2gM/Cwv5ZadKZVmOtTh+awFhFbJW0kMYRVsfUcvzhI9RYrgbG3terFtSS11RkUJG0XsJyAqFqq2wgZVA1znOBt8C5tb+eB/85b81/GqoXpLnPXCqZwQ0SDTXKNFqopvNcKQzI1MIMbgy/0hXhoTo1QgHCtABEM8psvmewjegYFwxvfdsARXa8orXzU1m5bj4b4DBkQ+FP0LyElGsTJ+UwE08TVjK519U8hpaldcqYwe+jxgpB13ZlvPj3lis47KZfwbWufC5xitUn14OjJQUFMApkknUdw5Z+bsUc9RhyAYAmPF8hBpJeIgUfL2mYCXfpLkJ0xePtVsubzhCVQpYpzjBQRNC/gM0+9oyr3i+giB2XsT2mg7wupudeBQR8Z9t4eKciVVWmiYvCCiY9J5DgsZa7IZc1E4qt/MsI/dHWAr1ATffYr+TR1pjZD+j0q4QDnnKxGCspXo571lMYPSu1XefGNJfE+XV4iDBGRNIEUro0DWUarIRP1d+QM26HOCtvK+0knlRDJB4H3rhYlZQbAfMPM4p6eimEyOZdTGryO4F6pnfWSyuuZwpu6IMFNeeKuOoGkbYQZ9dI1rkZ668I3DRQb0aJlie4RugP53oTmZeDtDvODxdjcPWbjWF0ySVR28pZAbin
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(316002)(6636002)(110136005)(54906003)(478600001)(70206006)(70586007)(8676002)(4326008)(6666004)(8936002)(41300700001)(7696005)(356005)(47076005)(81166007)(426003)(186003)(1076003)(336012)(5660300002)(2906002)(2616005)(83380400001)(26005)(36860700001)(82740400003)(82310400005)(40460700003)(36756003)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 07:23:47.6713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7489f5-f36e-490b-cadf-08daadb50903
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6328
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
Cc: Kent Russell <Kent.Russell@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RAS error address translation algorithm is common
across dGPU and A + A platform as along as the SOC
integrates the same generation of UMC IP.

UMC RAS is managed by x86 MCA on A + A platform,
umc_ras in GPU driver is not initialized at all on
A + A platform. In such case, any umc_ras callback
implemented for dGPU config shouldn't be invoked
from A + A specific callback.

The change moves convert_error_address out of dGPU
umc_ras structure and makes it share between A + A
and dGPU config.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Stanley Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 16 ++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  3 ---
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c   |  7 +++----
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.h   |  4 +++-
 4 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 75f1402101f4..41b3081fe415 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -36,6 +36,7 @@
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include "atom.h"
 #include "amdgpu_reset.h"
+#include "umc_v6_7.h"
 
 #ifdef CONFIG_X86_MCE_AMD
 #include <asm/mce.h>
@@ -2885,10 +2886,17 @@ static int amdgpu_bad_page_notifier(struct notifier_block *nb,
 	/*
 	 * Translate UMC channel address to Physical address
 	 */
-	if (adev->umc.ras &&
-	    adev->umc.ras->convert_ras_error_address)
-		adev->umc.ras->convert_ras_error_address(adev,
-			&err_data, m->addr, ch_inst, umc_inst);
+	switch (adev->ip_versions[UMC_HWIP][0]) {
+	case IP_VERSION(6, 7, 0):
+		umc_v6_7_convert_error_address(adev,
+				&err_data, m->addr, ch_inst, umc_inst);
+		break;
+	default:
+		dev_warn(adev->dev,
+			 "UMC address to Physical address translation is not supported\n");
+		kfree(err_data.err_addr);
+		return NOTIFY_DONE;
+	}
 
 	if (amdgpu_bad_page_threshold != 0) {
 		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index e46439274f3a..3629d8f292ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -51,9 +51,6 @@ struct amdgpu_umc_ras {
 	struct amdgpu_ras_block_object ras_block;
 	void (*err_cnt_init)(struct amdgpu_device *adev);
 	bool (*query_ras_poison_mode)(struct amdgpu_device *adev);
-	void (*convert_ras_error_address)(struct amdgpu_device *adev,
-				struct ras_err_data *err_data, uint64_t err_addr,
-				uint32_t ch_inst, uint32_t umc_inst);
 	void (*ecc_info_query_ras_error_count)(struct amdgpu_device *adev,
 				      void *ras_error_status);
 	void (*ecc_info_query_ras_error_address)(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index 5d5d031c9e7d..72fd963f178b 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -187,9 +187,9 @@ static void umc_v6_7_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
 	}
 }
 
-static void umc_v6_7_convert_error_address(struct amdgpu_device *adev,
-					struct ras_err_data *err_data, uint64_t err_addr,
-					uint32_t ch_inst, uint32_t umc_inst)
+void umc_v6_7_convert_error_address(struct amdgpu_device *adev,
+				    struct ras_err_data *err_data, uint64_t err_addr,
+				    uint32_t ch_inst, uint32_t umc_inst)
 {
 	uint32_t channel_index;
 	uint64_t soc_pa, retired_page, column;
@@ -553,5 +553,4 @@ struct amdgpu_umc_ras umc_v6_7_ras = {
 	.query_ras_poison_mode = umc_v6_7_query_ras_poison_mode,
 	.ecc_info_query_ras_error_count = umc_v6_7_ecc_info_query_ras_error_count,
 	.ecc_info_query_ras_error_address = umc_v6_7_ecc_info_query_ras_error_address,
-	.convert_ras_error_address = umc_v6_7_convert_error_address,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
index fe41ed2f5945..105245d5b6e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
@@ -71,5 +71,7 @@ extern const uint32_t
 	umc_v6_7_channel_idx_tbl_second[UMC_V6_7_UMC_INSTANCE_NUM][UMC_V6_7_CHANNEL_INSTANCE_NUM];
 extern const uint32_t
 	umc_v6_7_channel_idx_tbl_first[UMC_V6_7_UMC_INSTANCE_NUM][UMC_V6_7_CHANNEL_INSTANCE_NUM];
-
+void umc_v6_7_convert_error_address(struct amdgpu_device *adev,
+                                    struct ras_err_data *err_data, uint64_t err_addr,
+                                    uint32_t ch_inst, uint32_t umc_inst);
 #endif
-- 
2.17.1

