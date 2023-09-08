Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E61AEE8019
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 16:06:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65BBE10E125;
	Fri,  8 Sep 2023 16:06:18 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F08C10E0C9
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 16:06:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daPMeNQ4iGSCefRg8BWp/oR2ai7wxvNlwrPzVrYnIZCPWvPxgQ8682Xo0YgyB15zpnNAN1mMs0jdd4SSrsvLrFfm6E/AAUmTDPDKU7H5TGYf6Nyh6Ab4HOjF0Fa785pXEOke1dhAO6pzkPxWM93c62vitmCgcLRCyS6RtPW2ojeKRoKsQRYue3YmcwOG/YSGGI0Bd2eJkqXwu30v6ExDkmmUwI8ldl4GaSxhCdRKFm0oDOyucQeO0suRxr9AHVUI4x1vxTAktlW7e71XHvsQtAmVIh7nI4NVneIkyeqHw+Rcc75VMsA8g4UdeahOWxQ2oe4oqFPZvKXTIxmmJVRK3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ET5axIpARlsU8cVjW1qkxFQJo6LbOQjb5NsWCnj6l/Q=;
 b=cMLvPAqHTbCdupYRvBbS3Hb4YN1EXw+XiIrC2PmNtsjJmftFFJo2MaDSp/3ThEQr+7mf1+GobJj6a7ogmnWGAvOH5OkPFx8OFqG6IsUhN6aqcfjphU24f5/pbryVspSUhTVgKUPKUD/OOMwWezRZmkh0fo2+uSIR/Y9A+WkT62Ic4GMnA2nFa8sLHnpMd0r8qyKp4C+9QDQRRpmKZI8Qd7XH0fOyqwG8djhsBgvL8FlUpyFS9pAcxPTyCe5f4Kt/TNKuWk/N+iAZ2Kg/q3jvfDy7SS2d57z/3UlcymYu2/rypFBGprX1wfLl3D9JfiCKz8OrjuI4RrUPG+dmBf1QSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ET5axIpARlsU8cVjW1qkxFQJo6LbOQjb5NsWCnj6l/Q=;
 b=fVI4N2uMzKv+s32B6YShhQMI+3ekpCtrvZ+slOL/xgcsvdd3g0U5h6x6GkbwuyHa8CtjS5985mF1FpOx2fYsqSkl4T78WMD6XpKW7Q9TfAWYkNCPZFIu2cU/renuyShPH8W8XtYgD8yDltmkbdhkbtYtCPFoliP51+iM4aFMalc=
Received: from CH0P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::28)
 by CY8PR12MB7217.namprd12.prod.outlook.com (2603:10b6:930:5b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 16:06:13 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::80) by CH0P221CA0011.outlook.office365.com
 (2603:10b6:610:11c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Fri, 8 Sep 2023 16:06:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Fri, 8 Sep 2023 16:06:13 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 11:06:10 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 4/9] drm/amdgpu: create GFX-gen11 usermode queue
Date: Fri, 8 Sep 2023 18:04:41 +0200
Message-ID: <20230908160446.2188-5-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230908160446.2188-1-shashank.sharma@amd.com>
References: <20230908160446.2188-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|CY8PR12MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: 80221dc8-ca55-47a2-c3dd-08dbb085865f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5VeAPLYcJ5onpeq6DsJBMbVcq0ApGoyEsXH/9o3d3DROs5Udt2RBy1dZU2c651Z6/LSCtdftBKfqfShG5PbUjs6rkc4WBCJ/tUuNJ3tDdibqTwynl7q76CUPJZ+zX1aEA/As2RRhy/q5AfXHdWWZS5r+7uBtgHrOp5sk3/cRUKxZwUf3QGbmgiEBvoalbBHcdN3AZtL7mTKi9U33qFu5R5HFdZNnika6wlofUPne+4evR1aynqg1zHqzzXZl3Nhe/wyaEO9G6VdvAax5bkTk2S5no0cARZtOe8NqM1o/VXa0iq5tgA9fFdChiFlGsmfsUay4/NHSYvUE0p/NVtLbismaVSp4f07IqYJn1xxg/c7uyhHUA/R2pjwYJ5XHR5h8/WVN/BosTgBcwT6jciYIkC2T1yeiCcl4Oi/IHYu/xAVkXHHSI0CgoSy7tMhwvO1mxzXv+5Lk+JibUNXmNcpaGIRh+KcCsFYZYGYdAHS8jiGshvl9/l57IKn/gdZURp54KT/lbvTMxzGWyWbFoZ3aqsoWONFzGeeSQNgt3vpe9sQvLKdWO1184xG8U/LWZ0W/wBuG3zclCn8eMF82hi1/qLf5yLQ6QIdwRS//5YPvFA1d3MJ+FuqQ7pOyoFU0K2B+nGDkadAGdxNBmYO22N+N4KotQL3d3iMtFJNgcUdjCTTykm/ncVMqZkdBp/kCMW1Z5ITRAJMh+o8EBLfFgx07SpoHgN9CskU5CJ9b4qonbdtgDDfHmMk72x2Jvd34BjqAe6aHHkS0KZW0Z5MG+PrZ/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(186009)(1800799009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(7696005)(6666004)(83380400001)(478600001)(26005)(2616005)(1076003)(426003)(336012)(16526019)(41300700001)(2906002)(4326008)(6916009)(54906003)(44832011)(316002)(70206006)(5660300002)(8676002)(70586007)(8936002)(86362001)(82740400003)(40460700003)(47076005)(40480700001)(36860700001)(36756003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 16:06:13.3837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80221dc8-ca55-47a2-c3dd-08dbb085865f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7217
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A Memory queue descriptor (MQD) of a userqueue defines it in
the hw's context. As MQD format can vary between different
graphics IPs, we need gfx GEN specific handlers to create MQDs.

This patch:
- Introduces MQD handler functions for the usermode queues.
- Adds new functions to create and destroy userqueue MQD for
  GFX-GEN-11 IP

V1: Worked on review comments from Alex:
    - Make MQD functions GEN and IP specific

V2: Worked on review comments from Alex:
    - Reuse the existing adev->mqd[ip] for MQD creation
    - Formatting and arrangement of code

V3:
    - Integration with doorbell manager

V4: Review comments addressed:
    - Do not create a new file for userq, reuse gfx_v11_0.c (Alex)
    - Align name of structure members (Luben)
    - Don't break up the Cc tag list and the Sob tag list in commit
      message (Luben)
V5:
   - No need to reserve the bo for MQD (Christian).
   - Some more changes to support IP specific MQD creation.

V6:
   - Add a comment reminding us to replace the amdgpu_bo_create_kernel()
     calls while creating MQD object to amdgpu_bo_create() once eviction
     fences are ready (Christian).

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 16 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 77 +++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
 3 files changed, 100 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 44769423ba30..03fc8e89eafb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -140,12 +140,28 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
+extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
+
+static void
+amdgpu_userqueue_setup_gfx(struct amdgpu_userq_mgr *uq_mgr)
+{
+	int maj;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	uint32_t version = adev->ip_versions[GC_HWIP][0];
+
+	/* We support usermode queue only for GFX V11 as of now */
+	maj = IP_VERSION_MAJ(version);
+	if (maj == 11)
+		uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_gfx_v11_funcs;
+}
+
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
 {
 	mutex_init(&userq_mgr->userq_mutex);
 	idr_init_base(&userq_mgr->userq_idr, 1);
 	userq_mgr->adev = adev;
 
+	amdgpu_userqueue_setup_gfx(userq_mgr);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0451533ddde4..6760abda08df 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -30,6 +30,7 @@
 #include "amdgpu_psp.h"
 #include "amdgpu_smu.h"
 #include "amdgpu_atomfirmware.h"
+#include "amdgpu_userqueue.h"
 #include "imu_v11_0.h"
 #include "soc21.h"
 #include "nvd.h"
@@ -6422,3 +6423,79 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
 	.rev = 0,
 	.funcs = &gfx_v11_0_ip_funcs,
 };
+
+static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
+				      struct drm_amdgpu_userq_in *args_in,
+				      struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_mqd *mqd_gfx_generic = &adev->mqds[AMDGPU_HW_IP_GFX];
+	struct drm_amdgpu_userq_mqd_gfx_v11_0 mqd_user;
+	struct amdgpu_mqd_prop userq_props;
+	int r;
+
+	/* Incoming MQD parameters from userspace to be saved here */
+	memset(&mqd_user, 0, sizeof(mqd_user));
+
+	/* Structure to initialize MQD for userqueue using generic MQD init function */
+	memset(&userq_props, 0, sizeof(userq_props));
+
+	if (args_in->mqd_size != sizeof(struct drm_amdgpu_userq_mqd_gfx_v11_0)) {
+		DRM_ERROR("MQD size mismatch\n");
+		return -EINVAL;
+	}
+
+	if (copy_from_user(&mqd_user, u64_to_user_ptr(args_in->mqd), args_in->mqd_size)) {
+		DRM_ERROR("Failed to get user MQD\n");
+		return -EFAULT;
+	}
+
+	/*
+	 * Create BO for actual Userqueue MQD now
+	 * Todo: replace the calls to bo_create_kernel() with bo_create() and use
+	 * implicit pinning for the MQD buffers.
+	 */
+	r = amdgpu_bo_create_kernel(adev, mqd_gfx_generic->mqd_size, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_GTT,
+				    &queue->mqd.obj,
+				    &queue->mqd.gpu_addr,
+				    &queue->mqd.cpu_ptr);
+	if (r) {
+		DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
+		return -ENOMEM;
+	}
+	memset(queue->mqd.cpu_ptr, 0, mqd_gfx_generic->mqd_size);
+
+	/* Initialize the MQD BO with user given values */
+	userq_props.wptr_gpu_addr = mqd_user.wptr_va;
+	userq_props.rptr_gpu_addr = mqd_user.rptr_va;
+	userq_props.queue_size = mqd_user.queue_size;
+	userq_props.hqd_base_gpu_addr = mqd_user.queue_va;
+	userq_props.mqd_gpu_addr = queue->mqd.gpu_addr;
+	userq_props.use_doorbell = true;
+
+	r = mqd_gfx_generic->init_mqd(adev, (void *)queue->mqd.cpu_ptr, &userq_props);
+	if (r) {
+		DRM_ERROR("Failed to initialize MQD for userqueue\n");
+		goto free_mqd;
+	}
+
+	return 0;
+
+free_mqd:
+	amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr, &queue->mqd.cpu_ptr);
+	return r;
+}
+
+static void
+gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_userq_obj *mqd = &queue->mqd;
+
+	amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
+}
+
+const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
+	.mqd_create = gfx_v11_0_userq_mqd_create,
+	.mqd_destroy = gfx_v11_0_userq_mqd_destroy,
+};
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 55ed6512a565..240f92796f00 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -29,6 +29,12 @@
 
 struct amdgpu_mqd_prop;
 
+struct amdgpu_userq_obj {
+	void		 *cpu_ptr;
+	uint64_t	 gpu_addr;
+	struct amdgpu_bo *obj;
+};
+
 struct amdgpu_usermode_queue {
 	int			queue_type;
 	uint64_t		doorbell_handle;
@@ -37,6 +43,7 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_mqd_prop	*userq_prop;
 	struct amdgpu_userq_mgr *userq_mgr;
 	struct amdgpu_vm	*vm;
+	struct amdgpu_userq_obj mqd;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.42.0

