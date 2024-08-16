Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D66C531DC
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 07:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D75A10E5C5;
	Fri, 16 Aug 2024 07:55:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e4k0lPDj";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEACE10E5CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 07:55:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVaCIwY/IS2eAgNoHuIWAw0xGu18jAhyfRZA6KYatRWbL50u3qFy5zj+cQ5B5HWs0MHd3hziPagOxMz6/QOw/2Y3SQERhGXpSYfO+DQGxLosfroYyYtFnlOzxodpK+N8hMpLaVRK8N9vp00YQPsz8jNEWeXbw6zafgU9QoHkC/10sDF9P+kOYamEeEZVUwWzn+XcAQPHcS5BEGy4O+H8ISw1WHQxRoPE1zkqkZ20YmbKtCof9PfUVi5i47p7e8o/2mRGia/y03igPxFcuL5472UWlh4GL/y+zHq14qxD6MOhhhJZMAp7AX92aPZq/IbY8DhjSG19FBcDagxYrLG9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npyWtcxOgUcWLsTdnnE4Lzh92XUDRZrWCwbfxh2o0Vs=;
 b=hYlTOqCwUfyJH7dGAsMOvSC8YcHL0/UvhyMN6lJ2uNKL6oJG+HIl8zOrKnxAMHgn8TSwm/5n0Q6Iz3SEbZ1JGNjxu+mILlxWWGEgLtR4dqqMSVo9pT+ExQNcxzumYfO80su1Q25lqt9KsTJ707HnrKDH5ncIRD9YntNmsexbwLrOsNMtu28vpvXqt30FtOzIVNn31+NykjWUm/gq4In6VqiT6gG+6/oBcxShwvmVGx8522TUHX4CDk1bmok/klXFqSHelc+tI5g1xADUE4SdRhwzkdF5EaJvSSSo9AQUpWWCi8bH6TMiArMTuPNx5ugEP/U9VVU5umYz1Hi1TfKYWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npyWtcxOgUcWLsTdnnE4Lzh92XUDRZrWCwbfxh2o0Vs=;
 b=e4k0lPDj0DUdtqtqdV0tCiAYwtDGQePCjeQkZIbNA4WUcXteU7X7CvQwwIXLUEHEnGVNCiLUfcc+uxj+ikrKb15vCpqnUCswxL+qqgLRqUpffL8g2BEdjgWfPI4ovO1s7/8jF+59j5MmtaYLjjTrCqXB4j1rxEsta42gE1JFcRU=
Received: from PH2PEPF00003859.namprd17.prod.outlook.com (2603:10b6:518:1::7b)
 by DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 07:55:06 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2a01:111:f403:f913::1) by PH2PEPF00003859.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Fri, 16 Aug 2024 07:55:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 07:55:06 +0000
Received: from lps-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 02:55:04 -0500
From: <Trigger.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <sunil.khatri@amd.com>, <alexander.deucher@amd.com>, Trigger Huang
 <Trigger.Huang@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Use gpu_coredump to control core dump
Date: Fri, 16 Aug 2024 15:54:45 +0800
Message-ID: <20240816075447.442983-3-Trigger.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816075447.442983-1-Trigger.Huang@amd.com>
References: <20240816075447.442983-1-Trigger.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DM4PR12MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd709f8-d282-4f4f-6117-08dcbdc8be45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?naBp+nue2orq9+UYEch4bE55jhCDkhcHNJBPAKc0yMDy4lw6GTZ8oJxdqWua?=
 =?us-ascii?Q?6DDAzzk+Q0dvSK51cX4++XiGSN8YcrGx9cNML97J16o6WwG5TZqJAXEt91jf?=
 =?us-ascii?Q?soinXvZvY7q32gMkVf/udD2DvrsaH3GHNpkPBl/vgs1g/nJD6ejHh3Xa1jWw?=
 =?us-ascii?Q?b6IzDyDABY7k2DIIoHnCdU3oEhDaPkcyKtWvXQoLyyFYYfki6kw8nzvhHr6T?=
 =?us-ascii?Q?cN5wWYBIDYSyzWrpAm5u/kv3Jw9y0ZnbdPMLfuB9NphGnaAWvxDpsUeF1WfE?=
 =?us-ascii?Q?8T+CwvLJjXlH5CZmGMf0PQtEjyovJ+r4TQZMOcuEDn1ThLnucsQq5yN8i3Al?=
 =?us-ascii?Q?5hN72YPNjqH+pRj3748SQTv9KUFdCmkE0chHhgak1kq/4HF/qbfrzXa1HN6W?=
 =?us-ascii?Q?RPyk8SqM2IzkHo5Eae4DcihAK35lxiwMLNvjAnj5vg2C+ulVG8abjWqRIiwp?=
 =?us-ascii?Q?+4E2uBQwaKhACkRD52S4xE7zUbK+E+1Ltlfct+Tca383PjXlkmMIA64S+BoD?=
 =?us-ascii?Q?ypAGuD48tN5fXg4yM5kamfKwZCQp9RO8xruU6lNipEWR0px4VL7yRtTZR0X6?=
 =?us-ascii?Q?pzUMACJ6TCIHaP1RWEwtEmxWhJxOybzh3/7GAr0+AXY+RwnYYzSJhGriK1dE?=
 =?us-ascii?Q?DfycCv8eCqb67+b6VnVYrY02CYPzLgBvwe8LDhaI16tYvffTvkEjL8rX3nPV?=
 =?us-ascii?Q?qHhV+DVggrDwyD2MSOkoyTY9LkT61GfIRQGBFPtFawXSn751ZOVxU28vnX+F?=
 =?us-ascii?Q?LWH82mI/pyZTtDuWCkhd6CjrW7MmQ+QKBsfKdg6xd9XT9ziQYq4n5rDBDLI1?=
 =?us-ascii?Q?aUuN4BCrMOZqWsPfq4YwxS8SY2jrTqgx9bSbVJ7ihqftaukqNRf7n7iPky3n?=
 =?us-ascii?Q?JPsiSmkgg9iEBXujOoVNmagUKbtYBoZgHCdgUDSj8VySvNUeMoblQKM8OwZ0?=
 =?us-ascii?Q?Dwead9+YrZr/XtdHWT4uwF+cbhdzQDF1XrVJ+6oXSEzb7QtcLp+2auF6JRMZ?=
 =?us-ascii?Q?g+e7nQGB8dLQevfjFMZ935lWTlhqj9vHvRYj90zxRNKroS4hb4R9jNsw46e8?=
 =?us-ascii?Q?vuxqnFoTjd1cLVrxCON1JVQavIsvISgi5K7iBULBfjYVNWtwngmsGJWCowqq?=
 =?us-ascii?Q?2gBmDRqSp89ocenZMiqkBg/fpF5M8A2euPaqgVzCC0H5k9/Srk1VVTxK5YyR?=
 =?us-ascii?Q?TbnIxEGtbX3kiJeADkX6l7j9KpEHWWYDdOQ1A+ztNAoXU80qeLAu5FatfuQ0?=
 =?us-ascii?Q?Mxah3Gvoh1WeUgOHo3hp7rbwBtYsd1+yA92LupRlqxxGchRhAAJuUkYvtukC?=
 =?us-ascii?Q?9hYzaq1VqQOJgUMVaCqu/gGN4dgnBvQrFdLKnVTpCtImzxkxC+lli6dYw31k?=
 =?us-ascii?Q?MUdMcFhM9qYPOTDw1J6Lr/yM+sfGUhl1rN3AqdtGrPU2a1IxvSwU+OYq1wwO?=
 =?us-ascii?Q?HZfIPnXeihc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 07:55:06.1844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd709f8-d282-4f4f-6117-08dcbdc8be45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7767
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

From: Trigger Huang <Trigger.Huang@amd.com>

Do the dev core dump if gpu_coredump is enabled

Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 482db4ebcc4b..9885d0606b0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5340,7 +5340,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 			}
 		}
 
-		if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
+		if (amdgpu_gpu_coredump && (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags))) {
 			dev_info(tmp_adev->dev, "Dumping IP State\n");
 			/* Trigger ip dump before we reset the asic */
 			for (i = 0; i < tmp_adev->num_ip_blocks; i++)
@@ -5444,7 +5444,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 
 				vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
 
-				if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags))
+				if (amdgpu_gpu_coredump && (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)))
 					amdgpu_coredump(tmp_adev, vram_lost, reset_context);
 
 				if (vram_lost) {
-- 
2.34.1

