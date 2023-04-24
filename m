Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF275C7618E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 17:39:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6547510E599;
	Mon, 24 Apr 2023 17:39:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50E8210E119
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 17:39:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNnRf1OHaYzl8sLw0ju+RdQcJTyoLNFzYG34/T6GB1wy5ygjXssP1TRIR2A/fYgadmFs5mz6zUaXPSw+NXCrtNQ1VWpakee+1/1dUGV9SjBRI2pWIcLGdLGUvKFHXm1LhANDcmRMgGpvdhGoZZZiKNYYZpD/gNRgfAN1qvRu7+FAfcfX+LhlVtzY6Xq0ZM3j0+DBpVbyR6IvCCrIIOCmlhPY7rtvCG2GsW2EMLFJpAdSfmMxdNlszch2r1pahwgmkJVICtSvTGht25mByLC6tA1euKNSB1kcfol4T6RE6pN4nmPZcfW1yqd6Vv+4VGVqMautdnk2n3AfCyNc7u2oIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZoxZuAw0jklrRfGncrMQ04ZQuiJ8SayXPEKhbu2O4yo=;
 b=QkEvhwPv4Xw3v4BR5QFVldOFLM2wRAnanqBKL7dUnVYhYQLpV/cgwSluJD4M7i4kvS+RN6iA9RwwFC3R0czxehR3Ty8pRcvXT7YOvOSWobQOz373TSIVVMGnXxQ2JFzKCN6o93nbCMVRIMyZeocjuj/RB31os4pTeykX0gDEKb7nuyhdJTJvYyro1feJsEfhnXsMyHzBFDQjGGmlkA6ZK7BHtgDT+qzabbc6ljpfUO9ArKxnIPS4f9mvO7Ni8QCognIcMU/joC10Tc71T139GJA3VIKUY+CzJkMbqD5xPEtlFTYK+ApJnal1gSrNAA6kI0xbdTzKH+/TfTn8kbeaTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoxZuAw0jklrRfGncrMQ04ZQuiJ8SayXPEKhbu2O4yo=;
 b=Ys81sHtHa+U6C0r1I1ML8tvkCBGK0fAh1pFwNziLa/eoIDt0iE7OjRfJOo+yu+zUsT/OsNwgIyAG9BC2a+wOBP/b6IvXFJAJrExhdGuZV9b2wEzvwN5QQ0oTjo6wJ1pJnO9dYpVtOg8p8Ql1igm3264gx10CkrH7zP+3v4A/OcU=
Received: from MW4P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::18)
 by DM6PR12MB4498.namprd12.prod.outlook.com (2603:10b6:5:2a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 17:39:15 +0000
Received: from CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::c3) by MW4P222CA0013.outlook.office365.com
 (2603:10b6:303:114::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 17:39:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT115.mail.protection.outlook.com (10.13.174.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.19 via Frontend Transport; Mon, 24 Apr 2023 17:39:14 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 24 Apr
 2023 12:39:12 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 06/10] drm/amdgpu: set FW parameters in v11_struct
Date: Mon, 24 Apr 2023 19:38:31 +0200
Message-ID: <20230424173836.1441-7-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230424173836.1441-1-shashank.sharma@amd.com>
References: <20230424173836.1441-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT115:EE_|DM6PR12MB4498:EE_
X-MS-Office365-Filtering-Correlation-Id: 646876ff-b068-459a-3514-08db44ead2b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y2tuJhnAsN584a1P2dUziI2zbwsXtEWfKfEw5P8IXl6j9fWFSssCyK8nmwKOvd3+TPQki7rzPYZxF3RjjaFdqMlONSP19gRX/oeJYyn5QJmPZD/rmYzGS2M8jA/2fVFd3KDe9Pb40920l5KOOt3vkrdTg5FY+U1NyU8FeSjEesUSbbd/ct5ZXiNPKDtTKdCp4VTXJXCJcCwR9qiTLEoKkd+3N1FgjTAeNZdKZB+4xXXpXW+D+DP7AMyJkgde/F8SC8G+sy+9tMQafy51BByWoJ6akRfSvkGIIVKXwRHZyUSYm3N979+oKZmAY0FWGY5FP4106BvPUEwK/Aqa22K56gkx9ebnO0m8nvdLysyx7ioJWF9HWigXcSqDS5LsHWnnOpVhNXt/XMbwTgO0qZMeVmqTRVSF0kADVF0RUcRGqjDCjeh6bj+Y74Lar3ocFFIESyTm5CEMVAtISwR+49gXf+c81SHKtKeBi8ikVDbtONaZBkOv0sUL/hbZc0FITvdT7CKkmMnMZ8dox/WiYRmyyqdB5TeCBRcNhIUsKxMKqCXnS8o2T6/J/6pVC2WX1pQCr+Kkq/XF3gZjP87MoqLlwsYOt/1tSbQKBzRs46l+mDIRy8LIcoEGJSrYPPYLombK36w9b29X/XxDLKbYt6f+eAznvl+qk8kZDM03Hd0OKF8OoiUyCnVwSBtIERBykFBMbNmyK/mrg6mqCDNCK8TMHXQih//3gWAKwcokA4Tv0fM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(40470700004)(46966006)(36840700001)(2906002)(40460700003)(41300700001)(356005)(5660300002)(81166007)(44832011)(8676002)(8936002)(36756003)(82310400005)(86362001)(40480700001)(7696005)(6666004)(1076003)(26005)(54906003)(478600001)(36860700001)(2616005)(83380400001)(47076005)(336012)(426003)(186003)(16526019)(6916009)(4326008)(82740400003)(316002)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 17:39:14.9687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 646876ff-b068-459a-3514-08db44ead2b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4498
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
Cc: pierre-eric.pelloux-prayer@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>, arvind.yadav@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, contactshashanksharma@gmail.com,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Arvind Yadav <arvind.yadav@amd.com>

This patch sets new parameters defined in v11_struct for
usermode queue with the respective allocated gpu context
space addresses.

V4: Split the patch into two parts, keep only the set parameter
    part in this series (Alex).

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index f6b33faea86f..86de35292f69 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6411,6 +6411,21 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
 	.funcs = &gfx_v11_0_ip_funcs,
 };
 
+static void gfx_v11_userq_set_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
+					struct amdgpu_usermode_queue *queue)
+{
+	struct v11_gfx_mqd *mqd = queue->mqd.cpu_ptr;
+
+	mqd->shadow_base_lo = queue->shadow_ctx_gpu_addr & 0xfffffffc;
+	mqd->shadow_base_hi = upper_32_bits(queue->shadow_ctx_gpu_addr);
+
+	mqd->gds_bkup_base_lo = queue->gds_ctx_gpu_addr & 0xfffffffc;
+	mqd->gds_bkup_base_hi = upper_32_bits(queue->gds_ctx_gpu_addr);
+
+	mqd->fw_work_area_base_lo = queue->fw_ctx_gpu_addr & 0xfffffffc;
+	mqd->fw_work_area_base_lo = upper_32_bits(queue->fw_ctx_gpu_addr);
+}
+
 static int gfx_v11_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 					  struct amdgpu_usermode_queue *queue)
 {
@@ -6484,12 +6499,14 @@ gfx_v11_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode
 	queue->userq_prop.use_doorbell = true;
 	queue->userq_prop.mqd_gpu_addr = mqd->gpu_addr;
 	r = gfx_v11_mqd->init_mqd(adev, (void *)mqd->cpu_ptr, &queue->userq_prop);
-	amdgpu_bo_unreserve(mqd->obj);
 	if (r) {
+		amdgpu_bo_unreserve(mqd->obj);
 		DRM_ERROR("Failed to init MQD for queue\n");
 		goto free_ctx;
 	}
 
+	gfx_v11_userq_set_ctx_space(uq_mgr, queue);
+	amdgpu_bo_unreserve(mqd->obj);
 	DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
 	return 0;
 
-- 
2.40.0

