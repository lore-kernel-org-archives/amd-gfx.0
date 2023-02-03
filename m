Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BC4C61DA4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 21:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4EC810E900;
	Fri,  3 Feb 2023 21:54:43 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFB4A10E900
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 21:54:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ly2wMtBSySu3E8eDxQt1RtgvqNlUvyaMHd1UuW4oHkGHY92+4dBhr372Rh2MCiiiYqxs3F5B7SOkeIde8heB0E+icDT3nd+GhsjLX1VRilVAC4CcrBjWzIG/KBco8uw3AtbMrJmEKiFCcI+dkfYiBwcMZuhQDv6AAxOVH7wz1kM/MXUCQSoIgenuWX9WqTOT0XyNvOLGvC4yQxqENwG2pyXyzRu2ps8CPiq7u6lxL1g4Emq4VS3iGnM0tKaIhcb8bS5Vpik3gfGed5TkUd4pKBL143VJaG0csezPy3RbahtHf+8RoIN3XudydRWyQJw6HFvcb+WbIPRRbPFhSHMS9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lauH9mpXIVxFLIH56qUdpzEdZyd3y9QPzu05ZnSHlfQ=;
 b=SSoHTVUa+tE0pAT0wq+hN0hJ6SP1ocXLtgIR3Lg2PaUfJWuxoV9NcN5jQRiIr74QSAr2hEYbfOGA6FvZT+YYVKzuNt1gQKatDaz0WbkTyx7k9xbjBQ2xP+FD75EJIOl167m+A9BCaYpFmUyohUN8xW6+mueHNFXEjScg4Zh4N09Q6TIMd6XVvJet5+FV94NHuJC3a20WH4FK6UnIj4Ui8mHJChtrmbqev7KiN39frnOC3EPcjqAXbI8/ZVOGUJ6VGTb11+9aEf5Fwzmrd3KhmmelPQQJoJ3f+TPND+J8EkXvW/9oS1SHndjjIk+4kFeOT7xL6PvLGSCfHI+vu+TSEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lauH9mpXIVxFLIH56qUdpzEdZyd3y9QPzu05ZnSHlfQ=;
 b=wfsoYivWmVQLCTcsg52VVbTksfTbPAZvgkvFA1n9zPj8njXxg1hUvEU4Q6OWrdq+ckFWFZlbC42u9w8RHI5/dkWbUmGtiDF+9d6KRa5oshNDlKgQTHLtPUKi0A9ov8N1g3Mz7Lhg2aBEWGLDEm2jMm0EWxqhXEf586EH8m/jOEw=
Received: from CY5PR19CA0110.namprd19.prod.outlook.com (2603:10b6:930:64::11)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Fri, 3 Feb
 2023 21:54:39 +0000
Received: from CY4PEPF0000C977.namprd02.prod.outlook.com
 (2603:10b6:930:64:cafe::b9) by CY5PR19CA0110.outlook.office365.com
 (2603:10b6:930:64::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 21:54:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C977.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.18 via Frontend Transport; Fri, 3 Feb 2023 21:54:38 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 15:54:34 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/8] drm/amdgpu: UAPI for user queue management
Date: Fri, 3 Feb 2023 22:54:02 +0100
Message-ID: <20230203215409.2021-2-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230203215409.2021-1-shashank.sharma@amd.com>
References: <20230203215409.2021-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C977:EE_|MN2PR12MB4109:EE_
X-MS-Office365-Filtering-Correlation-Id: d86c8c9f-5a7d-4565-2611-08db06313f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5DHU9uwpJAGLUW7kFMbD1WTneZa4cGk7o/u2iSNx20JkWZ9Bi4Z2Qo0T1lCHvIKx5L9fMjtR87jeaNZyK7ua0QiInW/M+FZSLPO2aojO92lGvdYDXOv8B/ocOdXyZ5hUEvSaVFKzOU1AtlvzqMhZ5HfO3oJgkXHG5cwLsATf3dHxosYKiNh7ruXQvyJMGLIuJZ+LxPbFE/MQbpU+f35ySwMtdIUkiIq8Y7O2i6PvPIQgDiL/b+LKGdpQLT7/m+1n4Mz12MYlUrFy3npEha2x29l36EGg89jT2swqEAfYfv16YrvMhCIqRqhrZBNrQsK/c1ToxJa9TCFXG5dyPhIp9D2f1yG/WyDQEEnqJ5+VJyorMmuOyr+kB6bI8QQSaQp0166yg/psEjRSUmM9FdO6+qBPNebkSlaKefFmcHcOOVr4A8DUJPTXOnjMx/eLfBmorQxHMm/femMWfY0g+7wjPvMp+wcHQDd4crqN1PcFb6F+X+wjFxn+E19Rmy0sIiT38V8gZDQi5WvNfoa7cO6Qkf4ZShpdZrtav2PItA0u68ksg7HYMu1OF3khaLZDtoY9Fntq5NkfYcaWalEf23iWVVI5nTmg+KwP9QYRUQcCLqAHSh5Uc4hPfs55scWYzhGs6p5tEnVw2FPXLXiPXk15ZBQ3g9JOcM5WjNMOz3+OC0LqFKTfg2fxfTxhDLhM8q5efGaOyJD+zwe04vmMsWwn+WkI3amadFwUJLh6NhIwwg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199018)(46966006)(40470700004)(36840700001)(2906002)(316002)(36756003)(44832011)(82310400005)(426003)(83380400001)(47076005)(54906003)(2616005)(6666004)(186003)(16526019)(8936002)(70206006)(6916009)(478600001)(70586007)(40460700003)(356005)(4326008)(26005)(82740400003)(8676002)(86362001)(41300700001)(5660300002)(40480700001)(1076003)(81166007)(7696005)(36860700001)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 21:54:38.2363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d86c8c9f-5a7d-4565-2611-08db06313f04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C977.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
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

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 53 +++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 4038abe8505a..6c5235d107b3 100644
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
@@ -302,6 +304,57 @@ union drm_amdgpu_ctx {
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

