Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184C8C64EC4
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 09:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4DCF10E5F3;
	Wed,  8 Mar 2023 09:34:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40CBD10E5ED
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 09:34:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+1vDuDxghowQTXMP+sXaQuqQdLOpVKi0AiLZhIyWHKufyEVrSg2CnY7nPWG2RqFE3P3IgczFvo3Y2ErlTPKHCsiwWwRNuGQ/32+8xy2TI1yPavYzLk8XkWoqlQkyIDMnRvbKSIXI9U8JhAWDeJ8BQRWi3VIbznZ7MgNg7TxJvxHQyPXbLsOtmWCmXvI7GRSJsU00bU+E4If7IPP6B3/mP5COnl9IW3/TGbuNOsgAmg8P9Jubz41DWI/EFYrQiK5i83cwh+a3OPUamxy82eTa32TRC/kDOqmMAaNcGrpXYwzzaDhh7e/muwvsJ33bKvEA7B7GsmfjIzMRlTylX13Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btjntSXLOZmzVoHMdG6WdH3AHUS8DqHDxkofDbVUG2c=;
 b=X7hDsIB7XSPAtsuzNoAqwDuUjtBFn1K2la+MsJGPyyYHwFpzKDwPPIOi2TRi2dBJoKOhQ2OGQIlVseBZSOJzZtGODpUyk8ZSapp7nnV1tH0rg4k//nXfC8MgJWyIfSS36CJQb65jT8eIDcqYkzITGt1rJyh6VBJYOXIvUbiQ57rTmkdBvsgJIYXy+w6Un1jGhSHKld0WOyUt1OcHnQ4p8ZzPeyoHHPtS6YV24uh8xyCGuwDg3SCzjMB9YQWx0mSCG9vDPrk5P6qKqJwT6wqjRBf/hFuKIXSTznBs6MIHTAjtd6g1DOYEKyTlptM+pXMpNfu94O3gvbknW67DpCMgcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btjntSXLOZmzVoHMdG6WdH3AHUS8DqHDxkofDbVUG2c=;
 b=gYuBGR2TdGlEydcpxSmmqQdH8vbG0Yr0j+nXFhuWj/kGZcEn3M3VudlsRvYIChj8Q/QDrE8+LL4nu27ok0cT7TUklqDO7i/H5JNUAyuAF++w5IOPFltIo325QoPay2qWjZij8lKzZYMwkYJ+Ltf9weAl1Lhz6J7XtU7k+6ulkrc=
Received: from MN2PR05CA0058.namprd05.prod.outlook.com (2603:10b6:208:236::27)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 09:34:25 +0000
Received: from BL02EPF0000C406.namprd05.prod.outlook.com
 (2603:10b6:208:236:cafe::45) by MN2PR05CA0058.outlook.office365.com
 (2603:10b6:208:236::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17 via Frontend
 Transport; Wed, 8 Mar 2023 09:34:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C406.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.12 via Frontend Transport; Wed, 8 Mar 2023 09:34:25 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Mar
 2023 03:34:23 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/amdkfd: Fix build error with unmatched argument
 type
Date: Wed, 8 Mar 2023 04:34:08 -0500
Message-ID: <20230308093408.239331-2-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308093408.239331-1-qingqing.zhuo@amd.com>
References: <20230308093408.239331-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C406:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: badb85fb-ae88-440c-05e8-08db1fb84e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V70DCviogwYr49o5faWQ6u0zNbBSL7HFGf0uxUrTb0IbLuKSdCFSfF4ZChczM78Ed2FG6iTD9kjNrdLMD6GB0VkLjTvrwQjgZ4xz7oj3xC0Jmm+TqkVU92TbOF3OkQ3MhTkrC7+zjlU0EVfudFgsRYBYfh8xIliiS5ut5IZXEw7/RQy1M7Lvs67PB0IlR/axr60TQ4nT/XQx4tCbU6GmOUgE8mOsu1H1y6rP/h90+tiKkdixlQo9Z0JKhmfCyN6kgSz6PYjcaVzWdjmVCEu9XcpOd5JJbO4EFvQgqjmegmieabI757groE9CYpQyP4Y5RYLpgZYvoyNIqHXDVfKXXpIywaGUVx4i+MNkwfAH1S9Rp+H49Xc4h8ljoHMqve6Q6Sq9J5cTf+AyskFKzk/Cv28YErUjLdeBA4F9Ga+WkkhPnG2eXNIsmsKPs/vz3uISV7OfZ6M5wb13uln6jwuVA0mYGrbMx+QwOFrCmH8ZmibEHFp4vo9W7eLeo4PF/FnsapVHSx4wDYTfgqJExVNrwZLlbA+QzozCyQmDhzuGLG2hEFzCGvpyf2Pz4VCW7U3Iiz6z403k1jcvN5L4Ci95H08unyEMmtY8Bfqc7TdNAUPyFgnQjS9ujriJQjBGQjt1ewpeapI4Eh3ut5yLd3YwILLybfXf6HpNR3qhAgddJDYK72swB4OVYo+y8PiAYG4DxQtqgEg8WYvB+JkPXvB4VIB+hqE2T+e1fv0Vr71MxIw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199018)(36840700001)(46966006)(40470700004)(8936002)(2906002)(44832011)(41300700001)(70586007)(8676002)(70206006)(5660300002)(6916009)(4326008)(82740400003)(316002)(54906003)(40460700003)(356005)(478600001)(36756003)(336012)(16526019)(6666004)(81166007)(86362001)(1076003)(26005)(186003)(36860700001)(82310400005)(83380400001)(47076005)(2616005)(426003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 09:34:25.1332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: badb85fb-ae88-440c-05e8-08db1fb84e59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C406.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018
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
Cc: Xiaogang Chen <Xiaogang.Chen@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_migrate.c: In function ‘svm_migrate_copy_to_vram’:
./drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:35:21:
error: format ‘%lx’ expects argument of type ‘long unsigned int’,
but argument 6 has type ‘uint64_t’ {aka ‘long long unsigned int’} [-Werror=format=]
   35 | #define pr_fmt(fmt) "amdgpu: " fmt
      |                     ^~~~~~~~~~

[How]
use %llx instead of %lx for ttm_res_offset.

Fixes: d5db9d377c021 ("drm/amdkfd: Fix BO offset for multi-VMA page migration")
Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>

Cc: Xiaogang Chen <Xiaogang.Chen@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>

---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 373cd7b0e1ca..fd54a00e7229 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -304,7 +304,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	uint64_t i, j;
 	int r;
 
-	pr_debug("svms 0x%p [0x%lx 0x%lx 0x%lx]\n", prange->svms, prange->start,
+	pr_debug("svms 0x%p [0x%lx 0x%lx 0x%llx]\n", prange->svms, prange->start,
 		 prange->last, ttm_res_offset);
 
 	src = scratch;
-- 
2.34.1

