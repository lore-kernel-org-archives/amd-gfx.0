Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE16E95A97
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 10:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8425010E330;
	Tue, 10 Oct 2023 10:18:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1A1710E1E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 10:18:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zx+/pJF5owSgkEDl7glrbJqHbbdaUO21GyOowQbs3druNqFx2UxC6VrePI0Mt8W6XjBt1ADHH713F+HSXgnVSui5UnGncTNKpp9JzMoKBA+qSd5scy1N1QR0ynsWF8dgFwxEO/o/Pu5SUnOzlNXEgNRSlabmvfhe5pJPHQfxp8LaFbyl3j2i4cLZlHeQx0WEj7vpt7l/kydhnFtyZh+bqdqE77f3ajA+zY5uDsuAlKYIBVkGS7YUooXruWwFkhaaOXF7uJ0jCKFiS74PBLSQtp8ySBMPKnkysmHS2Gr84quIBF0xImsUS/nFvT9nFu7Nugtd3Ulx3u6S2VGalXTRyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6SJH8Vr2UdGLddG7Ot14UaGuVl5f519M40tP3Wxm8I=;
 b=JxWHeT+OomHGuigJHJZxDrLibvuMk9jtthzMJYnwu8t9og4x3WhPamIaFNhNivJUMFse6NjdZFGFgWVfSMY4sbxr4hzi5le3wLu1cYlMIy5Zyllj8hlivBGx/PEMCu5MkySVM/MmBn59m6XgnZVHNewN8dWyP06hWIz776eQDSn7gaHZRHKLx8pXzz7CjO2BeBVWQWXtglazfRiqtIe2PD93X1YuF+unGSP2Z+ik9FRZS31K+4nuI2RD5MfLBZk/IFHaUtxtj9iZrfmhQHK5A0j0nDGZzuQ1nHPi5VK7D7MRedKR1jxm+Fma7U0xghVpCnyRq8/DNtPji/ZtSxAEqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6SJH8Vr2UdGLddG7Ot14UaGuVl5f519M40tP3Wxm8I=;
 b=OOn3SAfCOLc/1D2jtSIUvJbI1jepfacZx8CawzrVgunK+CV2LNPtygaoVWgrDgHoSZ/mhkxs5rwhJYHQYBmy0nXxTVXRIHkJhphOZwmWvDgp+TzxsA5vl8JopcMgpSZ9D4jKtek6dh4uI5pDZFix8bAdkIH/hZyeOY3e8aL+/u4=
Received: from PH0P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::26)
 by SN7PR12MB7179.namprd12.prod.outlook.com (2603:10b6:806:2a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 10:18:41 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::f4) by PH0P220CA0015.outlook.office365.com
 (2603:10b6:510:d3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Tue, 10 Oct 2023 10:18:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 10 Oct 2023 10:18:41 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 05:18:39 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v7 06/12] drm/amdgpu: create context space for usermode queue
Date: Tue, 10 Oct 2023 12:17:46 +0200
Message-ID: <20231010101752.1843-7-shashank.sharma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|SN7PR12MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f21b20-011d-4583-a81d-08dbc97a46b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MbKyzmsRy8xJ4wXDo5+XcHssXu2UhiyWP8s+j31XkGVdHlePFPepBCYcFS5Gx/NhAcBW5y7ZCpv3nyCY+muIEZXopexeROGwvuEev733xo+kL0dwUDFl1V2eeTHvXAR9OxQTCIfrpd712l64DucYgc0MDNF+HLhWTor0owzUfZ35gJqlsilC0d5uQMM/GR/Tyybua2aGZHz3N6wA7Icy8IT51uq2n0/gdbgxhjIWdzdS26+PFUBk1YOgAjukj+6prR+ctHPebFxKPOUg2yDSsjH4DcleDD2umta1Eu2dxsGKEjwm5GUAxxmc3jNsGkqARMPf3uTse92omO1Bl+fpH8rk20ZkU4cTPYtsnmAw8KvcKGL7OWNr6COXia2XILnPP+seMjBYQrgi36gwzboWDd0rHs73ClSXAdaqF5z+b25HJ17eLTQKzOeFxdnzDgUU96ilS8walJdyI0agKxeTsCY2CDSzGnlcmCHrJiCwmhrrEQTSC7NjdBTcaUSjawLjsJ9PZhsPB9NXz0OJD19/C0kASP0xkCGmjNEqKyc0nfAr6L5z2KmcrPwIzPqOhgbrna6VbT6q453fyYzY+nW/73+DU5vzXRyHcp3SadtUHlWrOV/xkwag/xAECZ7YfA5gyvkaQ6l0nVAdS4JlbCf0kWGWc5QPsDPRogOsTqhCS6w3OD5Skt30bawWQNhwsW+i/JtS1lyATU0hIN8yLA45PR9yAZU7uoPyH3CY3rtU9WxHeBgdnwLYKTQHTqrq8EzGcMOy4yd3QxKPiOf/7EryxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(83380400001)(40460700003)(40480700001)(2616005)(426003)(336012)(1076003)(16526019)(26005)(70206006)(70586007)(54906003)(6916009)(316002)(356005)(41300700001)(47076005)(5660300002)(82740400003)(4326008)(8676002)(8936002)(2906002)(81166007)(44832011)(36756003)(7696005)(6666004)(86362001)(478600001)(36860700001)(19627235002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 10:18:41.2066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f21b20-011d-4583-a81d-08dbc97a46b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7179
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

The FW expects us to allocate at least one page as context
space to process gang, process, GDS and FW  related work.
This patch creates a joint object for the same, and calculates
GPU space offsets of these spaces.

V1: Addressed review comments on RFC patch:
    Alex: Make this function IP specific

V2: Addressed review comments from Christian
    - Allocate only one object for total FW space, and calculate
      offsets for each of these objects.

V3: Integration with doorbell manager

V4: Review comments:
    - Remove shadow from FW space list from cover letter (Alex)
    - Alignment of macro (Luben)

V5: Merged patches 5 and 6 into this single patch
    Addressed review comments:
    - Use lower_32_bits instead of mask (Christian)
    - gfx_v11_0 instead of gfx_v11 in function names (Alex)
    - Shadow and GDS objects are now coming from userspace (Christian,
      Alex)

V6:
    - Add a comment to replace amdgpu_bo_create_kernel() with
      amdgpu_bo_create() during fw_ctx object creation (Christian).
    - Move proc_ctx_gpu_addr, gang_ctx_gpu_addr and fw_ctx_gpu_addr out
      of generic queue structure and make it gen11 specific (Alex).

V7:
   - Using helper function to create/destroy userqueue objects.
   - Removed FW object space allocation.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 41 +++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
 2 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 30e18cb018fa..4b0c3fc63411 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -61,6 +61,9 @@
 #define regCGTT_WD_CLK_CTRL_BASE_IDX	1
 #define regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1	0x4e7e
 #define regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1_BASE_IDX	1
+#define AMDGPU_USERQ_PROC_CTX_SZ   PAGE_SIZE
+#define AMDGPU_USERQ_GANG_CTX_SZ   PAGE_SIZE
+#define AMDGPU_USERQ_FW_CTX_SZ     PAGE_SIZE
 
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_me.bin");
@@ -6402,6 +6405,36 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
 	.funcs = &gfx_v11_0_ip_funcs,
 };
 
+static int gfx_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
+					    struct amdgpu_usermode_queue *queue,
+					    struct drm_amdgpu_userq_mqd_gfx_v11_0 *mqd_user)
+{
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	struct v11_gfx_mqd *mqd = queue->mqd.cpu_ptr;
+	int r, size;
+
+	/*
+	 * The FW expects at least one page space allocated for
+	 * process ctx and gang ctx each. Create an object
+	 * for the same.
+	 */
+	size = AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_GANG_CTX_SZ;
+	r = amdgpu_userqueue_create_object(uq_mgr, ctx, size);
+	if (r) {
+		DRM_ERROR("Failed to allocate ctx space bo for userqueue, err:%d\n", r);
+		return r;
+	}
+
+	/* Shadow and GDS objects come directly from userspace */
+	mqd->shadow_base_lo = mqd_user->shadow_va & 0xFFFFFFFC;
+	mqd->shadow_base_hi = upper_32_bits(mqd_user->shadow_va);
+
+	mqd->gds_bkup_base_lo = mqd_user->gds_va & 0xFFFFFFFC;
+	mqd->gds_bkup_base_hi = upper_32_bits(mqd_user->gds_va);
+
+	return 0;
+}
+
 static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 				      struct drm_amdgpu_userq_in *args_in,
 				      struct amdgpu_usermode_queue *queue)
@@ -6450,6 +6483,13 @@ static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		goto free_mqd;
 	}
 
+	/* Create BO for FW operations */
+	r = gfx_v11_0_userq_create_ctx_space(uq_mgr, queue, mqd_user);
+	if (r) {
+		DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
+		goto free_mqd;
+	}
+
 	return 0;
 
 free_mqd:
@@ -6461,6 +6501,7 @@ static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 static void
 gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
 {
+	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
 }
 
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index bbd29f68b8d4..643f31474bd8 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -44,6 +44,7 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_userq_mgr *userq_mgr;
 	struct amdgpu_vm	*vm;
 	struct amdgpu_userq_obj mqd;
+	struct amdgpu_userq_obj fw_obj;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.42.0

