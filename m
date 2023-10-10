Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D21CD691F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 10:18:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E90710E1E2;
	Tue, 10 Oct 2023 10:18:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EACFF10E1D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 10:18:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dg1GDc3vmBiF2pwPIKFr4PK22mXkUsVstHP7KPDfVflZKdeKB6S/zCg/V8wsxhQVvllp4lbdsCvAZo0Fve4oGMqfM9EabdFKe/NAim61JyGhiLMtBFJcpKigkXYTAqJjWjUeLpZpH5BDTcTB/c+NWdGMcSZ4zlaBUlI8kTsb/NIS8GI2l3LAaR9+Et59C4nIbkRSptTzbJiu206BUI0gkeHWailRSrxzBSlzhV703RUzmaBLbzNEfvoM8p0d715w9TcJj4MCykLObIA/6eph6b/Jhjl0RNoO3EYzLNuH08i+Q3BwsRdo+evnyUq17pnGSZfgfTzaNjUZ2IsA2kYEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEVsUT9qo69geR6ND1boIPvKFMjraODDwHBRCYdFR2A=;
 b=Z+U371Cnz6ZwJ0zzM3sx+h4u3Winn/S1xUCLwBxd1BcQyjb9N8lFK4r0SJl4kz0ZsQUXHL+c/rRvX6fOID8dmCYd0ZcubwzFagiqhw/QIyzDLrKJD15Q99thfOeyMp9/jBgH6+A9UBHmaWedLmmYuYdOG7Tq5WWclucmQh0qskSpolVB9xUQdXDHDui/ZrKxA+uVsBz8swepZAahhZrZFunPi6CKBwtk10VyYITnbVOZ6J77W97JaVKX/opdKtVoJaKXApbETzX1rpQHczfg48vifQpysho76+oFPN5MJTXvA6j5p9fXp9PWvI+h/UaPOFg1v0gH/UbVJv3iWSM/5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEVsUT9qo69geR6ND1boIPvKFMjraODDwHBRCYdFR2A=;
 b=jzG+/Vo33B7/AmjYfT7Uwb2oFxWLM3u5ze4KxEkr57+IKTUJDklo8JGTpTRxa+Lywl7DwOE+gIt+8YUSvoxQU1jLalq4ta5WJAREUP+l49xnSHarjwg1yVVEmI6E9CIG7wipZMUQIhDj2aUEPgk5ghT9T0oGLuxSr12JLL6bgEk=
Received: from PH0P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::7) by
 DM6PR12MB4912.namprd12.prod.outlook.com (2603:10b6:5:20b::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Tue, 10 Oct 2023 10:18:40 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::27) by PH0P220CA0026.outlook.office365.com
 (2603:10b6:510:d3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.40 via Frontend
 Transport; Tue, 10 Oct 2023 10:18:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 10 Oct 2023 10:18:40 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 05:18:37 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v7 05/12] drm/amdgpu: create GFX-gen11 usermode queue
Date: Tue, 10 Oct 2023 12:17:45 +0200
Message-ID: <20231010101752.1843-6-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20231010101752.1843-1-shashank.sharma@amd.com>
References: <20231010101752.1843-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|DM6PR12MB4912:EE_
X-MS-Office365-Filtering-Correlation-Id: 364e0361-35e6-46fc-fd73-08dbc97a462a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OR2jp0wxkFne3GZdQzXNtH8ShIewnLz9ok4F243a0MTD3DxW2xeBO7iuoEICV2E1vfQW2mn3cu9YnIPvXOpmU4PsEFaakVejOAH8kVjexmct71vaD6ZRw8eGZIdUiH86UJ/NAq7A1KJrxrqTEpNP98YCUt95ChkkHcRq5cW7zkA9ynb7HiDY06l/rX1U5atHT0cvYeRLQsrG54MzDYCSkQ8NXIlDM+nxWb+5gSu/wWSvPanorOJO7mG8H2usogBnmohZ2KgWCsRNKyE38uEQS+1yFVZ8Z1ExNReJ0dJYemYFvmn6xkd/GI4PShdy/P2ID9g9fXaHBKOroKhgpL5NH9EwrJnOgL3Q8jytpAOGTBkz2BYDbuJKuNNfqsBJrydLnNn9ZSMtcrd/CZ78ccl4bA9NAYucjbB9+/yLBlDVPM6lB/BmcFDyCsbvjEeu2dn3tshGLpvdSk8NRoXk460QclJJ5GrKUKVAK9ZX/uvnp6go5EZ0T+h6Y2VGL1WPCDTg7wJZy9/OaYZOjJWM6FCFZYih4gaZOHpw3Rytn6cJk4Eb8AgTGIn65ceY3LJTNw+39HySVL1FQw214TXqAwkeO8HvdiSeoXbbrG/Y4fd6c9k+CWsJj3xzV08rGinhBDaMDYg6QkGP0n/i069vGatfUboPuGOOBfbTsGnHmtEhHbEM3yFw1U9nuitsh4SO8dmSAk3/E5b4hHYrmg1ImyUtSh7u7d+27wWx9F9q306LsaIjxVRe5ljnJRhL8+c0XWOJe1TvYgobDq88RFU3FKfT1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799009)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(336012)(426003)(2616005)(41300700001)(1076003)(26005)(47076005)(70586007)(316002)(6916009)(36860700001)(54906003)(16526019)(8676002)(70206006)(7696005)(5660300002)(44832011)(6666004)(4326008)(478600001)(2906002)(82740400003)(83380400001)(8936002)(36756003)(356005)(81166007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 10:18:40.2847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 364e0361-35e6-46fc-fd73-08dbc97a462a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4912
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

V7:
   - Re-arrange userqueue functions in adev instead of uq_mgr (Alex)
   - Use memdup_user instead of copy_from_user (Christian)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 72 ++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5c3db694afa8..30e18cb018fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -49,6 +49,7 @@
 #include "gfx_v11_0_3.h"
 #include "nbio_v4_3.h"
 #include "mes_v11_0.h"
+#include "amdgpu_userqueue.h"
 
 #define GFX11_NUM_GFX_RINGS		1
 #define GFX11_MEC_HPD_SIZE	2048
@@ -1295,6 +1296,8 @@ static int gfx_v11_0_rlc_backdoor_autoload_enable(struct amdgpu_device *adev)
 	return 0;
 }
 
+const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
+
 static int gfx_v11_0_sw_init(void *handle)
 {
 	int i, j, k, r, ring_id = 0;
@@ -1313,6 +1316,7 @@ static int gfx_v11_0_sw_init(void *handle)
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
+		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_gfx_v11_funcs;
 		break;
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 4):
@@ -1322,6 +1326,7 @@ static int gfx_v11_0_sw_init(void *handle)
 		adev->gfx.mec.num_mec = 1;
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
+		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_gfx_v11_funcs;
 		break;
 	default:
 		adev->gfx.me.num_me = 1;
@@ -6396,3 +6401,70 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
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
+	struct drm_amdgpu_userq_mqd_gfx_v11_0 *mqd_user;
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
+	mqd_user = memdup_user(u64_to_user_ptr(args_in->mqd), args_in->mqd_size);
+	if (IS_ERR(mqd_user)) {
+		DRM_ERROR("Failed to read user MQD\n");
+		return -EFAULT;
+	}
+
+	r = amdgpu_userqueue_create_object(uq_mgr, &queue->mqd, mqd_gfx_generic->mqd_size);
+	if (r) {
+		DRM_ERROR("Failed to create MQD object for userqueue\n");
+		kfree(mqd_user);
+		return r;
+	}
+
+	/* Initialize the MQD BO with user given values */
+	userq_props.wptr_gpu_addr = mqd_user->wptr_va;
+	userq_props.rptr_gpu_addr = mqd_user->rptr_va;
+	userq_props.queue_size = mqd_user->queue_size;
+	userq_props.hqd_base_gpu_addr = mqd_user->queue_va;
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
+	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
+	kfree(mqd_user);
+	return r;
+}
+
+static void
+gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
+{
+	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
+}
+
+const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
+	.mqd_create = gfx_v11_0_userq_mqd_create,
+	.mqd_destroy = gfx_v11_0_userq_mqd_destroy,
+};
-- 
2.42.0

