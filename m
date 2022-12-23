Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1877CC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Dec 2022 19:37:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59CFF10E21D;
	Fri, 23 Dec 2022 19:37:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A591C10E1C4
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Dec 2022 19:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmabkjP3tY7yWPPLABoBZ5jD1gy9/ATwVNAZthHj1YmzaJXc81PFR0p3M0Pbac6nt2UqG1Rs6l3O3Z8XTtkmGIv/5zUoZ6VPDkGtHU2C3M2pmDzpdZhSd2jIMWGBTAzun8UzeAr1E85QzkLox6qjapAqt8TjXxTTS7nknmDJYVc/c0ptlHay1Ol9IcE02phIO7Qg+jWTzti2UIF8OHALFdNyoPRIm+aqL3cSbgau1DSA1TxK8NjecoKkSAWo1SCbLimCfI3gQfpCKtP4yL0CO5EoNA5chAPwUHwd+nXIWbS2BtDLadFrN2HVrRLb8PGBi4rmrfSkg3OMr/VOJBTfZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oa3818Iv0EuqMxXU+CSHaUyMNneKQ3N6Uv9RC0gJ/OE=;
 b=WbYUixbCDnxGNb1cMGBE0vGutNy+ys/0NpE71EPqWA/4N3gWJZ+GxF89aUHvEYpK9KkzMsC2ZFOP83NSPfoun1b4RbiT4MGqWaP1Qb5lrZ5ZLJALtPSVXxwyiULDQNQRNpLuGZ+ovNZHBitUlZebuPwyVDiBZa8taTB5VWpmXpCmKDCfbYzg4CYwi+Ssrhe/xJ6x9d9OHU0cMqQa4jeawx4qMyXM55HXS4N4Scw7M4WG68GT35hknIzu0h0g2/oax+n+Vxtvkt9hbdTsuCTQsmoP/cbwCNuAeKvx11mQyuC3VOJa/VuT13peshvkWJDlxJ5ajhyReXz6vG0QBt0s3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oa3818Iv0EuqMxXU+CSHaUyMNneKQ3N6Uv9RC0gJ/OE=;
 b=CseCSuOAgi2eOsEE58lHlPxHptXy78dAUlO2QJ8TWz1i5poqGWfNSstPSOAFDU8TAuB0hBTiiCXqF66g1WswhT4FBSA8OHdVFJxWD97XkJCTHAX8E9Mn5/qjDvGp+HjGsf5mglTeUI0qKVcoLqVfWAUjmXmouSr/ro9MgJEQx1k=
Received: from MW4PR03CA0215.namprd03.prod.outlook.com (2603:10b6:303:b9::10)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12; Fri, 23 Dec
 2022 19:37:26 +0000
Received: from CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::4c) by MW4PR03CA0215.outlook.office365.com
 (2603:10b6:303:b9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.13 via Frontend
 Transport; Fri, 23 Dec 2022 19:37:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT110.mail.protection.outlook.com (10.13.175.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.14 via Frontend Transport; Fri, 23 Dec 2022 19:37:25 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 23 Dec
 2022 13:37:23 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC 1/7] drm/amdgpu: UAPI for user queue management
Date: Fri, 23 Dec 2022 20:36:49 +0100
Message-ID: <20221223193655.1972-2-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20221223193655.1972-1-shashank.sharma@amd.com>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT110:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b7e74f5-2610-489a-a5c9-08dae51d1e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lqr/kN90/gMdCHAb+DJ0EFzQ5TcfU79oSZEwfUuQG+1/U/t23qbdMF9e7Kthgmt+0kL37MsnVG/1yB1dX7DMBqpXjRd3HqiU4p+yMdQ6h5//hknEGKQcCC+zwk6gkm5VjWq16IxrEDlgDKAzshKZovN6HD8atIgX3v3uLNLqs8kDFK1czgEeV1q5qA4Y0mttSkhPUV5xZoHwtRg3m7iG5KCAQvHMMH2v8NU6vqTXYZBFFdu/6yFoGn3SUFsnAt6o9nhM6hpUPk9vdGBnnLm2ggVv23Sn1bGqR1EW48TotgUW4sbtWwPWeMinrYh5AM/ojiuTViaWDAzda6wo2mu33bM1ZYFF82GmImGqRuQKBpvclgptf73UIoyhV5O4VhEz3ty6P8yEODt0j4zvfw9+aniRdxLFLZMuxKlWJJp1V2uEyNAfDQOaUJAuW+zhVJA/Wx1uqlE9GiA2B6Z5KbbhYYRjatG0r9lTv7rfpFkDAfGPd0MK5pnAQIVXFmaYnJamcFDddrDm/MEkjau6qL+Lz+5eM/BkLb+OkDIkzkr8//huPJFGeDZ4Jwys0iY4l8yajuOs5F47QEhLWdsKl7nt6WYgbxk9R6nzmG2uku5lt94RglcE3pXSQujcZ32nzAELCXzabRAUwbivrdRjsTzajgV+Yjye9xR2JIN2xEBOh12rBauNZj5BKaeeGQiaWjz43d5cGPqRADEJyjH/fbJ8bBazVocsVYRJys6P3io3YQ4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(36840700001)(40470700004)(46966006)(478600001)(7696005)(6666004)(356005)(81166007)(26005)(36860700001)(86362001)(83380400001)(82310400005)(16526019)(41300700001)(426003)(40460700003)(54906003)(316002)(6916009)(2906002)(36756003)(186003)(2616005)(8676002)(1076003)(70206006)(4326008)(5660300002)(70586007)(82740400003)(47076005)(44832011)(336012)(8936002)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 19:37:25.3434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7e74f5-2610-489a-a5c9-08dae51d1e7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233
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
 Shashank Sharma <shashank.sharma@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

This patch intorduces new UAPI/IOCTL for usermode graphics
queue. The userspace app will fill this structure and request
the graphics driver to add a graphics work queue for it. The
output of this UAPI is a queue id.

This UAPI maps the queue into GPU, so the graphics app can start
submitting work to the queue as soon as the call returns.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 52 +++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 0d93ec132ebb..a3d0dd6f62c5 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -54,6 +54,7 @@ extern "C" {
 #define DRM_AMDGPU_VM			0x13
 #define DRM_AMDGPU_FENCE_TO_HANDLE	0x14
 #define DRM_AMDGPU_SCHED		0x15
+#define DRM_AMDGPU_USERQ		0x16
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -71,6 +72,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_VM		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_VM, union drm_amdgpu_vm)
 #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
 #define DRM_IOCTL_AMDGPU_SCHED		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
+#define DRM_IOCTL_AMDGPU_USERQ		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
 
 /**
  * DOC: memory domains
@@ -288,6 +290,56 @@ union drm_amdgpu_ctx {
 	union drm_amdgpu_ctx_out out;
 };
 
+/* user queue IOCTL */
+#define AMDGPU_USERQ_OP_CREATE	1
+#define AMDGPU_USERQ_OP_FREE	2
+
+#define AMDGPU_USERQ_MQD_FLAGS_SECURE	(1 << 0)
+#define AMDGPU_USERQ_MQD_FLAGS_AQL	(1 << 1)
+
+struct drm_amdgpu_userq_mqd {
+	/** Flags: AMDGPU_USERQ_MQD_FLAGS_* */
+	__u32	flags;
+	/** IP type: AMDGPU_HW_IP_* */
+	__u32	ip_type;
+	/** GEM object handle */
+	__u32   doorbell_handle;
+	/** Doorbell offset in dwords */
+	__u32   doorbell_offset;
+	/** GPU virtual address of the queue */
+	__u64   queue_va;
+	/** Size of the queue in bytes */
+	__u64   queue_size;
+	/** GPU virtual address of the rptr */
+	__u64   rptr_va;
+	/** GPU virtual address of the wptr */
+	__u64   wptr_va;
+};
+
+struct drm_amdgpu_userq_in {
+	/** AMDGPU_USERQ_OP_* */
+	__u32	op;
+	/** Flags */
+	__u32	flags;
+	/** Context handle to associate the queue with */
+	__u32	ctx_id;
+	__u32	pad;
+	/** Queue descriptor */
+	struct drm_amdgpu_userq_mqd mqd;
+};
+
+struct drm_amdgpu_userq_out {
+	/** Queue handle */
+	__u32	q_id;
+	/** Flags */
+	__u32	flags;
+};
+
+union drm_amdgpu_userq {
+	struct drm_amdgpu_userq_in in;
+	struct drm_amdgpu_userq_out out;
+};
+
 /* vm ioctl */
 #define AMDGPU_VM_OP_RESERVE_VMID	1
 #define AMDGPU_VM_OP_UNRESERVE_VMID	2
-- 
2.34.1

