Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16393FEC119
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 21:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A566210E125;
	Tue, 24 Mar 2026 21:20:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4C9z2Qc3";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C58810E11D
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 21:20:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0p1G2F4n6xqbNTeOdyQ9LtMNFYcuR/tA1TQSRM8ha4x4Hiun+/1KNTFqxvFf0aqH8uUcUtfv2EW4Dx9hVRGzd89diJDzQZD9KwlIpxzcac7OWwY03koFcGzMc4cDkadg+ikrhmKQBST5YsRIHylCq7mN2UuxXIcRWGdpUcu+iaxkn3qOw6nQCuHsoPlmJZ8/xG7Y5xgRL0ZuGmJMAIvALOnl969O1IcLqGqEIphCm9aMzC9E8fsOJu58fDWJc0dpHS48dCNTQ+I6SbXjiBKNLBjlGOpaNvqctzGee4i42krMJ02n3/+t+iWrlQvY5ECW4i0bO4Er03Enij2rMZG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kwb2fwm/cUSLJRQXXvz3OcnXlmqoFONWyMhHxYKkY8g=;
 b=iMTLSvnX0i/mp1qi9ig05I6vl4OgO9KCkLBKsHX4Ht3tdup5Iyu7iEszxq8kz4lv/Ktdy873TOi4VnPDJw1BkSleG7dyhG8BlO2+O72BjV0weQC8PgossZvuzCiMbFfMKOV5KahilCB/NPEhADX0Ed7lZwkmY+ySzcSzfclIt/hVuvQuU8D9/g8XMzqniY4iQGvMLmMi2XdvIiR4YYoBKddP7lDr1Hj9TmeP0dSCZg7eKRs/pbJPFgXwEL74x8h7bkdcg3KULweKd2R/rKonGGIltM988vQ8RmDBP2St0UKE30V/FhirTAMVCYvugJiUbrLnMk7dGqQfqG4MM/M+cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kwb2fwm/cUSLJRQXXvz3OcnXlmqoFONWyMhHxYKkY8g=;
 b=4C9z2Qc3rXdCzLuALQd7GullUi6TTNOPtBl86rOhyF9LXby6EMPNRQspW95/An46eC9bHPn1eyzsCrKv0rKk5e7Ee0bIFFBbeFKzaCNrcvYLhqhhiv6QS5c836dhod400iJkwkwspQoDFDtWI0hNskYshl0sP5bhrFwEWfgrQ14=
Received: from SA0PR11CA0196.namprd11.prod.outlook.com (2603:10b6:806:1bc::21)
 by MN0PR12MB5737.namprd12.prod.outlook.com (2603:10b6:208:370::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 21:20:48 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:1bc:cafe::da) by SA0PR11CA0196.outlook.office365.com
 (2603:10b6:806:1bc::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 21:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 21:20:46 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 16:20:42 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>, <David.Francis@amd.com>
CC: <Jesse.Zhang@amd.com>, <Jenny-Jing.Liu@amd.com>, <jamesz@amd.com>
Subject: [PATCH v2 03/17] drm/amdgpu: implement profiler ioctl
Date: Tue, 24 Mar 2026 17:20:16 -0400
Message-ID: <20260324212030.822932-4-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324212030.822932-1-James.Zhu@amd.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|MN0PR12MB5737:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b5ee21-6817-4742-515d-08de89eb372d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: m7W7w3czeh6zs1Sx9Ytxw5FlhD1Vn1t+jnYIgdaiIhp0RBmX1QTt0SvGW5GBwjeS6JybV9W+GLSFMweWcBb9pdGBuvPD1cDn0ya+/P0uOTzfYbWxIUenXMJDYStafgBs++LdwluNAL/V7/f52zehBEpGEt3eQnLasCDVX1FQfehz/pek1LADk15PZnaKLtoEkdHfZDphOacjm0Yx5QI39pLk9C+EvQxP/fJltrVjek7hgLNKImjwTcgr+OhKI5YskqRieC7n6gV2UEsU8w1gF5TTeelEjjPtuJh4H2zuTeJHv4ZMHmKukCi9LCifsql9evY2jbqy8FEm7MWvgWJc/bwO1vk5JgCF54QyuPsVcjSy5aEoKmCBxEQYdDlSFJQ4aMSCmXsPl9U9Dya0pc5E6DGmIo2V5WNLw8abOQ7D+cT6XyuibW/V0Hu3kkgjpzPIo5ubWSXViXCL/CWaJ8MDcTX5Vaz2gH6YqnBoSl804kReAGqWvNc9U7OCaFIfBF2HSvlgoLEM4YmwaYGdfrk5n4GLZGbOOlNyGEg0cq57CP5iywyFpKGOeE2uyBxRJTgRBa33Q52ROcFHGWlyBsFCuQu2y2+SB0zdRu/GUWeaCk1p3wnGfVCmcpIeLRx8tnQNoAeT7twPys+DtUoFzQrQwG0SX1U/ygD3DiCb3UooqwjrZ5W2fQx0KbyokSC4CNGO+T1MJ0bbbboXTWulN7sSN7RnDHhcmbYR6B3rt5C8bt+FxyUyrCAIjXmhcl32AYtAPHS4d+PxWxzu2e69v/2WvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VMJv5T8ufGtnClivpHJ65YLV8Y+SFHiX9JvprbXfBSg7wxwm6Eoo717YZsaAPUV6Fe6aubAJUcYtyi7TCPsvJyAUPLaDdhQA24im9buGkbUzD8PuA+e5UwVpijVnp9uTDULQMPNKAjJTFC+eIOcxPqPkJ8JShhue/1gvKqt78ytmhuNNlvTfBaCeOOrAK28JrILPm62K06TupM3xSYspqZIlosF9u8qLKmtePVhWdczDU/jQSqukSj0NsMubuXe2JgkNzAZwa34RiK3RgZQAq1taPOl3MjE0Hx1TdD586blr/xNZAuZ4Ww4YwKHImhjCQjj44l8rcsARn7gScZ4O8o45AHHUzhyRmHQ6INujwmzbLofeQQegOPqY4wjCRwDbRLVmFWV0U+iQCt6b4K/TZL3L6Fw8Eki2lndwXqhfJU0xNa2rVlowPURRJtbcYnx5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:20:46.8583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b5ee21-6817-4742-515d-08de89eb372d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5737
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

with wire up the DRM_AMDGPU_PROFILER ioctl introduced in the
UAPI patch by registering amdgpu_profiler_ioctl() as its
handler with DRM_AUTH|DRM_RENDER_ALLOW permissions.

Implement the first operation AMDGPU_PROFILER_VERSION, which
returns the profiler UAPI version to user space by packing
the major version into bits 31:16 and the minor version into
bits 15:0 of the args->version field. Unknown operations
return -EINVAL.

A helper macro AMDGPU_XCP_ID() is added to normalize the XCP
partition ID for display purposes: AMDGPU_XCP_NO_PARTITION
(device not yet initialized) is mapped to 0, while valid
partition IDs are passed through unchanged.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 25 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  3 +++
 3 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 52423c98ebf5..dcd36a6d2930 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3064,6 +3064,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_PROFILER, amdgpu_profiler_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
index d2cf0520c6f1..bed43ea8bcc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -32,6 +32,31 @@
 #define AMDGPU_PROFILER_VERSION_MAJOR 1
 #define AMDGPU_PROFILER_VERSION_MINOR 1
 
+int amdgpu_profiler_ioctl(
+		struct drm_device *dev,
+		void *data,
+		struct drm_file *filp)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_device *adev = fpriv_to_adev(fpriv);
+	struct drm_amdgpu_profiler_args *args = data;
+
+	dev_dbg(adev->dev, "Profiler IOCTL op %d on render node %d xcp %d",
+		args->op, adev->ddev.render->index, AMDGPU_XCP_ID(fpriv->xcp_id));
+
+	switch (args->op) {
+	case AMDGPU_PROFILER_VERSION:
+		args->version = AMDGPU_PROFILER_VERSION_MAJOR << 16 |
+					AMDGPU_PROFILER_VERSION_MINOR;
+		return 0;
+
+	default:
+		dev_dbg(adev->dev, "Invalid option: %i", args->op);
+	}
+
+	return -EINVAL;
+}
+
 int amdgpu_profiler_mgr_init(
 		struct amdgpu_profiler_mgr *prof_mgr,
 		struct amdgpu_fpriv *fpriv)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
index 2dfc0b1bb207..779cfe19fda2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
@@ -25,6 +25,7 @@
 #ifndef AMDGPU_PROFILER_H_
 #define AMDGPU_PROFILER_H_
 
+#define AMDGPU_XCP_ID(x) (x == AMDGPU_XCP_NO_PARTITION ? 0 : x)
 #define fpriv_to_prof_mgr(fpriv) (&(fpriv)->userq_mgr.adev->prof_mgr)
 #define fpriv_to_adev(fpriv) ((fpriv)->userq_mgr.adev)
 
@@ -40,6 +41,8 @@ struct amdgpu_profiler_mgr {
 	struct amdgpu_profiler_xcp_mgr prof_xcp_mgr[MAX_XCP];
 };
 
+int amdgpu_profiler_ioctl(struct drm_device *dev, void *data,
+					struct drm_file *filp);
 int amdgpu_profiler_mgr_init(struct amdgpu_profiler_mgr *prof_mgr,
 					struct amdgpu_fpriv *fpriv);
 void amdgpu_profiler_mgr_fini(struct amdgpu_profiler_mgr *prof_mgr,
-- 
2.34.1

