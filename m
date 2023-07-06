Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B04EB64DC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 12:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60A0410E409;
	Thu,  6 Jul 2023 12:36:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B55D10E3EE
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 12:36:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/VTVbpKfa63n4thsiLhNPw6xqkfdfpTxTccshRvn+fHLVdAihHE1+xcX85GmFe3fpEFNB7PhfPT0d+J101L+SCQMvnSKlrxpnnhLrp/gwY6V03nsB4vIF8MXwreHRHKguzqvTI+BAF1z3tN88TJuUd8XzHAZ0Ic0L4MmMNvf8kytnzmKTPU+eYfkjqZ6vBHGNwNrckFKx3KM93MvEOGrPkK9i8wEI1K+BAoEKocUw0R/OKvFWfUwvY12ERvqzor9nwegBZK2BneoDuf/BUUfP9r2VVDyL4duwUNN+93OztnSYae4FlnAfEFAgQE1wVrb+cmCvIG2bVQ8jHg1UKxUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JVm6puAiDglv2/5ZP0u847K2O4iRDWv/kyXyVHQZOc=;
 b=YV7pEGEA+PboXsTswl/S5cxIfJkLCJnhH2o/nxOJB/DCLSE3tNNaIxyXDhOJaUv3tSQBcmypwRmmiDAwCBiScMyppJPN4IDdnna1d1pDQBHQfOBVmDVhzejVSxGVVbbVG1/vqMuIkWteKTkBj3Cnou1CqAM2zCDz5/9HiTJXulcJkLqB/LEn5VA2UtHhZQgNi1caTIHoZgOGoDGrtEJw7CKOCkNf7329shg0E0eJ82V2z55CR/9Hpkw0+YA3ZJdR7bsi73SfMWURsUH8onDAXC3djJFWgbmTaAg2bmoju8RtrWS+uG50w1sX+Wxv8oB8hkSYtH1Sq1wPAkLavo3l/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JVm6puAiDglv2/5ZP0u847K2O4iRDWv/kyXyVHQZOc=;
 b=n3p+ihZsOe97wNToOfBvLbnMQLC+jM6cdh/NO2m24dyWdkgJil/10nAZUIQ5kzj0nvjgbRLpXpqoJkJP/9Coy19dghdmGfO+7aEfz9gtidhI5L0oE1lq6dPicfFzR82lEZ29uZ2f5S7gl43BfkoLp4zicJiKpAEs64vo2I1XP/U=
Received: from DM6PR06CA0008.namprd06.prod.outlook.com (2603:10b6:5:120::21)
 by DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 12:36:33 +0000
Received: from DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120::4) by DM6PR06CA0008.outlook.office365.com
 (2603:10b6:5:120::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Thu, 6 Jul 2023 12:36:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT098.mail.protection.outlook.com (10.13.173.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 12:36:33 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 07:36:31 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 04/10] drm/amdgpu: create GFX-gen11 usermode queue
Date: Thu, 6 Jul 2023 14:35:56 +0200
Message-ID: <20230706123602.2331-5-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230706123602.2331-1-shashank.sharma@amd.com>
References: <20230706123602.2331-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT098:EE_|DM4PR12MB5165:EE_
X-MS-Office365-Filtering-Correlation-Id: 45a97f0f-ce68-41cc-6cc0-08db7e1da1a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qvfm8ZpVtjFjv+3zdhtVJys/A2oPFtBFfAo75GuXOlXdlrcmUR8sOCtAbnTeU9j0u6RHLmb25nus+Puhimiy8FFH/ghJ2p8XYYdslx1nZ+oo0ifv2pZkWrXI1IlUkyWtAuHjlD77AxY/BIHFTMNUbpysDXrWGYCt6ZitK+aqLb0iu7CLexAJNdkBrN4gxzzVyxWZb2uP45YAT+RYxR8eG4B0ybgj8YOTCDTDx0x1nrrMyrvZO/SVSlTrxsc0/c4L7QpSmZCxDD//4ModHVwQDF3pK0uJmdt2DK5nAOqicfhmxeC/1QAqMySYVxjpNeW5OHLlZMOQc89WQkFkBw8OrMIvjL/9xuZb1MDo5LIWQAC04xs3WEY+uiywhdbwit9vaTx5QE1YGtYb33pXXI2MtcG8DcDhf1ke8WJd4phefU2yTPcNFUf/h4BX1E9jbaadN0+RkJr3PUU6JXk0ZfpqeTbK/jA/REtf3SeUongjJJZMJJV2wkH8uBKn1PFfHYxIVab9kwGSPGOuXFqAWqVXiAFx01+6ohOcPeynsJAoVNLX0kHiz0APB1ImS7HMP/iT2Ll8/c1l3jvjWPzt75Otb5z0Xhi+icKkG4204lPuHrqwm2HMObuUeEIOcmujDS//0WAATCengQoykhbN/HXj+AJwOBau1Mi+9NjgBmWdmFx/oPbG7YwmCyJl5lubun+0r+RJ8K2c8vjWv1SZSzXGzPVEE1ZE0sg8ylyF8ztTs8/gtX+feQ85mKHgyeMcYRgWpygFZiCPWjLdVeUdQeFyjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(70206006)(6666004)(478600001)(7696005)(54906003)(70586007)(81166007)(47076005)(2616005)(36860700001)(426003)(36756003)(86362001)(40480700001)(2906002)(336012)(82310400005)(1076003)(16526019)(26005)(186003)(82740400003)(356005)(83380400001)(40460700003)(316002)(6916009)(4326008)(5660300002)(41300700001)(8936002)(8676002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:36:33.3662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a97f0f-ce68-41cc-6cc0-08db7e1da1a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5165
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

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 16 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 73 +++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
 3 files changed, 96 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index e37b5da5a0d0..bb774144c372 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -134,12 +134,28 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
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
index c4940b6ea1c4..e76e1b86b434 100644
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
@@ -6486,3 +6487,75 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
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
+	/* Create BO for actual Userqueue MQD now */
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
2.40.1

