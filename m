Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC41AC6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 16:05:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6438210EB6C;
	Wed, 29 Mar 2023 16:05:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D740810EB7A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 16:05:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwj6gW3lUeCIBBghWf3+2xh92efgbGFnEJFjVlVIq15r6jQwthwQkZZ8qB7dwfb7R548qduEo38V/tg+KEZ4O7XeneYjAQudzHjilEDwQseVhjEhemgZNQIyS5+HDtpFpzpfHOiiswPxuh0+yE+imhZObETN99okbp40TcFFiuKRFVVLtFgCDPROD44egZ/RJrxoPbKUlDOu+EW/aqp95+Puf/MARqEe0KdqGxs65GNUcsWlt2c0j20r8ZQ8IO7CVoIa2GIxmjTZqrt2mBJhziZPW1UF+Yje97dFFFQjptFZsTDoJlHDxBxB0dGIT3Jd1cKuBBEvZ/1ZzOKmhRZXAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NGX4PkXIuZkXs3NQfDbMRZyrgyvZjDLfTWN7vwOnOE=;
 b=cBPfLHhGeDUXErdhujA7OUU1cn3r7dtb0I7+EDf/a5Kb5HHIa+fJ45HM+4BZOUupFGsqeWTVAXWZ+2nRMr3xDHjSWiWsb/yOZ7BXUOPYcRrq6kZioYh0Xt7CfjhU4B5UPsJnl6kmjuqoqPF8C4VJomYFPrajFMHIq7WYP6Iuaj25mAEQ+AbsCbVXCML+JxH2LkGlR+MDqWqT/qnTCIFWXp+PJVmIz481Wx4RVr0gbpSLCP0ai66uvjY7ap/7Iyt/moDGKQGmOzZDe7SrsM7TR+oRzKGxYsr/MzydWAjtfKkukvMEBjNWh7lvd86bWGeLb5ELDRoJ+K/t+cHHA9SEkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NGX4PkXIuZkXs3NQfDbMRZyrgyvZjDLfTWN7vwOnOE=;
 b=ApH0yCWOUtsvylgOSNwHQDL3RiHYiawtwuZq/ErZ8fXGT89gQxiUIlMf4N9AtyXx2eunCA3ZQOHE7JWwoiSK/pRX5p4NoyRWdx7LaEZa/9GPL+Tpwg0gsVTDXXo9B91uW9acuAaQjXUhwmdgDSpoXNh/+Nn2ksjy9aa56yeDHys=
Received: from BN9PR03CA0283.namprd03.prod.outlook.com (2603:10b6:408:f5::18)
 by MN0PR12MB5882.namprd12.prod.outlook.com (2603:10b6:208:37a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 16:05:08 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::df) by BN9PR03CA0283.outlook.office365.com
 (2603:10b6:408:f5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 16:05:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.21 via Frontend Transport; Wed, 29 Mar 2023 16:05:07 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 11:05:06 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/9] drm/amdgpu: UAPI for user queue management
Date: Wed, 29 Mar 2023 18:04:37 +0200
Message-ID: <20230329160445.1300-2-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230329160445.1300-1-shashank.sharma@amd.com>
References: <20230329160445.1300-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT043:EE_|MN0PR12MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: fe4509f9-3b5c-4a75-c7fd-08db306f5e08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZsF8ZA47dSjUYYBYId18rFM0OfEowIXL4452jHi9pVPvalB4VBXhlepqpFmE3F8jE+4C+yQe9ohdfyKKLtjrGBI4eTsnncNWjkM4tK1Mvs4tPNvEF8t/ihEMLHEuPF8r/p+/N/aaHIETaXFZ0V5aVUDCansknWZdVtK+Fz9IzU2/JwS2sjgFk6iY16jc2ZaKi6ao6WmHHomynkhWiDJ67FMZMTQfJ39jBJ1XIf9tpXlV7gksvKpE6dFMacf4PQhT3vHAhg1J9O2wm5x5DxlUCgz4tWLThdExnsT72P4b0xQOxVlCBKrrW6XpmKlIrC6QvmWwxeucDEf9Am2Yo4qfbL47B6f6DtIAcu/yYf8gSObJKOWK5ZrJV02X+CuiMaaBzZtoTOqEfYmA6za8k6OO0AZEvwGO9Ed2QbskzEDzU+Aef9aIK/gl3s5smk+YUAUsnA8KonHlPE7P7QoOvFIHm14oVeECjYezIdVG8gQyJxYptmTmdY+o4l2xtc6nonmTxfFl+EMAk2zeyXWE0BLiUztnpezQf92BkxJwUm5xgfNobP/i9lWJSS05EcxnP02opq6jHL+Qk02IL0SJFICAQItI1UtRbCGQAlSVCnyk5Z3Hn5yLV6FX4apYbX0jdYpZ3F+KlI7t4JfXZSsKUfjvmX53/r02f1n0C3ulG6zFGqEQIUZ4cRynjzZ1yoevwo8TLlEqEUtzL1hZ0IrMA/281q8Tm6JVaw0ywUDuhIjApo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(6916009)(4326008)(7696005)(36860700001)(70586007)(40480700001)(70206006)(54906003)(40460700003)(316002)(478600001)(8676002)(2906002)(47076005)(186003)(5660300002)(1076003)(26005)(44832011)(83380400001)(2616005)(426003)(336012)(36756003)(82310400005)(81166007)(86362001)(16526019)(6666004)(41300700001)(356005)(82740400003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 16:05:07.9725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4509f9-3b5c-4a75-c7fd-08db306f5e08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5882
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
 Felix Kuehling <felix.kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
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
V3: Integration with doorbell manager

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 55 +++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index cc5d551abda5..e4943099b9d2 100644
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
@@ -307,6 +309,59 @@ union drm_amdgpu_ctx {
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
2.40.0

