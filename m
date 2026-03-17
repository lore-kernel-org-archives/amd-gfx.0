Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C57F3380B
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 07:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FE7410E51C;
	Tue, 17 Mar 2026 07:48:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OZNe7m1T";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013019.outbound.protection.outlook.com
 [40.107.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6940710E51C
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 07:48:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MipBO+Sq5Bnp1/u7aYRv+EHqP2y1AGzUxTAxyHhwLModBnWZITS3gODgoICKSSuW8KtrSaSJ3/p/eUEdRIKhS/ngj0WYcQN1IXeolkAH8dI+tj+lcCDNKjfyqS/cBxbtGt/EAMHmBqxeQjC5EjeJODEWPQGQTMB9mqCazeSolbg/0woyFWahkv/YQd6madIFrigrK8pX5MNWDM+8WeQblb7WnWiY3xSYTJMmre9f8amvi2oEZpOIpDW4NLIc4JG6uM3KitkKYXG4093IBGe3Axa9swNA3DQ0PwyesK4QIG8Afw4Uzg3O6d44P931RkU4eOcp0cX7XAfhcvm3eaq+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+cKhbNalHsn84HtWP1MscYrHQCY0xpLfVBmo8m1VLg=;
 b=w1rMGG1QHpsxWk0hyD4acj/2C3Lx8igmU5w/h8M/BgYcZ1QCWSvtbqb2cqzwqxxi3wTUHLcBEVrdZi99XEnKTDGpPomQR1V9ntw6CNEOmGHSq1aN2oh7WCZGDnXrNOnpkbZI9kB4RGJ6N9f85hp0MLgXk8NTKgr8C0SOiIUWTk1ZS/TtZHqoRRmP2zwKmwP6JESss43mr848NehFDrgqFwxw2rK1sTSVE/ckNSklKKBbv+wjM2RttCsa+ivDccfoLHZ4InIsJc/kppzUye2LHkjxsvXPacqHV+fqLfpOUPSQ1qD5mHKDbzEyptSFED2LqPEUgOu2iRYkmaqsRm0EEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+cKhbNalHsn84HtWP1MscYrHQCY0xpLfVBmo8m1VLg=;
 b=OZNe7m1TjUXGhS1gmknIqCVOMDUuRduY89ZfJdr5wmFvzg4nQxOx/rsRl674IZBTc1FtsG1ZL/g07QRbyNCnKdlHe6eFMnO9KKpaJzenw9lYMwXODqoDptj3qi486emmXLJALcV2RGTFqrKJiIyU3Y3ncLhEy+EwE1cyMG/Atts=
Received: from BN9P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::35)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 07:48:28 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:10b:cafe::dc) by BN9P223CA0030.outlook.office365.com
 (2603:10b6:408:10b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 07:48:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 07:48:27 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 02:48:26 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Tue, 17 Mar 2026 02:48:19 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>,
 "Vitaly Prosyak" <vitaly.prosyak@amd.com>
Subject: [PATCH v3 3/3] drm/amdgpu: harden SIGNAL/WAIT ioctl argument
 validation
Date: Tue, 17 Mar 2026 15:47:28 +0800
Message-ID: <20260317074804.2363458-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260317074804.2363458-1-Jesse.Zhang@amd.com>
References: <20260317074804.2363458-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|DM6PR12MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: 319da782-cdc9-4930-ba33-08de83f9936f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: iPECeCh863tTmpSISG4d0lO1N5nT5d82zoiqrt3gQN9hLdcwPq36MaXH13vvVx3XPLsGRCce8aKXTA6/z9ksYgHWPPMqOV6kkZjPMt91RgDQsHI0KxnHz6LhxXU4K2+LksA66yJtqCSiP6eiHntMOUOG8nh9oX7PeR0rvX8+DikIRVR1ymFq7o4ZD1g/CtPlKwo7IHBHqCwd1tIx7Im2rQQClpYeOiUHy2PVKZpUhWJ4QuNTSZAX8PjIFYUkbAtmSmncbOXjHt8bUwqWTBT30tWw7Fkjo1qWZTadzMqQaC4EAs+rNUjAqZC4pHovuB4sI5mkRZ/mT+O5h7/7NzQM/tYE9eGTf7bv6WLfojkkOlWWhoINg1zFqR/3MJTbeU0qMh0dBdXnuhA2tXlfYCexlJ2s2pGjWpt4PwQm9wr4asYKgcwBwdoFiuO3iwSAj+2FKeq6D4NgbzBMZcE58iVX3tyEBoCbBqky86AA57/9GlBQCzkmvHqO/y0zmmdWGOMv1xisJqJT+qmCz7I6jGLRvRVtTFjog2u3WoS5AVNMgyVBJv0RWqP+PEObvrw1I/m456FsQIJjOkuObchgw6AN3LBfkE7rJOQctVkT6QJmjrw6uPSfFhUWCAqNu8Dg22YbNmTYju2Hy5IkaGWhnmkQLEbmZ6/k2fdLg8cPDYKJv1rOtn0vISU4rqu5UrmeEvC5txWaX4EUZsFf8J6IjANV6d7jgcezIJasqsvCrDJ4rl/fhRCPltS8DTGVLWIYQz2++wqeJVDg1ALAekvDt1my2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /+Nw3S1y8ev24Dkhq8RLfabYL7JdKm1XHW7XHyIZSc55j5pzwrkyPvrGuOIDuhm53D8LyzyUgRF9Nq3GQoMHYmSSVoOU0SheGjEXgo4yep7dSbYO8iUs7Vs4xu9pJbGgvN5Fl6RDDWJoD81Gg6OnPJOQe8lsIdJUX/Duhe9+Y8QtuX+zBE9a13zs7hy7nYAe2bHZa8d29BsyPCbCGmvbHov6FIyaAHd0XQLCsTjY+an39+z+O+GnSrephpgO6nuSEy+AVtTJ1xBCaqrWWJoi7uMAg9r4EPIKdbVeiqeEg2Gw5OlTzPiFn94wbU64DTQDWnvvUVcySUgn6tTjL3TEgopEEkbVVTpKKzBnIVszgIp5N10iZc1YYQCsTeAa5wqjfe8SD7nckMXfw6C+QI0dgR5z4UAysjkNNeG96Dxh4kZDoEXPaSpxT99gq5dn1FJF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 07:48:27.6432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 319da782-cdc9-4930-ba33-08de83f9936f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299
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

Tighten the early parameter checks in the USERQ SIGNAL and WAIT ioctls:

1. Validate num_syncobj_handles against AMDGPU_USERQ_MAX_HANDLES in
   addition to the BO handle counts that are already checked. The UAPI
   field is __u64 but the driver stores it in a u32, so the comparison
   must happen before the narrowing assignment to prevent unintended
   truncation (e.g. 0x1_0000_0000 would silently become 0).

2. Reject inconsistent pointer/count pairs where a non-NULL userspace
   pointer is provided with a zero element count. This is clearly
   malformed input and returning -EINVAL early gives userspace a
   deterministic error rather than silently proceeding with empty data.

No functional change for well-formed userspace callers.

v2:
- Reworked commit message to focus on parameter validation correctness (Vitaly)
- Updated code comments for clarity: describe the type width mismatch
  and why the early check is needed (Vitaly)
- No functional changes to the code itself (Vitaly)

v3: drop the num_syncobj_handles > AMDGPU_USERQ_MAX_HANDLES checks (Christian)

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index fad595401a77..5ff8fc815e45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -484,6 +484,16 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	    args->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
 		return -EINVAL;
 
+	/* Reject non-NULL pointers paired with a zero count. */
+	if (!args->num_syncobj_handles && args->syncobj_handles)
+		return -EINVAL;
+
+	if (!args->num_bo_read_handles && args->bo_read_handles)
+		return -EINVAL;
+
+	if (!args->num_bo_write_handles && args->bo_write_handles)
+		return -EINVAL;
+
 	num_syncobj_handles = args->num_syncobj_handles;
 	syncobj_handles = memdup_array_user(u64_to_user_ptr(args->syncobj_handles),
 					    num_syncobj_handles, sizeof(u32));
@@ -642,6 +652,25 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	    wait_info->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
 		return -EINVAL;
 
+	/* Reject non-NULL pointers paired with a zero count: the pointer
+	 * is meaningless and indicates inconsistent input from userspace.
+	 */
+	if (!wait_info->num_syncobj_handles && wait_info->syncobj_handles)
+		return -EINVAL;
+
+	if (!wait_info->num_syncobj_timeline_handles &&
+	    (wait_info->syncobj_timeline_handles || wait_info->syncobj_timeline_points))
+		return -EINVAL;
+
+	if (!wait_info->num_bo_read_handles && wait_info->bo_read_handles)
+		return -EINVAL;
+
+	if (!wait_info->num_bo_write_handles && wait_info->bo_write_handles)
+		return -EINVAL;
+
+	if (!wait_info->num_fences && wait_info->out_fences)
+		return -EINVAL;
+
 	num_syncobj = wait_info->num_syncobj_handles;
 	syncobj_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_handles),
 					    num_syncobj, sizeof(u32));
-- 
2.49.0

