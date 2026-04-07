Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CB9105D986
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2026 21:36:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B92110E4D3;
	Tue,  7 Apr 2026 21:36:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="shO0dLPR";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010066.outbound.protection.outlook.com
 [52.101.193.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7244210E4D3
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2026 21:36:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOdln/lEhPuNh3e/Y2QeGwXA0e0mnP1Q1x5wwyKvqIOH7mkCryL93vpm3BJ3Npf7qagNlUSC74AoXBhTvfI0OWkTjAbmjiLC3O5OR2Tupd5e3Q5m/fdUx3R32xIJeX7eX4i0i9WizCOsr9/Qucrt7PU7OOXJn3Y3EdSXFg1lu2iNQuJofDJgjA/QTE30XUlN6AJfWiD27llEwQB1sGQr1AxpZl/SdLxD88E3+UjI+lFt5uHJP1j7pfZSdgrwCV7bvFO6kxlH+4rYsbx5DGNeVN90zOfDrltlJ8od8/N72Px/9ogxxknPvvnvD65ETwHJDoQwQs/Z9PgUc7BhttQ/qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgalB/IkUSzRLo41AF+KE7R9o7CFFhTifrYoLwPxuqk=;
 b=hogKtF8qxaAABmangut7tua5H5mpxEc9/5vx+YKNjhBeidSbXB37r+1XJiWe1I5jF5ycXSWSDQkkMJvZNPeAXgCGLys3IyS3zZi0EvhBo/n2o9rvvmne+ePAiHOFpVD7gyaJ2d5SHAWAsQv9jCfjW35ah2mumHbl80vpbxCCANrqUAYoHpr+H6svlgffMJeTD7TnZhXHm10S6/IkswoCWGsdbJd2Y0hUznPCBZdKYwg7A+uliNbdoZAPL1gV+ucx9nBZgqpaqX+KU5N/pna9AOTPNbDbS9ItZhRZlqWODpv/eP5JNxm4izNRE4EzTmVtT3bNEGBxfxXDLsb+tw2tzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgalB/IkUSzRLo41AF+KE7R9o7CFFhTifrYoLwPxuqk=;
 b=shO0dLPRD/g8IBmprcyu9druomf/d/p976e6FWuQXIx2MSdz6ZEsARxBLL4HYLs9HFxPgTTyban9Xuk1Qms9FzNkSKDgbRUDSj8/7+CLrZx9HkhPQju1M2/1f6wRF9UszSiLb02bPADRuOow8BxtQg39uGUM+UzJvvYCfUQ1rZw=
Received: from DS7PR03CA0235.namprd03.prod.outlook.com (2603:10b6:5:3ba::30)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 21:36:06 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::a0) by DS7PR03CA0235.outlook.office365.com
 (2603:10b6:5:3ba::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 21:36:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 21:36:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 7 Apr
 2026 16:36:05 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Apr
 2026 16:36:05 -0500
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Tue, 7 Apr 2026 16:36:04 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH] drm/amdgpu: Remove sys file compute_partition_mem_alloc_mode
 at module unload
Date: Tue, 7 Apr 2026 16:30:32 -0500
Message-ID: <20260407213032.4087036-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: xiaogang.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: af128525-d500-478d-e71a-08de94edacab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: L2ZUIAvRKg/kvJYVlmHJj66ki9m6OtIoRvXWDuUtrPctDTz51PTbprOdPhq2VwOXvEftLb5RaomdZrIssvKK0jb6KXfOvweBKqDKFts7/SiIW7FuNnk7tzwCbjl3XPGkdbarFBScgB3eAc7SpEOhfNQY2wp8zt2g5NS20336jnJ05dr8b36XoVqry5PL3dv66y9znGCrDQlkAAhJyRPdjetmvgp0H+z2dcanhjBCV4bYnLq8hupI8wbNqtR9v4CukIaOv3AMQY9MbiAPAwxCdohMxBvjuDcFDtWvi7GauenZ/xITmxPreibdYznRAyxIOLwkGzfgyNqy6hY0jyRDeyriEbGXoCfTONooKLZa+2FxeaicFTLXEFllrvtvYq7Lk4e9CnAEdQAmxvYKVA6BZf8JTunfkd3zRwIxDW8x1xgAECTt7cFPSdpZuIfCAA1/IUVG7u6LCkF81n2yu2jr8rwkpZv8NCj/iWTHBkZNzLjtpms3Mt7xuxhMQ/Mhvja4poPOgQJIeXrc+BiIlSZMyyaJP4PMcgT6aXG+TPXgz19xeUd+eCYPRO0bSKF7bIu/FiaCQl9OcduLafZsAxulj0f/qIG849AJ5HmW+g4rIKragO7lEc/260Rt/7TIqkU9usUapR/E1YJCr39QUjtjKQBPnQkd3meD6C1Ei0McMSerNuU3BeuzNTnAEZKhBEQYIf5B7ZsS/svefEvAR0ggM+GDRwYTal9ZPenrB5o3d32KHQtrQx+jHhhjwEA43KOmdorXAGo8fzvZ8B67ujLiKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w6MGoo59e8DzDXyGL3WHs1ETVNPNrLjwQkYg+05QshpyRTNIP7z3c3D0B0aiqWhUfefe3SYljj0UTD+EwlbywLwY8ih5si7j8G3+tgSlUsfC5LAEAAvANwOIhhSNcXlsBtGEXr/2/yECdHG6IWD4k4Yc9gR1829f6eBAdrOPxbX8WB9OT4ZKr1J7DudqTlr2XTJnIGEaniPn9UW/8z8Z6kQKsVF8tCB0aD11qQ5YMYPzlXh74VLQiIn1xMIihhCZS/VyNiWyUH9BwjiTt+uEjPOhMzh9faC6sYZpLrCfuhVfrDKqIQbIFrfGnqATUMYOAYbobuKWME2tsFbhnlS5COKbY2j5PN3NOJNhLm9vyEJYmtoSVcdUtNguggfsJf0722tQuh7GGtpzxH4jB6QGP79WmxQF6GRDH/WN3w63E9RL06MZymYyBP8JW/4lx9v+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 21:36:05.7773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af128525-d500-478d-e71a-08de94edacab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

Fixes: 147263e551eb("drm/amdgpu: add an option to allow gpu partition allocate
all available memory")

Module reload would fail when create sys file that was not removed during
module unload.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 2956e45c9254..b8ca876694ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2013,6 +2013,8 @@ static void amdgpu_gfx_sysfs_xcp_fini(struct amdgpu_device *adev)
 		(xcp_mgr->funcs && xcp_mgr->funcs->switch_partition_mode);
 	device_remove_file(adev->dev, &dev_attr_current_compute_partition);
 
+	device_remove_file(adev->dev, &dev_attr_compute_partition_mem_alloc_mode);
+
 	if (xcp_switch_supported)
 		device_remove_file(adev->dev,
 				   &dev_attr_available_compute_partition);
-- 
2.34.1

