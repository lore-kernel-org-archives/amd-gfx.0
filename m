Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB0BC636D4
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 18:44:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E6D910E0B5;
	Wed, 15 Feb 2023 18:44:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE97310EB83
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 18:44:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iADfeJPQMyep90NleBYjRsSCY+E3/LQmevbphJuJX5mQ2tdZJ9JGwFrvkN/vKgIigMQzSY2ZMEulB2pxFxxhb0MwFPWoJNvary83VUxfdoLBq79x05coOhHWpa/iO/uPlXie6/aFz1T64CQzB2YU3PIbLwdraHKhmZ+YyQ6Haf7BGUyuQGZE3CHI2eGsgavaYmF0zHyIqBPJWwZIe0jwL1g7Y/blSMaRdvfQFdFDJZYYCReKgu3KW63z+9n4OfcY8JD9nmjKzeHlGNnQIMgR+VzXFZPUXUUQ4fb5W/ZCaLMJqLSgqgdfiQZhuN9nyZl0NlmZ4hjvIPSeu7pHtr9GEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDymWwfjzaqs/vhPClxVpJYiDlvJIyLUQc1t3mS8vNo=;
 b=Pp3yql+lV5Bin0jHakiQdg+fGQITbaDm9klVKUWwuR94OCbf8IsunhEgingjD0RLSU5Q/hE8Po5vwbX3mFB0mjNUVkcwAPolFD1UiHpDILHdj0q4PnTjwpaPqHjzdCo44fzUjXG4zOaahSwXhw6TFRXhfC4/X8dEIofz979aQVngyoprPSsdxky9oJSbnnRFL5AL9O3gHL/sCCfjCkIffZSLyIHVUBCOzmyFmp4uBXgRqnj8w9QAw/1zSh4ACFTRSgJLryzqfrBqUVmlEm2KzJhzt4q0ICGRjcBwxhv0xtKwCaIflPkrlvrrt8shN73o3DMRSVOg+Jl8hhh+znczTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDymWwfjzaqs/vhPClxVpJYiDlvJIyLUQc1t3mS8vNo=;
 b=abOI8j6WC4UnVq/WowElmx2k5YaZPZy62+VJC1HEWfZ825/bC+v+GDR3o//SlI3z4FZqlxRg7nyvO6yML8jICCBGhZ0+oCuTRvIda0TQmSE5GcYaf85fYuzVUPanloSZJVu3Motx06PMPbfYmjNkO++sigNAyNR1YMS7xf79jGA=
Received: from DS7PR05CA0054.namprd05.prod.outlook.com (2603:10b6:8:2f::28) by
 DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.22; Wed, 15 Feb 2023 18:44:29 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::2c) by DS7PR05CA0054.outlook.office365.com
 (2603:10b6:8:2f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12 via Frontend
 Transport; Wed, 15 Feb 2023 18:44:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.12 via Frontend Transport; Wed, 15 Feb 2023 18:44:29 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Feb
 2023 12:44:28 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/9] drm/amdgpu: UAPI for user queue management
Date: Wed, 15 Feb 2023 19:43:49 +0100
Message-ID: <20230215184356.2205-2-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230215184356.2205-1-shashank.sharma@amd.com>
References: <20230215184356.2205-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT011:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: ec594ed9-adad-4e9e-1cac-08db0f84abe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fvBOLRMBzm6nGACWcKa9rZHGncyE+QISRu2ay9lXvkRK/zBasSbgC6vApRuPbuJjbPjOJ0lfxM5VLzMMhUj4w7aW1wjShyyVaGBSdwNIVihe4oxAQvouh6xJFmjtmwjALws7+9VDG87nAh+s8MUXmA23Ve1bFbPFEkG4CrAun43+J9E4GXEI4GpqyxoFqocX5YQtoaAKBbANc9TyDNzgpqkhtkEUpV55kOIu9jUZTAdH4/cTSb5OJBiqzkxWEH1RlDQv/7Wdb3LNiKs9Fm3jd0Fwo/v63AuKGQi7primKV6iUN+KIxY4k4LswTdGemvHkSMYXnqHvKS++HBDrshwGb19TyvhwdxJYL8u6qB83Cb0b5Gqqjp0hv7iMUBFTALWZcyoT6YQfUBC7nayicBGN6K0jDEHPrKBQHUykwf2nkxDR63Wo5+bKJsNJd4wba1KCK3+/6BS2PHJ9/D/6NcZmgsl9uXrWiYDLnMs0nWRl1p6LE/xgYgGLDi8xCivGVYFAYuxCi28+ApAHKUn7rsJsAdHgrc2neWS52YFjqRIVywZwaW+gadj7Ew2oXXsD17CGAm4kj7jMfMWWA5+KF6VYnmCNENW4BRmGeK+D5WFR5cILNQ5yt8AWFmkLdfBAEgq54WiDMTUXIAQFQdMwj6jhUpdRuQGzE3sXbyNpGg8vc830MNYKj0My2C60rsno0IcV+wjD2Ou9eDNMAdDwMdPD6ckJgt7dVmCUl4oZE7Lzts=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199018)(40470700004)(46966006)(36840700001)(83380400001)(54906003)(36860700001)(26005)(1076003)(336012)(186003)(6666004)(16526019)(7696005)(478600001)(426003)(2616005)(47076005)(40460700003)(2906002)(316002)(40480700001)(6916009)(70586007)(81166007)(86362001)(82310400005)(36756003)(8676002)(356005)(4326008)(70206006)(8936002)(5660300002)(44832011)(82740400003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 18:44:29.6556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec594ed9-adad-4e9e-1cac-08db0f84abe9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573
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
 Christian Koenig <christian.koenig@amd.com>, Arvind.Yadav@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

This patch intorduces new UAPI/IOCTL for usermode graphics
queue. The userspace app will fill this structure and request
the graphics driver to add a graphics work queue for it. The
output of this UAPI is a queue id.

This UAPI maps the queue into GPU, so the graphics app can start
submitting work to the queue as soon as the call returns.

V2: Addressed review comments from Alex and Christian
    - Make the doorbell offset's comment clearer
    - Change the output parameter name to queue_id

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 55 +++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 4038abe8505a..2bc4869ee279 100644
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
@@ -302,6 +304,59 @@ union drm_amdgpu_ctx {
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
+	/** Doorbell's offset in the doorbell bo */
+	__u32   doorbell_offset;
+	/** GPU virtual address of the queue */
+	__u64   queue_va;
+	/** Size of the queue in bytes */
+	__u64   queue_size;
+	/** GPU virtual address of the rptr */
+	__u64   rptr_va;
+	/** GPU virtual address of the wptr */
+	__u64   wptr_va;
+	/** GPU virtual address of the shadow context space */
+	__u64	shadow_va;
+};
+
+struct drm_amdgpu_userq_in {
+	/** AMDGPU_USERQ_OP_* */
+	__u32	op;
+	/** Flags */
+	__u32	flags;
+	/** Queue handle to associate the queue free call with,
+	 * unused for queue create calls */
+	__u32	queue_id;
+	__u32	pad;
+	/** Queue descriptor */
+	struct drm_amdgpu_userq_mqd mqd;
+};
+
+struct drm_amdgpu_userq_out {
+	/** Queue handle */
+	__u32	queue_id;
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

