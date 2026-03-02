Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288D0D58E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 03:02:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8A9E10E34D;
	Mon,  2 Mar 2026 03:02:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4yCYFUto";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EFA410E41A
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2026 03:02:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzVwe5ANSeUbdQIA72GL2lJT2/baiR91rH0fn9rFtzOD5RJackXmTb+7c+f/Y+7M6RkpKyDYqBJFVr5oAvpPGCGPKf/NdxQ6oFMwzueuNL9/YySwiDA7N4euMVDuVAkQN1J+vKIKytB300OtEJhmAAdUtnUuc340XXEPjcMYpvFKwVEUDc94Zormcr+mBBVY8YFmYx0YYphODlHkyFBU64ldixAeE2WWo31qpbWMn3qaq+Nk/OXuoFVsCu7KAXcUEgAmCuX/JuNRKuL/2IbdntBHVweCxkZqNyz9jhcfjQhWFHzxMcoWc2HW66ITXOyKP0Y8Bn1htC8h62yZQCMhSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jR4eTBBwzmXjbx3RxTOqBC0qTunjfQooghA2c52zDxA=;
 b=dfouYy5WmAcwTgh7atdltWXw6yzmJOiHA66XoR12uQP1MCsIkTgniVRzlNrWBOjzHZSRjpYqY9ozJvxBdSZGxbW2auiineWnpYmkWjSqN6nF0ryLv9Q/r5R7N+PrnfFQd/p454/fP2Tuxig8qIcRBquN31eGnTOcxD4i6n2JpNloY/e6OYxhIoTOaGwyTKIzaNwn0UB9qVBdTcqNjQwM+dKqUMZ1bcghq8f5dPTKNUtJIlHvGDpH/P2fJUCJGjN+NxHwfnBvEE/MnupDsQKSwi16fmjnFylgVIZyorrD0tM29p9rRmHyjf0eRTYZom3Lws62rtgTx5hy85auLlb6CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jR4eTBBwzmXjbx3RxTOqBC0qTunjfQooghA2c52zDxA=;
 b=4yCYFUto4WZNOYdFZ9zAe1TqqAzs6V7aYXtJO38qU774R9dd8LJossnCuapdZ9HzYnQGfDj3veRazrr9kLPyMnabh/NbkhPLGFS1L+SrBlpA+G8O5Vh1uVCfms/AchbZFx+iM0jETfCAc/0aKitL9Yt7iBbUaQF9Y5pkeVqTmls=
Received: from BY1P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::8)
 by IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 03:02:50 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:59d:cafe::55) by BY1P220CA0012.outlook.office365.com
 (2603:10b6:a03:59d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Mon,
 2 Mar 2026 03:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 03:02:50 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 1 Mar 2026 21:02:48 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v3 4/4] drm/amdgpu/uapi: Add EVENTFD bind/unbind ioctls for
 render node
Date: Mon, 2 Mar 2026 08:32:19 +0530
Message-ID: <20260302030219.1734986-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302030219.1734986-1-srinivasan.shanmugam@amd.com>
References: <20260302030219.1734986-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|IA0PR12MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: f8d1abb0-04fe-48da-35b8-08de780830a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: tbI8WaY9BirfudgacEaU8sLrc/IJ1kSBTwxtJGykFc0V9TDrpQv8I8gvupwEQp874MKbsNDK093819WmIpPiezmPP2n4iouPa2hQ66F7qoqzUCWjrpGqSIXigcc+AW0knZRzXWgxGQ0DOUGeHwW6mJujdWOJk8cMThArDll45MR9oKVABW4iZqfhlidhvT79a4l4+KNJNMt+5rueqsq115ezJktHnWPkbYoMSx88/uoGL4tnX1zwHLDwoVTHjWHgoby30Exp/k3Mh5gicQGnbNXSEHULKCIeDx3hLaoDOfgC5rvhkcjgzO0BbmedsWqlyMyGTyW2dVH1RI5Hbw8IjZDUqRagV/LNlmaUUEF0s6BF8xIOOFE3Lz/7jxWduq0wMfUxDjgAW+39r5PTJayvTb6qq0m1Sa1W5EDe1s+vtguhkEBfXaDOwpErrIkpBCZDazMqUWZg1tz/DrFhdLoqQ1mPPpNSpNh4w12TUi5tlpRRasa7zdi0r2tQs5tTwQWSZ/ifmaPsvVNq7j4nD5GpdcRJpomKZB9rc8rMaGoOHB7n/JiqYaB5MsgSvVrHi8tcGUdSaagKw92/xhRhNLBcQlJpCwVAITYSweBBNCQrazUcz2V0wgYaB7OCE2ke2x8YQB2urNktlq1/wPMXalzWl+aTtx2JkZJeyK2qdQWwopb5CB/zt9Bllnh5DxT1SvbnFvRERbn6bfvNukbuDFSoG9nh9SpMHWxksLoDbcyADipMR4h1RXOIrIfaEZJH5LN4H62EDfjwX8qEBKHFs78CRWyTYfRqUoWJTzzE6SDYkNeBebcRjCw602nBb6KCDAR+a6iIYLrqP3S/YyGTWtZaRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BXuwwHIwPofZzGiNKAYedcaPTPBWCNT90LqAR31+2Ikv8pQUuYx1wmi3c+FK2OFRYnj8sNYDXX2R1X72pIhzsMSX5OaPP060EQ5OlVQM1AGKTUSE3+RpJcPnlY6UenZCfQxwrIgLbB+RmtJwzdP+uwie/QoR8/sBodLgTD4lRspHRg4pb38sg+bHTqwx/njA3kII+rw5Tp2MYLvO2eJuKGrt3qXklKsyt/wuvUsiwJ/2WNI2ftngxTBL/3nHKsxXTzQFnyVJ+m3kJQj1sGOe8pbGbGnDtcMDbB2v/FQjc/0Tkzh+2CFvBVjVA9Bvad+sZOoKSkisX2h1rnAQz925akltrul95YmM0tQ/4o5YMEB3ap6bUX+m7Pm5LxKLPEn2xoKuwW+8gKhD7wUaeVESmybufLXuN94TrIXDwVkzV+0txyXNiBn0XPCnHkk286jF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 03:02:50.3495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d1abb0-04fe-48da-35b8-08de780830a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7555
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Introduce two new UAPI ioctls to allow userspace to bind and unbind an
eventfd to a userspace-defined event_id on the render node.

The design supports multiple eventfds bound to the same event_id.
Therefore, unbind includes the eventfd to remove a specific binding.

UAPI is placed last in the series since it enables the userspace-facing
feature.

Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  6 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 36 +++++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           | 18 +++++++++++++
 4 files changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9e650b3707e3..decac4cc44cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -460,6 +460,12 @@ struct amdgpu_fpriv {
 	struct amdgpu_eventfd_mgr	*eventfd_mgr;
 };
 
+struct drm_device;
+struct drm_file;
+
+int amdgpu_eventfd_bind_ioctl(struct drm_device *dev, void *data, struct drm_file *file_priv);
+int amdgpu_eventfd_unbind_ioctl(struct drm_device *dev, void *data, struct drm_file *file_priv);
+
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 03814a23eb54..0393026534f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3062,6 +3062,8 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_EVENTFD_BIND, amdgpu_eventfd_bind_ioctl, DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_EVENTFD_UNBIND, amdgpu_eventfd_unbind_ioctl, DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 8ab8f9dc4cfa..31449c7a0ae8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -635,6 +635,42 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	return 0;
 }
 
+int amdgpu_eventfd_bind_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *file_priv)
+{
+	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
+	struct drm_amdgpu_eventfd_bind *args = data;
+
+	if (!fpriv || !fpriv->eventfd_mgr)
+		return -EINVAL;
+	if (args->flags)
+		return -EINVAL;
+	if (!args->event_id)
+		return -EINVAL;
+	if (args->eventfd < 0)
+		return -EINVAL;
+
+	return amdgpu_eventfd_bind(fpriv->eventfd_mgr, args->event_id, args->eventfd);
+}
+
+int amdgpu_eventfd_unbind_ioctl(struct drm_device *dev, void *data,
+				struct drm_file *file_priv)
+{
+	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
+	struct drm_amdgpu_eventfd_unbind *args = data;
+
+	if (!fpriv || !fpriv->eventfd_mgr)
+		return -ENODEV;
+	if (args->flags)
+		return -EINVAL;
+	if (!args->event_id)
+		return -EINVAL;
+	if (args->eventfd < 0)
+		return -EINVAL;
+
+	return amdgpu_eventfd_unbind(fpriv->eventfd_mgr, args->event_id, args->eventfd);
+}
+
 /*
  * Userspace get information ioctl
  */
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 22fcf2a69134..32c8bb8a9293 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -39,6 +39,8 @@ extern "C" {
 #endif
 
 #define DRM_AMDGPU_GEM_CREATE		0x00
+#define DRM_AMDGPU_EVENTFD_BIND		0x1A
+#define DRM_AMDGPU_EVENTFD_UNBIND	0x1B
 #define DRM_AMDGPU_GEM_MMAP		0x01
 #define DRM_AMDGPU_CTX			0x02
 #define DRM_AMDGPU_BO_LIST		0x03
@@ -79,6 +81,10 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
+#define DRM_IOCTL_AMDGPU_EVENTFD_BIND \
+	DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_EVENTFD_BIND, struct drm_amdgpu_eventfd_bind)
+#define DRM_IOCTL_AMDGPU_EVENTFD_UNBIND \
+	DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_EVENTFD_UNBIND, struct drm_amdgpu_eventfd_unbind)
 
 /**
  * DOC: memory domains
@@ -204,6 +210,18 @@ union drm_amdgpu_gem_create {
 	struct drm_amdgpu_gem_create_out	out;
 };
 
+struct drm_amdgpu_eventfd_bind {
+	__u32 event_id;
+	__s32 eventfd;
+	__u32 flags;
+};
+
+struct drm_amdgpu_eventfd_unbind {
+	__u32 event_id;
+	__s32 eventfd;
+	__u32 flags;
+};
+
 /** Opcode to create new residency list.  */
 #define AMDGPU_BO_LIST_OP_CREATE	0
 /** Opcode to destroy previously created residency list */
-- 
2.34.1

