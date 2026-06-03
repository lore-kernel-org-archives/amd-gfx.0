Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39E6CD6E55
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 16:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DC4B1120D1;
	Wed,  3 Jun 2026 16:35:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AEqiygOG";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012062.outbound.protection.outlook.com
 [40.107.200.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC3281120CF
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 16:35:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wm4jX35c8Lil9Lt93sUdkEytZmjElJq8ldV22KU9nf8VibgSWE0rehpsRvvMMXSJ58xjyu6HYYdZS/eIdJtqLCkZ8swN/GB/m1XXhtiuVupEMUe1wRGOhvrhHNeYXMTTVaDvHClV4N9ljc1Fs0kk5CmYaAN0GHQeIKHUoikddH35OxRJxUxSUFg5W/VG428WigZ/wRm7yD0WTwXsliwIagQwhJjNOPlPJWH+cRvhHo41Tch92vhGKQPJfDsKfdQR9sPJNn6ez4X/Ewv7OJ4AmjAh/bNUtGS7rfHWrLAOBzkl9tM1s6pIsjMhhDxuTMJKN2ZlvjPv02D0wpTdVWJa+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VroqJQPenhYfHVyanS5GQsnHewi3/78SaiNVif5OqQ=;
 b=hA2f+7ngSaccFZjfu6eF8tyZ81izWn21W64fuxj5E0qkmVyX292ykZuxdKNnNZPCEKWHURY5RAX/GJ21KbkrWGZrs+WFEB5lAoEQgkV3tH+YzibXHrR5TNgX8sw317cYiJzp5++2Hr3aqjSStB+41J9svuw0Bcwxt/fyhDQ1Bg8ythRJZVLnDSHFg+fMwU6p2ZarjjF/Rq71RP1WcaTsB1lxwDzs4StaPlQ/MuFy45Bd9bIwmCVDKvy99Ugf/Wp652R2ox1WfLup5E5r0qNwsNpEpgGbbCt4ogJ7BfWt0fWQ1228W7Kkp90s9PrpQE+Rruy5plCks6LFtd9cAum8Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VroqJQPenhYfHVyanS5GQsnHewi3/78SaiNVif5OqQ=;
 b=AEqiygOGrvnN+3NPhJ0Mqb/f6KK1pOvxHvVbgO3B3a33AhQ3bmCONtXA0qYieJItPT5JWDlMLA09Mmw+o5uqIEfv7HD3vgQFqpJJfQwtRSPfBzFdBLfkiFSZ9c8XaLmjCEn7yNOrJ7xrSmy+XqebAnD2scy/IG3DLMb3Axo2yUs=
Received: from BLAPR03CA0080.namprd03.prod.outlook.com (2603:10b6:208:329::25)
 by BL3PR12MB6618.namprd12.prod.outlook.com (2603:10b6:208:38d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 16:35:15 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:329:cafe::4) by BLAPR03CA0080.outlook.office365.com
 (2603:10b6:208:329::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:35:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 16:35:14 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 3 Jun 2026 11:35:10 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 03/11] drm/amdgpu: Register WAIT_EVENT ioctl
Date: Wed, 3 Jun 2026 22:04:42 +0530
Message-ID: <20260603163450.2678374-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603163450.2678374-1-srinivasan.shanmugam@amd.com>
References: <20260603163450.2678374-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|BL3PR12MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 76852669-471f-4c39-7e26-08dec18e16f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: C+WylKZCx3xmtuHyLrST3X5/NzlUjuVgZpsSwA8feHyRIRZ5YC4qaJCIVnVfuyXU1GZHe9ysgxAqL3HqK8xEPIoRTnsVr49dXEi1iG9H/g5Lu8v6IDAEvK3CoLrdu0QcUq/AFnmpj8piOr3kumce9MKUYjwqTNmp0EV1Q/RW55aJeTd2gNU37Zb4HXxiLbHtU2V03bJ2vEaXDU0HxANMub0hX4wN1F4RM556BN7rH3vBdXSCWdN8J4BbeY49ZVmjg0K+nguHCOake++Ylx8hQlZ3YMAKleIYEs4oh3JKzJVgA6mUz/2vgnO192fvuVtU1U9036mmyea3qu1AtZwMpI9rXonMIIjXzVjK4s9/5VMKLrx3Xdu2Hbmg5OtybZHAvkv+AqrUfdEsuhNLcB1KOkYYe6mrkKwWvkiB+sU6+CVwlyQIKiSjiCkwGU0z1TsJq7EGWHFeWq37mEs4j4pqw0codSeGaM86Glsn+xMNTtlrqX42+/9hwoRHEVNguyZ4UzGHQpMU8n53W/HRJ7w0UFvpZjH9nIkTdm6OAZJWac/G6WPeH45LXDuD2xRmqPX/0MwIYGW5/NDD+vLeHDMMXz52Sm/sH4LLCGxkg8dF8BnZgDNUciErdkEmXcCEs3khTSCLQZVOw4U+lhqLyK/huUBlSma50AR4XvPgeAmVTn/u4eeFMI+tTmrdU9tqVXhJtRDtsuQ0qQ6e3GJuxO9pqhuxG6J4NLQ5HAgU8Uurspk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ujy+yIyXw2Mj6ta0IjPXMUYOwg6R8o4iAQ9ro2mtxdnO7CE9U0GKKZwvjuOGoPgcNPUVGzkgQvofVF1YU7Eh3jGC5FqL8+k4NTX8axkK7xRH4+8dhMuWTlV9/fEodufLmHMmm8OCO5zhj/cM6s5Ey0LbXA+Xw4p6K0wwRg1Ha3O6W00JRZR3R8+wUvnSoyBYESbMOC+GU9nzikfbgC58T+iI5IfpjdbHh7VQhcO1533+6eJDfKaBxkk8OZCuPCwRJsbIDgC3nphttnTPKY3US4eT2HMYRwBI1cEzBmbS20h6bOMIfhMfz2vhnbH6SVlXjRoTiQhCV0GseMgli8aqbVJC0fE8OutPtSXByTsK0WuGigJ4B1ImgSr7ohvSy5XzMPeR0K4pgo2nRov4mo+K5EexpNFSP3oI+EbixSYOix8fwGTWlMVw2KiiMpmvTuyr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:35:14.7578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76852669-471f-4c39-7e26-08dec18e16f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6618
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

Register the WAIT_EVENT ioctl for render-node event consumption.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index aaa4dd57099f..33f2330ba640 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3077,6 +3077,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_EVENTFD, amdgpu_eventfd_ioctl, DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_WAIT_EVENT, amdgpu_wait_event_drm_ioctl, DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
-- 
2.34.1

