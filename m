Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CBDC43638
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 20:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2975A10F708;
	Fri, 26 Jun 2026 20:41:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PZICHDcq";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBD2610E3F2
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 20:41:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OiPdei+455jrS32f7cMn/vSbg6F3+kwFDFQ6QSE4wiGMDHL6YMjWcfUCiyNxgqWp27UYFpDqTQkdpe3jcVngNha3m60iXvq/vLwdMgt7z2EKDoWahFhCTD5QzGQwslRrK0FMLkuMsoI64WicTqKG0ghvLRsoHnga9curgpYQmSLiQrw8EuwlbpLG+j4Fc8Hf5XDehnuVxFtXO8tzuTbAaOGj+VBFFYr40VxV1Z+1kNO3IBWM1Fm+zHQKwL0XYvkusWpG2BqPOGA5hBtDogla1TocuXNhlI5U+QgRykHaPS0bV5mSKW65PHBYAcV4zIPfWfPmUaR4l5TaQhi0dr8a0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glCoZh8eshZHreQYFgaqljEVPU2ikcwJCE9LiHdRl1s=;
 b=oIiyuqyEh5bM5TZd+P25kt7/NI3bvozb4Goot6YfRX+Ws/krIcil6/CR0kkBVn/wu2boX5mtYRB1KJ3q+DAQJ/BcQlXqZ7MR2iCJF79Jt7EHH/n7aQd+rqb8biQ3eSMbSv6zAYK3ccPWsegN3OGyvxvoNBAfa3GZfs9LUUM1LQfm7JZmC1gIm7mvczuyyeTIP6AK3ra4eBllDGvkHY21ToM/huASYys8JZmD1kMg9afg/6UUCrTiQMuFD+1YvTn459kRYpdD7HrMfoIuDo7r2Uq3GjQc0i6om2abZWy5fe6X6fUau4qOhUHpqajO12KThEvpy0CE9oAOFJtt5C0IPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glCoZh8eshZHreQYFgaqljEVPU2ikcwJCE9LiHdRl1s=;
 b=PZICHDcq8hDelPGFztHNhFbYQ0kEY3fdo41lk+2OBrKl0xA9tubjQ4OUHzKgSgsS4t0hP/oxYlVvNBmtYVcHyfn6FQR2OReO20PZg5RU8v/HIQflqNP3XwX0UuRXeHekNTf6fzvfCT4bb94fQVMJGgIpnhZZv2jgZZuVeXp29Do=
Received: from CH0P221CA0036.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::14)
 by DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 20:41:13 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::41) by CH0P221CA0036.outlook.office365.com
 (2603:10b6:610:11d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.18 via Frontend Transport; Fri,
 26 Jun 2026 20:41:13 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 26 Jun 2026 20:41:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 15:41:08 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 26 Jun 2026 15:41:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/gfx10: Program DB_RING_CONTROL
Date: Fri, 26 Jun 2026 16:40:58 -0400
Message-ID: <20260626204101.31172-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: a18658af-8005-42ef-1ceb-08ded3c34277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|3023799007|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: uv4qwpWNeAS4mPVowGkt8F1+8JrK6fSlgCKUInunt56MxWhcsPmkkKyHVrgGrFgePQdHBAoeoyNZRtGSHV3lnIJhRjJ455U5W/hS2k3uVWz9b5ByL+8NM4QwUdR8weHxMHGYtWrergG6LO4GRS4iYnq1ZhWEKWyKFlSgGXS3ALfS9vuUt0hxRtZ6mgW37Z2fYHu6PxcZTNPBSSeriDDKONinrEEmPP6bueMWhmTfEZZNFnCyUwt+4pgOhIBVk/3TtR8PdPA1TgDVwNuJvJGhLmjr4GzQZIjDyavSF+x17Km8036b8tB64z8BL1zn/fodgxhWuHr6F/6pjAci1zSkLKco4GBt9upJ1WbAAuYBuK0POEfAAHV9/1STHDXK8/AJWNFF3ZHB6tVMwu2A0SBVDsXHi5DQhxWARghxgBmZLpppQjTjrJk408oGnNQP8fAUSdJxd+t9QEonP+gB9CbtVF5+NmuVIAdntSYW3acl5/q8lt8uKcwZnhqRc000wZkCM+/XDjmXY/weIGi/n00jL1BWkmOQdBWY029XDCjulK2kO7RdAhuGYkkSCfykC29VvVsq4VdOLFw1WNVgoippfvm9UlAlPVcpgULXgOWsX4DkeISTyXU5NjSQyQAwUtrwXxspHtXUrL6DNT/95VK63L1hi15h0G/tppBCB512axbp3nauf9G0EHqUuupW4qLqORH9GEFR+qJJInSuDZlzmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(3023799007)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vR3VMzDSPLoU8Y72w8u3g3Iz9bOV/K2BI52PF3yzqQ1pJAxih2ok5+ShUgFfI21Bi8bKl9Pykoxg6EMUZrXiEm7BOe7fVPFj1ihTPijEez+6TOf5IdbeORCGeX6g8SLm5M5vpDLcatlrwGKmd5ogQuhSqOI9+iZ+H1X+HxkHCx/Uekd90yBTjLgEAq9/Fv3iv0BBkMLTRIOH2GFpQnQd0UwPrRbYOKCw7SuRYIj4jhxgm4OJu3v+aL1sAuv+eSlAD6DtTlERgU4/8OapqD/3dl+iQguHxC1gRBg6VZSYOmGI/5i9sJw1EEGqUV6zHlBfrNL0Qh5yZL1btJSbskHVCoBJpSzKzGIZuq2T75RalURBdvgYLD94RwTehasTzrtIQ5ylBmRxXnKqcQS3shg4SssTSBuSnkxkwIBkM97Dz0JeMvmA89JtpLbbgsyG42bE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 20:41:11.9814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a18658af-8005-42ef-1ceb-08ded3c34277
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995
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

This is needed to allocate occlusion counters across
both gfx pipes.

Fixes: b7a1a0ef12b8 ("drm/amd/amdgpu: add pipe1 hardware support")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d72ecf5dab09e..6ff7a8a700939 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5352,6 +5352,9 @@ static void gfx_v10_0_constants_init(struct amdgpu_device *adev)
 	gfx_v10_0_get_tcc_info(adev);
 	adev->gfx.config.pa_sc_tile_steering_override =
 		gfx_v10_0_init_pa_sc_tile_steering_override(adev);
+	/* program DB_RING_CONTROL for multiple GFX pipes */
+	WREG32_FIELD15(GC, 0, DB_RING_CONTROL, COUNTER_CONTROL,
+		       (adev->gfx.me.num_pipe_per_me > 1) ? 0 : 1);
 
 	/* XXX SH_MEM regs */
 	/* where to put LDS, scratch, GPUVM in FSA64 space */
-- 
2.54.0

